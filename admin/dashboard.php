<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Virtual India</title>
    <link rel="icon" type="image/svg+xml"
        href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>🇮🇳</text></svg>">
    <link rel="stylesheet" href="../css/style.css">
    <style>
        .admin-container {
            display: grid;
            grid-template-columns: 250px 1fr;
            min-height: 100vh;
        }

        .admin-sidebar {
            background: var(--dark-surface);
            border-right: 1px solid var(--dark-border);
            padding: var(--space-6);
        }

        .admin-sidebar-logo {
            font-family: var(--font-display);
            font-size: var(--text-xl);
            font-weight: var(--font-bold);
            margin-bottom: var(--space-8);
        }

        .admin-sidebar-logo span {
            color: var(--saffron);
        }

        .admin-nav {
            display: flex;
            flex-direction: column;
            gap: var(--space-2);
        }

        .admin-nav-link {
            padding: var(--space-3) var(--space-4);
            border-radius: var(--radius-lg);
            color: var(--text-secondary);
            display: flex;
            align-items: center;
            gap: var(--space-3);
            transition: var(--transition-base);
        }

        .admin-nav-link:hover,
        .admin-nav-link.active {
            background: var(--dark-card);
            color: var(--text-primary);
        }

        .admin-nav-link.active {
            border-left: 3px solid var(--saffron);
        }

        .admin-content {
            padding: var(--space-8);
        }

        .admin-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: var(--space-8);
        }

        .admin-title {
            font-family: var(--font-display);
            font-size: var(--text-3xl);
            font-weight: var(--font-bold);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: var(--space-6);
            margin-bottom: var(--space-8);
        }

        .stat-card {
            background: var(--gradient-card);
            border: 1px solid var(--glass-border);
            border-radius: var(--radius-xl);
            padding: var(--space-6);
        }

        .stat-icon {
            font-size: 2rem;
            margin-bottom: var(--space-3);
        }

        .stat-value {
            font-family: var(--font-display);
            font-size: var(--text-3xl);
            font-weight: var(--font-bold);
            color: var(--saffron);
        }

        .stat-label {
            color: var(--text-muted);
            font-size: var(--text-sm);
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            background: var(--dark-card);
            border-radius: var(--radius-xl);
            overflow: hidden;
        }

        .data-table th,
        .data-table td {
            padding: var(--space-4);
            text-align: left;
            border-bottom: 1px solid var(--dark-border);
        }

        .data-table th {
            background: var(--dark-surface);
            font-weight: var(--font-semibold);
            color: var(--text-muted);
            font-size: var(--text-sm);
            text-transform: uppercase;
        }

        .data-table tr:hover {
            background: rgba(255, 153, 51, 0.05);
        }

        @media (max-width: 768px) {
            .admin-container {
                grid-template-columns: 1fr;
            }

            .admin-sidebar {
                display: none;
            }

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
    </style>
</head>

<body>
    <div class="admin-container">
        <!-- Sidebar -->
        <aside class="admin-sidebar">
            <div class="admin-sidebar-logo">Virtual<span>India</span></div>
            <nav class="admin-nav">
                <a href="#dashboard" class="admin-nav-link active" data-section="dashboard">
                    <span>📊</span> Dashboard
                </a>
                <a href="#regions" class="admin-nav-link" data-section="regions">
                    <span>🗺️</span> Regions
                </a>
                <a href="#cultural" class="admin-nav-link" data-section="cultural">
                    <span>🎭</span> Cultural Items
                </a>
                <a href="#festivals" class="admin-nav-link" data-section="festivals">
                    <span>🎉</span> Festivals
                </a>
                <a href="#quiz" class="admin-nav-link" data-section="quiz">
                    <span>❓</span> Quiz Questions
                </a>
                <a href="#users" class="admin-nav-link" data-section="users">
                    <span>👥</span> Users
                </a>
                <hr style="border-color: var(--dark-border); margin: var(--space-4) 0;">
                <a href="../index.html" class="admin-nav-link">
                    <span>🏠</span> View Site
                </a>
                <a href="#" class="admin-nav-link" onclick="logout()">
                    <span>🚪</span> Logout
                </a>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="admin-content">
            <div class="admin-header">
                <h1 class="admin-title">Admin Dashboard</h1>
                <div id="adminInfo" style="color: var(--text-muted);">Welcome, Admin</div>
            </div>

            <!-- Stats Grid -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">🗺️</div>
                    <div class="stat-value" id="regionCount">4</div>
                    <div class="stat-label">Regions</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">🎭</div>
                    <div class="stat-value" id="culturalCount">-</div>
                    <div class="stat-label">Cultural Items</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">🎉</div>
                    <div class="stat-value" id="festivalCount">-</div>
                    <div class="stat-label">Festivals</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">❓</div>
                    <div class="stat-value" id="quizCount">-</div>
                    <div class="stat-label">Quiz Questions</div>
                </div>
            </div>

            <!-- Content Sections -->
            <div id="contentArea">
                <div class="card" style="padding: var(--space-6);">
                    <h2
                        style="font-family: var(--font-display); font-size: var(--text-xl); margin-bottom: var(--space-4);">
                        📋 Recent Activity
                    </h2>
                    <p style="color: var(--text-muted);">
                        Welcome to the Virtual India Admin Dashboard. Use the sidebar to manage content.
                    </p>
                    <div style="margin-top: var(--space-6);">
                        <h3 style="font-size: var(--text-lg); margin-bottom: var(--space-4);">Quick Actions</h3>
                        <div style="display: flex; gap: var(--space-4); flex-wrap: wrap;">
                            <a href="#cultural" class="btn btn-primary" onclick="showSection('cultural')">Add Cultural
                                Item</a>
                            <a href="#festivals" class="btn btn-secondary" onclick="showSection('festivals')">Add
                                Festival</a>
                            <a href="#quiz" class="btn btn-secondary" onclick="showSection('quiz')">Add Quiz
                                Question</a>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="../js/translations.js"></script>
    <script src="../js/main.js"></script>
    <script>
        // Check admin access
        document.addEventListener('DOMContentLoaded', async () => {
            loadStats();

            // Nav link handling
            document.querySelectorAll('.admin-nav-link[data-section]').forEach(link => {
                link.addEventListener('click', (e) => {
                    e.preventDefault();
                    const section = link.dataset.section;
                    document.querySelectorAll('.admin-nav-link').forEach(l => l.classList.remove('active'));
                    link.classList.add('active');
                    showSection(section);
                });
            });
        });

        async function loadStats() {
            try {
                const [culturalRes, festivalRes, quizRes] = await Promise.all([
                    fetchCulturalItems(),
                    fetchFestivals(),
                    fetchQuizQuestions(100)
                ]);

                if (culturalRes.success) {
                    document.getElementById('culturalCount').textContent = culturalRes.data.length;
                }
                if (festivalRes.success) {
                    document.getElementById('festivalCount').textContent = festivalRes.data.length;
                }
                if (quizRes.success) {
                    document.getElementById('quizCount').textContent = quizRes.data.length;
                }
            } catch (error) {
                console.error('Failed to load stats:', error);
            }
        }

        async function showSection(section) {
            const contentArea = document.getElementById('contentArea');

            switch (section) {
                case 'dashboard':
                    location.reload();
                    break;
                case 'regions':
                    await showRegions(contentArea);
                    break;
                case 'cultural':
                    await showCultural(contentArea);
                    break;
                case 'festivals':
                    await showFestivals(contentArea);
                    break;
                case 'quiz':
                    await showQuiz(contentArea);
                    break;
                case 'users':
                    showUsers(contentArea);
                    break;
            }
        }

        async function showRegions(container) {
            const response = await fetchRegions();
            if (response.success) {
                container.innerHTML = `
                    <div class="card" style="padding: var(--space-6);">
                        <h2 style="font-family: var(--font-display); font-size: var(--text-xl); margin-bottom: var(--space-6);">
                            🗺️ Regions
                        </h2>
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>States</th>
                                </tr>
                            </thead>
                            <tbody>
                                ${response.data.map(r => `
                                    <tr>
                                        <td>${r.id}</td>
                                        <td>${r.name}</td>
                                        <td>${r.states?.substring(0, 50)}...</td>
                                    </tr>
                                `).join('')}
                            </tbody>
                        </table>
                    </div>
                `;
            }
        }

        async function showCultural(container) {
            const response = await fetchCulturalItems();
            if (response.success) {
                container.innerHTML = `
                    <div class="card" style="padding: var(--space-6);">
                        <h2 style="font-family: var(--font-display); font-size: var(--text-xl); margin-bottom: var(--space-6);">
                            🎭 Cultural Items
                        </h2>
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Category</th>
                                    <th>Region</th>
                                </tr>
                            </thead>
                            <tbody>
                                ${response.data.map(item => `
                                    <tr>
                                        <td>${item.id}</td>
                                        <td>${item.name}</td>
                                        <td>${item.category}</td>
                                        <td>${item.region_name || '-'}</td>
                                    </tr>
                                `).join('')}
                            </tbody>
                        </table>
                    </div>
                `;
            }
        }

        async function showFestivals(container) {
            const response = await fetchFestivals();
            if (response.success) {
                container.innerHTML = `
                    <div class="card" style="padding: var(--space-6);">
                        <h2 style="font-family: var(--font-display); font-size: var(--text-xl); margin-bottom: var(--space-6);">
                            🎉 Festivals
                        </h2>
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Month</th>
                                    <th>Region</th>
                                </tr>
                            </thead>
                            <tbody>
                                ${response.data.map(f => `
                                    <tr>
                                        <td>${f.id}</td>
                                        <td>${f.name}</td>
                                        <td>${getMonthName(f.month)}</td>
                                        <td>${f.region_name || 'Pan-India'}</td>
                                    </tr>
                                `).join('')}
                            </tbody>
                        </table>
                    </div>
                `;
            }
        }

        async function showQuiz(container) {
            const response = await fetchQuizQuestions(100);
            if (response.success) {
                container.innerHTML = `
                    <div class="card" style="padding: var(--space-6);">
                        <h2 style="font-family: var(--font-display); font-size: var(--text-xl); margin-bottom: var(--space-6);">
                            ❓ Quiz Questions
                        </h2>
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Question</th>
                                    <th>Category</th>
                                    <th>Answer</th>
                                </tr>
                            </thead>
                            <tbody>
                                ${response.data.map(q => `
                                    <tr>
                                        <td>${q.id}</td>
                                        <td>${q.question.substring(0, 50)}...</td>
                                        <td>${q.category}</td>
                                        <td>${q.correct}</td>
                                    </tr>
                                `).join('')}
                            </tbody>
                        </table>
                    </div>
                `;
            }
        }

        function showUsers(container) {
            container.innerHTML = `
                <div class="card" style="padding: var(--space-6);">
                    <h2 style="font-family: var(--font-display); font-size: var(--text-xl); margin-bottom: var(--space-6);">
                        👥 Users
                    </h2>
                    <p style="color: var(--text-muted);">
                        User management is handled through the database directly via phpMyAdmin.
                    </p>
                    <a href="http://localhost/phpmyadmin" target="_blank" class="btn btn-primary" style="margin-top: var(--space-4);">
                        Open phpMyAdmin
                    </a>
                </div>
            `;
        }
    </script>
</body>

</html>