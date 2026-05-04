<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Notifications.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Notifications" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Notifications - Campus Connect</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --bg-image: url('wbg.jpg');
            --page-text: #2b6f68;
            --surface: rgba(255, 255, 255, 0.93);
            --surface-strong: #ffffff;
            --surface-soft: #f6f3ef;
            --border: rgba(103, 184, 169, 0.18);
            --primary: #5db6aa;
            --primary-strong: #2f8f86;
            --primary-2: #E28A6D;
            --accent: #E8C55E;
            --accent-strong: #D46565;
            --muted: #6f8f8a;
            --muted-light: #9ab7b2;
            --shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
            --active-bg: rgba(103, 184, 169, 0.14);
        }

        html, body, form {
            min-height: 100%;
        }

        body {
            min-height: 100vh;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            color: var(--page-text);
            background-image: linear-gradient(rgba(255, 255, 255, 0.20), rgba(255, 255, 255, 0.20)), var(--bg-image);
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            background-attachment: fixed;
        }

        a {
            color: inherit;
            text-decoration: none;
        }

        button {
            font: inherit;
        }

        .page-shell {
            min-height: 100vh;
            padding: 24px;
        }

        .page-wrap {
            max-width: 1100px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .topbar {
            background:
                linear-gradient(135deg, rgba(103,184,169,0.14), rgba(255,248,244,0.96) 42%, rgba(226,138,109,0.18)),
                var(--surface);
            backdrop-filter: blur(14px);
            border: 1px solid rgba(226,138,109,0.18);
            border-radius: 22px;
            padding: 16px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            box-shadow: var(--shadow);
            flex-wrap: wrap;
        }

        .topbar-left {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .topbar-title {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 20px;
            font-weight: 800;
            color: var(--primary-strong);
        }

        .topbar-sub {
            font-size: 13px;
            color: var(--muted);
        }

        .topbar-actions {
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
        }

        .back-btn {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--primary-2));
            color: #fff;
            border: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: var(--shadow);
        }

        .mark-all-btn {
            border: 1px solid rgba(103, 184, 169, 0.22);
            background: var(--surface-soft);
            color: var(--primary-strong);
            border-radius: 999px;
            padding: 10px 16px;
            cursor: pointer;
            font-weight: 700;
        }

        .summary-card {
            background: var(--surface);
            backdrop-filter: blur(12px);
            border-radius: 22px;
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            padding: 18px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            flex-wrap: wrap;
        }

        .summary-left {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .summary-icon {
            width: 52px;
            height: 52px;
            border-radius: 16px;
            background: linear-gradient(135deg, var(--primary), var(--primary-2));
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
        }

        .summary-title {
            font-size: 16px;
            font-weight: 800;
            color: var(--primary-strong);
        }

        .summary-text {
            font-size: 13px;
            color: var(--muted);
            margin-top: 4px;
        }

        .badge-pill {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 38px;
            height: 38px;
            padding: 0 14px;
            border-radius: 999px;
            background: linear-gradient(135deg, var(--accent-strong), var(--primary-2));
            color: #fff;
            font-weight: 800;
            font-size: 14px;
        }

        .list-wrap {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .notif-item {
            background: linear-gradient(145deg, rgba(255,255,255,0.96), rgba(247,244,240,0.96));
            border: 1px solid rgba(103, 184, 169, 0.20);
            border-radius: 22px;
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: transform 0.2s ease, box-shadow 0.2s ease, border-color 0.2s ease;
            cursor: pointer;
        }

        .notif-item:hover {
            transform: translateY(-1px);
            box-shadow: 0 14px 28px rgba(103, 184, 169, 0.10);
            border-color: rgba(226, 138, 109, 0.30);
        }

        .notif-item.unread {
            border-left: 5px solid var(--primary-strong);
        }

        .notif-row {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 18px 18px;
        }

        .notif-icon {
            width: 48px;
            height: 48px;
            border-radius: 16px;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            font-size: 18px;
        }

        .notif-like { background: linear-gradient(135deg, #d46565, #E28A6D); }
        .notif-comment { background: linear-gradient(135deg, #67B8A9, #2f8f86); }
        .notif-share { background: linear-gradient(135deg, #E8C55E, #E28A6D); }
        .notif-default { background: linear-gradient(135deg, #67B8A9, #E28A6D); }

        .notif-main {
            flex: 1;
            min-width: 0;
        }

        .notif-head {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            flex-wrap: wrap;
        }

        .notif-message {
            font-size: 15px;
            font-weight: 700;
            color: var(--primary-strong);
            line-height: 1.45;
            word-break: break-word;
        }

        .notif-time {
            font-size: 12px;
            color: var(--muted);
            white-space: nowrap;
        }

        .notif-sub {
            margin-top: 6px;
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }

        .notif-state {
            font-size: 12px;
            color: var(--muted);
        }

        .notif-unread-dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background: #dc2626;
            box-shadow: 0 0 0 3px rgba(220,38,38,0.14);
            flex-shrink: 0;
        }

        .notif-item:not(.unread) .notif-unread-dot {
            display: none;
        }

        .notif-chevron {
            color: var(--muted-light);
            font-size: 14px;
            flex-shrink: 0;
        }

        .empty-state {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 22px;
            box-shadow: var(--shadow);
            padding: 60px 20px;
            text-align: center;
        }

        .empty-state i {
            font-size: 48px;
            color: var(--primary);
            opacity: 0.35;
            display: block;
            margin-bottom: 14px;
        }

        .empty-title {
            font-size: 18px;
            font-weight: 800;
            color: var(--primary-strong);
        }

        .empty-text {
            font-size: 13px;
            color: var(--muted);
            margin-top: 8px;
        }

        .toast-msg {
            position: fixed;
            bottom: 26px;
            left: 50%;
            transform: translateX(-50%);
            background: #2f8f86;
            color: #fff;
            padding: 10px 24px;
            border-radius: 999px;
            font-size: 13px;
            z-index: 9999;
            box-shadow: 0 8px 24px rgba(0,0,0,0.20);
        }

        .dark-mode {
            --bg-image: url('bg.jpg');
            --page-text: #b9efe7;
            --surface: rgba(31, 42, 47, 0.95);
            --surface-strong: rgba(31, 42, 47, 0.98);
            --surface-soft: rgba(103, 184, 169, 0.10);
            --border: rgba(103, 184, 169, 0.22);
            --primary: #7fd8cc;
            --primary-strong: #9ee3d7;
            --primary-2: #E28A6D;
            --accent: #E8C55E;
            --accent-strong: #D46565;
            --muted: #9dc9c2;
            --muted-light: #7ea8a2;
            --shadow: 0 8px 32px rgba(0, 0, 0, 0.55);
            --active-bg: rgba(103, 184, 169, 0.18);
        }

        body.dark-mode {
            background-image: linear-gradient(rgba(15, 23, 42, 0.85), rgba(15, 23, 42, 0.85)), var(--bg-image);
        }

        body.dark-mode .topbar,
        body.dark-mode .summary-card,
        body.dark-mode .empty-state,
        body.dark-mode .notif-item {
            background: rgba(31, 42, 47, 0.95);
        }

        @media (max-width: 700px) {
            .page-shell { padding: 14px 12px 24px; }
            .topbar, .summary-card { padding: 14px; }
            .notif-row { padding: 14px; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-shell">
            <div class="page-wrap">
                <div class="topbar">
                    <div class="topbar-left">
                        <div>
                            <div class="topbar-title">
                                <i class="fas fa-bell"></i>
                                <span>Notifications</span>
                            </div>
                            <div class="topbar-sub">Click a notification to open the exact post.</div>
                        </div>
                    </div>

                    <div class="topbar-actions">
                        <button type="button" class="mark-all-btn" onclick="markAllNotificationsRead()">
                            <i class="fas fa-check-double"></i> Mark all as read
                        </button>
                        <a class="back-btn" href="<%= BackUrl %>" title="Back">
                            <i class="fas fa-home"></i>
                        </a>
                    </div>
                </div>

                <div class="summary-card">
                    <div class="summary-left">
                        <div class="summary-icon">
                            <i class="fas fa-envelope-open-text"></i>
                        </div>
                        <div>
                            <div class="summary-title">Activity Notifications</div>
                            <div class="summary-text"></div>
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
        (function () {
            document.body.classList.toggle('dark-mode', localStorage.getItem('campus_theme') === 'dark');
            window.addEventListener('storage', function (e) {
                if (e.key === 'campus_theme') {
                    document.body.classList.toggle('dark-mode', e.newValue === 'dark');
                }
            });
        })();

        function escapeHtml(s) {
            if (!s) return '';
            return String(s).replace(/[&<>"']/g, function (c) {
                return {
                    '&': '&amp;',
                    '<': '&lt;',
                    '>': '&gt;',
                    '"': '&quot;',
                    "'": '&#39;'
                }[c];
            });
        }

        function showToast(msg) {
            var t = document.createElement('div');
            t.className = 'toast-msg';
            t.textContent = msg;
            document.body.appendChild(t);
            setTimeout(function () {
                if (t.parentNode) t.parentNode.removeChild(t);
            }, 2200);
        }

        function getNotifType(message) {
            var text = (message || '').toLowerCase();
            if (text.indexOf('liked your announcement') !== -1) return 'like';
            if (text.indexOf('commented on your announcement') !== -1) return 'comment';
            if (text.indexOf('shared your announcement') !== -1) return 'share';
            return 'default';
        }

        function getNotifIcon(type) {
            if (type === 'like') return 'fa-heart';
            if (type === 'comment') return 'fa-comment';
            if (type === 'share') return 'fa-share-alt';
            return 'fa-bell';
        }

        function getNotifClass(type) {
            if (type === 'like') return 'notif-like';
            if (type === 'comment') return 'notif-comment';
            if (type === 'share') return 'notif-share';
            return 'notif-default';
        }

        function renderUnreadBadge(list) {
            var unreadCount = 0;
            for (var i = 0; i < list.length; i++) {
                if (!list[i].isRead) unreadCount++;
            }

            var badge = document.getElementById('unreadBadge');
            if (!badge) return;

            if (unreadCount > 0) {
                badge.textContent = unreadCount;
                badge.style.display = 'inline-flex';
            } else {
                badge.style.display = 'none';
            }
        }

        function renderNotifications(list) {
            var container = document.getElementById('notifList');
            if (!container) return;

            renderUnreadBadge(list);

            if (!list || !list.length) {
                container.innerHTML =
                    '<div class="empty-state">' +
                    '<i class="fas fa-bell-slash"></i>' +
                    '<div class="empty-title">No notifications yet</div>' +
                    '<div class="empty-text">Student reactions to your announcements will appear here.</div>' +
                    '</div>';
                return;
            }

            container.innerHTML = list.map(function (item) {
                var type = getNotifType(item.message);
                var icon = getNotifIcon(type);
                var iconClass = getNotifClass(type);
                var stateText = item.isRead ? 'Read' : 'Unread';

                return '' +
                    '<div class="notif-item' + (item.isRead ? '' : ' unread') + '" onclick="openNotification(' + item.id + ',' + item.announcementId + ')">' +
                    '<div class="notif-row">' +
                    '<div class="notif-icon ' + iconClass + '">' +
                    '<i class="fas ' + icon + '"></i>' +
                    '</div>' +
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
                            '<div class="empty-state">' +
                            '<i class="fas fa-exclamation-triangle"></i>' +
                            '<div class="empty-title">Could not load notifications</div>' +
                            '<div class="empty-text">' + escapeHtml(res.error || 'Please try again.') + '</div>' +
                            '</div>';
                        return;
                    }

                    renderNotifications(res.data || []);
                })
                .catch(function () {
                    document.getElementById('notifList').innerHTML =
                        '<div class="empty-state">' +
                        '<i class="fas fa-wifi"></i>' +
                        '<div class="empty-title">Connection problem</div>' +
                        '<div class="empty-text">Please check your connection and try again.</div>' +
                        '</div>';
                });
        }

        function openNotification(notificationId, announcementId) {
            fetch('NotificationHandler.ashx?action=markRead&id=' + encodeURIComponent(notificationId), { credentials: 'same-origin' })
                .then(function () {
                    if (announcementId && announcementId > 0) {
                        window.location.href = 'Teacher.aspx?postId=' + encodeURIComponent(announcementId);
                    } else {
                        window.location.href = 'Teacher.aspx';
                    }
                })
                .catch(function () {
                    if (announcementId && announcementId > 0) {
                        window.location.href = 'Teacher.aspx?postId=' + encodeURIComponent(announcementId);
                    } else {
                        window.location.href = 'Teacher.aspx';
                    }
                });
        }

        function markAllNotificationsRead() {
            fetch('NotificationHandler.ashx?action=markAllRead', { credentials: 'same-origin' })
                .then(function (r) { return r.json(); })
                .then(function (res) {
                    if (!res.ok) {
                        showToast('Could not mark notifications as read');
                        return;
                    }
                    showToast('All notifications marked as read');
                    loadNotifications();
                })
                .catch(function () {
                    showToast('Could not mark notifications as read');
                });
        }

        loadNotifications();
    </script>
</body>
</html>
