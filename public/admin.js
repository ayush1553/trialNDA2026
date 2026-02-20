// Admin Dashboard Logic
document.addEventListener('DOMContentLoaded', () => {
    checkAdminAccess();
    loadUsers();
});

const SESSION_KEY = 'nda_platform_session';
const adminUser = JSON.parse(localStorage.getItem(SESSION_KEY));

function checkAdminAccess() {
    console.log('Checking admin access...', adminUser);
    if (!adminUser || adminUser.role !== 'admin') {
        alert('Access Denied: Admin privileges required.');
        window.location.href = 'login.html';
        return;
    }
    const emailElem = document.getElementById('admin-email');
    if (emailElem) emailElem.textContent = adminUser.email || 'Admin';
}

async function loadUsers() {
    try {
        const response = await fetch('/api/admin/users', {
            headers: {
                'x-admin-email': adminUser.email
            }
        });

        if (!response.ok) throw new Error('Failed to fetch data');

        const users = await response.json();
        renderUsers(users);
        updateSummary(users);
    } catch (err) {
        console.error(err);
        document.getElementById('users-table-body').innerHTML = `<tr><td colspan="8" class="empty-state">Error loading users data.</td></tr>`;
    }
}

function renderUsers(users) {
    const tbody = document.getElementById('users-table-body');
    if (users.length === 0) {
        tbody.innerHTML = `<tr><td colspan="8" class="empty-state">No users registered yet.</td></tr>`;
        return;
    }

    tbody.innerHTML = users.map(u => `
        <tr>
            <td>${u.email}</td>
            <td>${new Date(u.created_at).toLocaleDateString()}</td>
            <td>${u.total_attempts || 0}</td>
            <td>${u.pyqs_attempted || 0} / ${u.mocks_attempted || 0}</td>
            <td>${u.avg_score ? u.avg_score.toFixed(1) : '0.0'}%</td>
            <td>${u.avg_accuracy ? u.avg_accuracy.toFixed(1) : '0.0'}%</td>
            <td>${u.last_attempt_date ? new Date(u.last_attempt_date).toLocaleDateString() : 'Never'}</td>
            <td><button class="btn-view" onclick="viewUserDetail('${u.user_id}', '${u.email}')">View Details</button></td>
        </tr>
    `).join('');
}

function updateSummary(users) {
    document.getElementById('total-users-count').textContent = users.length;
    const totalAttempts = users.reduce((sum, u) => sum + (u.total_attempts || 0), 0);
    document.getElementById('total-attempts-all').textContent = totalAttempts;

    // Simple mock for "Active Today" - check last_attempt_date
    const today = new Date().toLocaleDateString();
    const activeToday = users.filter(u => u.last_attempt_date && new Date(u.last_attempt_date).toLocaleDateString() === today).length;
    document.getElementById('active-today').textContent = activeToday;
}

async function viewUserDetail(userId, email) {
    document.getElementById('detail-user-email').textContent = `Test History for ${email}`;
    const modal = document.getElementById('user-detail-modal');
    modal.style.display = 'flex';

    try {
        const response = await fetch(`/api/admin/user/${userId}/attempts`, {
            headers: {
                'x-admin-email': adminUser.email
            }
        });

        if (!response.ok) throw new Error('Failed to fetch history');

        const attempts = await response.json();
        renderHistory(attempts);
    } catch (err) {
        console.error(err);
        document.getElementById('history-table-body').innerHTML = `<tr><td colspan="8" class="empty-state">Error loading history.</td></tr>`;
    }
}

function renderHistory(attempts) {
    const tbody = document.getElementById('history-table-body');
    if (attempts.length === 0) {
        tbody.innerHTML = `<tr><td colspan="8" class="empty-state">No attempts yet.</td></tr>`;
        return;
    }

    tbody.innerHTML = attempts.map(a => `
        <tr>
            <td>${new Date(a.submitted_at).toLocaleDateString()} ${new Date(a.submitted_at).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}</td>
            <td>${a.test_id}</td>
            <td>${a.test_type}</td>
            <td>${a.subject || '-'}</td>
            <td>${a.score} / ${a.max_score}</td>
            <td>${a.accuracy}%</td>
            <td>${formatTime(a.time_taken)}</td>
            <td><button class="btn-view" style="background:#27ae60" onclick="viewAttemptReview('${a.attempt_id}')">Review</button></td>
        </tr>
    `).join('');
}

