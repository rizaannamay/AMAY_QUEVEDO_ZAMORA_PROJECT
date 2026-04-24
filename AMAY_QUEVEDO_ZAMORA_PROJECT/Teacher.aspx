<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes" />
    <title>Campus Announcement - Teacher Portal | Like, Share & Comment</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --bg-image: url('wbg.jpg');
            --page-text: #1a2a3a;
            --surface: rgba(255, 255, 255, 0.92);
            --surface-strong: #ffffff;
            --surface-soft: #f8fafc;
            --border: rgba(26, 58, 92, 0.12);
            --primary: #1a3a5c;
            --primary-2: #2c5a7a;
            --muted: #6b7c8f;
            --muted-light: #9db0c4;
            --shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
            --active-bg: #e8f0fe;
            --danger: #dc2626;
        }

        html, body {
            height: 100%;
            overflow: hidden;
            font-family: "Segoe UI", system-ui, -apple-system, sans-serif;
        }

        body {
            color: var(--page-text);
            background-image: linear-gradient(rgba(255, 255, 255, 0.3), rgba(255, 255, 255, 0.3)), var(--bg-image);
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            transition: background 0.3s ease, color 0.3s;
        }

        body.dark-mode {
            --bg-image: url('bg.jpg');
            --page-text: #e4e6eb;
            --surface: rgba(33, 38, 45, 0.9);
            --surface-strong: rgba(39, 44, 52, 0.96);
            --surface-soft: rgba(56, 62, 72, 0.75);
            --border: rgba(255, 255, 255, 0.08);
            --shadow: 0 8px 24px rgba(0, 0, 0, 0.28);
            --active-bg: rgba(64, 96, 128, 0.36);
        }

        .app-shell {
            height: 100vh;
            display: flex;
            flex-direction: column;
            gap: 12px;
            padding: 16px 20px 16px;
            overflow: hidden;
        }

        /* header */
        .header {
            flex-shrink: 0;
            background: var(--surface);
            backdrop-filter: blur(10px);
            border-radius: 28px;
            padding: 10px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            box-shadow: var(--shadow);
            border: 1px solid var(--border);
        }

        .logo {
            font-size: 22px;
            font-weight: 800;
            color: var(--primary);
            white-space: nowrap;
        }
        .logo i { margin-right: 8px; }

        .search-container {
            display: flex;
            gap: 10px;
            flex: 1;
            justify-content: center;
        }
        .search-box {
            background: var(--surface-soft);
            border-radius: 40px;
            padding: 10px 18px;
            width: 280px;
            display: flex;
            gap: 10px;
            border: 1px solid #dce4ec;
        }
        .search-box input {
            background: none;
            border: none;
            outline: none;
            width: 100%;
            color: var(--page-text);
        }
        .search-btn {
            background: linear-gradient(135deg, var(--primary), var(--primary-2));
            border: none;
            border-radius: 40px;
            padding: 10px 24px;
            color: white;
            font-weight: 600;
            cursor: pointer;
            transition: 0.2s;
        }
        .header-actions {
            display: flex;
            gap: 16px;
            align-items: center;
        }
        .notification-bell {
            position: relative;
            background: var(--surface-soft);
            width: 44px;
            height: 44px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            border: 1px solid var(--border);
        }
        .badge-red {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #dc2626;
            color: white;
            font-size: 10px;
            font-weight: bold;
            padding: 2px 6px;
            border-radius: 50%;
            min-width: 18px;
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
            background: var(--surface-soft);
            padding: 6px 20px;
            border-radius: 40px;
            border: 1px solid var(--border);
        }
        .avatar {
            width: 38px;
            height: 38px;
            background: linear-gradient(135deg, var(--primary), var(--primary-2));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }
        .user-name { font-weight: 700; font-size: 14px; }
        .user-role { font-size: 11px; color: var(--muted); }

        /* main layout */
        .content-shell {
            flex: 1;
            min-height: 0;
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 25px;
            overflow: hidden;
        }

        /* sidebar like student view */
        .sidebar { height: 100%; overflow: hidden; }
        .card {
            background: var(--surface);
            backdrop-filter: blur(10px);
            border-radius: 28px;
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        .sidebar-content { overflow-y: auto; flex: 1; }
        .card-header {
            padding: 18px 22px;
            border-bottom: 1px solid var(--border);
            font-weight: 700;
            color: var(--primary);
        }
        .profile-section {
            text-align: center;
            padding: 24px 16px;
            border-bottom: 1px solid var(--border);
        }
        .profile-avatar {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, var(--primary), var(--primary-2));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 12px;
            font-size: 32px;
            color: white;
        }
        .profile-name { font-size: 18px; font-weight: 800; }
        .profile-email { font-size: 12px; color: var(--muted); margin-top: 4px; }

        .menu-item, .settings-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 22px;
            cursor: pointer;
            width: 100%;
            background: none;
            border: none;
            text-align: left;
            font-size: 14px;
            transition: 0.2s;
            color: var(--page-text);
            border-left: 3px solid transparent;
        }
        .menu-item:hover, .settings-item:hover { background: var(--surface-soft); color: var(--primary); }
        .dropdown-icon { margin-left: auto; font-size: 12px; transition: transform 0.2s; }
        .dropdown-content {
            margin-left: 45px;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease;
        }
        .dropdown-item {
            display: block;
            padding: 10px 22px;
            font-size: 13px;
            cursor: pointer;
            background: none;
            width: 100%;
            text-align: left;
            border: none;
            color: var(--page-text);
        }
        .toggle-switch {
            width: 44px;
            height: 22px;
            background: #dce4ec;
            border-radius: 30px;
            position: relative;
            margin-left: auto;
            cursor: pointer;
        }
        .toggle-switch.active { background: linear-gradient(135deg, var(--primary), var(--primary-2)); }
        .toggle-switch::after {
            content: '';
            width: 18px;
            height: 18px;
            background: white;
            border-radius: 50%;
            position: absolute;
            top: 2px;
            left: 2px;
            transition: 0.2s;
        }
        .toggle-switch.active::after { left: 24px; }

        /* main right column */
        .main-panel { display: flex; flex-direction: column; min-width: 0; }
        .create-post-card {
            background: var(--surface);
            backdrop-filter: blur(10px);
            border-radius: 28px;
            padding: 12px 20px;
            margin-bottom: 20px;
            border: 1px solid var(--border);
            cursor: pointer;
            transition: 0.2s;
        }
        .create-post-header { display: flex; align-items: center; gap: 14px; }
        .create-post-avatar {
            width: 48px; height: 48px;
            background: linear-gradient(135deg, var(--primary), var(--primary-2));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }
        .create-post-input {
            flex: 1;
            background: var(--surface-soft);
            border-radius: 40px;
            padding: 12px 20px;
            color: var(--muted);
        }

        .announcement-board {
            flex: 1;
            overflow-y: auto;
            padding: 6px 4px 16px 4px;
        }
        .announcement-card {
            background: var(--surface-strong);
            border-radius: 28px;
            margin-bottom: 24px;
            border: 1px solid var(--border);
            transition: box-shadow 0.2s;
        }
        .post-header {
            display: flex;
            justify-content: space-between;
            padding: 18px 22px 6px;
        }
        .post-header-left { display: flex; gap: 14px; align-items: center; }
        .post-avatar {
            width: 50px; height: 50px;
            background: linear-gradient(135deg, var(--primary), var(--primary-2));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }
        .post-author { font-weight: 800; }
        .post-meta { font-size: 12px; color: var(--muted); display: flex; gap: 12px; margin-top: 4px; }
        .post-category {
            padding: 2px 10px;
            border-radius: 30px;
            font-size: 10px;
            font-weight: 700;
        }
        .post-category-Exam { background: #e3f2fd; color: #1976d2; }
        .post-category-Suspension { background: #ffebee; color: #c62828; }
        .post-category-Event { background: #e8f5e9; color: #2e7d32; }
        .post-category-General { background: #f3e5f5; color: #7b1fa2; }
        .pin-btn {
            background: none;
            border: none;
            font-size: 18px;
            cursor: pointer;
            color: var(--muted-light);
        }
        .pin-btn.pinned { color: #e65100; }
        .post-content { padding: 0 22px 16px; }
        .post-title { font-size: 18px; font-weight: 800; margin-bottom: 10px; }
        .post-text { line-height: 1.5; margin-bottom: 12px; }
        .post-image img { max-width: 100%; border-radius: 20px; max-height: 280px; object-fit: cover; width: 100%; margin-top: 8px; }

        .post-stats {
            display: flex;
            gap: 24px;
            padding: 8px 22px;
            border-top: 1px solid var(--border);
            border-bottom: 1px solid var(--border);
            color: var(--muted);
            font-size: 13px;
        }
        .post-stats span { display: flex; align-items: center; gap: 6px; cursor: pointer; transition: 0.2s; }
        .action-buttons {
            display: flex;
            gap: 8px;
            padding: 8px 22px 12px;
        }
        .action-btn {
            flex: 1;
            background: none;
            border: none;
            padding: 10px;
            border-radius: 40px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            font-size: 14px;
            color: var(--muted);
            transition: 0.2s;
        }
        .action-btn:hover { background: var(--surface-soft); }
        .action-btn.liked { color: #dc2626; }
        .action-btn.liked i { font-weight: 900; }

        .comments-section {
            padding: 0 22px 20px;
            border-top: 1px solid var(--border);
            display: none;
        }
        .comments-section.show { display: block; }
        .comment-input {
            display: flex;
            gap: 12px;
            margin: 16px 0;
        }
        .comment-input input {
            flex: 1;
            padding: 12px 18px;
            background: var(--surface-soft);
            border: 1px solid var(--border);
            border-radius: 40px;
            outline: none;
        }
        .comment-input button {
            background: var(--primary);
            border: none;
            padding: 0 24px;
            border-radius: 40px;
            color: white;
            font-weight: 600;
            cursor: pointer;
        }
        .comment {
            display: flex;
            gap: 12px;
            padding: 12px 0;
            border-bottom: 1px solid var(--border);
        }
        .comment-avatar {
            width: 34px; height: 34px;
            background: #e8f0fe;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
        }
        .comment-author { font-weight: 700; }
        .comment-time { font-size: 10px; color: var(--muted-light); margin-top: 4px; }

        .notification-dropdown {
            position: absolute;
            top: 85px;
            right: 24px;
            width: 320px;
            background: var(--surface-strong);
            border-radius: 24px;
            box-shadow: var(--shadow);
            display: none;
            z-index: 200;
        }
        .modal {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.5);
            align-items: center;
            justify-content: center;
            z-index: 1000;
        }
        .modal-content {
            background: var(--surface-strong);
            border-radius: 32px;
            max-width: 500px;
            width: 90%;
            padding: 28px;
        }
        .form-group { margin-bottom: 18px; }
        .form-group label { font-weight: 600; display: block; margin-bottom: 6px; }
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 12px;
            border-radius: 20px;
            border: 1px solid var(--border);
            background: var(--surface-soft);
        }
        /* footer removed - no footer element */

        @media (max-width: 860px) {
            .content-shell { grid-template-columns: 1fr; overflow: auto; }
            .app-shell, body { overflow: auto; height: auto; }
        }
        .toast { position: fixed; bottom: 20px; right: 20px; background: #1a3a5c; color: white; padding: 12px 24px; border-radius: 40px; z-index: 9999; animation: fade 2s; }
        @keyframes fade { 0% { opacity: 0; transform: translateY(20px); } 10% { opacity: 1; } 90% { opacity: 1; } 100% { opacity: 0; } }
    </style>
</head>
<body>
<div class="app-shell">
    <div class="header">
        <div class="logo"><i class="fas fa-chalkboard-user"></i> Campus Announcement</div>
        <div class="search-container"><div class="search-box"><i class="fas fa-search"></i><input type="text" id="globalSearchInput" placeholder="Search announcements..."></div><button class="search-btn" onclick="performGlobalSearch()">Search</button></div>
        <div class="header-actions"><div class="notification-bell" onclick="toggleNotificationPanel()"><i class="fas fa-bell"></i><span id="notifBadgeTop" class="badge-red" style="display:none;">0</span></div><div class="user-info"><div class="avatar"><i class="fas fa-user-tie"></i></div><div><div class="user-name" id="teacherName">Prof. Davis</div><div class="user-role">Faculty</div></div></div></div>
    </div>
    <div id="notificationDropdown" class="notification-dropdown"><div class="card-header" style="border:none;"><i class="fas fa-bell"></i> Notifications <button style="float:right; background:none; border:none; color:var(--primary);" onclick="markAllReadNotif()">Mark all read</button></div><div id="notifListContainer" class="notification-list" style="max-height:300px; overflow-y:auto; padding:0 12px 12px;">Loading...</div></div>

    <div class="content-shell">
        <aside class="sidebar"><div class="card"><div class="sidebar-content"><div class="profile-section"><div class="profile-avatar"><i class="fas fa-chalkboard-user"></i></div><div class="profile-name" id="sidebarProfileName">Prof. Emily Davis</div><div class="profile-email">faculty@ctu.edu.ph</div></div><div class="card-header"><i class="fas fa-filter"></i> Filters</div><div class="menu-item" onclick="toggleCategoryMenu()"><i class="fas fa-layer-group"></i> Filter by Category <i class="fas fa-chevron-down dropdown-icon"></i></div><div id="categoryMenu" class="dropdown-content"><button class="dropdown-item" onclick="setFilter('All')">📢 All</button><button class="dropdown-item" onclick="setFilter('Exam')">📚 Exam</button><button class="dropdown-item" onclick="setFilter('Suspension')">🌧️ Suspension</button><button class="dropdown-item" onclick="setFilter('Event')">🎉 Event</button><button class="dropdown-item" onclick="setFilter('General')">📌 General</button></div><div class="menu-item" onclick="setFilter('Pinned')"><i class="fas fa-thumbtack"></i> Pinned Announcements</div><div class="card-header" style="margin-top:8px;"><i class="fas fa-cog"></i> Settings</div><div class="settings-item" onclick="toggleDarkMode()"><i class="fas fa-moon"></i> Dark / Light Mode <div id="themeToggleSide" class="toggle-switch"></div></div><div class="settings-item" onclick="openAboutModal()"><i class="fas fa-info-circle"></i> About Us</div><div class="settings-item" onclick="logoutAction()"><i class="fas fa-sign-out-alt"></i> Logout</div></div></div></aside>

        <main class="main-panel"><div class="create-post-card" onclick="openCreateModal()"><div class="create-post-header"><div class="create-post-avatar"><i class="fas fa-plus-circle"></i></div><div class="create-post-input"><i class="fas fa-edit"></i> Create new announcement ...</div></div></div><div class="card" style="flex:1;"><div class="card-header"><i class="fas fa-bullhorn"></i> Announcement Board <span style="float:right;font-size:12px;">Filter: <span id="activeFilterLabel">All</span></span></div><div id="announcementsContainer" class="announcement-board"><div style="text-align:center;padding:40px;">Loading posts...</div></div></div></main>
    </div>
</div>

<!-- modals -->
<div id="createPostModal" class="modal"><div class="modal-content"><div class="card-header" style="border:none; padding:0 0 12px;">📝 New Announcement</div><div class="form-group"><label>Title</label><input id="newTitle" placeholder="Title"></div><div class="form-group"><label>Category</label><select id="newCategory"><option>General</option><option>Exam</option><option>Suspension</option><option>Event</option></select></div><div class="form-group"><label>Content</label><textarea id="newContent" rows="4" placeholder="Announcement details..."></textarea></div><div class="form-group"><label>Image URL (optional)</label><input id="newImageUrl" placeholder="https://..."></div><div class="modal-buttons" style="display:flex; justify-content:flex-end; gap:10px;"><button class="btn-secondary" onclick="closeCreateModal()">Cancel</button><button class="btn-primary" onclick="publishAnnouncement()" style="background:var(--primary); color:white; border:none; padding:10px 24px; border-radius:40px;">Publish</button></div></div></div>
<div id="aboutModal" class="modal"><div class="modal-content"><div style="font-size:48px; text-align:center;"><i class="fas fa-university"></i></div><div style="font-size:22px; font-weight:800; text-align:center;">Campus Announcement</div><p style="margin:16px 0; text-align:center;">Teacher portal with full interaction: Like, Share, and Comment. Also manage pinned posts.</p><button class="btn-primary" onclick="closeAboutModal()" style="background:var(--primary); width:100%; padding:10px;">Close</button></div></div>

<script>
// ---------- MOCK DATA & HELPER ----------
let currentFilter = "All";
let globalSearch = "";
let teacher = { id: 1, name: "Prof. Emily Davis", email: "emily@ctu.edu.ph" };
let posts = [];
let notifications = [];

function initMockData() {
    posts = [
        { id: 101, title: "Midterm Examination Schedule", content: "Midterms run from Nov 25-30. Check your assigned rooms.", category: "Exam", authorName: teacher.name, createdDate: new Date(2024, 10, 12), likeCount: 14, commentCount: 2, shareCount: 3, isPinned: true, imageUrl: "", likedByCurrent: false, comments: [{ id: 1, author: "Student Mike", text: "Good luck!", date: "Nov 12" }] },
        { id: 102, title: "Class Suspension - Typhoon Warning", content: "No classes tomorrow due to Signal No. 3. Stay indoors.", category: "Suspension", authorName: teacher.name, createdDate: new Date(2024, 10, 13), likeCount: 29, commentCount: 5, shareCount: 12, isPinned: false, imageUrl: "", likedByCurrent: false, comments: [] },
        { id: 103, title: "Campus Talent Fest 2024", content: "Join the annual talent show on December 5 at the gymnasium.", category: "Event", authorName: "Student Council", createdDate: new Date(2024, 10, 10), likeCount: 42, commentCount: 8, shareCount: 9, isPinned: false, imageUrl: "https://picsum.photos/id/20/400/200", likedByCurrent: false, comments: [] },
        { id: 104, title: "Library Extended Hours", content: "Library open until 9 PM during exam week.", category: "General", authorName: "Librarian", createdDate: new Date(2024, 10, 9), likeCount: 10, commentCount: 1, shareCount: 2, isPinned: false, imageUrl: "", likedByCurrent: false, comments: [] }
    ];
    notifications = [{ id: 1, message: "Student liked your exam post", isRead: false, date: new Date() }, { id: 2, message: "New comment on suspension", isRead: false, date: new Date() }];
    updateNotificationUI();
}
initMockData();

function renderPosts() {
    let filtered = [...posts];
    if (currentFilter === "Pinned") filtered = filtered.filter(p => p.isPinned === true);
    else if (currentFilter !== "All") filtered = filtered.filter(p => p.category === currentFilter);
    if (globalSearch.trim()) filtered = filtered.filter(p => p.title.toLowerCase().includes(globalSearch.toLowerCase()) || p.content.toLowerCase().includes(globalSearch.toLowerCase()));
    const container = document.getElementById("announcementsContainer");
    if (!filtered.length) { container.innerHTML = '<div style="text-align:center;padding:60px;"><i class="fas fa-newspaper"></i><p>No announcements match.</p></div>'; return; }
    let html = "";
    filtered.forEach(p => {
        const catClass = `post-category-${p.category}`;
        const pinnedClass = p.isPinned ? "pinned" : "";
        const pinIcon = p.isPinned ? "fas fa-thumbtack" : "far fa-thumbtack";
        const likedClass = p.likedByCurrent ? "liked" : "";
        const likeIcon = p.likedByCurrent ? "fas fa-heart" : "far fa-heart";
        const likeText = p.likedByCurrent ? "Liked" : "Like";
        const imageHtml = p.imageUrl ? `<div class="post-image"><img src="${escapeHtml(p.imageUrl)}" onerror="this.style.display='none'"></div>` : "";
        html += `<div class="announcement-card" data-post-id="${p.id}">
                        <div class="post-header"><div class="post-header-left"><div class="post-avatar"><i class="fas fa-chalkboard-user"></i></div><div><div class="post-author">${escapeHtml(p.authorName)}</div><div class="post-meta"><span><i class="far fa-calendar"></i> ${formatDate(p.createdDate)}</span><span class="post-category ${catClass}">${p.category}</span></div></div></div><button class="pin-btn ${pinnedClass}" onclick="togglePin(${p.id})"><i class="${pinIcon}"></i></button></div>
                        <div class="post-content"><div class="post-title">${escapeHtml(p.title)}</div><div class="post-text">${escapeHtml(p.content)}</div>${imageHtml}</div>
                        <div class="post-stats"><span onclick="likePost(${p.id})"><i class="far fa-heart"></i> <span class="like-count-${p.id}">${p.likeCount}</span> Likes</span><span onclick="scrollToCommentSection(${p.id})"><i class="far fa-comment"></i> <span class="comment-count-${p.id}">${p.commentCount}</span> Comments</span><span onclick="sharePost(${p.id})"><i class="fas fa-share-alt"></i> <span class="share-count-${p.id}">${p.shareCount || 0}</span> Shares</span></div>
                        <div class="action-buttons"><button class="action-btn ${likedClass}" id="likeBtn_${p.id}" onclick="likePost(${p.id})"><i class="${likeIcon}"></i> ${likeText}</button><button class="action-btn" onclick="toggleCommentsPanel(${p.id})"><i class="far fa-comment"></i> Comment</button><button class="action-btn" onclick="sharePost(${p.id})"><i class="fas fa-share-alt"></i> Share</button></div>
                        <div class="comments-section" id="commentsSection_${p.id}"><div class="comment-input"><input type="text" id="commentInput_${p.id}" placeholder="Write a comment..."><button onclick="addComment(${p.id})">Post</button></div><div id="commentsList_${p.id}" class="comments-list">${renderComments(p.comments || [])}</div></div>
                    </div>`;
    });
    container.innerHTML = html;
    document.getElementById("activeFilterLabel").innerText = currentFilter === "Pinned" ? "Pinned" : currentFilter;
}

function renderComments(comments) { if (!comments.length) return '<div class="no-comments" style="padding:12px 0; color:var(--muted-light);">No comments yet. Be first!</div>'; return comments.map(c => `<div class="comment"><div class="comment-avatar"><i class="fas fa-user"></i></div><div><div class="comment-author">${escapeHtml(c.author)}</div><div class="comment-text">${escapeHtml(c.text)}</div><div class="comment-time">${c.date || "just now"}</div></div></div>`).join(""); }

function formatDate(d) { return d.toLocaleDateString('en-US', { month: 'short', day: 'numeric' }); }
function escapeHtml(str) { if (!str) return ''; return str.replace(/[&<>]/g, function(m) { if (m === '&') return '&amp;'; if (m === '<') return '&lt;'; if (m === '>') return '&gt;'; return m; }); }

// Interactions: LIKE, SHARE, COMMENT
function likePost(postId) {
    let post = posts.find(p => p.id === postId);
    if (!post) return;
    if (post.likedByCurrent) { post.likeCount--; post.likedByCurrent = false; } else { post.likeCount++; post.likedByCurrent = true; addNotification(`You liked "${post.title}"`); }
    renderPosts();
}

function sharePost(postId) {
    let post = posts.find(p => p.id === postId);
    if (post) { post.shareCount = (post.shareCount || 0) + 1; addNotification(`You shared "${post.title}"`); renderPosts(); showToast("✅ Shared successfully!"); }
}

function addComment(postId) {
    let input = document.getElementById(`commentInput_${postId}`);
    let text = input?.value.trim();
    if (!text) { showToast("Write a comment first"); return; }
    let post = posts.find(p => p.id === postId);
    if (post) { let newComment = { id: Date.now(), author: teacher.name, text: text, date: "Just now" }; post.comments = post.comments || []; post.comments.push(newComment); post.commentCount = post.comments.length; addNotification(`New comment on "${post.title}"`); renderPosts(); showToast("💬 Comment added"); }
    input.value = "";
}

function toggleCommentsPanel(postId) { let sec = document.getElementById(`commentsSection_${postId}`); if (sec) sec.classList.toggle("show"); }
function scrollToCommentSection(postId) { let sec = document.getElementById(`commentsSection_${postId}`); if (sec) { sec.classList.add("show"); sec.scrollIntoView({ behavior: "smooth", block: "nearest" }); } }

// Post creation
function openCreateModal() { document.getElementById("createPostModal").style.display = "flex"; }
function closeCreateModal() { document.getElementById("createPostModal").style.display = "none"; }
function publishAnnouncement() {
    let title = document.getElementById("newTitle").value.trim();
    let content = document.getElementById("newContent").value.trim();
    let category = document.getElementById("newCategory").value;
    let imageUrl = document.getElementById("newImageUrl").value.trim();
    if (!title || !content) { showToast("Title and content required"); return; }
    let newPost = { id: Date.now(), title, content, category, authorName: teacher.name, createdDate: new Date(), likeCount: 0, commentCount: 0, shareCount: 0, isPinned: false, imageUrl, likedByCurrent: false, comments: [] };
    posts.unshift(newPost);
    closeCreateModal();
    document.getElementById("newTitle").value = "";
    document.getElementById("newContent").value = "";
    document.getElementById("newImageUrl").value = "";
    renderPosts();
    addNotification("Your announcement has been posted!");
    showToast("Announcement published!");
}

function togglePin(postId) { let post = posts.find(p => p.id === postId); if (post) { post.isPinned = !post.isPinned; renderPosts(); showToast(post.isPinned ? "📌 Pinned" : "Unpinned"); } }
function setFilter(filter) { currentFilter = filter; globalSearch = ""; document.getElementById("globalSearchInput").value = ""; renderPosts(); let catMenu = document.getElementById("categoryMenu"); if (catMenu) catMenu.style.maxHeight = "0px"; }
function performGlobalSearch() { globalSearch = document.getElementById("globalSearchInput").value; renderPosts(); }
function toggleCategoryMenu() { let menu = document.getElementById("categoryMenu"); if (menu.style.maxHeight && menu.style.maxHeight !== "0px") menu.style.maxHeight = "0px"; else menu.style.maxHeight = menu.scrollHeight + "px"; }

// Notifications
function addNotification(msg) { notifications.unshift({ id: Date.now(), message: msg, isRead: false, date: new Date() }); updateNotificationUI(); showToast(msg); }
function updateNotificationUI() { let unread = notifications.filter(n => !n.isRead).length; let badge = document.getElementById("notifBadgeTop"); if (badge) { if (unread > 0) { badge.innerText = unread; badge.style.display = "inline-block"; } else badge.style.display = "none"; } let container = document.getElementById("notifListContainer"); if (container) { if (!notifications.length) container.innerHTML = "<div style='padding:15px;'>No notifications</div>"; else container.innerHTML = notifications.map(n => `<div class="notification-item ${!n.isRead ? 'unread' : ''}" style="padding:12px; border-bottom:1px solid var(--border); cursor:pointer;" onclick="markRead(${n.id})"><div>${escapeHtml(n.message)}</div><div style="font-size:10px;">Just now</div></div>`).join(""); } }
function markRead(id) { let n = notifications.find(no => no.id === id); if (n) n.isRead = true; updateNotificationUI(); }
function markAllReadNotif() { notifications.forEach(n => n.isRead = true); updateNotificationUI(); showToast("All marked read"); }
function toggleNotificationPanel() { document.getElementById("notificationDropdown").classList.toggle("show"); }

// Theme, modals, logout
function toggleDarkMode() { document.body.classList.toggle("dark-mode"); let toggle = document.getElementById("themeToggleSide"); if (toggle) toggle.classList.toggle("active"); localStorage.setItem("teacherTheme", document.body.classList.contains("dark-mode") ? "dark" : "light"); }
function loadThemePref() { if (localStorage.getItem("teacherTheme") === "dark") { document.body.classList.add("dark-mode"); document.getElementById("themeToggleSide")?.classList.add("active"); } }
function openAboutModal() { document.getElementById("aboutModal").style.display = "flex"; }
function closeAboutModal() { document.getElementById("aboutModal").style.display = "none"; }
function logoutAction() { if (confirm("Logout from faculty portal?")) window.location.href = "login.aspx"; }
function showToast(msg) { let t = document.createElement("div"); t.className = "toast"; t.innerText = msg; document.body.appendChild(t); setTimeout(() => t.remove(), 2500); }

window.onclick = function(e) { let modal = document.getElementById("createPostModal"); if (e.target === modal) closeCreateModal(); let about = document.getElementById("aboutModal"); if (e.target === about) closeAboutModal(); let notifDrop = document.getElementById("notificationDropdown"); if (notifDrop && !document.querySelector(".notification-bell")?.contains(e.target) && !notifDrop.contains(e.target)) notifDrop.classList.remove("show"); };
document.getElementById("sidebarProfileName").innerText = teacher.name;
document.getElementById("teacherName").innerText = teacher.name.split(" ")[0];
loadThemePref();
renderPosts();
updateNotificationUI();
</script>
</body>
</html>