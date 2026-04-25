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
        // ── Same data as Student/Search pages ──────────────────
        var announcementsDB = [
            { id:1, title:"Final Exam Schedule Spring 2026",   category:"Exam Schedule",    date:"2026-05-10", time:"09:00 AM", professor:"Dr. Reyes",       description:"Final exams will be held from May 15-20, 2026. Please check your exam permits online. Bring school ID and test permit.", bannerText:"EXAM SCHEDULE",    bannerType:"exam"       },
            { id:2, title:"Class Suspension due to Typhoon",   category:"Class Suspension", date:"2026-04-25", time:"08:00 PM", professor:"Admin Office",    description:"Classes suspended on April 26-27 due to Typhoon. All activities will shift to online learning platforms.",              bannerText:"CLASS SUSPENSION", bannerType:"suspension"  },
            { id:3, title:"University Hackathon 2026",         category:"Campus Events",    date:"2026-05-20", time:"10:00 AM", professor:"IT Department",   description:"48-hour coding challenge with exciting prizes. Form teams of 3-4 members. Registration ends May 15.",                   bannerText:"HACKATHON",        bannerType:"events"      },
            { id:4, title:"Midterm Grade Release",             category:"Exam Schedule",    date:"2026-04-22", time:"02:00 PM", professor:"Registrar",       description:"Midterm grades are now available via the student portal. Check your assessment and email your instructors for concerns.",  bannerText:"GRADES OUT",       bannerType:"exam"        },
            { id:5, title:"Transport Strike Advisory",         category:"Class Suspension", date:"2026-04-28", time:"07:30 AM", professor:"Student Affairs", description:"No face-to-face classes on April 30 due to nationwide transport strike. Asynchronous activities will be provided.",       bannerText:"STRIKE DAY",       bannerType:"suspension"  },
            { id:6, title:"Cultural Festival 2026",            category:"Campus Events",    date:"2026-05-05", time:"09:00 AM", professor:"OSA",             description:"Celebration of arts, international food fair, and cultural performances. Free entrance for all students!",                bannerText:"CULTURAL FEST",    bannerType:"events"      },
            { id:7, title:"Research Colloquium",               category:"Campus Events",    date:"2026-05-12", time:"11:00 AM", professor:"Graduate School", description:"Present your research papers and get feedback from panelists. Best paper receives recognition award.",                     bannerText:"CALL FOR PAPERS",  bannerType:"events"      }
        ];

        // ── Shared localStorage state ──────────────────────────
        var STORAGE = {
            get: function(k) { try { return JSON.parse(localStorage.getItem(k) || 'null'); } catch(e) { return null; } },
            set: function(k,v) { localStorage.setItem(k, JSON.stringify(v)); }
        };
        var likes      = STORAGE.get('sd_likes')      || {};
        var likeCounts = STORAGE.get('sd_likeCounts') || {};
        var pins       = STORAGE.get('campus_pins')   || {};
        var comments   = STORAGE.get('sd_comments')   || {};

        // Init like counts
        announcementsDB.forEach(function(a) {
            if (likeCounts[a.id] === undefined) likeCounts[a.id] = Math.floor(Math.random()*20)+2;
        });

        function saveState() {
            STORAGE.set('sd_likes',      likes);
            STORAGE.set('sd_likeCounts', likeCounts);
            STORAGE.set('campus_pins',   pins);
            STORAGE.set('sd_comments',   comments);
        }

        function escapeHtml(s) {
            if (!s) return '';
            return String(s).replace(/[&<>"']/g, function(c) {
                return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c];
            });
        }

        function formatDate(d) {
            return new Date(d).toLocaleDateString('en-US', { month:'long', day:'numeric', year:'numeric' });
        }

        function getBannerClass(t) {
            return t === 'exam' ? 'banner-exam' : t === 'suspension' ? 'banner-suspension' : t === 'events' ? 'banner-events' : 'banner-default';
        }

        function getCatClass(c) {
            if (c === 'Exam Schedule')    return 'cat-exam';
            if (c === 'Class Suspension') return 'cat-suspension';
            if (c === 'Campus Events')    return 'cat-event';
            return 'cat-default';
        }

        function showToast(msg) {
            var t = document.createElement('div');
            t.className = 'toast-msg';
            t.textContent = msg;
            document.body.appendChild(t);
            setTimeout(function() { if (t.parentNode) t.parentNode.removeChild(t); }, 2700);
        }

        function renderComments(id) {
            var list = comments[id] || [];
            if (!list.length) return '<div class="no-comments">No comments yet. Be the first!</div>';
            return list.map(function(c) {
                return '<div class="comment-item">'
                    + '<div class="comment-avatar"><i class="fas fa-user"></i></div>'
                    + '<div><div class="comment-author">' + escapeHtml(c.author) + '</div>'
                    + '<div class="comment-text">' + escapeHtml(c.text) + '</div>'
                    + '<div class="comment-time">' + escapeHtml(c.time) + '</div></div></div>';
            }).join('');
        }

        function toggleLike(id) {
            likes[id] = !likes[id];
            likeCounts[id] = (likeCounts[id] || 0) + (likes[id] ? 1 : -1);
            if (likeCounts[id] < 0) likeCounts[id] = 0;
            saveState();
            renderAll();
            showToast(likes[id] ? '❤️ Liked!' : 'Like removed');
        }

        function togglePin(id) {
            pins[id] = !pins[id];
            saveState();
            renderAll();
            showToast(pins[id] ? '📌 Pinned!' : 'Unpinned');
        }

        function openComments(id) {
            var sec = document.getElementById('cs-' + id);
            if (sec) sec.classList.toggle('show');
        }

        function postComment(id) {
            var input = document.getElementById('ci-' + id);
            if (!input) return;
            var text = input.value.trim();
            if (!text) { showToast('Please write a comment first'); return; }
            if (!comments[id]) comments[id] = [];
            comments[id].push({ author:'You', text:text, time: new Date().toLocaleTimeString('en-US',{hour:'2-digit',minute:'2-digit'}) });
            saveState();
            input.value = '';
            var cl = document.getElementById('cl-' + id);
            if (cl) cl.innerHTML = renderComments(id);
            showToast('💬 Comment posted!');
        }

        function sharePost(id, title) {
            var url = window.location.href.split('?')[0] + '?post=' + id;
            if (navigator.clipboard) {
                navigator.clipboard.writeText(url).then(function() { showToast('🔗 Link copied!'); });
            } else { showToast('📤 Shared!'); }
        }

        function renderAll() {
            var container = document.getElementById('notifContainer');
            if (!container) return;

            if (!announcementsDB.length) {
                container.innerHTML = '<div style="text-align:center;padding:40px;color:var(--muted)">No notifications yet.</div>';
                return;
            }

            container.innerHTML = announcementsDB.map(function(ann) {
                var liked  = !!likes[ann.id];
                var pinned = !!pins[ann.id];
                var lc     = likeCounts[ann.id] || 0;
                var cc     = (comments[ann.id] || []).length;
                var catCls = getCatClass(ann.category);
                var catIcon= ann.category === 'Exam Schedule' ? '📅' : ann.category === 'Class Suspension' ? '⚠️' : '🎉';

                return '<div class="announce-card">'
                    // header
                    + '<div style="padding:18px 20px 12px">'
                    +   '<div style="display:flex;align-items:flex-start;justify-content:space-between;gap:12px;margin-bottom:12px">'
                    +     '<div style="display:flex;align-items:center;gap:12px;flex:1">'
                    +       '<div style="width:44px;height:44px;background:var(--active-bg);border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0">'
                    +         '<i class="fas fa-user" style="color:var(--primary);font-size:18px"></i>'
                    +       '</div>'
                    +       '<div>'
                    +         '<div class="card-author-name">' + escapeHtml(ann.professor) + '</div>'
                    +         '<div class="card-meta"><i class="far fa-calendar-alt" style="margin-right:4px"></i>' + formatDate(ann.date) + ' at ' + ann.time + '</div>'
                    +       '</div>'
                    +     '</div>'
                    +     '<div style="display:flex;align-items:center;gap:8px">'
                    +       '<span class="card-banner ' + getBannerClass(ann.bannerType) + '">' + escapeHtml(ann.bannerText) + '</span>'
                    +       '<button onclick="togglePin(' + ann.id + ')" title="' + (pinned?'Unpin':'Pin') + '" style="background:none;border:none;cursor:pointer;font-size:18px;color:' + (pinned?'#e65100':'var(--muted-light)') + ';padding:4px;transition:color 0.2s">'
                    +         '<i class="' + (pinned?'fas':'far') + ' fa-thumbtack"></i>'
                    +       '</button>'
                    +     '</div>'
                    +   '</div>'
                    +   '<div class="card-title">' + escapeHtml(ann.title) + '</div>'
                    +   '<div class="card-desc">' + escapeHtml(ann.description) + '</div>'
                    +   '<div style="margin-top:10px">'
                    +     '<span class="cat-badge ' + catCls + '">' + catIcon + ' ' + escapeHtml(ann.category) + '</span>'
                    +     (pinned ? '<span style="margin-left:6px;font-size:10px;color:#e65100;font-weight:700"><i class="fas fa-thumbtack" style="margin-right:3px"></i>Pinned</span>' : '')
                    +   '</div>'
                    + '</div>'
                    // stats
                    + '<div class="post-stats">'
                    +   '<span onclick="toggleLike(' + ann.id + ')"><i class="' + (liked?'fas':'far') + ' fa-heart" style="' + (liked?'color:#dc2626':'') + '"></i> ' + lc + ' Likes</span>'
                    +   '<span onclick="openComments(' + ann.id + ')"><i class="far fa-comment"></i> ' + cc + ' Comments</span>'
                    +   '<span onclick="sharePost(' + ann.id + ',\'' + escapeHtml(ann.title) + '\')"><i class="far fa-share-square"></i> Share</span>'
                    + '</div>'
                    // action buttons
                    + '<div class="action-buttons">'
                    +   '<button class="action-btn' + (liked?' liked':'') + '" onclick="toggleLike(' + ann.id + ')"><i class="' + (liked?'fas':'far') + ' fa-heart"></i> ' + (liked?'Liked':'Like') + '</button>'
                    +   '<button class="action-btn" onclick="openComments(' + ann.id + ')"><i class="far fa-comment"></i> Comment</button>'
                    +   '<button class="action-btn" onclick="sharePost(' + ann.id + ',\'' + escapeHtml(ann.title) + '\')"><i class="fas fa-share-alt"></i> Share</button>'
                    + '</div>'
                    // comments
                    + '<div class="comments-section" id="cs-' + ann.id + '">'
                    +   '<div class="comment-input-row">'
                    +     '<input id="ci-' + ann.id + '" type="text" placeholder="Write a comment...">'
                    +     '<button onclick="postComment(' + ann.id + ')">Post</button>'
                    +   '</div>'
                    +   '<div id="cl-' + ann.id + '">' + renderComments(ann.id) + '</div>'
                    + '</div>'
                    + '</div>';
            }).join('');
        }

        // ── Theme ──────────────────────────────────────────────
        var THEME_KEY = 'campus_theme';

        function applyStoredTheme() {
            document.body.classList.toggle('dark-mode', localStorage.getItem(THEME_KEY) === 'dark');
        }

        window.addEventListener('storage', function(e) {
            if (e.key === THEME_KEY) applyStoredTheme();
            if (e.key === 'campus_pins') {
                pins = JSON.parse(e.newValue || '{}');
                renderAll();
            }
        });

        applyStoredTheme();
        renderAll();
    </script>
</body>
</html>