function formatTime(seconds) {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}m ${secs}s`;
}

async function viewAttemptReview(attemptId) {
    try {
        const response = await fetch(`/api/attempts/id/${attemptId}`);
        if (!response.ok) throw new Error('Failed to fetch attempt details');

        const attempt = await response.json();

        // Save to localStorage so result.html can display it
        localStorage.setItem('ndaExamResult', JSON.stringify(attempt));
        window.open('result.html', '_blank');
    } catch (err) {
        console.error(err);
        alert('Error loading test attempt review.');
    }
}

function closeModal() {
    document.getElementById('user-detail-modal').style.display = 'none';
}

// Close modal on outside click
window.onclick = (event) => {
    const modal = document.getElementById('user-detail-modal');
    if (event.target == modal) closeModal();
};

function switchSection(sectionId, element) {
    // Update Sidebar
    document.querySelectorAll('.nav-item').forEach(item => item.classList.remove('active'));
    element.classList.add('active');

    // Update Content
    document.querySelectorAll('.content-section').forEach(sec => sec.classList.remove('active'));
    document.getElementById(`section-${sectionId}`).classList.add('active');

    if (sectionId === 'portal') {
        loadTestsPortal();
    }
}

async function loadTestsPortal() {
    try {
        console.log('Fetching tests for portal... Email:', adminUser ? adminUser.email : 'null');
        const response = await fetch('/api/admin/tests', {
            headers: {
                'x-admin-email': adminUser ? adminUser.email : ''
            }
        });

        if (!response.ok) {
            const errBody = await response.json().catch(() => ({}));
            console.error('API Error Response:', response.status, errBody);
            return;
        }

        const tests = await response.json();
        console.log('Received tests for portal:', tests);

        if (!Array.isArray(tests)) {
            console.error('Expected array of tests, got:', tests);
            return;
        }

        renderPortal(tests);
    } catch (error) {
        console.error('Error loading tests portal:', error);
    }
}

function renderPortal(tests) {
    const containers = {
        'Mock': document.getElementById('admin-mock-list'),
        'PYQ': document.getElementById('admin-pyq-list'),
        'Chapter': document.getElementById('admin-chapter-list'),
        'CA': document.getElementById('admin-ca-list')
    };

    // Define Sorting Priorities
    const subjectPriority = {
        'Mathematics': 1, 'MAT': 1,
        'Chemistry': 2,
        'Physics': 3,
        'History': 4,
        'Polity': 5,
        'Economy': 6,
        'Geography': 7,
        'English': 8, 'GAT': 8,
        'Art & Culture': 9,
        'General Science': 10,
        'Static GK': 11
    };

    // Sort tests helper
    const sortedTests = [...tests].sort((a, b) => {
        // First by category priority (if they were mixed, but we group them anyway)
        // Within the same category:

        // 1. Sort by sub_category/subject priority
        const pA = subjectPriority[a.sub_category] || 99;
        const pB = subjectPriority[b.sub_category] || 99;
        if (pA !== pB) return pA - pB;

        // 2. Sort by Year (Descending)
        if (a.year !== b.year) return (parseInt(b.year) || 0) - (parseInt(a.year) || 0);

        // 3. Sort by Title/ID
        return a.title.localeCompare(b.title);
    });

    // Clear lists
    Object.values(containers).forEach(c => {
        if (c) c.innerHTML = '';
    });

    const counts = { 'Mock': 0, 'PYQ': 0, 'Chapter': 0, 'CA': 0 };

    sortedTests.forEach(test => {
        const container = containers[test.category];
        if (!container) return;

        counts[test.category]++;
        const isActive = test.status === 'active';

        const item = document.createElement('div');
        item.className = `test-item ${isActive ? 'active-test' : 'coming-test'}`;
        item.innerHTML = `
            <div class="test-info">
                <div class="test-title">${test.title}</div>
                <div class="test-sub">${test.sub_category || ''} ${test.year ? '| ' + test.year : ''}</div>
            </div>
            <label class="switch">
                <input type="checkbox" ${isActive ? 'checked' : ''} onchange="toggleTestStatus('${test.test_id}', this)">
                <span class="slider"></span>
            </label>
        `;
        container.appendChild(item);
    });

    // Check for empty columns and show fallback
    Object.keys(containers).forEach(cat => {
        const container = containers[cat];
        if (container && counts[cat] === 0) {
            container.innerHTML = `<p class="test-sub" style="text-align:center; padding:20px;">No tests found for ${cat}.</p>`;
        }
    });

    // Update counts
    if (document.getElementById('mock-count-admin')) document.getElementById('mock-count-admin').textContent = `(${counts['Mock']})`;
    if (document.getElementById('pyq-count-admin')) document.getElementById('pyq-count-admin').textContent = `(${counts['PYQ']})`;
    if (document.getElementById('chapter-count-admin')) document.getElementById('chapter-count-admin').textContent = `(${counts['Chapter']})`;
    if (document.getElementById('ca-count-admin')) document.getElementById('ca-count-admin').textContent = `(${counts['CA']})`;
}

async function toggleTestStatus(testId, checkbox) {
    const newStatus = checkbox.checked ? 'active' : 'coming_soon';

    try {
        const response = await fetch(`/api/admin/tests/${testId}/status`, {
            method: 'PATCH',
            headers: {
                'Content-Type': 'application/json',
                'x-admin-email': adminUser.email
            },
            body: JSON.stringify({ status: newStatus })
        });

        if (!response.ok) {
            alert('Failed to update status');
            checkbox.checked = !checkbox.checked; // Revert UI
        } else {
            // Update item styling
            const item = checkbox.closest('.test-item');
            item.className = `test-item ${checkbox.checked ? 'active-test' : 'coming-test'}`;
        }
    } catch (error) {
        console.error('Error toggling status:', error);
        checkbox.checked = !checkbox.checked;
    }
}
