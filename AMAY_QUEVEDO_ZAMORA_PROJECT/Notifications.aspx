<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Notifications.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Notifications" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Notifications - Campus Connect</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

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
        }

        html, body, form { min-height: 100%; }

        body {
            min-height: 100vh;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            color: var(--page-text);
            background-image: linear-gradient(rgba(255,255,255,0.3), rgba(255,255,255,0.3)), var(--bg-image);
            background-size: cover; background-repeat: no-repeat;
            background-position: center; background-attachment: fixed;
            transition: background 0.4s ease, color 0.4s ease;
        }

        a { color: inherit; text-decoration: none; }
        button { font: inherit; }

        /* ── Header (matches dashboard) ── */
        .header {
            background: #1a3a5c;
            border-radius: 24px;
            padding: 12px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            box-shadow: var(--shadow);
            margin: 16px 20px 0;
        }

        .logo {
            font-size: 20px; font-weight: 800; color: #fff;
            white-space: nowrap; cursor: pointer; background: none; border: none;
            display: flex; align-items: center; gap: 8px;
        }

        .header-right { display: flex; align-items: center; gap: 12px; }

        .back-btn {
            width: 40px; height: 40px; border-radius: 50%;
            background: rgba(255,255,255,0.15); border: 1px solid rgba(255,255,255,0.3);
            color: #fff; cursor: pointer; display: flex; align-items: center; justify-content: center;
            font-size: 16px; transition: background 0.2s;
        }
        .back-btn:hover { background: rgba(255,255,255,0.25); }

        .mark-all-btn {
            background: rgba(255,255,255,0.15); border: 1px solid rgba(255,255,255,0.3);
            color: #fff; border-radius: 999px; padding: 8px 16px;
            cursor: pointer; font-weight: 600; font-size: 13px; transition: background 0.2s;
        }
        .mark-all-btn:hover { background: rgba(255,255,255,0.25); }

        /* ── Page shell ── */
        .page-shell { padding: 16px 20px 24px; }
        .page-wrap { max-width: 800px; margin: 24px auto 0; display: flex; flex-direction: column; gap: 14px; }

        /* ── Summary card ── */
        .summary-card {
            background: var(--surface); backdrop-filter: blur(10px);
            border-radius: 20px; border: 1px solid var(--border);
            box-shadow: var(--shadow); padding: 18px 22px;
            display: flex; align-items: center; justify-content: space-between; gap: 16px;
        }

        .summary-left { display: flex; align-items: center; gap: 14px; }

        .summary-icon {
            width: 50px; height: 50px; border-radius: 14px;
            background: linear-gradient(135deg, #1a3a5c, #2563eb);
            color: #fff; display: flex; align-items: center; justify-content: center; font-size: 20px;
        }

        .summary-title { font-size: 16px; font-weight: 800; color: var(--primary); }
        .summary-text  { font-size: 13px; color: var(--muted); margin-top: 3px; }

        .badge-pill {
            display: inline-flex; align-items: center; justify-content: center;
            min-width: 36px; height: 36px; padding: 0 12px;
            border-radius: 999px; background: linear-gradient(135deg, #dc2626, #ef4444);
            color: #fff; font-weight: 800; font-size: 14px;
        }

        /* ── Notification items ── */
        .list-wrap { display: flex; flex-direction: column; gap: 10px; }

        .notif-item {
            background: var(--surface); backdrop-filter: blur(10px);
            border: 1px solid var(--border); border-radius: 18px;
            box-shadow: var(--shadow); overflow: hidden;
            transition: transform 0.2s ease, box-shadow 0.2s ease, border-color 0.2s ease;
            cursor: pointer;
        }

        .notif-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 28px rgba(0,0,0,0.10);
            border-color: rgba(26,58,92,0.25);
        }

        .notif-item.unread { border-left: 4px solid #1a3a5c; }

        .notif-row {
            display: flex; align-items: center; gap: 14px; padding: 16px 18px;
        }

        .notif-icon {
            width: 46px; height: 46px; border-radius: 14px;
            color: #fff; display: flex; align-items: center; justify-content: center;
            flex-shrink: 0; font-size: 18px;
        }

        .notif-like    { background: linear-gradient(135deg, #dc2626, #ef4444); }
        .notif-comment { background: linear-gradient(135deg, #1a3a5c, #2563eb); }
        .notif-share   { background: linear-gradient(135deg, #d97706, #f59e0b); }
        .notif-default { background: linear-gradient(135deg, #1a3a5c, #2c5a7a); }

        .notif-main { flex: 1; min-width: 0; }

        .notif-head {
            display: flex; align-items: center; justify-content: space-between;
            gap: 12px; flex-wrap: wrap;
        }

        .notif-message {
            font-size: 14px; font-weight: 700; color: var(--primary);
            line-height: 1.45; word-break: break-word;
        }

        .notif-time { font-size: 12px; color: var(--muted); white-space: nowrap; }

        .notif-sub {
            margin-top: 5px; display: flex; align-items: center; gap: 8px;
        }

        .notif-state { font-size: 12px; color: var(--muted); }

        .notif-unread-dot {
            width: 8px; height: 8px; border-radius: 50%; background: #dc2626;
            box-shadow: 0 0 0 3px rgba(220,38,38,0.14); flex-shrink: 0;
        }

        .notif-item:not(.unread) .notif-unread-dot { display: none; }

        .notif-chevron { color: var(--muted-light); font-size: 13px; flex-shrink: 0; }

        /* ── Empty state ── */
        .empty-state {
            background: var(--surface); border: 1px solid var(--border);
            border-radius: 20px; box-shadow: var(--shadow);
            padding: 60px 20px; text-align: center;
        }

        .empty-state i { font-size: 48px; color: var(--muted-light); display: block; margin-bottom: 14px; }
        .empty-title { font-size: 18px; font-weight: 800; color: var(--primary); }
        .empty-text  { font-size: 13px; color: var(--muted); margin-top: 8px; }

        /* ── Toast ── */
        .toast-msg {
            position: fixed; bottom: 26px; left: 50%; transform: translateX(-50%);
            background: #1a3a5c; color: #fff; padding: 10px 24px;
            border-radius: 999px; font-size: 13px; z-index: 9999;
            box-shadow: 0 8px 24px rgba(0,0,0,0.20); pointer-events: none;
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
            --shadow: 0 8px 32px rgba(0, 0, 0, 0.6);
        }

        body.dark-mode {
            background-image: linear-gradient(rgba(15,23,42,0.85), rgba(15,23,42,0.85)), var(--bg-image);
        }

        body.dark-mode .notif-item.unread { border-left-color: #3b82f6; }
        body.dark-mode .notif-message { color: #e0e7ff; }
        body.dark-mode .summary-title { color: #e0e7ff; }

        @media (max-width: 700px) {
            .header { margin: 10px 10px 0; padding: 10px 16px; }
            .page-shell { padding: 10px 10px 32px; }
            .notif-row { padding: 12px 14px; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            <button type="button" class="logo" onclick="window.location.href='<%= BackUrl %>'">
                <i class="fas fa-university"></i> Campus Announcement
            </button>
            <div class="header-right">
                <button type="button" class="mark-all-btn" onclick="markAllNotificationsRead()">
                    <i class="fas fa-check-double"></i> Mark all read
                </button>
                <button type="button" class="back-btn" onclick="window.location.href='<%= BackUrl %>'" title="Back to Portal">
                    <i class="fas fa-home"></i>
                </button>
            </div>
        </div>

        <div class="page-shell">
            <div class="page-wrap">
                <div class="summary-card">
                    <div class="summary-left">
                        <div class="summary-icon"><i class="fas fa-bell"></i></div>
                        <div>
                            <div class="summary-title">Notifications</div>
                            <div class="summary-text">Likes, comments, and shares on your posts</div>
                        </div>
                    </div>
                    <div id="unreadBadge" class="badge-pill" style="display:none;">0</div>
                </div>

                <div id="notifList" class="list-wrap">
                    <div class="empty-state">
                        <i class="fas fa-spinner fa-spin"></i>
                        <div class="empty-title">Loading notifications...</div>
                        <div class="empty-text">Please wait a moment.</div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>
        // Apply saved theme
        (function () {
            document.body.classList.toggle('dark-mode', localStorage.getItem('campus_theme') === 'dark');
            window.addEventListener('storage', function (e) {
                if (e.key === 'campus_theme') document.body.classList.toggle('dark-mode', e.newValue === 'dark');
            });
        })();

        function escapeHtml(s) {
            if (!s) return '';
            return String(s).replace(/[&<>"']/g, function (c) {
                return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c];
            });
        }

        function showToast(msg) {
            var t = document.createElement('div');
            t.className = 'toast-msg';
            t.textContent = msg;
            document.body.appendChild(t);
            setTimeout(function () { if (t.parentNode) t.parentNode.removeChild(t); }, 2200);
        }

        function getNotifType(message) {
            var text = (message || '').toLowerCase();
            if (text.indexOf('liked') !== -1)    return 'like';
            if (text.indexOf('commented') !== -1) return 'comment';
            if (text.indexOf('shared') !== -1)    return 'share';
            return 'default';
        }

        function getNotifIcon(type) {
            if (type === 'like')    return 'fa-heart';
            if (type === 'comment') return 'fa-comment';
            if (type === 'share')   return 'fa-share-alt';
            return 'fa-bell';
        }

        function getNotifClass(type) {
            if (type === 'like')    return 'notif-like';
            if (type === 'comment') return 'notif-comment';
            if (type === 'share')   return 'notif-share';
            return 'notif-default';
        }

        function renderNotifications(list) {
            var container = document.getElementById('notifList');
            if (!container) return;

            var unreadCount = 0;
            for (var i = 0; i < list.length; i++) { if (!list[i].isRead) unreadCount++; }

            var badge = document.getElementById('unreadBadge');
            if (badge) {
                badge.textContent = unreadCount;
                badge.style.display = unreadCount > 0 ? 'inline-flex' : 'none';
            }

            if (!list || !list.length) {
                container.innerHTML =
                    '<div class="empty-state">' +
                    '<i class="fas fa-bell-slash"></i>' +
                    '<div class="empty-title">No notifications yet</div>' +
                    '<div class="empty-text">Reactions to your announcements will appear here.</div>' +
                    '</div>';
                return;
            }

            container.innerHTML = list.map(function (item) {
                var type = getNotifType(item.message);
                var icon = getNotifIcon(type);
                var iconClass = getNotifClass(type);
                var stateText = item.isRead ? 'Read' : 'Unread';

                return '<div class="notif-item' + (item.isRead ? '' : ' unread') + '" onclick="openNotification(' + item.id + ',' + item.announcementId + ')">' +
                    '<div class="notif-row">' +
                    '<div class="notif-icon ' + iconClass + '"><i class="fas ' + icon + '"></i></div>' +
                    '<div class="notif-main">' +
                    '<div class="notif-head">' +
                    '<div class="notif-message">' + escapeHtml(item.message) + '</div>' +
                    '<div class="notif-time">' + escapeHtml(item.time || item.createdDate || '') + '</div>' +
                    '</div>' +
                    '<div class="notif-sub">' +
                    '<span class="notif-unread-dot"></span>' +
                    '<span class="notif-state">' + stateText + '</span>' +
                    '</div>' +
                    '</div>' +
                    '<i class="fas fa-chevron-right notif-chevron"></i>' +
                    '</div>' +
                    '</div>';
            }).join('');
        }

        function loadNotifications() {
            fetch('NotificationHandler.ashx?action=getAll', { credentials: 'same-origin' })
                .then(function (r) { return r.json(); })
                .then(function (res) {
                    if (!res.ok) {
                        document.getElementById('notifList').innerHTML =
                            '<div class="empty-state"><i class="fas fa-exclamation-triangle"></i>' +
                            '<div class="empty-title">Could not load notifications</div>' +
                            '<div class="empty-text">' + escapeHtml(res.error || 'Please try again.') + '</div></div>';
                        return;
                    }
                    renderNotifications(res.data || []);
                })
                .catch(function () {
                    document.getElementById('notifList').innerHTML =
                        '<div class="empty-state"><i class="fas fa-wifi"></i>' +
                        '<div class="empty-title">Connection problem</div>' +
                        '<div class="empty-text">Please check your connection and try again.</div></div>';
                });
        }

        function openNotification(notificationId, announcementId) {
            fetch('NotificationHandler.ashx?action=markRead&id=' + encodeURIComponent(notificationId), { credentials: 'same-origin' })
                .then(function () {
                    var backUrl = '<%= BackUrl %>';
                    if (announcementId && announcementId > 0) {
                        window.location.href = backUrl + '?postId=' + encodeURIComponent(announcementId);
                    } else {
                        window.location.href = backUrl;
                    }
                })
                .catch(function () {
                    window.location.href = '<%= BackUrl %>';
                });
        }

        function markAllNotificationsRead() {
            fetch('NotificationHandler.ashx?action=markAllRead', { credentials: 'same-origin' })
                .then(function (r) { return r.json(); })
                .then(function (res) {
                    if (!res.ok) { showToast('Could not mark as read'); return; }
                    showToast('✅ All notifications marked as read');
                    loadNotifications();
                })
                .catch(function () { showToast('Could not mark as read'); });
        }

        loadNotifications();
    </script>
</body>
</html>


