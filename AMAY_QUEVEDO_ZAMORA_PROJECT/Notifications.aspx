<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Notifications.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Notifications" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Notifications</title>
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
            --surface: rgba(255,255,255,0.92);
            --surface-strong: #ffffff;
            --surface-soft: #f8fafc;
            --border: rgba(26,58,92,0.12);
            --primary: #1a3a5c;
            --primary-2: #2c5a7a;
            --muted: #6b7c8f;
            --muted-light: #9db0c4;
            --shadow: 0 8px 24px rgba(0,0,0,0.08);
            --active-bg: #e8f0fe;
        }

        body {
            min-height: 100vh;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            color: var(--page-text);
            background-image: linear-gradient(rgba(255,255,255,0.16), rgba(255,255,255,0.16)), var(--bg-image);
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            background-attachment: fixed;
            transition: background 0.3s, color 0.3s;
        }

        a { color: inherit; text-decoration: none; }

        .page-shell { min-height: 100vh; padding: 48px 32px 32px; }
        .page-wrap  { max-width: 860px; margin: 0 auto; }

        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 26px;
        }

        .page-title {
            display: flex;
            align-items: center;
            gap: 16px;
            font-size: 28px;
            font-weight: 800;
            color: var(--primary);
        }
        .page-title i { color: var(--primary); }

        .back-link {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: linear-gradient(135deg, #1a3a5c, #2563eb);
            color: #ffffff;
            border: none;
            box-shadow: var(--shadow);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .back-link:hover { transform: translateY(-2px); box-shadow: 0 6px 18px rgba(37,99,235,0.35); }

        /* ── Announcement card style ── */
        .announce-card {
            background: var(--surface-strong);
            border: 1px solid #3B82F6;
            border-radius: 20px;
            margin-bottom: 16px;
            box-shadow: var(--shadow);
            overflow: hidden;
            transition: transform 0.2s, box-shadow 0.2s, border-color 0.2s;
        }
        .announce-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 28px rgba(0,0,0,0.12);
            border-color: #1E3A8A;
        }

        .card-author-name { color: var(--primary); font-weight: 700; font-size: 15px; }
        .card-meta        { color: var(--muted); font-size: 12px; margin-top: 2px; }
        .card-title       { color: var(--primary); font-size: 18px; font-weight: 700; margin-bottom: 8px; }
        .card-desc        { color: var(--page-text); font-size: 13px; line-height: 1.6; }

        .card-banner {
            border-radius: 10px;
            padding: 4px 12px;
            font-size: 11px;
            font-weight: 700;
            color: #fff;
            white-space: nowrap;
        }
        .banner-exam       { background: linear-gradient(135deg,#0f2b5c,#3b82f6); }
        .banner-suspension { background: linear-gradient(135deg,#7c2d12,#f59e0b); }
        .banner-events     { background: linear-gradient(135deg,#064e3b,#14b8a6); }
        .banner-default    { background: linear-gradient(135deg,#1e1b4b,#818cf8); }

        .cat-badge { display:inline-block; padding:2px 10px; border-radius:20px; font-size:10px; font-weight:700; }
        .cat-exam       { background:#DBEAFE; color:#1E3A8A; }
        .cat-suspension { background:#ffebee; color:#c62828; }
        .cat-event      { background:#dcfce7; color:#166534; }
        .cat-default    { background:#EDE9FE; color:#5B21B6; }

        .post-stats {
            display: flex;
            gap: 16px;
            padding: 8px 20px;
            border-top: 1px solid var(--border);
            border-bottom: 1px solid var(--border);
            color: var(--muted);
            font-size: 13px;
        }
        .post-stats span { display:flex; align-items:center; gap:5px; cursor:pointer; transition:color 0.2s; }
        .post-stats span:hover { color: var(--primary); }

        .action-buttons { display:flex; gap:4px; padding:6px 20px 10px; }
        .action-btn {
            flex: 1;
            background: none;
            border: none;
            padding: 8px 4px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 13px;
            color: var(--muted);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            transition: all 0.2s;
            font-family: inherit;
        }
        .action-btn:hover { background: #DBEAFE; color: #1E3A8A; }
        .action-btn.liked { color: #dc2626; }

        .comments-section { padding: 0 20px 16px; border-top: 1px solid var(--border); display: none; }
        .comments-section.show { display: block; }
        .comment-input-row { display:flex; gap:8px; margin:12px 0; }
        .comment-input-row input {
            flex:1; padding:9px 14px;
            background: var(--surface-soft);
            border: 1px solid var(--border);
            border-radius: 30px; outline: none;
            font-size: 13px; color: var(--page-text); font-family: inherit;
        }
        .comment-input-row button {
            background: linear-gradient(135deg, var(--primary), var(--primary-2));
            border: none; padding: 0 18px; border-radius: 30px;
            color: white; font-weight: 600; cursor: pointer; font-size: 13px; font-family: inherit;
        }
        .comment-item { display:flex; gap:10px; padding:10px 0; border-bottom:1px solid var(--border); font-size:13px; }
        .comment-item:last-child { border-bottom: none; }
        .comment-avatar {
            width:30px; height:30px; background:var(--active-bg); border-radius:50%;
            display:flex; align-items:center; justify-content:center; color:var(--primary); font-size:12px; flex-shrink:0;
        }
        .comment-author { font-weight:700; color:var(--primary); }
        .comment-text   { color:var(--page-text); margin-top:2px; }
        .comment-time   { font-size:10px; color:var(--muted-light); margin-top:2px; }
        .no-comments    { padding:12px 0; text-align:center; color:var(--muted-light); font-size:12px; }

        /* ── Toast ── */
        .toast-msg {
            position:fixed; bottom:28px; left:50%; transform:translateX(-50%);
            background:#1a3a5c; color:white; padding:10px 24px; border-radius:30px;
            font-size:13px; z-index:9999; box-shadow:0 4px 16px rgba(0,0,0,.25);
            animation:toastFade 2.6s ease forwards; pointer-events:none;
        }
        @keyframes toastFade {
            0%  { opacity:0; transform:translateX(-50%) translateY(10px); }
            12% { opacity:1; transform:translateX(-50%) translateY(0); }
            80% { opacity:1; }
            100%{ opacity:0; }
        }

        /* ── Dark mode ── */
        .dark-mode {
            --bg-image: url('bg.jpg');
            --page-text: #e4e6eb;
            --surface: rgba(30, 41, 59, 0.95);
            --surface-strong: rgba(30, 41, 59, 0.98);
            --surface-soft: rgba(51, 65, 85, 0.6);
            --border: rgba(148, 163, 184, 0.2);
            --primary: #93c5fd;
            --primary-2: #60a5fa;
            --muted: #cbd5e1;
            --muted-light: #94a3b8;
            --shadow: 0 8px 32px rgba(0,0,0,0.6);
            --active-bg: rgba(59, 130, 246, 0.2);
        }
        body.dark-mode {
            background-image: linear-gradient(rgba(15, 23, 42, 0.85), rgba(15, 23, 42, 0.85)), var(--bg-image);
        }
        body.dark-mode .announce-card {
            background: rgba(30, 41, 59, 0.95);
            border-color: #3B82F6;
        }
        body.dark-mode .announce-card:hover { 
            border-color: #60a5fa;
            background: rgba(30, 41, 59, 1);
        }
        body.dark-mode .action-btn:hover { 
            background: rgba(59, 130, 246, 0.15); 
            color: #93c5fd; 
        }
        body.dark-mode .cat-exam       { background: rgba(59, 130, 246, 0.25);  color: #93c5fd; }
        body.dark-mode .cat-suspension { background: rgba(239, 68, 68, 0.25);   color: #fca5a5; }
        body.dark-mode .cat-event      { background: rgba(34, 197, 94, 0.25);   color: #86efac; }
        body.dark-mode .toast-msg      { background: #3B82F6; }
        body.dark-mode .card-author-name { color: #e0e7ff; }
        body.dark-mode .card-title { color: #e0e7ff; }
        body.dark-mode .card-desc { color: #e2e8f0; }
        body.dark-mode .page-title { color: #e0e7ff; }
        body.dark-mode .page-title i { color: #93c5fd; }
        body.dark-mode .comment-author { color: #c7d2fe; }
        body.dark-mode .comment-text { color: #e2e8f0; }
        body.dark-mode .comment-avatar {
            background: rgba(59, 130, 246, 0.2);
            color: #93c5fd;
        }
        body.dark-mode .comment-input input {
            background: rgba(51, 65, 85, 0.6);
            border-color: rgba(148, 163, 184, 0.3);
            color: #f1f5f9;
        }
        body.dark-mode .comment-input input::placeholder {
            color: #94a3b8;
        }
        body.dark-mode .comment-input button {
            background: linear-gradient(135deg, #3B82F6, #60a5fa);
        }

        @media (max-width: 768px) {
            .page-shell { padding: 24px 16px; }
            .page-header { flex-direction: column; align-items: flex-start; }
            .page-title { font-size: 22px; }
            .action-buttons { padding: 6px 14px 10px; }
            .action-btn { font-size: 12px; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-shell">
            <div class="page-wrap">
                <div class="page-header">
                    <div class="page-title">
                        <i class="fas fa-bell"></i>
                        <span>Notifications</span>
                    </div>
                    <a class="back-link" href="<%= BackUrl %>" title="Back to Portal">
                        <i class="fas fa-home" style="font-size:18px;"></i>
                    </a>
                </div>

                <div id="notifContainer">
                    <div style="text-align:center;padding:40px;color:var(--muted);">
                        <i class="fas fa-spinner fa-spin" style="font-size:24px;"></i>
                        <p style="margin-top:10px;">Loading notifications...</p>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>
        var THEME_KEY = 'campus_theme';
        var pins = JSON.parse(localStorage.getItem('campus_pins') || '{}');
        var likes = {};

        function savePins() {
            localStorage.setItem('campus_pins', JSON.stringify(pins));
        }

        function applyStoredTheme() {
            document.body.classList.toggle('dark-mode', localStorage.getItem(THEME_KEY) === 'dark');
        }

        function escapeHtml(s) {
            if (!s) return '';
            return String(s).replace(/[&<>"']/g, function(c) {
                return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c];
            });
        }

        function showToast(msg) {
            var t = document.createElement('div');
            t.className = 'toast-msg';
            t.textContent = msg;
            document.body.appendChild(t);
            setTimeout(function() { if (t.parentNode) t.parentNode.removeChild(t); }, 2700);
        }

        function getCatClass(cat) {
            if (cat === 'Exam' || cat === 'Exam Schedule')         return 'cat-exam';
            if (cat === 'Suspension' || cat === 'Class Suspension') return 'cat-suspension';
            if (cat === 'Event' || cat === 'Campus Events')         return 'cat-event';
            return 'cat-default';
        }

        function getBannerClass(cat) {
            if (cat === 'Exam' || cat === 'Exam Schedule')         return 'banner-exam';
            if (cat === 'Suspension' || cat === 'Class Suspension') return 'banner-suspension';
            if (cat === 'Event' || cat === 'Campus Events')         return 'banner-events';
            return 'banner-default';
        }

        function toggleLike(id) {
            fetch('LikeHandler.ashx?action=toggle&postId=' + id, { credentials: 'same-origin' })
                .then(function(r) { return r.json(); })
                .then(function(res) {
                    if (!res.ok) { showToast('Error: ' + (res.error || 'Could not like')); return; }
                    likes[id] = res.liked;
                    var lcEl = document.getElementById('lc-' + id);
                    if (lcEl) lcEl.textContent = res.likeCount;
                    var likeBtn = document.getElementById('lb-' + id);
                    if (likeBtn) {
                        likeBtn.className = 'action-btn' + (res.liked ? ' liked' : '');
                        likeBtn.innerHTML = '<i class="' + (res.liked ? 'fas' : 'far') + ' fa-heart"></i> ' + (res.liked ? 'Liked' : 'Like');
                    }
                    showToast(res.liked ? '❤️ Liked!' : 'Like removed');
                })
                .catch(function() { showToast('Could not update like'); });
        }

        function togglePin(id) {
            pins[id] = !pins[id];
            if (!pins[id]) delete pins[id];
            savePins();
            loadAndRender();
            showToast(pins[id] ? '📌 Pinned!' : 'Unpinned');
        }

        function openComments(id) {
            var sec = document.getElementById('cs-' + id);
            if (!sec) return;
            var isOpen = sec.classList.contains('show');
            sec.classList.toggle('show');
            if (!isOpen) {
                fetch('CommentHandler.ashx?action=get&postId=' + id, { credentials: 'same-origin' })
                    .then(function(r) { return r.json(); })
                    .then(function(list) {
                        var cl = document.getElementById('cl-' + id);
                        if (!cl) return;
                        if (!list.length) { cl.innerHTML = '<div class="no-comments">No comments yet.</div>'; return; }
                        cl.innerHTML = list.map(function(c) {
                            return '<div class="comment-item">'
                                + '<div class="comment-avatar"><i class="fas fa-user"></i></div>'
                                + '<div><div class="comment-author">' + escapeHtml(c.author) + '</div>'
                                + '<div class="comment-text">' + escapeHtml(c.text) + '</div>'
                                + '<div class="comment-time">' + escapeHtml(c.date) + '</div></div></div>';
                        }).join('');
                        var cc = document.getElementById('cc-' + id);
                        if (cc) cc.textContent = list.length;
                    })
                    .catch(function() {});
            }
        }

        function postComment(id) {
            var input = document.getElementById('ci-' + id);
            if (!input) return;
            var text = input.value.trim();
            if (!text) { showToast('Please write a comment first'); return; }
            fetch('CommentHandler.ashx?action=add', {
                method: 'POST', credentials: 'same-origin',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ postId: id, comment: text })
            })
            .then(function(r) { return r.json(); })
            .then(function(res) {
                if (!res.success) { showToast('Error: ' + (res.error || 'Could not post')); return; }
                input.value = '';
                fetch('CommentHandler.ashx?action=get&postId=' + id, { credentials: 'same-origin' })
                    .then(function(r) { return r.json(); })
                    .then(function(list) {
                        var cl = document.getElementById('cl-' + id);
                        if (cl) cl.innerHTML = list.map(function(c) {
                            return '<div class="comment-item">'
                                + '<div class="comment-avatar"><i class="fas fa-user"></i></div>'
                                + '<div><div class="comment-author">' + escapeHtml(c.author) + '</div>'
                                + '<div class="comment-text">' + escapeHtml(c.text) + '</div>'
                                + '<div class="comment-time">' + escapeHtml(c.date) + '</div></div></div>';
                        }).join('');
                        var cc = document.getElementById('cc-' + id);
                        if (cc) cc.textContent = list.length;
                    });
                showToast('💬 Comment posted!');
            })
            .catch(function() { showToast('Could not post comment'); });
        }

        function sharePost(id, title) {
            var url = window.location.href.split('?')[0] + '?post=' + id;
            if (navigator.clipboard) {
                navigator.clipboard.writeText(url).then(function() { showToast('🔗 Link copied!'); });
            } else { showToast('📤 Shared!'); }
        }

        function loadAndRender() {
            var container = document.getElementById('notifContainer');
            container.innerHTML = '<div style="text-align:center;padding:40px;color:var(--muted);"><i class="fas fa-spinner fa-spin" style="font-size:24px;"></i><p style="margin-top:10px;">Loading...</p></div>';

            fetch('AnnouncementHandler.ashx?action=getAll', { credentials: 'same-origin' }).then(function(r) { return r.json(); })
            .then(function(annRes) {
                if (!annRes.ok) {
                    container.innerHTML = '<div style="text-align:center;padding:40px;">'
                        + '<i class="fas fa-exclamation-circle" style="font-size:40px;color:#dc2626;margin-bottom:12px;display:block;"></i>'
                        + '<p style="font-weight:700;color:#dc2626;font-size:16px;">Could not load announcements</p>'
                        + '<p style="color:var(--muted);margin-top:8px;font-size:13px;">Reason: ' + (annRes.error || 'Unknown error') + '</p>'
                        + '<a href="login.aspx" style="display:inline-block;margin-top:16px;padding:10px 24px;background:#1a3a5c;color:white;border-radius:30px;text-decoration:none;font-size:13px;">Go to Login</a>'
                        + '</div>';
                    return;
                }

                var announcements = annRes.data || [];
                if (!announcements.length) {
                    container.innerHTML = '<div style="text-align:center;padding:60px 20px;color:var(--muted)">'
                        + '<i class="fas fa-bell-slash" style="font-size:48px;opacity:0.3;display:block;margin-bottom:16px"></i>'
                        + '<p style="font-size:16px;font-weight:600">No announcements yet</p></div>';
                    return;
                }

                announcements.sort(function(a, b) {
                    var ap = pins[a.id] ? 1 : 0, bp = pins[b.id] ? 1 : 0;
                    if (bp !== ap) return bp - ap;
                    return b.id - a.id;
                });

                container.innerHTML = announcements.map(function(ann) {
                    var liked    = !!likes[ann.id];
                    var pinned   = !!pins[ann.id];
                    var lc       = ann.likeCount || 0;
                    var cc       = ann.commentCount || 0;
                    var catCls   = getCatClass(ann.category);
                    var banCls   = getBannerClass(ann.category);
                    var catLabel = ann.category || 'General';

                    return '<div class="announce-card">'
                        + '<div style="padding:18px 20px 12px">'
                        +   '<div style="display:flex;align-items:flex-start;justify-content:space-between;gap:12px;margin-bottom:12px">'
                        +     '<div style="display:flex;align-items:center;gap:12px;flex:1">'
                        +       '<div style="width:44px;height:44px;background:var(--active-bg);border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0">'
                        +         '<i class="fas fa-user-tie" style="color:var(--primary);font-size:18px"></i>'
                        +       '</div>'
                        +       '<div>'
                        +         '<div class="card-author-name">' + escapeHtml(ann.author) + '</div>'
                        +         '<div class="card-meta"><i class="fas fa-calendar-alt" style="margin-right:4px"></i>' + escapeHtml(ann.date) + '</div>'
                        +       '</div>'
                        +     '</div>'
                        +     '<div style="display:flex;align-items:center;gap:8px">'
                        +       '<span class="card-banner ' + banCls + '">' + escapeHtml(catLabel.toUpperCase()) + '</span>'
                        +       '<button type="button" onclick="togglePin(' + ann.id + ')" style="background:none;border:none;cursor:pointer;font-size:18px;color:' + (pinned ? '#e65100' : 'var(--muted-light)') + ';padding:4px;">'
                        +         '<i class="' + (pinned ? 'fas' : 'far') + ' fa-thumbtack"></i>'
                        +       '</button>'
                        +     '</div>'
                        +   '</div>'
                        +   '<div class="card-title">' + escapeHtml(ann.title) + '</div>'
                        +   '<div class="card-desc">' + escapeHtml(ann.content) + '</div>'
                        +   '<div style="margin-top:10px;display:flex;align-items:center;gap:8px">'
                        +     '<span class="cat-badge ' + catCls + '">' + escapeHtml(catLabel) + '</span>'
                        +     (pinned ? '<span style="font-size:10px;color:#e65100;font-weight:700"><i class="fas fa-thumbtack" style="margin-right:3px"></i>Pinned</span>' : '')
                        +   '</div>'
                        + '</div>'
                        + '<div class="post-stats">'
                        +   '<span onclick="toggleLike(' + ann.id + ')"><i class="' + (liked ? 'fas' : 'far') + ' fa-heart" style="' + (liked ? 'color:#dc2626' : '') + '"></i> <span id="lc-' + ann.id + '">' + lc + '</span> Likes</span>'
                        +   '<span onclick="openComments(' + ann.id + ')"><i class="far fa-comment"></i> <span id="cc-' + ann.id + '">' + cc + '</span> Comments</span>'
                        +   '<span onclick="sharePost(' + ann.id + ',\'' + escapeHtml(ann.title) + '\')"><i class="far fa-share-square"></i> Share</span>'
                        + '</div>'
                        + '<div class="action-buttons">'
                        +   '<button type="button" id="lb-' + ann.id + '" class="action-btn' + (liked ? ' liked' : '') + '" onclick="toggleLike(' + ann.id + ')"><i class="' + (liked ? 'fas' : 'far') + ' fa-heart"></i> ' + (liked ? 'Liked' : 'Like') + '</button>'
                        +   '<button type="button" class="action-btn" onclick="openComments(' + ann.id + ')"><i class="far fa-comment"></i> Comment</button>'
                        +   '<button type="button" class="action-btn" onclick="sharePost(' + ann.id + ',\'' + escapeHtml(ann.title) + '\')"><i class="fas fa-share-alt"></i> Share</button>'
                        + '</div>'
                        + '<div class="comments-section" id="cs-' + ann.id + '">'
                        +   '<div class="comment-input-row">'
                        +     '<input id="ci-' + ann.id + '" type="text" placeholder="Write a comment...">'
                        +     '<button type="button" onclick="postComment(' + ann.id + ')">Post</button>'
                        +   '</div>'
                        +   '<div id="cl-' + ann.id + '"><div class="no-comments">No comments yet.</div></div>'
                        + '</div>'
                        + '</div>';
                }).join('');
            })
            .catch(function(err) {
                container.innerHTML = '<div style="text-align:center;padding:40px;">'
                    + '<i class="fas fa-exclamation-triangle" style="font-size:40px;color:#f59e0b;margin-bottom:12px;display:block;"></i>'
                    + '<p style="font-weight:700;color:#dc2626;font-size:16px;">Failed to reach the server</p>'
                    + '<p style="color:var(--muted);margin-top:8px;font-size:13px;">Make sure:</p>'
                    + '<ul style="text-align:left;display:inline-block;margin-top:8px;color:var(--muted);font-size:13px;line-height:2;">'
                    + '<li>✅ SQL Server is running (SQLEXPRESS1)</li>'
                    + '<li>✅ IIS / Visual Studio is running</li>'
                    + '<li>✅ You are logged in</li>'
                    + '</ul>'
                    + '<br/><a href="login.aspx" style="display:inline-block;margin-top:16px;padding:10px 24px;background:#1a3a5c;color:white;border-radius:30px;text-decoration:none;font-size:13px;">Go to Login</a>'
                    + '</div>';
            });
        }

        window.addEventListener('storage', function(e) {
            if (e.key === THEME_KEY) applyStoredTheme();
        });

        applyStoredTheme();
        loadAndRender();
    </script>
</body>
</html>