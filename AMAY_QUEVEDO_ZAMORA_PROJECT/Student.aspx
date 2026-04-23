﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Student" %>

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

            body {
          background-image: url('wbg.jpg');
          background-size: cover;
          transition: background 0.5s ease-in-out;
          background-repeat: no-repeat;
          background-position: center;
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
            /* Use a solid color to avoid VS CSS warnings about background-clip:text */
            color: #1a3a5c;
        }

        .logo i {
            background: none;
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

        /* Pinned Dropdown Items */
        .pinned-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 22px;
            color: #2c3e50;
            font-size: 13px;
            border-bottom: 1px solid #eef2f6;
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
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            border-color: rgba(26,58,92,0.2);
        }

        /* Post Header */
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

        /* Pin Button Top Right */
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

        .pin-btn-top:hover {
            background: #f0f2f5;
        }

        .pin-btn-top.pinned {
            color: #e65100;
        }

        /* Post Content */
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
        }

        /* Post Stats */
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

        .post-stats span:hover {
            color: #1a3a5c;
        }

        /* Action Buttons - Like, Comment, Share at Bottom */
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

        .action-btn.liked {
            color: #dc2626;
        }

        .action-btn.liked i {
            font-weight: 900;
        }

        /* Comments Section */
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
            transition: all 0.3s;
        }

        .comment-input button:hover {
            transform: scale(1.02);
        }

        .comment {
            padding: 10px 0;
            font-size: 13px;
            border-bottom: 1px solid #eef2f6;
            display: flex;
            gap: 10px;
        }

        .comment:last-child {
            border-bottom: none;
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
            flex-shrink: 0;
        }

        .comment-content {
            flex: 1;
        }

        .comment-author {
            font-weight: bold;
            color: #1a3a5c;
        }

        .comment-text {
            color: #2c3e50;
            margin-top: 2px;
        }

        .comment-time {
            font-size: 10px;
            color: #b0c4de;
            margin-top: 4px;
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
    <form id="form1" runat="server">
        <!-- Header -->
        <div class="header">
            <div class="logo">
                <i class="fas fa-university"></i> CampusConnect
            </div>
            <div class="search-container">
                <div class="search-box">
                    <i class="fas fa-search"></i>
                    <input type="text" id="searchInput" placeholder="Search announcements..." />
                </div>
                <button class="search-btn" onclick="searchAnnouncements()">Search</button>
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
                        <div class="user-role">Student</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Notification Dropdown -->
        <div id="notificationDropdown" class="notification-dropdown">
            <div class="notification-header">
                <a href="Notifications.aspx">  
                <span><i class="fas fa-bell"></i> Notifications</span> </a>
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
                <div class="notification-icon">
                <a href="Notifications.aspx" style="text-decoration: none; color: inherit;">
                    
                 </a>
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

                    
                  <asp:LinkButton ID="btnViewPinned" runat="server" PostBackUrl="~/Pinned.aspx" CssClass="menu-item">
    <i class="fas fa-thumbtack"></i> View Pinned Items
</asp:LinkButton>

                    <div class="card-header" style="margin-top: 5px;">
                        <i class="fas fa-cog"></i> Settings
                    </div>
                    
                    <div class="settings-item" onclick="toggleTheme(this)">
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

            <!-- MAIN CONTENT - Announcement Board -->
            <main>
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-bullhorn"></i> Announcement Board
                        <span style="float: right; font-size: 12px; color: #1a3a5c;">Showing: <span id="activeFilterLabel">All</span></span>
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
                                <div class="post-text">
                                    The final examinations will be held on December 15-20, 2024. Please check your respective departments for room assignments.
                                </div>
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
                                    <div class="comment">
                                        <div class="comment-avatar"><i class="fas fa-user"></i></div>
                                        <div class="comment-content">
                                            <span class="comment-author">Maria Santos</span>
                                            <div class="comment-text">What time does the exam start?</div>
                                            <div class="comment-time">December 9, 2024</div>
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
                                <div class="post-text">
                                    Due to Typhoon Enteng, classes in all levels are suspended tomorrow, November 25, 2024. Stay safe and monitor for further announcements.
                                </div>
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
                                <div class="post-text">
                                    Join us for the annual University Foundation Week celebration on December 1-5, 2024. Activities include parade, talent show, sportsfest, and concert featuring local artists.
                                </div>
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
                    It allows students to access official announcements, exam schedules, class suspensions, and campus events in one place.
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
        document.addEventListener('click', function (e) {
            var bell = document.querySelector('.notification-bell');
            var dropdown = document.getElementById('notificationDropdown');
            if (bell && dropdown && !bell.contains(e.target) && !dropdown.contains(e.target)) {
                dropdown.classList.remove('show');
            }
        });

        // ==================== POST INTERACTIONS ====================

        // Toggle Comments Section
        function toggleComments(btn) {
            var card = btn.closest('.announcement-card');
            var commentsSection = card.querySelector('.comments-section');
            commentsSection.classList.toggle('show');
        }

        // Scroll to comments and open
        function scrollToComments(element) {
            var card = element.closest('.announcement-card');
            var commentsSection = card.querySelector('.comments-section');
            if (!commentsSection.classList.contains('show')) {
                commentsSection.classList.add('show');
            }
            commentsSection.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }

        // Toggle Like (from button)
        function toggleLike(btn) {
            var card = btn.closest('.announcement-card');
            var likeIcon = btn.querySelector('i');
            var likeCountSpan = card.querySelector('.like-count');
            var currentCount = parseInt(likeCountSpan.innerText);

            if (btn.classList.contains('liked')) {
                btn.classList.remove('liked');
                likeIcon.className = 'far fa-heart';
                likeCountSpan.innerText = currentCount - 1;
                btn.innerHTML = '<i class="far fa-heart"></i> Like';
            } else {
                btn.classList.add('liked');
                likeIcon.className = 'fas fa-heart';
                likeCountSpan.innerText = currentCount + 1;
                btn.innerHTML = '<i class="fas fa-heart"></i> Liked';
            }
        }

        // Toggle Like (from stats bar)
        function toggleLikeFromStats(span) {
            var card = span.closest('.announcement-card');
            var likeBtn = card.querySelector('.action-btn:first-child');
            var likeIcon = likeBtn.querySelector('i');
            var likeCountSpan = span.querySelector('.like-count');
            var currentCount = parseInt(likeCountSpan.innerText);

            if (likeBtn.classList.contains('liked')) {
                likeBtn.classList.remove('liked');
                likeIcon.className = 'far fa-heart';
                likeCountSpan.innerText = currentCount - 1;
                likeBtn.innerHTML = '<i class="far fa-heart"></i> Like';
            } else {
                likeBtn.classList.add('liked');
                likeIcon.className = 'fas fa-heart';
                likeCountSpan.innerText = currentCount + 1;
                likeBtn.innerHTML = '<i class="fas fa-heart"></i> Liked';
            }
        }

        // Share Post
        function sharePost() {
            alert('Share this announcement with others!');
        }

        // Toggle Pin (Top Right)
        function togglePinTop(btn) {
            if (btn.classList.contains('pinned')) {
                btn.classList.remove('pinned');
                alert('Announcement unpinned!');
            } else {
                btn.classList.add('pinned');
                alert('Announcement pinned!');
            }
        }

        // Add Comment with proper script
        function addComment(btn) {
            var input = btn.parentElement.querySelector('input');
            var commentText = input.value.trim();

            if (commentText !== '') {
                var card = btn.closest('.announcement-card');
                var commentsList = card.querySelector('.comments-list');
                var noComments = commentsList.querySelector('.no-comments');
                var commentCountSpan = card.querySelector('.comment-count');
                var currentCommentCount = parseInt(commentCountSpan.innerText);

                if (noComments) {
                    noComments.remove();
                }

                var now = new Date();
                var formattedDate = now.toLocaleDateString('en-US', { month: 'long', day: 'numeric', year: 'numeric' });

                var newComment = document.createElement('div');
                newComment.className = 'comment';
                newComment.innerHTML = '<div class="comment-avatar"><i class="fas fa-user"></i></div>' +
                    '<div class="comment-content">' +
                    '<span class="comment-author">You</span>' +
                    '<div class="comment-text">' + escapeHtml(commentText) + '</div>' +
                    '<div class="comment-time">Just now</div>' +
                    '</div>';
                commentsList.appendChild(newComment);

                // Update comment count
                commentCountSpan.innerText = currentCommentCount + 1;

                // Update stats bar comment count
                var statsCommentSpan = card.querySelector('.post-stats span:nth-child(2) .comment-count');
                if (statsCommentSpan) {
                    statsCommentSpan.innerText = currentCommentCount + 1;
                }

                input.value = '';

                // Show success message
                showToast('Comment posted successfully!');
            } else {
                showToast('Please enter a comment!');
            }
        }

        // Escape HTML to prevent XSS
        function escapeHtml(text) {
            var div = document.createElement('div');
            div.textContent = text;
            return div.innerHTML;
        }

        // Show toast notification
        function showToast(message) {
            var toast = document.createElement('div');
            toast.style.position = 'fixed';
            toast.style.bottom = '20px';
            toast.style.right = '20px';
            toast.style.backgroundColor = '#1a3a5c';
            toast.style.color = 'white';
            toast.style.padding = '12px 24px';
            toast.style.borderRadius = '30px';
            toast.style.fontSize = '14px';
            toast.style.zIndex = '9999';
            toast.style.boxShadow = '0 4px 12px rgba(0,0,0,0.15)';
            toast.innerHTML = message;
            document.body.appendChild(toast);

            setTimeout(function () {
                toast.style.opacity = '0';
                toast.style.transition = 'opacity 0.3s';
                setTimeout(function () {
                    toast.remove();
                }, 300);
            }, 2000);
        }

        // Filter Category
        function filterCategory(category) {
            var announcements = document.querySelectorAll('.announcement-card');
            var filterLabel = document.getElementById('activeFilterLabel');

            announcements.forEach(function (ann) {
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

            announcements.forEach(function (ann) {
                var title = ann.querySelector('.post-title').innerText.toLowerCase();
                var content = ann.querySelector('.post-text').innerText.toLowerCase();

                if (title.includes(searchTerm) || content.includes(searchTerm)) {
                    ann.style.display = 'block';
                    found = true;
                } else {
                    ann.style.display = 'none';
                }
            });

            if (!found && searchTerm !== '') {
                showToast('No announcements found matching "' + searchTerm + '"');
            }
        }

        // Enter key search
        var searchInput = document.getElementById('searchInput');
        if (searchInput) {
            searchInput.addEventListener('keypress', function (e) {
                if (e.key === 'Enter') {
                    searchAnnouncements();
                }
            });
        }

        // Remove Pin from sidebar
        function removePin(btn) {
            btn.parentElement.remove();
            showToast('Item removed from pinned!');
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
            notifications.forEach(function (notif) {
                notif.classList.remove('unread');
                var dot = notif.querySelector('.notification-dot');
                if (dot) dot.remove();
            });
            updateBadgeCount();
            showToast('All notifications marked as read');
        }

        function updateBadgeCount() {
            var unreadCount = document.querySelectorAll('.notification-item.unread').length;
            var badge = document.getElementById('notificationBadge');
            if (badge) {
                if (unreadCount > 0) {
                    badge.textContent = unreadCount;
                    badge.style.display = 'inline-block';
                } else {
                    badge.style.display = 'none';
                }
            }
        }

        // Theme Toggle
        function toggleTheme(item) {
            var toggle = item.querySelector('.toggle-switch');
            toggle.classList.toggle('active');
            var body = document.body;

            if (body.classList.contains('dark-mode')) {
                // Switch to LIGHT MODE
                body.classList.remove('dark-mode');
                body.style.backgroundImage = "url('wbg.jpg')"; // Your light image
                body.style.backgroundSize = "cover";
                body.style.backgroundAttachment = "fixed";

                // Update card backgrounds to be semi-transparent white
                document.querySelectorAll('.card, .announcement-card, .header').forEach(function (el) {
                    el.style.background = 'rgba(255, 255, 255, 0.7)';
                    el.style.color = '#1a2a3a';
                });
            } else {
                // Switch to DARK MODE
                body.classList.add('dark-mode');
                body.style.backgroundImage = "url('bg.jpg')"; // Your dark image
                body.style.backgroundSize = "cover";
                body.style.backgroundAttachment = "fixed";

                // Update card backgrounds to be semi-transparent dark
                document.querySelectorAll('.card, .announcement-card, .header').forEach(function (el) {
                    el.style.background = 'rgba(42, 42, 42, 0.7)';
                    el.style.color = '#e4e6eb';
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