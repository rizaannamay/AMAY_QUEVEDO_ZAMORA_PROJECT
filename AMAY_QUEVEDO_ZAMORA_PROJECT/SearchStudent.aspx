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

        :root {
            --page-text: #e4e6eb;
            --surface: rgba(15, 25, 55, 0.85);
            --surface-strong: rgba(15, 25, 55, 0.92);
            --surface-soft: rgba(255, 255, 255, 0.07);
            --border: rgba(255, 255, 255, 0.1);
            --primary: #818cf8;
            --primary-2: #6366f1;
            --muted: #94a3b8;
            --muted-light: #64748b;
            --shadow: 0 8px 32px rgba(0, 0, 0, 0.5);
            --active-bg: rgba(99, 102, 241, 0.18);
        }

        body {
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
            color: var(--page-text);
            background-color: #0F172A;
            background-image: url('bg.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            background-attachment: fixed;
        }

        /* Dark overlay to match Notifications page look */
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background: linear-gradient(135deg, rgba(10, 15, 40, 0.92) 0%, rgba(15, 23, 60, 0.92) 100%);
            z-index: 0;
            pointer-events: none;
        }

        .relative.z-10 { position: relative; z-index: 1; }

        /* -- NAVBAR -- */
        .glass-nav {
            background: linear-gradient(135deg, #0f172a 0%, #1e3a8a 100%);
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
        }

        .glass-nav h1,
        .glass-nav p,
        .glass-nav a,
        .glass-nav button { color: #ffffff !important; }
        .glass-nav .text-muted { color: rgba(255, 255, 255, 0.7) !important; }

        .glass-sidebar {
            background: rgba(15, 25, 55, 0.75);
            backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
        }

        .glass-card {
            background: rgba(15, 25, 55, 0.75);
            backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: all 0.3s ease;
        }

        .glass-card:hover {
            border-color: rgba(99, 102, 241, 0.4);
            transform: translateY(-2px);
        }

        .announce-card {
            background: rgba(15, 25, 55, 0.88);
            border: 1px solid #3B82F6;
            border-radius: 20px;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.35);
            overflow: hidden;
            will-change: transform;
        }

        .announce-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 32px rgba(0, 0, 0, 0.5);
            border-color: #93C5FD;
        }

        .card-author-name { color: #93c5fd; font-weight: 700; font-size: 15px; }
        .card-meta        { color: var(--muted); font-size: 12px; }
        .card-title       { color: #e0e7ff; font-size: 18px; font-weight: 700; margin-bottom: 8px; }
        .card-desc        { color: #e2e8f0; font-size: 13px; line-height: 1.6; }

        .card-banner {
            background: linear-gradient(135deg, #1e3a8a, #4f46e5);
            border-radius: 12px;
            min-width: 90px;
            text-align: center;
            transition: transform 0.2s;
            flex-shrink: 0;
        }
        .card-banner:hover { transform: scale(1.03); }
        .banner-exam       { background: linear-gradient(135deg, #0f2b5c, #1e4a8a, #3b82f6); }
        .banner-suspension { background: linear-gradient(135deg, #7c2d12, #b45309, #f59e0b); }
        .banner-events     { background: linear-gradient(135deg, #064e3b, #0d9488, #14b8a6); }
        .banner-default    { background: linear-gradient(135deg, #1e1b4b, #4f46e5, #818cf8); }

        .post-stats {
            display: flex;
            gap: 16px;
            padding: 8px 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            color: var(--muted);
            font-size: 13px;
        }
        .post-stats span { display: flex; align-items: center; gap: 5px; cursor: pointer; transition: color 0.2s; }
        .post-stats span:hover { color: #93c5fd; }

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
        .action-btn:hover { background: rgba(255, 255, 255, 0.06); color: #93C5FD; }
        .action-btn.liked { color: #f87171; }

        .comments-section {
            padding: 0 20px 16px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
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
            background: rgba(255, 255, 255, 0.07);
            border: 1px solid rgba(255, 255, 255, 0.12);
            border-radius: 30px;
            outline: none;
            font-size: 13px;
            color: #f1f5f9;
            font-family: inherit;
        }
        .comment-input-row input:focus { border-color: #6366f1; }
        .comment-input-row input::placeholder { color: var(--muted-light); }
        .comment-input-row button {
            background: linear-gradient(135deg, #3B82F6, #6366f1);
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
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
            font-size: 13px;
        }
        .comment-item:last-child { border-bottom: none; }
        .comment-avatar {
            width: 30px; height: 30px;
            background: rgba(99, 102, 241, 0.2);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            color: #93c5fd;
            font-size: 12px;
            flex-shrink: 0;
        }
        .comment-author { font-weight: 700; color: #c7d2fe; }
        .comment-text   { color: #e2e8f0; margin-top: 2px; }
        .comment-time   { font-size: 10px; color: var(--muted-light); margin-top: 2px; }
        .no-comments    { padding: 12px 0; text-align: center; color: var(--muted-light); font-size: 12px; }

        .cat-badge {
            display: inline-block;
            padding: 2px 10px;
            border-radius: 20px;
            font-size: 10px;
            font-weight: 700;
        }
        .cat-exam       { background: rgba(30, 58, 138, 0.3);  color: #93C5FD; }
        .cat-suspension { background: rgba(198, 40, 40, 0.2);  color: #ef9a9a; }
        .cat-event      { background: rgba(22, 101, 52, 0.25); color: #86efac; }
        .cat-default    { background: rgba(91, 33, 182, 0.2);  color: #c4b5fd; }

        .history-item {
            cursor: pointer;
            transition: all 0.2s ease;
            padding: 8px 12px;
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.08);
            color: #cbd5e1;
            font-size: 13px;
        }
        .history-item:hover {
            background: rgba(99, 102, 241, 0.18);
            transform: translateX(4px);
            border-color: rgba(99, 102, 241, 0.4);
            color: #93c5fd;
        }

        .search-input {
            background: rgba(255, 255, 255, 0.12);
            backdrop-filter: blur(4px);
            border: 1.5px solid rgba(255, 255, 255, 0.4);
            transition: all 0.2s;
            color: #ffffff;
        }
        .search-input:focus {
            background: rgba(255, 255, 255, 0.18);
            border-color: rgba(255, 255, 255, 0.8);
            box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.1);
            outline: none;
        }
        .search-input::placeholder { color: rgba(255, 255, 255, 0.6); }

        .filter-select {
            background: rgba(15, 25, 55, 0.75);
            border: 1px solid rgba(255, 255, 255, 0.12);
            color: #e2e8f0;
        }
        .filter-select:focus { border-color: #6366f1; outline: none; }

        /* Flatpickr dark override */
        .flatpickr-calendar {
            background: #1e293b !important;
            border-color: rgba(255,255,255,0.1) !important;
            box-shadow: 0 8px 32px rgba(0,0,0,0.5) !important;
        }
        .flatpickr-day { color: #e2e8f0 !important; }
        .flatpickr-day:hover { background: rgba(99,102,241,0.3) !important; }
        .flatpickr-day.selected { background: #6366f1 !important; border-color: #6366f1 !important; }
        .flatpickr-months .flatpickr-month,
        .flatpickr-weekdays,
        span.flatpickr-weekday { background: #1e293b !important; color: #93c5fd !important; fill: #93c5fd !important; }
        .flatpickr-current-month input.cur-year,
        .flatpickr-current-month .flatpickr-monthDropdown-months { color: #e2e8f0 !important; }
        .flatpickr-prev-month svg, .flatpickr-next-month svg { fill: #93c5fd !important; }

        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: rgba(255, 255, 255, 0.05); border-radius: 10px; }
        ::-webkit-scrollbar-thumb { background: rgba(99, 102, 241, 0.5); border-radius: 10px; }

        #resultsContainer { display: flex; flex-direction: column; gap: 16px; }

        /* Section titles */
        .section-title { color: #93c5fd !important; }
        .result-count  { color: #93c5fd !important; background: rgba(15,25,55,0.75) !important; border-color: rgba(255,255,255,0.1) !important; }

        .toast-msg {
            position: fixed;
            bottom: 28px;
            left: 50%;
            transform: translateX(-50%);
            background: #6366f1;
            color: white;
            padding: 10px 24px;
            border-radius: 30px;
            font-size: 13px;
            z-index: 9999;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.4);
            animation: toastFade 2.6s ease forwards;
            pointer-events: none;
        }
        @keyframes toastFade {
            0%   { opacity: 0; transform: translateX(-50%) translateY(10px); }
            12%  { opacity: 1; transform: translateX(-50%) translateY(0); }
            80%  { opacity: 1; }
            100% { opacity: 0; }
        }

        /* Modal */
        .modal-overlay {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(6px);
            z-index: 10000;
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.2s ease, visibility 0.2s ease;
        }
        .modal-overlay.active { opacity: 1; visibility: visible; }
        .confirm-card {
            max-width: 420px;
            width: 90%;
            background: #1e293b;
            border: 1px solid rgba(255, 255, 255, 0.12);
            border-radius: 28px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.5);
            padding: 2rem 1.75rem;
            text-align: center;
            transform: scale(0.95);
            transition: transform 0.2s ease;
        }
        .modal-overlay.active .confirm-card { transform: scale(1); }
        .icon-wrapper {
            background: rgba(220, 38, 38, 0.2);
            width: 64px; height: 64px;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 1.25rem;
        }
        .icon-wrapper i { font-size: 2rem; color: #f87171; }
        .info-icon-wrapper {
            background: rgba(59, 130, 246, 0.2);
            width: 64px; height: 64px;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 1.25rem;
        }
        .info-icon-wrapper i { font-size: 2rem; color: #60a5fa; }
        .confirm-title   { font-size: 1.5rem; font-weight: 700; color: #f1f5f9; margin-bottom: 0.5rem; }
        .confirm-message { font-size: 1rem; color: #cbd5e1; margin-bottom: 1.75rem; line-height: 1.5; }
        .button-group { display: flex; gap: 12px; }
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
        .btn-cancel  { background: rgba(255,255,255,0.08); color: #cbd5e1; }
        .btn-cancel:hover  { background: rgba(255,255,255,0.14); }
        .btn-danger  { background: #dc2626; color: white; }
        .btn-danger:hover  { background: #b91c1c; }
        .btn-info    { background: #3b82f6; color: white; }
        .btn-info:hover    { background: #2563eb; }

        /* Footer */
        footer {
            border-color: rgba(255,255,255,0.08) !important;
            color: var(--muted) !important;
            background: rgba(10,15,40,0.5) !important;
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
                                    <i class="fas fa-history text-lg" style="color:#93c5fd"></i>
                                    <h3 class="font-bold text-base" style="color:#93c5fd">Search History</h3>
                                </div>
                                <button type="button" id="clearHistoryBtn" class="text-xs transition px-2 py-1 rounded-lg hover:bg-white/10" style="color:#f87171">
                                    <i class="fas fa-trash-alt mr-1"></i>Clear
                                </button>
                            </div>
                            <div id="historyList" class="space-y-2 max-h-[400px] overflow-y-auto">
                                <div class="text-sm text-center py-4" style="color:var(--muted)">No searches yet</div>
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
                                <i class="fas fa-newspaper text-xl" style="color:#93c5fd"></i>
                                <h3 class="font-bold text-lg section-title">Announcements</h3>
                            </div>
                            <span id="resultCount" class="result-count glass-card px-3 py-1 rounded-full text-xs">0 items</span>
                        </div>
                        <div id="resultsContainer" class="space-y-5">
                            <div class="text-center py-12">
                                <i class="fas fa-spinner fa-spin text-3xl" style="color:#3B82F6"></i>
                                <p class="mt-2" style="color:#93c5fd">Loading announcements...</p>
                            </div>
                        </div>
                        <div id="emptyState" class="glass-card rounded-2xl p-12 text-center hidden">
                            <i class="fas fa-inbox text-5xl mb-3" style="color:var(--muted-light)"></i>
                            <p style="color:var(--muted)">No announcements match your criteria</p>
                            <button type="button" id="resetFiltersBtn" class="mt-3 text-sm underline transition" style="color:#93c5fd">Reset all filters</button>
                        </div>
                    </div>
                </div>
            </div>

            <footer class="border-t mt-12 py-5 text-center text-xs backdrop-blur-sm">
                <i class="far fa-copyright"></i> 2026 CampusConnect · Connecting Students to Campus Life
            </footer>
        </div>

        <!-- CONFIRMATION DIALOG -->
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

        <!-- INFO DIALOG -->
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
            if (searchHistory.length === 0) { showInfoModal(); return; }
            searchHistory = [];
            saveHistory();
            showToast('Search history cleared');
            closeConfirmModal();
        }

        function checkAndClearHistory() {
            if (searchHistory.length === 0) { showInfoModal(); } else { showConfirmModal(); }
        }

        function escapeHtml(str) { if (!str) return ''; return str.replace(/[&<>"']/g, m => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[m])); }
        function formatDate(d) { try { return new Date(d).toLocaleDateString('en-US', { month: 'long', day: 'numeric', year: 'numeric' }); } catch (e) { return d; } }
        function getBannerClass(cat) { if (cat === 'Exam Schedule') return 'banner-exam'; if (cat === 'Class Suspension') return 'banner-suspension'; if (cat === 'Campus Events') return 'banner-events'; return 'banner-default'; }
        function getBannerText(cat) { if (cat === 'Exam Schedule') return 'EXAM SCHEDULE'; if (cat === 'Class Suspension') return 'CLASS SUSPENSION'; if (cat === 'Campus Events') return 'CAMPUS EVENT'; return (cat || 'GENERAL').toUpperCase(); }
        function getCatClass(cat) { if (cat === 'Exam Schedule') return 'cat-exam'; if (cat === 'Class Suspension') return 'cat-suspension'; if (cat === 'Campus Events') return 'cat-event'; return 'cat-default'; }
        function getCatIcon(cat) { if (cat === 'Exam Schedule') return '📅'; if (cat === 'Class Suspension') return '⚠️'; if (cat === 'Campus Events') return '🎉'; return '📢'; }
        function showToast(msg) { const t = document.createElement('div'); t.className = 'toast-msg'; t.textContent = msg; document.body.appendChild(t); setTimeout(() => t.remove(), 2700); }
        function updateNotifBadge() { }

        function saveHistory() { localStorage.setItem('campus_history', JSON.stringify(searchHistory.slice(0, 15))); renderHistory(); }
        function addToHistory(term) { if (!term.trim()) return; term = term.trim(); searchHistory = [term, ...searchHistory.filter(t => t !== term)].slice(0, 15); saveHistory(); }

        function renderHistory() {
            if (!historyListDiv) return;
            if (!searchHistory.length) { historyListDiv.innerHTML = '<div class="text-sm text-center py-4" style="color:var(--muted)">No searches yet</div>'; return; }
            historyListDiv.innerHTML = searchHistory.map(term =>
                `<div class="history-item flex items-center justify-between group" data-term="${escapeHtml(term)}">
                    <span><i class="fas fa-search text-xs mr-2 opacity-50"></i>${escapeHtml(term)}</span>
                    <i class="fas fa-chevron-right text-xs opacity-0 group-hover:opacity-100 transition"></i>
                </div>`
            ).join('');
            historyListDiv.querySelectorAll('.history-item').forEach(item => {
                item.addEventListener('click', () => { searchInput.value = item.dataset.term; performSearch(); });
            });
        }

        function renderPinnedSidebar() {
            const pinnedList = document.getElementById('pinnedList');
            const pinnedCountEl = document.getElementById('pinnedCount');
            if (!pinnedList || !pinnedCountEl) return;
            const pinned = announcementsDB.filter(a => pins[a.id]);
            pinnedCountEl.textContent = pinned.length;
            if (!pinned.length) { pinnedList.innerHTML = '<div class="text-xs text-center py-2" style="color:var(--muted)">No pinned items</div>'; return; }
            pinnedList.innerHTML = pinned.map(a => `<div class="history-item flex items-center gap-2 text-xs"><i class="fas fa-thumbtack text-orange-400 flex-shrink-0"></i><span class="truncate" style="color:#93c5fd">${escapeHtml(a.title)}</span></div>`).join('');
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

        function renderCommentsList(list) {
            if (!list || !list.length) return '<div class="no-comments">No comments yet. Be the first!</div>';
            return list.map(c =>
                `<div class="comment-item">
                    <div class="comment-avatar"><i class="fas fa-user"></i></div>
                    <div>
                        <div class="comment-author">${escapeHtml(c.author)}</div>
                        <div class="comment-text">${escapeHtml(c.text)}</div>
                        <div class="comment-time">${escapeHtml(c.date || '')}</div>
                    </div>
                </div>`
            ).join('');
        }

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
                return `<div class="announce-card" data-id="${ann.id}">
                    <div style="padding:18px 20px 12px">
                        <div style="display:flex;align-items:flex-start;justify-content:space-between;gap:12px;margin-bottom:12px">
                            <div style="display:flex;align-items:center;gap:12px;flex:1">
                                <div style="width:44px;height:44px;background:rgba(99,102,241,0.2);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:18px;flex-shrink:0">
                                    <i class="fas fa-user-tie" style="color:#93c5fd"></i>
                                </div>
                                <div>
                                    <div class="card-author-name">${escapeHtml(ann.professor)}</div>
                                    <div class="card-meta"><i class="far fa-calendar-alt mr-1"></i>${formatDate(ann.date)}</div>
                                </div>
                            </div>
                            <div style="display:flex;align-items:center;gap:8px">
                                <div class="card-banner ${getBannerClass(ann.category)} px-3 py-1 hidden sm:block">
                                    <p class="text-white text-xs font-bold tracking-wide">${getBannerText(ann.category)}</p>
                                </div>
                                <button type="button" onclick="togglePin(${ann.id})" title="${pinned ? 'Unpin' : 'Pin this announcement'}"
                                    style="flex:none;width:34px;height:34px;padding:0;border-radius:50%;background:none;border:none;cursor:pointer;display:flex;align-items:center;justify-content:center;font-size:16px;transition:all 0.2s;color:${pinned ? '#fb923c' : 'rgba(148,163,184,0.5)'}">
                                    <i class="${pinned ? 'fas' : 'far'} fa-thumbtack"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-title">${escapeHtml(ann.title)}</div>
                        <div class="card-desc">${escapeHtml(ann.description)}</div>
                        ${ann.imageUrl ? `<div style="margin-top:10px;border-radius:12px;overflow:hidden"><img src="${escapeHtml(ann.imageUrl)}" alt="" style="width:100%;max-height:260px;object-fit:cover" onerror="this.style.display='none'"/></div>` : ''}
                        <div style="margin-top:10px"><span class="cat-badge ${getCatClass(ann.category)}">${getCatIcon(ann.category)} ${ann.category}</span></div>
                    </div>
                    <div class="post-stats">
                        <span onclick="toggleLike(${ann.id})">
                            <i class="${liked ? 'fas' : 'far'} fa-heart" style="${liked ? 'color:#f87171' : ''}"></i>
                            <span id="lc-${ann.id}">${lc}</span> Likes
                        </span>
                        <span onclick="openComments(${ann.id})">
                            <i class="far fa-comment"></i>
                            <span id="cc-${ann.id}">${cc}</span> Comments
                        </span>
                        <span onclick="sharePost(${ann.id},'${escapeHtml(ann.title)}')">
                            <i class="far fa-share-square"></i> Share
                        </span>
                    </div>
                    <div class="action-buttons">
                        <button type="button" class="action-btn ${liked ? 'liked' : ''}" onclick="toggleLike(${ann.id})">
                            <i class="${liked ? 'fas' : 'far'} fa-heart"></i> ${liked ? 'Liked' : 'Like'}
                        </button>
                        <button type="button" class="action-btn" onclick="openComments(${ann.id})">
                            <i class="far fa-comment"></i> Comment
                        </button>
                        <button type="button" class="action-btn" onclick="sharePost(${ann.id},'${escapeHtml(ann.title)}')">
                            <i class="fas fa-share-alt"></i> Share
                        </button>
                    </div>
                    <div class="comments-section" id="cs-${ann.id}">
                        <div class="comment-input-row">
                            <input type="text" id="ci-${ann.id}" placeholder="Write a comment..." />
                            <button type="button" onclick="postComment(${ann.id})">Post</button>
                        </div>
                        <div id="cl-${ann.id}"><div class="no-comments">No comments yet. Be the first!</div></div>
                    </div>
                </div>`;
            }).join('');
            renderPinnedSidebar();
        }

        function toggleLike(id) {
            fetch('LikeHandler.ashx?action=toggle&postId=' + id, { credentials: 'same-origin' })
                .then(r => r.json())
                .then(res => {
                    if (!res.ok) { showToast('Error: ' + res.error); return; }
                    likes[id] = res.liked;
                    likeCounts[id] = res.likeCount;
                    const lcEl = document.getElementById('lc-' + id);
                    if (lcEl) lcEl.textContent = res.likeCount;
                    // Update like button & stat icon
                    const card = document.querySelector(`.announce-card[data-id="${id}"]`);
                    if (card) {
                        const likeBtn = card.querySelector('.action-btn');
                        if (likeBtn) {
                            likeBtn.className = 'action-btn' + (res.liked ? ' liked' : '');
                            likeBtn.innerHTML = `<i class="${res.liked ? 'fas' : 'far'} fa-heart"></i> ${res.liked ? 'Liked' : 'Like'}`;
                        }
                        const likeStatI = card.querySelector('.post-stats span:first-child i');
                        if (likeStatI) { likeStatI.className = (res.liked ? 'fas' : 'far') + ' fa-heart'; likeStatI.style.color = res.liked ? '#f87171' : ''; }
                    }
                    showToast(res.liked ? '❤️ Liked!' : 'Like removed');
                })
                .catch(() => showToast('Could not update like'));
        }

        function togglePin(id) {
            fetch('UserPinHandler.ashx?action=toggle&announcementId=' + id, { credentials: 'same-origin' })
                .then(r => r.json())
                .then(res => {
                    if (!res.ok) { showToast('Error: ' + res.error); return; }
                    if (res.isPinned) pins[id] = true; else delete pins[id];
                    renderResults();
                    showToast(res.isPinned ? '📌 Pinned!' : 'Unpinned');
                })
                .catch(() => showToast('Could not update pin'));
        }

        function openComments(id) {
            const sec = document.getElementById('cs-' + id);
            if (!sec) return;
            sec.classList.toggle('show');
            if (sec.classList.contains('show')) {
                fetch('CommentHandler.ashx?action=get&postId=' + id, { credentials: 'same-origin' })
                    .then(r => r.json())
                    .then(list => {
                        const cl = document.getElementById('cl-' + id);
                        if (cl) cl.innerHTML = renderCommentsList(list);
                        const cc = document.getElementById('cc-' + id);
                        if (cc) cc.textContent = list.length;
                    })
                    .catch(() => { });
                setTimeout(() => { const inp = document.getElementById('ci-' + id); if (inp) inp.focus(); }, 50);
            }
        }

        function postComment(id) {
            const input = document.getElementById('ci-' + id);
            if (!input) return;
            const text = input.value.trim();
            if (!text) { showToast('Please write a comment first'); return; }
            const btn = input.nextElementSibling;
            if (btn) { btn.disabled = true; btn.textContent = '...'; }
            fetch('CommentHandler.ashx?action=add', {
                method: 'POST', credentials: 'same-origin',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ postId: id, comment: text })
            })
                .then(r => r.json())
                .then(res => {
                    if (btn) { btn.disabled = false; btn.textContent = 'Post'; }
                    if (!res.success) { showToast('Error: ' + (res.error || 'Could not post')); return; }
                    input.value = '';
                    fetch('CommentHandler.ashx?action=get&postId=' + id, { credentials: 'same-origin' })
                        .then(r => r.json())
                        .then(list => {
                            const cl = document.getElementById('cl-' + id);
                            if (cl) cl.innerHTML = renderCommentsList(list);
                            const cc = document.getElementById('cc-' + id);
                            if (cc) cc.textContent = list.length;
                        });
                    showToast('💬 Comment posted!');
                })
                .catch(() => { if (btn) { btn.disabled = false; btn.textContent = 'Post'; } showToast('Could not post comment'); });
        }

        function sharePost(id, title) {
            const url = window.location.href.split('?')[0];
            if (navigator.clipboard) {
                navigator.clipboard.writeText(url)
                    .then(() => showToast('🔗 Link copied!'))
                    .catch(() => showToast('📤 Shared!'));
            } else {
                const dummy = document.createElement('input');
                dummy.value = url;
                document.body.appendChild(dummy);
                dummy.select();
                document.execCommand('copy');
                document.body.removeChild(dummy);
                showToast('🔗 Link copied!');
            }
            fetch('NotificationHandler.ashx?action=notifyShare&postId=' + id, { credentials: 'same-origin' }).catch(() => { });
        }

        function performSearch() {
            const term = searchInput.value;
            currentSearchTerm = term;
            if (lastSearchHidden) lastSearchHidden.value = term;
            if (term.trim()) addToHistory(term);
            renderResults();
        }

        function applyFilters() { currentDate = dateFilter.value || ''; currentSort = sortFilter.value; renderResults(); }

        function resetEverything() {
            searchInput.value = ''; dateFilter.value = ''; sortFilter.value = 'latest';
            currentSearchTerm = ''; currentDate = ''; currentSort = 'latest';
            if (lastSearchHidden) lastSearchHidden.value = '';
            renderResults();
        }

        function navigateTo(url) { window.location.href = url; }

        function init() {
            renderHistory();
            updateNotifBadge();
            flatpickr(dateFilter, {
                dateFormat: 'Y-m-d', altInput: true, altFormat: 'F j, Y',
                onChange: (_, dateStr) => { currentDate = dateStr || ''; renderResults(); }
            });
            searchInput.addEventListener('keypress', e => { if (e.key === 'Enter') performSearch(); });
            sortFilter.addEventListener('change', applyFilters);
            if (resetFiltersBtn) resetFiltersBtn.addEventListener('click', resetEverything);
            if (clearHistoryBtn) clearHistoryBtn.addEventListener('click', checkAndClearHistory);
            if (modalCancel) modalCancel.addEventListener('click', closeConfirmModal);
            if (modalConfirm) modalConfirm.addEventListener('click', clearHistory);
            if (infoOkBtn) infoOkBtn.addEventListener('click', closeInfoModal);
            if (confirmModal) confirmModal.addEventListener('click', e => { if (e.target === confirmModal) closeConfirmModal(); });
            if (infoModal) infoModal.addEventListener('click', e => { if (e.target === infoModal) closeInfoModal(); });
            document.addEventListener('keydown', e => {
                if (e.key === 'Escape') {
                    if (confirmModal && confirmModal.classList.contains('active')) closeConfirmModal();
                    if (infoModal && infoModal.classList.contains('active')) closeInfoModal();
                }
            });

            resultsContainer.innerHTML = '<div class="text-center py-12"><i class="fas fa-spinner fa-spin text-3xl" style="color:#3B82F6"></i><p class="mt-2" style="color:#93c5fd">Loading announcements...</p></div>';

            Promise.all([
                fetch('AnnouncementHandler.ashx?action=getAll', { credentials: 'same-origin' }).then(r => r.json()),
                fetch('UserPinHandler.ashx?action=getUserPins', { credentials: 'same-origin' }).then(r => r.json())
            ]).then(([annRes, pinRes]) => {
                if (!annRes.ok) { resultsContainer.innerHTML = '<div class="text-center py-12" style="color:var(--muted)">Failed to load announcements.</div>'; return; }
                announcementsDB = annRes.data.map(a => ({
                    id: a.id,
                    title: a.title || '',
                    category: a.category === 'Exam' ? 'Exam Schedule' : a.category === 'Suspension' ? 'Class Suspension' : a.category === 'Event' ? 'Campus Events' : (a.category || 'General'),
                    date: a.date || '',
                    professor: a.author || 'Admin',
                    description: a.content || '',
                    imageUrl: a.imageUrl || '',
                    likeCount: a.likeCount || 0,
                    commentCount: a.commentCount || 0
                }));
                announcementsDB.forEach(a => { likeCounts[a.id] = a.likeCount; });
                pins = {};
                if (pinRes.ok && pinRes.pinnedIds) pinRes.pinnedIds.forEach(id => { pins[id] = true; });
                try { if (lastSearchHidden && lastSearchHidden.value) { searchInput.value = lastSearchHidden.value; currentSearchTerm = lastSearchHidden.value; } } catch (e) { }
                renderResults();
            }).catch(() => {
                resultsContainer.innerHTML = '<div class="text-center py-12" style="color:var(--muted)">Could not connect to server.</div>';
            });
        }

        init();

        // Theme sync
        (function () {
            const KEY = 'campus_theme';
            window.addEventListener('storage', e => { if (e.key === KEY) { } });
        })();
    </script>
</body>
</html>