const express = require('express');
require('dotenv').config();
const { createClient } = require('@supabase/supabase-js');
const bodyParser = require('body-parser');
const cors = require('cors');
const path = require('path');
const { Resend } = require('resend');

const app = express();
const PORT = process.env.PORT || 3000;

// Serve static files from public directory (for local development)
// Serve static files from public directory (for local development)
app.use(express.static(path.join(__dirname, 'public')));
// Data is now served from public/data via the static middleware above


// Supabase Configuration
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_KEY;

let supabase;
if (supabaseUrl && supabaseKey) {
    supabase = createClient(supabaseUrl, supabaseKey);
} else {
    console.error('CRITICAL: Supabase credentials missing. Ensure SUPABASE_URL and SUPABASE_KEY are set in Environment Variables.');
}

// Middleware to ensure Supabase is configured
const checkConfig = (req, res, next) => {
    if (!supabase) {
        return res.status(500).json({
            error: 'Server configuration error: Supabase credentials missing.',
            details: 'Please set SUPABASE_URL and SUPABASE_KEY in Vercel Project Settings.'
        });
    }
    next();
};

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Global Debug Logger
app.use((req, res, next) => {
    console.log(`${new Date().toISOString()} - ${req.method} ${req.url}`);
    next();
});

// Test Endpoint
app.get('/api/hello', (req, res) => {
    res.json({ message: 'API is working' });
});
// Static files handled by Vercel in production, only needed for local dev
if (require.main === module) {
    // Fallback for SPA or root access in local dev
    app.get('/', (req, res) => {
        res.sendFile(path.join(__dirname, 'public', 'index.html'));
    });
}

// Apply config check to all API routes
app.use('/api', checkConfig);

// --- AUTH API ---

// 1. Check Email
app.get('/api/auth/check/:email', async (req, res) => {
    const { email } = req.params;
    const { data, error } = await supabase
        .from('users')
        .select('*')
        .eq('email', email)
        .single();

    if (error && error.code !== 'PGRST116') { // PGRST116 is "no rows found"
        return res.status(500).json({ error: error.message });
    }

    res.json({
        exists: !!data,
        user: data ? { id: data.user_id, email: data.email, username: data.username } : null
    });
});

// 2. Signup
app.post('/api/auth/signup', async (req, res) => {
    const { email, password, username } = req.body;
    const userId = 'user_' + Date.now();
    const role = 'user';

    const { data, error } = await supabase
        .from('users')
        .insert([{ user_id: userId, email, username, password_hash: password, role }])
        .select()
        .single();

    if (error) return res.status(500).json({ error: 'Email already exists or database error' });
    res.json({ id: data.user_id, email: data.email, username: data.username, role: data.role });
});

// 3. Login
app.post('/api/auth/login', async (req, res) => {
    const { email, password } = req.body;
    const { data, error } = await supabase
        .from('users')
        .select('*')
        .eq('email', email)
        .eq('password_hash', password)
        .single();

    if (error || !data) {
        return res.status(error ? 500 : 401).json({ error: error ? error.message : 'Invalid email or password' });
    }
    res.json({ id: data.user_id, email: data.email, username: data.username, role: data.role });
});

// --- ADMIN MIDDLEWARE ---
const isAdmin = async (req, res, next) => {
    const adminEmail = req.headers['x-admin-email'];
    if (!adminEmail) return res.status(401).json({ error: 'Unauthorized' });

    const { data, error } = await supabase
        .from('users')
        .select('role')
        .eq('email', adminEmail)
        .single();

    if (error || !data || data.role !== 'admin') {
        if (error) {
            console.error('Supabase Admin Check Error:', error); // Added console.error
            return res.status(500).json({ error: error.message }); // Return specific error
        }
        return res.status(403).json({ error: 'Admin access required' });
    }
    next();
};

// --- PERFORMANCE API ---

