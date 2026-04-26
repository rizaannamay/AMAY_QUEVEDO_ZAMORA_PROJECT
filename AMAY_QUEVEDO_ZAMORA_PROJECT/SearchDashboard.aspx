<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SearchDashboard.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.SearchDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>CampusConnect | Announcement Dashboard</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

    <style>
        * { font-family: 'Inter', system-ui, -apple-system, sans-serif; }

        /* ── BACKGROUND — same as SearchStudent.aspx ── */
        :root {
            --bg-image: url('wbg.jpg');
            --page-text: #1a2a3a;
            --surface: rgba(255,255,255,0.95);
            --surface-strong: #ffffff;
            --surface-soft: #f0f5ff;
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
            position: relative;
            overflow-x: hidden;
            color: var(--page-text);
            background-image: var(--bg-image);
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            background-attachment: fixed;
            transition: background 0.4s ease, color 0.4s ease;
        }

        /* ── DARK MODE ── */
        body.dark-mode {
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
            background-image: linear-gradient(rgba(0,0,0,0), rgba(0,0,0,0)), url('bg.jpg');
            background-color: #0F172A;
        }

        /* ── NAVBAR — blue gradient header ── */
        .glass-nav {
            background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 100%);
            border-bottom: none;
            box-shadow: 0 4px 20px rgba(30,58,138,0.3);
            transition: background 0.4s ease;
        }
        body.dark-mode .glass-nav {
            background: linear-gradient(135deg, #0f172a 0%, #1e3a8a 100%);
            box-shadow: 0 4px 20px rgba(0,0,0,0.5);
        }

        /* Force nav text/icons white on the blue header */
        .glass-nav h1,
        .glass-nav p,
        .glass-nav a,
        .glass-nav button { color: #ffffff !important; }
        .glass-nav .text-muted { color: rgba(255,255,255,0.7) !important; }

        /* ── GLASS SIDEBAR ── */
        .glass-sidebar {
            background: var(--surface);
            backdrop-filter: blur(12px);
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            transition: background 0.4s ease, border-color 0.4s ease;
        }

        /* ── GLASS CARD ── */
        .glass-card {
            background: var(--surface);
            backdrop-filter: blur(12px);
            border: 1px solid var(--border);
            transition: all 0.3s ease;
        }

        .glass-card:hover {
            border-color: rgba(99,102,241,0.3);
            transform: translateY(-2px);
        }

        /* ── HERO ── */
        .hero-section {
            background: linear-gradient(135deg, rgba(30,58,138,0.9), rgba(79,70,229,0.85));
            backdrop-filter: blur(4px);
            position: relative;
            overflow: hidden;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            bottom: 0; left: 0; right: 0;
            height: 60px;
            background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1200 120' preserveAspectRatio='none'%3E%3Cpath d='M0,0V46.29c47.79,22.2,103.59,32.17,158,28,70.36-5.37,136.33-33.31,206.8-37.5C438.64,32.43,512.34,53.67,583,72.05c69.27,18,138.3,24.88,209.4,13.08,36.15-6,69.85-17.84,104.45-29.34C989.49,25,1113-14.29,1200,52.47V0Z' fill='rgba(255,255,255,0.05)'/%3E%3C/svg%3E") repeat-x;
            background-size: 1200px 60px;
            opacity: 0.5;
        }

        /* ── ANNOUNCE CARD ── */
        .announce-card {
            background: var(--surface-strong);
            border: 1px solid #3B82F6;
            border-radius: 20px;
            transition: all 0.25s cubic-bezier(0.4,0,0.2,1);
            box-shadow: var(--shadow);
            overflow: hidden;
            will-change: transform;
        }

        .announce-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 16px 32px rgba(0,0,0,0.15);
            border-color: #1E3A8A;
        }
        body.dark-mode .announce-card {
            background: rgba(15,25,55,0.92);
            border-color: #3B82F6;
            box-shadow: 0 4px 20px rgba(0,0,0,0.35);
        }
        body.dark-mode .announce-card:hover {
            border-color: #93C5FD;
            box-shadow: 0 12px 32px rgba(0,0,0,0.5);
        }

        /* Card text colors */
        .card-author-name { color: var(--primary); font-weight: 700; font-size: 15px; }
        .card-meta        { color: var(--muted); font-size: 12px; }
        .card-title       { color: var(--primary); font-size: 18px; font-weight: 700; margin-bottom: 8px; }
        .card-desc        { color: var(--page-text); font-size: 13px; line-height: 1.6; }

        /* ── CARD BANNERS ── */
        .card-banner {
            background: linear-gradient(135deg,#1e3a8a,#4f46e5);
            border-radius: 12px;
            min-width: 90px;
            text-align: center;
            transition: transform 0.2s;
            flex-shrink: 0;
        }
        .card-banner:hover { transform: scale(1.03); }
        .banner-exam       { background: linear-gradient(135deg,#0f2b5c,#1e4a8a,#3b82f6); }
        .banner-suspension { background: linear-gradient(135deg,#7c2d12,#b45309,#f59e0b); }
        .banner-events     { background: linear-gradient(135deg,#064e3b,#0d9488,#14b8a6); }
        .banner-default    { background: linear-gradient(135deg,#1e1b4b,#4f46e5,#818cf8); }

        /* ── POST STATS BAR ── */
        .post-stats {
            display: flex;
            gap: 16px;
            padding: 8px 20px;
            border-top: 1px solid var(--border);
            border-bottom: 1px solid var(--border);
            color: var(--muted);
            font-size: 13px;
        }
        .post-stats span { display: flex; align-items: center; gap: 5px; cursor: pointer; transition: color 0.2s; }
        .post-stats span:hover { color: var(--primary); }

        /* ── ACTION BUTTONS ── */
        .action-buttons {
            display: flex;
            gap: 4px;
            padding: 6px 20px 10px;
        }
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
        .action-btn.pinned-active { color: #e65100; }
        .action-btn.notif-active { color: #3B82F6; }
        body.dark-mode .action-btn:hover { background: rgba(255,255,255,0.06); color: #93C5FD; }

        /* ── COMMENTS SECTION ── */
        .comments-section {
            padding: 0 20px 16px;
            border-top: 1px solid var(--border);
            display: none;
        }
        .comments-section.show { display: block; }
        .comment-input-row {
            display: flex;
            gap: 8px;
            margin: 12px 0;
        }
        .comment-input-row input {
            flex: 1;
            padding: 9px 14px;
            background: var(--surface-soft);
            border: 1px solid var(--border);
            border-radius: 30px;
            outline: none;
            font-size: 13px;
            color: var(--page-text);
            font-family: inherit;
            transition: border-color 0.2s;
        }
        .comment-input-row input:focus { border-color: #6366f1; }
        .comment-input-row input::placeholder { color: var(--muted-light); }
        .comment-input-row button {
            background: linear-gradient(135deg, var(--primary), var(--primary-2));
            border: none;
            padding: 0 18px;
            border-radius: 30px;
            color: white;
            font-weight: 600;
            cursor: pointer;
            font-family: inherit;
            font-size: 13px;
            transition: opacity 0.2s;
        }
        .comment-input-row button:hover { opacity: 0.88; }
        .comment-item {
            display: flex;
            gap: 10px;
            padding: 10px 0;
            border-bottom: 1px solid var(--border);
            font-size: 13px;
        }
        .comment-item:last-child { border-bottom: none; }
        .comment-avatar {
            width: 30px; height: 30px;
            background: var(--active-bg);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            color: var(--primary);
            font-size: 12px;
            flex-shrink: 0;
        }
        .comment-author { font-weight: 700; color: var(--primary); }
        .comment-text   { color: var(--page-text); margin-top: 2px; }
        .comment-time   { font-size: 10px; color: var(--muted-light); margin-top: 2px; }
        .no-comments    { padding: 12px 0; text-align: center; color: var(--muted-light); font-size: 12px; }

        /* ── CATEGORY BADGE ── */
        .cat-badge {
            display: inline-block;
            padding: 2px 10px;
            border-radius: 20px;
            font-size: 10px;
            font-weight: 700;
        }
        .cat-exam       { background: #DBEAFE; color: #1E3A8A; }
        .cat-suspension { background: #ffebee; color: #c62828; }
        .cat-event      { background: #dcfce7; color: #166534; }
        .cat-default    { background: #EDE9FE; color: #5B21B6; }

        body.dark-mode .cat-exam       { background: rgba(30,58,138,0.3);  color: #93C5FD; }
        body.dark-mode .cat-suspension { background: rgba(198,40,40,0.2);  color: #ef9a9a; }
        body.dark-mode .cat-event      { background: rgba(22,101,52,0.25); color: #86efac; }
        body.dark-mode .cat-default    { background: rgba(91,33,182,0.2);  color: #c4b5fd; }

        /* ── HISTORY ITEMS ── */
        .history-item {
            cursor: pointer;
            transition: all 0.2s ease;
            padding: 8px 12px;
            border-radius: 12px;
            background: var(--surface-soft);
            border: 1px solid var(--border);
            color: var(--page-text);
            font-size: 13px;
        }
        .history-item:hover {
            background: var(--active-bg);
            transform: translateX(4px);
            border-color: rgba(99,102,241,0.3);
            color: var(--primary);
        }

        /* ── SEARCH INPUT ── */
        .search-input {
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(4px);
            border: 1.5px solid rgba(255,255,255,0.5);
            transition: all 0.2s;
            color: #ffffff;
        }
        .search-input:focus {
            background: rgba(255,255,255,0.22);
            border-color: rgba(255,255,255,0.9);
            box-shadow: 0 0 0 3px rgba(255,255,255,0.15);
            outline: none;
        }
        .search-input::placeholder { color: rgba(255,255,255,0.65); }
        /* search icon always white on blue nav */
        .glass-nav .fa-search { color: rgba(255,255,255,0.85) !important; }

        /* ── FILTER SELECTS ── */
        .filter-select {
            background: var(--surface-soft);
            backdrop-filter: blur(4px);
            border: 1px solid var(--border);
            color: var(--page-text);
            transition: border-color 0.2s;
        }
        .filter-select:focus { border-color: #6366f1; outline: none; }
        .filter-select option { background: var(--surface-strong); color: var(--page-text); }

        /* ── SCROLLBAR ── */
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: rgba(255,255,255,0.1); border-radius: 10px; }
        ::-webkit-scrollbar-thumb { background: rgba(99,102,241,0.5); border-radius: 10px; }

        /* ── RESULTS CONTAINER ── */
        #resultsContainer { display: flex; flex-direction: column; gap: 16px; }
        .announce-card { will-change: transform; }

        /* ── TOAST ── */
        .toast-msg {
            position: fixed;
            bottom: 28px;
            left: 50%;
            transform: translateX(-50%);
            background: #1a3a5c;
            color: white;
            padding: 10px 24px;
            border-radius: 30px;
            font-size: 13px;
            z-index: 9999;
            box-shadow: 0 4px 16px rgba(0,0,0,0.25);
            animation: toastFade 2.6s ease forwards;
            pointer-events: none;
        }
        body.dark-mode .toast-msg { background: #6366f1; }
        @keyframes toastFade {
            0%   { opacity: 0; transform: translateX(-50%) translateY(10px); }
            12%  { opacity: 1; transform: translateX(-50%) translateY(0); }
            80%  { opacity: 1; }
            100% { opacity: 0; }
        }

        /* ── FLIP TRANSITION ── */
        @keyframes flipIn {
            0%   { transform: perspective(1200px) rotateY(90deg); opacity: 0; }
            100% { transform: perspective(1200px) rotateY(0deg);  opacity: 1; }
        }
        .page-flip-in { animation: flipIn 0.18s ease-out forwards; transform-origin: center center; }

        /* ── SMOOTH TRANSITIONS ── */
        *, *::before, *::after {
            transition: background-color 0.3s ease, border-color 0.3s ease,
                        color 0.3s ease, box-shadow 0.3s ease;
        }
        .page-flip-in { transition: none !important; }

        @media (max-width: 1024px) {
            .sidebar-hidden-mobile { position: fixed; left: -280px; transition: left 0.3s; z-index: 50; }
        }

        /* ── RESPONSIVE ── */
        @media (max-width: 768px) {
            .post-stats { gap: 10px; padding: 8px 14px; font-size: 12px; flex-wrap: wrap; }
            .action-buttons { padding: 6px 14px 10px; gap: 2px; }
            .action-btn { font-size: 12px; padding: 7px 2px; }
            .card-title { font-size: 16px; }
            .card-desc  { font-size: 12px; }
            .card-banner { display: none !important; }
            .comment-input-row { flex-direction: column; }
            .comment-input-row button { padding: 10px; border-radius: 12px; }
        }

        @media (max-width: 480px) {
            .post-stats span { font-size: 11px; }
            .action-btn { font-size: 11px; gap: 4px; }
            .card-author-name { font-size: 13px; }
        }
    </style>
</head>
<body class="antialiased relative">

    <form id="form1" runat="server">
        <asp:HiddenField ID="lastSearchTerm" runat="server" />

        <div class="relative z-10">

            <!-- ═══════════ NAVBAR ═══════════ -->
            <header class="glass-nav sticky top-0 z-40 shadow-lg">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="flex flex-wrap items-center justify-between py-3 md:py-4 gap-3">

                        <!-- Logo -->
                        <div class="flex items-center gap-3 cursor-pointer group">
                            <div class="bg-white/20 p-2 rounded-xl shadow-xl transition group-hover:scale-105">
                                <i class="fas fa-university text-white text-xl"></i>
                            </div>
                            <div>
                                <h1 class="font-extrabold text-xl md:text-2xl tracking-tight text-white">CampusConnect</h1>
                                <p class="text-xs font-medium hidden sm:block text-white/70">Teacher Portal</p>
                            </div>
                        </div>

                        <!-- Search Bar -->
                        <div class="flex-1 max-w-md mx-4">
                            <div class="relative">
                                <i class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-sm text-white/80"></i>
                                <asp:TextBox ID="searchInput" runat="server" CssClass="search-input w-full pl-10 pr-4 py-2 rounded-xl" placeholder="Search announcements..."></asp:TextBox>
                            </div>
                        </div>

                        <!-- Right controls -->
                        <div class="flex items-center gap-3 md:gap-4">
                            <div class="relative">
                                <button type="button" id="notificationBtn" class="p-2 hover:bg-white/20 rounded-full transition text-white">
                                    <i class="fas fa-bell text-xl"></i>
                                </button>
                                <span id="notificationBadge" class="absolute -top-1 -right-1 bg-red-400 text-white text-[10px] font-bold rounded-full min-w-[20px] h-5 px-1 flex items-center justify-center shadow-lg">0</span>
                            </div>

                            <asp:HyperLink ID="homeLink" runat="server" NavigateUrl="~/Teacher.aspx"
                                CssClass="p-2 hover:bg-white/20 rounded-full transition-all text-white">
                                <i class="fas fa-home text-xl"></i>
                            </asp:HyperLink>
                        </div>
                    </div>
                </div>
            </header>

            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6 md:py-8">

                <!-- TWO COLUMN LAYOUT -->
                <div class="flex flex-col lg:flex-row gap-6">

                    <!-- Sidebar -->
                    <div class="lg:w-72 flex-shrink-0">
                        <div class="glass-sidebar rounded-2xl p-5 sticky top-24">
                            <div class="flex justify-between items-center mb-4">
                                <div class="flex items-center gap-2">
                                    <i class="fas fa-history text-lg" style="color:var(--primary)"></i>
                                    <h3 class="font-bold text-base" style="color:var(--primary)">Search History</h3>
                                </div>
                                <button type="button" id="clearHistoryBtn" class="text-xs transition px-2 py-1 rounded-lg hover:bg-white/10" style="color:#ef4444">
                                    <i class="fas fa-trash-alt mr-1"></i>Clear
                                </button>
                            </div>
                            <div id="historyList" class="space-y-2 max-h-[400px] overflow-y-auto">
                                <div class="text-sm text-center py-4" style="color:var(--muted)">No searches yet</div>
                            </div>

                            <!-- Pinned section -->
                            <div class="mt-5 pt-4" style="border-top:1px solid var(--border)">
                                <div class="flex items-center gap-2 mb-3">
                                    <i class="fas fa-thumbtack text-sm" style="color:#e65100"></i>
                                    <h3 class="font-bold text-sm" style="color:var(--primary)">Pinned (<span id="pinnedCount">0</span>)</h3>
                                </div>
                                <div id="pinnedList" class="space-y-2 max-h-[200px] overflow-y-auto">
                                    <div class="text-xs text-center py-2" style="color:var(--muted)">No pinned items</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Main content -->
                    <div class="flex-1">

                        <!-- Filters -->
                        <div class="glass-card rounded-2xl p-4 mb-6">
                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
                                <div class="relative">
                                    <i class="fas fa-calendar-alt absolute left-3 top-1/2 -translate-y-1/2 text-sm pointer-events-none" style="color:var(--muted);z-index:1"></i>
                                    <input type="text" id="dateFilter" placeholder="Filter by date" class="filter-select w-full pl-9 pr-4 py-2 rounded-xl text-sm cursor-pointer" />
                                </div>
                                <select id="sortFilter" class="filter-select px-4 py-2 rounded-xl text-sm cursor-pointer">
                                    <option value="latest">Latest First</option>
                                    <option value="oldest">Oldest First</option>
                                </select>
                            </div>
                        </div>

                        <!-- Results Header -->
                        <div class="flex justify-between items-center mb-4">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-newspaper text-xl" style="color:var(--primary)"></i>
                                <h3 class="font-bold text-lg" style="color:var(--primary)">Announcements</h3>
                            </div>
                            <span id="resultCount" class="glass-card px-3 py-1 rounded-full text-xs" style="color:var(--primary)">0 items</span>
                        </div>

                        <!-- Results -->
                        <div id="resultsContainer" class="space-y-5">
                            <div class="text-center py-12" style="color:#3B82F6">
                                <i class="fas fa-spinner fa-spin text-3xl"></i>
                                <p class="mt-2" style="color:#1E3A8A">Loading announcements...</p>
                            </div>
                        </div>

                        <!-- Empty State -->
                        <div id="emptyState" class="glass-card rounded-2xl p-12 text-center hidden">
                            <i class="fas fa-inbox text-5xl mb-3" style="color:var(--muted-light)"></i>
                            <p style="color:var(--muted)">No announcements match your criteria</p>
                            <button type="button" id="resetFiltersBtn" class="mt-3 text-sm underline transition" style="color:var(--primary)">Reset all filters</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <footer class="border-t mt-12 py-5 text-center text-xs backdrop-blur-sm" style="border-color:var(--border);color:var(--muted);background:rgba(255,255,255,0.05)">
                <i class="far fa-copyright"></i> 2026 CampusConnect — Connecting Teachers to Campus Life
            </footer>
        </div>
    </form>

    <script>
    // ════════════════════════════════════════════════════════
    // DATA — load live announcements from Teacher.aspx
    // ════════════════════════════════════════════════════════
    function loadAnnouncementsDB() {
        const raw = JSON.parse(localStorage.getItem('teacher_announcements') || 'null');
        if (!raw || !raw.length) return [];
        return raw.map(a => {
            const cat = a.category || '';
            let bannerType = 'default';
            let bannerText = cat.toUpperCase();
            if (cat === 'Exam')       { bannerType = 'exam';       bannerText = 'EXAM SCHEDULE'; }
            if (cat === 'Suspension') { bannerType = 'suspension'; bannerText = 'CLASS SUSPENSION'; }
            if (cat === 'Event')      { bannerType = 'events';     bannerText = 'CAMPUS EVENT'; }
            const categoryLabel = cat === 'Exam' ? 'Exam Schedule'
                                : cat === 'Suspension' ? 'Class Suspension'
                                : cat === 'Event' ? 'Campus Events' : cat;
            return {
                id:            a.id,
                title:         a.title   || '',
                category:      categoryLabel,
                date:          a.date    || '',
                time:          '',
                professor:     a.author  || '',
                professorAvatar: '👨‍🏫',
                description:   a.content || '',
                bannerText,
                bannerType
            };
        });
    }
    let announcementsDB = loadAnnouncementsDB();

    // ── Persistent state (localStorage) ──────────────────────
    const STORAGE = {
        get: k => JSON.parse(localStorage.getItem(k) || 'null'),
        set: (k,v) => localStorage.setItem(k, JSON.stringify(v))
    };

    // Merge pins from both teacher_pins and campus_pins
    function loadPins() {
        const tp = STORAGE.get('teacher_pins') || {};
        const cp = STORAGE.get('campus_pins')  || {};
        const merged = Object.assign({}, cp, tp);
        // Sanitize: remove any non-integer keys (e.g. "2:1" from corrupted state)
        Object.keys(merged).forEach(k => { if (!/^\d+$/.test(k)) delete merged[k]; });
        return merged;
    }
    // Merge likeCounts from teacher_likeCounts + sd_likeCounts
    function loadLikeCounts() {
        const tl = STORAGE.get('teacher_likeCounts') || {};
        const sl = STORAGE.get('sd_likeCounts')      || {};
        return Object.assign({}, sl, tl);
    }

    let likes      = STORAGE.get('sd_likes')     || {};   // { id: true/false }
    let likeCounts = loadLikeCounts();                     // { id: number }
    let pins       = loadPins();                           // merged teacher_pins + campus_pins
    let notifs     = STORAGE.get('sd_notifs')    || {};   // { id: true/false }
    let comments   = STORAGE.get('sd_comments')  || {};   // { id: [{author,text,time}] }
    let searchHistory = STORAGE.get('campus_history') || [];

    // Init like counts from DB
    announcementsDB.forEach(a => {
        if (likeCounts[a.id] === undefined) likeCounts[a.id] = Math.floor(Math.random()*30)+2;
    });

    function saveState() {
        STORAGE.set('sd_likes',      likes);
        STORAGE.set('sd_likeCounts', likeCounts);
        STORAGE.set('campus_pins',   pins);   // shared with Student.aspx
        STORAGE.set('teacher_pins',  pins);   // shared with Teacher.aspx
        STORAGE.set('sd_notifs',     notifs);
        STORAGE.set('sd_comments',   comments);
    }

    // ── DOM refs ──────────────────────────────────────────────
    const searchInput      = document.getElementById('<%= searchInput.ClientID %>');
    const lastSearchHidden = document.getElementById('<%= lastSearchTerm.ClientID %>');
    const categoryFilter   = null; // removed
    const dateFilter       = document.getElementById('dateFilter');
    const sortFilter       = document.getElementById('sortFilter');
    const resultsContainer = document.getElementById('resultsContainer');
    const resultCount      = document.getElementById('resultCount');
    const emptyState       = document.getElementById('emptyState');
    const resetFiltersBtn  = document.getElementById('resetFiltersBtn');
    const historyListDiv   = document.getElementById('historyList');
    const clearHistoryBtn  = document.getElementById('clearHistoryBtn');
    const notificationBtn  = document.getElementById('notificationBtn');
    const notificationBadge= document.getElementById('notificationBadge');

    let currentSearchTerm = '';
    let currentDate       = '';
    let currentSort       = 'latest';

    // ── Helpers ───────────────────────────────────────────────
    function escapeHtml(str) {
        if (!str) return '';
        return str.replace(/[&<>"']/g, m => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[m]));
    }

    function formatDate(dateStr) {
        return new Date(dateStr).toLocaleDateString('en-US', { month:'long', day:'numeric', year:'numeric' });
    }

    function getBannerClass(type) {
        return { exam:'banner-exam', suspension:'banner-suspension', events:'banner-events' }[type] || 'banner-default';
    }

    function getCatClass(cat) {
        if (cat === 'Exam Schedule')   return 'cat-exam';
        if (cat === 'Class Suspension') return 'cat-suspension';
        if (cat === 'Campus Events')   return 'cat-event';
        return 'cat-default';
    }

    function showToast(msg) {
        const t = document.createElement('div');
        t.className = 'toast-msg';
        t.textContent = msg;
        document.body.appendChild(t);
        setTimeout(() => t.remove(), 2700);
    }

    function updateNotifBadge() {
        const stored = JSON.parse(localStorage.getItem('campus_notifications') || '[]');
        const count = stored.filter(n => !n.read).length;
        notificationBadge.textContent = count;
        notificationBadge.style.display = count > 0 ? 'flex' : 'none';
    }

    // ── Search History ────────────────────────────────────────
    function saveHistory() {
        STORAGE.set('campus_history', searchHistory.slice(0,15));
        renderHistory();
    }

    function addToHistory(term) {
        if (!term.trim()) return;
        term = term.trim();
        searchHistory = [term, ...searchHistory.filter(t => t !== term)].slice(0,15);
        saveHistory();
    }

    function renderHistory() {
        if (!historyListDiv) return;
        if (!searchHistory.length) {
            historyListDiv.innerHTML = '<div class="text-sm text-center py-4" style="color:var(--muted)">No searches yet</div>';
            return;
        }
        historyListDiv.innerHTML = searchHistory.map(term => `
            <div class="history-item flex items-center justify-between group" data-term="${escapeHtml(term)}">
                <span><i class="fas fa-search text-xs mr-2 opacity-50"></i>${escapeHtml(term)}</span>
                <i class="fas fa-chevron-right text-xs opacity-0 group-hover:opacity-100 transition"></i>
            </div>
        `).join('');
        historyListDiv.querySelectorAll('.history-item').forEach(item => {
            item.addEventListener('click', () => {
                searchInput.value = item.dataset.term;
                performSearch();
            });
        });
    }

    // ── Pinned sidebar ────────────────────────────────────────
    function renderPinnedSidebar() {
        const pinnedList = document.getElementById('pinnedList');
        const pinnedCountEl = document.getElementById('pinnedCount');
        const pinned = announcementsDB.filter(a => pins[a.id]);
        pinnedCountEl.textContent = pinned.length;
        if (!pinned.length) {
            pinnedList.innerHTML = '<div class="text-xs text-center py-2" style="color:var(--muted)">No pinned items</div>';
            return;
        }
        pinnedList.innerHTML = pinned.map(a => `
            <div class="history-item flex items-center gap-2 text-xs" style="color:var(--primary)">
                <i class="fas fa-thumbtack text-orange-500 flex-shrink-0"></i>
                <span class="truncate">${escapeHtml(a.title)}</span>
            </div>
        `).join('');
    }

    // ── Filter & Sort ─────────────────────────────────────────
    function getFilteredAnnouncements() {
        let results = [...announcementsDB];
        if (currentSearchTerm.trim()) {
            const kw = currentSearchTerm.toLowerCase().trim();
            results = results.filter(a =>
                a.title.toLowerCase().includes(kw) ||
                a.description.toLowerCase().includes(kw) ||
                a.professor.toLowerCase().includes(kw)
            );
        }
        if (currentDate) results = results.filter(a => a.date === currentDate);

        if (currentSort === 'pinned') {
            results.sort((a,b) => (pins[b.id]?1:0) - (pins[a.id]?1:0));
        } else if (currentSort === 'latest') {
            results.sort((a,b) => new Date(b.date) - new Date(a.date));
        } else {
            results.sort((a,b) => new Date(a.date) - new Date(b.date));
        }
        if (currentSort !== 'pinned') {
            results.sort((a,b) => (pins[b.id]?1:0) - (pins[a.id]?1:0));
        }
        return results;
    }

    // ── Render Cards ──────────────────────────────────────────
    function renderResults() {
        const filtered = getFilteredAnnouncements();
        const count = filtered.length;
        resultCount.textContent = `${count} item${count !== 1 ? 's' : ''}`;

        if (!count) {
            resultsContainer.innerHTML = '';
            emptyState.classList.remove('hidden');
            return;
        }
        emptyState.classList.add('hidden');

        resultsContainer.innerHTML = filtered.map(ann => {
            const liked    = !!likes[ann.id];
            const pinned   = !!pins[ann.id];
            const notifOn  = !!notifs[ann.id];
            const lc       = likeCounts[ann.id] || 0;
            const cc       = (comments[ann.id] || []).length;

            return `
            <div class="announce-card" data-id="${ann.id}">
                <div style="padding:18px 20px 12px">
                    <!-- Header row -->
                    <div style="display:flex;align-items:flex-start;justify-content:space-between;gap:12px;margin-bottom:12px">
                        <div style="display:flex;align-items:center;gap:12px;flex:1">
                            <div style="width:44px;height:44px;background:var(--active-bg);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:20px;flex-shrink:0">${ann.professorAvatar}</div>
                            <div>
                                <div class="card-author-name">${escapeHtml(ann.professor)}</div>
                                <div class="card-meta"><i class="far fa-calendar-alt mr-1"></i>${formatDate(ann.date)} at ${ann.time}</div>
                            </div>
                        </div>
                        <div style="display:flex;align-items:center;gap:8px">
                            <div class="card-banner ${getBannerClass(ann.bannerType)} px-3 py-1 hidden sm:block">
                                <p class="text-white text-xs font-bold tracking-wide">${ann.bannerText}</p>
                            </div>
                            <!-- Pin button top-right: white=unpinned, orange=pinned -->
                            <button type="button"
                                onclick="togglePin(${ann.id})"
                                title="${pinned ? 'Unpin' : 'Pin this announcement'}"
                                style="flex:none;width:34px;height:34px;padding:0;border-radius:50%;background:none;border:none;cursor:pointer;display:flex;align-items:center;justify-content:center;font-size:16px;transition:all 0.2s;color:${pinned ? '#e65100' : 'rgba(255,255,255,0.7)'}">
                                <i class="${pinned ? 'fas' : 'far'} fa-thumbtack"></i>
                            </button>
                        </div>
                    </div>

                    <!-- Title & description -->
                    <div class="card-title">${escapeHtml(ann.title)}</div>
                    <div class="card-desc">${escapeHtml(ann.description)}</div>

                    ${pinned ? '<div style="margin-top:8px"><span style="font-size:10px;color:#e65100;font-weight:700"><i class="fas fa-thumbtack mr-1"></i>Pinned</span></div>' : ''}
                </div>

                <!-- Stats bar -->
                <div class="post-stats">
                    <span onclick="toggleLike(${ann.id})">
                        <i class="${liked?'fas':'far'} fa-heart" style="${liked?'color:#dc2626':''}"></i>
                        <span id="lc-${ann.id}">${lc}</span> Likes
                    </span>
                    <span onclick="openComments(${ann.id})">
                        <i class="far fa-comment"></i>
                        <span id="cc-${ann.id}">${cc}</span> Comments
                    </span>
                    <span onclick="sharePost(${ann.id}, '${escapeHtml(ann.title)}')">
                        <i class="far fa-share-square"></i> Share
                    </span>
                </div>

                <!-- Action buttons -->
                <div class="action-buttons">
                    <button type="button" class="action-btn ${liked?'liked':''}" onclick="toggleLike(${ann.id})">
                        <i class="${liked?'fas':'far'} fa-heart"></i> ${liked?'Liked':'Like'}
                    </button>
                    <button type="button" class="action-btn" onclick="openComments(${ann.id})">
                        <i class="far fa-comment"></i> Comment
                    </button>
                    <button type="button" class="action-btn" onclick="sharePost(${ann.id}, '${escapeHtml(ann.title)}')">
                        <i class="fas fa-share-alt"></i> Share
                    </button>
                </div>

                <!-- Comments section -->
                <div class="comments-section" id="cs-${ann.id}">
                    <div class="comment-input-row">
                        <input type="text" id="ci-${ann.id}" placeholder="Write a comment..." />
                        <button type="button" onclick="postComment(${ann.id})">Post</button>
                    </div>
                    <div id="cl-${ann.id}">${renderCommentsList(ann.id)}</div>
                </div>
            </div>`;
        }).join('');

        renderPinnedSidebar();
    }

    function renderCommentsList(id) {
        const list = comments[id] || [];
        if (!list.length) return '<div class="no-comments">No comments yet. Be the first!</div>';
        return list.map(c => `
            <div class="comment-item">
                <div class="comment-avatar"><i class="fas fa-user"></i></div>
                <div>
                    <div class="comment-author">${escapeHtml(c.author)}</div>
                    <div class="comment-text">${escapeHtml(c.text)}</div>
                    <div class="comment-time">${c.time}</div>
                </div>
            </div>
        `).join('');
    }

    // ── Interactions ──────────────────────────────────────────
    function toggleLike(id) {
        fetch('LikeHandler.ashx?action=toggle&postId=' + id, { credentials: 'same-origin' })
            .then(r => r.json())
            .then(res => {
                if (!res.ok) { showToast('Error: ' + res.error); return; }
                likes[id]      = res.liked;
                likeCounts[id] = res.likeCount;
                saveState();
                renderResults();
                showToast(res.liked ? '❤️ Liked!' : 'Like removed');
            })
            .catch(() => showToast('Could not update like'));
    }

    function pushNotification(msg, icon) {
        const notifs = JSON.parse(localStorage.getItem('campus_notifications') || '[]');
        notifs.unshift({ msg, icon: icon || 'fa-bell', time: new Date().toISOString(), read: false });
        if (notifs.length > 50) notifs.length = 50;
        localStorage.setItem('campus_notifications', JSON.stringify(notifs));
        window.dispatchEvent(new StorageEvent('storage', { key: 'campus_notifications', newValue: JSON.stringify(notifs) }));
    }

    function togglePin(id) {
        pins[id] = !pins[id];
        saveState();
        const ann = announcementsDB.find(a => a.id === id);
        if (ann) pushNotification((pins[id] ? '📌 Pinned: ' : '📌 Unpinned: ') + ann.title, 'fa-thumbtack');
        // Notify all tabs — Student uses campus_pins, Teacher uses teacher_pins
        window.dispatchEvent(new StorageEvent('storage', { key: 'campus_pins', newValue: JSON.stringify(pins) }));
        window.dispatchEvent(new StorageEvent('storage', { key: 'teacher_pins', newValue: JSON.stringify(pins) }));
        renderResults();
        showToast(pins[id] ? '📌 Pinned!' : 'Unpinned');
    }

    function toggleNotif(id) {
        notifs[id] = !notifs[id];
        saveState();
        updateNotifBadge();
        renderResults();
        showToast(notifs[id] ? '🔔 Notifications on!' : '🔕 Notifications off');
    }

    function openComments(id) {
        const sec = document.getElementById('cs-' + id);
        if (!sec) return;
        sec.classList.toggle('show');
        if (sec.classList.contains('show')) {
            const input = document.getElementById('ci-' + id);
            if (input) setTimeout(() => input.focus(), 50);
        }
    }

    function postComment(id) {
        const input = document.getElementById('ci-' + id);
        if (!input) return;
        const text = input.value.trim();
        if (!text) { showToast('Please write a comment first'); return; }

        fetch('CommentHandler.ashx?action=add', { credentials: 'same-origin',
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ postId: id, comment: text })
        })
        .then(r => r.json())
        .then(res => {
            if (!res.success) { showToast('Error: ' + (res.error || 'Could not post comment')); return; }
            input.value = '';
            // Reload comments from DB
            fetch('CommentHandler.ashx?action=get&postId=' + id, { credentials: 'same-origin' })
                .then(r => r.json())
                .then(list => {
                    const cl = document.getElementById('cl-' + id);
                    if (cl) cl.innerHTML = list.map(c =>
                        '<div class="comment-item">' +
                        '<div class="comment-avatar"><i class="fas fa-user"></i></div>' +
                        '<div><div class="comment-author">' + escapeHtml(c.author) + '</div>' +
                        '<div class="comment-text">' + escapeHtml(c.text) + '</div>' +
                        '<div class="comment-time">' + escapeHtml(c.date) + '</div></div></div>'
                    ).join('');
                    const cc = document.getElementById('cc-' + id);
                    if (cc) cc.textContent = list.length;
                })
                .catch(() => {});
            showToast('?? Comment posted!');
        })
        .catch(() => showToast('Could not post comment'));
    }

    function sharePost(id, title) {
        const url = window.location.href.split('?')[0] + '?post=' + id;
        pushNotification('🔗 "' + title + '" was shared', 'fa-share-alt');
        if (navigator.clipboard) {
            navigator.clipboard.writeText(url).then(() => showToast('🔗 Link copied: ' + title));
        } else {
            showToast('📤 Shared: ' + title);
        }
    }

    // ── Search & Filters ──────────────────────────────────────
    function performSearch() {
        const term = searchInput.value;
        currentSearchTerm = term;
        if (lastSearchHidden) lastSearchHidden.value = term;
        if (term.trim()) addToHistory(term);
        renderResults();
    }

    function applyFilters() {
        currentDate  = dateFilter.value || '';
        currentSort  = sortFilter.value;
        renderResults();
    }

    function resetEverything() {
        searchInput.value = '';
        dateFilter.value  = '';
        sortFilter.value  = 'latest';
        currentSearchTerm = ''; currentDate = ''; currentSort = 'latest';
        if (lastSearchHidden) lastSearchHidden.value = '';
        renderResults();
    }

    // ── Init ──────────────────────────────────────────────────
    function init() {
        renderHistory();
        renderPinnedSidebar();
        updateNotifBadge();

        flatpickr(dateFilter, {
            dateFormat: "Y-m-d",
            altInput: true,
            altFormat: "F j, Y",
            onChange: (_, dateStr) => { currentDate = dateStr || ''; renderResults(); }
        });

        searchInput.addEventListener('keypress', e => { if (e.key === 'Enter') performSearch(); });
        sortFilter.addEventListener('change', applyFilters);
        if (resetFiltersBtn) resetFiltersBtn.addEventListener('click', resetEverything);
        if (clearHistoryBtn) clearHistoryBtn.addEventListener('click', () => {
            if (confirm('Clear all search history?')) { searchHistory = []; saveHistory(); }
        });
        if (notificationBtn) notificationBtn.addEventListener('click', () => {
            navigateWithFlip('Notifications.aspx');
        });

        try {
            if (lastSearchHidden && lastSearchHidden.value) {
                searchInput.value = lastSearchHidden.value;
                performSearch();
            } else {
                renderResults();
            }
        } catch(e) { renderResults(); }
    }

    init();

    function navigateWithFlip(url) {
        const shell = document.querySelector('.relative.z-10') || document.body;
        shell.style.animation = 'flipIn 0.18s ease-in reverse forwards';
        setTimeout(() => { window.location.href = url; }, 160);
    }

    // ════════════════════════════════════════════════════════
    // THEME — reads global campus_theme
    // ════════════════════════════════════════════════════════
    (function () {
        const KEY = 'campus_theme';

        function applyTheme(mode) {
            document.body.classList.toggle('dark-mode', mode === 'dark');
        }

        applyTheme(localStorage.getItem(KEY) || 'light');

        window.addEventListener('storage', e => {
            if (e.key === KEY) applyTheme(e.newValue || 'light');
            if (e.key === 'campus_pins' || e.key === 'teacher_pins') {
                pins = loadPins();
                renderResults();
            }
            if (e.key === 'sd_notifs') {
                notifs = JSON.parse(e.newValue || '{}');
                updateNotifBadge();
                renderResults();
            }
            if (e.key === 'teacher_announcements') {
                announcementsDB = loadAnnouncementsDB();
                renderResults();
            }
            if (e.key === 'campus_notifications') {
                updateNotifBadge();
            }
        });

        // Flip-in on arrival
        const shell = document.querySelector('.relative.z-10') || document.body;
        shell.classList.add('page-flip-in');
        shell.addEventListener('animationend', () => shell.classList.remove('page-flip-in'), { once: true });
    })();
    </script>
</body>
</html>
