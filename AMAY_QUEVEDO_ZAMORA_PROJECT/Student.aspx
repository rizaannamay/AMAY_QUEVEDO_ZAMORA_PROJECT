<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Campus Announcement Portal - Dynamic Posts</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', 'Roboto', Helvetica, Arial, sans-serif;
            background-color: #f0f2f5;
            color: #1c1e21;
        }

        /* Facebook Blue Theme */
        :root {
            --fb-blue: #1877f2;
            --fb-hover-blue: #e7f3ff;
            --fb-border: #e4e6eb;
            --fb-bg: #f0f2f5;
            --fb-card: #ffffff;
            --fb-text: #1c1e21;
            --fb-text-secondary: #65676b;
        }

        /* DARK MODE */
        body.dark-mode {
            background-color: #18191a;
            color: #e4e6eb;
        }
        body.dark-mode .header {
            background-color: #242526;
            border-bottom-color: #3e4042;
        }
        body.dark-mode .card, body.dark-mode .create-card, body.dark-mode .sidebar-card, body.dark-mode .right-card {
            background-color: #242526;
            border-color: #3e4042;
        }
        body.dark-mode .sidebar-item:hover {
            background-color: #3a3b3c;
        }
        body.dark-mode .post-action-btn:hover {
            background-color: #3a3b3c;
        }
        body.dark-mode .search-bar {
            background-color: #3a3b3c;
        }
        body.dark-mode .search-bar input {
            color: #e4e6eb;
        }
        body.dark-mode .filter-chip {
            background-color: #3a3b3c;
            color: #e4e6eb;
        }
        body.dark-mode .filter-chip.active {
            background-color: var(--fb-blue);
            color: white;
        }
        body.dark-mode .empty-state {
            color: #b0b3b8;
        }
        body.dark-mode .empty-icon {
            background-color: #3a3b3c;
            color: #b0b3b8;
        }
        body.dark-mode .post-card {
            background-color: #242526;
            border-color: #3e4042;
        }
        body.dark-mode .post-stats, body.dark-mode .reactions-row {
            border-top-color: #3e4042;
            border-bottom-color: #3e4042;
        }
        body.dark-mode .reaction-btn:hover {
            background-color: #3a3b3c;
        }

        /* === HEADER === */
        .header {
            background-color: #ffffff;
            height: 56px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 16px;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
            border-bottom: 1px solid var(--fb-border);
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .campus-logo {
            font-size: 20px;
            font-weight: 700;
            color: var(--fb-blue);
            letter-spacing: -0.5px;
            cursor: pointer;
        }

        .search-bar {
            background-color: #f0f2f5;
            border-radius: 24px;
            padding: 8px 16px;
            display: flex;
            align-items: center;
            gap: 8px;
            width: 280px;
            margin-left: 8px;
        }
        .search-bar i {
            color: #65676b;
        }
        .search-bar input {
            border: none;
            background: transparent;
            outline: none;
            font-size: 15px;
            width: 100%;
        }

        .header-right {
            display: flex;
            gap: 8px;
            align-items: center;
        }
        .header-icon {
            background-color: #e4e6eb;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            color: #1c1e21;
        }
        .avatar-sm {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #1877f2, #0c63d4);
            cursor: pointer;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="white"><path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/></svg>');
            background-size: 60%;
            background-position: center 55%;
            background-repeat: no-repeat;
        }

        /* MAIN GRID */
        .app-container {
            display: grid;
            grid-template-columns: 360px minmax(0, 680px) 360px;
            gap: 24px;
            max-width: 1400px;
            margin: 80px auto 0;
            padding: 0 16px;
        }

        /* LEFT SIDEBAR */
        .sidebar-card {
            background: white;
            border-radius: 8px;
            border: 1px solid var(--fb-border);
            padding: 8px 0;
            margin-bottom: 16px;
        }
        .sidebar-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.2s;
            color: var(--fb-text);
            font-weight: 500;
            font-size: 15px;
        }
        .sidebar-item i {
            width: 28px;
            font-size: 20px;
            color: var(--fb-blue);
        }
        .sidebar-item:hover {
            background-color: #f0f2f5;
        }
        .sidebar-item.active {
            background-color: #e7f3ff;
            color: var(--fb-blue);
            font-weight: 600;
        }
        .divider {
            height: 1px;
            background-color: var(--fb-border);
            margin: 8px 0;
        }

        /* CREATE POST CARD */
        .create-card {
            background: white;
            border-radius: 8px;
            border: 1px solid var(--fb-border);
            margin-bottom: 16px;
        }
        .create-top {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 16px;
        }
        .avatar-md {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #42a5f5, #1877f2);
            flex-shrink: 0;
        }
        .dummy-post-input {
            background-color: #f0f2f5;
            border-radius: 24px;
            padding: 10px 16px;
            flex: 1;
            color: #65676b;
            cursor: pointer;
            font-size: 15px;
        }
        .post-actions {
            display: flex;
            justify-content: space-around;
            padding: 8px 0;
            border-top: 1px solid var(--fb-border);
        }
        .post-action-btn {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
            color: #65676b;
        }
        .post-action-btn:hover {
            background-color: #f0f2f5;
        }

        /* FILTER ROW */
        .filter-row {
            display: flex;
            gap: 8px;
            padding: 8px 16px;
            background: white;
            border-radius: 8px;
            border: 1px solid var(--fb-border);
            margin-bottom: 16px;
        }
        .filter-chip {
            padding: 6px 20px;
            border-radius: 20px;
            background: #f0f2f5;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.2s;
            color: #1c1e21;
        }
        .filter-chip.active {
            background: var(--fb-blue);
            color: white;
        }

        /* POST CARD */
        .post-card {
            background: white;
            border-radius: 8px;
            border: 1px solid var(--fb-border);
            margin-bottom: 16px;
            display: none;
        }
        .post-card.visible {
            display: block;
        }
        .post-header {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 16px;
        }
        .post-info {
            flex: 1;
        }
        .post-name {
            font-weight: 600;
            font-size: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }
        .pin-badge {
            color: var(--fb-blue);
            font-size: 11px;
            background: #e7f3ff;
            padding: 2px 8px;
            border-radius: 12px;
        }
        .category-badge {
            font-size: 11px;
            background: #e4e6eb;
            padding: 2px 8px;
            border-radius: 12px;
            color: #1c1e21;
        }
        .post-time {
            font-size: 12px;
            color: #65676b;
            margin-top: 2px;
        }
        .post-content {
            padding: 0 16px 12px;
            font-size: 15px;
        }
        .post-content h4 {
            margin-bottom: 6px;
            font-size: 16px;
        }
        .post-stats {
            display: flex;
            justify-content: space-between;
            padding: 8px 16px;
            border-top: 1px solid var(--fb-border);
            border-bottom: 1px solid var(--fb-border);
            font-size: 14px;
            color: #65676b;
        }
        .reactions-row {
            display: flex;
            justify-content: space-around;
            padding: 6px 0;
        }
        .reaction-btn {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 8px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
            color: #65676b;
        }
        .reaction-btn:hover {
            background-color: #f0f2f5;
        }

        /* EMPTY STATE */
        .empty-state {
            text-align: center;
            padding: 48px 24px;
            background: white;
            border-radius: 8px;
            border: 1px solid var(--fb-border);
        }
        .empty-icon {
            font-size: 56px;
            color: #bcc0c4;
            margin-bottom: 16px;
            background: #f0f2f5;
            width: 100px;
            height: 100px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-left: auto;
            margin-right: auto;
        }
        .empty-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 8px;
            color: #1c1e21;
        }
        .empty-subtitle {
            color: #65676b;
            font-size: 15px;
        }

        /* RIGHT SIDEBAR */
        .right-card {
            background: white;
            border-radius: 8px;
            border: 1px solid var(--fb-border);
            margin-bottom: 16px;
            overflow: hidden;
        }
        .right-header {
            font-weight: 700;
            font-size: 17px;
            padding: 12px 16px;
            border-bottom: 1px solid var(--fb-border);
        }
        .empty-message {
            padding: 32px 16px;
            text-align: center;
            color: #65676b;
            font-size: 14px;
        }
        .empty-message i {
            font-size: 32px;
            margin-bottom: 12px;
            display: block;
            color: #bcc0c4;
        }
        .pinned-item, .notification-item {
            padding: 12px 16px;
            border-bottom: 1px solid #f0f2f5;
            cursor: pointer;
        }
        .pinned-item:hover, .notification-item:hover {
            background-color: #f0f2f5;
        }
        .pinned-title {
            font-weight: 600;
            font-size: 14px;
        }
        .pinned-meta, .notification-text {
            font-size: 12px;
            color: #65676b;
            margin-top: 4px;
        }
        .notification-avatar {
            display: inline-block;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: #e4e6eb;
            text-align: center;
            line-height: 32px;
            margin-right: 10px;
        }

        @media (max-width: 1100px) {
            .app-container {
                grid-template-columns: 280px 1fr;
                gap: 16px;
            }
            .right-sidebar {
                display: none;
            }
        }
        @media (max-width: 780px) {
            .app-container {
                grid-template-columns: 1fr;
            }
            .left-sidebar {
                display: none;
            }
        }
    </style>
