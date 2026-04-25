<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>CampusConnect | Student Announcement Dashboard</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

    <style>
        * { font-family: 'Inter', system-ui, -apple-system, sans-serif; }

        /* ── LIGHT MODE — Ice Blue palette ── */
        :root {
            --page-text: #1E3A8A;
            --surface: rgba(255,255,255,0.97);
            --surface-strong: #ffffff;
            --surface-soft: #EFF6FF;
            --border: #DBEAFE;
            --border-strong: #93C5FD;
            --primary: #1E3A8A;
            --primary-2: #2563EB;
            --accent: #3B82F6;
            --muted: #64748B;
            --muted-light: #94A3B8;
            --shadow: 0 4px 20px rgba(30,58,138,0.10);
            --shadow-md: 0 8px 32px rgba(30,58,138,0.14);
            --active-bg: #DBEAFE;
        }

        body {
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
            color: var(--page-text);
            background: linear-gradient(160deg,#EFF6FF 0%,#F0F5FF 50%,#E8F0FE 100%);
            background-attachment: fixed;
            transition: background 0.4s ease, color 0.4s ease;
        }

        /* ── DARK MODE ── */
        body.dark-mode {
            --page-text: #e4e6eb;
            --surface: rgba(15,25,55,0.75);
            --surface-strong: rgba(15,25,55,0.92);
            --surface-soft: rgba(255,255,255,0.07);
            --border: rgba(255,255,255,0.1);
            --border-strong: rgba(255,255,255,0.2);
            --primary: #818cf8;
            --primary-2: #6366f1;
            --accent: #6366f1;
            --muted: #94a3b8;
            --muted-light: #64748b;
            --shadow: 0 8px 32px rgba(0,0,0,0.5);
            --shadow-md: 0 12px 40px rgba(0,0,0,0.6);
            --active-bg: rgba(99,102,241,0.18);
            background: linear-gradient(rgba(0,0,0,0.35),rgba(0,0,0,0.35)), url('bg.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .glass-nav {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(16px);
            border-bottom: 1px solid #DBEAFE;
            box-shadow: 0 2px 16px rgba(30,58,138,0.08);
            transition: background 0.4s ease, border-color 0.4s ease;
        }
        body.dark-mode .glass-nav {
            background: rgba(15,25,55,0.82);
            border-bottom-color: rgba(255,255,255,0.08);
            box-shadow: 0 2px 16px rgba(0,0,0,0.4);
        }

        .glass-sidebar {
            background: linear-gradient(145deg,#EFF6FF 0%,#F8FAFF 100%);
            backdrop-filter: blur(12px);
            border: 1px solid #DBEAFE;
            box-shadow: 0 4px 24px rgba(30,58,138,0.10);
            transition: background 0.4s ease, border-color 0.4s ease;
        }
        body.dark-mode .glass-sidebar {
            background: rgba(15,25,55,0.75);
            border-color: rgba(255,255,255,0.1);
            box-shadow: 0 8px 32px rgba(0,0,0,0.5);
        }

        .glass-card {
            background: linear-gradient(145deg,#EFF6FF 0%,#F8FAFF 100%);
            backdrop-filter: blur(12px);
            border: 1px solid #DBEAFE;
            box-shadow: 0 4px 20px rgba(30,58,138,0.08);
            transition: all 0.3s ease;
        }

        .glass-card:hover {
            border-color: #93C5FD;
            box-shadow: 0 8px 28px rgba(30,58,138,0.14);
            transform: translateY(-2px);
        }
        body.dark-mode .glass-card {
            background: rgba(15,25,55,0.75);
            border-color: rgba(255,255,255,0.1);
            box-shadow: 0 8px 32px rgba(0,0,0,0.5);
        }
        body.dark-mode .glass-card:hover {
            border-color: rgba(255,255,255,0.2);
            box-shadow: 0 12px 40px rgba(0,0,0,0.6);
        }

        .hero-section {
            background: linear-gradient(135deg,#1E3A8A 0%,#2563EB 60%,#3B82F6 100%);
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

        .announce-card {
            background: linear-gradient(145deg,#EFF6FF 0%,#FFFFFF 100%);
            border: 1px solid #DBEAFE;
            border-radius: 20px;
            transition: all 0.3s cubic-bezier(0.4,0,0.2,1);
            box-shadow: 0 4px 20px rgba(30,58,138,0.08);
            overflow: hidden;
        }

        .announce-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 32px rgba(30,58,138,0.15);
            border-color: #93C5FD;
        }
        body.dark-mode .announce-card {
            background: rgba(15,25,55,0.92);
            border-color: rgba(255,255,255,0.1);
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
        }
        body.dark-mode .announce-card:hover {
            box-shadow: 0 12px 32px rgba(0,0,0,0.5);
            border-color: rgba(99,102,241,0.4);
        }

        .card-author-name { color: #1E3A8A; font-weight: 700; font-size: 15px; }
        .card-meta        { color: #64748B; font-size: 12px; }
        .card-title       { color: #1E3A8A; font-size: 18px; font-weight: 700; margin-bottom: 8px; }
        .card-desc        { color: #334155; font-size: 13px; line-height: 1.6; }
        body.dark-mode .card-author-name,
        body.dark-mode .card-title { color: #93C5FD; }
        body.dark-mode .card-desc  { color: #e4e6eb; }

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

        .action-buttons { display: flex; gap: 4px; padding: 6px 20px 10px; }
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
        .action-btn:hover { background: var(--surface-soft); color: var(--primary); }
        .action-btn.liked { color: #dc2626; }
        .action-btn.pinned-active { color: #e65100; }
        .action-btn.notif-active { color: #6366f1; }

        .comments-section { padding: 0 20px 16px; border-top: 1px solid var(--border); display: none; }
        .comments-section.show { display: block; }
        .comment-input-row { display: flex; gap: 8px; margin: 12px 0; }
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
        .comment-item { display: flex; gap: 10px; padding: 10px 0; border-bottom: 1px solid var(--border); font-size: 13px; }
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

        .cat-badge { display: inline-block; padding: 2px 10px; border-radius: 20px; font-size: 10px; font-weight: 700; }
        .cat-exam       { background: #e3f2fd; color: #1976d2; }
        .cat-suspension { background: #ffebee; color: #c62828; }
        .cat-event      { background: #e8f5e9; color: #2e7d32; }
        .cat-default    { background: #f3e5f5; color: #7b1fa2; }

        body.dark-mode .cat-exam       { background: rgba(25,118,210,0.2); color: #90caf9; }
        body.dark-mode .cat-suspension { background: rgba(198,40,40,0.2);  color: #ef9a9a; }
        body.dark-mode .cat-event      { background: rgba(46,125,50,0.2);  color: #a5d6a7; }
        body.dark-mode .cat-default    { background: rgba(123,31,162,0.2); color: #ce93d8; }

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

        .search-input {
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(4px);
            border: 1px solid rgba(255,255,255,0.2);
            transition: all 0.2s;
            color: white;
        }
        .search-input:focus {
            background: rgba(255,255,255,0.15);
            border-color: #6366f1;
            box-shadow: 0 0 0 3px rgba(99,102,241,0.3);
            outline: none;
        }
        .search-input::placeholder { color: rgba(255,255,255,0.6); }

        .filter-select {
            background: var(--surface-soft);
            backdrop-filter: blur(4px);
            border: 1px solid var(--border);
            color: var(--page-text);
            transition: border-color 0.2s;
        }
        .filter-select:focus { border-color: #6366f1; outline: none; }
        .filter-select option { background: var(--surface-strong); color: var(--page-text); }

        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: rgba(255,255,255,0.1); border-radius: 10px; }
        ::-webkit-scrollbar-thumb { background: rgba(99,102,241,0.5); border-radius: 10px; }

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

        @keyframes flipIn {
            0%   { transform: perspective(1200px) rotateY(90deg); opacity: 0; }
            100% { transform: perspective(1200px) rotateY(0deg);  opacity: 1; }
        }
        .page-flip-in { animation: flipIn 0.18s ease-out forwards; transform-origin: center center; }

        *, *::before, *::after {
            transition: background-color 0.3s ease, border-color 0.3s ease,
                        color 0.3s ease, box-shadow 0.3s ease;
        }
        .page-flip-in { transition: none !important; }

        @media (max-width: 1024px) {
            .sidebar-hidden-mobile { position: fixed; left: -280px; transition: left 0.3s; z-index: 50; }
        }

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

            <!-- NAVBAR -->
            <header class="glass-nav sticky top-0 z-40 shadow-lg">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="flex flex-wrap items-center justify-between py-3 md:py-4 gap-3">

                        <!-- Logo -->
                        <div class="flex items-center gap-3 cursor-pointer group">
                            <div class="bg-gradient-to-br from-indigo-500 to-indigo-600 p-2 rounded-xl shadow-xl transition group-hover:scale-105">
                                <i class="fas fa-university text-white text-xl"></i>
                            </div>
                            <div>
                                <h1 class="font-extrabold text-xl md:text-2xl tracking-tight" style="color:var(--primary)">CampusConnect</h1>
                                <p class="text-xs font-medium hidden sm:block" style="color:var(--muted)">Student Portal</p>
                            </div>
                        </div>

                        <!-- Search Bar -->
                        <div class="flex-1 max-w-md mx-4">
                            <div class="relative">
                                <i class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-indigo-300 text-sm"></i>
                                <asp:TextBox ID="searchInput" runat="server" CssClass="search-input w-full pl-10 pr-4 py-2 rounded-xl" placeholder="Search announcements..."></asp:TextBox>
                            </div>
                        </div>

                        <!-- Right controls -->
                        <div class="flex items-center gap-3 md:gap-4">
                            <asp:HyperLink ID="homeLink" runat="server" NavigateUrl="~/Student.aspx"
                                CssClass="p-2 hover:bg-white/20 rounded-full transition-all" style="color:var(--primary)">
                                <i class="fas fa-home text-xl"></i>
                            </asp:HyperLink>

                            <div class="relative">
                                <button type="button" id="notificationBtn" class="p-2 hover:bg-white/20 rounded-full transition" style="color:var(--primary)">
                                    <i class="fas fa-bell text-xl"></i>
                                </button>
                                <span id="notificationBadge" class="absolute -top-1 -right-1 bg-red-500 text-white text-[10px] font-bold rounded-full min-w-[20px] h-5 px-1 flex items-center justify-center shadow-lg" style="display:none">0</span>
                            </div>

                            <div class="flex items-center gap-3 pl-2" style="border-left:1px solid var(--border)">
                                <div class="w-9 h-9 md:w-10 md:h-10 bg-gradient-to-br from-indigo-400 to-indigo-600 rounded-full flex items-center justify-center text-white shadow-lg">
                                    <i class="fas fa-user-graduate text-sm md:text-base"></i>
                                </div>
                                <div class="hidden sm:block">
                                    <p class="text-sm font-semibold leading-tight" style="color:var(--primary)">Maria Santos</p>
                                    <p class="text-xs" style="color:var(--muted)">Student · BSIT</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </header>

            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6 md:py-8">

                <!-- HERO -->
                <div class="hero-section rounded-2xl mb-8 p-8 md:p-10 text-center shadow-2xl border border-white/20 relative overflow-hidden">
                    <div class="relative z-10">
                        <div class="inline-block p-4 bg-white/20 backdrop-blur-md rounded-full mb-5">
                            <i class="fas fa-megaphone text-4xl md:text-5xl text-white"></i>
                        </div>
                        <h2 class="text-2xl md:text-4xl lg:text-5xl font-black text-white drop-shadow-2xl mb-3">
                            Stay Updated with Campus Announcements
                        </h2>
                        <p class="text-indigo-100 text-base md:text-lg max-w-2xl mx-auto drop-shadow">
                            Find events, schedules, and important updates from your university community
                        </p>
                    </div>
                </div>

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
                            <div class="grid grid-cols-1 sm:grid-cols-3 gap-3">
                                <select id="categoryFilter" class="filter-select px-4 py-2 rounded-xl text-sm cursor-pointer">
                                    <option value="all">📢 All Announcements</option>
                                    <option value="Exam Schedule">📅 Exam Schedule</option>
                                    <option value="Class Suspension">⚠️ Class Suspension</option>
                                    <option value="Campus Events">🎉 Campus Events</option>
                                </select>
                                <input type="text" id="dateFilter" placeholder="📅 Filter by date" class="filter-select px-4 py-2 rounded-xl text-sm cursor-pointer" />
                                <select id="sortFilter" class="filter-select px-4 py-2 rounded-xl text-sm cursor-pointer">
                                    <option value="latest">📅 Latest First</option>
                                    <option value="oldest">📅 Oldest First</option>
                                    <option value="pinned">📌 Pinned First</option>
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
                            <div class="text-center py-12" style="color:var(--muted)">
                                <i class="fas fa-spinner fa-spin text-3xl"></i>
                                <p class="mt-2">Loading announcements...</p>
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
                <i class="far fa-copyright"></i> 2026 CampusConnect — Connecting Students to Campus Life
            </footer>
        </div>
    </form>

    <script>
    const announcementsDB = [
        { id:1, title:"Final Exam Schedule Spring 2026", category:"Exam Schedule", date:"2026-05-10", time:"09:00 AM", professor:"Dr. Reyes", professorAvatar:"👨‍🏫", description:"Final exams will be held from May 15-20, 2026. Please check your exam permits online. Bring school ID and test permit.", bannerText:"EXAM SCHEDULE", bannerType:"exam" },
        { id:2, title:"Class Suspension due to Typhoon", category:"Class Suspension", date:"2026-04-25", time:"08:00 PM", professor:"Admin Office", professorAvatar:"🏫", description:"Classes suspended on April 26-27 due to Typhoon. All activities will shift to online learning platforms.", bannerText:"CLASS SUSPENSION", bannerType:"suspension" },
        { id:3, title:"University Hackathon 2026", category:"Campus Events", date:"2026-05-20", time:"10:00 AM", professor:"IT Department", professorAvatar:"💻", description:"48-hour coding challenge with exciting prizes. Form teams of 3-4 members. Registration ends May 15.", bannerText:"HACKATHON", bannerType:"events" },
        { id:4, title:"Midterm Grade Release", category:"Exam Schedule", date:"2026-04-22", time:"02:00 PM", professor:"Registrar", professorAvatar:"📊", description:"Midterm grades are now available via the student portal. Check your assessment and email your instructors for concerns.", bannerText:"GRADES OUT", bannerType:"exam" },
        { id:5, title:"Transport Strike Advisory", category:"Class Suspension", date:"2026-04-28", time:"07:30 AM", professor:"Student Affairs", professorAvatar:"🚌", description:"No face-to-face classes on April 30 due to nationwide transport strike. Asynchronous activities will be provided.", bannerText:"STRIKE DAY", bannerType:"suspension" },
        { id:6, title:"Cultural Festival 2026", category:"Campus Events", date:"2026-05-05", time:"09:00 AM", professor:"OSA", professorAvatar:"🎭", description:"Celebration of arts, international food fair, and cultural performances. Free entrance for all students!", bannerText:"CULTURAL FEST", bannerType:"events" },
        { id:7, title:"Research Colloquium", category:"Campus Events", date:"2026-05-12", time:"11:00 AM", professor:"Graduate School", professorAvatar:"🔬", description:"Present your research papers and get feedback from panelists. Best paper receives recognition award.", bannerText:"CALL FOR PAPERS", bannerType:"events" }
    ];

    const STORAGE = {
        get: k => JSON.parse(localStorage.getItem(k) || 'null'),
        set: (k,v) => localStorage.setItem(k, JSON.stringify(v))
    };

    let likes      = STORAGE.get('sd_likes')     || {};
    let likeCounts = STORAGE.get('sd_likeCounts') || {};
    let pins       = STORAGE.get('campus_pins')   || {};   // shared with Teacher + SearchDashboard
    let notifs     = STORAGE.get('sd_notifs')     || {};
    let comments   = STORAGE.get('sd_comments')   || {};
    let searchHistory = STORAGE.get('campus_history') || [];

    announcementsDB.forEach(a => {
        if (likeCounts[a.id] === undefined) likeCounts[a.id] = Math.floor(Math.random()*30)+2;
    });

    function saveState() {
        STORAGE.set('sd_likes',      likes);
        STORAGE.set('sd_likeCounts', likeCounts);
        STORAGE.set('campus_pins',   pins);
        STORAGE.set('sd_notifs',     notifs);
        STORAGE.set('sd_comments',   comments);
    }

    const searchInput      = document.getElementById('<%= searchInput.ClientID %>');
    const lastSearchHidden = document.getElementById('<%= lastSearchTerm.ClientID %>');
    const categoryFilter   = document.getElementById('categoryFilter');
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
    let currentCategory   = 'all';
    let currentDate       = '';
    let currentSort       = 'latest';

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
        if (cat === 'Exam Schedule')    return 'cat-exam';
        if (cat === 'Class Suspension') return 'cat-suspension';
        if (cat === 'Campus Events')    return 'cat-event';
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
        const count = Object.values(notifs).filter(Boolean).length;
        notificationBadge.textContent = count;
        notificationBadge.style.display = count > 0 ? 'flex' : 'none';
    }

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

    function renderPinnedSidebar() {
        const pinnedList    = document.getElementById('pinnedList');
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
        if (currentCategory !== 'all') results = results.filter(a => a.category === currentCategory);
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
            const liked   = !!likes[ann.id];
            const pinned  = !!pins[ann.id];
            const notifOn = !!notifs[ann.id];
            const lc      = likeCounts[ann.id] || 0;
            const cc      = (comments[ann.id] || []).length;
            const catClass = getCatClass(ann.category);
            const catIcon  = ann.category === 'Exam Schedule' ? '📅' : ann.category === 'Class Suspension' ? '⚠️' : '🎉';

            return `
            <div class="announce-card" data-id="${ann.id}">
                <div style="padding:18px 20px 12px">
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
                            <button type="button"
                                onclick="togglePin(${ann.id})"
                                title="${pinned ? 'Unpin' : 'Pin this announcement'}"
                                style="flex:none;width:34px;height:34px;padding:0;border-radius:50%;background:none;border:none;cursor:pointer;display:flex;align-items:center;justify-content:center;font-size:16px;transition:all 0.2s;color:${pinned ? '#e65100' : 'rgba(255,255,255,0.7)'}">
                                <i class="${pinned ? 'fas' : 'far'} fa-thumbtack"></i>
                            </button>
                        </div>
                    </div>
                    <div class="card-title">${escapeHtml(ann.title)}</div>
                    <div class="card-desc">${escapeHtml(ann.description)}</div>
                    <div style="margin-top:10px">
                        <span class="cat-badge ${catClass}">${catIcon} ${ann.category}</span>
                        ${pinned ? '<span style="margin-left:6px;font-size:10px;color:#e65100;font-weight:700"><i class="fas fa-thumbtack mr-1"></i>Pinned</span>' : ''}
                    </div>
                </div>

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
                    <span onclick="toggleNotif(${ann.id})" title="Toggle notification">
                        <i class="${notifOn?'fas':'far'} fa-bell" style="${notifOn?'color:#6366f1':''}"></i>
                        ${notifOn ? '<span style="font-size:10px;color:#6366f1">On</span>' : 'Notify'}
                    </span>
                </div>

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
                    <button type="button" class="action-btn ${notifOn?'notif-active':''}" onclick="toggleNotif(${ann.id})">
                        <i class="${notifOn?'fas':'far'} fa-bell"></i> ${notifOn?'Notif On':'Notify'}
                    </button>
                </div>

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

    function toggleLike(id) {
        likes[id] = !likes[id];
        likeCounts[id] = (likeCounts[id] || 0) + (likes[id] ? 1 : -1);
        if (likeCounts[id] < 0) likeCounts[id] = 0;
        saveState();
        renderResults();
        showToast(likes[id] ? '❤️ Liked!' : 'Like removed');
    }

    function togglePin(id) {
        pins[id] = !pins[id];
        saveState();
        window.dispatchEvent(new StorageEvent('storage', { key: 'campus_pins', newValue: JSON.stringify(pins) }));
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
        if (!comments[id]) comments[id] = [];
        comments[id].push({
            author: 'You',
            text: text,
            time: new Date().toLocaleTimeString('en-US', { hour:'2-digit', minute:'2-digit' })
        });
        saveState();
        input.value = '';
        const cl = document.getElementById('cl-' + id);
        if (cl) cl.innerHTML = renderCommentsList(id);
        const cc = document.getElementById('cc-' + id);
        if (cc) cc.textContent = comments[id].length;
        showToast('💬 Comment posted!');
    }

    function sharePost(id, title) {
        const url = window.location.href.split('?')[0] + '?post=' + id;
        if (navigator.clipboard) {
            navigator.clipboard.writeText(url).then(() => showToast('🔗 Link copied: ' + title));
        } else {
            showToast('📤 Shared: ' + title);
        }
    }

    function performSearch() {
        const term = searchInput.value;
        currentSearchTerm = term;
        if (lastSearchHidden) lastSearchHidden.value = term;
        if (term.trim()) addToHistory(term);
        renderResults();
    }

    function applyFilters() {
        currentCategory = categoryFilter.value;
        currentDate     = dateFilter.value || '';
        currentSort     = sortFilter.value;
        renderResults();
    }

    function resetEverything() {
        searchInput.value    = '';
        categoryFilter.value = 'all';
        dateFilter.value     = '';
        sortFilter.value     = 'latest';
        currentSearchTerm = ''; currentCategory = 'all'; currentDate = ''; currentSort = 'latest';
        if (lastSearchHidden) lastSearchHidden.value = '';
        renderResults();
    }

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
        categoryFilter.addEventListener('change', applyFilters);
        sortFilter.addEventListener('change', applyFilters);
        if (resetFiltersBtn) resetFiltersBtn.addEventListener('click', resetEverything);
        if (clearHistoryBtn) clearHistoryBtn.addEventListener('click', () => {
            if (confirm('Clear all search history?')) { searchHistory = []; saveHistory(); }
        });
        if (notificationBtn) notificationBtn.addEventListener('click', () => {
            const on = Object.values(notifs).filter(Boolean).length;
            showToast(on > 0 ? `🔔 You have ${on} active notification(s)` : '🔕 No active notifications');
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

    // ── Theme + flip-in ──────────────────────────────────────
    (function () {
        const KEY = 'campus_theme';

        function applyTheme(mode) {
            document.body.classList.toggle('dark-mode', mode === 'dark');
        }

        applyTheme(localStorage.getItem(KEY) || 'dark');

        window.addEventListener('storage', e => {
            if (e.key === KEY) applyTheme(e.newValue || 'dark');
            if (e.key === 'campus_pins') {
                pins = JSON.parse(e.newValue || '{}');
                renderResults();
            }
        });

        const shell = document.querySelector('.relative.z-10') || document.body;
        shell.classList.add('page-flip-in');
        shell.addEventListener('animationend', () => shell.classList.remove('page-flip-in'), { once: true });
    })();
    </script>
</body>
</html>
