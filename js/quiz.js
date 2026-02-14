/**
 * Virtual India - Quiz JavaScript
 * Quiz functionality and scoring
 */

class QuizManager {
    constructor() {
        this.questions = [];
        this.currentIndex = 0;
        this.score = 0;
        this.selectedAnswer = null;
        this.answered = false;
        this.container = document.querySelector('.quiz-container');
    }

    async init() {
        if (!this.container) return;

        this.showLoading();

        try {
            const response = await fetchQuizQuestions(10);
            if (response.success && response.data.length > 0) {
                this.questions = response.data;
                this.renderQuestion();
            } else {
                this.showError('Could not load quiz questions');
            }
        } catch (error) {
            console.error('Quiz init error:', error);
            this.showError('Failed to load quiz');
        }
    }

    showLoading() {
        this.container.innerHTML = `
            <div class="loading">
                <div class="loading-spinner"></div>
            </div>
        `;
    }

    showError(message) {
        this.container.innerHTML = `
            <div class="empty-state">
                <div class="empty-state-icon">⚠️</div>
                <h3 class="empty-state-title">${t('common.error')}</h3>
                <p class="empty-state-text">${message}</p>
                <button class="btn btn-primary" onclick="location.reload()">
                    ${t('quiz.tryAgain')}
                </button>
            </div>
        `;
    }

    renderQuestion() {
        const question = this.questions[this.currentIndex];
        const progress = ((this.currentIndex) / this.questions.length) * 100;

        this.container.innerHTML = `
            <div class="quiz-progress">
                <div class="quiz-progress-bar">
                    <div class="quiz-progress-fill" style="width: ${progress}%"></div>
                </div>
                <span class="quiz-progress-text">
                    ${t('quiz.question')} ${this.currentIndex + 1} ${t('quiz.of')} ${this.questions.length}
                </span>
            </div>
            
            <div class="quiz-question-card">
                <h2 class="quiz-question">${question.question}</h2>
                
                <div class="quiz-options">
                    ${this.renderOptions(question)}
                </div>
                
                <div class="quiz-actions">
                    <button class="btn btn-secondary" onclick="quiz.skipQuestion()">
                        Skip
                    </button>
                    <button class="btn btn-primary" id="nextBtn" disabled onclick="quiz.submitAnswer()">
                        ${this.currentIndex < this.questions.length - 1 ? t('quiz.nextQuestion') : t('quiz.submitAnswer')}
                    </button>
                </div>
            </div>
            
            <div class="quiz-score-display" style="text-align: center; margin-top: var(--space-6);">
                <span style="color: var(--saffron); font-weight: 600;">
                    ${t('quiz.score')}: ${this.score}/${this.currentIndex}
                </span>
            </div>
        `;

        this.attachOptionListeners();
    }

    renderOptions(question) {
        const options = ['A', 'B', 'C', 'D'];
        return options.map(key => `
            <div class="quiz-option" data-option="${key}">
                <span class="quiz-option-key">${key}</span>
                <span class="quiz-option-text">${question.options[key]}</span>
            </div>
        `).join('');
    }

    attachOptionListeners() {
        const options = this.container.querySelectorAll('.quiz-option');
        const nextBtn = this.container.querySelector('#nextBtn');

        options.forEach(option => {
            option.addEventListener('click', () => {
                if (this.answered) return;

                // Remove previous selection
                options.forEach(o => o.classList.remove('selected'));

                // Select current
                option.classList.add('selected');
                this.selectedAnswer = option.dataset.option;

                // Enable next button
                nextBtn.disabled = false;
            });
        });
    }

    submitAnswer() {
        if (this.selectedAnswer === null || this.answered) return;

        this.answered = true;
        const question = this.questions[this.currentIndex];
        const options = this.container.querySelectorAll('.quiz-option');
        const selectedOption = this.container.querySelector(`.quiz-option[data-option="${this.selectedAnswer}"]`);
        const correctOption = this.container.querySelector(`.quiz-option[data-option="${question.correct}"]`);

        // Show correct/wrong
        if (this.selectedAnswer === question.correct) {
            this.score++;
            selectedOption.classList.add('correct');
            showToast(t('quiz.correct'), 'success');
        } else {
            selectedOption.classList.add('wrong');
            correctOption.classList.add('correct');
            showToast(t('quiz.wrong'), 'error');
        }

        // Disable all options
        options.forEach(o => o.style.pointerEvents = 'none');

        // Auto-advance after delay
        setTimeout(() => {
            this.nextQuestion();
        }, 1500);
    }

    skipQuestion() {
        this.nextQuestion();
    }

    nextQuestion() {
        this.currentIndex++;
        this.selectedAnswer = null;
        this.answered = false;

        if (this.currentIndex < this.questions.length) {
            this.renderQuestion();
        } else {
            this.showResults();
        }
    }

    async showResults() {
        const percentage = Math.round((this.score / this.questions.length) * 100);

        // Get feedback from server
        let feedback = '';
        try {
            const user = getUser();
            const response = await submitQuizScore(this.score, this.questions.length, user?.id);
            if (response.success) {
                const lang = getCurrentLanguage();
                feedback = lang === 'hi' ? response.feedback_hi : response.feedback;
            }
        } catch (error) {
            console.error('Score submit error:', error);
        }

        // Determine grade emoji
        let emoji = '';
        if (percentage >= 80) emoji = '🏆';
        else if (percentage >= 60) emoji = '🌟';
        else if (percentage >= 40) emoji = '👍';
        else emoji = '📚';

        this.container.innerHTML = `
            <div class="quiz-question-card quiz-result">
                <div style="font-size: 4rem; margin-bottom: var(--space-4);">${emoji}</div>
                <h2 class="quiz-score">${this.score}/${this.questions.length}</h2>
                <p style="font-size: var(--text-xl); color: var(--text-muted); margin-bottom: var(--space-2);">
                    ${percentage}%
                </p>
                <p class="quiz-feedback">${feedback}</p>
                
                <div style="display: flex; gap: var(--space-4); justify-content: center; flex-wrap: wrap;">
                    <button class="btn btn-primary btn-lg" onclick="quiz.restart()">
                        ${t('quiz.tryAgain')}
                    </button>
                    <a href="/pratiksha06/index.html" class="btn btn-secondary btn-lg">
                        ${t('common.home')}
                    </a>
                </div>
            </div>
        `;
    }

    restart() {
        this.currentIndex = 0;
        this.score = 0;
        this.selectedAnswer = null;
        this.answered = false;
        this.init();
    }
}

// Initialize quiz
let quiz;
document.addEventListener('DOMContentLoaded', () => {
    if (document.querySelector('.quiz-container')) {
        quiz = new QuizManager();
        quiz.init();
    }
});