// 4. Save Attempt
app.post('/api/attempts', async (req, res) => {
    const a = req.body;
    const attemptId = 'att_' + Date.now();
    const userId = a.user_id || 'guest';

    // Ensure User exists in Supabase (handle local migration or guest)
    const { data: userExists, error: userError } = await supabase
        .from('users')
        .select('user_id')
        .eq('user_id', userId)
        .single();

    if (userError && userError.code === 'PGRST116') {
        // User not found in Supabase -> Create placeholder
        console.log(`Auto-creating user record for: ${userId}`);
        await supabase
            .from('users')
            .insert([{
                user_id: userId,
                email: userId + '@local.dev',
                username: userId,
                password_hash: 'migrated',
                role: 'user'
            }]);
    }

    const { data, error } = await supabase
        .from('test_attempts')
        .insert([{
            attempt_id: attemptId,
            user_id: userId,
            test_id: a.test_id,
            test_type: a.test_type,
            subject: a.subject,
            year: a.year,
            session: a.session,
            total_questions: a.total_questions,
            attempted: a.attempted,
            correct: a.correct,
            wrong: a.incorrect || a.wrong || 0,
            unattempted: a.unattempted,
            score: a.score,
            max_score: a.max_score,
            accuracy: a.accuracy,
            time_taken: a.time_taken,
            detailed_results: a.detailedResults
        }])
        .select()
        .single();

    if (error) {
        console.error('Supabase Insert Error:', error);
        return res.status(500).json({ error: error.message });
    }

    // Return with 'id' so result.html can use it immediately
    res.json({ id: attemptId, ...a });
});

// Helper to map DB row to frontend format
function mapAttempt(a) {
    return {
        ...a,
        id: a.attempt_id,
        detailedResults: a.detailed_results,
        incorrect: a.wrong
    };
}

// 5. Get Attempts by User
app.get('/api/attempts/user/:userId', async (req, res) => {
    const { data, error } = await supabase
        .from('test_attempts')
        .select('*')
        .eq('user_id', req.params.userId)
        .order('submitted_at', { ascending: false });

    if (error) return res.status(500).json({ error: error.message });
    res.json(data.map(mapAttempt));
});

app.get('/api/attempts/id/:attemptId', async (req, res) => {
    const { data, error } = await supabase
        .from('test_attempts')
        .select('*')
        .eq('attempt_id', req.params.attemptId)
        .single();

    if (error || !data) {
        return res.status(error ? 500 : 404).json({ error: error ? error.message : 'Not found' });
    }
    res.json(mapAttempt(data));
});

// --- ADMIN API ---

// 7. Get All Users with Stats
app.get('/api/admin/users', isAdmin, async (req, res) => {
    // Note: Complex aggregations like in SQL are harder with simple Supabase JS client 
    // without using RPC. For now, we'll use a slightly simplified fetch or the user can add an RPC function.
    // However, we can use raw SQL via RPC in Supabase if needed.

    // For this migration, we'll use a stored procedure call if possible, or just a flat list for now.
    const { data, error } = await supabase
        .from('users')
        .select(`
            user_id, email, username, created_at,
            test_attempts (
                attempt_id, test_type, score, accuracy, submitted_at
            )
        `)
        .order('created_at', { ascending: false });

    if (error) return res.status(500).json({ error: error.message });

    // Format stats manually to match previous API response
    const usersWithStats = data.map(u => {
        const attempts = u.test_attempts || [];
        return {
            user_id: u.user_id,
            email: u.email,
            username: u.username,
            created_at: u.created_at,
            total_attempts: attempts.length,
            pyqs_attempted: attempts.filter(a => a.test_type === 'PYQ').length,
            mocks_attempted: attempts.filter(a => a.test_type === 'Mock').length,
            avg_score: attempts.length ? (attempts.reduce((sum, a) => sum + parseFloat(a.score), 0) / attempts.length) : 0,
            avg_accuracy: attempts.length ? (attempts.reduce((sum, a) => sum + parseFloat(a.accuracy), 0) / attempts.length) : 0,
            last_attempt_date: attempts.length ? attempts[0].submitted_at : null
        };
    });

    res.json(usersWithStats);
});

