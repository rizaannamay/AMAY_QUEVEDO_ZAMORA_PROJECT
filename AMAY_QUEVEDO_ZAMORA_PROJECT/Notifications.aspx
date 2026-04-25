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
            gap: 10px;
            padding: 10px 18px;
            border-radius: 999px;
            background: var(--surface);
            color: var(--primary);
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            font-weight: 600;
            font-size: 14px;
            transition: background 0.2s;
        }
        .back-link:hover { background: var(--active-bg); }

        /* ── Announcement card style ── */
        .announce-card {
            background: var(--surface-strong);
            border: 1px solid #3B82F6;
            border-radius: 20px;
            margin-bottom: 16px;
            box-shadow: var(--shadow);
            overflow: hidden;
            transition: transform 0.2s, box-shadow 0.2s;
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
            --surface: rgba(15,25,55,0.75);
            --surface-strong: rgba(15,25,55,0.92);
            --surface-soft: rgba(255,255,255,0.07);
            --border: rgba(255,255,255,0.1);
            --primary: #818cf8;
            --primary-2: #6366f1;
            --muted: #94a3b8;
            --muted-light: #64748b;
            --shadow: 0 8px 32px rgba(0,0,0,0.5);
            --active-bg: rgba(99,102,241,0.18);
        }
        body.dark-mode {
            background-image: linear-gradient(rgba(0,0,0,0.35), rgba(0,0,0,0.35)), var(--bg-image);
        }
        body.dark-mode .announce-card {
            background: rgba(15,25,55,0.92);
            border-color: #3B82F6;
        }
        body.dark-mode .announce-card:hover { border-color: #93C5FD; }
        body.dark-mode .action-btn:hover { background: rgba(255,255,255,0.06); color: #93C5FD; }
        body.dark-mode .cat-exam       { background:rgba(30,58,138,0.3);  color:#93C5FD; }
        body.dark-mode .cat-suspension { background:rgba(198,40,40,0.2);  color:#ef9a9a; }
        body.dark-mode .cat-event      { background:rgba(22,101,52,0.25); color:#86efac; }
        body.dark-mode .toast-msg      { background:#6366f1; }

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
                    <a class="back-link" href="<%= BackUrl %>">
                        <i class="fas fa-arrow-left"></i>
                        <span><%= BackLabel %></span>
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
        // ── Notifications feed from campus_notifications ───────
        var THEME_KEY = 'campus_theme';

        function escapeHtml(s) {
            if (!s) return '';
            return String(s).replace(/[&<>"']/g, function(c) {
                return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c];
            });
        }

        function timeAgo(iso) {
            var diff = (Date.now() - new Date(iso).getTime()) / 1000;
            if (diff < 60)    return 'Just now';
            if (diff < 3600)  return Math.floor(diff / 60) + ' min ago';
            if (diff < 86400) return Math.floor(diff / 3600) + ' hr ago';
            return Math.floor(diff / 86400) + ' days ago';
        }

        function loadNotifs() {
            return JSON.parse(localStorage.getItem('campus_notifications') || '[]');
        }

        function saveNotifs(notifs) {
            localStorage.setItem('campus_notifications', JSON.stringify(notifs));
        }

        function showToast(msg) {
            var t = document.createElement('div');
            t.className = 'toast-msg';
            t.textContent = msg;
            document.body.appendChild(t);
            setTimeout(function() { if (t.parentNode) t.parentNode.removeChild(t); }, 2700);
        }

        function markAllRead() {
            var notifs = loadNotifs();
            notifs.forEach(function(n) { n.read = true; });
            saveNotifs(notifs);
            renderAll();
        }

        function markRead(idx) {
            var notifs = loadNotifs();
            if (notifs[idx]) { notifs[idx].read = true; saveNotifs(notifs); }
            renderAll();
        }

        function clearAll() {
            saveNotifs([]);
            renderAll();
        }

        function iconClass(icon) {
            var map = {
                'fa-bullhorn':  '#2563eb',
                'fa-heart':     '#dc2626',
                'fa-comment':   '#16a34a',
                'fa-share-alt': '#7c3aed',
                'fa-thumbtack': '#ea580c',
                'fa-bell':      '#d97706'
            };
            return map[icon] || '#1a3a5c';
        }

        function renderAll() {
            var container = document.getElementById('notifContainer');
            if (!container) return;
            var notifs = loadNotifs();

            if (!notifs.length) {
                container.innerHTML = '<div style="text-align:center;padding:60px 20px;color:var(--muted)">'
                    + '<i class="fas fa-bell-slash" style="font-size:48px;opacity:0.3;display:block;margin-bottom:16px"></i>'
                    + '<p style="font-size:16px;font-weight:600">No notifications yet</p>'
                    + '<p style="font-size:13px;margin-top:6px">Notifications will appear here when announcements are posted or when someone reacts.</p>'
                    + '</div>';
                return;
            }

            var unread = notifs.filter(function(n) { return !n.read; }).length;

            var header = '<div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px">'
                + '<span style="font-size:14px;color:var(--muted)">'
                + (unread > 0 ? '<strong style="color:var(--primary)">' + unread + ' unread</strong>' : 'All caught up!')
                + '</span>'
                + '<div style="display:flex;gap:8px">'
                + (unread > 0 ? '<button onclick="markAllRead()" style="background:none;border:1px solid var(--border);padding:6px 14px;border-radius:20px;font-size:12px;cursor:pointer;color:var(--primary);font-family:inherit">Mark all read</button>' : '')
                + '<button onclick="clearAll()" style="background:none;border:1px solid #fca5a5;padding:6px 14px;border-radius:20px;font-size:12px;cursor:pointer;color:#dc2626;font-family:inherit">Clear all</button>'
                + '</div></div>';

            var items = notifs.map(function(n, idx) {
                var color = iconClass(n.icon);
                var bg    = n.read ? 'var(--surface)' : 'var(--active-bg)';
                return '<div onclick="markRead(' + idx + ')" style="display:flex;align-items:flex-start;gap:14px;padding:16px 20px;background:' + bg + ';border:1px solid var(--border);border-radius:16px;margin-bottom:10px;cursor:pointer;transition:background 0.2s">'
                    + '<div style="width:42px;height:42px;border-radius:50%;background:' + color + '22;display:flex;align-items:center;justify-content:center;flex-shrink:0">'
                    + '<i class="fas ' + escapeHtml(n.icon) + '" style="color:' + color + ';font-size:16px"></i>'
                    + '</div>'
                    + '<div style="flex:1;min-width:0">'
                    + '<div style="font-size:14px;color:var(--page-text);line-height:1.5' + (n.read ? '' : ';font-weight:600') + '">' + escapeHtml(n.msg) + '</div>'
                    + '<div style="font-size:11px;color:var(--muted);margin-top:4px">' + timeAgo(n.time) + '</div>'
                    + '</div>'
                    + (!n.read ? '<div style="width:8px;height:8px;border-radius:50%;background:#3b82f6;flex-shrink:0;margin-top:6px"></div>' : '')
                    + '</div>';
            }).join('');

            container.innerHTML = header + items;
        }

        // ── Theme ──────────────────────────────────────────────
        function applyStoredTheme() {
            document.body.classList.toggle('dark-mode', localStorage.getItem(THEME_KEY) === 'dark');
        }

        window.addEventListener('storage', function(e) {
            if (e.key === THEME_KEY) applyStoredTheme();
            if (e.key === 'campus_notifications') renderAll();
        });

        applyStoredTheme();
        renderAll();
    </script>
</body>
</html>