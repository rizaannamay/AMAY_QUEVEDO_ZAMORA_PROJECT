<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pinned.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Pinned" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Pinned Announcements - Campus Connect</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="dark-mode.css" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        :root {
            --bg-image: url('wbg.jpg');
            --page-text: #1a2a3a;
            --surface: rgba(255, 255, 255, 0.92);
            --surface-strong: #ffffff;
            --surface-soft: #f8fafc;
            --border: rgba(26, 58, 92, 0.12);
            --primary: #1a2a3a;
            --primary-2: #a87800;
            --muted: #6b7c8f;
            --muted-light: #9db0c4;
            --shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
        }

        html, body, form { min-height: 100%; }
        html, body { overflow: auto; }

        /* Cover content that scrolls behind the fixed header */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: 80px;
            z-index: 199;
            pointer-events: none;
            background-image: var(--bg-image);
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

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

        /* ── Header (matches dashboard) ── */
        .header {
            background: #c9920a;
            border-radius: 24px;
            padding: 12px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            box-shadow: var(--shadow);
            position: fixed;
            top: 10px;
            left: 10px;
            right: 10px;
            z-index: 200;
        }

        .logo {
            font-size: 20px; font-weight: 800; color: #fff;
            white-space: nowrap; cursor: pointer; background: none; border: none;
            display: flex; align-items: center; gap: 8px;
        }

        .back-btn {
            width: 40px; height: 40px; border-radius: 50%;
            background: rgba(255,255,255,0.15); border: 1px solid rgba(255,255,255,0.3);
            color: #fff; cursor: pointer; display: flex; align-items: center; justify-content: center;
            font-size: 16px; transition: background 0.2s; text-decoration: none;
        }
        .back-btn:hover { background: rgba(255,255,255,0.25); }

        /* ── Page shell ── */
       .page-shell { padding: 80px 10px 24px; }

        .page-wrap { max-width: calc(100% - 20px); margin: 24px auto 0; }

        .page-title {
            display: flex; align-items: center; gap: 12px;
            font-size: 22px; font-weight: 800; color: var(--primary);
            margin-bottom: 20px;
        }

        .pinned-list { display: flex; flex-direction: column; gap: 18px; }

        /* ── Announcement card (matches dashboard style) ── */
        .pinned-card {
            background: var(--surface-strong);
            border-radius: 20px;
            border: 1px solid #c9920a;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            overflow: hidden;
            transition: all 0.3s;
        }

        .pinned-card:hover {
            box-shadow: 0 8px 18px rgba(0,0,0,0.08);
            border-color: #1E3A8A;
        }

        .post-header {
            display: flex; align-items: center; justify-content: space-between;
            padding: 18px 22px 12px;
        }

        .post-header-left { display: flex; align-items: center; gap: 14px; }

        .post-avatar {
            width: 50px; height: 50px; border-radius: 50%;
            background: linear-gradient(135deg, #c9920a, #a87800);
            color: #fff; display: flex; align-items: center; justify-content: center;
            font-size: 20px; flex-shrink: 0; overflow: hidden;
        }

        .post-author { font-weight: 700; font-size: 16px; color: var(--primary); }

        .post-meta {
            display: flex; gap: 10px; font-size: 12px; margin-top: 4px;
            flex-wrap: wrap; color: var(--muted);
        }

        .post-category {
            display: inline-block; padding: 2px 10px; border-radius: 20px;
            font-size: 10px; font-weight: 600;
        }

        .post-category-exam       { background: #fef3c7; color: #c9920a; }
        .post-category-suspension { background: #ffebee; color: #c62828; }
        .post-category-event      { background: #e8f5e9; color: #2e7d32; }
        .post-category-general    { background: #e0e7ff; color: #4f46e5; }

        .pin-badge {
            display: inline-flex; align-items: center; gap: 5px;
            padding: 4px 10px; border-radius: 999px; font-size: 11px; font-weight: 700;
            background: #fff0db; color: #d97706;
        }

        .unpin-btn {
            background: none; border: none; cursor: pointer; font-size: 18px;
            color: #ea580c; padding: 6px; border-radius: 50%; transition: background 0.2s;
        }
        .unpin-btn:hover { background: rgba(234,88,12,0.1); }

        .post-content { padding: 0 22px 16px; }
        .post-title { font-size: 18px; font-weight: 700; margin-bottom: 10px; color: var(--primary); }
        .post-text  { color: var(--page-text); line-height: 1.55; }

        .post-image { margin-top: 12px; border-radius: 16px; overflow: hidden; }
        .post-image img { width: 100%; max-height: 200px; object-fit: cover; border-radius: 16px; display: block; }

        .post-stats {
            display: flex; gap: 20px; padding: 10px 22px;
            border-top: 1px solid rgba(26,58,92,0.08);
            border-bottom: 1px solid rgba(26,58,92,0.08);
            color: var(--muted); font-size: 13px;
        }

        .post-stats span { display: flex; align-items: center; gap: 6px; cursor: pointer; }
        .post-stats span:hover { color: var(--primary); }

        .action-buttons { display: flex; gap: 5px; padding: 8px 22px; }

        .action-btn {
            flex: 1; background: none; border: none; padding: 10px; border-radius: 10px;
            cursor: pointer; font-size: 14px; color: var(--muted);
            display: flex; align-items: center; justify-content: center; gap: 8px;
            transition: all 0.3s; font-family: inherit;
        }

        .action-btn:hover { background: rgba(26,58,92,0.07); color: var(--primary); }
        .action-btn.liked { color: #dc2626; }

        .comments-section {
            padding: 0 22px 18px;
            border-top: 1px solid rgba(26,58,92,0.08);
        }

        .comment-input { display: flex; gap: 10px; margin: 14px 0; }

        .comment-input input {
            flex: 1; padding: 10px 16px;
            background: var(--surface-soft); border: 1px solid rgba(26,58,92,0.15);
            border-radius: 30px; outline: none; font-size: 13px; color: var(--page-text);
            font-family: inherit;
        }

        .comment-input button {
            padding: 10px 22px;
            background: linear-gradient(135deg, #c9920a, #a87800);
            border: none; border-radius: 30px; cursor: pointer;
            font-weight: 600; color: white; font-family: inherit;
        }

        .comment-item {
            display: flex; gap: 10px; padding: 10px 0;
            border-bottom: 1px solid rgba(26,58,92,0.08); font-size: 13px;
        }
        .comment-item:last-child { border-bottom: none; }

        .comment-avatar {
            width: 32px; height: 32px; background: #fef3c7; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 12px; color: var(--primary); flex-shrink: 0; overflow: hidden;
        }

        .comment-author { font-weight: bold; color: var(--primary); }
        .comment-text   { color: var(--page-text); margin-top: 2px; }
        .comment-time   { font-size: 10px; color: var(--muted); margin-top: 2px; }

        .no-comments {
            padding: 14px 0; text-align: center; font-size: 12px; color: var(--muted-light);
        }

        /* ── Empty state ── */
        .empty-state {
            background: var(--surface); border: 1px solid var(--border);
            border-radius: 20px; box-shadow: var(--shadow);
            padding: 50px 20px; text-align: center; color: var(--muted);
        }

        /* ── Toast ── */
        .toast-msg {
            position: fixed; bottom: 28px; left: 50%; transform: translateX(-50%);
            background: #c9920a; color: #fff; padding: 10px 24px;
            border-radius: 30px; font-size: 13px; z-index: 9999;
            box-shadow: 0 4px 16px rgba(0,0,0,.25); pointer-events: none;
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

        body.dark-mode .pinned-card { background: rgba(35,35,35,0.95); border-color: rgba(201,146,10,0.30); }
        body.dark-mode .pinned-card:hover { border-color: rgba(201,146,10,0.60); }
        body.dark-mode .post-author, body.dark-mode .post-title { color: #e0e7ff; }
        body.dark-mode .post-text { color: #e2e8f0; }
        body.dark-mode .post-stats { border-color: rgba(148,163,184,0.15); color: #cbd5e1; }
        body.dark-mode .post-stats span:hover { color: #93c5fd; }
        body.dark-mode .action-btn { color: #cbd5e1; }
        body.dark-mode .action-btn:hover { background: rgba(59,130,246,0.15); color: #93c5fd; }
        body.dark-mode .action-btn.liked { color: #f87171; }
        body.dark-mode .comments-section { border-color: rgba(148,163,184,0.15); }
        body.dark-mode .comment-input input { background: rgba(51,65,85,0.6); border-color: rgba(148,163,184,0.3); color: #f1f5f9; }
        body.dark-mode .comment-input input::placeholder { color: #94a3b8; }
        body.dark-mode .comment-avatar { background: rgba(59,130,246,0.2); color: #93c5fd; }
        body.dark-mode .comment-author { color: #fbbf24; }
        body.dark-mode .comment-text { color: #e2e8f0; }
        body.dark-mode .comment-item { border-color: rgba(148,163,184,0.12); }
        body.dark-mode .page-title { color: #e0e7ff; }
        body.dark-mode .post-category-exam       { background: rgba(59,130,246,0.25); color: #93c5fd; }
        body.dark-mode .post-category-suspension { background: rgba(239,68,68,0.25);  color: #fca5a5; }
        body.dark-mode .post-category-event      { background: rgba(34,197,94,0.25);  color: #86efac; }
        body.dark-mode .post-category-general    { background: rgba(139,92,246,0.25); color: #c4b5fd; }
        body.dark-mode .pin-badge { background: rgba(251,146,60,0.2); color: #fdba74; }

@media (max-width: 768px) {
    .header { top: 6px; left: 6px; right: 6px; padding: 10px 16px; }
    .page-shell { padding: 76px 10px 32px; }
    .post-header { padding: 14px 16px 10px; }
    .post-content { padding: 0 16px 14px; }
    .post-stats { padding: 8px 16px; gap: 12px; font-size: 12px; }
    .action-buttons { padding: 6px 16px; }
}
</style>
</head>
<body>
<form id="form1" runat="server">
<div class="header">
    <button type="button" class="logo" onclick="window.location.href='<%= BackUrl %>'">
        <i class="fas fa-thumbtack"></i> Pinned Announcements
    </button>
    <a class="back-btn" href="<%= BackUrl %>" title="Back to Portal">
        <i class="fas fa-home"></i>
    </a>
</div>

<div class="page-shell">
    <div class="page-wrap">
        <div class="pinned-list">
            <div style="text-align:center;padding:40px;color:var(--muted);">
                <i class="fas fa-spinner fa-spin" style="font-size:28px;"></i>
                <p style="margin-top:10px;">Loading pinned announcements...</p>
            </div>
        </div>
    </div>
</div>
</form>

<!-- Image Lightbox -->
<div id="imageLightbox" onclick="if(event.target===this)closeLightbox()"
    style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.88);z-index:9998;align-items:center;justify-content:center;padding:20px;">
    <button onclick="closeLightbox()"
        style="position:absolute;top:18px;right:22px;background:rgba(255,255,255,0.15);border:none;color:#fff;font-size:28px;width:44px;height:44px;border-radius:50%;cursor:pointer;display:flex;align-items:center;justify-content:center;line-height:1;">&times;</button>
    <img id="lightboxImg" src=""
        style="max-width:92vw;max-height:88vh;border-radius:12px;object-fit:contain;box-shadow:0 8px 40px rgba(0,0,0,0.6);" />
</div>

<script>
    var THEME_KEY = 'campus_theme';
    var pinnedDB = [];
    var likeCounts = {};

    // ✅ Role injected from session — controls unpin button visibility
    var userRole = '<%= Session["Role"] != null ? Session["Role"].ToString() : "Student" %>';
    var isTeacher = userRole.toLowerCase() === 'admin';

    // ── Helpers ──────────────────────────────────────────────────────
    function escapeHtml(s) {
        if (!s) return '';
        var d = document.createElement('div');
        d.appendChild(document.createTextNode(String(s)));
        return d.innerHTML;
    }


    function formatDate(d) {
        if (!d) return '';
        var date = new Date(d);
        if (isNaN(date)) return d;
        var now = new Date();
        var sec = Math.floor((now - date) / 1000);
        if (sec < 60) return 'Just now';
        var min = Math.floor(sec / 60);
        if (min < 60) return min + (min === 1 ? ' min ago' : ' mins ago');
        var hr = Math.floor(min / 60);
        if (hr < 24) return hr + (hr === 1 ? ' hour ago' : ' hours ago');
        var day = Math.floor(hr / 24);
        if (day < 7) return day + (day === 1 ? ' day ago' : ' days ago');
        var wk = Math.floor(day / 7);
        if (wk < 5) return wk + (wk === 1 ? ' week ago' : ' weeks ago');
        var mo = Math.floor(day / 30);
        if (mo < 12) return mo + (mo === 1 ? ' month ago' : ' months ago');
        var yr = Math.floor(day / 365);
        return yr + (yr === 1 ? ' year ago' : ' years ago');
    }

    function showToast(msg) {
        var t = document.createElement('div');
        t.textContent = msg;
        t.style.cssText = 'position:fixed;bottom:28px;left:50%;transform:translateX(-50%);background:#c9920a;color:#fff;padding:10px 24px;border-radius:30px;font-size:13px;z-index:9999;box-shadow:0 4px 16px rgba(0,0,0,.25);pointer-events:none;';
        document.body.appendChild(t);
        setTimeout(function () { if (t.parentNode) t.parentNode.removeChild(t); }, 2500);
    }

    function openLightbox(src) {
        var lb = document.getElementById('imageLightbox');
        var lbImg = document.getElementById('lightboxImg');
        if (!lb || !lbImg) return;
        lbImg.src = src;
        lb.style.display = 'flex';
        document.body.style.overflow = 'hidden';
    }
    function closeLightbox() {
        var lb = document.getElementById('imageLightbox');
        if (lb) lb.style.display = 'none';
        document.body.style.overflow = '';
    }
    document.addEventListener('keydown', function (e) { if (e.key === 'Escape') closeLightbox(); });

    // ── Media render (images, videos, attachments) ───────────────────
    var videoExts = ['mp4', 'webm', 'ogg', 'mov', 'avi'];
    var imageExts = ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'];
    function getExt(url) { return (url.split('.').pop() || '').toLowerCase().split('?')[0]; }

    function renderMediaHtml(mediaUrl) {
        if (!mediaUrl) return '';
        var urls = mediaUrl.split(',').map(function (u) { return u.trim(); }).filter(Boolean);
        if (!urls.length) return '';
        var html = '';
        var images = urls.filter(function (u) { return imageExts.indexOf(getExt(u)) !== -1; });
        var videos = urls.filter(function (u) { return videoExts.indexOf(getExt(u)) !== -1; });
        var files = urls.filter(function (u) { return imageExts.indexOf(getExt(u)) === -1 && videoExts.indexOf(getExt(u)) === -1; });

        if (images.length === 1) {
            html += '<div class="post-image"><img src="' + images[0] + '" style="cursor:zoom-in;" onclick="openLightbox(\'' + images[0] + '\')" onerror="this.style.display=\'none\'" /></div>';
        } else if (images.length > 1) {
            html += '<div class="post-image" style="display:flex;flex-wrap:wrap;gap:6px;">';
            images.forEach(function (img) {
                html += '<img src="' + img + '" style="width:calc(50% - 3px);max-height:160px;object-fit:cover;border-radius:12px;cursor:zoom-in;flex:1 1 calc(50% - 3px);" onclick="openLightbox(\'' + img + '\')" onerror="this.style.display=\'none\'" />';
            });
            html += '</div>';
        }
        videos.forEach(function (vid) {
            html += '<div class="post-image" style="margin-top:10px;"><video controls style="width:100%;max-height:280px;border-radius:16px;display:block;"><source src="' + vid + '" />Your browser does not support video.</video></div>';
        });
        files.forEach(function (f) {
            var fname = f.split('/').pop();
            html += '<div style="margin-top:10px;padding:10px 14px;background:var(--surface-soft);border:1px solid var(--border);border-radius:12px;display:flex;align-items:center;gap:10px;">'
                + '<i class="fas fa-file-alt" style="color:var(--primary);font-size:18px;"></i>'
                + '<span style="flex:1;font-size:13px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">' + escapeHtml(fname) + '</span>'
                + '<a href="' + f + '" download="' + escapeHtml(fname) + '" style="padding:6px 14px;background:var(--primary);color:#fff;border-radius:20px;font-size:12px;font-weight:600;text-decoration:none;white-space:nowrap;">'
                + '<i class="fas fa-download" style="margin-right:4px;"></i>Download</a>'
                + '</div>';
        });
        return html;
    }

    // ── Load from DB ─────────────────────────────────────────────────
    function loadFromDB() {
        fetch('AnnouncementHandler.ashx?action=getAll', { credentials: 'same-origin' })
            .then(function (r) { return r.json(); })
            .then(function (res) {
                if (!res.ok) { renderPinned([]); return; }

                // ✅ Only show globally pinned posts (IsPinned = true from DB)
                pinnedDB = res.data
                    .filter(function (a) { return a.isPinned === true; })
                    .map(function (a) {
                        likeCounts[a.id] = a.likeCount || 0;
                        return {
                            id: a.id,
                            title: a.title || '',
                            category: a.category || '',
                            date: a.date || '',
                            professor: a.author || '',
                            authorImage: a.authorImage || '',
                            description: a.content || '',
                            imageUrl: a.imageUrl || '',
                            likeCount: a.likeCount || 0,
                            commentCount: a.commentCount || 0,
                            userLiked: !!a.userLiked
                        };
                    });

                renderPinned(pinnedDB);
            })
            .catch(function () { renderPinned([]); });
    }

    // ── Like ─────────────────────────────────────────────────────────
    function toggleLike(id) {
        fetch('LikeHandler.ashx?action=toggle&postId=' + id, { credentials: 'same-origin' })
            .then(function (r) { return r.json(); })
            .then(function (res) {
                if (!res.ok) { showToast('Error: ' + (res.error || 'Could not update like')); return; }
                var ann = pinnedDB.find(function (a) { return a.id === id; });
                if (ann) { ann.userLiked = res.liked; ann.likeCount = res.likeCount; }
                likeCounts[id] = res.likeCount;
                var card = document.querySelector('.pinned-card[data-post-id="' + id + '"]');
                if (card) {
                    var icon = card.querySelector('.like-stat-icon');
                    if (icon) { icon.className = 'like-stat-icon ' + (res.liked ? 'fas' : 'far') + ' fa-heart'; icon.style.color = res.liked ? '#dc2626' : ''; }
                    var cnt = card.querySelector('.like-stat-count');
                    if (cnt) cnt.textContent = res.likeCount;
                    var btn = card.querySelector('.like-action-btn');
                    if (btn) { btn.className = 'action-btn like-action-btn' + (res.liked ? ' liked' : ''); btn.innerHTML = '<i class="' + (res.liked ? 'fas' : 'far') + ' fa-heart"></i> ' + (res.liked ? 'Liked' : 'Like'); }
                }
                showToast(res.liked ? 'Liked!' : 'Like removed');
            }).catch(function () { showToast('Could not update like'); });
    }

    // ── Unpin (teacher only) ─────────────────────────────────────────
    function unpinPost(id) {
        fetch('AnnouncementHandler.ashx?action=togglePin&id=' + id, { credentials: 'same-origin' })
            .then(function (r) { return r.json(); })
            .then(function (res) {
                if (!res.ok) { showToast('Error: ' + (res.error || 'Could not unpin')); return; }
                showToast(res.isPinned ? '📌 Pinned!' : 'Unpinned');
                // Reload to reflect the change
                loadFromDB();
            }).catch(function () { showToast('Could not update pin'); });
    }

    // ── Comments ─────────────────────────────────────────────────────
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
                if (!Array.isArray(list) || !list.length) {
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
                        + '</div></div>';
                }).join('');
            }).catch(function () {
                cl.innerHTML = '<div class="no-comments">Could not load comments.</div>';
            });
    }

    function postComment(id) {
        var input = document.getElementById('ci-' + id);
        if (!input) return;
        var text = input.value.trim();
        if (!text) { showToast('Write a comment first'); return; }
        var btn = input.nextElementSibling;
        if (btn) { btn.disabled = true; btn.textContent = '...'; }
        fetch('CommentHandler.ashx?action=add', {
            method: 'POST',
            credentials: 'same-origin',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ postId: id, comment: text })
        }).then(function (r) { return r.json(); })
            .then(function (res) {
                if (btn) { btn.disabled = false; btn.textContent = 'Post'; }
                if (!res.success) { showToast('Error: ' + (res.error || 'Could not post')); return; }
                input.value = '';
                loadComments(id);
                var card = document.querySelector('.pinned-card[data-post-id="' + id + '"]');
                if (card) {
                    var cc = card.querySelector('.comment-stat-count');
                    if (cc) cc.textContent = parseInt(cc.textContent || '0') + 1;
                }
                showToast('Comment posted!');
            }).catch(function () {
                if (btn) { btn.disabled = false; btn.textContent = 'Post'; }
                showToast('Could not post comment');
            });
    }

    // ── Share ────────────────────────────────────────────────────────
    function sharePost(id) {
        var url = window.location.href.split('?')[0];
        if (navigator.clipboard) {
            navigator.clipboard.writeText(url)
                .then(function () { showToast('Link copied!'); })
                .catch(function () { fallbackCopy(url); });
        } else { fallbackCopy(url); }
        fetch('NotificationHandler.ashx?action=notifyShare&postId=' + id, { credentials: 'same-origin' }).catch(function () { });
    }
    function fallbackCopy(url) {
        var dummy = document.createElement('input');
        dummy.value = url;
        document.body.appendChild(dummy);
        dummy.select();
        document.execCommand('copy');
        document.body.removeChild(dummy);
        showToast('Link copied!');
    }

    // ── Render ───────────────────────────────────────────────────────
    function renderPinned(list) {
        var container = document.querySelector('.pinned-list');
        if (!container) return;

        if (!list || !list.length) {
            container.innerHTML = '<div class="empty-state">'
                + '<i class="fas fa-thumbtack" style="font-size:40px;color:var(--muted-light);display:block;margin-bottom:14px;"></i>'
                + '<p style="font-size:16px;font-weight:600;color:var(--muted);">No pinned announcements yet.</p>'
                + '<p style="font-size:13px;margin-top:6px;color:var(--muted-light);">'
                + (isTeacher ? 'Pin announcements from the board to show them here.' : 'The teacher has not pinned any announcements yet.')
                + '</p></div>';
            return;
        }

        container.innerHTML = list.map(function (ann) {
            var liked = !!ann.userLiked;
            var lc = ann.likeCount || 0;
            var cc = ann.commentCount || 0;
            var catClass = ann.category === 'Exam' ? 'post-category-exam'
                : ann.category === 'Suspension' ? 'post-category-suspension'
                    : ann.category === 'Event' ? 'post-category-event'
                        : 'post-category-general';

            var postAvatar = ann.authorImage
                ? '<div class="post-avatar"><img src="' + escapeHtml(ann.authorImage) + '" style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;" /></div>'
                : '<div class="post-avatar"><i class="fas fa-user-tie"></i></div>';

            // ✅ Unpin button only visible to teachers
            var pinControls = '<span class="pin-badge"><i class="fas fa-thumbtack"></i> Pinned</span>';
            if (isTeacher) {
                pinControls += '<button class="unpin-btn" onclick="unpinPost(' + ann.id + ')" title="Unpin this post">'
                    + '<i class="fas fa-thumbtack"></i></button>';
            }

            return '<div class="pinned-card" data-post-id="' + ann.id + '">'
                + '<div class="post-header">'
                + '<div class="post-header-left">'
                + postAvatar
                + '<div>'
                + '<div class="post-author">' + escapeHtml(ann.professor) + '</div>'
                + '<div class="post-meta">'
                + '<span>' + formatDate(ann.date) + '</span>'
                + '<span class="post-category ' + catClass + '">' + escapeHtml(ann.category) + '</span>'
                + '</div>'
                + '</div>'
                + '</div>'
                + '<div style="display:flex;align-items:center;gap:8px;">' + pinControls + '</div>'
                + '</div>'
                + '<div class="post-content">'
                + '<div class="post-title">' + escapeHtml(ann.title) + '</div>'
                + '<div class="post-text">' + escapeHtml(ann.description) + '</div>'
                + renderMediaHtml(ann.imageUrl)
                + '</div>'
                + '<div class="post-stats">'
                + '<span onclick="toggleLike(' + ann.id + ')">'
                + '<i class="like-stat-icon ' + (liked ? 'fas' : 'far') + ' fa-heart"' + (liked ? ' style="color:#dc2626"' : '') + '></i>'
                + ' <span class="like-stat-count">' + lc + '</span> Likes'
                + '</span>'
                + '<span onclick="toggleComments(' + ann.id + ')">'
                + '<i class="far fa-comment"></i>'
                + ' <span class="comment-stat-count">' + cc + '</span> Comments'
                + '</span>'
                + '<span onclick="sharePost(' + ann.id + ')">'
                + '<i class="far fa-share-square"></i> Share'
                + '</span>'
                + '</div>'
                + '<div class="action-buttons">'
                + '<button class="action-btn like-action-btn' + (liked ? ' liked' : '') + '" onclick="toggleLike(' + ann.id + ')">'
                + '<i class="' + (liked ? 'fas' : 'far') + ' fa-heart"></i> ' + (liked ? 'Liked' : 'Like')
                + '</button>'
                + '<button class="action-btn" onclick="toggleComments(' + ann.id + ')">'
                + '<i class="far fa-comment"></i> Comment'
                + '</button>'
                + '<button class="action-btn" onclick="sharePost(' + ann.id + ')">'
                + '<i class="fas fa-share-alt"></i> Share'
                + '</button>'
                + '</div>'
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

    // ── Theme ────────────────────────────────────────────────────────
    function applyStoredTheme() {
        document.body.classList.toggle('dark-mode', localStorage.getItem(THEME_KEY) === 'dark');
    }
    window.addEventListener('storage', function (e) {
        if (e.key === THEME_KEY) applyStoredTheme();
    });

    // ── Init ─────────────────────────────────────────────────────────
    applyStoredTheme();
    loadFromDB();
</script>
</body>
</html>