// 8. Get User History
app.get('/api/admin/user/:userId/attempts', isAdmin, async (req, res) => {
    const { data, error } = await supabase
        .from('test_attempts')
        .select('*')
        .eq('user_id', req.params.userId)
        .order('submitted_at', { ascending: false });

    if (error) return res.status(500).json({ error: error.message });
    res.json(data.map(mapAttempt));
});

// --- TEST MANAGEMENT API (ADMIN ONLY) ---

// 9. Get All Tests for Management
app.get('/api/admin/tests', isAdmin, async (req, res) => {
    console.log('GET /api/admin/tests - Admin Email:', req.headers['x-admin-email']);
    const { data, error } = await supabase
        .from('test_registry')
        .select('*')
        .order('category', { ascending: true })
        .order('year', { ascending: false })
        .order('created_at', { ascending: true });

    if (error) return res.status(500).json({ error: error.message });
    res.json(data);
});

// 10. Update Test Status
app.patch('/api/admin/tests/:testId/status', isAdmin, async (req, res) => {
    const { testId } = req.params;
    const { status } = req.body;

    if (!['active', 'coming_soon'].includes(status)) {
        return res.status(400).json({ error: 'Invalid status' });
    }

    const { data, error } = await supabase
        .from('test_registry')
        .update({ status })
        .eq('test_id', testId)
        .select()
        .single();

    if (error) return res.status(500).json({ error: error.message });
    res.json(data);
});

// 11. Public: Get All Tests (No Auth needed for read)
app.get('/api/tests', async (req, res) => {
    const { data, error } = await supabase
        .from('test_registry')
        .select('*')
        .order('category', { ascending: true });

    if (error) return res.status(500).json({ error: error.message });
    res.json(data);
});

// 12. Send Feedback Email
app.post('/api/feedback', async (req, res) => {
    const { user_id, test_id, rating, comments, follow_up } = req.body;
    const resendApiKey = process.env.RESEND_API_KEY;
    const recipientEmail = process.env.FEEDBACK_RECIPIENT_EMAIL;

    if (!resendApiKey || !recipientEmail) {
        console.error('Email configuration missing');
        return res.status(500).json({ error: 'Server handles email incorrectly. Check RESEND_API_KEY and FEEDBACK_RECIPIENT_EMAIL.' });
    }

    const resend = new Resend(resendApiKey);

    try {
        const { data, error } = await resend.emails.send({
            from: 'Feedback <onboarding@resend.dev>',
            to: [recipientEmail],
            subject: `New Test Feedback - ID: ${test_id}`,
            html: `
                <h2>New Feedback Received</h2>
                <p><strong>User ID:</strong> ${user_id}</p>
                <p><strong>Test ID:</strong> ${test_id}</p>
                <p><strong>Rating:</strong> ${rating}</p>
                <p><strong>Comments:</strong> ${comments || 'No comments provided'}</p>
                <p><strong>Allow Follow-up:</strong> ${follow_up ? 'Yes' : 'No'}</p>
            `
        });

        if (error) {
            console.error('Resend Error:', error);
            return res.status(500).json({ error: error.message });
        }

        res.json({ success: true, data });
    } catch (err) {
        console.error('Internal Server Error:', err);
        res.status(500).json({ error: err.message });
    }
});

// Export the app for Vercel
app.get('/api', (req, res) => res.json({ status: 'NDA Prep API Online' }));

// 404 Catch-all for /api
app.use('/api/*', (req, res) => {
    console.log(`404 NOT FOUND: ${req.method} ${req.url}`);
    res.status(404).json({ error: `Path ${req.url} not found on this server.` });
});

module.exports = app;

if (require.main === module) {
    app.listen(PORT, () => {
        console.log(`Server running at http://localhost:${PORT}`);
        console.log(`Serving data from: ${path.join(__dirname, 'data')}`);
    });
}
