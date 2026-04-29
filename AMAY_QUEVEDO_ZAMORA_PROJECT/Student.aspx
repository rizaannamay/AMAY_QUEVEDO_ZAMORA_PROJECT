<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Student" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Campus Connect - Student Portal</title>
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
            --surface: rgba(255, 255, 255, 0.92);
            --surface-strong: #ffffff;
            --surface-soft: #f8fafc;
            --border: rgba(26, 58, 92, 0.12);
            --primary: #1a3a5c;
            --primary-2: #2c5a7a;
            --muted: #6b7c8f;
            --muted-light: #9db0c4;
            --shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
            --active-bg: #e8f0fe;
        }

        html, body, form { height: auto; min-height: 100%; }
        html, body { overflow: auto; }

        body {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            color: var(--page-text);
            background-image: linear-gradient(rgba(255, 255, 255, 0.3), rgba(255, 255, 255, 0.3)), var(--bg-image);
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            background-attachment: fixed;
            transition: background 0.4s ease, color 0.4s ease;
        }

        a { color: inherit; text-decoration: none; }
        button, input, textarea { font: inherit; }

        .app-shell {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            gap: 10px;
            padding: 16px 20px 20px;
        }

        .header {
            flex: 0 0 auto;
            background: var(--surface);
            backdrop-filter: blur(10px);
            border-radius: 24px;
            padding: 12px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            box-shadow: var(--shadow);
            border: 1px solid var(--border);
        }

        .footer {
            flex: 0 0 34px;
            text-align: center;
            line-height: 34px;
            font-size: 12px;
        }

        form { height: auto; min-height: 100%; overflow: visible; }

        .logo { font-size: 22px; font-weight: 800; color: var(--primary); white-space: nowrap; cursor: pointer; }
        .logo i { color: var(--primary); margin-right: 8px; }

        .search-container {
            display: flex;
            gap: 10px;
            align-items: center;
            flex: 1;
            justify-content: center;
            min-width: 0;
        }

        .search-box {
            background: var(--surface-soft);
            border-radius: 30px;
            padding: 10px 18px;
            width: min(100%, 320px);
            display: flex;
            align-items: center;
            gap: 10px;
            border: 1px solid rgba(26,58,92,0.2);
        }
        .search-box input {
            background: none;
            border: none;
            outline: none;
            width: 100%;
            font-size: 14px;
            color: var(--page-text);
        }

        .search-box input::placeholder { color: var(--muted-light); }
        .search-box i, .bell-icon { color: var(--primary); }

        .search-btn {
            background: none;
            border: 1px solid rgba(26,58,92,0.25);
            border-radius: 30px;
            padding: 10px 22px;
            color: var(--primary);
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .search-btn:hover {
            background: #e8f0fe;
            border-color: rgba(26,58,92,0.4);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        .header-actions {
            display: flex;
            gap: 15px;
            align-items: center;
            white-space: nowrap;
        }

        .notification-bell {
            position: relative;
            cursor: pointer;
            background: var(--surface-soft);
            width: 42px;
            height: 42px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid rgba(26,58,92,0.15);
            transition: background 0.3s;
        }

        .notification-bell:hover { background: var(--active-bg); }

        .badge-red {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #dc2626;
            color: #ffffff;
            font-size: 10px;
            font-weight: bold;
            padding: 2px 6px;
            border-radius: 50%;
            min-width: 18px;
            text-align: center;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
            background: rgba(255,255,255,0.85);
            padding: 6px 18px;
            border-radius: 40px;
            border: 1.5px solid rgba(26,58,92,0.18);
            cursor: pointer;
            position: relative;
            transition: background 0.2s;
        }
        .user-info:hover { background: rgba(255,255,255,1); }

        /* HAMBURGER MENU BUTTON - New addition */
        .hamburger-menu-btn {
            background: var(--surface-soft);
            border: 1px solid var(--border);
            width: 44px;
            height: 44px;
            border-radius: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s ease;
            font-size: 20px;
            color: var(--primary);
        }
        .hamburger-menu-btn:hover {
            background: var(--active-bg);
            transform: scale(0.98);
        }

        /* SLIDE-OUT PANEL (Right Side) */
        .slideout-panel {
            position: fixed;
            top: 0;
            right: -380px;
            width: 360px;
            max-width: 85vw;
            height: 100vh;
            background: var(--surface-strong);
            backdrop-filter: blur(16px);
            box-shadow: -8px 0 32px rgba(0, 0, 0, 0.2);
            z-index: 1100;
            transition: right 0.3s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            display: flex;
            flex-direction: column;
            border-left: 1px solid var(--border);
        }
        .slideout-panel.open {
            right: 0;
        }
        .panel-header {
            padding: 24px 20px 16px;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .panel-header h3 {
            font-size: 20px;
            font-weight: 700;
            color: var(--primary);
            margin: 0;
        }
        .panel-close {
            background: none;
            border: none;
            font-size: 26px;
            cursor: pointer;
            color: var(--muted);
            line-height: 1;
            padding: 0 8px;
        }
        .panel-close:hover { color: #dc2626; }
        .panel-menu-list {
            flex: 1;
            overflow-y: auto;
            padding: 16px 0;
        }
        .panel-menu-item {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 14px 24px;
            cursor: pointer;
            width: 100%;
            border: none;
            background: none;
            text-align: left;
            font-size: 15px;
            font-weight: 500;
            color: var(--page-text);
            transition: all 0.2s;
            border-left: 3px solid transparent;
        }
        .panel-menu-item i {
            width: 24px;
            font-size: 18px;
            color: var(--primary);
        }
        .panel-menu-item:hover {
            background: var(--surface-soft);
            color: var(--primary);
        }
        .category-dropdown-panel {
            margin-left: 52px;
            margin-bottom: 12px;
            display: none;
            flex-direction: column;
            gap: 6px;
        }
        .dropdown-item-panel {
            background: none;
            border: none;
            text-align: left;
            padding: 8px 12px;
            cursor: pointer;
            width: 100%;
            font-size: 14px;
            color: var(--page-text);
            border-radius: 12px;
            transition: all 0.2s;
        }
        .dropdown-item-panel:hover {
            background: var(--surface-soft);
            color: var(--primary);
        }
        .theme-toggle-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%;
        }
        .theme-toggle-row .toggle-switch-panel {
            width: 44px;
            height: 22px;
            background: #dce4ec;
            border-radius: 30px;
            position: relative;
            cursor: pointer;
            transition: all 0.3s;
        }
        .theme-toggle-row .toggle-switch-panel.active {
            background: linear-gradient(135deg, var(--primary), var(--primary-2));
        }
        .theme-toggle-row .toggle-switch-panel::after {
            content: '';
            width: 18px;
            height: 18px;
            background: #ffffff;
            border-radius: 50%;
            position: absolute;
            top: 2px;
            left: 2px;
            transition: all 0.3s;
        }
        .theme-toggle-row .toggle-switch-panel.active::after {
            left: 24px;
        }
        .divider-light {
            height: 1px;
            background: var(--border);
            margin: 8px 20px;
        }
        .overlay-black {
            display: none !important;
            pointer-events: none !important;
        }

        .avatar, .profile-avatar, .post-avatar {
            background: linear-gradient(135deg, var(--primary), var(--primary-2));
            color: #ffffff;
        }

        .avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        .user-name { font-size: 14px; font-weight: 600; }
        .user-role, .profile-email, .post-meta, .comment-time, .footer { color: var(--muted); }

        .content-shell {
            flex: 1 1 0;
            min-height: 0;
            display: grid;
            grid-template-columns: 1fr;
            gap: 25px;
            align-items: stretch;
        }

        .card {
            background: var(--surface);
            backdrop-filter: blur(10px);
            border-radius: 24px;
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            overflow: visible;
        }

        .main-panel.card {
            min-height: 600px;
            display: flex;
            flex-direction: column;
        }

        .card-header {
            padding: 18px 22px;
            border-bottom: 1px solid rgba(26,58,92,0.08);
            font-weight: 700;
            color: var(--primary);
            font-size: 16px;
        }

        .card-header i { margin-right: 10px; color: var(--primary); }

        .announcement-board {
            flex: 1 1 auto;
            min-height: 0;
            overflow-y: auto;
            padding: 18px;
            background: rgba(248, 250, 252, 0.35);
        }

        .announcement-card {
            background: var(--surface-strong);
            border-radius: 20px;
            margin-bottom: 20px;
            border: 1px solid #3B82F6;
            transition: all 0.3s;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
            overflow: hidden;
        }

        .announcement-card:hover {
            box-shadow: 0 8px 18px rgba(0, 0, 0, 0.08);
            border-color: #1E3A8A;
        }

        .post-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 18px 22px 12px;
        }

        .post-header-left { display: flex; align-items: center; gap: 15px; }

        .post-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            font-weight: bold;
            flex-shrink: 0;
        }

        .post-author { font-weight: 700; font-size: 16px; color: var(--primary); }

        .post-meta {
            display: flex;
            gap: 12px;
            font-size: 12px;
            margin-top: 4px;
            flex-wrap: wrap;
        }

        .post-category {
            display: inline-block;
            padding: 2px 10px;
            border-radius: 20px;
            font-size: 10px;
            font-weight: 600;
        }

        .post-category-exam { background: #e3f2fd; color: #1976d2; }
        .post-category-suspension { background: #ffebee; color: #c62828; }
        .post-category-event { background: #e8f5e9; color: #2e7d32; }
        .post-category-general { background: #e0e7ff; color: #4f46e5; }

        .pin-btn-top {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 18px;
            color: var(--muted-light);
            padding: 8px;
            border-radius: 50%;
            transition: all 0.3s;
            width: 36px;
            height: 36px;
        }

        .pin-btn-top:hover { background: #f0f2f5; }
        .pin-btn-top.pinned { color: #e65100; }

        .post-content { padding: 0 22px 16px; }
        .post-title { font-size: 18px; font-weight: 700; margin-bottom: 10px; color: var(--primary); }
        .post-text, .comment-text, .notification-text { color: var(--page-text); line-height: 1.5; }

        .post-image {
            margin-top: 12px;
            border-radius: 16px;
            overflow: hidden;
            max-width: 100%;
        }

        .post-image img {
            width: 100%;
            max-height: 300px;
            object-fit: cover;
            border-radius: 16px;
            display: block;
        }

        .post-stats {
            display: flex;
            gap: 20px;
            padding: 10px 22px;
            border-top: 1px solid rgba(26,58,92,0.08);
            border-bottom: 1px solid rgba(26,58,92,0.08);
            color: var(--muted);
            font-size: 13px;
        }

        .post-stats span { display: flex; align-items: center; gap: 6px; cursor: pointer; }
        .post-stats span:hover { color: var(--primary); }

        .action-buttons {
            display: flex;
            gap: 5px;
            padding: 8px 22px;
        }

        .action-btn {
            flex: 1;
            background: none;
            border: none;
            padding: 10px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 14px;
            color: var(--muted);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.3s;
        }

        .action-btn.liked { color: #dc2626; }
        .action-btn.liked i { font-weight: 900; }

        .comments-section {
            padding: 0 22px 18px;
            border-top: 1px solid rgba(26,58,92,0.08);
            display: none;
        }

        .comments-section.show { display: block; }

        .comment-input {
            display: flex;
            gap: 10px;
            margin: 15px 0;
        }

        .comment-input input {
            flex: 1;
            padding: 10px 16px;
            background: var(--surface-soft);
            border: 1px solid rgba(26,58,92,0.15);
            border-radius: 30px;
            outline: none;
            font-size: 13px;
            color: var(--page-text);
        }

        .comment-input button {
            padding: 10px 22px;
            background: linear-gradient(135deg, var(--primary), var(--primary-2));
            border: none;
            border-radius: 30px;
            cursor: pointer;
            font-weight: 600;
            color: white;
        }

        .comment {
            padding: 10px 0;
            font-size: 13px;
            border-bottom: 1px solid rgba(26,58,92,0.08);
            display: flex;
            gap: 10px;
        }

        .comment:last-child { border-bottom: none; }

        .comment-avatar {
            width: 32px;
            height: 32px;
            background: #e8f0fe;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            color: var(--primary);
            font-weight: bold;
            flex-shrink: 0;
        }

        .comment-author { font-weight: bold; color: var(--primary); }

        .no-comments {
            padding: 15px;
            text-align: center;
            color: var(--muted-light);
            font-size: 12px;
        }

        .notification-dropdown {
            position: absolute;
            top: 84px;
            right: 20px;
            width: 320px;
            background: var(--surface-strong);
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            border: 1px solid var(--border);
            z-index: 200;
            display: none;
        }

        .notification-dropdown.show { display: block; }

        .modal {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .modal-content {
            background: var(--surface-strong);
            border-radius: 24px;
            max-width: 400px;
            width: 100%;
            padding: 30px;
            text-align: center;
        }

        /* Dark Mode */
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
            --active-bg: rgba(59, 130, 246, 0.2);
        }

        body.dark-mode {
            background-image: linear-gradient(rgba(15, 23, 42, 0.85), rgba(15, 23, 42, 0.85)), url('bg.jpg');
            background-color: #0f172a;
            color: var(--page-text);
        }

        /* Cards & surfaces */
        body.dark-mode .announcement-card  { 
            background: rgba(30, 41, 59, 0.95); 
            border-color: #3B82F6;
        }
        body.dark-mode .announcement-card:hover {
            border-color: #60a5fa;
            background: rgba(30, 41, 59, 1);
        }
        body.dark-mode .card               { 
            background: rgba(30, 41, 59, 0.95); 
            border-color: rgba(148, 163, 184, 0.2); 
        }
        body.dark-mode .header             { 
            background: rgba(30, 41, 59, 0.95); 
            border-color: rgba(148, 163, 184, 0.2); 
        }

        /* Text */
        body.dark-mode .post-author,
        body.dark-mode .post-title         { color: #e0e7ff; }
        body.dark-mode .post-text,
        body.dark-mode .comment-text,
        body.dark-mode .notification-text  { color: #e2e8f0; }
        body.dark-mode .post-meta,
        body.dark-mode .post-stats,
        body.dark-mode .post-stats span,
        body.dark-mode .action-btn,
        body.dark-mode .comment-time,
        body.dark-mode .no-comments        { color: #cbd5e1; }
        body.dark-mode .comment-author     { color: #c7d2fe; }
        body.dark-mode .card-header        { color: #e0e7ff; border-bottom-color: rgba(148, 163, 184, 0.2); }
        body.dark-mode .logo               { color: #e0e7ff; }
        body.dark-mode .user-name          { color: #f1f5f9; }
        body.dark-mode .user-role          { color: #cbd5e1; }

        /* Slideout panel */
        body.dark-mode .slideout-panel     { 
            background: rgba(30, 41, 59, 0.98); 
            border-color: rgba(148, 163, 184, 0.2); 
        }
        body.dark-mode .panel-header h3    { color: #e0e7ff; }
        body.dark-mode .panel-menu-item    { color: #e2e8f0; }
        body.dark-mode .panel-menu-item i  { color: #93c5fd; }
        body.dark-mode .panel-menu-item:hover { 
            background: rgba(59, 130, 246, 0.2); 
            color: #ffffff; 
        }
        body.dark-mode .dropdown-item-panel { color: #e2e8f0; }
        body.dark-mode .dropdown-item-panel:hover { 
            background: rgba(59, 130, 246, 0.2); 
            color: #ffffff; 
        }
        body.dark-mode .divider-light      { background: rgba(148, 163, 184, 0.2); }

        /* Inputs & comment box */
        body.dark-mode .comment-input input { 
            background: rgba(51, 65, 85, 0.6); 
            border-color: rgba(148, 163, 184, 0.3); 
            color: #f1f5f9; 
        }
        body.dark-mode .comment-input input::placeholder { color: #94a3b8; }
        
        body.dark-mode .search-box {
            background: rgba(51, 65, 85, 0.6);
            border-color: rgba(148, 163, 184, 0.3);
        }
        body.dark-mode .search-box input {
            color: #f1f5f9;
        }
        body.dark-mode .search-box input::placeholder {
            color: #94a3b8;
        }

        /* Category badges */
        body.dark-mode .post-category-exam       { background: rgba(59, 130, 246, 0.25);  color: #93c5fd; }
        body.dark-mode .post-category-suspension { background: rgba(239, 68, 68, 0.25);   color: #fca5a5; }
        body.dark-mode .post-category-event      { background: rgba(34, 197, 94, 0.25);   color: #86efac; }
        body.dark-mode .post-category-general    { background: rgba(139, 92, 246, 0.25);  color: #c4b5fd; }
        body.dark-mode .pin-btn-top.pinned        { color: #fb923c; }

        /* Search button */
        body.dark-mode .search-btn { 
            border-color: rgba(148, 163, 184, 0.3); 
            color: #e2e8f0;
            background: rgba(51, 65, 85, 0.4);
        }
        body.dark-mode .search-btn:hover {
            background: rgba(59, 130, 246, 0.2);
            border-color: #3B82F6;
        }

        /* Notification bell */
        body.dark-mode .notification-bell {
            background: rgba(51, 65, 85, 0.6);
            border-color: rgba(148, 163, 184, 0.3);
        }
        body.dark-mode .notification-bell:hover {
            background: rgba(59, 130, 246, 0.2);
        }
        
        /* User info */
        body.dark-mode .user-info {
            background: rgba(51, 65, 85, 0.6);
            border-color: rgba(148, 163, 184, 0.3);
        }
        body.dark-mode .user-info:hover {
            background: rgba(51, 65, 85, 0.8);
        }
        
        /* Hamburger menu */
        body.dark-mode .hamburger-menu-btn {
            background: rgba(51, 65, 85, 0.6);
            border-color: rgba(148, 163, 184, 0.3);
            color: #93c5fd;
        }
        body.dark-mode .hamburger-menu-btn:hover {
            background: rgba(59, 130, 246, 0.2);
        }

        /* Profile modal */
        body.dark-mode .modal-content  { 
            background: rgba(30, 41, 59, 0.98); 
            border: 1px solid rgba(148, 163, 184, 0.2); 
        }
        body.dark-mode .modal-title    { color: #e0e7ff; }
        body.dark-mode .modal-text     { color: #cbd5e1; }
        
        /* Action buttons in dark mode */
        body.dark-mode .action-btn:hover {
            background: rgba(59, 130, 246, 0.15);
            color: #93c5fd;
        }
        
        /* Comment avatar */
        body.dark-mode .comment-avatar {
            background: rgba(59, 130, 246, 0.2);
            color: #93c5fd;
        }
        
        /* Post avatar */
        body.dark-mode .post-avatar {
            background: linear-gradient(135deg, #3B82F6, #60a5fa);
        }
        
        /* Announcement board background */
        body.dark-mode .announcement-board {
            background: rgba(15, 23, 42, 0.4);
        }

        @media (max-width: 980px) {
            html, body { overflow: auto; }
            .app-shell { height: auto; min-height: 100%; overflow: visible; }
            .content-shell { overflow: visible; }
            .announcement-board { overflow: visible; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="app-shell">
            <div class="header">
                <button type="button" class="logo" onclick="navigateWithFlip('Student.aspx')">
                    <i class="fas fa-university"></i> CampusAnnouncement
                </button>

                <div class="search-container">
                    <asp:Button ID="searchButton" runat="server" CssClass="search-btn" Text="🔎 Search........" OnClientClick="navigateWithFlip('SearchStudent.aspx'); return false;" Width="420px" Font-Bold="False" Font-Size="Medium" Height="54px" UseSubmitBehavior="false" />
                </div>

                <div class="header-actions">
                    <button type="button" class="notification-bell" onclick="navigateWithFlip('Notifications.aspx')">
                        <i class="fas fa-bell bell-icon"></i>
                        <span id="notificationBadge" class="badge-red" style="display:none;">0</span>
                    </button>
                    <button type="button" class="user-info" onclick="window.location.href='Profile.aspx'">
                        <div class="avatar" id="headerAvatar" style="overflow:hidden;">
                            <% if (!string.IsNullOrEmpty(Session["ProfileImage"]?.ToString())) { %>
                                <img src="<%= Session["ProfileImage"] %>" alt="Profile"
                                     style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;" />
                            <% } else { %>
                                <i class="fas fa-user"></i>
                            <% } %>
                        </div>
                        <div class="user-details">
                            <div class="user-name" id="userName"><%= Session["FullName"] ?? "User" %></div>
                            <div class="user-role" id="userRole"><%= Session["Role"] ?? "Student" %></div>
                        </div>
                    </button>
                    <!-- HAMBURGER MENU ICON - right side of profile -->
                    <button type="button" class="hamburger-menu-btn" id="hamburgerBtn">
                        <i class="fas fa-bars"></i>
                    </button>
                </div>
            </div>

            <!-- SLIDE-OUT PANEL with Filters & Settings -->
            <div id="slideoutPanel" class="slideout-panel">
                <div class="panel-header">
                    <h3><i class="fas fa-sliders-h"></i> Menu</h3>
                    <button type="button" class="panel-close" id="closePanelBtn">&times;</button>
                </div>
                <div class="panel-menu-list">
                    <button type="button" class="panel-menu-item" id="filterCategoryBtn">
                        <i class="fas fa-layer-group"></i> Filter by Category
                    </button>
                    <div id="categoryDropdownPanel" class="category-dropdown-panel">
                        <button type="button" class="dropdown-item-panel" data-filter="All"        onclick="filterCategory('All'); event.stopPropagation();"><i class="fas fa-th-list"></i> All Announcements</button>
                        <button type="button" class="dropdown-item-panel" data-filter="Exam"       onclick="filterCategory('Exam'); event.stopPropagation();"><i class="fas fa-file-alt"></i> Exam Schedule</button>
                        <button type="button" class="dropdown-item-panel" data-filter="Suspension" onclick="filterCategory('Suspension'); event.stopPropagation();"><i class="fas fa-cloud-rain"></i> Class Suspension</button>
                        <button type="button" class="dropdown-item-panel" data-filter="Event"      onclick="filterCategory('Event'); event.stopPropagation();"><i class="fas fa-calendar-alt"></i> Campus Events</button>
                        <button type="button" class="dropdown-item-panel" data-filter="General"    onclick="filterCategory('General'); event.stopPropagation();"><i class="fas fa-bullhorn"></i> General</button>
                    </div>
                    <button type="button" class="panel-menu-item" onclick="navigateWithFlip('Pinned.aspx');">
                        <i class="fas fa-thumbtack"></i> Pinned Announcements
                    </button>
                    <div class="divider-light"></div>
                    <button type="button" class="panel-menu-item" id="settingsThemeBtn">
                        <div class="theme-toggle-row" style="width:100%;">
                            <span><i class="fas fa-moon"></i> Dark / Light Mode</span>
                            <div class="toggle-switch-panel" id="panelThemeToggle"></div>
                        </div>
                    </button>
                    <button type="button" class="panel-menu-item" onclick="navigateWithFlip('AboutUs.aspx');">
                        <i class="fas fa-info-circle"></i> About Us
                    </button>
                </div>
            </div>
            <div id="overlay" class="overlay-black" style="display:none!important;pointer-events:none;"></div>

            <div class="content-shell">
                <main class="main-panel card">
                    <div class="card-header">
                        <i class="fas fa-bullhorn"></i> Announcement Board
                        <span class="header-filter" style="float:right;">Showing: <span id="activeFilterLabel">All</span></span>
                    </div>
                    <div id="announcementsContainer" class="announcement-board">
                        <div style="text-align:center;padding:40px;">Loading announcements...</div>
                    </div>
                </main>
            </div>
        </div>

        <!-- Profile Modal -->
        <div id="profileModal" class="modal" style="display:none;">
            <div class="modal-content" style="max-width:420px;text-align:left;">
                <div style="text-align:center;margin-bottom:20px;">
                    <div style="width:72px;height:72px;border-radius:50%;background:linear-gradient(135deg,#1e3a8a,#2563eb);color:#fff;display:flex;align-items:center;justify-content:center;font-size:28px;margin:0 auto 12px;">
                        <i class="fas fa-user"></i>
                    </div>
                    <div class="modal-title" style="margin-bottom:4px;" id="pm-fullname"><%= Session["FullName"] ?? "User" %></div>
                    <span style="display:inline-block;padding:3px 14px;border-radius:20px;font-size:11px;font-weight:700;background:#DBEAFE;color:#1E3A8A;" id="pm-role"><%= Session["Role"] ?? "Student" %></span>
                </div>
                <div style="display:flex;flex-direction:column;gap:12px;margin-bottom:24px;">
                    <div style="display:flex;align-items:center;gap:12px;padding:12px 16px;background:var(--surface-soft);border-radius:12px;"><i class="fas fa-user" style="color:var(--primary);"></i><div><div style="font-size:11px;color:var(--muted);">Username</div><div style="font-weight:600;" id="pm-username"><%= Session["Username"] ?? "User" %></div></div></div>
                    <div style="display:flex;align-items:center;gap:12px;padding:12px 16px;background:var(--surface-soft);border-radius:12px;"><i class="fas fa-envelope" style="color:var(--primary);"></i><div><div style="font-size:11px;color:var(--muted);">Email</div><div style="font-weight:600;" id="pm-email"><%= Session["Email"] ?? "student@ctu.edu" %></div></div></div>
                </div>
                <div style="display:flex;gap:10px;">
                    <button onclick="closeProfileModal()" style="flex:1;padding:12px;border:1px solid var(--border);border-radius:12px;background:none;cursor:pointer;">Close</button>
                    <button onclick="logout()" style="flex:1;padding:12px;border:none;border-radius:12px;background:#fef2f2;color:#dc2626;cursor:pointer;"><i class="fas fa-sign-out-alt"></i> Logout</button>
                </div>
            </div>
        </div>

        <!-- About Modal -->
        <div id="aboutModal" class="modal">
            <div class="modal-content">
                <div class="modal-icon"><i class="fas fa-university" style="font-size:48px;color:var(--primary);"></i></div>
                <div class="modal-title">Campus Connect</div>
                <div class="modal-text">Centralized announcement system for Cebu Technological University.</div>
                <button onclick="closeAboutModal()" style="margin-top:16px;padding:8px 24px;border-radius:30px;border:none;background:var(--primary);color:white;cursor:pointer;">Close</button>
            </div>
        </div>
    </form>

    <script>
        // ====================== GLOBAL STATE & HELPERS ======================
        let st_likes = {}, st_likeCounts = {}, st_pins = {}, st_comments = {};

        function showToast(msg) {
            let t = document.createElement('div');
            t.innerText = msg;
            t.style.cssText = 'position:fixed;bottom:30px;left:50%;transform:translateX(-50%);background:#1a3a5c;color:#fff;padding:8px 20px;border-radius:30px;z-index:9999';
            document.body.appendChild(t);
            setTimeout(() => t.remove(), 2500);
        }

        function escapeHtml(str) { if (!str) return ''; return str.replace(/[&<>]/g, m => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;' })[m]); }

        // ====================== SLIDE-OUT CONTROLS ======================
        function openSlideout() {
            document.getElementById('slideoutPanel').classList.add('open');
        }
        function closeSlideout() {
            document.getElementById('slideoutPanel').classList.remove('open');
        }

        // Hamburger toggles the panel open/closed
        document.getElementById('hamburgerBtn').addEventListener('click', function (e) {
            e.stopPropagation();
            let panel = document.getElementById('slideoutPanel');
            if (panel.classList.contains('open')) closeSlideout();
            else openSlideout();
        });

        // X button closes the panel
        document.getElementById('closePanelBtn').addEventListener('click', closeSlideout);

        // Category dropdown toggle inside panel — stays open
        document.getElementById('filterCategoryBtn').addEventListener('click', function (e) {
            e.stopPropagation();
            let panel = document.getElementById('categoryDropdownPanel');
            panel.style.display = panel.style.display === 'flex' ? 'none' : 'flex';
        });

        // Theme toggle from panel — stays open
        document.getElementById('settingsThemeBtn').addEventListener('click', function (e) {
            e.stopPropagation();
            toggleTheme();
        });

        // ====================== FILTER FUNCTION ======================
        function filterCategory(category) {
            localStorage.setItem('student_filter', category);

            // Update label
            let label = document.getElementById('activeFilterLabel');
            if (label) label.innerText = category;

            // Show/hide cards
            document.querySelectorAll('.announcement-card').forEach(card => {
                let cat = card.getAttribute('data-category') || '';
                let show = category === 'All' || cat === category;
                card.style.display = show ? '' : 'none';
            });

            // Highlight active dropdown button
            document.querySelectorAll('[data-filter]').forEach(btn => {
                let val = btn.getAttribute('data-filter');
                btn.style.fontWeight = val === category ? '700' : '';
                btn.style.color = val === category ? 'var(--primary)' : '';
            });
        }

        // ====================== THEME ======================
        function applyTheme(isDark) {
            document.body.classList.toggle('dark-mode', isDark);
            document.querySelectorAll('.toggle-switch-panel, #panelThemeToggle').forEach(el => el.classList.toggle('active', isDark));
        }

        function toggleTheme() {
            let isDark = !document.body.classList.contains('dark-mode');
            localStorage.setItem('campus_theme', isDark ? 'dark' : 'light');
            applyTheme(isDark);
        }

        // Apply saved theme immediately on load
        applyTheme(localStorage.getItem('campus_theme') === 'dark');

        // Sync theme across pages/tabs via storage event
        window.addEventListener('storage', function (e) {
            if (e.key === 'campus_theme') applyTheme(e.newValue === 'dark');
        });

        // ====================== MODALS ======================
        function openProfileModal(e) { if (e) e.stopPropagation(); document.getElementById('profileModal').style.display = 'flex'; }
        function closeProfileModal() { document.getElementById('profileModal').style.display = 'none'; }
        function openAboutModal() { document.getElementById('aboutModal').style.display = 'flex'; }
        function closeAboutModal() { document.getElementById('aboutModal').style.display = 'none'; }
        function logout() { window.location.href = 'Logout.aspx'; }

        // Click outside modals closes them
        document.addEventListener('click', function (e) {
            let pm = document.getElementById('profileModal');
            if (pm && pm.style.display === 'flex' && e.target === pm) pm.style.display = 'none';
            let am = document.getElementById('aboutModal');
            if (am && am.style.display === 'flex' && e.target === am) am.style.display = 'none';
        });

        // ====================== COMMENT & LIKE HANDLERS ======================
        function toggleLike(postId) {
            fetch('LikeHandler.ashx?action=toggle&postId=' + postId, { credentials: 'same-origin' })
                .then(r => r.json())
                .then(res => {
                    if (!res.ok) {
                        showToast('Error: ' + (res.error || 'Could not update like'));
                        return;
                    }
                    st_likes[postId] = res.liked;
                    st_likeCounts[postId] = res.likeCount;
                    let card = document.querySelector(`.announcement-card[data-post-id="${postId}"]`);
                    if (card) {
                        let likeSpan = card.querySelector('.like-count');
                        if (likeSpan) likeSpan.textContent = res.likeCount;
                        let likeBtn = card.querySelector('.action-btn.like-btn');
                        if (likeBtn) {
                            likeBtn.className = 'action-btn like-btn' + (res.liked ? ' liked' : '');
                            likeBtn.innerHTML = `<i class="${res.liked ? 'fas' : 'far'} fa-heart"></i> ${res.liked ? 'Liked' : 'Like'}`;
                        }
                        let statsSpan = card.querySelector('.post-stats span:first-child i');
                        if (statsSpan) statsSpan.className = res.liked ? 'fas fa-heart' : 'far fa-heart';
                    }
                    showToast(res.liked ? '❤️ Liked!' : 'Like removed');
                })
                .catch(err => {
                    console.error('Like error:', err);
                    showToast('Could not update like');
                });
        }

        function togglePin(postId) {
            st_pins[postId] = !st_pins[postId];
            if (!st_pins[postId]) delete st_pins[postId];
            localStorage.setItem('student_pins', JSON.stringify(st_pins));
            renderAnnouncements();
            showToast(st_pins[postId] ? '📌 Pinned!' : '📌 Unpinned');

        }

        console.log('Pin successful! isPinned:', res.isPinned);

        if (res.isPinned) st_pins[postId] = true;
        else delete st_pins[postId];

        // Update localStorage to trigger storage event for other tabs/pages
        localStorage.setItem('campus_pins', JSON.stringify(st_pins));
        localStorage.setItem('teacher_pins', JSON.stringify(st_pins));
        console.log('Updated localStorage pins:', st_pins);

        let card = document.querySelector(`.announcement-card[data-post-id="${postId}"]`);
        if (card) {
            let pinBtn = card.querySelector('.pin-btn-top');
            if (pinBtn) {
                pinBtn.style.color = res.isPinned ? '#e65100' : 'var(--muted-light)';
                pinBtn.innerHTML = `<i class="${res.isPinned ? 'fas' : 'far'} fa-thumbtack"></i>`;
                pinBtn.title = res.isPinned ? 'Unpin' : 'Pin';
                console.log('Updated pin button UI');
            } else {
                console.warn('Pin button not found in card');
            }
        } else {
            console.warn('Card not found for postId:', postId);
        }

        // Re-apply current filter so Pinned view updates immediately
        let currentFilter = localStorage.getItem('student_filter') || 'All';
        filterCategory(currentFilter);
        showToast(res.isPinned ? '📌 Pinned!' : 'Unpinned');
                })
                .catch (err => {
            console.error('Pin error:', err);
            showToast('Could not update pin: ' + err.message);
        });
        }

        function toggleCommentSection(postId) {
            let sec = document.getElementById('commentsSection_' + postId);
            if (sec) {
                let isHidden = sec.style.display === 'none' || sec.style.display === '';
                sec.style.display = isHidden ? 'block' : 'none';
                if (isHidden) loadCommentsFromDB(postId);
            }
        }

        function loadCommentsFromDB(postId) {
            let listDiv = document.getElementById('commentsList_' + postId);
            if (!listDiv) return;
            listDiv.innerHTML = '<div style="text-align:center;padding:10px;"><i class="fas fa-spinner fa-spin"></i></div>';
            fetch('CommentHandler.ashx?action=get&postId=' + postId, { credentials: 'same-origin' })
                .then(r => r.json())
                .then(comments => {
                    if (!comments.length) { listDiv.innerHTML = '<div class="no-comments">No comments yet.</div>'; return; }
                    listDiv.innerHTML = comments.map(c => `<div class="comment"><div class="comment-avatar"><i class="fas fa-user"></i></div><div><span class="comment-author">${escapeHtml(c.author)}</span><div class="comment-text">${escapeHtml(c.text)}</div><div class="comment-time">${escapeHtml(c.date)}</div></div></div>`).join('');
                })
                .catch(err => {
                    console.error('Load comments error:', err);
                    listDiv.innerHTML = '<div class="no-comments">Could not load comments</div>';
                });
        }

        function addComment(btn, postId) {
            let input = document.getElementById('commentInput_' + postId);
            let text = input.value.trim();
            if (!text) return showToast('Write a comment');
            fetch('CommentHandler.ashx?action=add', {
                method: 'POST', credentials: 'same-origin',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ postId: postId, comment: text })
            }).then(r => r.json()).then(res => {
                if (res.success) {
                    input.value = '';
                    loadCommentsFromDB(postId);
                    let countSpan = document.querySelector(`.announcement-card[data-post-id="${postId}"] .comment-count`);
                    if (countSpan) countSpan.textContent = parseInt(countSpan.textContent || 0) + 1;
                    showToast('💬 Comment added');
                } else {
                    showToast('Error: ' + (res.error || 'Could not add comment'));
                }
            }).catch(err => {
                console.error('Add comment error:', err);
                showToast('Could not add comment');
            });
        }

        function sharePost(postId) {
            let url = window.location.href.split('?')[0];
            if (navigator.clipboard) {
                navigator.clipboard.writeText(url).then(() => {
                    showToast('🔗 Link copied!');
                }).catch(() => {
                    showToast('📤 Shared!');
                });
            } else {
                showToast('📤 Shared!');
            }
        }

        // ====================== RENDER ANNOUNCEMENTS FROM API ======================
        function renderAnnouncements() {
            let container = document.getElementById('announcementsContainer');
            if (!container) return;

            fetch('AnnouncementHandler.ashx?action=getAll', { credentials: 'same-origin' })
                .then(r => r.json())
                .then(res => {
                    if (!res.ok) { container.innerHTML = '<div style="padding:40px;text-align:center;">Error loading</div>'; return; }
                    let announcements = res.data;
                    if (!announcements.length) { container.innerHTML = '<div style="padding:40px;text-align:center;">No announcements</div>'; return; }

                    // Load pins from localStorage first, then build + filter in one shot — zero flicker
                    try {
                        var savedPins = JSON.parse(localStorage.getItem('student_pins') || '{}');
                        st_pins = savedPins || {};
                    } catch (e) {
                        st_pins = {};
                    }
                    setTimeout(function () {
                        let savedFilter = localStorage.getItem('student_filter') || 'All';

                        container.innerHTML = announcements.map(post => {
                            let isPinned = !!st_pins[post.id];
                            let likeCount = post.likeCount || 0;
                            let catClass = post.category === 'Exam' ? 'post-category-exam'
                                : post.category === 'Suspension' ? 'post-category-suspension'
                                    : post.category === 'Event' ? 'post-category-event'
                                        : 'post-category-general';

                            // Determine visibility before rendering — no flicker
                            let visible = savedFilter === 'All' || post.category === savedFilter;

                            return `<div class="announcement-card" data-post-id="${post.id}" data-category="${post.category}" style="${visible ? '' : 'display:none'}">
                                    <div class="post-header">
                                        <div class="post-header-left">
                                            <div class="post-avatar"><i class="fas fa-user-tie"></i></div>
                                            <div>
                                                <div class="post-author">${escapeHtml(post.author)}</div>
                                                <div class="post-meta"><span>${escapeHtml(post.date)}</span><span class="post-category ${catClass}">${escapeHtml(post.category)}</span></div>
                                            </div>
                                        </div>
                                        <button type="button" class="pin-btn-top ${isPinned ? 'pinned' : ''}" style="color:${isPinned ? '#e65100' : 'var(--muted-light)'}" onclick="togglePin(${post.id})"><i class="${isPinned ? 'fas' : 'far'} fa-thumbtack"></i></button>
                                    </div>
                                    <div class="post-content">
                                        <div class="post-title">${escapeHtml(post.title)}</div>
                                        <div class="post-text">${escapeHtml(post.content)}</div>
                                        ${post.imageUrl ? `<div class="post-image"><img src="${escapeHtml(post.imageUrl)}" onerror="this.style.display='none'"/></div>` : ''}
                                    </div>
                                    <div class="post-stats">
                                        <span onclick="toggleLike(${post.id})"><i class="far fa-heart"></i> <span class="like-count">${likeCount}</span> Likes</span>
                                        <span onclick="toggleCommentSection(${post.id})"><i class="far fa-comment"></i> <span class="comment-count">${post.commentCount || 0}</span> Comments</span>
                                        <span onclick="sharePost(${post.id})"><i class="far fa-share-square"></i> Share</span>
                                    </div>
                                    <div class="action-buttons">
                                        <button type="button" class="action-btn like-btn" onclick="toggleLike(${post.id})"><i class="far fa-heart"></i> Like</button>
                                        <button type="button" class="action-btn" onclick="toggleCommentSection(${post.id})"><i class="far fa-comment"></i> Comment</button>
                                        <button type="button" class="action-btn" onclick="sharePost(${post.id})"><i class="fas fa-share-alt"></i> Share</button>
                                    </div>
                                    <div class="comments-section" id="commentsSection_${post.id}" style="display:none;">
                                        <div class="comment-input">
                                            <input type="text" id="commentInput_${post.id}" placeholder="Write a comment..." />
                                            <button type="button" onclick="addComment(this, ${post.id})">Post</button>
                                        </div>
                                        <div class="comments-list" id="commentsList_${post.id}"><div class="no-comments">No comments yet.</div></div>
                                    </div>
                                </div>`;
                        }).join('');

                        // Update filter label and highlight active button
                        let label = document.getElementById('activeFilterLabel');
                        if (label) label.innerText = savedFilter;
                        document.querySelectorAll('.dropdown-item-panel').forEach(btn => {
                            let val = btn.getAttribute('data-filter');
                            btn.style.fontWeight = val === savedFilter ? '700' : '';
                            btn.style.color = val === savedFilter ? 'var(--primary)' : '';
                        });

                        updateNotifBadge();
                    });
                });
        }

        function markNotificationRead(el, id) {
            if (el) el.classList.remove('unread');
            fetch('NotificationHandler.ashx?action=markRead&id=' + id, { credentials: 'same-origin' });
            let badge = document.getElementById('notificationBadge');
            if (badge) {
                let count = parseInt(badge.textContent || '0') - 1;
                if (count > 0) { badge.textContent = count; } else { badge.style.display = 'none'; }
            }
        }

        function updateNotifBadge() {
            fetch('NotificationHandler.ashx?action=getUnread', { credentials: 'same-origin' })
                .then(r => r.json())
                .then(res => {
                    let badge = document.getElementById('notificationBadge');
                    if (badge) {
                        if (res.ok && res.count > 0) {
                            badge.textContent = res.count;
                            badge.style.display = 'inline-block';
                        } else badge.style.display = 'none';
                    }
                });
        }

        // ====================== PAGE NAVIGATION ======================
        function navigateWithFlip(url) {
            window.location.href = url;
        }

        // Initialize
        renderAnnouncements();
    </script>
</body>
</html>