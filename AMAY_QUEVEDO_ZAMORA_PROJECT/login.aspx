<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Student" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Campus Announcement - Student Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #e8f0fe 0%, #d4e0f0 100%);
            min-height: 100vh;
            padding: 20px;
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
            border: 1px solid rgba(26,58,92,0.1);
        }

        .logo {
            font-size: 22px;
            font-weight: 800;
            background: linear-gradient(135deg, #1a3a5c, #2c5a7a);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .logo i {
            background: none;
            -webkit-background-clip: unset;
            color: #1a3a5c;
            margin-right: 8px;
        }

        .search-container {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .search-box {
            background: #f8fafc;
            border-radius: 30px;
            padding: 10px 18px;
            width: 280px;
            display: flex;
            align-items: center;
            gap: 10px;
            border: 1px solid #dce4ec;
        }

        .search-box input {
            background: none;
            border: none;
            outline: none;
            width: 100%;
            font-size: 14px;
            color: #1a2a3a;
        }

        .search-box input::placeholder {
            color: #b0c4de;
        }

        .search-box i {
            color: #1a3a5c;
        }

        .search-btn {
            background: linear-gradient(135deg, #1a3a5c, #2c5a7a);
            border: none;
            border-radius: 30px;
            padding: 10px 22px;
            color: white;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(26,58,92,0.2);
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
            border: 1px solid #dce4ec;
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
            border: 1px solid #dce4ec;
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
            border: 1px solid rgba(26,58,92,0.1);
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

        /* Menu Items */
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

        .menu-item.active {
            background: #e8f0fe;
            color: #1a3a5c;
            border-left-color: #1a3a5c;
        }

        .dropdown-icon {
            margin-left: auto;
            font-size: 12px;
            color: #b0c4de;
        }

        /* Dropdown Content */
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

        /* Pinned Items */
        .pinned-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 22px;
            color: #2c3e50;
            font-size: 13px;
            border-bottom: 1px solid #eef2f6;
        }

        .pinned-item i {
            color: #fbbf24;
            margin-right: 10px;
        }

        .remove-pin {
            color: #dc2626;
            background: none;
            border: none;
            cursor: pointer;
            font-size: 12px;
        }

        /* Settings Items */
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

        /* Toggle Switch */
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
            padding: 22px;
            margin-bottom: 20px;
            border: 1px solid rgba(26,58,92,0.08);
            transition: all 0.3s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.03);
        }

        .announcement-card:hover {
            transform: translateX(5px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            border-color: rgba(26,58,92,0.2);
        }

        .badge-group {
            margin-bottom: 12px;
        }

        .badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            margin-right: 8px;
        }

        .badge-exam { background: #e3f2fd; color: #1976d2; }
        .badge-suspension { background: #ffebee; color: #c62828; }
        .badge-event { background: #e8f5e9; color: #2e7d32; }
        .badge-pinned { background: #fff3e0; color: #e65100; }

        .announcement-title {
            font-size: 18px;
            font-weight: 700;
            color: #1a3a5c;
            margin-bottom: 8px;
        }

        .announcement-meta {
            display: flex;
            gap: 20px;
            font-size: 12px;
            color: #7a8e9e;
            margin-bottom: 12px;
        }

        .announcement-content {
            color: #2c3e50;
            line-height: 1.5;
            margin-bottom: 16px;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            padding-top: 12px;
            border-top: 1px solid #eef2f6;
        }

        .action-btn {
            background: #f8fafc;
            border: none;
            padding: 6px 16px;
            border-radius: 30px;
            cursor: pointer;
            font-size: 13px;
            color: #5a6e7c;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
        }

        .action-btn:hover {
            background: #e8f0fe;
            color: #1a3a5c;
        }

        /* Comments Section */
        .comments-section {
            margin-top: 16px;
            padding-top: 16px;
            border-top: 1px solid #eef2f6;
            display: none;
        }

        .comments-section.show {
            display: block;
        }

        .comment-input {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
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
            padding: 8px 0;
            font-size: 13px;
            border-bottom: 1px solid #eef2f6;
            color: #2c3e50;
        }

        .comment-author {
            font-weight: bold;
            color: #1a3a5c;
        }

        .no-comments {
            padding: 15px;
            text-align: center;
            color: #b0c4de;
            font-size: 12px;
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

        .notification-header button {
            background: none;
            border: none;
            color: #1a3a5c;
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

        .notification-item:hover {
            background: #f8fafc;
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

        .notification-text {
            flex: 1;
            font-size: 13px;
            color: #2c3e50;
        }

        .notification-time {
            font-size: 10px;
            color: #b0c4de;
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
            font-size: 13px;
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

        /* Footer */
        .footer {
            text-align: center;
            padding: 20px;
            color: #8a9bb0;
            font-size: 12px;
            margin-top: 20px;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 50px;
            color: #b0c4de;
        }

        .empty-state i {
            font-size: 48px;
            margin-bottom: 15px;
        }

        /* Responsive */
        @media (max-width: 900px) {
            .main-layout {
                grid-template-columns: 1fr;
            }
            .search-container {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="bubbles"></div>

    <form id="form1" runat="server">
        <!-- Header -->
        <div class="header">
            <div class="logo">
                <i class="fas fa-university"></i> Campus Announcement
            </div>
            <div class="search-container">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchInput" placeholder="Search announcements..." />
                </div>
                <button class="search-btn" onclick="searchAnnouncements()"><i class="fas fa-search"></i> Search</button>
            </div>
            <div style="display: flex; gap: 15px; align-items: center;">
                <!-- Notification Bell -->
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
                        <div class="user-role">Student</div>
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
                    <div class="notification-text">📝 New exam schedule announced</div>
                    <div class="notification-time">2 hours ago</div>
                </div>
                <div class="notification-item unread" onclick="markRead(this)">
                    <div class="notification-dot"></div>
                    <div class="notification-text">⚠️ Class suspension due to typhoon</div>
                    <div class="notification-time">1 day ago</div>
                </div>
                <div class="notification-item" onclick="markRead(this)">
                    <div class="notification-text">🎉 Foundation Week activities posted</div>
                    <div class="notification-time">3 days ago</div>
                </div>
            </div>
        </div>

        <!-- Main Layout -->
        <div class="main-layout">
            <!-- LEFT SIDEBAR -->
            <aside>
                <div class="card">
                    <!-- Profile -->
                    <div class="profile-section">
                        <div class="profile-avatar">
                            <i class="fas fa-user-graduate"></i>
                        </div>
                        <div class="profile-name">John Dela Cruz</div>
                        <div class="profile-email">john.delacruz@ctu.edu.ph</div>
                    </div>

                    <!-- Category Dropdown -->
                    <div class="card-header">
                        <i class="fas fa-filter"></i> Filters
                    </div>
                    <div class="menu-item" onclick="toggleDropdown('categoryDropdown')">
                        <i class="fas fa-layer-group"></i> Filter by Category
                        <i class="fas fa-chevron-down dropdown-icon"></i>
                    </div>
                    <div id="categoryDropdown" class="dropdown-content">
                        <button class="dropdown-item" onclick="filterCategory('All')">📋 All Announcements</button>
                        <button class="dropdown-item" onclick="filterCategory('Exam')">📝 Exam Schedule</button>
                        <button class="dropdown-item" onclick="filterCategory('Suspension')">⚠️ Class Suspension</button>
                        <button class="dropdown-item" onclick="filterCategory('Event')">🎉 Campus Events</button>
                    </div>

                    <!-- Pinned Items -->
                    <div class="card-header" style="margin-top: 5px;">
                        <i class="fas fa-thumbtack"></i> Pinned Items
                    </div>
                    <div id="pinnedContainer">
                        <div class="pinned-item">
                            <div><i class="fas fa-thumbtack"></i> Final Exam Schedule</div>
                            <button class="remove-pin" onclick="removePin(this)">✕</button>
                        </div>
                        <div class="pinned-item">
                            <div><i class="fas fa-thumbtack"></i> Class Suspension</div>
                            <button class="remove-pin" onclick="removePin(this)">✕</button>
                        </div>
                    </div>

                    <!-- Settings -->
                    <div class="card-header" style="margin-top: 5px;">
                        <i class="fas fa-cog"></i> Settings
                    </div>
                    
                    <!-- Dark/Light Mode -->
                    <div class="settings-item" onclick="toggleTheme(this)">
                        <i class="fas fa-moon"></i> Dark / Light Mode
                        <div class="toggle-switch" id="themeToggle"></div>
                    </div>
                    
                    <!-- About Us -->
                    <div class="settings-item" onclick="openAboutModal()">
                        <i class="fas fa-info-circle"></i> About Us
                    </div>
                    
                    <!-- Logout -->
                    <div class="settings-item" onclick="logout()">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </div>
                </div>
            </aside>

            <!-- MAIN CONTENT - Announcement Board -->
            <main>
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-bullhorn"></i> Announcement Board
                        <span style="float: right; font-size: 12px; color: #1a3a5c;">Showing: <span id="activeFilterLabel">All</span></span>
                    </div>

                    <!-- Announcements Container -->
                    <div id="announcementsContainer" class="announcement-board">
                        <!-- Announcement 1 - Exam -->
                        <div class="announcement-card" data-category="Exam">
                            <div class="badge-group">
                                <span class="badge badge-exam">Exam</span>
                                <span class="badge badge-pinned"><i class="fas fa-thumbtack"></i> PINNED</span>
                            </div>
                            <div class="announcement-title">Final Exam Schedule</div>
                            <div class="announcement-meta">
                                <span><i class="far fa-calendar-alt"></i> December 15-20, 2024</span>
                                <span><i class="fas fa-user"></i> Admin</span>
                            </div>
                            <div class="announcement-content">
                                The final examinations will be held on December 15-20, 2024. Please check your respective departments for room assignments.
                            </div>
                            <div class="action-buttons">
                                <button class="action-btn" onclick="togglePin(this)"><i class="fas fa-thumbtack"></i> Unpin</button>
                                <button class="action-btn" onclick="toggleComments(this)"><i class="fas fa-comment"></i> Comment (2)</button>
                            </div>
                            <div class="comments-section">
                                <div class="comment-input">
                                    <input type="text" placeholder="Write a comment..." />
                                    <button onclick="addComment(this)">Post</button>
                                </div>
                                <div class="comments-list">
                                    <div class="comment"><span class="comment-author">Juan Dela Cruz:</span> Thank you for the update!</div>
                                    <div class="comment"><span class="comment-author">Maria Santos:</span> What time does the exam start?</div>
                                </div>
                            </div>
                        </div>

                        <!-- Announcement 2 - Suspension -->
                        <div class="announcement-card" data-category="Suspension">
                            <div class="badge-group">
                                <span class="badge badge-suspension">Suspension</span>
                                <span class="badge badge-pinned"><i class="fas fa-thumbtack"></i> PINNED</span>
                            </div>
                            <div class="announcement-title">Class Suspension - Typhoon</div>
                            <div class="announcement-meta">
                                <span><i class="far fa-calendar-alt"></i> November 25, 2024</span>
                                <span><i class="fas fa-user"></i> Admin</span>
                            </div>
                            <div class="announcement-content">
                                Due to Typhoon Enteng, classes in all levels are suspended tomorrow, November 25, 2024.
                            </div>
                            <div class="action-buttons">
                                <button class="action-btn" onclick="togglePin(this)"><i class="fas fa-thumbtack"></i> Unpin</button>
                                <button class="action-btn" onclick="toggleComments(this)"><i class="fas fa-comment"></i> Comment (1)</button>
                            </div>
                            <div class="comments-section">
                                <div class="comment-input">
                                    <input type="text" placeholder="Write a comment..." />
                                    <button onclick="addComment(this)">Post</button>
                                </div>
                                <div class="comments-list">
                                    <div class="comment"><span class="comment-author">John Santos:</span> Stay safe everyone!</div>
                                </div>
                            </div>
                        </div>

                        <!-- Announcement 3 - Event -->
                        <div class="announcement-card" data-category="Event">
                            <div class="badge-group">
                                <span class="badge badge-event">Event</span>
                            </div>
                            <div class="announcement-title">University Foundation Week</div>
                            <div class="announcement-meta">
                                <span><i class="far fa-calendar-alt"></i> December 1-5, 2024</span>
                                <span><i class="fas fa-user"></i> Admin</span>
                            </div>
                            <div class="announcement-content">
                                Join us for the annual University Foundation Week celebration. Activities include parade, talent show, and sportsfest.
                            </div>
                            <div class="action-buttons">
                                <button class="action-btn" onclick="togglePin(this)"><i class="fas fa-thumbtack"></i> Pin</button>
                                <button class="action-btn" onclick="toggleComments(this)"><i class="fas fa-comment"></i> Comment (0)</button>
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
                    It allows students to access official announcements, exam schedules, class suspensions, and campus events in one place.
                </div>
                <div class="modal-text">
                    <strong>Version:</strong> 1.0<br>
                    <strong>Developed for:</strong> CTU Students & Faculty
                </div>
                <button class="modal-close" onclick="closeAboutModal()">Close</button>
            </div>
        </div>
    </form>

    <script>
        // Toggle Dropdown
        function toggleDropdown(id) {
            var dropdown = document.getElementById(id);
            if (dropdown.style.display === 'none' || dropdown.style.display === '') {
                dropdown.style.display = 'block';
            } else {
                dropdown.style.display = 'none';
            }
        }

        // Toggle Notification Dropdown
        function toggleNotificationDropdown() {
            var dropdown = document.getElementById('notificationDropdown');
            dropdown.classList.toggle('show');
        }

        // Close notification dropdown when clicking outside
        document.addEventListener('click', function(e) {
            var bell = document.querySelector('.notification-bell');
            var dropdown = document.getElementById('notificationDropdown');
            if (!bell.contains(e.target) && !dropdown.contains(e.target)) {
                dropdown.classList.remove('show');
            }
        });

        // Toggle Comments
        function toggleComments(btn) {
            var card = btn.closest('.announcement-card');
            var commentsSection = card.querySelector('.comments-section');
            commentsSection.classList.toggle('show');
        }

        // Filter Category
        function filterCategory(category) {
            var announcements = document.querySelectorAll('.announcement-card');
            var filterLabel = document.getElementById('activeFilterLabel');
            
            announcements.forEach(function(ann) {
                if (category === 'All' || ann.getAttribute('data-category') === category) {
                    ann.style.display = 'block';
                } else {
                    ann.style.display = 'none';
                }
            });
            
            filterLabel.innerText = category;
            document.getElementById('categoryDropdown').style.display = 'none';
        }

        // Search Announcements
        function searchAnnouncements() {
            var searchTerm = document.getElementById('searchInput').value.toLowerCase();
            var announcements = document.querySelectorAll('.announcement-card');
            var found = false;
            
            announcements.forEach(function(ann) {
                var title = ann.querySelector('.announcement-title').innerText.toLowerCase();
                var content = ann.querySelector('.announcement-content').innerText.toLowerCase();
                
                if (title.includes(searchTerm) || content.includes(searchTerm)) {
                    ann.style.display = 'block';
                    found = true;
                } else {
                    ann.style.display = 'none';
                }
            });
            
            if (!found && searchTerm !== '') {
                alert('No announcements found matching "' + searchTerm + '"');
            }
        }

        // Enter key search
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                searchAnnouncements();
            }
        });

        // Toggle Pin
        function togglePin(btn) {
            if (btn.innerHTML.includes('Pin')) {
                btn.innerHTML = '<i class="fas fa-thumbtack"></i> Unpin';
                alert('Announcement pinned!');
            } else {
                btn.innerHTML = '<i class="fas fa-thumbtack"></i> Pin';
                alert('Announcement unpinned!');
            }
        }

        // Add Comment
        function addComment(btn) {
            var input = btn.parentElement.querySelector('input');
            var commentText = input.value.trim();
            
            if (commentText !== '') {
                var commentsList = btn.parentElement.parentElement.querySelector('.comments-list');
                var noComments = commentsList.querySelector('.no-comments');
                
                if (noComments) {
                    noComments.remove();
                }
                
                var newComment = document.createElement('div');
                newComment.className = 'comment';
                newComment.innerHTML = '<span class="comment-author">You:</span> ' + commentText;
                commentsList.appendChild(newComment);
                input.value = '';
            }
        }

        // Remove Pin
        function removePin(btn) {
            btn.parentElement.remove();
            alert('Item removed from pinned!');
        }

        // Mark Notification Read
        function markRead(item) {
            item.classList.remove('unread');
            var dot = item.querySelector('.notification-dot');
            if (dot) dot.remove();
            updateBadgeCount();
        }

        function markAllRead() {
            var notifications = document.querySelectorAll('.notification-item.unread');
            notifications.forEach(function(notif) {
                notif.classList.remove('unread');
                var dot = notif.querySelector('.notification-dot');
                if (dot) dot.remove();
            });
            updateBadgeCount();
        }

        function updateBadgeCount() {
            var unreadCount = document.querySelectorAll('.notification-item.unread').length;
            var badge = document.getElementById('notificationBadge');
            if (unreadCount > 0) {
                badge.textContent = unreadCount;
                badge.style.display = 'inline-block';
            } else {
                badge.style.display = 'none';
            }
        }

        // Theme Toggle
        function toggleTheme(item) {
            var toggle = item.querySelector('.toggle-switch');
            toggle.classList.toggle('active');
            var body = document.body;
            
            if (body.style.background === '' || body.style.background === 'linear-gradient(135deg, #e8f0fe 0%, #d4e0f0 100%)') {
                body.style.background = '#1a1a2e';
                document.querySelector('.bubbles').style.opacity = '0.3';
                // Change card backgrounds
                document.querySelectorAll('.card, .announcement-card, .header, .notification-dropdown, .modal-content').forEach(function(el) {
                    el.style.background = '#242526';
                    el.style.color = '#e4e6eb';
                });
            } else {
                body.style.background = 'linear-gradient(135deg, #e8f0fe 0%, #d4e0f0 100%)';
                document.querySelector('.bubbles').style.opacity = '1';
                document.querySelectorAll('.card, .announcement-card, .header, .notification-dropdown, .modal-content').forEach(function(el) {
                    el.style.background = 'white';
                    el.style.color = '#1a2a3a';
                });
            }
        }

        // About Modal
        function openAboutModal() {
            document.getElementById('aboutModal').style.display = 'flex';
        }

        function closeAboutModal() {
            document.getElementById('aboutModal').style.display = 'none';
        }

        // Logout
        function logout() {
            if (confirm('Are you sure you want to logout?')) {
                window.location.href = 'login.aspx';
            }
        }
    </script>
</body>
</html>