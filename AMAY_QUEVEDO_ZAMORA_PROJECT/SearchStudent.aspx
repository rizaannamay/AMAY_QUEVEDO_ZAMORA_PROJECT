<%@ Page Language="C#" AutoEventWireup="true"  %>

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

        /* -- BACKGROUND -- */
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

        /* -- DARK MODE -- */
        body.dark-mode {
            --bg-image: url('bg.jpg');
            --page-text: #e4e6eb;
            --surface: rgba(15,25,55,0.85);
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

        /* -- NAVBAR -- */
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

        .glass-nav h1,
        .glass-nav p,
        .glass-nav a,
        .glass-nav button { color: #ffffff !important; }
        .glass-nav .text-muted { color: rgba(255,255,255,0.7) !important; }

        .glass-sidebar {
            background: var(--surface);
            backdrop-filter: blur(12px);
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            transition: background 0.4s ease, border-color 0.4s ease;
        }

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

        .card-author-name { color: var(--primary); font-weight: 700; font-size: 15px; }
        .card-meta        { color: var(--muted); font-size: 12px; }
        .card-title       { color: var(--primary); font-size: 18px; font-weight: 700; margin-bottom: 8px; }
        .card-desc        { color: var(--page-text); font-size: 13px; line-height: 1.6; }

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
        body.dark-mode .action-btn:hover { background: rgba(255,255,255,0.06); color: #93C5FD; }

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

        .filter-select {
            background: var(--surface-soft);
            backdrop-filter: blur(4px);
            border: 1px solid var(--border);
            color: var(--page-text);
        }
        .filter-select:focus { border-color: #6366f1; outline: none; }

        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: rgba(255,255,255,0.1); border-radius: 10px; }
        ::-webkit-scrollbar-thumb { background: rgba(99,102,241,0.5); border-radius: 10px; }

        #resultsContainer { display: flex; flex-direction: column; gap: 16px; }

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

        /* ========== CONFIRMATION DIALOG - CENTERED CARD STYLE ========== */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(4px);
            z-index: 10000;
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.2s ease, visibility 0.2s ease;
        }
        .modal-overlay.active {
            opacity: 1;
            visibility: visible;
        }
        .confirm-card {
            max-width: 420px;
            width: 90%;
            background: white;
            border-radius: 28px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
            padding: 2rem 1.75rem;
            text-align: center;
            transform: scale(0.95);
            transition: transform 0.2s ease;
        }
        .modal-overlay.active .confirm-card {
            transform: scale(1);
        }
        body.dark-mode .confirm-card {
            background: #1e293b;
        }
        .icon-wrapper {
            background: #fee2e2;
            width: 64px;
            height: 64px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.25rem;
        }
        .icon-wrapper i {
            font-size: 2rem;
            color: #dc2626;
        }
        .info-icon-wrapper {
            background: #dbeafe;
            width: 64px;
            height: 64px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.25rem;
        }
        .info-icon-wrapper i {
            font-size: 2rem;
            color: #3b82f6;
        }
        .confirm-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 0.5rem;
        }
        body.dark-mode .confirm-title {
            color: #f1f5f9;
        }
        .confirm-message {
            font-size: 1rem;
            color: #475569;
            margin-bottom: 1.75rem;
            line-height: 1.5;
        }
        body.dark-mode .confirm-message {
            color: #cbd5e1;
        }
        .button-group {
            display: flex;
            gap: 12px;
        }
        .btn {
            flex: 1;
            padding: 12px 0;
            font-weight: 600;
            font-size: 0.9rem;
            border-radius: 40px;
            border: none;
            cursor: pointer;
            transition: all 0.2s;
            font-family: inherit;
        }
        .btn-cancel {
            background: #f1f5f9;
            color: #334155;
        }
        .btn-cancel:hover {
            background: #e2e8f0;
        }
        .btn-danger {
            background: #dc2626;
            color: white;
        }
        .btn-danger:hover {
            background: #b91c1c;
        }
        .btn-info {
            background: #3b82f6;
            color: white;
        }
        .btn-info:hover {
            background: #2563eb;
        }
        @media (max-width: 480px) {
            .confirm-card { padding: 1.5rem; }
            .icon-wrapper { width: 52px; height: 52px; }
            .icon-wrapper i { font-size: 1.6rem; }
            .confirm-title { font-size: 1.3rem; }
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
    </style>
</head>
<body class="antialiased relative">

    <form id="form1" runat="server">
        <asp:HiddenField ID="lastSearchTerm" runat="server" />

        <div class="relative z-10">
            <header class="glass-nav sticky top-0 z-40 shadow-lg">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="flex flex-wrap items-center justify-between py-3 md:py-4 gap-3">
                        <div class="flex items-center gap-3 cursor-pointer group" onclick="navigateTo('Student.aspx')">
                            <div class="bg-white/20 p-2 rounded-xl shadow-xl transition group-hover:scale-105">
                                <i class="fas fa-university text-white text-xl"></i>
                            </div>
                            <div>
                                <h1 class="font-extrabold text-xl md:text-2xl tracking-tight text-white">CampusConnect</h1>
                                <p class="text-xs font-medium hidden sm:block text-white/70">Student Portal</p>
                            </div>
                        </div>
                        <div class="flex-1 max-w-md mx-4">
                            <div class="relative">
                                <i class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-sm text-white/80"></i>
                                <asp:TextBox ID="searchInput" runat="server" CssClass="search-input w-full pl-10 pr-4 py-2 rounded-xl" placeholder="Search announcements..."></asp:TextBox>
                            </div>
                        </div>
                        <div class="flex items-center gap-3 md:gap-4">
                            <div class="relative">
                                <button type="button" id="notificationBtn" class="p-2 hover:bg-white/20 rounded-full transition text-white">
                                    <i class="fas fa-bell text-xl"></i>
                                </button>
                                <span id="notificationBadge" class="absolute -top-1 -right-1 bg-red-400 text-white text-[10px] font-bold rounded-full min-w-[20px] h-5 px-1 flex items-center justify-center shadow-lg">0</span>
                            </div>
                            <asp:HyperLink ID="homeLink" runat="server" NavigateUrl="~/Student.aspx"
                                CssClass="p-2 hover:bg-white/20 rounded-full transition-all text-white">
                                <i class="fas fa-home text-xl"></i>
                            </asp:HyperLink>
                        </div>
                    </div>
                </div>
            </header>

            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6 md:py-8">
                <div class="flex flex-col lg:flex-row gap-6">
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

                    <div class="flex-1">
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
                        <div class="flex justify-between items-center mb-4">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-newspaper text-xl" style="color:var(--primary)"></i>
                                <h3 class="font-bold text-lg" style="color:var(--primary)">Announcements</h3>
                            </div>
                            <span id="resultCount" class="glass-card px-3 py-1 rounded-full text-xs" style="color:var(--primary)">0 items</span>
                        </div>
                        <div id="resultsContainer" class="space-y-5">
                            <div class="text-center py-12" style="color:#3B82F6">
                                <i class="fas fa-spinner fa-spin text-3xl"></i>
                                <p class="mt-2" style="color:#1E3A8A">Loading announcements...</p>
                            </div>
                        </div>
                        <div id="emptyState" class="glass-card rounded-2xl p-12 text-center hidden">
                            <i class="fas fa-inbox text-5xl mb-3" style="color:var(--muted-light)"></i>
                            <p style="color:var(--muted)">No announcements match your criteria</p>
                            <button type="button" id="resetFiltersBtn" class="mt-3 text-sm underline transition" style="color:var(--primary)">Reset all filters</button>
                        </div>
                    </div>
                </div>
            </div>
            <footer class="border-t mt-12 py-5 text-center text-xs backdrop-blur-sm" style="border-color:var(--border);color:var(--muted);background:rgba(255,255,255,0.05)">
                <i class="far fa-copyright"></i> 2026 CampusConnect · Connecting Students to Campus Life
            </footer>
        </div>

        <!-- CONFIRMATION DIALOG - CENTERED CARD STYLE BOX -->
        <div id="confirmModal" class="modal-overlay">
            <div class="confirm-card">
                <div class="icon-wrapper">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <h2 class="confirm-title">Clear search history?</h2>
                <p class="confirm-message">Are you sure you want to clear all search history?</p>
                <div class="button-group">
                    <button id="modalCancelBtn" class="btn btn-cancel">Cancel</button>
                    <button id="modalConfirmBtn" class="btn btn-danger">Clear History</button>
                </div>
            </div>
        </div>

        <!-- INFO DIALOG - for empty search history (same design style) -->
        <div id="infoModal" class="modal-overlay">
            <div class="confirm-card">
                <div class="info-icon-wrapper">
                    <i class="fas fa-info-circle"></i>
                </div>
                <h2 class="confirm-title">Search History Empty</h2>
                <p class="confirm-message">No search history found. Your search history is currently empty.</p>
                <div class="button-group">
                    <button id="infoOkBtn" class="btn btn-info">Got it</button>
                </div>
            </div>
        </div>
    </form>

    <script>
        let announcementsDB = [];
        let pins = {};
        let likes = {};
        let likeCounts = {};
        let searchHistory = JSON.parse(localStorage.getItem('campus_history') || '[]');

        const searchInput = document.getElementById('<%= searchInput.ClientID %>');
        const lastSearchHidden = document.getElementById('<%= lastSearchTerm.ClientID %>');
        const dateFilter = document.getElementById('dateFilter');
        const sortFilter = document.getElementById('sortFilter');
        const resultsContainer = document.getElementById('resultsContainer');
        const resultCount = document.getElementById('resultCount');
        const emptyState = document.getElementById('emptyState');
        const resetFiltersBtn = document.getElementById('resetFiltersBtn');
        const historyListDiv = document.getElementById('historyList');
        const clearHistoryBtn = document.getElementById('clearHistoryBtn');
        const notificationBtn = document.getElementById('notificationBtn');
        const notificationBadge = document.getElementById('notificationBadge');

        // Modal elements
        const confirmModal = document.getElementById('confirmModal');
        const infoModal = document.getElementById('infoModal');
        const modalCancel = document.getElementById('modalCancelBtn');
        const modalConfirm = document.getElementById('modalConfirmBtn');
        const infoOkBtn = document.getElementById('infoOkBtn');

        let currentSearchTerm = '';
        let currentDate = '';
        let currentSort = 'latest';

        function showConfirmModal() { if (confirmModal) confirmModal.classList.add('active'); }
        function closeConfirmModal() { if (confirmModal) confirmModal.classList.remove('active'); }
        function showInfoModal() { if (infoModal) infoModal.classList.add('active'); }
        function closeInfoModal() { if (infoModal) infoModal.classList.remove('active'); }

        function clearHistory() {
            if (searchHistory.length === 0) {
                showInfoModal();
                return;
            }
            searchHistory = [];
            saveHistory();
            showToast('Search history cleared');
            closeConfirmModal();
        }

        function checkAndClearHistory() {
            if (searchHistory.length === 0) {
                showInfoModal();
            } else {
                showConfirmModal();
            }
        }

        function escapeHtml(str) { if (!str) return ''; return str.replace(/[&<>"']/g, m => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[m])); }
        function formatDate(d) { try { return new Date(d).toLocaleDateString('en-US', { month: 'long', day: 'numeric', year: 'numeric' }); } catch (e) { return d; } }
        function getBannerClass(cat) { if (cat === 'Exam Schedule') return 'banner-exam'; if (cat === 'Class Suspension') return 'banner-suspension'; if (cat === 'Campus Events') return 'banner-events'; return 'banner-default'; }
        function getBannerText(cat) { if (cat === 'Exam Schedule') return 'EXAM SCHEDULE'; if (cat === 'Class Suspension') return 'CLASS SUSPENSION'; if (cat === 'Campus Events') return 'CAMPUS EVENT'; return (cat || 'GENERAL').toUpperCase(); }
        function getCatClass(cat) { if (cat === 'Exam Schedule') return 'cat-exam'; if (cat === 'Class Suspension') return 'cat-suspension'; if (cat === 'Campus Events') return 'cat-event'; return 'cat-default'; }
        function getCatIcon(cat) { if (cat === 'Exam Schedule') return '📅'; if (cat === 'Class Suspension') return '⚠️'; if (cat === 'Campus Events') return '🎉'; return '📢'; }
        function showToast(msg) { const t = document.createElement('div'); t.className = 'toast-msg'; t.textContent = msg; document.body.appendChild(t); setTimeout(() => t.remove(), 2700); }
        function updateNotifBadge() { fetch('NotificationHandler.ashx?action=getUnread', { credentials: 'same-origin' }).then(r => r.json()).then(res => { const count = res.ok ? (res.notifications || []).length : 0; notificationBadge.textContent = count; notificationBadge.style.display = count > 0 ? 'flex' : 'none'; }).catch(() => { notificationBadge.style.display = 'none'; }); }

        function saveHistory() { localStorage.setItem('campus_history', JSON.stringify(searchHistory.slice(0, 15))); renderHistory(); }
        function addToHistory(term) { if (!term.trim()) return; term = term.trim(); searchHistory = [term, ...searchHistory.filter(t => t !== term)].slice(0, 15); saveHistory(); }
        function renderHistory() {
            if (!historyListDiv) return;
            if (!searchHistory.length) { historyListDiv.innerHTML = '<div class="text-sm text-center py-4" style="color:var(--muted)">No searches yet</div>'; return; }
            historyListDiv.innerHTML = searchHistory.map(term => `<div class="history-item flex items-center justify-between group" data-term="${escapeHtml(term)}"><span><i class="fas fa-search text-xs mr-2 opacity-50"></i>${escapeHtml(term)}</span><i class="fas fa-chevron-right text-xs opacity-0 group-hover:opacity-100 transition"></i></div>`).join('');
            historyListDiv.querySelectorAll('.history-item').forEach(item => { item.addEventListener('click', () => { searchInput.value = item.dataset.term; performSearch(); }); });
        }
        function renderPinnedSidebar() {
            const pinnedList = document.getElementById('pinnedList');
            const pinnedCountEl = document.getElementById('pinnedCount');
            const pinned = announcementsDB.filter(a => pins[a.id]);
            pinnedCountEl.textContent = pinned.length;
            if (!pinned.length) { pinnedList.innerHTML = '<div class="text-xs text-center py-2" style="color:var(--muted)">No pinned items</div>'; return; }
            pinnedList.innerHTML = pinned.map(a => `<div class="history-item flex items-center gap-2 text-xs" style="color:var(--primary)"><i class="fas fa-thumbtack text-orange-500 flex-shrink-0"></i><span class="truncate">${escapeHtml(a.title)}</span></div>`).join('');
        }

        function getFilteredAnnouncements() {
            let results = [...announcementsDB];
            if (currentSearchTerm.trim()) { const kw = currentSearchTerm.toLowerCase().trim(); results = results.filter(a => a.title.toLowerCase().includes(kw) || a.description.toLowerCase().includes(kw) || a.professor.toLowerCase().includes(kw)); }
            if (currentDate) results = results.filter(a => a.date && a.date.startsWith(currentDate));
            if (currentSort === 'latest') results.sort((a, b) => new Date(b.date) - new Date(a.date));
            else results.sort((a, b) => new Date(a.date) - new Date(b.date));
            results.sort((a, b) => (pins[b.id] ? 1 : 0) - (pins[a.id] ? 1 : 0));
            return results;
        }

        function renderCommentsList(list) { if (!list || !list.length) return '<div class="no-comments">No comments yet. Be the first!</div>'; return list.map(c => `<div class="comment-item"><div class="comment-avatar"><i class="fas fa-user"></i></div><div><div class="comment-author">${escapeHtml(c.author)}</div><div class="comment-text">${escapeHtml(c.text)}</div><div class="comment-time">${escapeHtml(c.date || '')}</div></div></div>`).join(''); }

        function renderResults() {
            const filtered = getFilteredAnnouncements();
            resultCount.textContent = `${filtered.length} item${filtered.length !== 1 ? 's' : ''}`;
            if (!filtered.length) { resultsContainer.innerHTML = ''; emptyState.classList.remove('hidden'); return; }
            emptyState.classList.add('hidden');
            resultsContainer.innerHTML = filtered.map(ann => {
                const liked = !!likes[ann.id];
                const pinned = !!pins[ann.id];
                const lc = likeCounts[ann.id] || 0;
                const cc = ann.commentCount || 0;
                return `<div class="announce-card" data-id="${ann.id}"><div style="padding:18px 20px 12px"><div style="display:flex;align-items:flex-start;justify-content:space-between;gap:12px;margin-bottom:12px"><div style="display:flex;align-items:center;gap:12px;flex:1"><div style="width:44px;height:44px;background:var(--active-bg);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:18px;flex-shrink:0"><i class="fas fa-user-tie" style="color:var(--primary)"></i></div><div><div class="card-author-name">${escapeHtml(ann.professor)}</div><div class="card-meta"><i class="far fa-calendar-alt mr-1"></i>${formatDate(ann.date)}</div></div></div><div style="display:flex;align-items:center;gap:8px"><div class="card-banner ${getBannerClass(ann.category)} px-3 py-1 hidden sm:block"><p class="text-white text-xs font-bold tracking-wide">${getBannerText(ann.category)}</p></div><button type="button" onclick="togglePin(${ann.id})" title="${pinned ? 'Unpin' : 'Pin this announcement'}" style="flex:none;width:34px;height:34px;padding:0;border-radius:50%;background:none;border:none;cursor:pointer;display:flex;align-items:center;justify-content:center;font-size:16px;transition:all 0.2s;color:${pinned ? '#e65100' : 'var(--muted-light)'}"><i class="${pinned ? 'fas' : 'far'} fa-thumbtack"></i></button></div></div><div class="card-title">${escapeHtml(ann.title)}</div><div class="card-desc">${escapeHtml(ann.description)}</div>${ann.imageUrl ? `<div style="margin-top:10px;border-radius:12px;overflow:hidden"><img src="${escapeHtml(ann.imageUrl)}" alt="" style="width:100%;max-height:260px;object-fit:cover" onerror="this.style.display='none'"/></div>` : ''}<div style="margin-top:10px"><span class="cat-badge ${getCatClass(ann.category)}">${getCatIcon(ann.category)} ${ann.category}</span></div></div><div class="post-stats"><span onclick="toggleLike(${ann.id})"><i class="${liked ? 'fas' : 'far'} fa-heart" style="${liked ? 'color:#dc2626' : ''}"></i><span id="lc-${ann.id}">${lc}</span> Likes</span><span onclick="openComments(${ann.id})"><i class="far fa-comment"></i><span id="cc-${ann.id}">${cc}</span> Comments</span><span onclick="sharePost(${ann.id}, '${escapeHtml(ann.title)}')"><i class="far fa-share-square"></i> Share</span></div><div class="action-buttons"><button type="button" class="action-btn ${liked ? 'liked' : ''}" onclick="toggleLike(${ann.id})"><i class="${liked ? 'fas' : 'far'} fa-heart"></i> ${liked ? 'Liked' : 'Like'}</button><button type="button" class="action-btn" onclick="openComments(${ann.id})"><i class="far fa-comment"></i> Comment</button><button type="button" class="action-btn" onclick="sharePost(${ann.id}, '${escapeHtml(ann.title)}')"><i class="fas fa-share-alt"></i> Share</button></div><div class="comments-section" id="cs-${ann.id}"><div class="comment-input-row"><input type="text" id="ci-${ann.id}" placeholder="Write a comment..." /><button type="button" onclick="postComment(${ann.id})">Post</button></div><div id="cl-${ann.id}"><div class="no-comments">No comments yet. Be the first!</div></div></div></div>`;
            }).join('');
            renderPinnedSidebar();
        }

        function toggleLike(id) { fetch('LikeHandler.ashx?action=toggle&postId=' + id, { credentials: 'same-origin' }).then(r => r.json()).then(res => { if (!res.ok) { showToast('Error: ' + res.error); return; } likes[id] = res.liked; likeCounts[id] = res.likeCount; const lcEl = document.getElementById('lc-' + id); if (lcEl) lcEl.textContent = res.likeCount; showToast(res.liked ? 'Liked!' : 'Like removed'); }).catch(() => showToast('Could not update like')); }
        function togglePin(id) { fetch('UserPinHandler.ashx?action=toggle&announcementId=' + id, { credentials: 'same-origin' }).then(r => r.json()).then(res => { if (!res.ok) { showToast('Error: ' + res.error); return; } if (res.isPinned) pins[id] = true; else delete pins[id]; renderResults(); showToast(res.isPinned ? 'Pinned!' : 'Unpinned'); }).catch(() => showToast('Could not update pin')); }
        function openComments(id) { const sec = document.getElementById('cs-' + id); if (!sec) return; sec.classList.toggle('show'); if (sec.classList.contains('show')) { fetch('CommentHandler.ashx?action=get&postId=' + id, { credentials: 'same-origin' }).then(r => r.json()).then(list => { const cl = document.getElementById('cl-' + id); if (cl) cl.innerHTML = renderCommentsList(list); const cc = document.getElementById('cc-' + id); if (cc) cc.textContent = list.length; }).catch(() => { }); setTimeout(() => { const inp = document.getElementById('ci-' + id); if (inp) inp.focus(); }, 50); } }
        function postComment(id) { const input = document.getElementById('ci-' + id); if (!input) return; const text = input.value.trim(); if (!text) { showToast('Please write a comment first'); return; } fetch('CommentHandler.ashx?action=add', { method: 'POST', credentials: 'same-origin', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ postId: id, comment: text }) }).then(r => r.json()).then(res => { if (!res.success) { showToast('Error: ' + (res.error || 'Could not post')); return; } input.value = ''; fetch('CommentHandler.ashx?action=get&postId=' + id, { credentials: 'same-origin' }).then(r => r.json()).then(list => { const cl = document.getElementById('cl-' + id); if (cl) cl.innerHTML = renderCommentsList(list); const cc = document.getElementById('cc-' + id); if (cc) cc.textContent = list.length; }); showToast('Comment posted!'); }).catch(() => showToast('Could not post comment')); }
        function sharePost(id, title) { const url = window.location.href.split('?')[0] + '?post=' + id; if (navigator.clipboard) { navigator.clipboard.writeText(url).then(() => showToast('Link copied: ' + title)); } else { showToast('Shared: ' + title); } }
        function performSearch() { const term = searchInput.value; currentSearchTerm = term; if (lastSearchHidden) lastSearchHidden.value = term; if (term.trim()) addToHistory(term); renderResults(); }
        function applyFilters() { currentDate = dateFilter.value || ''; currentSort = sortFilter.value; renderResults(); }
        function resetEverything() { searchInput.value = ''; dateFilter.value = ''; sortFilter.value = 'latest'; currentSearchTerm = ''; currentDate = ''; currentSort = 'latest'; if (lastSearchHidden) lastSearchHidden.value = ''; renderResults(); }
        function navigateTo(url) { window.location.href = url; }

        function init() {
            renderHistory();
            updateNotifBadge();
            flatpickr(dateFilter, { dateFormat: 'Y-m-d', altInput: true, altFormat: 'F j, Y', onChange: (_, dateStr) => { currentDate = dateStr || ''; renderResults(); } });
            searchInput.addEventListener('keypress', e => { if (e.key === 'Enter') performSearch(); });
            sortFilter.addEventListener('change', applyFilters);
            if (resetFiltersBtn) resetFiltersBtn.addEventListener('click', resetEverything);
            if (clearHistoryBtn) clearHistoryBtn.addEventListener('click', checkAndClearHistory);
            if (notificationBtn) notificationBtn.addEventListener('click', () => navigateTo('Notifications.aspx'));
            if (modalCancel) modalCancel.addEventListener('click', closeConfirmModal);
            if (modalConfirm) modalConfirm.addEventListener('click', clearHistory);
            if (infoOkBtn) infoOkBtn.addEventListener('click', closeInfoModal);
            if (confirmModal) confirmModal.addEventListener('click', (e) => { if (e.target === confirmModal) closeConfirmModal(); });
            if (infoModal) infoModal.addEventListener('click', (e) => { if (e.target === infoModal) closeInfoModal(); });
            document.addEventListener('keydown', (e) => {
                if (e.key === 'Escape') {
                    if (confirmModal && confirmModal.classList.contains('active')) closeConfirmModal();
                    if (infoModal && infoModal.classList.contains('active')) closeInfoModal();
                }
            });

            resultsContainer.innerHTML = '<div class="text-center py-12" style="color:#3B82F6"><i class="fas fa-spinner fa-spin text-3xl"></i><p class="mt-2" style="color:#1E3A8A">Loading announcements...</p></div>';
            Promise.all([fetch('AnnouncementHandler.ashx?action=getAll', { credentials: 'same-origin' }).then(r => r.json()), fetch('UserPinHandler.ashx?action=getUserPins', { credentials: 'same-origin' }).then(r => r.json())]).then(([annRes, pinRes]) => { if (!annRes.ok) { resultsContainer.innerHTML = '<div class="text-center py-12" style="color:var(--muted)">Failed to load announcements.</div>'; return; } announcementsDB = annRes.data.map(a => ({ id: a.id, title: a.title || '', category: a.category === 'Exam' ? 'Exam Schedule' : a.category === 'Suspension' ? 'Class Suspension' : a.category === 'Event' ? 'Campus Events' : (a.category || 'General'), date: a.date || '', professor: a.author || 'Admin', description: a.content || '', imageUrl: a.imageUrl || '', likeCount: a.likeCount || 0, commentCount: a.commentCount || 0 })); announcementsDB.forEach(a => { likeCounts[a.id] = a.likeCount; }); pins = {}; if (pinRes.ok && pinRes.pinnedIds) pinRes.pinnedIds.forEach(id => { pins[id] = true; }); try { if (lastSearchHidden && lastSearchHidden.value) { searchInput.value = lastSearchHidden.value; currentSearchTerm = lastSearchHidden.value; } } catch (e) { } renderResults(); }).catch(() => { resultsContainer.innerHTML = '<div class="text-center py-12" style="color:var(--muted)">Could not connect to server.</div>'; });
        }
        init();

        // Theme - no flip transition
        (function () {
            const KEY = 'campus_theme';
            function applyTheme(mode) { document.body.classList.toggle('dark-mode', mode === 'dark'); }
            applyTheme(localStorage.getItem(KEY) || 'light');
            window.addEventListener('storage', e => {
                if (e.key === KEY) applyTheme(e.newValue || 'light');
                if (e.key === 'campus_notifications') updateNotifBadge();
            });
        })();
    </script>
</body>
</html>