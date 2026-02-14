/**
 * Virtual India - Main JavaScript
 * Core functionality for the platform
 */

// API Base URL
const API_BASE = '/pratiksha06/pratiksha06/api';

// DOM Ready
document.addEventListener('DOMContentLoaded', function () {
    initNavbar();
    initLanguageToggle();
    initMobileMenu();
    initAnimations();
    applyTranslations();
});

// ========== Navigation ==========
function initNavbar() {
    const navbar = document.querySelector('.navbar');

    if (navbar) {
        window.addEventListener('scroll', () => {
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });
    }

    // Active link highlighting
    const currentPath = window.location.pathname;
    document.querySelectorAll('.nav-link').forEach(link => {
        if (link.getAttribute('href') === currentPath ||
            currentPath.includes(link.getAttribute('href'))) {
            link.classList.add('active');
        }
    });
}

// ========== Mobile Menu ==========
function initMobileMenu() {
    const menuBtn = document.querySelector('.mobile-menu-btn');
    const navMenu = document.querySelector('.nav-menu');

    if (menuBtn && navMenu) {
        menuBtn.addEventListener('click', () => {
            navMenu.classList.toggle('active');
            menuBtn.classList.toggle('active');
        });

        // Close on link click
        navMenu.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', () => {
                navMenu.classList.remove('active');
                menuBtn.classList.remove('active');
            });
        });
    }
}

// ========== Language Toggle ==========
function initLanguageToggle() {
    const langBtns = document.querySelectorAll('.lang-btn');
    const currentLang = getCurrentLanguage();

    // Set initial active state
    langBtns.forEach(btn => {
        if (btn.dataset.lang === currentLang) {
            btn.classList.add('active');
        }

        btn.addEventListener('click', () => {
            const lang = btn.dataset.lang;
            setLanguage(lang);

            langBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');

            // Reload page to apply translations
            window.location.reload();
        });
    });

    // Apply hindi class if needed
    if (currentLang === 'hi') {
        document.body.classList.add('hindi');
    }
}

// ========== Apply Translations ==========
function applyTranslations() {
    const lang = getCurrentLanguage();

    document.querySelectorAll('[data-translate]').forEach(el => {
        const key = el.dataset.translate;
        const translation = t(key);
        if (translation && translation !== key) {
            el.textContent = translation;
        }
    });

    document.querySelectorAll('[data-translate-placeholder]').forEach(el => {
        const key = el.dataset.translatePlaceholder;
        const translation = t(key);
        if (translation && translation !== key) {
            el.placeholder = translation;
        }
    });
}

// ========== Animations ==========
function initAnimations() {
    // Intersection Observer for scroll animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-fadeInUp');
                observer.unobserve(entry.target);
            }
        });
    }, observerOptions);

    document.querySelectorAll('.animate-on-scroll').forEach(el => {
        observer.observe(el);
    });
}

// ========== API Helpers ==========
async function apiCall(endpoint, options = {}) {
    const lang = getCurrentLanguage();
    const url = new URL(API_BASE + endpoint, window.location.origin);
    url.searchParams.set('lang', lang);

    if (options.params) {
        Object.entries(options.params).forEach(([key, value]) => {
            url.searchParams.set(key, value);
        });
    }

    try {
        const response = await fetch(url.toString(), {
            method: options.method || 'GET',
            headers: {
                'Content-Type': 'application/json',
                ...options.headers
            },
            body: options.body ? JSON.stringify(options.body) : undefined
        });

        return await response.json();
    } catch (error) {
        console.error('API Error:', error);
        return { success: false, message: 'Network error' };
    }
}

// Fetch regions
async function fetchRegions() {
    return apiCall('/regions.php', { params: { action: 'list' } });
}

// Fetch region detail
async function fetchRegionDetail(id) {
    return apiCall('/regions.php', { params: { action: 'detail', id } });
}

// Fetch cultural items
async function fetchCulturalItems(regionId = null, category = null) {
    const params = { action: 'cultural_items' };
    if (regionId) params.region_id = regionId;
    if (category) params.category = category;
    return apiCall('/regions.php', { params });
}

// Fetch festivals
async function fetchFestivals() {
    return apiCall('/festivals.php', { params: { action: 'list' } });
}

// Fetch festivals by month
async function fetchFestivalsByMonth(month) {
    return apiCall('/festivals.php', { params: { action: 'by_month', month } });
}

// Fetch quiz questions
async function fetchQuizQuestions(limit = 10, category = null) {
    const params = { action: 'questions', limit };
    if (category) params.category = category;
    return apiCall('/quiz.php', { params });
}

