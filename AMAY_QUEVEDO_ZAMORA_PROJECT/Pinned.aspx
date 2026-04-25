<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pinned.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Pinned" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Pinned Announcements</title>
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
            --surface: rgba(255, 255, 255, 0.9);
            --surface-strong: rgba(255, 255, 255, 0.95);
            --border: rgba(26, 58, 92, 0.14);
            --primary: #1a3a5c;
            --primary-2: #2c5a7a;
            --muted: #6b7c8f;
            --shadow: 0 14px 34px rgba(0, 0, 0, 0.12);
        }

        body {
            min-height: 100vh;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            color: var(--page-text);
            background-image: linear-gradient(rgba(255, 255, 255, 0.16), rgba(255, 255, 255, 0.16)), var(--bg-image);
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            background-attachment: fixed;
            transition: background 0.3s ease, color 0.3s ease;
        }

        a {
            color: inherit;
            text-decoration: none;
        }

        .page-shell {
            min-height: 100vh;
            padding: 48px 32px 32px;
        }

        .page-wrap {
            max-width: 1460px;
            margin: 0 auto;
        }

        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            color: #000000;
            margin-bottom: 26px;
        }

        .page-title {
            display: flex;
            align-items: center;
            gap: 16px;
            font-size: 34px;
            font-weight: 800;
            color: var(--primary);
        }

        .page-title i {
            color: var(--primary);
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 12px 18px;
            border-radius: 999px;
            background: var(--surface);
            color: var(--primary);
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            font-weight: 600;
        }

        .pinned-list {
            display: grid;
            gap: 24px;
        }

        .pinned-card {
            background: var(--surface);
            backdrop-filter: blur(12px);
            border-radius: 28px;
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            padding: 28px;
        }

        .card-top {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 18px;
            margin-bottom: 18px;
        }

        .card-author {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .avatar {
            width: 58px;
            height: 58px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, var(--primary), var(--primary-2));
            color: #ffffff;
            font-size: 22px;
        }

        .author-name {
            font-size: 17px;
            font-weight: 700;
            color: var(--primary);
        }

        .meta {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin-top: 6px;
            font-size: 13px;
            color: var(--muted);
        }

        .status-pill {
            display: inline-flex;
            align-items: center;
            padding: 4px 12px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 700;
            background: #fff0db;
            color: #d97706;
        }

        .pin-icon {
            color: #ea580c;
            font-size: 24px;
            padding-top: 6px;
        }

        .card-title {
            font-size: 21px;
            font-weight: 800;
            color: var(--primary);
            margin-bottom: 12px;
        }

        .card-text {
            font-size: 16px;
            line-height: 1.65;
            margin-bottom: 22px;
        }

        .card-image img {
            width: 100%;
            max-height: 420px;
            object-fit: cover;
            display: block;
            border-radius: 24px;
        }

        .empty-state {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 28px;
            padding: 40px 28px;
            text-align: center;
            color: var(--muted);
            box-shadow: var(--shadow);
        }

        /* Category badges */
        .cat-badge { display:inline-block;padding:2px 10px;border-radius:20px;font-size:10px;font-weight:700; }
        .cat-exam       { background:#DBEAFE;color:#1E3A8A; }
        .cat-suspension { background:#ffebee;color:#c62828; }
        .cat-event      { background:#dcfce7;color:#166534; }
        .cat-default    { background:#EDE9FE;color:#5B21B6; }

        /* Action button hover */
        button:hover { opacity: 0.85; }

        .dark-mode {
            --bg-image: url('bg.jpg');
            --page-text: #f2f6fb;
            --surface: rgba(33, 38, 45, 0.9);
            --surface-strong: rgba(39, 44, 52, 0.96);
            --border: rgba(255, 255, 255, 0.08);
            --primary: #ffffff;
            --primary-2: #7fa6d1;
            --muted: #c4cfdb;
            --shadow: 0 14px 34px rgba(0, 0, 0, 0.28);
        }

        body.dark-mode {
            background-image: linear-gradient(rgba(18, 22, 28, 0.42), rgba(18, 22, 28, 0.42)), var(--bg-image);
        }

        .dark-mode .back-link,
        .dark-mode .pinned-card,
        .dark-mode .empty-state {
            color: #ffffff;
        }

        .dark-mode .status-pill {
            background: rgba(234, 88, 12, 0.18);
            color: #ffd3b0;
        }

        .dark-mode .pin-icon {
            color: #ff8a3d;
        }

        @media (max-width: 768px) {
            .page-shell {
                padding: 24px 16px;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .page-title {
                font-size: 28px;
            }

            .pinned-card {
                padding: 20px;
            }

            .card-top {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-shell">
            <div class="page-wrap">
                <div class="page-header">
                    <div class="page-title">
                        <i class="fas fa-thumbtack"></i>
                        <span>Pinned Announcements</span>
                    </div>
                    <a class="back-link" href="<%= BackUrl %>">
                        <i class="fas fa-arrow-left"></i>
                        <span><%= BackLabel %></span>
                    </a>
                </div>

                <div class="pinned-list">
                    <div style="text-align:center;padding:40px;">Loading pinned announcements...</div>
                </div>
            </div>
        </div>
    </form>

    <script>
        // ── Load live data from teacher_announcements ──────────
        function loadDB() {
            var raw = JSON.parse(localStorage.getItem('teacher_announcements') || 'null') || [];
            return raw.map(function(a) {
                var cat = a.category || '';
                var catLabel = cat === 'Exam' ? 'Exam Schedule' : cat === 'Suspension' ? 'Class Suspension' : cat === 'Event' ? 'Campus Events' : cat;
                return { id: a.id, title: a.title||'', category: catLabel, date: a.date||'', time: '', professor: a.author||'', description: a.content||'' };
            });
        }

        var THEME_KEY = 'campus_theme';

        function loadPins() {
            var tp = JSON.parse(localStorage.getItem('teacher_pins') || '{}');
            var cp = JSON.parse(localStorage.getItem('campus_pins')  || '{}');
            return Object.assign({}, cp, tp);
        }

        var pins      = loadPins();
        var likes     = JSON.parse(localStorage.getItem('sd_likes')      || '{}');
        var likeCounts= JSON.parse(localStorage.getItem('sd_likeCounts') || '{}');
        var comments  = JSON.parse(localStorage.getItem('sd_comments')   || '{}');

        function saveState() {
            localStorage.setItem('campus_pins',    JSON.stringify(pins));
            localStorage.setItem('teacher_pins',   JSON.stringify(pins));
            localStorage.setItem('sd_likes',       JSON.stringify(likes));
            localStorage.setItem('sd_likeCounts',  JSON.stringify(likeCounts));
            localStorage.setItem('sd_comments',    JSON.stringify(comments));
        }

        function escapeHtml(s) {
            if (!s) return '';
            return String(s).replace(/[&<>"']/g, function(c) {
                return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c];
            });
        }

        function formatDate(d) {
            if (!d) return '';
            var dt = new Date(d);
            if (isNaN(dt)) return d;
            return dt.toLocaleDateString('en-US', { month:'long', day:'numeric', year:'numeric' });
        }

        function getCatClass(cat) {
            if (cat === 'Exam Schedule')    return 'cat-exam';
            if (cat === 'Class Suspension') return 'cat-suspension';
            if (cat === 'Campus Events')    return 'cat-event';
            return 'cat-default';
        }

        function showToast(msg) {
            var t = document.createElement('div');
            t.textContent = msg;
            t.style.cssText = 'position:fixed;bottom:28px;left:50%;transform:translateX(-50%);background:#1a3a5c;color:#fff;padding:10px 24px;border-radius:30px;font-size:13px;z-index:9999;box-shadow:0 4px 16px rgba(0,0,0,.25);pointer-events:none;';
            document.body.appendChild(t);
            setTimeout(function() { if (t.parentNode) t.parentNode.removeChild(t); }, 2500);
        }

        function renderComments(id) {
            var list = comments[id] || [];
            if (!list.length) return '<div style="padding:10px 0;text-align:center;font-size:12px;color:var(--muted)">No comments yet.</div>';
            return list.map(function(c) {
                return '<div style="display:flex;gap:10px;padding:8px 0;border-bottom:1px solid var(--border);font-size:13px">'
                    + '<div style="width:28px;height:28px;border-radius:50%;background:var(--active-bg);display:flex;align-items:center;justify-content:center;flex-shrink:0;color:var(--primary);font-size:11px"><i class="fas fa-user"></i></div>'
                    + '<div><div style="font-weight:700;color:var(--primary)">' + escapeHtml(c.author) + '</div>'
                    + '<div style="color:var(--page-text)">' + escapeHtml(c.text) + '</div>'
                    + '<div style="font-size:10px;color:var(--muted-light)">' + escapeHtml(c.time) + '</div></div></div>';
            }).join('');
        }

        function pushNotification(msg, icon) {
            var notifs = JSON.parse(localStorage.getItem('campus_notifications') || '[]');
            notifs.unshift({ msg: msg, icon: icon || 'fa-bell', time: new Date().toISOString(), read: false });
            if (notifs.length > 50) notifs = notifs.slice(0, 50);
            localStorage.setItem('campus_notifications', JSON.stringify(notifs));
        }

        function toggleLike(id) {
            var ann = loadDB().find(function(a) { return a.id === id; });
            likes[id] = !likes[id];
            likeCounts[id] = (likeCounts[id] || 0) + (likes[id] ? 1 : -1);
            if (likeCounts[id] < 0) likeCounts[id] = 0;
            if (likes[id] && ann) pushNotification('❤️ Someone liked "' + ann.title + '"', 'fa-heart');
            saveState();
            renderPinned();
            showToast(likes[id] ? '❤️ Liked!' : 'Like removed');
        }

        function togglePin(id) {
            pins[id] = !pins[id];
            saveState();
            window.dispatchEvent(new StorageEvent('storage', { key: 'campus_pins',  newValue: JSON.stringify(pins) }));
            window.dispatchEvent(new StorageEvent('storage', { key: 'teacher_pins', newValue: JSON.stringify(pins) }));
            renderPinned();
            showToast(pins[id] ? '📌 Pinned!' : 'Unpinned');
        }

        function openComments(id) {
            var sec = document.getElementById('cs-' + id);
            if (sec) sec.style.display = sec.style.display === 'none' ? 'block' : 'none';
        }

        function postComment(id) {
            var input = document.getElementById('ci-' + id);
            if (!input) return;
            var text = input.value.trim();
            if (!text) { showToast('Please write a comment first'); return; }
            var ann = loadDB().find(function(a) { return a.id === id; });
            if (!comments[id]) comments[id] = [];
            comments[id].push({ author:'You', text:text, time: new Date().toLocaleTimeString('en-US',{hour:'2-digit',minute:'2-digit'}) });
            if (ann) pushNotification('💬 New comment on "' + ann.title + '": ' + text, 'fa-comment');
            saveState();
            input.value = '';
            var cl = document.getElementById('cl-' + id);
            if (cl) cl.innerHTML = renderComments(id);
            showToast('💬 Comment posted!');
        }

        function sharePost(id, title) {
            var url = window.location.href.split('?')[0] + '?post=' + id;
            pushNotification('🔗 "' + title + '" was shared', 'fa-share-alt');
            saveState();
            if (navigator.clipboard) {
                navigator.clipboard.writeText(url).then(function() { showToast('🔗 Link copied: ' + title); });
            } else { showToast('📤 Shared!'); }
        }

        function renderPinned() {
            var announcementsDB = loadDB();
            var pinned = announcementsDB.filter(function(a) { return !!pins[a.id]; });
            var container = document.querySelector('.pinned-list');
            if (!container) return;

            if (!pinned.length) {
                container.innerHTML = '<div class="empty-state"><i class="fas fa-thumbtack" style="font-size:40px;margin-bottom:12px;opacity:0.4"></i><p>No pinned announcements yet.</p><p style="font-size:13px;margin-top:6px">Pin announcements from the main board to see them here.</p></div>';
                return;
            }

            container.innerHTML = pinned.map(function(ann) {
                var liked   = !!likes[ann.id];
                var lc      = likeCounts[ann.id] || 0;
                var cc      = (comments[ann.id] || []).length;
                var catCls  = getCatClass(ann.category);
                var catIcon = ann.category === 'Exam Schedule' ? 'fas fa-file-alt' : ann.category === 'Class Suspension' ? 'fas fa-cloud-rain' : 'fas fa-calendar-alt';

                return '<div class="pinned-card">'
                    + '<div class="card-top">'
                    +   '<div class="card-author">'
                    +     '<div class="avatar"><i class="' + catIcon + '"></i></div>'
                    +     '<div>'
                    +       '<div class="author-name">' + escapeHtml(ann.professor) + '</div>'
                    +       '<div class="meta">'
                    +         '<span><i class="far fa-calendar-alt"></i> ' + formatDate(ann.date) + (ann.time ? ' at ' + ann.time : '') + '</span>'
                    +         '<span class="cat-badge ' + catCls + '">' + escapeHtml(ann.category) + '</span>'
                    +       '</div>'
                    +     '</div>'
                    +   '</div>'
                    +   '<div style="display:flex;align-items:center;gap:8px">'
                    +     '<span class="status-pill"><i class="fas fa-thumbtack" style="margin-right:4px"></i>Pinned</span>'
                    +     '<button onclick="togglePin(' + ann.id + ')" style="background:none;border:none;cursor:pointer;font-size:18px;color:#ea580c;padding:4px" title="Unpin"><i class="fas fa-thumbtack"></i></button>'
                    +   '</div>'
                    + '</div>'
                    + '<div class="card-title">' + escapeHtml(ann.title) + '</div>'
                    + '<div class="card-text">' + escapeHtml(ann.description) + '</div>'
                    + '<div style="display:flex;gap:16px;padding:10px 0;border-top:1px solid var(--border);border-bottom:1px solid var(--border);color:var(--muted);font-size:13px;margin-top:14px">'
                    +   '<span onclick="toggleLike(' + ann.id + ')" style="cursor:pointer;display:flex;align-items:center;gap:5px"><i class="' + (liked?'fas':'far') + ' fa-heart" style="' + (liked?'color:#dc2626':'') + '"></i> ' + lc + ' Likes</span>'
                    +   '<span onclick="openComments(' + ann.id + ')" style="cursor:pointer;display:flex;align-items:center;gap:5px"><i class="far fa-comment"></i> ' + cc + ' Comments</span>'
                    +   '<span onclick="sharePost(' + ann.id + ',\'' + escapeHtml(ann.title) + '\')" style="cursor:pointer;display:flex;align-items:center;gap:5px"><i class="far fa-share-square"></i> Share</span>'
                    + '</div>'
                    + '<div style="display:flex;gap:4px;padding:6px 0">'
                    +   '<button onclick="toggleLike(' + ann.id + ')" style="flex:1;background:none;border:none;padding:8px;border-radius:10px;cursor:pointer;font-size:13px;color:' + (liked?'#dc2626':'var(--muted)') + ';display:flex;align-items:center;justify-content:center;gap:6px"><i class="' + (liked?'fas':'far') + ' fa-heart"></i> ' + (liked?'Liked':'Like') + '</button>'
                    +   '<button onclick="openComments(' + ann.id + ')" style="flex:1;background:none;border:none;padding:8px;border-radius:10px;cursor:pointer;font-size:13px;color:var(--muted);display:flex;align-items:center;justify-content:center;gap:6px"><i class="far fa-comment"></i> Comment</button>'
                    +   '<button onclick="sharePost(' + ann.id + ',\'' + escapeHtml(ann.title) + '\')" style="flex:1;background:none;border:none;padding:8px;border-radius:10px;cursor:pointer;font-size:13px;color:var(--muted);display:flex;align-items:center;justify-content:center;gap:6px"><i class="fas fa-share-alt"></i> Share</button>'
                    + '</div>'
                    + '<div id="cs-' + ann.id + '" style="display:none;border-top:1px solid var(--border);padding-top:12px">'
                    +   '<div style="display:flex;gap:8px;margin-bottom:10px">'
                    +     '<input id="ci-' + ann.id + '" type="text" placeholder="Write a comment..." style="flex:1;padding:9px 14px;background:var(--surface-soft,#f8fafc);border:1px solid var(--border);border-radius:30px;outline:none;font-size:13px;color:var(--page-text)">'
                    +     '<button onclick="postComment(' + ann.id + ')" style="background:linear-gradient(135deg,#1a3a5c,#2c5a7a);border:none;padding:0 18px;border-radius:30px;color:#fff;font-weight:600;cursor:pointer;font-size:13px">Post</button>'
                    +   '</div>'
                    +   '<div id="cl-' + ann.id + '">' + renderComments(ann.id) + '</div>'
                    + '</div>'
                    + '</div>';
            }).join('');
        }

        // ── Theme ──────────────────────────────────────────────
        function applyStoredTheme() {
            document.body.classList.toggle('dark-mode', localStorage.getItem(THEME_KEY) === 'dark');
        }

        window.addEventListener('storage', function(e) {
            if (e.key === THEME_KEY) applyStoredTheme();
            if (e.key === 'campus_pins' || e.key === 'teacher_pins') {
                pins = loadPins();
                renderPinned();
            }
            if (e.key === 'teacher_announcements') {
                renderPinned();
            }
        });

        applyStoredTheme();
        renderPinned();
    </script>
</body>
</html>