</head>
<body>

<div class="header">
    <div class="header-left">
        <div class="campus-logo">
            <i class="fas fa-graduation-cap" style="margin-right: 6px;"></i> Campus Announcement</div>
        <div class="search-bar">
            <i class="fas fa-search"></i>
            <input type="text" id="searchInput" placeholder="Search Announcements...">
        </div>
    </div>
    <div class="header-right">
        <div class="header-icon"><i class="fas fa-user-friends"></i></div>
        <div class="header-icon"><i class="fas fa-bell"></i></div>
        <div class="avatar-sm"></div>
    </div>
</div>

<div class="app-container">
    <!-- LEFT SIDEBAR -->
    <div class="left-sidebar">
        <div class="sidebar-card">
            <div class="sidebar-item active" id="navHome">
                <i class="fas fa-newspaper"></i> Announcement Board
            </div>
            <div class="sidebar-item" id="navPinned">
                <i class="fas fa-thumbtack"></i> Pinned Announcements
            </div>
            <div class="divider"></div>
            <div class="sidebar-item" id="darkModeToggle">
                <i class="fas fa-moon"></i> Dark Mode
            </div>
            <div class="sidebar-item" id="settingsBtn">
                <i class="fas fa-cog"></i> Settings
            </div>
        </div>
    </div>

    <!-- MAIN FEED -->
    <div class="main-feed">
        <!-- Create Post Card -->

        <!-- Filter Chips -->
        <div class="filter-row">
            <div class="filter-chip active" data-filter="all">All</div>
            <div class="filter-chip" data-filter="events">Events</div>
            <div class="filter-chip" data-filter="exams">Exams</div>
            <div class="filter-chip" data-filter="suspensions">Suspensions</div>
        </div>

        <!-- Posts Container -->
        <div id="postsContainer"></div>

        <!-- Empty State (shown when no posts) -->
        <div id="emptyState" class="empty-state">
            <div class="empty-icon">
                <i class="fas fa-newspaper"></i>
            </div>
            <div class="empty-title">No announcements yet</div>
            <div class="empty-subtitle">Be the first to post an announcement. Click "What's on your mind?" above to share campus news, events, or updates.</div>
        </div>
    </div>

    <!-- RIGHT SIDEBAR -->
    <div class="right-sidebar">
        <!-- Pinned Announcements Card -->
        <div class="right-card" id="pinnedCard">
            <div class="right-header">
                <i class="fas fa-thumbtack" style="color:#1877f2;"></i> Pinned Announcements
            </div>
            <div id="pinnedList" class="empty-message">
                <i class="fas fa-thumbtack"></i>
                No pinned announcements yet
            </div>
        </div>

        <!-- Notifications Card -->
        <div class="right-card" id="notificationsCard">
            <div class="right-header">
                <i class="fas fa-bell"></i> Notifications
            </div>
            <div id="notificationsList" class="empty-message">
                <i class="fas fa-bell-slash"></i>
                No new notifications
            </div>
        </div>

       
            </div>
        </div>
    </div>
