<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SearchDashboard.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.SearchDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>CampusConnect | Announcement Dashboard</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="dark-mode.css">
    <link rel="stylesheet" href="responsive.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

    <style>
        * { font-family: 'Inter', system-ui, -apple-system, sans-serif; }

        /* ── ROOT VARIABLES — teal theme matching dashboard ── */
        :root {
            --page-text: #1a2a3a;
            --surface: rgba(255, 255, 255, 0.92);
            --surface-strong: #ffffff;
            --surface-soft: #f8fafc;
            --border: rgba(26, 58, 92, 0.12);
            --primary: #1a2a3a;
            --primary-2: #1a9aaa;
            --muted: #6b7c8f;
            --muted-light: #9db0c4;
            --shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
            --active-bg: #e0f7fa;
        }

        /* ── BODY — teal/light matching dashboard ── */
        body {
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
            color: var(--page-text);
            background-color: #c9920a;
            background-image: linear-gradient(rgba(255,255,255,0.18), rgba(255,255,255,0.18)), url('wbg.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            background-attachment: fixed;
            transition: color 0.3s ease;
        }

        /* ── NAVBAR ── */
        .glass-nav {
            background: #c9920a;
            border: 1px solid rgba(255,255,255,0.15);
            border-radius: 24px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.2);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            position: fixed !important;
            top: 10px !important;
            left: 10px !important;
            right: 10px !important;
            width: auto !important;
            z-index: 1200 !important;
            transition: background 0.3s ease, box-shadow 0.3s ease;
        }

        body.dark-mode .glass-nav {
            background: rgba(25, 25, 25, 0.95);
            border-color: rgba(255,255,255,0.08);
            box-shadow: 0 4px 24px rgba(0,0,0,0.5);
        }

        body.dark-mode {
            background-color: #121212;
            background-image: linear-gradient(rgba(18,18,18,0.92), rgba(18,18,18,0.92)), url('bg.jpg');
            background-size: cover;
            background-attachment: fixed;
            color: #e4e6eb;
        }

        .glass-nav h1,
        .glass-nav p,
        .glass-nav a,
        .glass-nav button { color: #ffffff !important; }
        .glass-nav .text-muted { color: rgba(255,255,255,0.7) !important; }

        /* ── SIDEBAR ── */
        .glass-sidebar {
            background: rgba(255, 255, 255, 0.92);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid rgba(26, 58, 92, 0.15);
            box-shadow: 0 8px 24px rgba(0,0,0,0.08);
            transition: background 0.4s ease, border-color 0.4s ease;
        }

        /* ── FILTER CARD ── */
        .glass-card {
            background: rgba(255, 255, 255, 0.92);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid rgba(26, 58, 92, 0.15);
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
            transition: all 0.3s ease;
        }

        .glass-card:hover {
            border-color: rgba(42, 172, 191, 0.4);
            transform: translateY(-2px);
        }

        /* ── ANNOUNCEMENT CARDS ── */
        .announce-card {
            background: #ffffff;
            border: 1px solid #2AACBF;
            border-radius: 20px;
            transition: all 0.25s cubic-bezier(0.4,0,0.2,1);
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            overflow: hidden;
            will-change: transform;
        }

        .announce-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 24px rgba(0,0,0,0.10);
            border-color: #1a9aaa;
        }

        .card-author-name { color: #1a3a5c; font-weight: 700; font-size: 15px; }
        .card-meta        { color: var(--muted); font-size: 12px; }
        .card-title       { color: #1a2a3a; font-size: 18px; font-weight: 700; margin-bottom: 8px; }
        .card-desc        { color: #374151; font-size: 13px; line-height: 1.6; }

        .card-banner {
            background: linear-gradient(135deg,#7a5200,#c9920a);
            border-radius: 12px;
            min-width: 90px;
            text-align: center;
            transition: transform 0.2s;
            flex-shrink: 0;
        }
        .card-banner:hover { transform: scale(1.03); }
        .banner-exam       { background: linear-gradient(135deg,#7a5200,#c9920a,#fbbf24); }
        .banner-suspension { background: linear-gradient(135deg,#7c2d12,#b45309,#f59e0b); }
        .banner-events     { background: linear-gradient(135deg,#064e3b,#0d9488,#14b8a6); }
        .banner-default    { background: linear-gradient(135deg,#7a5200,#c9920a,#fbbf24); }

        .post-stats {
            display: flex;
            gap: 16px;
            padding: 8px 20px;
            border-top: 1px solid rgba(26,58,92,0.08);
            border-bottom: 1px solid rgba(26,58,92,0.08);
            color: var(--muted);
            font-size: 13px;
        }
        .post-stats span { display: flex; align-items: center; gap: 5px; cursor: pointer; transition: color 0.2s; }
        .post-stats span:hover { color: #1a3a5c; }

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
        .action-btn:hover { background: #e0f7fa; color: #1a3a5c; }
        .action-btn.liked { color: #dc2626; }
        .action-btn.pinned-active { color: #e65100; }
        .action-btn.notif-active { color: #2AACBF; }

        .comments-section {
            padding: 0 20px 16px;
            border-top: 1px solid rgba(26,58,92,0.08);
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
            background: #f8fafc;
            border: 1px solid rgba(26,58,92,0.15);
            border-radius: 30px;
            outline: none;
            font-size: 13px;
            color: var(--page-text);
            font-family: inherit;
            transition: border-color 0.2s;
        }
        .comment-input-row input:focus { border-color: #2AACBF; }
        .comment-input-row input::placeholder { color: var(--muted-light); }
        .comment-input-row button {
            background: linear-gradient(135deg, #2AACBF, #1a9aaa);
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
            border-bottom: 1px solid rgba(26,58,92,0.08);
            font-size: 13px;
        }
        .comment-item:last-child { border-bottom: none; }
        .comment-avatar {
            width: 30px; height: 30px;
            background: #e0f7fa;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            color: #2AACBF;
            font-size: 12px;
            flex-shrink: 0;
        }
        .comment-author { font-weight: 700; color: #1a3a5c; }
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
        .cat-exam       { background: #e0f7fa; color: #2AACBF; }
        .cat-suspension { background: #ffebee; color: #c62828; }
        .cat-event      { background: #e8f5e9; color: #2e7d32; }
        .cat-default    { background: #fef3c7; color: #92650a; }

        .history-item {
            cursor: pointer;
            transition: all 0.2s ease;
            padding: 8px 12px;
            border-radius: 12px;
            background: rgba(26,58,92,0.05);
            border: 1px solid rgba(26,58,92,0.1);
            color: var(--page-text);
            font-size: 13px;
        }
        .history-item:hover {
            background: #e0f7fa;
            transform: translateX(4px);
            border-color: rgba(42,172,191,0.35);
            color: #1a3a5c;
        }

        /* ── SEARCH INPUT in navbar ── */
        .search-input {
            background: rgba(255,255,255,0.2);
            backdrop-filter: blur(4px);
            border: 1.5px solid rgba(255,255,255,0.45);
            transition: all 0.2s;
            color: #ffffff;
        }
        .search-input:focus {
            background: rgba(255,255,255,0.28);
            border-color: rgba(255,255,255,0.8);
            box-shadow: 0 0 0 3px rgba(255,255,255,0.15);
            outline: none;
        }
        .search-input::placeholder { color: rgba(255,255,255,0.65); }
        .glass-nav .fa-search { color: rgba(255,255,255,0.8) !important; }

        /* ── FILTER SELECTS ── */
        .filter-select {
            background: #f8fafc;
            border: 1px solid rgba(26,58,92,0.2);
            color: var(--page-text);
            transition: border-color 0.2s;
        }
        .filter-select:focus { border-color: #2AACBF; outline: none; }
        .filter-select option { background: #ffffff; color: var(--page-text); }

        /* Flatpickr light override */
        .flatpickr-calendar {
            background: #ffffff !important;
            border: 1px solid rgba(42,172,191,0.3) !important;
            box-shadow: 0 8px 24px rgba(0,0,0,0.12) !important;
        }
        .flatpickr-day { color: #1a2a3a !important; }
        .flatpickr-day:hover { background: #e0f7fa !important; }
        .flatpickr-day.selected { background: #2AACBF !important; border-color: #2AACBF !important; color: #fff !important; }
        .flatpickr-months .flatpickr-month,
        .flatpickr-weekdays,
        span.flatpickr-weekday { background: #f0fafb !important; color: #1a3a5c !important; fill: #1a3a5c !important; }
        .flatpickr-current-month select,
        .flatpickr-current-month input { color: #1a2a3a !important; }
        .flatpickr-prev-month svg, .flatpickr-next-month svg { fill: #2AACBF !important; }
        .flatpickr-day.flatpickr-disabled { color: #9db0c4 !important; }

        /* Hide page scrollbar */
        html::-webkit-scrollbar { display: none; }
        html { scrollbar-width: none; -ms-overflow-style: none; }
        /* Custom scrollbar for inner containers */
        .glass-sidebar::-webkit-scrollbar { width: 6px; }
        .glass-sidebar::-webkit-scrollbar-track { background: rgba(26,58,92,0.05); border-radius: 10px; }
        .glass-sidebar::-webkit-scrollbar-thumb { background: rgba(42,172,191,0.4); border-radius: 10px; }

        #resultsContainer { display: flex; flex-direction: column; gap: 16px; }

        /* ══════════════════════════════════════════
           LIGHT MODE OVERRIDES
           Applied when body has class "light-mode"
        ══════════════════════════════════════════ */
        body.light-mode {
            background-color: #f0f4f8;
            background-image:
                radial-gradient(ellipse at 15% 40%, rgba(200,220,255,0.35) 0%, transparent 55%),
                radial-gradient(ellipse at 85% 15%, rgba(180,200,255,0.2) 0%, transparent 50%),
                radial-gradient(ellipse at 60% 85%, rgba(210,225,255,0.25) 0%, transparent 45%);
            color: #1a2a3a;
        }
        body.light-mode .glass-nav {
            background: #c9920a;
            border-color: rgba(255,255,255,0.15);
            box-shadow: 0 4px 20px rgba(0,0,0,0.2);
        }
        body.light-mode .glass-sidebar {
            background: rgba(255,255,255,0.92);
            border-color: rgba(26,58,92,0.15);
            box-shadow: 0 8px 24px rgba(0,0,0,0.08);
        }
        body.light-mode .glass-card {
            background: rgba(255,255,255,0.92);
            border-color: rgba(26,58,92,0.15);
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
        }
        body.light-mode .glass-card:hover {
            border-color: rgba(26,58,92,0.3);
        }
        body.light-mode .announce-card {
            background: #ffffff;
            border-color: rgba(59,130,246,0.4);
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
        }
        body.light-mode .announce-card:hover {
            border-color: rgba(201,146,10,0.6);
            box-shadow: 0 8px 24px rgba(0,0,0,0.1);
        }
        body.light-mode .card-author-name { color: #1a3a5c; }
        body.light-mode .card-meta        { color: #6b7c8f; }
        body.light-mode .card-title       { color: #1a2a3a; }
        body.light-mode .card-desc        { color: #374151; }
        body.light-mode .post-stats {
            border-color: rgba(26,58,92,0.1);
            color: #6b7c8f;
        }
        body.light-mode .post-stats span:hover { color: #1a3a5c; }
        body.light-mode .action-btn { color: #6b7c8f; }
        body.light-mode .action-btn:hover { background: #e8f0fe; color: #1a3a5c; }
        body.light-mode .action-btn.liked { color: #dc2626; }
        body.light-mode .action-btn.pinned-active { color: #e65100; }
        body.light-mode .comments-section { border-color: rgba(26,58,92,0.1); }
        body.light-mode .comment-input-row input {
            background: #f8fafc;
            border-color: rgba(26,58,92,0.2);
            color: #1a2a3a;
        }
        body.light-mode .comment-input-row input::placeholder { color: #9db0c4; }
        body.light-mode .comment-input-row input:focus { border-color: #1a3a5c; }
        body.light-mode .comment-item { border-color: rgba(26,58,92,0.08); }
        body.light-mode .comment-avatar { background: #e8f0fe; color: #1a3a5c; }
        body.light-mode .comment-author { color: #1a3a5c; }
        body.light-mode .comment-text   { color: #374151; }
        body.light-mode .comment-time   { color: #9db0c4; }
        body.light-mode .no-comments    { color: #9db0c4; }
        body.light-mode .history-item {
            background: rgba(26,58,92,0.05);
            border-color: rgba(26,58,92,0.1);
            color: #374151;
        }
        body.light-mode .history-item:hover {
            background: #e8f0fe;
            border-color: rgba(26,58,92,0.25);
            color: #1a3a5c;
        }
        body.light-mode .search-input {
            background: rgba(255,255,255,0.25);
            border-color: rgba(255,255,255,0.5);
            color: #ffffff;
        }
        body.light-mode .search-input::placeholder { color: rgba(255,255,255,0.75); }
        body.light-mode .filter-select {
            background: #f8fafc;
            border-color: rgba(26,58,92,0.2);
            color: #1a2a3a;
        }
        body.light-mode .filter-select option { background: #ffffff; color: #1a2a3a; }
        body.light-mode .section-title { color: #1a3a5c; }
        body.light-mode .section-icon  { color: #1a3a5c; }
        body.light-mode #resultCount {
            background: rgba(26,58,92,0.08);
            border-color: rgba(26,58,92,0.2);
            color: #1a3a5c !important;
        }
        body.light-mode #emptyState {
            background: rgba(255,255,255,0.9);
            border-color: rgba(26,58,92,0.15);
        }
        body.light-mode footer {
            border-color: rgba(26,58,92,0.1) !important;
            color: #6b7c8f !important;
            background: rgba(255,255,255,0.6) !important;
        }
        body.light-mode .cat-exam       { background: #e3f2fd; color: #1976d2; }
        body.light-mode .cat-suspension { background: #ffebee; color: #c62828; }
        body.light-mode .cat-event      { background: #e8f5e9; color: #2e7d32; }
        body.light-mode .cat-default    { background: #fef3c7; color: #92650a; }
        body.light-mode .confirm-card {
            background: #ffffff;
            border-color: rgba(26,58,92,0.15);
        }
        body.light-mode .confirm-title   { color: #1a2a3a; }
        body.light-mode .confirm-message { color: #6b7c8f; }
        body.light-mode .btn-cancel { background: rgba(26,58,92,0.08); color: #374151; border-color: rgba(26,58,92,0.15); }
        body.light-mode .btn-cancel:hover { background: rgba(26,58,92,0.14); }

        /* ══════════════════════════════════════════
           DARK MODE OVERRIDES
        ══════════════════════════════════════════ */
        body.dark-mode .glass-sidebar {
            background: rgba(15, 25, 55, 0.85);
            border-color: rgba(255,255,255,0.08);
            box-shadow: 0 8px 32px rgba(0,0,0,0.4);
        }
        body.dark-mode .glass-card {
            background: rgba(15, 25, 55, 0.80);
            border-color: rgba(255,255,255,0.08);
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
        }
        body.dark-mode .glass-card:hover {
            border-color: rgba(201,146,10,0.40);
        }
        body.dark-mode .announce-card {
            background: rgba(22, 36, 71, 0.95);
            border-color: rgba(59,130,246,0.35);
            box-shadow: 0 2px 12px rgba(0,0,0,0.3);
        }
        body.dark-mode .announce-card:hover {
            border-color: rgba(201,146,10,0.55);
            box-shadow: 0 8px 28px rgba(0,0,0,0.45);
        }
        body.dark-mode .card-author-name { color: #fcd34d; }
        body.dark-mode .card-meta        { color: #94a3b8; }
        body.dark-mode .card-title       { color: #e0e7ff; }
        body.dark-mode .card-desc        { color: #cbd5e1; }
        body.dark-mode .post-stats {
            border-color: rgba(255,255,255,0.07);
            color: #94a3b8;
        }
        body.dark-mode .post-stats span:hover { color: #93c5fd; }
        body.dark-mode .action-btn { color: #94a3b8; }
        body.dark-mode .action-btn:hover { background: rgba(201,146,10,0.12); color: #fcd34d; }
        body.dark-mode .action-btn.liked { color: #f87171; }
        body.dark-mode .action-btn.pinned-active { color: #fb923c; }
        body.dark-mode .action-btn.notif-active { color: #60a5fa; }
        body.dark-mode .comments-section { border-color: rgba(255,255,255,0.07); }
        body.dark-mode .comment-input-row input {
            background: rgba(255,255,255,0.07);
            border-color: rgba(255,255,255,0.12);
            color: #e2e8f0;
        }
        body.dark-mode .comment-input-row input::placeholder { color: #64748b; }
        body.dark-mode .comment-input-row input:focus { border-color: #60a5fa; }
        body.dark-mode .comment-item { border-color: rgba(255,255,255,0.07); }
        body.dark-mode .comment-avatar { background: rgba(201,146,10,0.18); color: #fcd34d; }
        body.dark-mode .comment-author { color: #fbbf24; }
        body.dark-mode .comment-text   { color: #cbd5e1; }
        body.dark-mode .comment-time   { color: #64748b; }
        body.dark-mode .no-comments    { color: #64748b; }
        body.dark-mode .history-item {
            background: rgba(255,255,255,0.05);
            border-color: rgba(255,255,255,0.08);
            color: #cbd5e1;
        }
        body.dark-mode .history-item:hover {
            background: rgba(201,146,10,0.15);
            border-color: rgba(201,146,10,0.35);
            color: #fef3c7;
        }
        body.dark-mode .filter-select {
            background: rgba(15,25,55,0.85);
            border-color: rgba(255,255,255,0.12);
            color: #e2e8f0;
        }
        body.dark-mode .filter-select option { background: #121212; color: #e4e6eb; }
        body.dark-mode .section-title { color: #fcd34d !important; }
        body.dark-mode .section-icon  { color: #fbbf24 !important; }
        body.dark-mode #resultCount {
            background: rgba(99,102,241,0.15);
            border-color: rgba(99,102,241,0.3);
            color: #c7d2fe !important;
        }
        body.dark-mode #emptyState {
            background: rgba(15,25,55,0.85);
            border-color: rgba(255,255,255,0.08);
            color: #94a3b8;
        }
        body.dark-mode .cat-exam       { background: rgba(201,146,10,0.20); color: #fcd34d; }
        body.dark-mode .cat-suspension { background: rgba(198,40,40,0.2);  color: #ef9a9a; }
        body.dark-mode .cat-event      { background: rgba(46,125,50,0.2);  color: #a5d6a7; }
        body.dark-mode .cat-default    { background: rgba(80,80,80,0.35);  color: #d1d5db; }
        body.dark-mode .confirm-card {
            background: rgba(25,25,25,0.97);
            border-color: rgba(255,255,255,0.1);
        }
        body.dark-mode .confirm-title   { color: #e0e7ff; }
        body.dark-mode .confirm-message { color: #94a3b8; }
        body.dark-mode .btn-cancel { background: rgba(45,45,45,0.80); color: #d1d5db; border-color: rgba(255,255,255,0.15); }
        body.dark-mode .btn-cancel:hover { background: rgba(201,146,10,0.12); color: #fcd34d; }
        body.dark-mode footer {
            border-color: rgba(255,255,255,0.07) !important;
            color: #64748b !important;
            background: rgba(15,25,55,0.5) !important;
        }

        /* ── TOAST ── */
        .toast-msg {
            position: fixed;
            bottom: 28px;
            left: 50%;
            transform: translateX(-50%);
            background: linear-gradient(135deg, #7a5200, #c9920a);
            color: white;
            padding: 10px 24px;
            border-radius: 30px;
            font-size: 13px;
            z-index: 9999;
            box-shadow: 0 4px 20px rgba(99,102,241,0.4);
            animation: toastFade 2.6s ease forwards;
            pointer-events: none;
        }
        @keyframes toastFade {
            0%   { opacity: 0; transform: translateX(-50%) translateY(10px); }
            12%  { opacity: 1; transform: translateX(-50%) translateY(0); }
            80%  { opacity: 1; }
            100% { opacity: 0; }
        }

        /* ── MODAL OVERLAY ── */
        .modal-overlay {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.65);
            backdrop-filter: blur(6px);
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
            background: rgba(10, 18, 45, 0.95);
            border: 1px solid rgba(99,102,241,0.25);
            border-radius: 28px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.6);
            padding: 2rem 1.75rem;
            text-align: center;
            transform: scale(0.95);
            transition: transform 0.2s ease;
            backdrop-filter: blur(20px);
        }
        .modal-overlay.active .confirm-card {
            transform: scale(1);
        }
        .icon-wrapper {
            background: rgba(220,38,38,0.15);
            border: 1px solid rgba(220,38,38,0.3);
            width: 64px; height: 64px;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 1.25rem;
        }
        .icon-wrapper i { font-size: 2rem; color: #ef4444; }
        .confirm-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #f1f5f9;
            margin-bottom: 0.5rem;
        }
        .confirm-message {
            font-size: 1rem;
            color: #94a3b8;
            margin-bottom: 1.75rem;
            line-height: 1.5;
        }
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
        .btn-cancel { background: rgba(255,255,255,0.08); color: #cbd5e1; border: 1px solid rgba(255,255,255,0.12); }
        .btn-cancel:hover { background: rgba(255,255,255,0.13); }
        .btn-danger { background: #dc2626; color: white; }
        .btn-danger:hover { background: #b91c1c; }

        /* Info dialog */
        .info-icon-wrapper {
            background: rgba(59,130,246,0.15);
            border: 1px solid rgba(59,130,246,0.3);
            width: 64px; height: 64px;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 1.25rem;
        }
        .info-icon-wrapper i { font-size: 2rem; color: #c9920a; }
        .btn-info { background: linear-gradient(135deg, #7a5200, #c9920a); color: white; }
        .btn-info:hover { opacity: 0.88; }

        @media (max-width: 480px) {
            .confirm-card { padding: 1.5rem; }
            .icon-wrapper { width: 52px; height: 52px; }
            .icon-wrapper i { font-size: 1.6rem; }
            .confirm-title { font-size: 1.3rem; }
        }

        /* ── TRANSITIONS ── */
        *, *::before, *::after {
            transition: background-color 0.3s ease, border-color 0.3s ease,
                        color 0.3s ease, box-shadow 0.3s ease;
        }

        /* ── RESPONSIVE ── */
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

        /* Sidebar offset — removed, these pages have no sidebar */
        .page-content-offset {
            padding-left: 0;
            padding-top: 90px;
        }

        /* Cap announcement images */
        .announce-card img { max-height: 200px; object-fit: cover; width: 100%; }

        /* ── FOOTER ── */
        footer {
            border-color: rgba(255,255,255,0.07) !important;
            color: var(--muted) !important;
            background: rgba(5,10,25,0.5) !important;
        }

        /* ── RESULT COUNT BADGE ── */
        #resultCount {
            background: rgba(42,172,191,0.15);
            border: 1px solid rgba(42,172,191,0.3);
            color: #1a3a5c !important;
        }

        /* ── EMPTY STATE ── */
        #emptyState {
            background: rgba(255,255,255,0.9);
            border: 1px solid rgba(26,58,92,0.12);
        }

        /* ── HEADING ICONS ── */
        .section-icon { color: #2AACBF; }
        .section-title { color: #1a2a3a; }

        /* ── LOGO ICON BG ── */
        .logo-icon-bg {
            background: rgba(255,255,255,0.2);
            border: 1px solid rgba(255,255,255,0.3);
        }
    </style>
</head>
<body class="antialiased relative">

    <form id="form1" runat="server">
        <asp:HiddenField ID="lastSearchTerm" runat="server" />

        <div class="relative z-10 page-content-offset">

            <!-- ═══ NAVBAR ═══ -->
            <header class="glass-nav sticky top-0 z-40">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div class="flex flex-wrap items-center justify-between py-3 md:py-4 gap-3">
                        <div class="flex items-center gap-3 cursor-pointer group">
                            <div class="logo-icon-bg p-2 rounded-xl shadow-xl transition group-hover:scale-105">
                                <i class="fas fa-university text-white text-xl"></i>
                            </div>
                            <div>
                                <h1 class="font-extrabold text-xl md:text-2xl tracking-tight text-white">CampusAnnouncement</h1>
                                <p class="text-xs font-medium hidden sm:block" style="color:rgba(255,255,255,0.55)">Teacher Portal</p>
                            </div>
                        </div>
                        <div class="flex-1 max-w-md mx-4">
                            <div class="relative">
                                <i class="fas fa-search absolute left-3 top-1/2 -translate-y-1/2 text-sm" style="color:rgba(255,255,255,0.6)"></i>
                                <asp:TextBox ID="searchInput" runat="server" CssClass="search-input w-full pl-10 pr-4 py-2 rounded-xl" placeholder="Search announcements..."></asp:TextBox>
                            </div>
                        </div>
                        <div class="flex items-center gap-3 md:gap-4">
                            <asp:HyperLink ID="homeLink" runat="server" NavigateUrl="~/Teacher.aspx"
                                CssClass="p-2 rounded-full transition-all text-white" style="background:rgba(255,255,255,0.08);border:1px solid rgba(255,255,255,0.12)">
                                <i class="fas fa-home text-xl"></i>
                            </asp:HyperLink>
                        </div>
                    </div>
                </div>
            </header>

            <!-- ═══ MAIN CONTENT ═══ -->
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6 md:py-8">
                <div class="flex flex-col lg:flex-row gap-6">

                    <!-- ── SIDEBAR ── -->
                    <div class="lg:w-72 flex-shrink-0">
                        <div class="glass-sidebar rounded-2xl p-5 sticky top-24">
                            <div class="flex justify-between items-center mb-4">
                                <div class="flex items-center gap-2">
                                    <i class="fas fa-history text-lg section-icon"></i>
                                    <h3 class="font-bold text-base section-title">Search History</h3>
                                </div>
                                <button type="button" id="clearHistoryBtn" class="text-xs transition px-2 py-1 rounded-lg" style="color:#f87171;background:rgba(220,38,38,0.1);border:1px solid rgba(220,38,38,0.2)">
                                    <i class="fas fa-trash-alt mr-1"></i>Clear
                                </button>
                            </div>
                            <div id="historyList" class="space-y-2 max-h-[400px] overflow-y-auto">
                                <div class="text-sm text-center py-4" style="color:var(--muted)">No searches yet</div>
                            </div>
                        </div>
                    </div>

                    <!-- ── MAIN PANEL ── -->
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

                        <!-- Header row -->
                        <div class="flex justify-between items-center mb-4">
                            <div class="flex items-center gap-2">
                                <i class="fas fa-newspaper text-xl section-icon"></i>
                                <h3 class="font-bold text-lg section-title">Announcements</h3>
                            </div>
                            <span id="resultCount" class="px-3 py-1 rounded-full text-xs font-semibold">0 items</span>
                        </div>

                        <!-- Results -->
                        <div id="resultsContainer" class="space-y-5">
                            <div class="text-center py-12">
                                <i class="fas fa-spinner fa-spin text-3xl" style="color:#6366f1"></i>
                                <p class="mt-2" style="color:#93c5fd">Loading announcements...</p>
                            </div>
                        </div>

                        <!-- Empty state -->
                        <div id="emptyState" class="rounded-2xl p-12 text-center hidden">
                            <i class="fas fa-inbox text-5xl mb-3" style="color:var(--muted-light)"></i>
                            <p style="color:var(--muted)">No announcements match your criteria</p>
                            <button type="button" id="resetFiltersBtn" class="mt-3 text-sm underline transition" style="color:#93c5fd">Reset all filters</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ═══ FOOTER ═══ -->
            <footer class="border-t mt-12 py-5 text-center text-xs backdrop-blur-sm">
                <i class="far fa-copyright"></i> 2026 CampusConnect — Connecting Teachers to Campus Life
            </footer>
        </div>

        <!-- ═══ CONFIRM MODAL (Clear History) ═══ -->
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

        <!-- ═══ INFO MODAL (Empty History) ═══ -->
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
        // ════════════════════════════════════════════════════════
        // DATA — load live announcements from AnnouncementHandler API
        // ════════════════════════════════════════════════════════
        let announcementsDB = [];

        function fetchAnnouncementsFromAPI() {
            Promise.all([
                fetch('AnnouncementHandler.ashx?action=getAll', { credentials: 'same-origin' }).then(r => r.json()),
                fetch('UserPinHandler.ashx?action=getUserPins', { credentials: 'same-origin' }).then(r => r.json())
            ]).then(([annRes, pinRes]) => {
                if (!annRes.ok) {
                    resultsContainer.innerHTML = '<div class="text-center py-12" style="color:var(--muted)">Failed to load announcements.</div>';
                    return;
                }
                announcementsDB = annRes.data.map(a => ({
                    id: a.id,
                    title: a.title || '',
                    category: a.category === 'Exam' ? 'Exam Schedule'
                        : a.category === 'Suspension' ? 'Class Suspension'
                            : a.category === 'Event' ? 'Campus Events'
                                : (a.category || 'General'),
                    date: a.date || '',
                    professor: a.author || '',
                    authorFullName: a.authorFullName || a.author || '',
                    description: a.content || '',
                    imageUrl: a.imageUrl || '',
                    likeCount: a.likeCount || 0,
                    commentCount: a.commentCount || 0,
                    authorImage: a.authorImage || '',
                    bannerType: a.category === 'Exam' ? 'exam'
                        : a.category === 'Suspension' ? 'suspension'
                            : a.category === 'Event' ? 'events' : 'default',
                    bannerText: a.category === 'Exam' ? 'EXAM SCHEDULE'
                        : a.category === 'Suspension' ? 'CLASS SUSPENSION'
                            : a.category === 'Event' ? 'CAMPUS EVENT'
                                : (a.category || 'GENERAL').toUpperCase()
                }));
                announcementsDB.forEach(a => { likeCounts[a.id] = a.likeCount; });
                pins = {};
                if (pinRes.ok && pinRes.pinnedIds) pinRes.pinnedIds.forEach(id => { pins[id] = true; });
                renderResults();
            }).catch(() => {
                resultsContainer.innerHTML = '<div class="text-center py-12" style="color:var(--muted)">Could not connect to server.</div>';
            });
        }

        // ── Persistent state (localStorage) ──────────────────────
        const STORAGE = {
            get: k => JSON.parse(localStorage.getItem(k) || 'null'),
            set: (k, v) => localStorage.setItem(k, JSON.stringify(v))
        };

        function loadPins() {
            const tp = STORAGE.get('teacher_pins') || {};
            const cp = STORAGE.get('campus_pins') || {};
            const merged = Object.assign({}, cp, tp);
            Object.keys(merged).forEach(k => { if (!/^\d+$/.test(k)) delete merged[k]; });
            return merged;
        }
        function loadLikeCounts() {
            const tl = STORAGE.get('teacher_likeCounts') || {};
            const sl = STORAGE.get('sd_likeCounts') || {};
            return Object.assign({}, sl, tl);
        }

        let likes = STORAGE.get('sd_likes') || {};
        let likeCounts = loadLikeCounts();
        let pins = loadPins();
        let notifs = STORAGE.get('sd_notifs') || {};
        let comments = STORAGE.get('sd_comments') || {};
        let searchHistory = STORAGE.get('campus_history') || [];

        function saveState() {
            STORAGE.set('sd_likes', likes);
            STORAGE.set('sd_likeCounts', likeCounts);
            STORAGE.set('campus_pins', pins);
            STORAGE.set('teacher_pins', pins);
            STORAGE.set('sd_notifs', notifs);
            STORAGE.set('sd_comments', comments);
        }

        // ── Modal elements ──
        const confirmModal = document.getElementById('confirmModal');
        const infoModal = document.getElementById('infoModal');
        const modalCancel = document.getElementById('modalCancelBtn');
        const modalConfirm = document.getElementById('modalConfirmBtn');
        const infoOkBtn = document.getElementById('infoOkBtn');

        function showConfirmModal() { if (confirmModal) confirmModal.classList.add('active'); }
        function closeConfirmModal() { if (confirmModal) confirmModal.classList.remove('active'); }
        function showInfoModal() { if (infoModal) infoModal.classList.add('active'); }
        function closeInfoModal() { if (infoModal) infoModal.classList.remove('active'); }

        function executeClearHistory() {
            searchHistory = [];
            saveHistory();
            showToast('🗑️ Search history cleared');
            closeConfirmModal();
        }

        function checkAndClearHistory() {
            if (searchHistory.length === 0) { showInfoModal(); }
            else { showConfirmModal(); }
        }

        // ── DOM refs ──
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

        let currentSearchTerm = '';
        let currentDate = '';
        let currentSort = 'latest';

        // ── Helpers ──
        function escapeHtml(str) {
            if (!str) return '';
            return str.replace(/[&<>"']/g, m => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[m]));
        }

        function formatDate(dateStr) {
            if (!dateStr) return '';
            var date = new Date(dateStr);
            if (isNaN(date)) return dateStr;
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

        function getBannerClass(type) {
            return { exam: 'banner-exam', suspension: 'banner-suspension', events: 'banner-events' }[type] || 'banner-default';
        }

        function getCatClass(cat) {
            if (cat === 'Exam Schedule') return 'cat-exam';
            if (cat === 'Class Suspension') return 'cat-suspension';
            if (cat === 'Campus Events') return 'cat-event';
            return 'cat-default';
        }

        function showToast(msg) {
            const t = document.createElement('div');
            t.className = 'toast-msg';
            t.textContent = msg;
            document.body.appendChild(t);
            setTimeout(() => t.remove(), 2700);
        }

        function updateNotifBadge() { /* bell removed */ }

        // ── Search History ──
        function saveHistory() {
            STORAGE.set('campus_history', searchHistory.slice(0, 15));
            renderHistory();
        }

        function addToHistory(term) {
            if (!term.trim()) return;
            term = term.trim();
            searchHistory = [term, ...searchHistory.filter(t => t !== term)].slice(0, 15);
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

        // ── Pinned sidebar ──
        function renderPinnedSidebar() {
            const pinnedList = document.getElementById('pinnedList');
            const pinnedCountEl = document.getElementById('pinnedCount');
            if (!pinnedList || !pinnedCountEl) return;
            const pinned = announcementsDB.filter(a => pins[a.id]);
            pinnedCountEl.textContent = pinned.length;
            if (!pinned.length) {
                pinnedList.innerHTML = '<div class="text-xs text-center py-2" style="color:var(--muted)">No pinned items</div>';
                return;
            }
            pinnedList.innerHTML = pinned.map(a => `
                <div class="history-item flex items-center gap-2 text-xs" style="color:#93c5fd">
                    <i class="fas fa-thumbtack text-orange-400 flex-shrink-0"></i>
                    <span class="truncate">${escapeHtml(a.title)}</span>
                </div>
            `).join('');
        }

        // ── Filter & Sort ──
        function getFilteredAnnouncements() {
            let results = [...announcementsDB];
            if (currentSearchTerm.trim()) {
                const kw = currentSearchTerm.toLowerCase().trim();
                results = results.filter(a =>
                    a.title.toLowerCase().includes(kw) ||
                    a.description.toLowerCase().includes(kw) ||
                    a.professor.toLowerCase().includes(kw) ||
                    (a.authorFullName || '').toLowerCase().includes(kw)
                );
            }
            if (currentDate) results = results.filter(a => a.date && a.date.startsWith(currentDate));

            // Sort: pinned items always float to top, date order applied within each group
            const dateCompare = currentSort === 'oldest'
                ? (a, b) => new Date(a.date) - new Date(b.date)
                : (a, b) => new Date(b.date) - new Date(a.date);

            results.sort((a, b) => {
                const pinDiff = (pins[b.id] ? 1 : 0) - (pins[a.id] ? 1 : 0);
                return pinDiff !== 0 ? pinDiff : dateCompare(a, b);
            });

            return results;
        }

        // ── Render Cards ──
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
                const liked = !!likes[ann.id];
                const pinned = !!pins[ann.id];
                const lc = likeCounts[ann.id] || 0;
                const cc = (comments[ann.id] || []).length;

                return `
                <div class="announce-card" data-id="${ann.id}">
                    <div style="padding:18px 20px 12px">
                        <div style="display:flex;align-items:flex-start;justify-content:space-between;gap:12px;margin-bottom:12px">
                            <div style="display:flex;align-items:center;gap:12px;flex:1">
                                <div style="width:44px;height:44px;background:rgba(201,146,10,0.18);border:1px solid rgba(201,146,10,0.35);border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:20px;flex-shrink:0;overflow:hidden;">
                                    ${ann.authorImage ? `<img src="${escapeHtml(ann.authorImage)}" style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;" onerror="this.style.display='none'" />` : `<i class="fas fa-user-tie" style="color:#fcd34d"></i>`}
                                </div>
                                <div>
                                    <div class="card-author-name">${escapeHtml(ann.professor)}</div>
                                    <div class="card-meta"><i class="far fa-calendar-alt mr-1"></i>${formatDate(ann.date)}</div>
                                </div>
                            </div>
                            <div style="display:flex;align-items:center;gap:8px">
                                <div class="card-banner ${getBannerClass(ann.bannerType)} px-3 py-1 hidden sm:block">
                                    <p class="text-white text-xs font-bold tracking-wide">${ann.bannerText}</p>
                                </div>
                                <button type="button"
                                    onclick="togglePin(${ann.id})"
                                    title="${pinned ? 'Unpin' : 'Pin this announcement'}"
                                    style="flex:none;width:34px;height:34px;padding:0;border-radius:50%;background:${pinned ? 'rgba(230,81,0,0.18)' : 'rgba(255,255,255,0.06)'};border:1px solid ${pinned ? 'rgba(230,81,0,0.35)' : 'rgba(255,255,255,0.1)'};cursor:pointer;display:flex;align-items:center;justify-content:center;font-size:16px;transition:all 0.2s;color:${pinned ? '#fb923c' : '#64748b'}">
                                    <i class="fas fa-thumbtack"></i>
                                </button>
                            </div>
                        </div>
                        <div class="card-title">${escapeHtml(ann.title)}</div>
                        <div class="card-desc">${escapeHtml(ann.description)}</div>
                    </div>
                    <div class="post-stats">
                        <span onclick="toggleLike(${ann.id})">
                            <i class="${liked ? 'fas' : 'far'} fa-heart" style="${liked ? 'color:#dc2626' : ''}"></i>
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
                    <div class="action-buttons">
                        <button type="button" class="action-btn ${liked ? 'liked' : ''}" onclick="toggleLike(${ann.id})">
                            <i class="${liked ? 'fas' : 'far'} fa-heart"></i> ${liked ? 'Liked' : 'Like'}
                        </button>
                        <button type="button" class="action-btn" onclick="openComments(${ann.id})">
                            <i class="far fa-comment"></i> Comment
                        </button>
                        <button type="button" class="action-btn" onclick="sharePost(${ann.id}, '${escapeHtml(ann.title)}')">
                            <i class="fas fa-share-alt"></i> Share
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

        function renderCommentsList(id) {
            const list = comments[id] || [];
            if (!list.length) return '<div class="no-comments">No comments yet. Be the first!</div>';

            const topLevel = list.filter(c => !c.parentCommentId);
            const replies  = list.filter(c =>  c.parentCommentId);

            function avatarHtml(img) {
                if (img) return `<div class="comment-avatar" style="overflow:hidden;"><img src="${escapeHtml(img)}" style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;" onerror="this.style.display='none'" /></div>`;
                return `<div class="comment-avatar"><i class="fas fa-user"></i></div>`;
            }

            function buildReply(r) {
                const liked = r.userLiked;
                return `<div class="comment-item" style="margin-left:38px;padding:6px 0;" id="ci-r-${r.commentId}">
                    ${avatarHtml(r.profileImage)}
                    <div style="flex:1;min-width:0;">
                        <div class="comment-author">${escapeHtml(r.author)}</div>
                        <div class="comment-text">${escapeHtml(r.text)}</div>
                        <div style="display:flex;align-items:center;gap:10px;margin-top:3px;">
                            <span class="comment-time">${escapeHtml(r.date || '')}</span>
                            <button type="button" onclick="likeComment(${r.commentId},${id},this)"
                                style="background:none;border:none;cursor:pointer;font-size:11px;color:${liked?'#dc2626':'var(--muted)'};display:flex;align-items:center;gap:3px;padding:0;">
                                <i class="${liked?'fas':'far'} fa-heart"></i>
                                <span class="clc">${r.likeCount>0?r.likeCount:''}</span>
                            </button>
                            <button type="button" onclick="toggleReplyBox('rb-${r.commentId}')"
                                style="background:none;border:none;cursor:pointer;font-size:11px;color:var(--muted);padding:0;">
                                <i class="fas fa-reply"></i> Reply
                            </button>
                        </div>
                        <div id="rb-${r.commentId}" style="display:none;margin-top:6px;">
                            <div class="comment-input-row" style="margin:0;">
                                <input type="text" placeholder="Reply to ${escapeHtml(r.author)}..." />
                                <button type="button" onclick="submitReply(${r.commentId},${id},this)">Reply</button>
                            </div>
                        </div>
                    </div>
                </div>`;
            }

            return topLevel.map(c => {
                const liked = c.userLiked;
                const childReplies = replies.filter(r => r.parentCommentId === c.commentId);
                return `<div class="comment-item" id="ci-${c.commentId}">
                    ${avatarHtml(c.profileImage)}
                    <div style="flex:1;min-width:0;">
                        <div class="comment-author">${escapeHtml(c.author)}</div>
                        <div class="comment-text">${escapeHtml(c.text)}</div>
                        <div style="display:flex;align-items:center;gap:10px;margin-top:3px;">
                            <span class="comment-time">${escapeHtml(c.date || '')}</span>
                            <button type="button" onclick="likeComment(${c.commentId},${id},this)"
                                style="background:none;border:none;cursor:pointer;font-size:11px;color:${liked?'#dc2626':'var(--muted)'};display:flex;align-items:center;gap:3px;padding:0;">
                                <i class="${liked?'fas':'far'} fa-heart"></i>
                                <span class="clc">${c.likeCount>0?c.likeCount:''}</span>
                            </button>
                            <button type="button" onclick="toggleReplyBox('rb-${c.commentId}')"
                                style="background:none;border:none;cursor:pointer;font-size:11px;color:var(--muted);padding:0;">
                                <i class="fas fa-reply"></i> Reply
                            </button>
                        </div>
                        <div id="rb-${c.commentId}" style="display:none;margin-top:6px;">
                            <div class="comment-input-row" style="margin:0;">
                                <input type="text" placeholder="Reply to ${escapeHtml(c.author)}..." />
                                <button type="button" onclick="submitReply(${c.commentId},${id},this)">Reply</button>
                            </div>
                        </div>
                        ${childReplies.map(r => buildReply(r)).join('')}
                    </div>
                </div>`;
            }).join('');
        }

        function toggleReplyBox(boxId) {
            const box = document.getElementById(boxId);
            if (!box) return;
            const isOpen = box.style.display === 'block';
            box.style.display = isOpen ? 'none' : 'block';
            if (!isOpen) { const inp = box.querySelector('input'); if (inp) inp.focus(); }
        }

        function submitReply(parentCommentId, postId, btn) {
            const box = document.getElementById('rb-' + parentCommentId);
            if (!box) return;
            const input = box.querySelector('input');
            const text = input ? input.value.trim() : '';
            if (!text) { showToast('Write a reply first'); return; }
            if (btn) { btn.disabled = true; btn.textContent = '...'; }
            fetch('CommentHandler.ashx?action=reply', {
                method: 'POST', credentials: 'same-origin',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ postId: postId, parentCommentId: parentCommentId, comment: text })
            })
            .then(r => r.json())
            .then(res => {
                if (btn) { btn.disabled = false; btn.textContent = 'Reply'; }
                if (!res.success) { showToast('Error: ' + (res.error || 'Could not post reply')); return; }
                if (input) input.value = '';
                box.style.display = 'none';
                reloadComments(postId);
                showToast('Reply posted!');
            })
            .catch(() => { if (btn) { btn.disabled = false; btn.textContent = 'Reply'; } showToast('Could not post reply'); });
        }

        function likeComment(commentId, postId, btn) {
            fetch('CommentHandler.ashx?action=likeComment&commentId=' + commentId, { credentials: 'same-origin' })
            .then(r => r.json())
            .then(res => {
                if (!res.success) { showToast('Error'); return; }
                if (btn) {
                    btn.style.color = res.liked ? '#dc2626' : 'var(--muted)';
                    const icon = btn.querySelector('i');
                    if (icon) icon.className = (res.liked ? 'fas' : 'far') + ' fa-heart';
                    const cnt = btn.querySelector('.clc');
                    if (cnt) cnt.textContent = res.likeCount > 0 ? res.likeCount : '';
                }
            })
            .catch(() => showToast('Could not update reaction'));
        }

        function reloadComments(postId) {
            fetch('CommentHandler.ashx?action=get&postId=' + postId, { credentials: 'same-origin' })
            .then(r => r.json())
            .then(data => {
                if (!Array.isArray(data)) return;
                comments[postId] = data;
                const cl = document.getElementById('cl-' + postId);
                if (cl) cl.innerHTML = renderCommentsList(postId);
                const cc = document.getElementById('cc-' + postId);
                if (cc) cc.textContent = data.filter(c => !c.parentCommentId).length;
            })
            .catch(() => {});
        }

        // ── Interactions ──
        function toggleLike(id) {
            fetch('LikeHandler.ashx?action=toggle&postId=' + id, { credentials: 'same-origin' })
                .then(r => r.json())
                .then(res => {
                    if (!res.ok) { showToast('Error: ' + res.error); return; }
                    likes[id] = res.liked;
                    likeCounts[id] = res.likeCount;
                    saveState();
                    renderResults();
                    showToast(res.liked ? '❤️ Liked!' : 'Like removed');
                })
                .catch(() => showToast('Could not update like'));
        }

        function pushNotification(msg, icon) {
            const notifArr = JSON.parse(localStorage.getItem('campus_notifications') || '[]');
            notifArr.unshift({ msg, icon: icon || 'fa-bell', time: new Date().toISOString(), read: false });
            if (notifArr.length > 50) notifArr.length = 50;
            localStorage.setItem('campus_notifications', JSON.stringify(notifArr));
            window.dispatchEvent(new StorageEvent('storage', { key: 'campus_notifications', newValue: JSON.stringify(notifArr) }));
        }

        function togglePin(id) {
            pins[id] = !pins[id];
            saveState();
            const ann = announcementsDB.find(a => a.id === id);
            if (ann) pushNotification((pins[id] ? '📌 Pinned: ' : '📌 Unpinned: ') + ann.title, 'fa-thumbtack');
            window.dispatchEvent(new StorageEvent('storage', { key: 'campus_pins', newValue: JSON.stringify(pins) }));
            window.dispatchEvent(new StorageEvent('storage', { key: 'teacher_pins', newValue: JSON.stringify(pins) }));
            renderResults();
            showToast(pins[id] ? '📌 Pinned!' : 'Unpinned');
        }

        function openComments(id) {
            const sec = document.getElementById('cs-' + id);
            if (!sec) return;
            sec.classList.toggle('show');
            if (sec.classList.contains('show')) {
                reloadComments(id);
                const input = document.getElementById('ci-' + id);
                if (input) setTimeout(() => input.focus(), 50);
            }
        }

        function postComment(id) {
            const input = document.getElementById('ci-' + id);
            if (!input) return;
            const text = input.value.trim();
            if (!text) { showToast('Please write a comment first'); return; }

            fetch('CommentHandler.ashx?action=add', {
                credentials: 'same-origin',
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ postId: id, comment: text })
            })
                .then(r => r.json())
                .then(res => {
                    if (!res.success) { showToast('Error: ' + (res.error || 'Could not post comment')); return; }
                    input.value = '';
                    reloadComments(id);
                    showToast('Comment posted!');
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

        // ── Search & Filters ──
        function performSearch() {
            const term = searchInput.value;
            currentSearchTerm = term;
            if (lastSearchHidden) lastSearchHidden.value = term;
            if (term.trim()) addToHistory(term);
            renderResults();
        }

        function applyFilters() {
            // Note: currentDate is set by flatpickr's onChange callback, not dateFilter.value
            // (flatpickr uses altInput so dateFilter.value is always empty)
            currentSort = sortFilter.value;
            renderResults();
        }

        function resetEverything() {
            searchInput.value = '';
            if (window._datePicker) window._datePicker.clear();
            sortFilter.value = 'latest';
            currentSearchTerm = '';
            currentDate = '';
            currentSort = 'latest';
            if (lastSearchHidden) lastSearchHidden.value = '';
            renderResults();
        }

        // ── Init ──
        function init() {
            renderHistory();
            renderPinnedSidebar();
            updateNotifBadge();

            window._datePicker = flatpickr(dateFilter, {
                dateFormat: "Y-m-d",
                altInput: true,
                altFormat: "F j, Y",
                onChange: (_, dateStr) => { currentDate = dateStr || ''; renderResults(); },
                onClear: () => { currentDate = ''; renderResults(); }
            });

            searchInput.addEventListener('input', () => { currentSearchTerm = searchInput.value; renderResults(); });
            searchInput.addEventListener('keypress', e => { if (e.key === 'Enter') performSearch(); });
            sortFilter.addEventListener('change', applyFilters);
            if (resetFiltersBtn) resetFiltersBtn.addEventListener('click', resetEverything);
            if (clearHistoryBtn) clearHistoryBtn.addEventListener('click', checkAndClearHistory);
            if (modalCancel) modalCancel.addEventListener('click', closeConfirmModal);
            if (modalConfirm) modalConfirm.addEventListener('click', executeClearHistory);
            if (infoOkBtn) infoOkBtn.addEventListener('click', closeInfoModal);

            if (confirmModal) confirmModal.addEventListener('click', e => { if (e.target === confirmModal) closeConfirmModal(); });
            if (infoModal) infoModal.addEventListener('click', e => { if (e.target === infoModal) closeInfoModal(); });

            document.addEventListener('keydown', e => {
                if (e.key === 'Escape') {
                    if (confirmModal && confirmModal.classList.contains('active')) closeConfirmModal();
                    if (infoModal && infoModal.classList.contains('active')) closeInfoModal();
                }
            });

            try {
                if (lastSearchHidden && lastSearchHidden.value) {
                    searchInput.value = lastSearchHidden.value;
                    currentSearchTerm = lastSearchHidden.value;
                }
            } catch (e) { }

            fetchAnnouncementsFromAPI();
        }

        init();

        // ════════════════════════════════════════════════════════
        // THEME — sync with campus_theme (storage events from other tabs)
        // ════════════════════════════════════════════════════════
        (function () {
            const KEY = 'campus_theme';
            // SearchDashboard uses teal/light as default — only apply dark class if dark
            function applyTheme(isDark) {
                document.body.classList.toggle('dark-mode', isDark);
                document.body.classList.remove('light-mode'); // never apply light-mode
            }
            applyTheme(localStorage.getItem(KEY) === 'dark');
            window.addEventListener('storage', e => {
                if (e.key === KEY) applyTheme(e.newValue === 'dark');
            });
        })();

        window.addEventListener('storage', e => {
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
                fetchAnnouncementsFromAPI();
            }
            if (e.key === 'campus_notifications') {
                updateNotifBadge();
            }
        });
    </script>
</body>
</html>
