<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Teacher.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Teacher" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes" />
    <title>Campus Announcement - Teacher Portal | Like, Share & Comment</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        /* Combined, cleaned CSS from both branches */
        * { margin:0; padding:0; box-sizing:border-box; }
        :root{
            --bg-image: url('wbg.jpg');
            --page-text:#1a2a3a;
            --surface:rgba(255,255,255,0.92);
            --surface-strong:#ffffff;
            --surface-soft:#f8fafc;
            --border:rgba(26,58,92,0.12);
            --primary:#1a3a5c;
            --primary-2:#2c5a7a;
            --muted:#6b7c8f;
            --muted-light:#9db0c4;
            --shadow:0 8px 24px rgba(0,0,0,0.08);
            --active-bg:#e8f0fe;
        }
        html,body { height:100%; font-family:"Segoe UI", system-ui, -apple-system, sans-serif; color:var(--page-text); }
        body {
            background-image: linear-gradient(rgba(255,255,255,0.3), rgba(255,255,255,0.3)), var(--bg-image);
            background-size:cover; background-position:center; background-attachment:fixed;
            transition: background 0.3s ease, color 0.3s;
            overflow:hidden;
        }
        body.dark-mode {
            --bg-image: url('bg.jpg');
            --page-text:#e4e6eb;
            --surface:rgba(33,38,45,0.9);
            --surface-strong:rgba(39,44,52,0.96);
            --surface-soft:rgba(56,62,72,0.75);
            --border:rgba(255,255,255,0.08);
            --shadow:0 8px 24px rgba(0,0,0,0.28);
            --active-bg:rgba(64,96,128,0.36);
        }

        .app-shell { height:100vh; display:flex; flex-direction:column; gap:12px; padding:16px 20px; overflow:hidden; }

        .header {
            flex-shrink:0;
            background:var(--surface);
            backdrop-filter: blur(10px);
            border-radius:28px;
            padding:10px 24px;
            display:flex;
            justify-content:space-between;
            align-items:center;
            gap:16px;
            box-shadow:var(--shadow);
            border:1px solid var(--border);
        }
        .logo { font-size:22px; font-weight:800; color:var(--primary); display:flex; align-items:center; gap:12px; }
        .logo i { margin-right:8px; color:var(--primary); }

        /* Single search button */
        .single-search-btn {
            background:#f0f2f5;
            border:1px solid rgba(26,58,92,0.2);
            border-radius:48px;
            padding:12px 24px;
            min-width:280px;
            color:#0F172A;
            font-weight:500;
            cursor:pointer;
            display:flex;
            align-items:center;
            justify-content:center;
            gap:12px;
            font-family:inherit;
        }
        .single-search-btn i { font-size:16px; color:var(--primary); }
        .single-search-btn:hover { background:#e8f0fe; border-color:rgba(26,58,92,0.4); transform:translateY(-1px); }

        .header-actions { display:flex; gap:16px; align-items:center; }
        .notification-bell { position:relative; background:var(--surface-soft); width:44px; height:44px; border-radius:50%; display:flex; align-items:center; justify-content:center; cursor:pointer; border:1px solid var(--border); }
        .badge-red { position:absolute; top:-5px; right:-5px; background:#dc2626; color:white; font-size:10px; font-weight:700; padding:2px 6px; border-radius:50%; min-width:18px; text-align:center; }

        .user-info { display:flex; gap:12px; align-items:center; background:var(--surface-soft); padding:6px 20px; border-radius:40px; border:1px solid var(--border); }
        .avatar { width:38px; height:38px; background:linear-gradient(135deg,var(--primary),var(--primary-2)); border-radius:50%; display:flex; align-items:center; justify-content:center; color:white; }
        .user-details { display:flex; flex-direction:column; color:var(--page-text); }
        .user-name { font-weight:600; }
        .user-role { font-size:11px; color:var(--muted); }

        /* layout */
        .main-layout { display:grid; grid-template-columns:300px 1fr; gap:25px; flex:1; min-height:0; overflow:hidden; }

        /* sidebar */
        .sidebar .card { height:100%; display:flex; flex-direction:column; border-radius:28px; background:var(--surface); border:1px solid var(--border); box-shadow:var(--shadow); overflow:hidden; }
        .sidebar-content { overflow-y:auto; padding:0; flex:1; }
        .profile-section { text-align:center; padding:24px 16px; border-bottom:1px solid var(--border); }
        .profile-avatar { width:80px; height:80px; border-radius:50%; background:linear-gradient(135deg,var(--primary),var(--primary-2)); display:flex; align-items:center; justify-content:center; color:white; font-size:32px; margin:0 auto 12px; }
        .profile-name { font-size:18px; font-weight:800; }
        .profile-email { font-size:12px; color:var(--muted); margin-top:4px; }

        .card-header { padding:18px 22px; border-bottom:1px solid var(--border); font-weight:700; color:var(--primary); }
        .menu-item, .settings-item { display:flex; align-items:center; gap:12px; padding:14px 22px; cursor:pointer; width:100%; background:none; border:none; text-align:left; font-size:14px; color:var(--page-text); border-left:3px solid transparent; transition:0.2s; }
        .menu-item:hover, .settings-item:hover { background:var(--surface-soft); color:var(--primary); }
        .dropdown-icon { margin-left:auto; font-size:12px; transition:transform 0.2s; }
        .dropdown-content { margin-left:45px; max-height:0; overflow:hidden; transition:max-height 0.25s ease; }

        .toggle-switch { width:44px; height:22px; background:#dce4ec; border-radius:30px; position:relative; margin-left:auto; cursor:pointer; }
        .toggle-switch.active { background:linear-gradient(135deg,var(--primary),var(--primary-2)); }
        .toggle-switch::after { content:''; width:18px; height:18px; background:white; border-radius:50%; position:absolute; top:2px; left:2px; transition:0.2s; }
        .toggle-switch.active::after { left:24px; }

        /* main panel */
        .main-panel { display:flex; flex-direction:column; min-width:0; }
        .create-post-card { border-radius:28px; padding:12px 20px; margin-bottom:20px; border:1px solid var(--border); background:var(--surface); cursor:pointer; }
        .create-post-avatar { width:48px; height:48px; border-radius:50%; background:linear-gradient(135deg,var(--primary),var(--primary-2)); display:flex; align-items:center; justify-content:center; color:white; }
        .create-post-input { flex:1; background:var(--surface-soft); border-radius:40px; padding:12px 20px; color:var(--muted); }

        .announcement-board { flex:1; overflow-y:auto; padding:6px 4px 16px 4px; }
        .announcement-card { background:var(--surface-strong); border-radius:28px; margin-bottom:24px; border:1px solid var(--border); transition:box-shadow 0.2s; overflow:hidden; }
        .post-header { display:flex; justify-content:space-between; padding:18px 22px 6px; }
        .post-header-left { display:flex; gap:14px; align-items:center; }
        .post-avatar { width:50px; height:50px; border-radius:50%; background:linear-gradient(135deg,var(--primary),var(--primary-2)); display:flex; align-items:center; justify-content:center; color:white; }
        .post-author { font-weight:800; }
        .post-meta { font-size:12px; color:var(--muted); display:flex; gap:12px; margin-top:4px; }
        .post-category { padding:2px 10px; border-radius:30px; font-size:10px; font-weight:700; }
        .post-content { padding:0 22px 16px; }
        .post-title { font-size:18px; font-weight:800; margin-bottom:10px; }
        .post-text { line-height:1.5; margin-bottom:12px; }
        .post-image img { max-width:100%; border-radius:20px; max-height:280px; object-fit:cover; width:100%; margin-top:8px; }

        .post-stats { display:flex; gap:24px; padding:8px 22px; border-top:1px solid var(--border); border-bottom:1px solid var(--border); color:var(--muted); font-size:13px; }
        .action-buttons { display:flex; gap:8px; padding:8px 22px 12px; }
        .action-btn { flex:1; background:none; border:none; padding:10px; border-radius:40px; cursor:pointer; display:flex; align-items:center; justify-content:center; gap:8px; font-size:14px; color:var(--muted); transition:0.2s; }
        .action-btn:hover { background:var(--surface-soft); }
        .action-btn.liked { color:#dc2626; }

        .comments-section { padding:0 22px 20px; border-top:1px solid var(--border); display:none; }
        .comments-section.show { display:block; }
        .comment-input { display:flex; gap:12px; margin:16px 0; }
        .comment-input input { flex:1; padding:12px 18px; background:var(--surface-soft); border:1px solid var(--border); border-radius:40px; outline:none; }
        .comment-input button { background:var(--primary); border:none; padding:0 24px; border-radius:40px; color:white; font-weight:600; cursor:pointer; }

        .notification-dropdown { position:absolute; top:85px; right:24px; width:320px; background:var(--surface-strong); border-radius:24px; box-shadow:var(--shadow); display:none; z-index:200; }
        .modal { display:none; position:fixed; inset:0; background:rgba(0,0,0,0.5); align-items:center; justify-content:center; z-index:1000; }
        .modal-content { background:var(--surface-strong); border-radius:32px; max-width:500px; width:90%; padding:28px; }

        @media (max-width:900px){ .main-layout{ grid-template-columns:1fr; } .single-search-btn{ min-width:200px; padding:10px 18px; font-size:13px; } .header{ flex-direction:column; align-items:stretch; } }
        .toast{ position:fixed; bottom:20px; right:20px; background:#1a3a5c; color:white; padding:12px 24px; border-radius:40px; z-index:9999; animation:fade 2s; }
        @keyframes fade{ 0%{ opacity:0; transform:translateY(20px);} 10%{ opacity:1;} 90%{ opacity:1;} 100%{ opacity:0;} }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="app-shell">
            <div class="header">
                <div class="logo"><i class="fas fa-chalkboard-teacher"></i> CampusConnect Teacher</div>

                <asp:Button ID="searchBtn" runat="server"
                    CssClass="single-search-btn"
                    Text="🔎 Search........"
                    OnClientClick="performSearchAndRedirect(); return false;"
                    UseSubmitBehavior="false" Width="471px" />

                <div class="header-actions">
                    <div class="notification-bell" onclick="toggleNotificationDropdown()">
                        <i class="fas fa-bell bell-icon"></i>
                        <span id="notificationBadge" class="badge-red" style="display:none;">0</span>
                    </div>

                    <div class="user-info">
                        <div class="avatar"><i class="fas fa-user"></i></div>
                        <div class="user-details">
                            <div class="user-name" id="teacherName">Prof. Emily Davis</div>
                            <div class="user-role">Faculty</div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="notificationDropdown" class="notification-dropdown">
                <div class="card-header" style="border:none;"><i class="fas fa-bell"></i> Notifications <button style="float:right;background:none;border:none;color:var(--primary);" onclick="markAllRead()">Mark all read</button></div>
                <div id="notifListContainer" class="notification-list" style="max-height:300px; overflow-y:auto; padding:0 12px 12px;">
                    <div style="padding:15px;">Loading...</div>
                </div>
            </div>

            <div class="main-layout">
                <aside class="sidebar">
                    <div class="card">
                        <div class="sidebar-content">
                            <div class="profile-section">
                                <div class="profile-avatar"><i class="fas fa-chalkboard-user"></i></div>
                                <div class="profile-name" id="sidebarProfileName">Prof. Emily Davis</div>
                                <div class="profile-email">faculty@ctu.edu.ph</div>
                            </div>

                            <div class="card-header"><i class="fas fa-filter"></i> Filters</div>

                            <button type="button" class="menu-item" onclick="toggleDropdown('categoryDropdown')">
                                <i class="fas fa-layer-group"></i> Filter by Category
                                <i class="fas fa-chevron-down dropdown-icon"></i>
                            </button>
                            <div id="categoryDropdown" class="dropdown-content">
                                <button type="button" class="dropdown-item" onclick="filterCategory('All')">All Announcements</button>
                                <button type="button" class="dropdown-item" onclick="filterCategory('Exam')">Exam Schedule</button>
                                <button type="button" class="dropdown-item" onclick="filterCategory('Suspension')">Class Suspension</button>
                                <button type="button" class="dropdown-item" onclick="filterCategory('Event')">Campus Events</button>
                            </div>

                            <button type="button" class="menu-item" onclick="setFilter('Pinned')">
                                <i class="fas fa-thumbtack"></i> Pinned Announcements
                            </button>

                            <div class="card-header" style="margin-top:8px;"><i class="fas fa-cog"></i> Settings</div>

                            <button type="button" class="settings-item" onclick="toggleTheme(this)" title="Toggle dark / light theme">
                                <i class="fas fa-moon"></i>
                                <span>Dark / Light Mode</span>
                                <div id="themeToggleSide" class="toggle-switch" role="switch" aria-checked="false"></div>
                            </button>

                            <button type="button" class="settings-item" onclick="openAboutModal()"><i class="fas fa-info-circle"></i> About Us</button>
                            <button type="button" class="settings-item" onclick="logout()"><i class="fas fa-sign-out-alt"></i> Logout</button>
                        </div>
                    </div>
                </aside>

                <main class="main-panel">
                    <div class="create-post-card" onclick="openCreateModal()">
                        <div class="create-post-header">
                            <div class="create-post-avatar"><i class="fas fa-plus-circle"></i></div>
                            <div class="create-post-input"><i class="fas fa-edit"></i> Create new announcement ...</div>
                        </div>
                    </div>

                    <div class="card" style="flex:1;">
                        <div class="card-header"><i class="fas fa-bullhorn"></i> Announcement Board <span style="float:right;font-size:12px;">Filter: <span id="activeFilterLabel">All</span></span></div>
                        <div id="announcementsContainer" class="announcement-board">
                            <div style="text-align:center;padding:40px;">Loading posts...</div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <!-- Create / About modals -->
        <div id="createPostModal" class="modal"><div class="modal-content"><div class="card-header" style="border:none; padding:0 0 12px;">📝 New Announcement</div><div class="form-group"><label>Title</label><input id="newTitle" placeholder="Title"></div><div class="form-group"><label>Category</label><select id="newCategory"><option>General</option><option>Exam</option><option>Suspension</option><option>Event</option></select></div><div class="form-group"><label>Content</label><textarea id="newContent" rows="4" placeholder="Announcement details..."></textarea></div><div class="form-group"><label>Image URL (optional)</label><input id="newImageUrl" placeholder="https://..."></div><div style="display:flex; justify-content:flex-end; gap:10px;"><button onclick="closeCreateModal()" class="btn-secondary">Cancel</button><button onclick="publishAnnouncement()" class="btn-primary" style="background:var(--primary); color:white; border:none; padding:10px 24px; border-radius:40px;">Publish</button></div></div></div>

        <div id="aboutModal" class="modal"><div class="modal-content"><div class="modal-icon"><i class="fas fa-university"></i></div><div class="modal-title">Campus Connect</div><div class="modal-text">Campus Connect is a centralized announcement system for Cebu Technological University.</div><button type="button" class="modal-close" onclick="closeAboutModal()">Close</button></div></div>
    </form>

    <script>
        // Small client-side logic to make the page interactive and remove conflict remnants
        function performSearchAndRedirect() {
            window.location.href = 'SearchDashboard.aspx?query=' + encodeURIComponent('');
        }

        function toggleDropdown(id) {
            var el = document.getElementById(id);
            if (!el) return;
            if (el.style.maxHeight && el.style.maxHeight !== "0px") {
                el.style.maxHeight = "0px";
            } else {
                el.style.maxHeight = el.scrollHeight + "px";
            }
        }

        function toggleNotificationDropdown() {
            var d = document.getElementById('notificationDropdown');
            if (d) d.classList.toggle('show');
        }

        // Filters
        function filterCategory(category) {
            var cards = document.querySelectorAll('.announcement-card');
            document.getElementById('activeFilterLabel').innerText = category;
            cards.forEach(function (card) {
                card.style.display = (category === 'All' || card.dataset.category === category) ? 'block' : 'none';
            });
            var dd = document.getElementById('categoryDropdown');
            if (dd) dd.style.maxHeight = '0px';
        }

        // Mock data + render (keeps UI usable)
        const teacher = { id: 1, name: 'Prof. Emily Davis', email: 'faculty@ctu.edu.ph' };
        let posts = [
            { id: 1, title: "Final Exam Schedule", content: "Final exams Dec 15-20. Check your department.", category: "Exam", authorName: teacher.name, createdDate: new Date(), likeCount: 24, commentCount: 2, shareCount:5, isPinned:true, comments:[] },
            { id: 2, title: "Library Hours Extended", content: "Library open until midnight during exams.", category: "Event", authorName: "Student Affairs", createdDate: new Date(), likeCount:8, commentCount:1, shareCount:1, isPinned:false, comments:[] }
        ];

        function renderPosts() {
            const container = document.getElementById('announcementsContainer');
            if (!container) return;
            if (!posts.length) { container.innerHTML = '<div style="text-align:center;padding:40px;">No posts</div>'; return; }
            let html = posts.map(p => {
                return `<div class="announcement-card" data-category="${p.category}">
                    <div class="post-header">
                        <div class="post-header-left">
                            <div class="post-avatar"><i class="fas fa-chalkboard-user"></i></div>
                            <div>
                                <div class="post-author">${escapeHtml(p.authorName)}</div>
                                <div class="post-meta"><span><i class="far fa-calendar-alt"></i> ${formatDate(p.createdDate)}</span><span class="post-category">${escapeHtml(p.category)}</span></div>
                            </div>
                        </div>
                        <button type="button" class="pin-btn-top ${p.isPinned ? 'pinned' : ''}" onclick="togglePinTop(this, ${p.id})"><i class="fas fa-thumbtack"></i></button>
                    </div>
                    <div class="post-content">
                        <div class="post-title">${escapeHtml(p.title)}</div>
                        <div class="post-text">${escapeHtml(p.content)}</div>
                    </div>
                    <div class="post-stats">
                        <span onclick="toggleLikeFromStats(this)"><i class="far fa-heart"></i> <span class="like-count">${p.likeCount}</span> Likes</span>
                        <span onclick="scrollToComments(this)"><i class="far fa-comment"></i> <span class="comment-count">${p.commentCount}</span> Comments</span>
                        <span onclick="sharePost(${p.id})"><i class="far fa-share-square"></i> <span class="share-count">${p.shareCount}</span> Shares</span>
                    </div>
                    <div class="action-buttons">
                        <button type="button" class="action-btn" onclick="toggleLike(this, ${p.id})"><i class="far fa-heart"></i> Like</button>
                        <button type="button" class="action-btn" onclick="toggleComments(this, ${p.id})"><i class="far fa-comment"></i> Comment</button>
                        <button type="button" class="action-btn" onclick="sharePost(${p.id})"><i class="fas fa-share"></i> Share</button>
                    </div>
                    <div class="comments-section" id="commentsSection_${p.id}">
                        <div class="comment-input">
                            <input type="text" id="commentInput_${p.id}" placeholder="Write a comment...">
                            <button onclick="addComment(${p.id})">Post</button>
                        </div>
                        <div id="commentsList_${p.id}" class="comments-list">${renderComments(p.comments)}</div>
                    </div>
                </div>`;
            }).join('');
            container.innerHTML = html;
            document.getElementById('sidebarProfileName').innerText = teacher.name;
            const teacherNameEl = document.getElementById('teacherName');
            if (teacherNameEl) teacherNameEl.innerText = teacher.name;
            updateNotificationUI();
        }

        function renderComments(comments) { if (!comments || !comments.length) return '<div class="no-comments" style="padding:12px 0; color:var(--muted-light);">No comments yet.</div>'; return comments.map(c => `<div class="comment"><div class="comment-avatar"><i class="fas fa-user"></i></div><div><div class="comment-author">${escapeHtml(c.author)}</div><div class="comment-text">${escapeHtml(c.text)}</div><div class="comment-time">${c.date || 'Just now'}</div></div></div>`).join(''); }
        function formatDate(d) { try { return new Date(d).toLocaleDateString('en-US', { month: 'short', day: 'numeric' }); } catch (e) { return ''; } }
        function escapeHtml(s) { if (!s) return ''; return s.replace(/[&<>"]/g, function (m) { if (m == '&') return '&amp;'; if (m == '<') return '&lt;'; if (m == '>') return '&gt;'; if (m == '"') return '&quot;'; return m; }); }

        // interactions
        function toggleLike(btn, postId) { var p = posts.find(x => x.id === postId); if (!p) return; p.likedByCurrent = !p.likedByCurrent; p.likeCount += p.likedByCurrent ? 1 : -1; renderPosts(); }
        function toggleLikeFromStats(span) { var card = span.closest('.announcement-card'); var btn = card.querySelector('.action-btn'); if (btn) btn.click(); }
        function toggleComments(btn, postId) { var sec = document.getElementById('commentsSection_' + postId); if (sec) sec.classList.toggle('show'); }
        function scrollToComments(el) { var card = el.closest('.announcement-card'); var sec = card.querySelector('.comments-section'); if (sec) { sec.classList.add('show'); sec.scrollIntoView({ behavior: 'smooth', block: 'nearest' }); } }
        function sharePost(id) { showToast('Shared'); var p = posts.find(x => x.id === id); if (p) p.shareCount = (p.shareCount || 0) + 1; renderPosts(); }
        function addComment(postId) { var input = document.getElementById('commentInput_' + postId); var txt = input.value.trim(); if (!txt) { showToast('Write a comment first'); return; } var p = posts.find(x => x.id === postId); if (p) { p.comments = p.comments || []; p.comments.push({ author: teacher.name, text: txt, date: 'Just now' }); p.commentCount = p.comments.length; renderPosts(); showToast('Comment added'); } }

        function togglePinTop(btn, postId) { var p = posts.find(x => x.id === postId); if (p) { p.isPinned = !p.isPinned; renderPosts(); showToast(p.isPinned ? 'Pinned' : 'Unpinned'); } }

        // create post modal
        function openCreateModal() { document.getElementById('createPostModal').style.display = 'flex'; }
        function closeCreateModal() { document.getElementById('createPostModal').style.display = 'none'; }
        function publishAnnouncement() { var title = document.getElementById('newTitle').value.trim(); var content = document.getElementById('newContent').value.trim(); var category = document.getElementById('newCategory').value; var img = document.getElementById('newImageUrl').value.trim(); if (!title || !content) { showToast('Title and content required'); return; } posts.unshift({ id: Date.now(), title: title, content: content, category: category, authorName: teacher.name, createdDate: new Date(), likeCount: 0, commentCount: 0, shareCount: 0, isPinned: false, comments: [] }); closeCreateModal(); renderPosts(); showToast('Announcement published!'); }

        // notifications (simple)
        let notifications = [];
        function updateNotificationUI() { var unread = notifications.filter(n => !n.isRead).length; var badge = document.getElementById('notificationBadge'); if (badge) { if (unread > 0) { badge.innerText = unread; badge.style.display = 'inline-block'; } else badge.style.display = 'none'; } var container = document.getElementById('notifListContainer'); if (container) { if (!notifications.length) container.innerHTML = '<div style="padding:15px;">No notifications</div>'; else container.innerHTML = notifications.map(n => `<div class="notification-item ${n.isRead ? '' : 'unread'}" style="padding:12px; border-bottom:1px solid var(--border); cursor:pointer;" onclick="markRead(${n.id})"><div>${escapeHtml(n.message)}</div><div style="font-size:10px;">Just now</div></div>`).join(''); } }
        function addNotification(msg) { notifications.unshift({ id: Date.now(), message: msg, isRead: false }); updateNotificationUI(); }
        function markRead(id) { var n = notifications.find(x => x.id === id); if (n) n.isRead = true; updateNotificationUI(); }
        function markAllRead() { notifications.forEach(n => n.isRead = true); updateNotificationUI(); showToast('All marked read'); }
        function toggleNotificationPanel() { document.getElementById('notificationDropdown').classList.toggle('show'); }

        // theme
        function toggleTheme(el) { var isDark = document.body.classList.toggle('dark-mode'); var t = document.getElementById('themeToggleSide'); if (t) t.classList.toggle('active', isDark); try { localStorage.setItem('teacherTheme', isDark ? 'dark' : 'light'); } catch (e) { } }
        function loadThemePref() { try { if (localStorage.getItem('teacherTheme') === 'dark') { document.body.classList.add('dark-mode'); document.getElementById('themeToggleSide')?.classList.add('active'); } } catch (e) { } }

        // utilities
        function showToast(msg) { var t = document.createElement('div'); t.className = 'toast'; t.innerText = msg; document.body.appendChild(t); setTimeout(() => t.remove(), 2500); }

        // init
        (function init() { notifications = [{ id: 1, message: 'New exam schedule announced', isRead: false }]; loadThemePref(); renderPosts(); updateNotificationUI(); })();

        // close dropdowns / modals on outside click
        window.onclick = function (e) {
            var notif = document.getElementById('notificationDropdown');
            var bell = document.querySelector('.notification-bell');
            if (notif && bell && !bell.contains(e.target) && !notif.contains(e.target)) notif.classList.remove('show');
        };
    </script>
</body>
</html>