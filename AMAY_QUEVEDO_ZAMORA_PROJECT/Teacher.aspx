<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Teacher.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Teacher" %>

<script runat="server">
    protected void SearchButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("SearchDashboard.aspx");
    }
</script>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Campus Connect - Teacher Dashboard</title>
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
            --danger: #dc2626;
            --danger-hover: #b91c1c;
            --success: #10b981;
            --success-hover: #059669;
        }

        html, body, form { height: 100%; }
        html, body { overflow: hidden; }

        body {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            color: var(--page-text);
            background-image: var(--bg-image);
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            background-attachment: fixed;
            transition: background 0.4s ease, color 0.4s ease;
        }

        a { color: inherit; text-decoration: none; }
        button, input, textarea, select { font: inherit; }

        .app-shell {
            height: 100vh;
            display: flex;
            flex-direction: column;
            gap: 10px;
            padding: 16px 20px 0;
            overflow: hidden;
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

        .search-btn {
            background: none;
            border: 2px solid var(--primary);
            border-radius: 30px;
            padding: 10px 22px;
            color: var(--primary);
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .search-btn:hover {
            background: var(--active-bg);
            border-color: var(--primary);
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
            border: 1px solid var(--border);
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
            background: var(--surface-soft);
            padding: 6px 18px;
            border-radius: 40px;
            border: 1px solid var(--border);
            cursor: pointer;
            transition: background 0.2s;
        }
        .user-info:hover { background: var(--active-bg); }

        /* Hamburger Menu Button */
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

        /* Slide-out Panel (Right Side) */
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
        .panel-close:hover { color: var(--danger); }
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

        /* Category Dropdown inside panel - fixed styling */
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

        .avatar, .post-avatar, .create-post-avatar {
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
        .user-role, .post-meta, .comment-time, .footer { color: var(--muted); }

        .content-shell {
            flex: 1 1 0;
            min-height: 0;
            display: grid;
            grid-template-columns: 1fr;
            gap: 25px;
            overflow: hidden;
            align-items: stretch;
        }

        .card {
            background: var(--surface);
            backdrop-filter: blur(10px);
            border-radius: 24px;
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        .main-panel.card {
            height: 100%;
            min-height: 100%;
            display: flex;
            flex-direction: column;
        }

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
            border: 1px solid var(--border);
            transition: all 0.3s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.03);
            overflow: hidden;
        }

        .announcement-card:hover {
            box-shadow: 0 8px 18px rgba(0,0,0,0.08);
            border-color: var(--primary);
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

        .pin-btn-top, .edit-btn-top, .delete-btn-top {
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
        .pin-btn-top.pinned { color: #e65100; }
        .pin-btn-top:hover, .edit-btn-top:hover, .delete-btn-top:hover { background: var(--surface-soft); }
        .edit-btn-top:hover { color: #3b82f6; }
        .delete-btn-top:hover { color: #ef4444; }

        .post-content { padding: 0 22px 16px; }
        .post-title { font-size: 18px; font-weight: 700; margin-bottom: 10px; color: var(--primary); }
        .post-text { color: var(--page-text); line-height: 1.5; }
        .post-image { margin-top: 12px; border-radius: 16px; overflow: hidden; max-width: 100%; }
        .post-image img { width: 100%; max-height: 300px; object-fit: cover; border-radius: 16px; }

        .post-stats {
            display: flex;
            gap: 20px;
            padding: 10px 22px;
            border-top: 1px solid var(--border);
            border-bottom: 1px solid var(--border);
            color: var(--muted);
            font-size: 13px;
        }
        .post-stats span { display: flex; align-items: center; gap: 6px; cursor: pointer; }
        .post-stats span:hover { color: var(--primary); }

        .action-buttons { display: flex; gap: 5px; padding: 8px 22px; }
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

        .comments-section {
            padding: 0 22px 18px;
            border-top: 1px solid var(--border);
            display: none;
        }
        .comments-section.show { display: block; }
        .comment-input { display: flex; gap: 10px; margin: 15px 0; }
        .comment-input input {
            flex: 1;
            padding: 10px 16px;
            background: var(--surface-soft);
            border: 1px solid var(--border);
            border-radius: 30px;
            outline: none;
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

        .create-post-card {
            background: var(--surface-strong);
            border-radius: 16px;
            padding: 14px 18px;
            border: 1px solid var(--border);
            flex-shrink: 0;
            cursor: pointer;
            margin-bottom: 12px;
        }
        .create-post-header { display: flex; align-items: center; gap: 12px; }
        .create-post-avatar {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
        }
        .create-post-input {
            flex: 1;
            background: var(--surface-soft);
            border: 1px solid var(--border);
            border-radius: 40px;
            padding: 10px 18px;
            font-size: 14px;
            color: var(--muted);
            cursor: pointer;
        }

        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(4px);
            z-index: 1200;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .modal-content {
            background: var(--surface-strong);
            border-radius: 28px;
            max-width: 440px;
            width: 100%;
            max-height: 90vh;
            overflow-y: auto;
        }
        .modal-title {
            font-size: 20px;
            font-weight: 700;
            color: var(--primary);
        }
        .modal-header { padding: 20px 24px; border-bottom: 1px solid var(--border); display: flex; justify-content: space-between; }
        .modal-body { padding: 24px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { font-weight: 600; margin-bottom: 8px; display: block; }
        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 12px 16px;
            background: var(--surface-soft);
            border: 1px solid var(--border);
            border-radius: 16px;
        }
        .btn-publish { background: var(--success); color: white; border: none; padding: 10px 28px; border-radius: 40px; cursor: pointer; }
        .btn-cancel { background: none; border: 1px solid var(--border); padding: 10px 24px; border-radius: 40px; cursor: pointer; }

        .footer {
            position: fixed;
            left: 20px;
            right: 20px;
            bottom: 0;
            height: 34px;
            text-align: center;
            font-size: 12px;
            color: var(--muted);
        }

        /* Dark Mode */
        .dark-mode {
            --bg-image: url('bg.jpg');
            --page-text: #e4e6eb;
            --surface: rgba(15, 25, 55, 0.75);
            --surface-strong: rgba(15, 25, 55, 0.92);
            --surface-soft: rgba(255, 255, 255, 0.07);
            --border: rgba(255, 255, 255, 0.1);
            --primary: #818cf8;
            --primary-2: #6366f1;
            --muted: #94a3b8;
            --active-bg: rgba(99, 102, 241, 0.18);
        }

        body.dark-mode {
            background-color: #0F172A;
            color: var(--page-text);
        }

        /* Cards & surfaces */
        body.dark-mode .announcement-card  { background: rgba(255,255,255,0.06); border-color: rgba(255,255,255,0.1); }
        body.dark-mode .card               { background: rgba(15,25,55,0.80); border-color: rgba(255,255,255,0.08); }
        body.dark-mode .header             { background: rgba(15,25,55,0.85); border-color: rgba(255,255,255,0.08); }
        body.dark-mode .create-post-card   { background: rgba(15,25,55,0.80); border-color: rgba(255,255,255,0.08); }
        body.dark-mode .create-post-input  { background: rgba(255,255,255,0.07); color: #94a3b8; border-color: rgba(255,255,255,0.08); }

        /* Text */
        body.dark-mode .post-author,
        body.dark-mode .post-title         { color: #c7d2fe; }
        body.dark-mode .post-text          { color: #cbd5e1; }
        body.dark-mode .post-meta,
        body.dark-mode .post-stats,
        body.dark-mode .post-stats span,
        body.dark-mode .action-btn,
        body.dark-mode .comment-time,
        body.dark-mode .no-comments        { color: #94a3b8; }
        body.dark-mode .comment-author     { color: #a5b4fc; }
        body.dark-mode .card-header        { color: #c7d2fe; border-bottom-color: rgba(255,255,255,0.08); }
        body.dark-mode .logo               { color: #c7d2fe; }
        body.dark-mode .user-name          { color: #e2e8f0; }
        body.dark-mode .user-role          { color: #94a3b8; }

        /* Slideout panel */
        body.dark-mode .slideout-panel     { background: rgba(10,15,40,0.97); border-color: rgba(255,255,255,0.08); }
        body.dark-mode .panel-header h3    { color: #c7d2fe; }
        body.dark-mode .panel-menu-item    { color: #cbd5e1; }
        body.dark-mode .panel-menu-item i  { color: #818cf8; }
        body.dark-mode .panel-menu-item:hover { background: rgba(99,102,241,0.15); color: #ffffff; }
        body.dark-mode .dropdown-item-panel { color: #cbd5e1; }
        body.dark-mode .dropdown-item-panel:hover { background: rgba(99,102,241,0.15); color: #ffffff; }
        body.dark-mode .divider-light      { background: rgba(255,255,255,0.08); }

        /* Inputs */
        body.dark-mode .comment-input input { background: rgba(255,255,255,0.07); border-color: rgba(255,255,255,0.1); color: #e2e8f0; }
        body.dark-mode .comment-input input::placeholder { color: #64748b; }
        body.dark-mode .form-group input,
        body.dark-mode .form-group textarea,
        body.dark-mode .form-group select  { background: rgba(255,255,255,0.07); border-color: rgba(255,255,255,0.1); color: #e2e8f0; }

        /* Category badges */
        body.dark-mode .post-category-exam       { background: rgba(25,118,210,0.2);  color: #90caf9; }
        body.dark-mode .post-category-suspension { background: rgba(198,40,40,0.2);   color: #ef9a9a; }
        body.dark-mode .post-category-event      { background: rgba(46,125,50,0.2);   color: #a5d6a7; }
        body.dark-mode .post-category-general    { background: rgba(99,102,241,0.2);  color: #c7d2fe; }
        body.dark-mode .pin-btn-top.pinned        { color: #fb923c; }

        /* Search & action buttons */
        body.dark-mode .search-btn { border-color: rgba(255,255,255,0.2); color: #e2e8f0; }
        body.dark-mode .edit-btn-top:hover   { background: rgba(59,130,246,0.15); color: #93c5fd; }
        body.dark-mode .delete-btn-top:hover { background: rgba(239,68,68,0.15);  color: #fca5a5; }

        /* Modals */
        body.dark-mode .modal-content  { background: rgba(10,15,40,0.97); border: 1px solid rgba(255,255,255,0.1); }
        body.dark-mode .modal-header h2 { color: #c7d2fe; }
        body.dark-mode .form-group label { color: #a5b4fc; }
        body.dark-mode .modal-title { color: #e0e7ff; }
        body.dark-mode #pm-fullname { color: #e0e7ff; }
        body.dark-mode #pm-username, body.dark-mode #pm-email { color: #e2e8f0; }
        @media (max-width: 980px) {
            .content-shell { overflow: visible; }
            .announcement-board { overflow: visible; }
            html, body { overflow: auto; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="app-shell">
            <div class="header">
                <div class="logo" onclick="navigateWithFlip('Teacher.aspx')">
                    <i class="fas fa-chalkboard-teacher"></i> CampusConnect Teacher
                </div>
                <div class="search-container">
                    <asp:Button ID="searchButton" runat="server" CssClass="search-btn"
                        Text="🔎 Search Announcements..." OnClick="SearchButton_Click"
                        Width="420px" Font-Bold="False" Font-Size="Medium" Height="54px"
                        UseSubmitBehavior="false" />
                </div>
                <div class="header-actions">
                    <div class="notification-bell" onclick="openNotificationDropdown()">
                        <i class="fas fa-bell bell-icon"></i>
                        <span id="notificationBadge" class="badge-red" style="display:none;">0</span>
                    </div>
                    <div class="user-info" onclick="openProfileModal()">
                        <div class="avatar"><i class="fas fa-user"></i></div>
                        <div class="user-details">
                            <div class="user-name"><%= Session["FullName"] ?? "User" %></div>
                            <div class="user-role"><%= Session["Role"] ?? "Teacher" %></div>
                        </div>
                    </div>
                    <div class="hamburger-menu-btn" id="hamburgerBtn">
                        <i class="fas fa-bars"></i>
                    </div>
                </div>
            </div>

            <!-- Slide-out Panel with fixed category dropdown -->
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
                    <button type="button" class="panel-menu-item" onclick="logout();">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </button>
                </div>
            </div>
            <div id="overlay" class="overlay-black" style="display:none!important;pointer-events:none;"></div>

            <div class="content-shell">
                <main class="main-panel">
                    <div class="create-post-card" onclick="openCreatePostModal()">
                        <div class="create-post-header">
                            <div class="create-post-avatar"><i class="fas fa-plus-circle"></i></div>
                            <div class="create-post-input">Share an announcement with students...</div>
                        </div>
                    </div>
                    <div class="card" style="flex:1 1 0; min-height:0; display:flex; flex-direction:column;">
                        <div class="card-header" style="padding:18px 22px; border-bottom:1px solid var(--border);">
                            <i class="fas fa-bullhorn"></i> Announcement Board
                            <span style="float: right; font-size: 12px;">Showing: <span id="activeFilterLabel">All</span></span>
                        </div>
                        <div id="announcementsContainer" class="announcement-board"></div>
                    </div>
                </main>
            </div>
        </div>

        <!-- Modals -->
        <div id="createPostModal" class="modal"><div class="modal-content"><div class="modal-header"><h2><i class="fas fa-plus-circle"></i> New Announcement</h2><button type="button" class="modal-close-btn" onclick="closeCreatePostModal()">&times;</button></div><div class="modal-body"><div class="form-group"><label>Title</label><input type="text" id="announcementTitle" /></div><div class="form-group"><label>Category</label><select id="announcementCategory"><option>General</option><option>Exam</option><option>Suspension</option><option>Event</option></select></div><div class="form-group"><label>Content</label><textarea id="announcementContent" rows="4"></textarea></div><div class="form-group"><label>Image</label><input type="file" id="announcementImageFile" accept="image/*" onchange="previewImageFile()" /><div id="imagePreview" class="image-preview" style="display:none;"><img id="previewImg" style="max-width:100%" /></div></div></div><div class="modal-footer-buttons" style="padding:16px 24px; display:flex; gap:12px; justify-content:flex-end;"><button class="btn-cancel" onclick="closeCreatePostModal()">Cancel</button><button class="btn-publish" onclick="publishAnnouncement()">Publish</button></div></div></div>
        <div id="profileModal" class="modal" style="display:none;">
            <div class="modal-content" style="max-width:420px;text-align:left;">
                <div style="text-align:center;margin-bottom:20px;">
                    <div style="width:72px;height:72px;border-radius:50%;background:linear-gradient(135deg,#1e3a8a,#2563eb);color:#fff;display:flex;align-items:center;justify-content:center;font-size:28px;margin:0 auto 12px;">
                        <i class="fas fa-user"></i>
                    </div>
                    <div class="modal-title" style="margin-bottom:4px;" id="pm-fullname"><%= Session["FullName"] ?? "User" %></div>
                    <span style="display:inline-block;padding:3px 14px;border-radius:20px;font-size:11px;font-weight:700;background:#DBEAFE;color:#1E3A8A;" id="pm-role"><%= Session["Role"] ?? "Admin" %></span>
                </div>
                <div style="display:flex;flex-direction:column;gap:12px;margin-bottom:24px;">
                    <div style="display:flex;align-items:center;gap:12px;padding:12px 16px;background:var(--surface-soft);border-radius:12px;"><i class="fas fa-user" style="color:var(--primary);"></i><div><div style="font-size:11px;color:var(--muted);">Username</div><div style="font-weight:600;" id="pm-username"><%= Session["Username"] ?? "User" %></div></div></div>
                    <div style="display:flex;align-items:center;gap:12px;padding:12px 16px;background:var(--surface-soft);border-radius:12px;"><i class="fas fa-envelope" style="color:var(--primary);"></i><div><div style="font-size:11px;color:var(--muted);">Email</div><div style="font-weight:600;" id="pm-email"><%= Session["Email"] ?? "admin@ctu.edu" %></div></div></div>
                </div>
                <div style="display:flex;gap:10px;">
                    <button onclick="closeProfileModal()" style="flex:1;padding:12px;border:1px solid var(--border);border-radius:12px;background:none;cursor:pointer;">Close</button>
                    <button onclick="logout()" style="flex:1;padding:12px;border:none;border-radius:12px;background:#fef2f2;color:#dc2626;cursor:pointer;"><i class="fas fa-sign-out-alt"></i> Logout</button>
                </div>
            </div>
        </div>
        <div id="aboutModal" class="modal"><div class="modal-content" style="max-width:400px;"><div class="modal-header"><h2>About Campus Connect</h2><button class="modal-close-btn" onclick="closeAboutModal()">&times;</button></div><div class="modal-body" style="text-align:center;"><p>Campus Connect - CTU Announcement System. Teacher Edition.</p><button class="btn-publish" style="margin-top:16px;" onclick="closeAboutModal()">Got it</button></div></div></div>
        <div class="footer"><i class="fas fa-shield-alt"></i> Secure Portal | Cebu Technological University</div>
    </form>
    <script>
        // Global state
        let st_announcements = [], st_likes = {}, st_likeCounts = {}, st_pins = {}, st_comments = {};
        function saveSharedState() { localStorage.setItem('teacher_data', JSON.stringify({ likes: st_likes, likeCounts: st_likeCounts, pins: st_pins, comments: st_comments })); }
        
        function loadAnnouncementsFromDB() {
            fetch('AnnouncementHandler.ashx?action=getAll', { credentials: 'same-origin' })
                .then(r => r.json()).then(res => { if(res.ok) { st_announcements = res.data.map(a => ({ ...a, pinned: a.isPinned })); renderAnnouncements(); } });
        }
        
        function renderAnnouncements() {
            let container = document.getElementById('announcementsContainer');
            if(!container) return;
            let filter = localStorage.getItem('teacher_filter') || 'All';
            document.getElementById('activeFilterLabel').innerText = filter;
            let filtered = st_announcements.filter(a => filter === 'All' || a.category === filter);
            filtered.sort((a,b) => (st_pins[a.id] && !st_pins[b.id]) ? -1 : (!st_pins[a.id] && st_pins[b.id]) ? 1 : b.id - a.id);
            container.innerHTML = filtered.map(post => {
                let pinned = st_pins[post.id];
                let likeCount = st_likeCounts[post.id] || post.likeCount || 0;
                let catClass = post.category === 'Exam' ? 'post-category-exam' : (post.category === 'Suspension' ? 'post-category-suspension' : (post.category === 'Event' ? 'post-category-event' : 'post-category-general'));
                let commentsCount = (st_comments[post.id] || []).length;
                return `<div class="announcement-card" data-id="${post.id}"><div class="post-header"><div class="post-header-left"><div class="post-avatar"><i class="fas fa-user-tie"></i></div><div><div class="post-author">${escapeHtml(post.author)}</div><div class="post-meta"><span>${post.date}</span><span class="post-category ${catClass}">${post.category}</span></div></div></div><div><button type="button" class="edit-btn-top" onclick="openEditModal(${post.id})"><i class="fas fa-edit"></i></button><button type="button" class="delete-btn-top" onclick="deletePost(${post.id})"><i class="fas fa-trash"></i></button><button type="button" class="pin-btn-top ${pinned ? 'pinned' : ''}" onclick="togglePin(${post.id})"><i class="${pinned ? 'fas' : 'far'} fa-thumbtack"></i></button></div></div><div class="post-content"><div class="post-title">${escapeHtml(post.title)}</div><div class="post-text">${escapeHtml(post.content)}</div>${post.imageUrl ? `<div class="post-image"><img src="${post.imageUrl}" /></div>` : ''}</div><div class="post-stats"><span onclick="toggleLike(${post.id})"><i class="${st_likes[post.id] ? 'fas' : 'far'} fa-heart"></i> <span class="like-count">${likeCount}</span> Likes</span><span onclick="toggleCommentSection(${post.id})"><i class="far fa-comment"></i> <span class="comment-count">${commentsCount}</span> Comments</span><span onclick="sharePost(${post.id})"><i class="far fa-share-square"></i> Share</span></div><div class="action-buttons"><button type="button" class="action-btn" onclick="toggleLike(${post.id})"><i class="${st_likes[post.id] ? 'fas' : 'far'} fa-heart"></i> Like</button><button type="button" class="action-btn" onclick="toggleCommentSection(${post.id})">Comment</button><button type="button" class="action-btn" onclick="sharePost(${post.id})">Share</button></div><div class="comments-section" id="commentsSection_${post.id}" style="display:none;"><div class="comment-input"><input id="commentInput_${post.id}" placeholder="Write a comment..."/><button type="button" onclick="addComment(${post.id})">Post</button></div><div id="commentsList_${post.id}">${renderCommentsList(post.id)}</div></div></div>`;
            }).join('');
        }
        
        function renderCommentsList(postId) { let comments = st_comments[postId] || []; if(!comments.length) return '<div class="no-comments">No comments yet.</div>'; return comments.map(c => `<div class="comment"><div class="comment-avatar"><i class="fas fa-user"></i></div><div><span class="comment-author">${escapeHtml(c.author)}</span><div>${escapeHtml(c.text)}</div><small>${c.time}</small></div></div>`).join(''); }
        function escapeHtml(str) { if(!str) return ''; return str.replace(/[&<>]/g, m => ({ '&':'&amp;', '<':'&lt;', '>':'&gt;' })[m]); }
        function showToast(msg) { let t = document.createElement('div'); t.innerText = msg; t.style.cssText = 'position:fixed;bottom:30px;left:50%;transform:translateX(-50%);background:#1a3a5c;color:#fff;padding:8px 20px;border-radius:30px;z-index:9999'; document.body.appendChild(t); setTimeout(() => t.remove(), 2500); }
        function toggleLike(id) { fetch(`LikeHandler.ashx?action=toggle&postId=${id}`, { credentials: 'same-origin' }).then(r=>r.json()).then(res=>{ if(res.ok){ st_likes[id]=res.liked; st_likeCounts[id]=res.likeCount; saveSharedState(); renderAnnouncements(); } }); }
        function togglePin(id) { fetch(`AnnouncementHandler.ashx?action=togglePin&id=${id}`, { credentials: 'same-origin' }).then(r=>r.json()).then(res=>{ if(res.ok){ st_pins[id]=res.isPinned; if(!res.isPinned) delete st_pins[id]; saveSharedState(); renderAnnouncements(); } }); }
        function addComment(postId) { let input = document.getElementById(`commentInput_${postId}`); let text = input.value.trim(); if(!text) return; fetch('CommentHandler.ashx?action=add', { method:'POST', credentials:'same-origin', headers:{'Content-Type':'application/json'}, body:JSON.stringify({postId, comment:text}) }).then(()=>{ input.value=''; loadComments(postId); }); }
        function loadComments(postId) { fetch(`CommentHandler.ashx?action=get&postId=${postId}`, { credentials:'same-origin' }).then(r=>r.json()).then(list=>{ st_comments[postId] = list; let listDiv = document.getElementById(`commentsList_${postId}`); if(listDiv) listDiv.innerHTML = renderCommentsList(postId); let countSpan = document.querySelector(`.announcement-card[data-id="${postId}"] .comment-count`); if(countSpan) countSpan.textContent = list.length; }); }
        function toggleCommentSection(id) { let sec = document.getElementById(`commentsSection_${id}`); if(sec){ let open = sec.style.display !== 'none' && sec.style.display !== ''; sec.style.display = open ? 'none' : 'block'; if(!open) loadComments(id); } }
        function sharePost(id) { navigator.clipboard?.writeText(window.location.href); showToast('Link copied!'); }
        
        // Fixed filterCategory - persists selection, no auto-close of dropdown
        function filterCategory(cat) {
            localStorage.setItem('teacher_filter', cat);
            document.getElementById('activeFilterLabel').innerText = cat;
            renderAnnouncements();
            document.querySelectorAll('.dropdown-item-panel').forEach(btn => {
                btn.style.fontWeight = btn.textContent.includes(cat) || (cat === 'All' && btn.textContent.includes('All')) ? '700' : '';
                btn.style.color = btn.style.fontWeight === '700' ? 'var(--primary)' : '';
            });
        }
        
        // Slide-out controls
        function openSlideout() { document.getElementById('slideoutPanel').classList.add('open'); }
        function closeSlideout() { document.getElementById('slideoutPanel').classList.remove('open'); }

        // Hamburger toggles the panel open/closed
        document.getElementById('hamburgerBtn').addEventListener('click', function(e) {
            e.stopPropagation();
            let panel = document.getElementById('slideoutPanel');
            if (panel.classList.contains('open')) closeSlideout();
            else openSlideout();
        });

        // X button closes the panel
        document.getElementById('closePanelBtn').addEventListener('click', closeSlideout);

        // Category dropdown toggle
        document.getElementById('filterCategoryBtn').addEventListener('click', function(e) {
            e.stopPropagation();
            let panel = document.getElementById('categoryDropdownPanel');
            panel.style.display = panel.style.display === 'flex' ? 'none' : 'flex';
        });        
        function openCreatePostModal() { document.getElementById('createPostModal').style.display='flex'; }
        function closeCreatePostModal() { document.getElementById('createPostModal').style.display='none'; document.getElementById('announcementTitle').value=''; document.getElementById('announcementContent').value=''; document.getElementById('announcementImageFile').value=''; document.getElementById('imagePreview').style.display='none'; }
        function publishAnnouncement() { let title = document.getElementById('announcementTitle').value; let content = document.getElementById('announcementContent').value; let category = document.getElementById('announcementCategory').value; if(!title || !content) return showToast('Fill all fields'); let form = new FormData(); form.append('title',title); form.append('content',content); form.append('category',category); let file = document.getElementById('announcementImageFile').files[0]; if(file) form.append('imageFile',file); fetch('AnnouncementHandler.ashx?action=create', { method:'POST', credentials:'same-origin', body:form }).then(()=>{ closeCreatePostModal(); loadAnnouncementsFromDB(); showToast('Published!'); }); }
        function openEditModal(id) { let post = st_announcements.find(p=>p.id===id); if(post){ document.getElementById('announcementTitle').value=post.title; document.getElementById('announcementContent').value=post.content; document.getElementById('announcementCategory').value=post.category; openCreatePostModal(); let btn = document.querySelector('.btn-publish'); btn.innerText='Update'; btn.onclick = () => updateAnnouncement(id); } }
        function updateAnnouncement(id) { let title = document.getElementById('announcementTitle').value; let content = document.getElementById('announcementContent').value; let category = document.getElementById('announcementCategory').value; let form = new FormData(); form.append('title',title); form.append('content',content); form.append('category',category); let file = document.getElementById('announcementImageFile').files[0]; if(file) form.append('imageFile',file); fetch(`AnnouncementHandler.ashx?action=update&id=${id}`, { method:'POST', body:form, credentials:'same-origin' }).then(()=>{ closeCreatePostModal(); loadAnnouncementsFromDB(); showToast('Updated'); }); }
        function deletePost(id) { if(confirm('Delete?')) fetch(`AnnouncementHandler.ashx?action=delete&id=${id}`, { credentials:'same-origin' }).then(()=> loadAnnouncementsFromDB()); }
        function openProfileModal() { document.getElementById('profileModal').style.display='flex'; }
        function closeProfileModal() { document.getElementById('profileModal').style.display='none'; }
        function openAboutModal() { document.getElementById('aboutModal').style.display='flex'; }
        function closeAboutModal() { document.getElementById('aboutModal').style.display='none'; }
        function logout() { window.location.href='Logout.aspx'; }
        function navigateWithFlip(url) { window.location.href = url; }
        function toggleTheme() { let isDark = !document.body.classList.contains('dark-mode'); localStorage.setItem('campus_theme', isDark ? 'dark' : 'light'); document.body.classList.toggle('dark-mode', isDark); document.querySelectorAll('.toggle-switch-panel').forEach(el=>el.classList.toggle('active', isDark)); }        function openNotificationDropdown() { navigateWithFlip('Notifications.aspx'); }
        function previewImageFile() { let file = document.getElementById('announcementImageFile').files[0]; if(file){ let reader = new FileReader(); reader.onload = e=>{ document.getElementById('previewImg').src=e.target.result; document.getElementById('imagePreview').style.display='block'; }; reader.readAsDataURL(file); } }
        
        document.getElementById('settingsThemeBtn').addEventListener('click', (e) => { e.stopPropagation(); toggleTheme(); });
        
        let savedTheme = localStorage.getItem('campus_theme'); if(savedTheme==='dark') document.body.classList.add('dark-mode');
        let panelToggle = document.getElementById('panelThemeToggle'); if(panelToggle) panelToggle.classList.toggle('active', savedTheme==='dark');

        // Single storage listener — theme sync + announcements reload (skip theme key for reload)
        window.addEventListener('storage', function(e) {
            if (e.key === 'campus_theme') {
                let isDark = e.newValue === 'dark';
                document.body.classList.toggle('dark-mode', isDark);
                document.querySelectorAll('.toggle-switch-panel').forEach(el => el.classList.toggle('active', isDark));
            } else {
                loadAnnouncementsFromDB();
            }
        });

        loadAnnouncementsFromDB();
    </script>
</body>
</html>