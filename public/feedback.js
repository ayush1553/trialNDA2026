/**
 * Feedback Form Logic
 */

const Feedback = {
    rating: 'Smile', // Default
    init() {
        this.bindEvents();
    },

    bindEvents() {
        const ratingIcons = document.querySelectorAll('.feedback-rating i');
        ratingIcons.forEach(icon => {
            icon.addEventListener('click', (e) => {
                ratingIcons.forEach(i => i.classList.remove('active'));
                icon.classList.add('active');
                this.rating = icon.getAttribute('title') || icon.className;
            });
        });

        const closeBtn = document.querySelector('.feedback-close-btn');
        const cancelBtn = document.querySelector('.feedback-btn-secondary');
        const sendBtn = document.querySelector('.feedback-btn-primary');

        if (closeBtn) closeBtn.onclick = () => this.hide();
        if (cancelBtn) cancelBtn.onclick = () => this.hide();

        if (sendBtn) {
            sendBtn.onclick = async () => {
                await this.send();
            };
        }
    },

    show() {
        const overlay = document.querySelector('.feedback-modal-overlay');
        if (overlay) overlay.style.display = 'flex';

        // Don't show again in this session
        sessionStorage.setItem('feedbackShown', 'true');
    },

    hide() {
        const overlay = document.querySelector('.feedback-modal-overlay');
        if (overlay) overlay.style.display = 'none';
    },

    async send() {
        const btn = document.querySelector('.feedback-btn-primary');
        const comments = document.querySelector('.feedback-glass-container textarea').value;
        const followUp = document.querySelector('input[name="feedback-follow"]:checked').value === 'yes';

        const testResult = JSON.parse(localStorage.getItem('ndaExamResult'));
        const user = window.Auth ? window.Auth.getSession() : null;

        const feedbackData = {
            user_id: user ? user.id : 'guest',
            test_id: testResult ? testResult.test_id : 'unknown',
            rating: this.rating,
            comments: comments,
            follow_up: followUp
        };

        try {
            btn.textContent = 'Sending...';
            btn.disabled = true;

            await window.DB.sendFeedback(feedbackData);

            btn.textContent = 'Sent!';
            setTimeout(() => {
                this.hide();
            }, 1000);
        } catch (err) {
            console.error('Feedback Error:', err);
            alert('Failed to send feedback. Please try again later.');
            btn.textContent = 'Send';
            btn.disabled = false;
        }
    }
};

document.addEventListener('DOMContentLoaded', () => {
    Feedback.init();
});

window.Feedback = Feedback;
