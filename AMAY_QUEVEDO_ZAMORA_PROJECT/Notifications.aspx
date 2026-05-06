<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Notifications.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Notifications" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Notifications - Campus Connect</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
<link rel="stylesheet" href="dark-mode.css" />
<link rel="stylesheet" href="responsive.css" />
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }
:root {
    --bg-image: url('wbg.jpg');
    --page-text: #1a2a3a;
    --surface: rgba(255,255,255,0.92);
    --surface-strong: #ffffff;
    --surface-soft: #f8fafc;
    --border: rgba(26,58,92,0.12);
    --primary: #1a2a3a;
    --primary-2: #c9920a;
    --muted: #6b7c8f;
    --muted-light: #9db0c4;
    --shadow: 0 8px 24px rgba(0,0,0,0.08);
    --active-bg: #fef9e7;
}
html, body, form { min-height: 100%; }
/* Cover strip — blocks content scrolling behind the fixed header */
body::before {
    content: '';
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    height: 80px;
    z-index: 199;
    pointer-events: none;
    background-image: linear-gradient(rgba(255,255,255,0.18),rgba(255,255,255,0.18)), var(--bg-image);
    background-size: cover;
    background-position: center;
    background-attachment: fixed;
}

body {
    min-height: 100vh;
    font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
    color: var(--page-text);
    background-image: linear-gradient(rgba(255,255,255,0.18),rgba(255,255,255,0.18)), var(--bg-image);
    background-size: cover;
    background-repeat: no-repeat;
    background-position: center;
    background-attachment: fixed;
}
a { color: inherit; text-decoration: none; }
button { font: inherit; }
.header {
    background: #c9920a;
    backdrop-filter: blur(10px);
    border-radius: 24px;
    padding: 12px 24px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 16px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.2);
    border: 1px solid rgba(255,255,255,0.15);
    position: fixed;
    top: 10px; left: 10px; right: 10px;
    z-index: 1200;
}
.header-title {
    display: flex;
    align-items: center;
    gap: 10px;
    font-size: 20px;
    font-weight: 800;
    color: #ffffff;
}
.header-sub {
    font-size: 12px;
    color: rgba(255,255,255,0.8);
    margin-top: 2px;
}
.header-actions {
    display: flex;
    align-items: center;
    gap: 10px;
    flex-wrap: wrap;
}
.mark-all-btn {
    border: 1px solid rgba(255,255,255,0.35);
    background: rgba(255,255,255,0.12);
    color: #ffffff;
    border-radius: 999px;
    padding: 10px 16px;
    cursor: pointer;
    font-weight: 700;
    font-size: 13px;
    transition: all 0.2s ease;
}
.mark-all-btn:hover { background: rgba(255,255,255,0.25); }
.home-btn {
    width: 42px; height: 42px;
    border-radius: 50%;
    background: rgba(255,255,255,0.15);
    border: 1px solid rgba(255,255,255,0.3);
    color: #fff;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 16px;
    transition: background 0.2s;
}
.home-btn:hover { background: rgba(255,255,255,0.25); }

/* ── Page shell ── */
.page-shell {
    min-height: 100vh;
    padding: 90px 10px 24px;
}
.page-wrap {
    max-width: calc(100% - 0px);
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    gap: 18px;
}

