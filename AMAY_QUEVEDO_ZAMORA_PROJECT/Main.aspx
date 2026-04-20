<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Campus Announcement Portal - Facebook Layout</title>
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

        /* === HEADER (Facebook style) === */
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

        .fb-logo {
            background: linear-gradient(135deg, #1877f2, #0c63d4);
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .fb-logo i {
            font-size: 24px;
            color: white;
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

        /* MAIN GRID: 3 columns exactly like Facebook */
        .app-container {
            display: grid;
            grid-template-columns: 360px minmax(0, 680px) 360px;
            gap: 24px;
            max-width: 1400px;
            margin: 80px auto 0;
            padding: 0 16px;
        }

        /* LEFT SIDEBAR - matches photo: Announcement Board, Categories, Pinned, Dark Mode, Create Group, Settings */
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

        /* FILTER ROW: All, Events, Exams, Suspensions (exactly as photo) */
        .filter-row {
            display: flex;
            gap: 8px;
            padding: 8px 16px;
            background: white;
            border-radius: 8px 8px 0 0;
            border-bottom: 1px solid var(--fb-border);
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

        /* RIGHT SIDEBAR: Pinned Announcements + Notifications (exactly as photo reference) */
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
        .pinned-item {
            padding: 12px 16px;
            border-bottom: 1px solid #f0f2f5;
            cursor: pointer;
            transition: background 0.2s;
        }
        .pinned-item:hover {
            background-color: #f0f2f5;
        }
        .pinned-title {
            font-weight: 600;
            font-size: 14px;
        }
        .pinned-meta {
            font-size: 11px;
            color: #65676b;
            margin-top: 4px;
        }
        .notification-item {
            display: flex;
            gap: 12px;
            padding: 12px 16px;
            border-bottom: 1px solid #f0f2f5;
            cursor: pointer;
            transition: background 0.2s;
        }
        .notification-item:hover {
            background-color: #f0f2f5;
        }
        .notification-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: #e4e6eb;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--fb-blue);
        }
        .notification-text {
            font-size: 13px;
            flex: 1;
        }
        .notification-time {
            font-size: 11px;
            color: #65676b;
            margin-top: 2px;
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
        <div class="fb-logo">
            <i class="fab fa-facebook-f"></i>
        </div>
        <div class="search-bar">
            <i class="fas fa-search"></i>
            <input type="text" placeholder="Search Campus Announcements...">
        </div>
    </div>
    <div class="header-right">
        <div class="header-icon"><i class="fas fa-user-friends"></i></div>
        <div class="header-icon"><i class="fas fa-bell"></i></div>
        <div class="avatar-sm"></div>
    </div>
</div>

<div class="app-container">
    <!-- LEFT SIDEBAR - exactly as photo: Announcement Board, Categories, Pinned, Dark Mode, Create Group, Settings -->
    <div class="left-sidebar">
        <div class="sidebar-card">
            <div class="sidebar-item active" id="navHome">
                <i class="fas fa-newspaper"></i> Announcement Board
            </div>
            <div class="sidebar-item" id="navCategories">
                <i class="fas fa-th-large"></i> Categories
            </div>
            <div class="sidebar-item" id="navPinned">
                <i class="fas fa-thumbtack"></i> Pinned Announcements
            </div>
            <div class="divider"></div>
            <div class="sidebar-item" id="darkModeToggle">
                <i class="fas fa-moon"></i> Dark Mode
            </div>
            <div class="sidebar-item" id="createGroupBtn">
                <i class="fas fa-users"></i> Create Group
            </div>
            <div class="sidebar-item" id="settingsBtn">
                <i class="fas fa-cog"></i> Settings
            </div>
        </div>
    </div>

    <!-- MAIN FEED -->
    <div class="main-feed">
        <!-- Create post card: "Post an announcement..." + Photos/Video + Event -->
        <div class="create-card">
            <div class="create-top">
                <div class="avatar-md"></div>
                <div class="dummy-post-input" id="postTrigger">Post an announcement...</div>
            </div>
            <div class="post-actions">
                <div class="post-action-btn"><i class="fas fa-image" style="color:#45bd62;"></i> Photos/Video</div>
                <div class="post-action-btn"><i class="fas fa-calendar-alt" style="color:#1877f2;"></i> Event</div>
                <div class="post-action-btn"><i class="fas fa-video" style="color:#f3425f;"></i> Live</div>
            </div>
        </div>

        <!-- Filter chips: All, Events, Exams, Suspensions (matches photo exactly) -->
        <div class="post-card" style="padding: 0;">
            <div class="filter-row">
                <div class="filter-chip active" data-filter="all">All</div>
                <div class="filter-chip" data-filter="events">Events</div>
                <div class="filter-chip" data-filter="exams">Exams</div>
                <div class="filter-chip" data-filter="suspensions">Suspensions</div>
            </div>
        </div>

        <!-- POST 1: Riza Ann R. Amay - Pinned - Suspension (exactly as photo) -->
        <div class="post-card" data-category="suspensions" data-pinned="true">
            <div class="post-header">
                <div class="avatar-md" style="background: #e44d3a;"></div>
                <div class="post-info">
                    <div class="post-name">
                        Riza Ann R. Amay 
                        <span class="pin-badge"><i class="fas fa-thumbtack"></i> Pinned</span>
                        <span class="category-badge">Suspension</span>
                    </div>
                    <div class="post-time">Today at 9:00 AM • Suspension</div>
                </div>
                <i class="fas fa-ellipsis-h" style="color:#65676b; cursor:pointer;"></i>
            </div>
            <div class="post-content">
                <h4>⚠️ Class Suspension Due to Weather</h4>
                <p>Due to the severe weather conditions, all classes are suspended today, April 24th. Please stay safe and check this portal for further updates.</p>
            </div>
            <div class="post-stats">
                <span><i class="fas fa-thumbs-up"></i> 76 Likes</span>
                <span>8 comments • 3 shares</span>
            </div>
            <div class="reactions-row">
                <div class="reaction-btn"><i class="far fa-thumbs-up"></i> Like</div>
                <div class="reaction-btn"><i class="far fa-comment"></i> Comment</div>
                <div class="reaction-btn"><i class="fas fa-share"></i> Share</div>
            </div>
        </div>

        <!-- POST 2: Mary Chris Quevedo - Exams (exactly as photo) -->
        <div class="post-card" data-category="exams">
            <div class="post-header">
                <div class="avatar-md" style="background: #2d7a4b;"></div>
                <div class="post-info">
                    <div class="post-name">
                        Mary Chris Quevedo 
                        <span class="category-badge">Exams</span>
                    </div>
                    <div class="post-time">1 day ago • Exams</div>
                </div>
                <i class="fas fa-ellipsis-h" style="color:#65676b;"></i>
            </div>
            <div class="post-content">
                <h4>📚 Exam Schedule for Midterms</h4>
                <p>The midterm exam schedule is now available. Please check the announcement board for your specific exam dates and times.</p>
            </div>
            <div class="post-stats">
                <span><i class="fas fa-thumbs-up"></i> 45 Likes</span>
                <span>12 comments • 2 shares</span>
            </div>
            <div class="reactions-row">
                <div class="reaction-btn"><i class="far fa-thumbs-up"></i> Like</div>
                <div class="reaction-btn"><i class="far fa-comment"></i> Comment</div>
                <div class="reaction-btn"><i class="fas fa-share"></i> Share</div>
            </div>
        </div>

        <!-- Additional event post to match Facebook richness -->
        <div class="post-card" data-category="events">
            <div class="post-header">
                <div class="avatar-md" style="background: #e9a23b;"></div>
                <div class="post-info">
                    <div class="post-name">
                        Student Council 
                        <span class="category-badge">Events</span>
                    </div>
                    <div class="post-time">Yesterday at 3:30 PM</div>
                </div>
            </div>
            <div class="post-content">
                <h4>🎉 Campus Music Fest 2026</h4>
                <p>Join us this Friday at the Quad! Free food, live bands, and raffle prizes. See you there!</p>
            </div>
            <div class="post-stats">
                <span><i class="fas fa-thumbs-up"></i> 112 Likes</span>
                <span>24 comments • 8 shares</span>
            </div>
            <div class="reactions-row">
                <div class="reaction-btn"><i class="far fa-thumbs-up"></i> Like</div>
                <div class="reaction-btn"><i class="far fa-comment"></i> Comment</div>
                <div class="reaction-btn"><i class="fas fa-share"></i> Share</div>
            </div>
        </div>
    </div>

    <!-- RIGHT SIDEBAR: Pinned Announcements + Notifications (exactly as photo reference) -->
    <div class="right-sidebar">
        <!-- Pinned Announcements card -->
        <div class="right-card">
            <div class="right-header">
                <i class="fas fa-thumbtack" style="color:#1877f2;"></i> Pinned Announcements
            </div>
            <div class="pinned-item">
                <div class="pinned-title"><i class="fas fa-cloud-rain" style="color:#65676b;"></i> Class Suspension Due to Weather</div>
                <div class="pinned-meta">Today at 9:00 AM • Suspension • Riza Ann R. Amay</div>
            </div>
            <div class="pinned-item">
                <div class="pinned-title"><i class="fas fa-calendar-alt"></i> Midterm Exam Guidelines</div>
                <div class="pinned-meta">Yesterday • Exams • Registrar Office</div>
            </div>
            <div class="pinned-item">
                <div class="pinned-title"><i class="fas fa-music"></i> Campus Music Fest 2026</div>
                <div class="pinned-meta">April 22 • Events • Student Council</div>
            </div>
        </div>

        <!-- Notifications card (exactly like photo: Tim Suarez commented, Exam Schedule notification) -->
        <div class="right-card">
            <div class="right-header">
                <i class="fas fa-bell"></i> Notifications
            </div>
            <div class="notification-item">
                <div class="notification-avatar"><i class="fas fa-user-circle"></i></div>
                <div class="notification-text">
                    <strong>Tim Suarez</strong> commented on your post...
                    <div class="notification-time">2 minutes ago</div>
                </div>
            </div>
            <div class="notification-item">
                <div class="notification-avatar"><i class="fas fa-graduation-cap"></i></div>
                <div class="notification-text">
                    <strong>Exam Schedule for Midterms</strong> was posted by Mary Chris Quevedo
                    <div class="notification-time">Yesterday</div>
                </div>
            </div>
            <div class="notification-item">
                <div class="notification-avatar"><i class="fas fa-chalkboard-user"></i></div>
                <div class="notification-text">
                    <strong>Student Council</strong> added a new event: Music Fest
                    <div class="notification-time">2 days ago</div>
                </div>
            </div>
        </div>

        <!-- Campus tip card (bonus, keeps consistency) -->
        <div class="right-card">
            <div class="right-header">📢 Campus Quick Links</div>
            <div class="pinned-item">📅 Academic Calendar</div>
            <div class="pinned-item">📖 Library Resources</div>
            <div class="pinned-item">💬 Student Support Hub</div>
        </div>
    </div>
</div>

<script>
    // Dark Mode Toggle
    const darkToggle = document.getElementById('darkModeToggle');
    if (darkToggle) {
        darkToggle.addEventListener('click', function () {
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
    }
    if (localStorage.getItem('campusDarkMode') === 'true') {
        document.body.classList.add('dark-mode');
        const darkIcon = document.querySelector('#darkModeToggle i');
        if (darkIcon) {
            darkIcon.classList.remove('fa-moon');
            darkIcon.classList.add('fa-sun');
        }
    }

    // Filter posts by category (All / Events / Exams / Suspensions)
    const filterChips = document.querySelectorAll('.filter-chip');
    const allPosts = document.querySelectorAll('.post-card[data-category]');
    function filterPosts(activeFilter) {
        allPosts.forEach(post => {
            const category = post.getAttribute('data-category');
            if (activeFilter === 'all') {
                post.style.display = 'block';
            } else {
                post.style.display = category === activeFilter ? 'block' : 'none';
            }
        });
    }
    filterChips.forEach(chip => {
        chip.addEventListener('click', function () {
            filterChips.forEach(c => c.classList.remove('active'));
            this.classList.add('active');
            filterPosts(this.getAttribute('data-filter'));
        });
    });

    // Sidebar navigation: Home, Categories, Pinned
    const navHome = document.getElementById('navHome');
    const navCategories = document.getElementById('navCategories');
    const navPinned = document.getElementById('navPinned');
    function setActiveSidebar(activeEl) {
        [navHome, navCategories, navPinned].forEach(el => el && el.classList.remove('active'));
        activeEl.classList.add('active');
    }
    if (navHome) {
        navHome.addEventListener('click', () => {
            setActiveSidebar(navHome);
            filterPosts('all');
            const allChip = document.querySelector('.filter-chip[data-filter="all"]');
            if (allChip) allChip.classList.add('active');
            filterChips.forEach(c => c.classList.remove('active'));
            if (allChip) allChip.classList.add('active');
            allPosts.forEach(p => p.style.display = 'block');
        });
    }
    if (navCategories) {
        navCategories.addEventListener('click', () => {
            setActiveSidebar(navCategories);
            alert("🔍 Categories: Academics, Events, Sports, Admissions — coming soon!");
        });
    }
    if (navPinned) {
        navPinned.addEventListener('click', () => {
            setActiveSidebar(navPinned);
            allPosts.forEach(post => {
                const isPinned = post.getAttribute('data-pinned') === 'true';
                post.style.display = isPinned ? 'block' : 'none';
            });
            filterChips.forEach(c => c.classList.remove('active'));
        });
    }
    // Create Group + Settings demo
    document.getElementById('createGroupBtn')?.addEventListener('click', () => alert("✨ Create a new study group or club on campus!"));
    document.getElementById('settingsBtn')?.addEventListener('click', () => alert("⚙️ Notification & privacy settings"));
    document.getElementById('postTrigger')?.addEventListener('click', () => alert("📢 Create announcement: share news, events, or alerts."));

    // Like button interactive counter
    const likeBtns = document.querySelectorAll('.reaction-btn:first-child');
    likeBtns.forEach(btn => {
        btn.addEventListener('click', function (e) {
            const statsSpan = this.closest('.post-card')?.querySelector('.post-stats span:first-child');
            if (statsSpan) {
                let likeText = statsSpan.innerText;
                let match = likeText.match(/\d+/);
                let likes = match ? parseInt(match[0]) : 0;
                if (!this.classList.contains('liked')) {
                    likes++;
                    statsSpan.innerHTML = `<i class="fas fa-thumbs-up"></i> ${likes} Likes`;
                    this.classList.add('liked');
                    this.style.color = '#1877f2';
                } else {
                    likes--;
                    statsSpan.innerHTML = `<i class="fas fa-thumbs-up"></i> ${likes} Likes`;
                    this.classList.remove('liked');
                    this.style.color = '#65676b';
                }
            } else {
                alert("👍 Liked!");
            }
        });
    });
</script>
</body>
</html>