</div>

<!-- Post Creation Modal (simple prompt) -->
<script>
    // Data storage
    let posts = [];
    let nextId = 1;
    let currentFilter = 'all';
    let currentView = 'home'; // home, pinned

    // DOM elements
    const postsContainer = document.getElementById('postsContainer');
    const emptyState = document.getElementById('emptyState');
    const pinnedList = document.getElementById('pinnedList');
    const notificationsList = document.getElementById('notificationsList');
    const searchInput = document.getElementById('searchInput');

    // Helper: format time ago
    function timeAgo(date) {
        const seconds = Math.floor((new Date() - date) / 1000);
        if (seconds < 60) return 'just now';
        const minutes = Math.floor(seconds / 60);
        if (minutes < 60) return `${minutes} minute${minutes > 1 ? 's' : ''} ago`;
        const hours = Math.floor(minutes / 60);
        if (hours < 24) return `${hours} hour${hours > 1 ? 's' : ''} ago`;
        const days = Math.floor(hours / 24);
        return `${days} day${days > 1 ? 's' : ''} ago`;
    }

    // Render posts based on filter and search
    function renderPosts() {
        let filteredPosts = [...posts];

        // Filter by view (pinned vs home)
        if (currentView === 'pinned') {
            filteredPosts = filteredPosts.filter(p => p.pinned);
        }

        // Filter by category
        if (currentFilter !== 'all') {
            filteredPosts = filteredPosts.filter(p => p.category === currentFilter);
        }

        // Search filter
        const searchTerm = searchInput ? searchInput.value.toLowerCase() : '';
        if (searchTerm) {
            filteredPosts = filteredPosts.filter(p => p.title.toLowerCase().includes(searchTerm) || p.content.toLowerCase().includes(searchTerm));
        }

        // Sort by date (newest first)
        filteredPosts.sort((a, b) => b.date - a.date);

        if (filteredPosts.length === 0) {
            postsContainer.innerHTML = '';
            emptyState.style.display = 'block';
            return;
        }

        emptyState.style.display = 'none';

        postsContainer.innerHTML = filteredPosts.map(post => `
            <div class="post-card visible" data-id="${post.id}" data-category="${post.category}" data-pinned="${post.pinned}">
                <div class="post-header">
                    <div class="avatar-md" style="background: ${post.avatarColor}"></div>
                    <div class="post-info">
                        <div class="post-name">
                            ${post.author}
                            ${post.pinned ? '<span class="pin-badge"><i class="fas fa-thumbtack"></i> Pinned</span>' : ''}
                            <span class="category-badge">${post.categoryLabel}</span>
                        </div>
                        <div class="post-time">${timeAgo(post.date)} • ${post.categoryLabel}</div>
                    </div>
                    <i class="fas fa-ellipsis-h" style="color:#65676b; cursor:pointer;"></i>
                </div>
                <div class="post-content">
                    <h4>${escapeHtml(post.title)}</h4>
                    <p>${escapeHtml(post.content)}</p>
                </div>
                <div class="post-stats">
                    <span><i class="fas fa-thumbs-up"></i> ${post.likes} Likes</span>
                    <span>0 comments • 0 shares</span>
                </div>
                <div class="reactions-row">
                    <div class="reaction-btn like-btn" data-id="${post.id}"><i class="far fa-thumbs-up"></i> Like</div>
                    <div class="reaction-btn"><i class="far fa-comment"></i> Comment</div>
                    <div class="reaction-btn"><i class="fas fa-share"></i> Share</div>
                </div>
            </div>
        `).join('');

        // Attach like event listeners
        document.querySelectorAll('.like-btn').forEach(btn => {
            btn.addEventListener('click', function (e) {
                const id = parseInt(this.getAttribute('data-id'));
                const post = posts.find(p => p.id === id);
                if (post) {
                    post.likes++;
                    renderPosts();
                    renderPinnedAndNotifications();
                }
            });
        });
    }

    function escapeHtml(str) {
        return str.replace(/[&<>]/g, function (m) {
            if (m === '&') return '&amp;';
            if (m === '<') return '&lt;';
            if (m === '>') return '&gt;';
            return m;
        });
    }

    // Render pinned announcements and notifications
    function renderPinnedAndNotifications() {
        const pinnedPosts = posts.filter(p => p.pinned);
        if (pinnedPosts.length === 0) {
            pinnedList.innerHTML = '<i class="fas fa-thumbtack"></i><br>No pinned announcements yet';
        } else {
            pinnedList.innerHTML = pinnedPosts.map(post => `
                <div class="pinned-item">
                    <div class="pinned-title">📌 ${escapeHtml(post.title)}</div>
                    <div class="pinned-meta">${timeAgo(post.date)} • ${post.categoryLabel} • ${post.author}</div>
                </div>
            `).join('');
        }

        // Notifications: show when someone likes or new post (demo)
        const recentActivities = [];
        posts.forEach(post => {
            recentActivities.push(`${post.author} posted "${post.title.substring(0, 40)}${post.title.length > 40 ? '...' : ''}"`);
        });
        if (recentActivities.length === 0) {
            notificationsList.innerHTML = '<i class="fas fa-bell-slash"></i><br>No new notifications';
        } else {
            notificationsList.innerHTML = recentActivities.slice(0, 5).map(act => `
                <div class="notification-item">
                    <div class="notification-avatar"><i class="fas fa-user-circle"></i></div>
                    <div class="notification-text">
                        <strong>New update</strong><br>${act}
                        <div class="notification-time">just now</div>
                    </div>
                </div>
            `).join('');
        }
    }

    // Create new post
    function createPost(title, content, category, categoryLabel, isPinned = false) {
        const newPost = {
            id: nextId++,
            author: "Admin User",
            authorAvatar: "A",
            avatarColor: `hsl(${Math.floor(Math.random() * 360)}, 65%, 55%)`,
            title: title,
            content: content,
            category: category,
            categoryLabel: categoryLabel,
            date: new Date(),
            likes: 0,
            pinned: isPinned
        };
        posts.unshift(newPost);
        renderPosts();
        renderPinnedAndNotifications();

        // Show success message
        alert(`✅ Announcement "${title}" has been posted!`);
    }

    // Open post creation modal
    function openPostCreator() {
        const category = prompt("Select category:\n1 - Events\n2 - Exams\n3 - Suspensions\n\nEnter number (1-3):", "1");
        let catValue, catLabel;
        if (category === "1") { catValue = "events"; catLabel = "Events"; }
        else if (category === "2") { catValue = "exams"; catLabel = "Exams"; }
        else if (category === "3") { catValue = "suspensions"; catLabel = "Suspensions"; }
        else { alert("Invalid category. Using Events."); catValue = "events"; catLabel = "Events"; }

        const title = prompt("Announcement Title:", "");
        if (!title) return;

        const content = prompt("Announcement Content:", "");
        if (!content) return;

        const wantPinned = confirm("Do you want to PIN this announcement? (Yes = Pinned)");

        createPost(title, content, catValue, catLabel, wantPinned);
    }

    // Event listeners
    document.getElementById('postTrigger')?.addEventListener('click', openPostCreator);
    document.getElementById('photoVideoBtn')?.addEventListener('click', openPostCreator);
    document.getElementById('eventBtn')?.addEventListener('click', openPostCreator);
    document.getElementById('pollBtn')?.addEventListener('click', openPostCreator);

    // Filter chips
    document.querySelectorAll('.filter-chip').forEach(chip => {
        chip.addEventListener('click', function () {
            document.querySelectorAll('.filter-chip').forEach(c => c.classList.remove('active'));
            this.classList.add('active');
            currentFilter = this.getAttribute('data-filter');
            if (currentView === 'pinned') {
                // stay in pinned view but apply filter
                renderPosts();
            } else {
                renderPosts();
            }
        });
    });

    // Navigation
    const navHome = document.getElementById('navHome');
    const navPinned = document.getElementById('navPinned');
    const navCategories = document.getElementById('navCategories');

    navHome?.addEventListener('click', () => {
        document.querySelectorAll('.sidebar-item').forEach(item => item.classList.remove('active'));
        navHome.classList.add('active');
        currentView = 'home';
        currentFilter = 'all';
        // reset filter chips
        document.querySelectorAll('.filter-chip').forEach(c => c.classList.remove('active'));
        document.querySelector('.filter-chip[data-filter="all"]')?.classList.add('active');
        renderPosts();
    });

    navPinned?.addEventListener('click', () => {
        document.querySelectorAll('.sidebar-item').forEach(item => item.classList.remove('active'));
        navPinned.classList.add('active');
        currentView = 'pinned';
        renderPosts();
    });

    navCategories?.addEventListener('click', () => {
        alert("📂 Categories: Events, Exams, Suspensions — Select a filter above to see announcements by category.");
    });

    // Dark Mode
    const darkToggle = document.getElementById('darkModeToggle');
    darkToggle?.addEventListener('click', function () {
        document.body.classList.toggle('dark-mode');
        const isDark = document.body.classList.contains('dark-mode');
        localStorage.setItem('campusDarkMode', isDark);
        const icon = darkToggle.querySelector('i');
        if (isDark) {
            icon.classList.remove('fa-moon');
            icon.classList.add('fa-sun');
        } else {
            icon.classList.remove('fa-sun');
            icon.classList.add('fa-moon');
        }
    });

    if (localStorage.getItem('campusDarkMode') === 'true') {
        document.body.classList.add('dark-mode');
        const darkIcon = document.querySelector('#darkModeToggle i');
        if (darkIcon) {
            darkIcon.classList.remove('fa-moon');
            darkIcon.classList.add('fa-sun');
        }
    }

    document.getElementById('createGroupBtn')?.addEventListener('click', () => alert("✨ Create a new study group or club on campus!"));
    document.getElementById('settingsBtn')?.addEventListener('click', () => alert("⚙️ Notification & privacy settings"));

    // Search
    searchInput?.addEventListener('input', () => {
        renderPosts();
    });

    // Initial render (empty)
    renderPosts();
    renderPinnedAndNotifications();
</script>
</body>
</html>