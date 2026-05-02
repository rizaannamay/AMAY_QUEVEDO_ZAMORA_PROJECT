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

        a { color: inherit; text-decoration: none; }

        .page-shell {
            min-height: 100vh;
            padding: 48px 32px 32px;
        }

        .page-wrap {
            max-width: 100%;
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

        .pinned-list { display: grid; gap: 20px; grid-template-columns: 1fr; }

        .pinned-card {
            background: var(--surface);
            backdrop-filter: blur(12px);
            border-radius: 20px;
            border: 1px solid #3B82F6;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.10);
            padding: 24px;
            transition: transform 0.25s ease, box-shadow 0.25s ease, border-color 0.25s ease;
        }

        .pinned-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 28px rgba(0,0,0,0.12);
            border-color: #1E3A8A;
        }

        .card-top {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 18px;
            margin-bottom: 18px;
        }

        .card-author { display: flex; align-items: center; gap: 16px; }

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

        .author-name { font-size: 17px; font-weight: 700; color: var(--primary); }

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

        .pin-icon { color: #ea580c; font-size: 24px; padding-top: 6px; }

        .card-title { font-size: 21px; font-weight: 800; color: var(--primary); margin-bottom: 12px; }

        .card-text { font-size: 16px; line-height: 1.65; margin-bottom: 22px; }

        .card-image img {
            width: 100%;
            max-height: 200px;
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

        .cat-badge { display:inline-block;padding:2px 10px;border-radius:20px;font-size:10px;font-weight:700; }
        .cat-exam       { background:#DBEAFE;color:#1E3A8A; }
        .cat-suspension { background:#ffebee;color:#c62828; }
        .cat-event      { background:#dcfce7;color:#166534; }
        .cat-default    { background:#EDE9FE;color:#5B21B6; }

        .post-stats {
            display: flex;
            gap: 20px;
            padding: 10px 0;
            border-top: 1px solid var(--border);
            border-bottom: 1px solid var(--border);
            color: var(--muted);
            font-size: 13px;
            margin-top: 14px;
        }

        .post-stats span {
            display: flex;
            align-items: center;
            gap: 6px;
            cursor: pointer;
            transition: color 0.2s;
        }

        .post-stats span:hover { color: var(--primary); }

        .action-buttons {
            display: flex;
            gap: 4px;
            padding: 6px 0;
            width: 100%;
        }

        .action-btn {
            flex: 1;
            background: none;
            border: none;
            padding: 10px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 13px;
            color: var(--muted);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            transition: all 0.2s;
            white-space: nowrap;
        }

        .action-btn:hover { background: rgba(26,58,92,0.07); color: var(--primary); }
        .action-btn.liked { color: #dc2626; }

        .comments-section {
            border-top: 1px solid var(--border);
            padding-top: 14px;
            margin-top: 4px;
        }

        .comment-input {
            display: flex;
            gap: 8px;
            margin-bottom: 12px;
        }

        .comment-input input {
            flex: 1;
            padding: 10px 16px;
            background: var(--surface-soft, #f8fafc);
            border: 1px solid var(--border);
            border-radius: 30px;
            outline: none;
            font-size: 13px;
            color: var(--page-text);
        }

        .comment-input button {
            background: linear-gradient(135deg, #1a3a5c, #2c5a7a);
            border: none;
            padding: 0 20px;
            border-radius: 30px;
            color: #fff;
            font-weight: 600;
            cursor: pointer;
            font-size: 13px;
        }

        .comment-item {
            display: flex;
            gap: 10px;
            padding: 8px 0;
            border-bottom: 1px solid var(--border);
            font-size: 13px;
        }

        .comment-item:last-child { border-bottom: none; }

        .comment-avatar {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background: #e8f0fe;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            color: var(--primary);
            font-size: 11px;
            overflow: hidden;
        }

        .comment-author { font-weight: 700; color: var(--primary); }
        .comment-text   { color: var(--page-text); margin-top: 2px; }
        .comment-time   { font-size: 10px; color: var(--muted); margin-top: 2px; }

        .no-comments {
            padding: 12px 0;
            text-align: center;
            font-size: 12px;
            color: var(--muted);
        }

        /* Dark Mode */
        .dark-mode {
            --bg-image: url('bg.jpg');
            --page-text: #e4e6eb;
            --surface: rgba(30, 41, 59, 0.95);
            --surface-strong: rgba(30, 41, 59, 0.98);
            --border: rgba(148, 163, 184, 0.2);
            --primary: #93c5fd;
            --primary-2: #60a5fa;
            --muted: #cbd5e1;
            --shadow: 0 14px 34px rgba(0, 0, 0, 0.6);
        }

        body.dark-mode {
            background-image: linear-gradient(rgba(15, 23, 42, 0.85), rgba(15, 23, 42, 0.85)), var(--bg-image);
        }

        body.dark-mode .pinned-card {
            background: rgba(30, 41, 59, 0.95);
            border-color: #3B82F6;
        }

        body.dark-mode .pinned-card:hover {
            border-color: #60a5fa;
            background: rgba(30, 41, 59, 1);
        }

        body.dark-mode .status-pill {
            background: rgba(251, 146, 60, 0.25);
            color: #fdba74;
        }

        body.dark-mode .card-title,
        body.dark-mode .author-name,
        body.dark-mode .page-title { color: #e0e7ff; }

        body.dark-mode .page-title i { color: #93c5fd; }
        body.dark-mode .card-text   { color: #e2e8f0; }
        body.dark-mode .meta        { color: #cbd5e1; }

        body.dark-mode .cat-exam       { background: rgba(59, 130, 246, 0.25);  color: #93c5fd; }
        body.dark-mode .cat-suspension { background: rgba(239, 68, 68, 0.25);   color: #fca5a5; }
        body.dark-mode .cat-event      { background: rgba(34, 197, 94, 0.25);   color: #86efac; }
        body.dark-mode .cat-default    { background: rgba(139, 92, 246, 0.25);  color: #c4b5fd; }

        body.dark-mode .action-btn        { color: #cbd5e1; }
        body.dark-mode .action-btn:hover  { background: rgba(59, 130, 246, 0.15); color: #93c5fd; }
        body.dark-mode .action-btn.liked  { color: #f87171; }

        body.dark-mode .comment-avatar {
            background: rgba(59, 130, 246, 0.2);
            color: #93c5fd;
        }

        body.dark-mode .comment-author { color: #c7d2fe; }
        body.dark-mode .comment-text   { color: #e2e8f0; }

        body.dark-mode .comment-input input {
            background: rgba(51, 65, 85, 0.6);
            border-color: rgba(148, 163, 184, 0.3);
            color: #f1f5f9;
        }

        body.dark-mode .comment-input input::placeholder { color: #94a3b8; }

        body.dark-mode .comment-input button {
            background: linear-gradient(135deg, #3B82F6, #60a5fa);
        }

        body.dark-mode .post-stats span { color: #cbd5e1; }
        body.dark-mode .post-stats span:hover { color: #93c5fd; }

        body.dark-mode .empty-state {
            background: rgba(30, 41, 59, 0.95);
            color: #cbd5e1;
        }

        body.dark-mode .comments-section {
            border-top-color: rgba(148, 163, 184, 0.2);
        }

        @media (max-width: 768px) {
            .page-shell { padding: 24px 16px; }
            .page-header { flex-direction: column; align-items: flex-start; }
            .page-title { font-size: 28px; }
            .pinned-card { padding: 20px; }
            .card-top { flex-direction: column; }
        }    </style>
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
                    <a class="back-link" href="<%= BackUrl %>" title="Back to Portal">
                        <i class="fas fa-home" style="font-size:18px;"></i>
                    </a>
                </div>
                <div class="pinned-list">
                    <div style="text-align:center;padding:40px;">Loading pinned announcements...</div>
                </div>
            </div>
        </div>
    </form>

    <script>
        var THEME_KEY = 'campus_theme';
        var pinnedDB = [];
        var pins = {};
        var likes = {};
        var likeCounts = {};

        // ── Helpers ───────────────────────────────────────────
        function escapeHtml(s) {
            if (!s) return '';
            return String(s).replace(/[&<>"']/g, function (c) {
                return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c];
            });
        }

        function formatDate(d) {
            if (!d) return '';
            var date = new Date(d);
            if (isNaN(date)) return d;
            var now = new Date();
            var sec = Math.floor((now - date) / 1000);
            if (sec < 60)  return 'Just now';
            var min = Math.floor(sec / 60);
            if (min < 60)  return min + (min === 1 ? ' min ago' : ' mins ago');
            var hr = Math.floor(min / 60);
            if (hr < 24)   return hr + (hr === 1 ? ' hour ago' : ' hours ago');
            var day = Math.floor(hr / 24);
            if (day < 7)   return day + (day === 1 ? ' day ago' : ' days ago');
            var wk = Math.floor(day / 7);
            if (wk < 5)    return wk + (wk === 1 ? ' week ago' : ' weeks ago');
            var mo = Math.floor(day / 30);
            if (mo < 12)   return mo + (mo === 1 ? ' month ago' : ' months ago');
            var yr = Math.floor(day / 365);
            return yr + (yr === 1 ? ' year ago' : ' years ago');
        }

        function getCatClass(cat) {
            if (cat === 'Exam Schedule') return 'cat-exam';
            if (cat === 'Class Suspension') return 'cat-suspension';
            if (cat === 'Campus Events') return 'cat-event';
            return 'cat-default';
        }

        function showToast(msg) {
            var t = document.createElement('div');
            t.textContent = msg;
            t.style.cssText = 'position:fixed;bottom:28px;left:50%;transform:translateX(-50%);background:#1a3a5c;color:#fff;padding:10px 24px;border-radius:30px;font-size:13px;z-index:9999;box-shadow:0 4px 16px rgba(0,0,0,.25);pointer-events:none;';
            document.body.appendChild(t);
            setTimeout(function () { if (t.parentNode) t.parentNode.removeChild(t); }, 2500);
        }

        // ── Load from DB ──────────────────────────────────────
        function loadFromDB(callback) {
            Promise.all([
                fetch('AnnouncementHandler.ashx?action=getAll', { credentials: 'same-origin' }).then(function (r) { return r.json(); }),
                fetch('UserPinHandler.ashx?action=getUserPins', { credentials: 'same-origin' }).then(function (r) { return r.json(); })
            ]).then(function (results) {
                    var res    = results[0];
                    var pinRes = results[1];

                    if (!res.ok) { if (callback) callback([]); return; }

                    // Build pin map from DB (user pins + admin global pins)
                    pins = {};
                    if (pinRes.ok && pinRes.pinnedIds) {
                        pinRes.pinnedIds.forEach(function (id) { pins[id] = true; });
                    }

                    pinnedDB = res.data.map(function (a) {
                        var pinned = !!pins[a.id];

                        likes[a.id] = !!a.userLiked;
                        likeCounts[a.id] = a.likeCount || 0;

                        var cat = a.category || '';
                        var catLabel = cat === 'Exam' ? 'Exam Schedule'
                            : cat === 'Suspension' ? 'Class Suspension'
                                : cat === 'Event' ? 'Campus Events'
                                    : cat;

                        return {
                            id: a.id,
                            title: a.title || '',
                            category: catLabel,
                            date: a.date || '',
                            professor: a.author || '',
                            authorImage: a.authorImage || '',
                            description: a.content || '',
                            imageUrl: a.imageUrl || '',
                            isPinned: pinned,
                            likeCount: a.likeCount || 0,
                            commentCount: a.commentCount || 0,
                            userLiked: !!a.userLiked
                        };
                    });

                    if (callback) callback(pinnedDB);
                })
                .catch(function () { if (callback) callback([]); });
        }

        // ── Like ──────────────────────────────────────────────
        function toggleLike(id) {
            fetch('LikeHandler.ashx?action=toggle&postId=' + id, { credentials: 'same-origin' })
                .then(function (r) { return r.json(); })
                .then(function (res) {
                    if (!res.ok) { showToast('Error: ' + (res.error || 'Could not update like')); return; }

                    likes[id] = res.liked;
                    likeCounts[id] = res.likeCount;

                    var ann = pinnedDB.find(function (a) { return a.id === id; });
                    if (ann) { ann.userLiked = res.liked; ann.likeCount = res.likeCount; }

                    var card = document.querySelector('.pinned-card[data-post-id="' + id + '"]');
                    if (card) {
                        // Update stats icon
                        var likeStatIcon = card.querySelector('.like-stat-icon');
                        if (likeStatIcon) {
                            likeStatIcon.className = 'like-stat-icon ' + (res.liked ? 'fas' : 'far') + ' fa-heart';
                            likeStatIcon.style.color = res.liked ? '#dc2626' : '';
                        }
                        // Update stats count
                        var likeStatCount = card.querySelector('.like-stat-count');
                        if (likeStatCount) likeStatCount.textContent = res.likeCount;

                        // Update action button
                        var likeBtn = card.querySelector('.like-action-btn');
                        if (likeBtn) {
                            likeBtn.className = 'action-btn like-action-btn' + (res.liked ? ' liked' : '');
                            likeBtn.innerHTML = '<i class="' + (res.liked ? 'fas' : 'far') + ' fa-heart"></i> ' + (res.liked ? 'Liked' : 'Like');
                        }
                    }

                    showToast(res.liked ? '❤️ Liked!' : 'Like removed');
                })
                .catch(function () { showToast('Could not update like'); });
        }

        // ── Pin ───────────────────────────────────────────────
        function togglePin(id) {
            fetch('UserPinHandler.ashx?action=toggle&announcementId=' + id, { credentials: 'same-origin' })
                .then(function (r) { return r.json(); })
                .then(function (res) {
                    if (!res.ok) { showToast('Error: ' + (res.error || 'Could not update pin')); return; }
                    if (res.isPinned) {
                        pins[id] = true;
                    } else {
                        delete pins[id];
                    }
                    renderPinned();
                    showToast(res.isPinned ? '📌 Pinned!' : 'Unpinned');
                })
                .catch(function () { showToast('Could not update pin'); });
        }

        // ── Comments ──────────────────────────────────────────
        function toggleComments(id) {
            var sec = document.getElementById('cs-' + id);
            if (!sec) return;
            var isHidden = sec.style.display === 'none' || sec.style.display === '';
            sec.style.display = isHidden ? 'block' : 'none';
            if (isHidden) loadComments(id);
        }

        function loadComments(id) {
            var cl = document.getElementById('cl-' + id);
            if (!cl) return;
            cl.innerHTML = '<div style="text-align:center;padding:10px;color:var(--muted)"><i class="fas fa-spinner fa-spin"></i> Loading...</div>';
            fetch('CommentHandler.ashx?action=get&postId=' + id, { credentials: 'same-origin' })
                .then(function (r) { return r.json(); })
                .then(function (list) {
                    if (!list.length) {
                        cl.innerHTML = '<div class="no-comments">No comments yet. Be the first to comment!</div>';
                        return;
                    }
                    cl.innerHTML = list.map(function (c) {
                        var avatar = c.profileImage
                            ? '<img src="' + escapeHtml(c.profileImage) + '" style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;">'
                            : '<i class="fas fa-user"></i>';
                        return '<div class="comment-item">'
                            + '<div class="comment-avatar">' + avatar + '</div>'
                            + '<div style="flex:1;min-width:0;">'
                            + '<div class="comment-author">' + escapeHtml(c.author) + '</div>'
                            + '<div class="comment-text">' + escapeHtml(c.text) + '</div>'
                            + '<div class="comment-time">' + escapeHtml(c.date) + '</div>'
                            + '</div>'
                            + '</div>';
                    }).join('');
                })
                .catch(function () {
                    cl.innerHTML = '<div class="no-comments">Could not load comments.</div>';
                });
        }

        function postComment(id) {
            var input = document.getElementById('ci-' + id);
            if (!input) return;
            var text = input.value.trim();
            if (!text) { showToast('Write a comment first'); return; }

            // Disable button while posting
            var btn = input.nextElementSibling;
            if (btn) { btn.disabled = true; btn.textContent = '...'; }

            fetch('CommentHandler.ashx?action=add', {
                method: 'POST',
                credentials: 'same-origin',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ postId: id, comment: text })
            })
                .then(function (r) { return r.json(); })
                .then(function (res) {
                    if (btn) { btn.disabled = false; btn.textContent = 'Post'; }
                    if (!res.success) { showToast('Error: ' + (res.error || 'Could not post')); return; }
                    input.value = '';
                    loadComments(id);
                    // Bump comment count
                    var card = document.querySelector('.pinned-card[data-post-id="' + id + '"]');
                    if (card) {
                        var cc = card.querySelector('.comment-stat-count');
                        if (cc) cc.textContent = parseInt(cc.textContent || '0') + 1;
                    }
                    showToast('💬 Comment posted!');
                })
                .catch(function () {
                    if (btn) { btn.disabled = false; btn.textContent = 'Post'; }
                    showToast('Could not post comment');
                });
        }

        // ── Share ─────────────────────────────────────────────
        function sharePost(id, title) {
            var url = window.location.href.split('?')[0];
            if (navigator.clipboard) {
                navigator.clipboard.writeText(url)
                    .then(function () { showToast('🔗 Link copied!'); })
                    .catch(function () {
                        // Fallback
                        var dummy = document.createElement('input');
                        dummy.value = url;
                        document.body.appendChild(dummy);
                        dummy.select();
                        document.execCommand('copy');
                        document.body.removeChild(dummy);
                        showToast('🔗 Link copied!');
                    });
            } else {
                var dummy = document.createElement('input');
                dummy.value = url;
                document.body.appendChild(dummy);
                dummy.select();
                document.execCommand('copy');
                document.body.removeChild(dummy);
                showToast('🔗 Link copied!');
            }
            fetch('NotificationHandler.ashx?action=notifyShare&postId=' + id, { credentials: 'same-origin' })
                .catch(function () { });
        }

        // ── Render ────────────────────────────────────────────
        function renderPinned() {
            var pinned = pinnedDB.filter(function (a) { return !!pins[a.id]; });
            var container = document.querySelector('.pinned-list');
            if (!container) return;

            if (!pinned.length) {
                container.innerHTML = '<div class="empty-state">'
                    + '<i class="fas fa-thumbtack" style="font-size:40px;margin-bottom:12px;opacity:0.4;display:block"></i>'
                    + '<p style="font-size:16px;font-weight:600;">No pinned announcements yet.</p>'
                    + '<p style="font-size:13px;margin-top:6px">Pin announcements from the main board to see them here.</p>'
                    + '</div>';
                return;
            }

            container.innerHTML = pinned.map(function (ann) {
                var liked = !!ann.userLiked;
                var lc = ann.likeCount || 0;
                var cc = ann.commentCount || 0;
                var catCls = getCatClass(ann.category);
                var catIcon = ann.category === 'Exam Schedule' ? 'fas fa-file-alt'
                    : ann.category === 'Class Suspension' ? 'fas fa-cloud-rain'
                        : 'fas fa-calendar-alt';

                var avatarHtml = ann.authorImage
                    ? '<div class="avatar" style="overflow:hidden;"><img src="' + escapeHtml(ann.authorImage) + '" style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;" /></div>'
                    : '<div class="avatar"><i class="' + catIcon + '"></i></div>';

                return '<div class="pinned-card" data-post-id="' + ann.id + '">'

                    // ── Top row ──
                    + '<div class="card-top">'
                    + '<div class="card-author">'
                    + avatarHtml
                    + '<div>'
                    + '<div class="author-name">' + escapeHtml(ann.professor) + '</div>'
                    + '<div class="meta">'
                    + '<span><i class="far fa-calendar-alt"></i> ' + formatDate(ann.date) + '</span>'
                    + '<span class="cat-badge ' + catCls + '">' + escapeHtml(ann.category) + '</span>'
                    + '</div>'
                    + '</div>'
                    + '</div>'
                    + '<div style="display:flex;align-items:center;gap:8px;">'
                    + '<span class="status-pill"><i class="fas fa-thumbtack" style="margin-right:4px"></i>Pinned</span>'
                    + '<button onclick="togglePin(' + ann.id + ')" style="background:none;border:none;cursor:pointer;font-size:18px;color:#ea580c;padding:4px;" title="Unpin"><i class="fas fa-thumbtack"></i></button>'
                    + '</div>'
                    + '</div>'

                    // ── Content ──
                    + '<div class="card-title">' + escapeHtml(ann.title) + '</div>'
                    + '<div class="card-text">' + escapeHtml(ann.description) + '</div>'
                    + (ann.imageUrl ? '<div class="card-image" style="margin-top:12px;margin-bottom:12px;"><img src="' + escapeHtml(ann.imageUrl) + '" onerror="this.style.display=\'none\'" /></div>' : '')

                    // ── Stats row ──
                    + '<div class="post-stats">'
                    + '<span onclick="toggleLike(' + ann.id + ')">'
                    + '<i class="like-stat-icon ' + (liked ? 'fas' : 'far') + ' fa-heart"' + (liked ? ' style="color:#dc2626"' : '') + '></i>'
                    + ' <span class="like-stat-count">' + lc + '</span> Likes'
                    + '</span>'
                    + '<span onclick="toggleComments(' + ann.id + ')">'
                    + '<i class="far fa-comment"></i>'
                    + ' <span class="comment-stat-count">' + cc + '</span> Comments'
                    + '</span>'
                    + '<span onclick="sharePost(' + ann.id + ',\'' + escapeHtml(ann.title) + '\')">'
                    + '<i class="far fa-share-square"></i> Share'
                    + '</span>'
                    + '</div>'

                    // ── Action buttons ──
                    + '<div class="action-buttons">'
                    + '<button class="action-btn like-action-btn' + (liked ? ' liked' : '') + '" onclick="toggleLike(' + ann.id + ')">'
                    + '<i class="' + (liked ? 'fas' : 'far') + ' fa-heart"></i> ' + (liked ? 'Liked' : 'Like')
                    + '</button>'
                    + '<button class="action-btn" onclick="toggleComments(' + ann.id + ')">'
                    + '<i class="far fa-comment"></i> Comment'
                    + '</button>'
                    + '<button class="action-btn" onclick="sharePost(' + ann.id + ',\'' + escapeHtml(ann.title) + '\')">'
                    + '<i class="fas fa-share-alt"></i> Share'
                    + '</button>'
                    + '</div>'

                    // ── Comments section (hidden by default via style) ──
                    + '<div class="comments-section" id="cs-' + ann.id + '" style="display:none;">'
                    + '<div class="comment-input">'
                    + '<input id="ci-' + ann.id + '" type="text" placeholder="Write a comment..." />'
                    + '<button onclick="postComment(' + ann.id + ')">Post</button>'
                    + '</div>'
                    + '<div id="cl-' + ann.id + '"><div class="no-comments">No comments yet.</div></div>'
                    + '</div>'

                    + '</div>';
            }).join('');
        }

        // ── Theme ─────────────────────────────────────────────
        function applyStoredTheme() {
            document.body.classList.toggle('dark-mode', localStorage.getItem(THEME_KEY) === 'dark');
        }

        window.addEventListener('storage', function (e) {
            if (e.key === THEME_KEY) applyStoredTheme();
            if (e.key === 'student_pins') {
                try { pins = JSON.parse(localStorage.getItem('student_pins') || '{}'); } catch (ex) { }
                renderPinned();
            }
        });

        // ── Init ──────────────────────────────────────────────
        applyStoredTheme();
        loadFromDB(function () { renderPinned(); });
    </script>
</body>
</html> 