// Submit quiz score
async function submitQuizScore(score, total, userId = null) {
    return apiCall('/quiz.php', {
        method: 'POST',
        body: { action: 'submit', score, total, user_id: userId }
    });
}

// Search
async function search(query, type = 'all') {
    return apiCall('/search.php', { params: { q: query, type } });
}

// ========== Auth Helpers ==========
async function login(email, password) {
    return apiCall('/users.php', {
        method: 'POST',
        body: { action: 'login', email, password }
    });
}

async function register(name, email, password) {
    return apiCall('/users.php', {
        method: 'POST',
        body: { action: 'register', name, email, password }
    });
}

async function logout() {
    return apiCall('/users.php', {
        method: 'POST',
        body: { action: 'logout' }
    });
}

async function checkAuthStatus() {
    return apiCall('/users.php', { params: { action: 'status' } });
}

// ========== UI Helpers ==========
function showLoading(container) {
    container.innerHTML = `
        <div class="loading">
            <div class="loading-spinner"></div>
        </div>
    `;
}

function showEmpty(container, icon = '🔍', title = 'No results', text = 'Try adjusting your search') {
    container.innerHTML = `
        <div class="empty-state">
            <div class="empty-state-icon">${icon}</div>
            <h3 class="empty-state-title">${title}</h3>
            <p class="empty-state-text">${text}</p>
        </div>
    `;
}

function showError(container, message = 'An error occurred') {
    container.innerHTML = `
        <div class="empty-state">
            <div class="empty-state-icon">⚠️</div>
            <h3 class="empty-state-title">Error</h3>
            <p class="empty-state-text">${message}</p>
        </div>
    `;
}

// Toast notifications
function showToast(message, type = 'info') {
    const toast = document.createElement('div');
    toast.className = `toast toast-${type}`;
    toast.textContent = message;
    toast.style.cssText = `
        position: fixed;
        bottom: 20px;
        right: 20px;
        padding: 16px 24px;
        background: ${type === 'success' ? 'var(--green-india)' : type === 'error' ? '#EF4444' : 'var(--saffron)'};
        color: white;
        border-radius: var(--radius-lg);
        font-weight: 500;
        z-index: 1000;
        animation: fadeInUp 0.3s ease;
    `;

    document.body.appendChild(toast);

    setTimeout(() => {
        toast.style.animation = 'fadeIn 0.3s ease reverse';
        setTimeout(() => toast.remove(), 300);
    }, 3000);
}

// Month name helper
function getMonthName(monthNum) {
    const lang = getCurrentLanguage();
    return t('months')[monthNum];
}

// Format category name
function formatCategory(category) {
    const lang = getCurrentLanguage();
    const categories = t('gallery.categories');
    return categories[category] || category;
}

// ========== User Session ==========
function getUser() {
    const userData = localStorage.getItem('user');
    return userData ? JSON.parse(userData) : null;
}

function setUser(user) {
    localStorage.setItem('user', JSON.stringify(user));
}

function clearUser() {
    localStorage.removeItem('user');
}

function isLoggedIn() {
    return getUser() !== null;
}

// Update UI based on auth state
async function updateAuthUI() {
    const user = getUser();
    const loginBtn = document.querySelector('.nav-login-btn');
    const signupBtn = document.querySelector('.nav-signup-btn');
    const userMenu = document.querySelector('.nav-user-menu');

    if (user) {
        if (loginBtn) loginBtn.style.display = 'none';
        if (signupBtn) signupBtn.style.display = 'none';
        if (userMenu) {
            userMenu.style.display = 'flex';
            const userName = userMenu.querySelector('.user-name');
            if (userName) userName.textContent = user.name;
        }
    } else {
        if (loginBtn) loginBtn.style.display = 'inline-flex';
        if (signupBtn) signupBtn.style.display = 'inline-flex';
        if (userMenu) userMenu.style.display = 'none';
    }
}

// Check auth on page load
document.addEventListener('DOMContentLoaded', updateAuthUI);

// ========== Smooth Scroll ==========
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth'
            });
        }
    });
});

// ========== Search Handler ==========
function initSearch() {
    const searchForm = document.querySelector('.nav-search');
    const searchInput = searchForm?.querySelector('input');

    if (searchForm && searchInput) {
        searchForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const query = searchInput.value.trim();
            if (query.length >= 2) {
                window.location.href = `/pratiksha06/pages/search.html?q=${encodeURIComponent(query)}`;
            }
        });

        searchInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                e.preventDefault();
                const query = searchInput.value.trim();
                if (query.length >= 2) {
                    window.location.href = `/pratiksha06/pages/search.html?q=${encodeURIComponent(query)}`;
                }
            }
        });
    }
}

document.addEventListener('DOMContentLoaded', initSearch);
