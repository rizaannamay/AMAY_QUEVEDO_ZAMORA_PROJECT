<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Student" %>


<script runat="server">
    protected void SearchButton_Click(object sender, EventArgs e)
    {
            Response.Redirect("SearchStudent.aspx");
        
    }
</script>

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

        html, body, form { height: 100%; }
        html, body { overflow: hidden; }

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

        .footer {
            flex: 0 0 34px;
            text-align: center;
            line-height: 34px;
            font-size: 12px;
        }

        form { height: auto; min-height: 100%; overflow: visible; }

        .logo { font-size: 22px; font-weight: 800; color: var(--primary); white-space: nowrap; }
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

            border: 2px solid #0F172A; 
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

        .search-btn, .comment-input button, .modal-close {
            background: none;
            border: 2px solid #0F172A; 
            border-radius: 30px;
            padding: 10px 22px;
            color: #0F172A;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        

        .search-btn:hover, .comment-input button:hover, .modal-close:hover {
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
            border: 1px solid #dce4ec;
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
            border: 1px solid #dce4ec;
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
            grid-template-columns: 300px minmax(0, 1fr);
            gap: 25px;
            overflow: hidden;
            align-items: stretch;
        }

        .sidebar { height: 100%; min-height: 0; overflow: hidden; }

        .card {
            background: var(--surface);
            backdrop-filter: blur(10px);
            border-radius: 24px;
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        .sidebar .card, .main-panel.card {
            height: 100%;
            min-height: 100%;
            display: flex;
            flex-direction: column;
        }

        .sidebar-content { min-height: 0; overflow-y: auto; }

        .card-header {
            padding: 18px 22px;
            border-bottom: 1px solid #eef2f6;
            font-weight: 700;
            color: var(--primary);
            font-size: 16px;
        }

        .card-header i { margin-right: 10px; color: var(--primary); }

        .profile-section {
            text-align: center;
            padding: 20px;
            border-bottom: 1px solid #eef2f6;
        }

        .profile-avatar {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 12px;
            font-size: 28px;
        }

        .sidebar-toggle {
            border: none;
            background: none;
            color: var(--primary);
            font-size: 22px;
            cursor: pointer;
            margin-bottom: 12px;
        }

        .profile-name, .post-author, .post-title, .modal-title { color: var(--primary); }
        .profile-name { font-size: 18px; font-weight: 700; }
        .menu-item, .settings-item, .dropdown-item { color: var(--page-text); }

        .menu-item, .settings-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 22px;
            cursor: pointer;
            width: 100%;
            border: none;
            background: none;
            text-align: left;
            font-size: 14px;
            transition: all 0.3s;
            border-left: 3px solid transparent;
        }

        .menu-item:hover, .settings-item:hover, .dropdown-item:hover, .action-btn:hover {
            background: var(--surface-soft);
            color: var(--primary);
        }

        .menu-item.active, .settings-item.active {
            background: var(--active-bg);
            color: var(--primary);
            border-left: 4px solid var(--primary);
            font-weight: 600;
        }

        .dropdown-icon {
            margin-left: auto;
            font-size: 12px;
            color: var(--muted-light);
            transition: transform 0.3s ease;
        }

        .menu-item.open .dropdown-icon { transform: rotate(180deg); }

        .dropdown-content {
            margin-left: 45px;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease;
        }

        .dropdown-item {
            display: block;
            padding: 10px 22px;
            font-size: 13px;
            cursor: pointer;
            background: none;
            border: none;
            width: 100%;
            text-align: left;
            transition: all 0.3s;
        }

        .toggle-switch {
            width: 44px;
            height: 22px;
            background: #dce4ec;
            border-radius: 30px;
            position: relative;
            cursor: pointer;
            transition: all 0.3s;
            margin-left: auto;
            flex-shrink: 0;
        }

        .toggle-switch.active { background: linear-gradient(135deg, var(--primary), var(--primary-2)); }

        .toggle-switch::after {
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

        .toggle-switch.active::after { left: 24px; }

        .main-panel { height: 100%; min-width: 0; min-height: 0; }
        .main-panel .card-header { flex: 0 0 auto; }
        .header-filter { float: right; font-size: 12px; color: var(--primary); }

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
            border: 1px solid rgba(26, 58, 92, 0.08);
            transition: all 0.3s;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
            overflow: hidden;
        }

        .announcement-card:hover {
            box-shadow: 0 8px 18px rgba(0, 0, 0, 0.08);
            border-color: rgba(26, 58, 92, 0.2);
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

        .post-author { font-weight: 700; font-size: 16px; }

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
        .post-title { font-size: 18px; font-weight: 700; margin-bottom: 10px; }
        .post-text, .comment-text, .notification-text, .modal-text { color: var(--page-text); line-height: 1.5; }

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
            border-top: 1px solid #eef2f6;
            border-bottom: 1px solid #eef2f6;
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
            border-top: 1px solid #eef2f6;
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
            border: 1px solid #dce4ec;
            border-radius: 30px;
            outline: none;
            font-size: 13px;
            color: var(--page-text);
        }

        .comment {
            padding: 10px 0;
            font-size: 13px;
            border-bottom: 1px solid #eef2f6;
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

        .notification-header {
            padding: 15px 18px;
            border-bottom: 1px solid #eef2f6;
            font-weight: 600;
            color: var(--primary);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .notification-header button {
            background: none;
            border: none;
            color: var(--primary);
            font-size: 11px;
            cursor: pointer;
        }

        .notification-list {
            max-height: 350px;
            overflow-y: auto;
        }

        .notification-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 18px;
            border-bottom: 1px solid #eef2f6;
            cursor: pointer;
        }

        .notification-item:hover { background: var(--surface-soft); }
        .notification-item.unread { background: var(--active-bg); }

        .notification-dot {
            width: 8px;
            height: 8px;
            background: #dc2626;
            border-radius: 50%;
        }

        .notification-time { font-size: 10px; color: var(--muted-light); }

        .modal {
            display: none;
            position: fixed;
            inset: 0;
            width: 100%;
            height: 100%;
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

        .modal-icon { font-size: 50px; color: var(--primary); margin-bottom: 15px; }
        .modal-title { font-size: 24px; font-weight: 700; margin-bottom: 10px; }
        .modal-text { margin: 15px 0; font-size: 13px; }

        .footer {
            position: fixed;
            left: 20px;
            right: 20px;
            bottom: 0;
            height: 34px;
            text-align: center;
            padding: 0;
            margin: 0;
            line-height: 34px;
            font-size: 12px;
            z-index: 50;
        }

        .sidebar.collapsed { width: 88px; }
        .sidebar.collapsed + .main-panel { margin-left: 0; }
        .sidebar.collapsed .profile-name, .sidebar.collapsed .profile-email, .sidebar.collapsed .card-header,
        .sidebar.collapsed .menu-text, .sidebar.collapsed .settings-text, .sidebar.collapsed .dropdown-content { display: none; }
        .sidebar.collapsed .menu-item, .sidebar.collapsed .settings-item, .sidebar.collapsed .profile-section { justify-content: center; }
        .sidebar.collapsed .dropdown-icon, .sidebar.collapsed .toggle-switch { display: none; }

        /* Dark mode variables and tweaks */
        .dark-mode {
            --bg-image: url('bg.jpg');
            --page-text: #e4e6eb;
            --surface: rgba(33, 38, 45, 0.9);
            --surface-strong: rgba(39, 44, 52, 0.96);
            --surface-soft: rgba(56, 62, 72, 0.75);
            --border: rgba(255, 255, 255, 0.08);
            --muted: #b0bac7;
            --muted-light: #8ea0b5;
            --shadow: 0 8px 24px rgba(0, 0, 0, 0.28);
            --active-bg: rgba(64, 96, 128, 0.36);
        }

        /* Additional element level dark-mode rules so borders / buttons look correct */
        .dark-mode .search-btn, .dark-mode .comment-input button, .dark-mode .modal-close {
            border-color: rgba(255,255,255,0.08);
            color: #ffffff;
            background: transparent;
        }

        .dark-mode .search-btn:hover, .dark-mode .comment-input button:hover, .dark-mode .modal-close:hover {
            background: rgba(255,255,255,0.04);
            box-shadow: none;
            transform: translateY(0);
        }

        .dark-mode .notification-bell { border-color: var(--border); }
        .dark-mode .user-info { border-color: var(--border); }
        .dark-mode .search-box { border-color: rgba(255,255,255,0.06); }
        .dark-mode .comment-input input { border-color: rgba(255,255,255,0.06); background: var(--surface-soft); color: var(--page-text); }
        .dark-mode .card-header { border-bottom-color: rgba(255,255,255,0.04); }
        .dark-mode .post-stats { border-top-color: rgba(255,255,255,0.04); border-bottom-color: rgba(255,255,255,0.04); }
        .dark-mode .comment { border-bottom-color: rgba(255,255,255,0.03); }
        .dark-mode .notification-header { border-bottom-color: rgba(255,255,255,0.04); }

        .dark-mode .announcement-board { background: rgba(18, 22, 28, 0.28); }
        .dark-mode .notification-item.unread, .dark-mode .menu-item.active, .dark-mode .settings-item.active { background: rgba(64, 96, 128, 0.36); }
        .dark-mode .logo, .dark-mode .logo i, .dark-mode .card-header, .dark-mode .card-header i,
        .dark-mode .profile-name, .dark-mode .post-author, .dark-mode .post-title, .dark-mode .modal-title,
        .dark-mode .user-name, .dark-mode .user-role, .dark-mode .profile-email, .dark-mode .menu-item,
        .dark-mode .settings-item, .dark-mode .dropdown-item, .dark-mode .menu-item.active, .dark-mode .settings-item.active,
        .dark-mode .header-filter, .dark-mode .post-stats, .dark-mode .post-stats span, .dark-mode .action-btn,
        .dark-mode .comment-author, .dark-mode .comment-avatar, .dark-mode .bell-icon, .dark-mode .notification-header,
        .dark-mode .notification-header button, .dark-mode .notification-header a, .dark-mode .sidebar-toggle,
        .dark-mode .dropdown-icon, .dark-mode .no-comments, .dark-mode .footer { color: #ffffff; }

        .dark-mode .menu-item:hover, .dark-mode .settings-item:hover, .dark-mode .dropdown-item:hover,
        .dark-mode .post-stats span:hover, .dark-mode .action-btn:hover { color: #ffffff; }

        .dark-mode .pin-btn-top:hover, .dark-mode .action-btn:hover { background: rgba(255, 255, 255, 0.06); }

        @media (max-width: 980px) {
            html, body { overflow: auto; }
            .app-shell, form { height: auto; min-height: 100%; overflow: visible; }
            .footer { position: static; height: auto; line-height: normal; padding: 6px 0 0; }
            .header { flex-wrap: wrap; }
            .search-container { order: 3; width: 100%; justify-content: stretch; }
            .content-shell { grid-template-columns: 1fr; overflow: visible; }
            .sidebar, .main-panel, .sidebar .card, .main-panel.card { height: auto; }
            .announcement-board, .sidebar-content { overflow: visible; max-height: none; }
            .notification-dropdown { right: 12px; left: 12px; width: auto; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="app-shell">
            <div class="header">
                <div class="logo">
                    <i class="fas fa-university"></i> CampusAnnouncement
                </div>

                <div class="search-container">
                    <asp:Button ID="searchButton" runat="server" CssClass="search-btn" Text=" 🔎 Search........" OnClick="SearchButton_Click" Width="420px" Font-Bold="False" ForeColor=" #0F172A" Font-Size="Medium" Height="54px" />
                </div>

                <div class="header-actions">
                    <div class="notification-bell" onclick="toggleNotificationDropdown()">
                        <i class="fas fa-bell bell-icon"></i>
                        <span id="notificationBadge" class="badge-red">0       </span>
                    </div>
                    <div class="user-info">
                        <div class="avatar">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="user-details">
                            <div class="user-name" id="userName">Loading...</div>
                            <div class="user-role" id="userRole">Student</div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="notificationDropdown" class="notification-dropdown">
                <div class="notification-header">
                    <a href="Notifications.aspx" style="text-decoration: none; color: inherit;">
                        <span><i class="fas fa-bell"></i> Notifications</span>
                    </a>
                    <button type="button" onclick="markAllRead()">Mark all read</button>
                </div>
                <div class="notification-list" id="notificationList">
                    <div style="padding:20px;text-align:center;">Loading notifications...</div>
                </div>
            </div>

            <div class="content-shell">
                <aside class="sidebar">
                    <div class="card">
                        <div class="sidebar-content">
                            <div class="profile-section">
                                <button type="button" class="sidebar-toggle" onclick="toggleSidebar()">
                                    <i class="fas fa-bars"></i>
                                </button>
                                <div class="profile-name" id="profileName">Loading...</div>
                                <div class="profile-email" id="profileEmail">Loading...</div>
                            </div>

                            <div class="card-header">
                                <i class="fas fa-filter"></i> Filters
                            </div>
                            <button type="button" class="menu-item" onclick="toggleDropdown('categoryDropdown', this)">
                                <i class="fas fa-layer-group"></i>
                                <span class="menu-text">Filter by Category</span>
                                <i class="fas fa-chevron-down dropdown-icon"></i>
                            </button>
                            <div id="categoryDropdown" class="dropdown-content">
                                <button type="button" class="dropdown-item" onclick="filterCategory('All')">All Announcements</button>
                                <button type="button" class="dropdown-item" onclick="filterCategory('Exam')">Exam Schedule</button>
                                <button type="button" class="dropdown-item" onclick="filterCategory('Suspension')">Class Suspension</button>
                                <button type="button" class="dropdown-item" onclick="filterCategory('Event')">Campus Events</button>
                            </div>

                            <button type="button" class="menu-item" onclick="window.location.href='Pinned.aspx'">
                                <i class="fas fa-thumbtack"></i>
                                <span class="menu-text">Pinned Announcements</span>
                            </button>

                            <div class="card-header" style="margin-top: 5px;">
                                <i class="fas fa-cog"></i> Settings
                            </div>

                            <button type="button" class="settings-item" onclick="toggleTheme(this)" aria-pressed="false" title="Toggle dark / light theme">
                                <i class="fas fa-moon"></i>
                                <span class="settings-text">Dark / Light Mode</span>
                                <div class="toggle-switch" id="themeToggle" role="switch" aria-checked="false"></div>
                            </button>

                            <button type="button" class="settings-item" onclick="openAboutModal()">
                                <i class="fas fa-info-circle"></i>
                                <span class="settings-text">About Us</span>
                            </button>

                            <button type="button" class="settings-item" onclick="logout()">
                                <i class="fas fa-sign-out-alt"></i>
                                <span class="settings-text">Logout</span>
                            </button>
                        </div>
                    </div>
                </aside>

                <main class="main-panel card">
                    <div class="card-header">
                        <i class="fas fa-bullhorn"></i> Announcement Board
                        <span class="header-filter">Showing: <span id="activeFilterLabel">All</span></span>
                    </div>

                    <div id="announcementsContainer" class="announcement-board">
                        <div style="text-align:center;padding:40px;">Loading announcements...</div>
                    </div>
                </main>
            </div>
        </div>

        <div id="aboutModal" class="modal">
            <div class="modal-content">
                <div class="modal-icon">
                    <i class="fas fa-university"></i>
                </div>
                <div class="modal-title">Campus Connect</div>
                <div class="modal-text">
                    Campus Connect is a centralized web-based announcement system for Cebu Technological University.
                    It allows students to access official announcements, exam schedules, class suspensions, and campus events in one place.
                </div>
                <button type="button" class="modal-close" onclick="closeAboutModal()">Close</button>
            </div>
        </div>
    </form>

    <script>
        function toggleDropdown(id, trigger) {
            var dropdown = document.getElementById(id);
            if (!dropdown) return;
            var isOpen = dropdown.style.maxHeight && dropdown.style.maxHeight !== "0px";
            dropdown.style.maxHeight = isOpen ? "0px" : dropdown.scrollHeight + "px";
            if (trigger) trigger.classList.toggle('open', !isOpen);
        }

        function toggleSidebar() {
            var sidebar = document.querySelector('.sidebar');
            if (sidebar) sidebar.classList.toggle('collapsed');
        }

        function toggleNotificationDropdown() {
            var dropdown = document.getElementById('notificationDropdown');
            if (dropdown) dropdown.classList.toggle('show');
        }

        document.addEventListener('click', function (e) {
            var bell = document.querySelector('.notification-bell');
            var dropdown = document.getElementById('notificationDropdown');
            if (bell && dropdown && !bell.contains(e.target) && !dropdown.contains(e.target)) {
                dropdown.classList.remove('show');
            }
        });

        function loadComments(postId) {
            fetch('Comments.aspx?action=get&postId=' + encodeURIComponent(postId))
                .then(function (res) { return res.json(); })
                .then(function (data) {
                    var commentsList = document.getElementById('commentsList_' + postId);
                    if (!commentsList) return;
                    if (!Array.isArray(data) || data.length === 0) {
                        commentsList.innerHTML = '<div class="no-comments">No comments yet. Be the first!</div>';
                        return;
                    }
                    var html = '';
                    data.forEach(function (comment) {
                        html += '\
<div class="comment">\
  <div class="comment-avatar"><i class="fas fa-user"></i></div>\
  <div class="comment-content">\
    <span class="comment-author">' + escapeHtml(comment.author) + '</span>\
    <div class="comment-text">' + escapeHtml(comment.text) + '</div>\
    <div class="comment-time">' + (comment.date || '') + '</div>\
  </div>\
</div>';
                    });
                    commentsList.innerHTML = html;
                })
                .catch(function (err) { console.error('Error loading comments:', err); });
        }

        // body must be valid JSON string
        function addComment(btn, postId) {
            var input = document.getElementById('commentInput_' + postId);
            if (!input) return;
            var commentText = input.value.trim();
            if (commentText === '') { showToast('Please enter a comment!'); return; }

            var payload = JSON.stringify({ postId: postId, comment: commentText });

            fetch('Comments.aspx?action=add', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: payload
            })
                .then(function (res) { return res.json(); })
                .then(function (data) {
                    if (data && data.success) {
                        input.value = '';
                        loadComments(postId);
                        showToast('Comment posted');
                    } else {
                        showToast('Error posting comment');
                    }
                })
                .catch(function (err) {
                    console.error('Error posting comment:', err);
                    showToast('Error posting comment');
                });
        }

        // small helpers
        function escapeHtml(s) {
            if (!s) return '';
            return String(s).replace(/[&<>"'\/]/g, function (c) {
                return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;', '/': '&#x2F;' }[c];
            });
        }

        function showToast(message) {
            // simple placeholder - implement a nicer toast if needed
            alert(message);
        }

        // THEME HANDLING
        function toggleTheme(item) {
            var toggle = item.querySelector('.toggle-switch');
            toggle.classList.toggle('active');
            document.body.classList.toggle('dark-mode');
        }

        function openAboutModal() {
            document.getElementById('aboutModal').style.display = 'flex';
        }
        a
        function closeAboutModal() {
            document.getElementById('aboutModal').style.display = 'none';
        }

        function logout() {
            if (confirm('Are you sure you want to logout?')) {
                window.location.href = 'login.aspx';
            }
        }

    </script>
</body>
</html>