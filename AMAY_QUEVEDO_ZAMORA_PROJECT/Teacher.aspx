<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Teacher.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Teacher" %>

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

        /* Normal Mode (Light) */
        body {
            background-image: url('wbg.jpg');
            background-size: cover;
            background-attachment: fixed;
            transition: all 0.3s ease;
        }

        /* Dark Mode State */
        body.dark-mode {
            background-image: url('bg.jpg') !important;
            color: #ffffff;
        }

        /* Glassmorphism for Cards in Dark Mode */
        body.dark-mode .card, 
        body.dark-mode .announcement-input-container,
        body.dark-mode .create-post-card {
            background: rgba(42, 42, 42, 0.85) !important;
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #e4e6eb;
        }

        body.dark-mode .header {
            background: rgba(30, 30, 30, 0.9);
            color: white;
        }

        /* Header */
        .header {
            background: white;
            border-radius: 24px;
            padding: 12px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            border: 1.5px solid rgba(26,58,92,0.25);
            flex-wrap: wrap;
            gap: 15px;
        }

        .logo {
            font-size: 22px;
            font-weight: 800;
            background: linear-gradient(135deg, #1a3a5c, #2c5a7a);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            color: #1a3a5c;
        }

        .logo i {
            background: none;
            -webkit-background-clip: unset;
            color: #1a3a5c;
            margin-right: 8px;
        }

        /* Modern Search Bar Styles */
        .search-container {
            flex: 1;
            max-width: 500px;
            margin: 0 20px;
        }

        .modern-search-wrapper {
            width: 100%;
        }

        .modern-search-bar {
            background: #1A3A5C;
            border-radius: 56px;
            padding: 4px;
            display: flex;
            align-items: center;
            gap: 8px;
            border: 1.5px solid rgba(99, 102, 241, 0.4);
            box-shadow: 0 0 0 0 rgba(99, 102, 241, 0);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            backdrop-filter: blur(10px);
        }

        .modern-search-bar:hover {
            border-color: rgba(99, 102, 241, 0.7);
            box-shadow: 0 0 15px rgba(99, 102, 241, 0.2);
        }

        .modern-search-bar:focus-within {
            border-color: #6366f1;
            box-shadow: 0 0 20px rgba(99, 102, 241, 0.4), 0 0 0 3px rgba(99, 102, 241, 0.1);
            transform: scale(1.02);
        }

        .search-icon-wrapper {
            padding: 12px 0 12px 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: rgba(165, 180, 252, 0.8);
            transition: color 0.3s ease;
        }

        .modern-search-bar:focus-within .search-icon-wrapper i {
            color: #818cf8;
        }

        .search-icon-wrapper i {
            font-size: 18px;
            transition: color 0.3s ease;
        }

        .modern-search-input {
            flex: 1;
            background: transparent !important;
            border: none !important;
            outline: none !important;
            padding: 14px 0;
            font-size: 15px;
            color: #ffffff !important;
            font-weight: 500;
            letter-spacing: 0.3px;
            width: 100%;
        }

        .modern-search-input::placeholder {
            color: rgba(165, 180, 252, 0.5);
            font-weight: 400;
            letter-spacing: 0.2px;
        }

        .modern-search-input:focus {
            box-shadow: none !important;
            outline: none !important;
            background: transparent !important;
        }

        .modern-search-btn {
            background: linear-gradient(135deg, #4f46e5, #6366f1);
            border: none;
            border-radius: 48px;
            padding: 10px 28px;
            margin: 4px;
            color: white;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            letter-spacing: 0.5px;
            position: relative;
            overflow: hidden;
            z-index: 1;
        }

        .modern-search-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #6366f1, #818cf8);
            transition: left 0.3s ease;
            z-index: -1;
        }

        .modern-search-btn:hover::before {
            left: 0;
        }

        .modern-search-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(79, 70, 229, 0.4);
        }

        .modern-search-btn:active {
            transform: translateY(1px);
        }

        body.dark-mode .modern-search-bar {
            background: linear-gradient(135deg, rgba(15, 23, 42, 0.95), rgba(30, 27, 75, 0.95));
            border-color: rgba(99, 102, 241, 0.5);
        }

        /* Post Announcement Button */
        .post-announcement-btn {
            background: linear-gradient(135deg, #1a3a5c, #2c5a7a);
            border: none;
            border-radius: 30px;
            padding: 14px 28px;
            color: white;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s;
            width: 100%;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .post-announcement-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(26,58,92,0.3);
            background: linear-gradient(135deg, #234f78, #3a6f94);
        }

        /* Notification Bell */
        .notification-bell {
            position: relative;
            cursor: pointer;
            background: #f8fafc;
            width: 42px;
            height: 42px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1.5px solid rgba(26,58,92,0.2);
            transition: all 0.3s;
        }

        .notification-bell:hover {
            background: #e8f0fe;
        }

        .bell-icon {
            font-size: 20px;
            color: #1a3a5c;
        }

        .badge-red {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #dc2626;
            color: white;
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
            background: #f8fafc;
            padding: 6px 18px;
            border-radius: 40px;
            border: 1.5px solid rgba(26,58,92,0.2);
        }

        .avatar {
            width: 36px;
            height: 36px;
            background: linear-gradient(135deg, #1a3a5c, #2c5a7a);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }

        .user-details {
            color: #1a2a3a;
        }

        .user-name {
            font-size: 14px;
            font-weight: 600;
        }

        .user-role {
            font-size: 11px;
            color: #7a8e9e;
        }

        /* Main Layout */
        .main-layout {
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 25px;
        }

        /* Cards */
        .card {
            background: white;
            border-radius: 24px;
            border: 1.5px solid rgba(26,58,92,0.25);
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            overflow: hidden;
        }

        .card-header {
            padding: 18px 22px;
            border-bottom: 1px solid #eef2f6;
            font-weight: 700;
            color: #1a3a5c;
            font-size: 16px;
        }

        .card-header i {
            margin-right: 10px;
            color: #1a3a5c;
        }

        /* Profile Section */
        .profile-section {
            text-align: center;
            padding: 25px 20px;
            border-bottom: 1px solid #eef2f6;
        }

        .profile-avatar {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, #1a3a5c, #2c5a7a);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 12px;
            font-size: 28px;
            color: white;
        }

        .profile-name {
            font-size: 18px;
            font-weight: 700;
            color: #1a3a5c;
        }

        .profile-email {
            font-size: 12px;
            color: #7a8e9e;
            margin-top: 5px;
        }

        .menu-item {
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
            color: #2c3e50;
            transition: all 0.3s;
            border-left: 3px solid transparent;
        }

        .menu-item:hover {
            background: #f8fafc;
            color: #1a3a5c;
        }

        .dropdown-icon {
            margin-left: auto;
            font-size: 12px;
            color: #b0c4de;
        }

        .dropdown-content {
            margin-left: 45px;
            display: none;
        }

        .dropdown-item {
            display: block;
            padding: 10px 22px;
            color: #5a6e7c;
            font-size: 13px;
            cursor: pointer;
            background: none;
            border: none;
            width: 100%;
            text-align: left;
            transition: all 0.3s;
        }

        .dropdown-item:hover {
            background: #f8fafc;
            color: #1a3a5c;
        }

        .pinned-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 22px;
            color: #2c3e50;
            font-size: 13px;
            border-bottom: 1px solid #eef2f6;
        }

        .remove-pin {
            color: #dc2626;
            background: none;
            border: none;
            cursor: pointer;
            font-size: 12px;
        }

        .settings-item {
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
            color: #2c3e50;
            transition: all 0.3s;
            border-top: 1px solid #eef2f6;
        }

        .settings-item:hover {
            background: #f8fafc;
            color: #1a3a5c;
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
        }

        .toggle-switch.active {
            background: linear-gradient(135deg, #1a3a5c, #2c5a7a);
        }

        .toggle-switch::after {
            content: '';
            width: 18px;
            height: 18px;
            background: white;
            border-radius: 50%;
            position: absolute;
            top: 2px;
            left: 2px;
            transition: all 0.3s;
        }

        .toggle-switch.active::after {
            left: 24px;
        }

        /* Announcement Cards */
        .announcement-board {
            padding: 5px;
        }

        .announcement-card {
            background: white;
            border-radius: 20px;
            margin-bottom: 20px;
            border: 1.5px solid rgba(26,58,92,0.25);
            transition: all 0.3s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.03);
            overflow: hidden;
        }

        .announcement-card:hover {
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            border-color: rgba(26,58,92,0.35);
        }

        .post-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 18px 22px 12px 22px;
        }

        .post-header-left {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .post-avatar {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #1a3a5c, #2c5a7a);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 20px;
            font-weight: bold;
            flex-shrink: 0;
        }

        .post-user-info {
            flex: 1;
        }

        .post-author {
            font-weight: 700;
            color: #1a3a5c;
            font-size: 16px;
        }

        .post-meta {
            display: flex;
            gap: 12px;
            font-size: 12px;
            color: #7a8e9e;
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
            color: #b0c4de;
            padding: 8px;
            border-radius: 50%;
            transition: all 0.3s;
            width: 36px;
            height: 36px;
        }

        .pin-btn-top.pinned {
            color: #e65100;
        }

        .post-content {
            padding: 0 22px 16px 22px;
        }

        .post-title {
            font-size: 18px;
            font-weight: 700;
            color: #1a3a5c;
            margin-bottom: 10px;
        }

        .post-text {
            color: #2c3e50;
            line-height: 1.5;
            margin-bottom: 12px;
        }

        .post-image img {
            width: 100%;
            max-height: 300px;
            object-fit: cover;
            border-radius: 16px;
            margin-top: 12px;
        }

        .post-stats {
            display: flex;
            gap: 20px;
            padding: 10px 22px;
            border-top: 1px solid #eef2f6;
            border-bottom: 1px solid #eef2f6;
            color: #7a8e9e;
            font-size: 13px;
        }

        .post-stats span {
            display: flex;
            align-items: center;
            gap: 6px;
            cursor: pointer;
        }

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
            color: #5a6e7c;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.3s;
        }

        .action-btn:hover {
            background: #f0f2f5;
            color: #1a3a5c;
        }

        .comments-section {
            padding: 0 22px 18px 22px;
            border-top: 1px solid #eef2f6;
            display: none;
        }

        .comments-section.show {
            display: block;
        }

        .comment-input {
            display: flex;
            gap: 10px;
            margin: 15px 0;
        }

        .comment-input input {
            flex: 1;
            padding: 10px 16px;
            background: #f8fafc;
            border: 1px solid #dce4ec;
            border-radius: 30px;
            outline: none;
            font-size: 13px;
        }

        .comment-input button {
            padding: 10px 22px;
            background: linear-gradient(135deg, #1a3a5c, #2c5a7a);
            border: none;
            border-radius: 30px;
            cursor: pointer;
            font-weight: 600;
            color: white;
        }

        .comment {
            padding: 10px 0;
            font-size: 13px;
            border-bottom: 1px solid #eef2f6;
            display: flex;
            gap: 10px;
        }

        .comment-avatar {
            width: 32px;
            height: 32px;
            background: #e8f0fe;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            color: #1a3a5c;
            font-weight: bold;
        }

        /* Notification Dropdown */
        .notification-dropdown {
            position: absolute;
            top: 70px;
            right: 30px;
            width: 320px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            border: 1px solid rgba(26,58,92,0.1);
            z-index: 200;
            display: none;
        }

        .notification-dropdown.show {
            display: block;
        }

        .notification-header {
            padding: 15px 18px;
            border-bottom: 1px solid #eef2f6;
            font-weight: 600;
            color: #1a3a5c;
            display: flex;
            justify-content: space-between;
            align-items: center;
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

        .notification-item.unread {
            background: #e8f0fe;
        }

        .notification-dot {
            width: 8px;
            height: 8px;
            background: #dc2626;
            border-radius: 50%;
        }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background: white;
            border-radius: 24px;
            max-width: 400px;
            width: 90%;
            padding: 30px;
            text-align: center;
        }

        .modal-icon {
            font-size: 50px;
            color: #1a3a5c;
            margin-bottom: 15px;
        }

        .modal-title {
            font-size: 24px;
            font-weight: 700;
            color: #1a3a5c;
            margin-bottom: 10px;
        }

        .modal-text {
            color: #5a6e7c;
            line-height: 1.6;
            margin: 15px 0;
        }

        .modal-close {
            background: linear-gradient(135deg, #1a3a5c, #2c5a7a);
            border: none;
            padding: 10px 28px;
            border-radius: 30px;
            color: white;
            font-weight: 600;
            cursor: pointer;
        }

        /* Create Post Box */
        .create-post-card {
            background: white;
            border-radius: 24px;
            padding: 18px 22px;
            margin-bottom: 25px;
            border: 1.5px solid rgba(26,58,92,0.25);
        }

        .create-post-header {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .create-post-avatar {
            width: 48px;
            height: 48px;
            background: linear-gradient(135deg, #1a3a5c, #2c5a7a);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 20px;
        }

        .create-post-input {
            flex: 1;
            background: #f8fafc;
            border: 1px solid #dce4ec;
            border-radius: 40px;
            padding: 12px 20px;
            font-size: 14px;
            color: #1a2a3a;
            cursor: pointer;
        }

        /* Footer */
        .footer {
            text-align: center;
            padding: 20px;
            color: #8a9bb0;
            font-size: 12px;
            margin-top: 20px;
        }

        @media (max-width: 900px) {
            .main-layout {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .search-container {
                max-width: 100%;
                margin: 10px 0;
                order: 3;
                width: 100%;
            }
            
            .modern-search-bar {
                padding: 2px;
            }
            
            .search-icon-wrapper {
                padding: 10px 0 10px 14px;
            }
            
            .modern-search-input {
                padding: 10px 0;
                font-size: 13px;
            }
            
            .modern-search-btn {
                padding: 8px 20px;
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Header -->
        <div class="header">
            <div class="logo">
                <i class="fas fa-chalkboard-teacher"></i> CampusConnect Teacher
            </div>
            
            <!-- Modern Search Bar -->
            <div class="search-container">
                <div class="modern-search-wrapper">
                    <div class="modern-search-bar">
                        <div class="search-icon-wrapper">
                            <i class="fas fa-search"></i>
                        </div>
                        <asp:TextBox ID="searchInput" runat="server" 
                            CssClass="modern-search-input" 
                            placeholder="Search announcements..." 
                            AutoPostBack="false">
                        </asp:TextBox>
                        <asp:Button ID="searchBtn" runat="server" 
                            CssClass="modern-search-btn" 
                            Text="Search" 
                            OnClientClick="performSearchAndRedirect(); return false;" />
                    </div>
                </div>
            </div>
            
            <div style="display: flex; gap: 15px; align-items: center;">
                <div class="notification-bell" onclick="toggleNotificationDropdown()">
                    <i class="fas fa-bell bell-icon"></i>
                    <span id="notificationBadge" class="badge-red">3</span>
                </div>
                <div class="user-info">
                    <div class="avatar">
                        <i class="fas fa-user"></i>
                    </div>
                    <div class="user-details">
                        <div class="user-name">John Dela Cruz</div>
                        <div class="user-role">Teacher</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Notification Dropdown -->
        <div id="notificationDropdown" class="notification-dropdown">
            <div class="notification-header">
                <span><i class="fas fa-bell"></i> Notifications</span>
                <button onclick="markAllRead()">Mark all read</button>
            </div>
            <div class="notification-list">
                <div class="notification-item unread" onclick="markRead(this)">
                    <div class="notification-dot"></div>
                    <div class="notification-text">New exam schedule announced</div>
                    <div class="notification-time">2 hours ago</div>
                </div>
                <div class="notification-item unread" onclick="markRead(this)">
                    <div class="notification-dot"></div>
                    <div class="notification-text">Class suspension due to typhoon</div>
                    <div class="notification-time">1 day ago</div>
                </div>
                <div class="notification-item" onclick="markRead(this)">
                    <div class="notification-text">Foundation Week activities posted</div>
                    <div class="notification-time">3 days ago</div>
                </div>
            </div>
        </div>

        <!-- Main Layout -->
        <div class="main-layout">
            <!-- LEFT SIDEBAR -->
            <aside>
                <div class="card">
                    <div class="profile-section">
                        <div class="profile-avatar">
                            <i class="fas fa-user-graduate"></i>
                        </div>
                        <div class="profile-name">John Dela Cruz</div>
                        <div class="profile-email">john.delacruz@ctu.edu.ph</div>
                    </div>

                    <div class="card-header">
                        <i class="fas fa-filter"></i> Filters
                    </div>
                    <div class="menu-item" onclick="toggleDropdown('categoryDropdown')">
                        <i class="fas fa-layer-group"></i> Filter by Category
                        <i class="fas fa-chevron-down dropdown-icon"></i>
                    </div>
                    <div id="categoryDropdown" class="dropdown-content">
                        <button class="dropdown-item" onclick="filterCategory('All')">All Announcements</button>
                        <button class="dropdown-item" onclick="filterCategory('Exam')">Exam Schedule</button>
                        <button class="dropdown-item" onclick="filterCategory('Suspension')">Class Suspension</button>
                        <button class="dropdown-item" onclick="filterCategory('Event')">Campus Events</button>
                    </div>

                    <div class="card-header">
                        <i class="fas fa-thumbtack"></i> Pinned Items
                    </div>
                    <div class="menu-item" onclick="toggleDropdown('pinnedDropdown')">
                        <i class="fas fa-list"></i> View Pinned Items
                        <i class="fas fa-chevron-down dropdown-icon"></i>
                    </div>
                    <div id="pinnedDropdown" class="dropdown-content">
                        <div class="pinned-item">
                            <div><i class="fas fa-thumbtack"></i> Final Exam Schedule</div>
                            <button class="remove-pin" onclick="removePin(this)">✕</button>
                        </div>
                        <div class="pinned-item">
                            <div><i class="fas fa-thumbtack"></i> Class Suspension</div>
                            <button class="remove-pin" onclick="removePin(this)">✕</button>
                        </div>
                    </div>

                    <div class="card-header">
                        <i class="fas fa-cog"></i> Settings
                    </div>
                    
                    <div class="settings-item" onclick="toggleTheme()">
                        <i class="fas fa-moon"></i> Dark / Light Mode
                        <div class="toggle-switch" id="themeToggle"></div>
                    </div>
                    
                    <div class="settings-item" onclick="openAboutModal()">
                        <i class="fas fa-info-circle"></i> About Us
                    </div>
                    
                    <div class="settings-item" onclick="logout()">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </div>
                </div>
            </aside>

            <main>
                <button class="post-announcement-btn" onclick="openCreatePostModal()">
                    <i class="fas fa-plus-circle"></i> Want to post an announcement?
                </button>

                <div class="create-post-card">
                    <div class="create-post-header">
                        <div class="create-post-avatar">
                            <i class="fas fa-user-edit"></i>
                        </div>
                        <div class="create-post-input" onclick="openCreatePostModal()">
                            Want to post an announcement?
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-bullhorn"></i> Announcement Board
                        <span style="float: right; font-size: 12px;">Showing: <span id="activeFilterLabel">All</span></span>
                    </div>

                    <div id="announcementsContainer" class="announcement-board">
                        <!-- Announcement 1 - Exam -->
                        <div class="announcement-card" data-category="Exam" data-post-id="1">
                            <div class="post-header">
                                <div class="post-header-left">
                                    <div class="post-avatar">
                                        <i class="fas fa-user-tie"></i>
                                    </div>
                                    <div class="post-user-info">
                                        <div class="post-author">Prof. Michael Reyes</div>
                                        <div class="post-meta">
                                            <span><i class="far fa-calendar-alt"></i> December 10, 2024</span>
                                            <span><i class="far fa-clock"></i> 9:00 AM</span>
                                            <span class="post-category post-category-exam">Exam</span>
                                        </div>
                                    </div>
                                </div>
                                <button class="pin-btn-top pinned" onclick="togglePinTop(this)"><i class="fas fa-thumbtack"></i></button>
                            </div>
                            <div class="post-content">
                                <div class="post-title">Final Exam Schedule</div>
                                <div class="post-text">The final examinations will be held on December 15-20, 2024. Please check your respective departments for room assignments.</div>
                                <div class="post-image">
                                    <img src="https://placehold.co/600x300/1a3a5c/white?text=Exam+Schedule" alt="Exam Schedule" />
                                </div>
                            </div>
                            <div class="post-stats">
                                <span onclick="toggleLikeFromStats(this)"><i class="far fa-heart"></i> <span class="like-count">24</span> Likes</span>
                                <span onclick="scrollToComments(this)"><i class="far fa-comment"></i> <span class="comment-count">2</span> Comments</span>
                                <span onclick="sharePost()"><i class="far fa-share-square"></i> <span class="share-count">5</span> Shares</span>
                            </div>
                            <div class="action-buttons">
                                <button class="action-btn" onclick="toggleLike(this)"><i class="far fa-heart"></i> Like</button>
                                <button class="action-btn" onclick="toggleComments(this)"><i class="far fa-comment"></i> Comment</button>
                                <button class="action-btn" onclick="sharePost()"><i class="fas fa-share"></i> Share</button>
                            </div>
                            <div class="comments-section">
                                <div class="comment-input">
                                    <input type="text" placeholder="Write a comment..." />
                                    <button onclick="addComment(this)">Post</button>
                                </div>
                                <div class="comments-list">
                                    <div class="comment">
                                        <div class="comment-avatar"><i class="fas fa-user"></i></div>
                                        <div class="comment-content">
                                            <span class="comment-author">Juan Dela Cruz</span>
                                            <div class="comment-text">Thank you for the update!</div>
                                            <div class="comment-time">December 8, 2024</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Announcement 2 - Suspension -->
                        <div class="announcement-card" data-category="Suspension" data-post-id="2">
                            <div class="post-header">
                                <div class="post-header-left">
                                    <div class="post-avatar">
                                        <i class="fas fa-building"></i>
                                    </div>
                                    <div class="post-user-info">
                                        <div class="post-author">Admin Office</div>
                                        <div class="post-meta">
                                            <span><i class="far fa-calendar-alt"></i> November 24, 2024</span>
                                            <span><i class="far fa-clock"></i> 6:00 AM</span>
                                            <span class="post-category post-category-suspension">Suspension</span>
                                        </div>
                                    </div>
                                </div>
                                <button class="pin-btn-top pinned" onclick="togglePinTop(this)"><i class="fas fa-thumbtack"></i></button>
                            </div>
                            <div class="post-content">
                                <div class="post-title">Class Suspension - Typhoon Enteng</div>
                                <div class="post-text">Due to Typhoon Enteng, classes in all levels are suspended tomorrow, November 25, 2024. Stay safe and monitor for further announcements.</div>
                                <div class="post-image">
                                    <img src="https://placehold.co/600x300/ef4444/white?text=Weather+Advisory" alt="Weather Advisory" />
                                </div>
                            </div>
                            <div class="post-stats">
                                <span onclick="toggleLikeFromStats(this)"><i class="far fa-heart"></i> <span class="like-count">56</span> Likes</span>
                                <span onclick="scrollToComments(this)"><i class="far fa-comment"></i> <span class="comment-count">1</span> Comments</span>
                                <span onclick="sharePost()"><i class="far fa-share-square"></i> <span class="share-count">12</span> Shares</span>
                            </div>
                            <div class="action-buttons">
                                <button class="action-btn" onclick="toggleLike(this)"><i class="far fa-heart"></i> Like</button>
                                <button class="action-btn" onclick="toggleComments(this)"><i class="far fa-comment"></i> Comment</button>
                                <button class="action-btn" onclick="sharePost()"><i class="fas fa-share"></i> Share</button>
                            </div>
                            <div class="comments-section">
                                <div class="comment-input">
                                    <input type="text" placeholder="Write a comment..." />
                                    <button onclick="addComment(this)">Post</button>
                                </div>
                                <div class="comments-list">
                                    <div class="comment">
                                        <div class="comment-avatar"><i class="fas fa-user"></i></div>
                                        <div class="comment-content">
                                            <span class="comment-author">John Santos</span>
                                            <div class="comment-text">Stay safe everyone!</div>
                                            <div class="comment-time">November 24, 2024</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Announcement 3 - Event -->
                        <div class="announcement-card" data-category="Event" data-post-id="3">
                            <div class="post-header">
                                <div class="post-header-left">
                                    <div class="post-avatar">
                                        <i class="fas fa-calendar-alt"></i>
                                    </div>
                                    <div class="post-user-info">
                                        <div class="post-author">Student Affairs Office</div>
                                        <div class="post-meta">
                                            <span><i class="far fa-calendar-alt"></i> November 20, 2024</span>
                                            <span><i class="far fa-clock"></i> 10:00 AM</span>
                                            <span class="post-category post-category-event">Event</span>
                                        </div>
                                    </div>
                                </div>
                                <button class="pin-btn-top" onclick="togglePinTop(this)"><i class="fas fa-thumbtack"></i></button>
                            </div>
                            <div class="post-content">
                                <div class="post-title">University Foundation Week 2024</div>
                                <div class="post-text">Join us for the annual University Foundation Week celebration on December 1-5, 2024. Activities include parade, talent show, sportsfest, and concert.</div>
                                <div class="post-image">
                                    <img src="https://placehold.co/600x300/10b981/white?text=Foundation+Week" alt="Foundation Week" />
                                </div>
                            </div>
                            <div class="post-stats">
                                <span onclick="toggleLikeFromStats(this)"><i class="far fa-heart"></i> <span class="like-count">89</span> Likes</span>
                                <span onclick="scrollToComments(this)"><i class="far fa-comment"></i> <span class="comment-count">0</span> Comments</span>
                                <span onclick="sharePost()"><i class="far fa-share-square"></i> <span class="share-count">23</span> Shares</span>
                            </div>
                            <div class="action-buttons">
                                <button class="action-btn" onclick="toggleLike(this)"><i class="far fa-heart"></i> Like</button>
                                <button class="action-btn" onclick="toggleComments(this)"><i class="far fa-comment"></i> Comment</button>
                                <button class="action-btn" onclick="sharePost()"><i class="fas fa-share"></i> Share</button>
                            </div>
                            <div class="comments-section">
                                <div class="comment-input">
                                    <input type="text" placeholder="Write a comment..." />
                                    <button onclick="addComment(this)">Post</button>
                                </div>
                                <div class="comments-list">
                                    <div class="no-comments">No comments yet. Be the first!</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <div class="footer">
            <i class="fas fa-shield-alt"></i> Secure Portal | Cebu Technological University | © 2024 Campus Connect
        </div>

        <!-- About Us Modal -->
        <div id="aboutModal" class="modal">
            <div class="modal-content">
                <div class="modal-icon">
                    <i class="fas fa-university"></i>
                </div>
                <div class="modal-title">Campus Connect</div>
                <div class="modal-text">
                    Campus Connect is a centralized web-based announcement system for Cebu Technological University.
                </div>
                <button class="modal-close" onclick="closeAboutModal()">Close</button>
            </div>
        </div>
    </form>

    <script>
        // Search and Redirect Function
        function performSearchAndRedirect() {
            var searchTerm = document.getElementById('<%= searchInput.ClientID %>').value;
            
            if (searchTerm.trim() !== '') {
                window.location.href = 'SearchDashboard.aspx?query=' + encodeURIComponent(searchTerm);
            } else {
                showToast('Please enter a search term');
            }
        }

        // Enter key handler
        document.addEventListener('DOMContentLoaded', function() {
            var searchInput = document.getElementById('<%= searchInput.ClientID %>');
            if (searchInput) {
                searchInput.addEventListener('keypress', function (e) {
                    if (e.key === 'Enter') {
                        e.preventDefault();
                        performSearchAndRedirect();
                    }
                });
            }
        });

        function showToast(message) {
            var toast = document.createElement('div');
            toast.style.position = 'fixed';
            toast.style.bottom = '20px';
            toast.style.right = '20px';
            toast.style.backgroundColor = '#4f46e5';
            toast.style.color = 'white';
            toast.style.padding = '12px 24px';
            toast.style.borderRadius = '30px';
            toast.style.fontSize = '14px';
            toast.style.zIndex = '9999';
            toast.style.boxShadow = '0 4px 12px rgba(0,0,0,0.3)';
            toast.innerHTML = message;
            document.body.appendChild(toast);

            setTimeout(function () {
                toast.style.opacity = '0';
                toast.style.transition = 'opacity 0.3s';
                setTimeout(function () { toast.remove(); }, 300);
            }, 2000);
        }

        function toggleDropdown(id) {
            var dropdown = document.getElementById(id);
            dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
        }

        function toggleNotificationDropdown() {
            document.getElementById('notificationDropdown').classList.toggle('show');
        }

        function filterCategory(category) {
            var cards = document.querySelectorAll('.announcement-card');
            document.getElementById('activeFilterLabel').innerText = category;
            cards.forEach(function (card) {
                card.style.display = (category === 'All' || card.dataset.category === category) ? 'block' : 'none';
            });
            document.getElementById('categoryDropdown').style.display = 'none';
        }

        function toggleLike(btn) {
            btn.classList.toggle('liked');
            var icon = btn.querySelector('i');
            icon.className = btn.classList.contains('liked') ? 'fas fa-heart' : 'far fa-heart';
            btn.innerHTML = btn.classList.contains('liked') ? '<i class="fas fa-heart"></i> Liked' : '<i class="far fa-heart"></i> Like';

            var card = btn.closest('.announcement-card');
            var likeCount = card.querySelector('.like-count');
            var current = parseInt(likeCount.innerText);
            likeCount.innerText = btn.classList.contains('liked') ? current + 1 : current - 1;
        }

        function toggleLikeFromStats(span) {
            var card = span.closest('.announcement-card');
            var likeBtn = card.querySelector('.action-btn:first-child');
            toggleLike(likeBtn);
        }

        function toggleComments(btn) {
            btn.closest('.announcement-card').querySelector('.comments-section').classList.toggle('show');
        }

        function scrollToComments(element) {
            var card = element.closest('.announcement-card');
            var comments = card.querySelector('.comments-section');
            comments.classList.add('show');
            comments.scrollIntoView({ behavior: 'smooth' });
        }

        function addComment(btn) {
            var input = btn.parentElement.querySelector('input');
            var comment = input.value.trim();
            if (comment) {
                var card = btn.closest('.announcement-card');
                var list = card.querySelector('.comments-list');
                var noComments = list.querySelector('.no-comments');
                if (noComments) noComments.remove();

                var newComment = document.createElement('div');
                newComment.className = 'comment';
                newComment.innerHTML = '<div class="comment-avatar"><i class="fas fa-user"></i></div>' +
                    '<div class="comment-content">' +
                    '<span class="comment-author">You</span>' +
                    '<div class="comment-text">' + comment + '</div>' +
                    '<div class="comment-time">Just now</div>' +
                    '</div>';
                list.appendChild(newComment);

                var count = card.querySelector('.comment-count');
                count.innerText = parseInt(count.innerText) + 1;
                input.value = '';
                showToast('Comment posted!');
            }
        }

        function sharePost() {
            showToast('Share feature coming soon!');
        }

        function togglePinTop(btn) {
            btn.classList.toggle('pinned');
            showToast(btn.classList.contains('pinned') ? 'Announcement pinned!' : 'Announcement unpinned!');
        }

        function removePin(btn) {
            btn.parentElement.remove();
            showToast('Removed from pinned items');
        }

        function markRead(item) {
            item.classList.remove('unread');
            var dot = item.querySelector('.notification-dot');
            if (dot) dot.remove();
            updateBadge();
        }

        function markAllRead() {
            document.querySelectorAll('.notification-item.unread').forEach(markRead);
        }

        function updateBadge() {
            var count = document.querySelectorAll('.notification-item.unread').length;
            var badge = document.getElementById('notificationBadge');
            if (count > 0) {
                badge.innerText = count;
                badge.style.display = 'inline-block';
            } else {
                badge.style.display = 'none';
            }
        }

        function toggleTheme() {
            document.body.classList.toggle('dark-mode');
            var toggle = document.querySelector('.toggle-switch');
            toggle.classList.toggle('active');
        }

        function openAboutModal() {
            document.getElementById('aboutModal').style.display = 'flex';
        }

        function closeAboutModal() {
            document.getElementById('aboutModal').style.display = 'none';
        }

        function openCreatePostModal() {
            showToast('Create post feature coming soon!');
        }

        function logout() {
            if (confirm('Are you sure you want to logout?')) {
                window.location.href = 'login.aspx';
            }
        }

        document.addEventListener('click', function (e) {
            var dropdown = document.getElementById('notificationDropdown');
            var bell = document.querySelector('.notification-bell');
            if (dropdown && bell && !bell.contains(e.target) && !dropdown.contains(e.target)) {
                dropdown.classList.remove('show');
            }
        });
    </script>
</body>
</html>