<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Notifications.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Notifications" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Notifications — Campus Connect</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }

        :root {
            --bg-image: url('wbg.jpg');
            --page-text: #1a2a3a;
            --surface: rgba(255,255,255,0.93);
            --surface-strong: #ffffff;
            --surface-soft: #f0f5ff;
            --border: rgba(26,58,92,0.12);
            --primary: #1a3a5c;
            --primary-2: #2563eb;
            --muted: #6b7c8f;
            --muted-light: #9db0c4;
            --shadow: 0 8px 24px rgba(0,0,0,0.08);
            --active-bg: #e8f0fe;
        }

        body {
            min-height: 100vh;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            color: var(--page-text);
            background-image: linear-gradient(rgba(255,255,255,0.16),rgba(255,255,255,0.16)), var(--bg-image);
            background-size: cover; background-attachment: fixed;
            transition: background 0.3s, color 0.3s;
        }

        .page-shell { min-height:100vh; padding:32px 20px 60px; }
        .page-wrap  { max-width:640px; margin:0 auto; display:flex; flex-direction:column; gap:16px; }

        /* ── Topbar ── */
        .topbar {
            background: var(--surface); backdrop-filter: blur(14px);
            border: 1px solid var(--border); border-radius: 20px;
            padding: 14px 20px; display: flex; align-items: center;
            justify-content: space-between; box-shadow: var(--shadow);
        }
        .topbar-title { display:flex; align-items:center; gap:10px; font-size:18px; font-weight:800; color:var(--primary); }
        .topbar-title i { color:var(--primary-2); }
        .back-btn {
            width:40px; height:40px; border-radius:50%;
            background:linear-gradient(135deg,#1a3a5c,#2563eb);
            color:#fff; border:none; cursor:pointer; text-decoration:none;
            display:flex; align-items:center; justify-content:center;
            box-shadow:var(--shadow); transition:transform .2s;
        }
        .back-btn:hover { transform:translateY(-2px); }

        /* ── Notification item (teaser) ── */
        .notif-item {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 18px;
            box-shadow: var(--shadow);
            overflow: hidden;
            transition: box-shadow 0.2s, border-color 0.2s;
        }
        .notif-item:hover { box-shadow: 0 12px 28px rgba(0,0,0,0.1); border-color: var(--primary-2); }
        .notif-item.unread { border-left: 4px solid var(--primary-2); }

        .notif-teaser {
            display: flex; align-items: center; gap: 14px;
            padding: 16px 18px; cursor: pointer;
            user-select: none;
        }

        .notif-icon {
            width: 44px; height: 44px; border-radius: 14px; flex-shrink: 0;
            display: flex; align-items: center; justify-content: center;
            font-size: 18px; color: #fff;
        }
        .icon-exam       { background: linear-gradient(135deg,#0f2b5c,#3b82f6); }
        .icon-suspension { background: linear-gradient(135deg,#7c2d12,#f59e0b); }
        .icon-event      { background: linear-gradient(135deg,#064e3b,#14b8a6); }
        .icon-general    { background: linear-gradient(135deg,#1e1b4b,#818cf8); }

        .notif-info { flex:1; min-width:0; }
        .notif-title {
            font-size: 14px; font-weight: 700; color: var(--primary);
            white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
        }
        .notif-sub {
            font-size: 12px; color: var(--muted); margin-top: 3px;
            display: flex; align-items: center; gap: 8px; flex-wrap: wrap;
        }
        .cat-pill {
            display: inline-block; padding: 1px 8px; border-radius: 20px;
            font-size: 10px; font-weight: 700;
        }
        .pill-exam       { background:#DBEAFE; color:#1E3A8A; }
        .pill-suspension { background:#ffebee; color:#c62828; }
        .pill-event      { background:#dcfce7; color:#166534; }
        .pill-general    { background:#EDE9FE; color:#5B21B6; }

        .notif-chevron {
            color: var(--muted-light); font-size: 13px; flex-shrink: 0;
            transition: transform 0.25s;
        }
        .notif-item.open .notif-chevron { transform: rotate(90deg); }

        /* ── Expanded post ── */
        .notif-post {
            display: none;
            border-top: 1px solid var(--border);
            padding: 18px 20px 14px;
            animation: slideDown 0.2s ease;
        }
        .notif-item.open .notif-post { display: block; }

        @keyframes slideDown {
            from { opacity:0; transform:translateY(-6px); }
            to   { opacity:1; transform:translateY(0); }
        }

        .post-author-row { display:flex; align-items:center; gap:12px; margin-bottom:12px; }
        .post-avatar-sm {
            width:40px; height:40px; border-radius:50%; overflow:hidden; flex-shrink:0;
            background:linear-gradient(135deg,var(--primary),var(--primary-2));
            display:flex; align-items:center; justify-content:center; color:#fff; font-size:16px;
        }
        .post-avatar-sm img { width:100%; height:100%; object-fit:cover; border-radius:50%; display:block; }
        .post-author-name { font-weight:700; font-size:14px; color:var(--primary); }
        .post-date        { font-size:11px; color:var(--muted); margin-top:2px; }

        .post-title-full { font-size:17px; font-weight:800; color:var(--primary); margin-bottom:8px; }
        .post-content    { font-size:13px; color:var(--page-text); line-height:1.65; }
        .post-img        { margin-top:12px; border-radius:12px; overflow:hidden; }
        .post-img img    { width:100%; max-height:280px; object-fit:cover; display:block; border-radius:12px; }

        /* action row */
        .post-actions {
            display:flex; gap:6px; margin-top:14px; padding-top:12px;
            border-top:1px solid var(--border);
        }
        .act-btn {
            flex:1; background:none; border:none; padding:9px 4px; border-radius:10px;
            cursor:pointer; font-size:13px; color:var(--muted);
            display:flex; align-items:center; justify-content:center; gap:6px;
            transition:all 0.2s; font-family:inherit;
        }
        .act-btn:hover { background:var(--active-bg); color:var(--primary); }
        .act-btn.liked { color:#dc2626; }

        /* comments */
        .comments-wrap { margin-top:12px; }
        .comment-input-row { display:flex; gap:8px; margin-bottom:10px; }
        .comment-input-row input {
            flex:1; padding:9px 14px; background:var(--surface-soft);
            border:1px solid var(--border); border-radius:30px; outline:none;
            font-size:13px; color:var(--page-text); font-family:inherit;
        }
        .comment-input-row button {
            background:linear-gradient(135deg,var(--primary),var(--primary-2));
            border:none; padding:0 18px; border-radius:30px;
            color:#fff; font-weight:600; cursor:pointer; font-size:13px; font-family:inherit;
        }
        .comment-item { display:flex; gap:10px; padding:8px 0; border-bottom:1px solid var(--border); font-size:13px; }
        .comment-item:last-child { border-bottom:none; }
        .c-avatar {
            width:30px; height:30px; min-width:30px; border-radius:50%; overflow:hidden;
            background:var(--active-bg); display:flex; align-items:center; justify-content:center;
            color:var(--primary); font-size:12px; flex-shrink:0;
        }
        .c-avatar img { width:100%; height:100%; object-fit:cover; border-radius:50%; display:block; }
        .c-author { font-weight:700; color:var(--primary); }
        .c-time   { font-size:10px; color:var(--muted-light); margin-top:2px; }
        .no-comments { padding:10px 0; text-align:center; color:var(--muted-light); font-size:12px; }

        /* empty / loading */
        .empty-state { text-align:center; padding:60px 20px; color:var(--muted); }
        .empty-state i { font-size:48px; opacity:0.3; display:block; margin-bottom:14px; }

        /* toast */
        .toast-msg {
            position:fixed; bottom:28px; left:50%; transform:translateX(-50%);
            background:#1a3a5c; color:#fff; padding:10px 24px; border-radius:30px;
            font-size:13px; z-index:9999; box-shadow:0 4px 16px rgba(0,0,0,.25);
            animation:toastFade 2.6s ease forwards; pointer-events:none;
        }
        @keyframes toastFade {
            0%  { opacity:0; transform:translateX(-50%) translateY(10px); }
            12% { opacity:1; transform:translateX(-50%) translateY(0); }
            80% { opacity:1; }
            100%{ opacity:0; }
        }

        /* dark mode */
        .dark-mode {
            --bg-image: url('bg.jpg');
            --page-text: #e4e6eb;
            --surface: rgba(30,41,59,0.95);
            --surface-strong: rgba(30,41,59,0.98);
            --surface-soft: rgba(51,65,85,0.6);
            --border: rgba(148,163,184,0.2);
            --primary: #93c5fd;
            --primary-2: #60a5fa;
            --muted: #cbd5e1;
            --muted-light: #94a3b8;
            --shadow: 0 8px 32px rgba(0,0,0,0.5);
            --active-bg: rgba(59,130,246,0.2);
        }
        body.dark-mode { background-image:linear-gradient(rgba(15,23,42,0.85),rgba(15,23,42,0.85)),var(--bg-image); }
        body.dark-mode .notif-title  { color:#e0e7ff; }
        body.dark-mode .post-title-full { color:#e0e7ff; }
        body.dark-mode .post-author-name { color:#c7d2fe; }
        body.dark-mode .topbar-title { color:#e0e7ff; }
        body.dark-mode .act-btn:hover { background:rgba(59,130,246,0.15); color:#93c5fd; }

        @media (max-width:600px) {
            .page-shell { padding:16px 12px 40px; }
            .notif-teaser { padding:14px 14px; }
            .notif-post { padding:14px 14px 12px; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-shell">
            <div class="page-wrap">

                <!-- Topbar -->
                <div class="topbar">
                    <div class="topbar-title">
                        <i class="fas fa-bell"></i>
                        <span>Notifications</span>
                    </div>
                    <a class="back-btn" href="<%= BackUrl %>" title="Back">
                        <i class="fas fa-home" style="font-size:16px;"></i>
                    </a>
                </div>

                <!-- Notification list -->
                <div id="notifList">
                    <div class="empty-state">
                        <i class="fas fa-spinner fa-spin"></i>
                        <p>Loading notifications...</p>
                    </div>
                </div>

            </div>
        </div>
    </form>

    <script>
        // ── Theme ──────────────────────────────────────────────
        (function() {
            document.body.classList.toggle('dark-mode', localStorage.getItem('campus_theme') === 'dark');
            window.addEventListener('storage', function(e) {
                if (e.key === 'campus_theme')
                    document.body.classList.toggle('dark-mode', e.newValue === 'dark');
            });
        })();

        var likes = {};

        function escapeHtml(s) {
            if (!s) return '';
            return String(s).replace(/[&<>"']/g, function(c) {
                return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c];
            });
        }

        function showToast(msg) {
            var t = document.createElement('div');
            t.className = 'toast-msg'; t.textContent = msg;
            document.body.appendChild(t);
            setTimeout(function() { if (t.parentNode) t.parentNode.removeChild(t); }, 2700);
        }

        function getCatIcon(cat) {
            if (cat === 'Exam')       return 'fa-file-alt';
            if (cat === 'Suspension') return 'fa-cloud-rain';
            if (cat === 'Event')      return 'fa-calendar-alt';
            return 'fa-bullhorn';
        }
        function getIconClass(cat) {
            if (cat === 'Exam')       return 'icon-exam';
            if (cat === 'Suspension') return 'icon-suspension';
            if (cat === 'Event')      return 'icon-event';
            return 'icon-general';
        }
        function getPillClass(cat) {
            if (cat === 'Exam')       return 'pill-exam';
            if (cat === 'Suspension') return 'pill-suspension';
            if (cat === 'Event')      return 'pill-event';
            return 'pill-general';
        }

        // ── Toggle expand/collapse ─────────────────────────────
        function togglePost(id) {
            var item = document.getElementById('notif-' + id);
            if (!item) return;
            var isOpen = item.classList.contains('open');
            // Close all others
            document.querySelectorAll('.notif-item.open').forEach(function(el) {
                el.classList.remove('open');
            });
            if (!isOpen) {
                item.classList.add('open');
                // Load comments when first opened
                var cl = document.getElementById('cl-' + id);
                if (cl && cl.dataset.loaded !== 'true') {
                    loadComments(id);
                }
            }
        }

        // ── Like ──────────────────────────────────────────────
        function toggleLike(id) {
            fetch('LikeHandler.ashx?action=toggle&postId=' + id, { credentials: 'same-origin' })
                .then(function(r) { return r.json(); })
                .then(function(res) {
                    if (!res.ok) { showToast('Error: ' + (res.error || 'Could not like')); return; }
                    likes[id] = res.liked;
                    var lcEl = document.getElementById('lc-' + id);
                    if (lcEl) lcEl.textContent = res.likeCount;
                    var btn = document.getElementById('lb-' + id);
                    if (btn) {
                        btn.className = 'act-btn' + (res.liked ? ' liked' : '');
                        btn.innerHTML = '<i class="' + (res.liked ? 'fas' : 'far') + ' fa-heart"></i> ' + (res.liked ? 'Liked' : 'Like');
                    }
                    showToast(res.liked ? '❤️ Liked!' : 'Like removed');
                })
                .catch(function() { showToast('Could not update like'); });
        }

        // ── Comments ──────────────────────────────────────────
        function loadComments(id) {
            var cl = document.getElementById('cl-' + id);
            if (!cl) return;
            cl.innerHTML = '<div class="no-comments"><i class="fas fa-spinner fa-spin"></i></div>';
            fetch('CommentHandler.ashx?action=get&postId=' + id, { credentials: 'same-origin' })
                .then(function(r) { return r.json(); })
                .then(function(list) {
                    cl.dataset.loaded = 'true';
                    if (!list.length) { cl.innerHTML = '<div class="no-comments">No comments yet.</div>'; return; }
                    cl.innerHTML = list.map(function(c) {
                        var av = c.profileImage
                            ? '<div class="c-avatar"><img src="' + escapeHtml(c.profileImage) + '" /></div>'
                            : '<div class="c-avatar"><i class="fas fa-user"></i></div>';
                        return '<div class="comment-item">' + av
                            + '<div><div class="c-author">' + escapeHtml(c.author) + '</div>'
                            + '<div>' + escapeHtml(c.text) + '</div>'
                            + '<div class="c-time">' + escapeHtml(c.date) + '</div></div></div>';
                    }).join('');
                    var cc = document.getElementById('cc-' + id);
                    if (cc) cc.textContent = list.length;
                })
                .catch(function() { cl.innerHTML = '<div class="no-comments">Could not load comments.</div>'; });
        }

        function postComment(id) {
            var input = document.getElementById('ci-' + id);
            if (!input) return;
            var text = input.value.trim();
            if (!text) { showToast('Write a comment first'); return; }
            fetch('CommentHandler.ashx?action=add', {
                method: 'POST', credentials: 'same-origin',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ postId: id, comment: text })
            })
            .then(function(r) { return r.json(); })
            .then(function(res) {
                if (!res.success) { showToast('Error: ' + (res.error || 'Could not post')); return; }
                input.value = '';
                var cl = document.getElementById('cl-' + id);
                if (cl) cl.dataset.loaded = 'false';
                loadComments(id);
                showToast('💬 Comment posted!');
            })
            .catch(function() { showToast('Could not post comment'); });
        }

        function sharePost(id, title) {
            var url = window.location.origin + window.location.pathname.replace('Notifications.aspx','') + '?post=' + id;
            if (navigator.clipboard) {
                navigator.clipboard.writeText(url).then(function() { showToast('🔗 Link copied!'); });
            } else { showToast('Shared: ' + title); }
        }

        // ── Load & render ─────────────────────────────────────
        function loadAndRender() {
            var list = document.getElementById('notifList');

            fetch('AnnouncementHandler.ashx?action=getAll', { credentials: 'same-origin' })
                .then(function(r) { return r.json(); })
                .then(function(res) {
                    if (!res.ok || !res.data || !res.data.length) {
                        list.innerHTML = '<div class="empty-state"><i class="fas fa-bell-slash"></i><p>No announcements yet.</p></div>';
                        return;
                    }

                    list.innerHTML = res.data.map(function(ann) {
                        var liked    = !!likes[ann.id];
                        var lc       = ann.likeCount || 0;
                        var cc       = ann.commentCount || 0;
                        var iconCls  = getIconClass(ann.category);
                        var iconFa   = getCatIcon(ann.category);
                        var pillCls  = getPillClass(ann.category);

                        // Author avatar
                        var authorAv = ann.authorImage
                            ? '<div class="post-avatar-sm"><img src="' + escapeHtml(ann.authorImage) + '" /></div>'
                            : '<div class="post-avatar-sm"><i class="fas fa-user-tie"></i></div>';

                        // Teaser: first 80 chars of content
                        var teaser = (ann.content || '').length > 80
                            ? ann.content.substring(0, 80) + '…'
                            : ann.content;

                        return '<div class="notif-item" id="notif-' + ann.id + '">'

                            // ── Teaser row (always visible) ──
                            + '<div class="notif-teaser" onclick="togglePost(' + ann.id + ')">'
                            +   '<div class="notif-icon ' + iconCls + '"><i class="fas ' + iconFa + '"></i></div>'
                            +   '<div class="notif-info">'
                            +     '<div class="notif-title">' + escapeHtml(ann.title) + '</div>'
                            +     '<div class="notif-sub">'
                            +       '<span class="cat-pill ' + pillCls + '">' + escapeHtml(ann.category) + '</span>'
                            +       '<span>' + escapeHtml(ann.date) + '</span>'
                            +       '<span style="color:var(--muted-light)">· ' + escapeHtml(teaser) + '</span>'
                            +     '</div>'
                            +   '</div>'
                            +   '<i class="fas fa-chevron-right notif-chevron"></i>'
                            + '</div>'

                            // ── Expanded full post ──
                            + '<div class="notif-post">'
                            +   '<div class="post-author-row">'
                            +     authorAv
                            +     '<div><div class="post-author-name">' + escapeHtml(ann.author) + '</div>'
                            +     '<div class="post-date">' + escapeHtml(ann.date) + '</div></div>'
                            +   '</div>'
                            +   '<div class="post-title-full">' + escapeHtml(ann.title) + '</div>'
                            +   '<div class="post-content">' + escapeHtml(ann.content) + '</div>'
                            +   (ann.imageUrl ? '<div class="post-img"><img src="' + escapeHtml(ann.imageUrl) + '" onerror="this.style.display=\'none\'" /></div>' : '')
                            +   '<div class="post-actions">'
                            +     '<button type="button" id="lb-' + ann.id + '" class="act-btn' + (liked ? ' liked' : '') + '" onclick="toggleLike(' + ann.id + ')">'
                            +       '<i class="' + (liked ? 'fas' : 'far') + ' fa-heart"></i> <span id="lc-' + ann.id + '">' + lc + '</span> Likes'
                            +     '</button>'
                            +     '<button type="button" class="act-btn" onclick="togglePost(' + ann.id + ');loadComments(' + ann.id + ')">'
                            +       '<i class="far fa-comment"></i> <span id="cc-' + ann.id + '">' + cc + '</span> Comments'
                            +     '</button>'
                            +     '<button type="button" class="act-btn" onclick="sharePost(' + ann.id + ',\'' + escapeHtml(ann.title) + '\')">'
                            +       '<i class="fas fa-share-alt"></i> Share'
                            +     '</button>'
                            +   '</div>'
                            +   '<div class="comments-wrap">'
                            +     '<div class="comment-input-row">'
                            +       '<input id="ci-' + ann.id + '" type="text" placeholder="Write a comment..." />'
                            +       '<button type="button" onclick="postComment(' + ann.id + ')">Post</button>'
                            +     '</div>'
                            +     '<div id="cl-' + ann.id + '"><div class="no-comments">No comments yet.</div></div>'
                            +   '</div>'
                            + '</div>'

                            + '</div>';
                    }).join('');
                })
                .catch(function() {
                    list.innerHTML = '<div class="empty-state"><i class="fas fa-exclamation-triangle"></i><p>Could not load. Check your connection.</p></div>';
                });
        }

        loadAndRender();

        // Mark all notifications as read when this page is opened
        fetch('NotificationHandler.ashx?action=markAllRead', { credentials: 'same-origin' })
            .catch(function() {});
    </script>
</body>
</html>