/* ── Summary card ── */
.summary-card {
    background: var(--surface);
    backdrop-filter: blur(12px);
    border-radius: 24px;
    border: 1px solid var(--border);
    box-shadow: var(--shadow);
    padding: 18px 20px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 16px;
    flex-wrap: wrap;
}
.summary-left { display: flex; align-items: center; gap: 14px; }
.summary-icon {
    width: 54px; height: 54px;
    border-radius: 16px;
    background: linear-gradient(135deg,#c9920a,#a87800);
    color: #fff;
    display: flex; align-items: center; justify-content: center;
    font-size: 22px; flex-shrink: 0;
}
.summary-title { font-size: 16px; font-weight: 800; color: var(--primary-2); }
.summary-text  { font-size: 13px; color: var(--muted); margin-top: 4px; }
.badge-pill {
    display: inline-flex; align-items: center; justify-content: center;
    min-width: 38px; height: 38px; padding: 0 14px;
    border-radius: 999px;
    background: linear-gradient(135deg,#dc2626,#ef4444);
    color: #fff; font-weight: 800; font-size: 14px;
}

/* ── Notification list ── */
.list-wrap { display: flex; flex-direction: column; gap: 14px; }
.notif-item {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: 24px;
    overflow: hidden;
    box-shadow: var(--shadow);
    transition: transform 0.18s ease, box-shadow 0.18s ease, border-color 0.18s ease;
    cursor: pointer;
}
.notif-item:hover { transform: translateY(-1px); box-shadow: 0 14px 28px rgba(0,0,0,0.10); border-color: rgba(201,146,10,0.35); }
.notif-item.unread { border-left: 5px solid #c9920a; }
.notif-row { display: flex; align-items: center; gap: 14px; padding: 20px; }
.notif-icon { width: 54px; height: 54px; border-radius: 18px; color: #fff; display: flex; align-items: center; justify-content: center; flex-shrink: 0; font-size: 22px; }
.notif-like    { background: linear-gradient(135deg,#d46565,#E28A6D); }
.notif-comment { background: linear-gradient(135deg,#c9920a,#a87800); }
.notif-reply   { background: linear-gradient(135deg,#7c3aed,#a78bfa); }
.notif-share   { background: linear-gradient(135deg,#E8C55E,#E28A6D); }
.notif-default { background: linear-gradient(135deg,#c9920a,#a87800); }
.notif-main { flex: 1; min-width: 0; }
.notif-head { display: flex; align-items: center; justify-content: space-between; gap: 12px; flex-wrap: wrap; }
.notif-message { font-size: 15px; font-weight: 800; color: var(--primary-2); line-height: 1.45; word-break: break-word; }
.notif-time { font-size: 12px; color: var(--muted); white-space: nowrap; }
.notif-sub { margin-top: 7px; display: flex; align-items: center; gap: 10px; flex-wrap: wrap; }
.notif-state { font-size: 12px; color: var(--muted); }
.notif-unread-dot { width: 10px; height: 10px; border-radius: 50%; background: #dc2626; box-shadow: 0 0 0 3px rgba(220,38,38,0.14); flex-shrink: 0; }
.notif-item:not(.unread) .notif-unread-dot { display: none; }
.notif-chevron { color: var(--muted-light); font-size: 20px; flex-shrink: 0; }

/* ── Empty state ── */
.empty-state { background: var(--surface); border: 1px solid var(--border); border-radius: 24px; box-shadow: var(--shadow); padding: 64px 20px; text-align: center; }
.empty-state i { font-size: 48px; color: var(--primary-2); opacity: 0.35; display: block; margin-bottom: 14px; }
.empty-title { font-size: 18px; font-weight: 800; color: var(--primary-2); }
.empty-text  { font-size: 13px; color: var(--muted); margin-top: 8px; }

.toast-msg { position: fixed; bottom: 26px; left: 50%; transform: translateX(-50%); background: #c9920a; color: #fff; padding: 10px 24px; border-radius: 999px; font-size: 13px; z-index: 9999; box-shadow: 0 8px 24px rgba(0,0,0,0.20); }

        .notif-row {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 20px 20px;
        }

        .notif-icon {
            width: 54px;
            height: 54px;
            border-radius: 18px;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            font-size: 22px;
        }

        .notif-like {
            background: linear-gradient(135deg, #d46565, #E28A6D);
        }

        .notif-comment {
            background: linear-gradient(135deg, #c9920a, #a87800);
        }

        .notif-share {
            background: linear-gradient(135deg, #E8C55E, #E28A6D);
        }

        .notif-default {
            background: linear-gradient(135deg, #c9920a, #a87800);
        }

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
            font-weight: 800;
            color: var(--primary-2);
            line-height: 1.45;
            word-break: break-word;
        }

        .notif-time {
            font-size: 12px;
            color: var(--muted);
            white-space: nowrap;
        }

        .notif-sub {
            margin-top: 7px;
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
            font-size: 20px;
            flex-shrink: 0;
        }

        .empty-state {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 24px;
            box-shadow: var(--shadow);
            padding: 64px 20px;
            text-align: center;
        }

        .empty-state i {
            font-size: 48px;
            color: var(--primary-2);
            opacity: 0.35;
            display: block;
            margin-bottom: 14px;
        }

        .empty-title {
            font-size: 18px;
            font-weight: 800;
            color: var(--primary-2);
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
            background: #c9920a;
            color: #fff;
            padding: 10px 24px;
            border-radius: 999px;
            font-size: 13px;
            z-index: 9999;
            box-shadow: 0 8px 24px rgba(0,0,0,0.20);
        }

        .dark-mode {
            --bg-image: url('bg.jpg');
            --page-text: #e4e6eb;
            --surface: rgba(15, 25, 55, 0.82);
            --surface-strong: rgba(15, 25, 55, 0.92);
            --surface-soft: rgba(255, 255, 255, 0.07);
            --border: rgba(255, 255, 255, 0.1);
            --primary: #818cf8;
            --primary-2: #fbbf24;
            --muted: #94a3b8;
            --muted-light: #cbd5e1;
            --active-bg: rgba(99, 102, 241, 0.18);
        }

        body.dark-mode {
            background-color: #0F172A;
            color: var(--page-text);
        }

        body.dark-mode .topbar,
        body.dark-mode .summary-card,
        body.dark-mode .notif-item,
        body.dark-mode .empty-state {
            background: rgba(15,25,55,0.88);
            border-color: rgba(255,255,255,0.08);
        }

        body.dark-mode .notif-message,
        body.dark-mode .summary-title,
        body.dark-mode .topbar-title {
            color: #67e8f9;
        }

        body.dark-mode .summary-text,
        body.dark-mode .notif-time,
        body.dark-mode .notif-state,
        body.dark-mode .topbar-sub,
        body.dark-mode .empty-text {
            color: #cbd5e1;
        }

@media (max-width: 700px) {
    .page-shell { padding: 100px 8px 24px; }
    .notif-row { padding: 14px; }
    .header { padding: 10px 16px; }
}
</style>
</head>
<body>
<form id="form1" runat="server">

<!-- ✅ Header matches Student.aspx style -->
<div class="header">
    <div>
        <div class="header-title">
            <i class="fas fa-bell"></i>
            <span>Notifications</span>
        </div>
        <div class="header-sub" id="topbarSub">Click a notification to open the related announcement.</div>
    </div>
    <div class="header-actions">
        <button type="button" class="mark-all-btn" onclick="markAllNotificationsRead()">
            <i class="fas fa-check-double"></i> Mark all as read
        </button>
        <button type="button" class="home-btn" id="homeBtn" title="Back to Portal">
            <i class="fas fa-home"></i>
        </button>
    </div>
</div>

<div class="page-shell">
    <div class="page-wrap">

        <!-- Summary -->
        <div class="summary-card">
            <div class="summary-left">
                <div class="summary-icon"><i class="fas fa-clipboard-list"></i></div>
                <div>
                    <div class="summary-title">Activity Notifications</div>
                    <div class="summary-text" id="summaryText">Loading...</div>
                </div>
            </div>
            <div id="unreadBadge" class="badge-pill" style="display:none;">0</div>
        </div>

        <!-- Notification List -->
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
var userRole  = '<%= Session["Role"] != null ? Session["Role"].ToString() : "Student" %>';
var isTeacher = userRole.toLowerCase() === 'admin';
var homeUrl   = isTeacher ? 'Teacher.aspx' : 'Student.aspx';
var portalUrl = isTeacher ? 'Teacher.aspx' : 'Student.aspx';

document.getElementById('homeBtn').onclick = function () { window.location.href = homeUrl; };

document.getElementById('topbarSub').textContent = isTeacher
    ? 'Student reactions to your announcements appear here.'
    : 'Teacher comments, replies, and likes on your activity appear here.';

document.getElementById('summaryText').textContent = isTeacher
    ? 'Likes, comments, and shares on your announcement posts appear here.'
    : 'You will be notified when a teacher comments, replies to, or likes your comment.';

// Theme
(function () {
    document.body.classList.toggle('dark-mode', localStorage.getItem('campus_theme') === 'dark');
    window.addEventListener('storage', function (e) {
        if (e.key === 'campus_theme')
            document.body.classList.toggle('dark-mode', e.newValue === 'dark');
    });
})();

function escapeHtml(s) {
    if (!s) return '';
    var d = document.createElement('div');
    d.appendChild(document.createTextNode(String(s)));
    return d.innerHTML;
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
    if (text.indexOf('(teacher) liked your comment') !== -1)    return 'like';
    if (text.indexOf('(teacher) replied to your comment') !== -1) return 'reply';
    if (text.indexOf('(teacher) commented on') !== -1)           return 'comment';
    if (text.indexOf('pinned announcement') !== -1)              return 'default';
    if (text.indexOf('liked your announcement') !== -1)          return 'like';
    if (text.indexOf('commented on your announcement') !== -1)   return 'comment';
    if (text.indexOf('replied on your announcement') !== -1)     return 'reply';
    if (text.indexOf('shared your announcement') !== -1)         return 'share';
    if (text.indexOf('liked your comment') !== -1)               return 'like';
    if (text.indexOf('new announcement') !== -1)                 return 'default';
    return 'default';
}

function getNotifIcon(type) {
    if (type === 'like')    return 'fa-heart';
    if (type === 'comment') return 'fa-comment';
    if (type === 'reply')   return 'fa-reply';
    if (type === 'share')   return 'fa-share-alt';
    return 'fa-bell';
}

function getNotifClass(type) {
    if (type === 'like')    return 'notif-like';
    if (type === 'comment') return 'notif-comment';
    if (type === 'reply')   return 'notif-reply';
    if (type === 'share')   return 'notif-share';
    return 'notif-default';
}

function renderUnreadBadge(list) {
    var count = 0;
    for (var i = 0; i < list.length; i++) { if (!list[i].isRead) count++; }
    var badge = document.getElementById('unreadBadge');
    if (!badge) return;
    if (count > 0) { badge.textContent = count; badge.style.display = 'inline-flex'; }
    else badge.style.display = 'none';
}

function renderNotifications(list) {
    var container = document.getElementById('notifList');
    if (!container) return;
    renderUnreadBadge(list);
    if (!list || !list.length) {
        var emptyMsg = isTeacher
            ? 'Student reactions to your announcements will appear here.'
            : 'When a teacher comments, replies, or likes your comment, it will show here.';
        container.innerHTML = '<div class="empty-state">'
            + '<i class="fas fa-bell-slash"></i>'
            + '<div class="empty-title">No notifications yet</div>'
            + '<div class="empty-text">' + emptyMsg + '</div>'
            + '</div>';
        return;
    }
    container.innerHTML = list.map(function (item) {
        var type      = getNotifType(item.message);
        var icon      = getNotifIcon(type);
        var iconClass = getNotifClass(type);
        var stateText = item.isRead ? 'Read' : 'Unread';
        return '<div class="notif-item' + (item.isRead ? '' : ' unread') + '" '
            + 'onclick="openNotification(' + item.id + ',' + item.announcementId + ')">'
            + '<div class="notif-row">'
            + '<div class="notif-icon ' + iconClass + '"><i class="fas ' + icon + '"></i></div>'
            + '<div class="notif-main">'
            + '<div class="notif-head">'
            + '<div class="notif-message">' + escapeHtml(item.message) + '</div>'
            + '<div class="notif-time">' + escapeHtml(item.time || item.createdDate || '') + '</div>'
            + '</div>'
            + '<div class="notif-sub">'
            + '<span class="notif-unread-dot"></span>'
            + '<span class="notif-state">' + stateText + '</span>'
            + '</div>'
            + '</div>'
            + '<i class="fas fa-chevron-right notif-chevron"></i>'
            + '</div>'
            + '</div>';
    }).join('');
}

function loadNotifications() {
    fetch('NotificationHandler.ashx?action=getAll', { credentials: 'same-origin' })
        .then(function (r) { return r.json(); })
        .then(function (res) {
            if (!res.ok) {
                document.getElementById('notifList').innerHTML = '<div class="empty-state">'
                    + '<i class="fas fa-exclamation-triangle"></i>'
                    + '<div class="empty-title">Could not load notifications</div>'
                    + '<div class="empty-text">' + escapeHtml(res.error || 'Please try again.') + '</div>'
                    + '</div>';
                return;
            }
            renderNotifications(res.data || []);
        }).catch(function () {
            document.getElementById('notifList').innerHTML = '<div class="empty-state">'
                + '<i class="fas fa-wifi"></i>'
                + '<div class="empty-title">Connection problem</div>'
                + '<div class="empty-text">Please check your connection and try again.</div>'
                + '</div>';
        });
}

function openNotification(notificationId, announcementId) {
    fetch('NotificationHandler.ashx?action=markRead&id=' + encodeURIComponent(notificationId), {
        credentials: 'same-origin'
    }).finally(function () {
        if (announcementId && announcementId > 0) {
            window.location.href = portalUrl + '?postId=' + encodeURIComponent(announcementId);
        } else {
            window.location.href = portalUrl;
        }
    });
}

function markAllNotificationsRead() {
    fetch('NotificationHandler.ashx?action=markAllRead', { credentials: 'same-origin' })
        .then(function (r) { return r.json(); })
        .then(function (res) {
            if (!res.ok) { showToast('Could not mark notifications as read'); return; }
            showToast('All notifications marked as read');
            loadNotifications();
        }).catch(function () { showToast('Could not mark notifications as read'); });
}

loadNotifications();
</script>
</body>
</html>
