<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Student" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<<<<<<< HEAD
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Campus Announcement - Student Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
=======
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Campus Connect - Student Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

<<<<<<< HEAD
       body {
            background-image: url('bg.jpg');
            background-size: cover;
            transition: background 0.5s ease-in-out;
            background-repeat: no-repeat;
            background-position: center;
        }

        /* Ensure the main container doesn't have a solid color blocking the image */
        .main-content, .announcement-board {
            background: transparent !important;
        }

        /* Glassmorphism effect for your cards so the image peeks through */
        .card, .announcement-card {
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.1);
}

        /* Header */
        .header {
            background: white;
            border-radius: 24px;
            padding: 12px 30px;
=======
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

        html,
        body,
        form {
            height: 100%;
        }

        html,
        body {
            overflow: hidden;
        }

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

        a {
            color: inherit;
            text-decoration: none;
        }

        button,
        input,
        textarea {
            font: inherit;
        }

         .app-shell {
            height: 100%;
            height: 100vh;
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
            display: flex;
            flex-direction: column;
            gap: 10px;
            padding: 16px 20px 8px;
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
            flex: 0 0 auto;
            flex: 0 0 34px;
            text-align: center;
            padding: 0;
            margin-top: -2px;
            margin: 0;
            line-height: 34px;
            font-size: 12px;
        }
            form {
                height: auto;
                min-height: 100%;
                overflow: visible;
            }

       
        .logo {
            font-size: 22px;
            font-weight: 800;
            color: var(--primary);
            white-space: nowrap;
        }

        .logo i {
            color: var(--primary);
            margin-right: 8px;
        }

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
            border: 1px solid #dce4ec;
        }

        .search-box input {
            background: none;
            border: none;
            outline: none;
            width: 100%;
            font-size: 14px;
            color: var(--page-text);
        }

        .search-box input::placeholder {
            color: var(--muted-light);
        }

        .search-box i,
        .bell-icon {
            color: var(--primary);
        }

        .search-btn,
        .comment-input button,
        .modal-close {
            background: linear-gradient(135deg, var(--primary), var(--primary-2));
            border: none;
            border-radius: 30px;
            padding: 10px 22px;
            color: #ffffff;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .search-btn:hover,
        .comment-input button:hover,
        .modal-close:hover {
            transform: translateY(-1px);
            box-shadow: 0 8px 16px rgba(26, 58, 92, 0.18);
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

        .notification-bell:hover {
            background: var(--active-bg);
        }

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

        .avatar,
        .profile-avatar,
        .post-avatar {
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

        .user-name {
            font-size: 14px;
            font-weight: 600;
        }

        .user-role,
        .profile-email,
        .post-meta,
        .comment-time,
        .footer {
            color: var(--muted);
        }

        .content-shell {
            flex: 1 1 0;
            min-height: 0;
            display: grid;
            grid-template-columns: 300px minmax(0, 1fr);
            gap: 25px;
            overflow: hidden;
            align-items: stretch;
        }

        .sidebar {
            height: 100%;
            min-height: 0;
            overflow: hidden;
        }

        .card {
            background: var(--surface);
            backdrop-filter: blur(10px);
            border-radius: 24px;
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        .sidebar .card,
        .main-panel.card {
            height: 100%;
            min-height: 100%;
            display: flex;
            flex-direction: column;
        }

        .sidebar-content {
            min-height: 0;
            overflow-y: auto;
        }

        .card-header {
            padding: 18px 22px;
            border-bottom: 1px solid #eef2f6;
            font-weight: 700;
            color: var(--primary);
            font-size: 16px;
        }

        .card-header i {
            margin-right: 10px;
            color: var(--primary);
        }

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

        .profile-name,
        .post-author,
        .post-title,
        .modal-title {
            color: var(--primary);
        }

        .profile-name {
            font-size: 18px;
            font-weight: 700;
<<<<<<< HEAD
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
=======
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
        }

        .menu-item,
        .settings-item,
        .dropdown-item {
            color: var(--page-text);
        }

<<<<<<< HEAD
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
=======
        .menu-item,
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
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
            transition: all 0.3s;
            border-left: 3px solid transparent;
        }

        .menu-item:hover,
        .settings-item:hover,
        .dropdown-item:hover,
        .action-btn:hover {
            background: var(--surface-soft);
            color: var(--primary);
        }

        .menu-item.active,
        .settings-item.active {
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

        .menu-item.open .dropdown-icon {
            transform: rotate(180deg);
        }

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

        .toggle-switch.active {
            background: linear-gradient(135deg, var(--primary), var(--primary-2));
        }

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

        .toggle-switch.active::after {
            left: 24px;
        }

<<<<<<< HEAD
        /* Announcement Cards */
=======
        .main-panel {
            height: 100%;
            min-width: 0;
            min-height: 0;
        }

        .main-panel .card-header {
            flex: 0 0 auto;
        }

        .header-filter {
            float: right;
            font-size: 12px;
            color: var(--primary);
        }

>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
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
            padding: 22px;
            margin-bottom: 20px;
            border: 1px solid rgba(26, 58, 92, 0.08);
            transition: all 0.3s;
<<<<<<< HEAD
            box-shadow: 0 2px 8px rgba(0,0,0,0.03);
        }

        .announcement-card:hover {
            transform: translateX(5px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            border-color: rgba(26,58,92,0.2);
        }

        .badge-group {
            margin-bottom: 12px;
=======
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

        .post-header-left {
            display: flex;
            align-items: center;
            gap: 15px;
        }

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

        .post-author {
            font-weight: 700;
            font-size: 16px;
        }

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

        .pin-btn-top:hover {
            background: #f0f2f5;
        }

        .pin-btn-top.pinned {
            color: #e65100;
        }

        .post-content {
            padding: 0 22px 16px;
        }

        .post-title {
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .post-text,
        .comment-text,
        .notification-text,
        .modal-text {
            color: var(--page-text);
            line-height: 1.5;
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
        }

        .badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            margin-right: 8px;
        }

<<<<<<< HEAD
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
=======
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
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
        }

        .announcement-content {
            color: #2c3e50;
            line-height: 1.5;
            margin-bottom: 16px;
        }

<<<<<<< HEAD
=======
        .post-stats span:hover {
            color: var(--primary);
        }

>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
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
<<<<<<< HEAD
            font-size: 13px;
            color: #5a6e7c;
=======
            font-size: 14px;
            color: var(--muted);
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
        }

<<<<<<< HEAD
        .action-btn:hover {
            background: #e8f0fe;
            color: #1a3a5c;
        }

        /* Comments Section */
        .comments-section {
            margin-top: 16px;
            padding-top: 16px;
=======
        .action-btn.liked {
            color: #dc2626;
        }

        .action-btn.liked i {
            font-weight: 900;
        }

        .comments-section {
            padding: 0 22px 18px;
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
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
            background: var(--surface-soft);
            border: 1px solid #dce4ec;
            border-radius: 30px;
            outline: none;
            font-size: 13px;
<<<<<<< HEAD
        }

        .comment-input button {
            padding: 10px 22px;
            background: linear-gradient(135deg, #1a3a5c, #2c5a7a);
            border: none;
            border-radius: 30px;
            cursor: pointer;
            font-weight: 600;
            color: white;
=======
            color: var(--page-text);
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
        }

        .comment {
            padding: 8px 0;
            font-size: 13px;
            border-bottom: 1px solid #eef2f6;
<<<<<<< HEAD
            color: #2c3e50;
=======
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
            color: var(--primary);
            font-weight: bold;
            flex-shrink: 0;
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
        }

        .comment-author {
            font-weight: bold;
<<<<<<< HEAD
            color: #1a3a5c;
=======
            color: var(--primary);
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
        }

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

        .notification-dropdown.show {
            display: block;
        }

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

        .notification-item:hover {
            background: var(--surface-soft);
        }

        .notification-item.unread {
            background: var(--active-bg);
        }

        .notification-dot {
            width: 8px;
            height: 8px;
            background: #dc2626;
            border-radius: 50%;
        }

        .notification-time {
            font-size: 10px;
            color: var(--muted-light);
        }

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

        .modal-icon {
            font-size: 50px;
            color: var(--primary);
            margin-bottom: 15px;
        }

        .modal-title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .modal-text {
            margin: 15px 0;
            font-size: 13px;
        }

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

<<<<<<< HEAD
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
=======
        .sidebar.collapsed {
            width: 88px;
        }

        .sidebar.collapsed + .main-panel {
            margin-left: 0;
        }

        .sidebar.collapsed .profile-name,
        .sidebar.collapsed .profile-email,
        .sidebar.collapsed .card-header,
        .sidebar.collapsed .menu-text,
        .sidebar.collapsed .settings-text,
        .sidebar.collapsed .dropdown-content {
            display: none;
        }

        .sidebar.collapsed .menu-item,
        .sidebar.collapsed .settings-item,
        .sidebar.collapsed .profile-section {
            justify-content: center;
        }

        .sidebar.collapsed .dropdown-icon,
        .sidebar.collapsed .toggle-switch {
            display: none;
        }

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

        .dark-mode .announcement-board {
            background: rgba(18, 22, 28, 0.28);
        }

        .dark-mode .notification-item.unread,
        .dark-mode .menu-item.active,
        .dark-mode .settings-item.active {
            background: rgba(64, 96, 128, 0.36);
        }

        .dark-mode .logo,
        .dark-mode .logo i,
        .dark-mode .card-header,
        .dark-mode .card-header i,
        .dark-mode .profile-name,
        .dark-mode .post-author,
        .dark-mode .post-title,
        .dark-mode .modal-title,
        .dark-mode .user-name,
        .dark-mode .user-role,
        .dark-mode .profile-email,
        .dark-mode .menu-item,
        .dark-mode .settings-item,
        .dark-mode .dropdown-item,
        .dark-mode .menu-item.active,
        .dark-mode .settings-item.active,
        .dark-mode .header-filter,
        .dark-mode .post-stats,
        .dark-mode .post-stats span,
        .dark-mode .action-btn,
        .dark-mode .comment-author,
        .dark-mode .comment-avatar,
        .dark-mode .bell-icon,
        .dark-mode .notification-header,
        .dark-mode .notification-header button,
        .dark-mode .notification-header a,
        .dark-mode .sidebar-toggle,
        .dark-mode .dropdown-icon,
        .dark-mode .no-comments,
        .dark-mode .footer {
            color: #ffffff;
        }

        .dark-mode .menu-item:hover,
        .dark-mode .settings-item:hover,
        .dark-mode .dropdown-item:hover,
        .dark-mode .post-stats span:hover,
        .dark-mode .action-btn:hover {
            color: #ffffff;
        }

        .dark-mode .pin-btn-top:hover,
        .dark-mode .action-btn:hover {
            background: rgba(255, 255, 255, 0.06);
        }

        @media (max-width: 980px) {
            html,
            body {
                overflow: auto;
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
            }

            .app-shell,
            form {
                height: auto;
                min-height: 100%;
                overflow: visible;
            }

            .footer {
                position: static;
                height: auto;
                line-height: normal;
                padding: 6px 0 0;
            }

            .header {
                flex-wrap: wrap;
            }

            .search-container {
                order: 3;
                width: 100%;
                justify-content: stretch;
            }

            .content-shell {
                grid-template-columns: 1fr;
                overflow: visible;
            }

            .sidebar,
            .main-panel,
            .sidebar .card,
            .main-panel.card {
                height: auto;
            }

            .announcement-board,
            .sidebar-content {
                overflow: visible;
                max-height: none;
            }

            .notification-dropdown {
                right: 12px;
                left: 12px;
                width: auto;
            }
        }
    </style>
</head>
<body>
    <div class="bubbles"></div>

    <form id="form1" runat="server">
<<<<<<< HEAD
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
=======
        <div class="app-shell">
            <div class="header">
                <div class="logo">
                    <i class="fas fa-university"></i> CampusAnnouncement
                </div>

                <div class="search-container">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="searchInput" placeholder="Search announcements..." />
                    </div>
                    <button type="button" class="search-btn" onclick="searchAnnouncements()">Search</button>
                </div>

                <div class="header-actions">
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
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
                        </div>
                    </div>
                </div>
            </div>

<<<<<<< HEAD
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
=======
            <div id="notificationDropdown" class="notification-dropdown">
                <div class="notification-header">
                    <a href="Notifications.aspx">
                        <span><i class="fas fa-bell"></i> Notifications</span>
                    </a>
                    <button type="button" onclick="markAllRead()">Mark all read</button>
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
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
                    </div>
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
                                <div class="profile-name">John Dela Cruz</div>
                                <div class="profile-email">john.delacruz@ctu.edu.ph</div>
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

                            <asp:LinkButton ID="btnViewPinned" runat="server" PostBackUrl="~/Pinned.aspx" CssClass="menu-item">
                                <i class="fas fa-thumbtack"></i>
                                <span class="menu-text">View Pinned Items</span>
                            </asp:LinkButton>

                            <div class="card-header" style="margin-top: 5px;">
                                <i class="fas fa-cog"></i> Settings
                            </div>

                            <button type="button" class="settings-item" onclick="toggleTheme(this)">
                                <i class="fas fa-moon"></i>
                                <span class="settings-text">Dark / Light Mode</span>
                                <div class="toggle-switch" id="themeToggle"></div>
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

                    <!-- Announcements Container -->
                    <div id="announcementsContainer" class="announcement-board">
<<<<<<< HEAD
                        <!-- Announcement 1 - Exam -->
                        <div class="announcement-card" data-category="Exam">
                            <div class="badge-group">
                                <span class="badge badge-exam">Exam</span>
                                <span class="badge badge-pinned"><i class="fas fa-thumbtack"></i> PINNED</span>
=======
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
                                <button type="button" class="pin-btn-top pinned" onclick="togglePinTop(this)"><i class="fas fa-thumbtack"></i></button>
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
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
<<<<<<< HEAD
                                <button class="action-btn" onclick="togglePin(this)"><i class="fas fa-thumbtack"></i> Unpin</button>
                                <button class="action-btn" onclick="toggleComments(this)"><i class="fas fa-comment"></i> Comment (2)</button>
=======
                                <button type="button" class="action-btn" onclick="toggleLike(this)"><i class="far fa-heart"></i> Like</button>
                                <button type="button" class="action-btn" onclick="toggleComments(this)"><i class="far fa-comment"></i> Comment</button>
                                <button type="button" class="action-btn" onclick="sharePost()"><i class="fas fa-share"></i> Share</button>
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
                            </div>
                            <div class="comments-section">
                                <div class="comment-input">
                                    <input type="text" placeholder="Write a comment..." />
                                    <button type="button" onclick="addComment(this)">Post</button>
                                </div>
                                <div class="comments-list">
                                    <div class="comment"><span class="comment-author">Juan Dela Cruz:</span> Thank you for the update!</div>
                                    <div class="comment"><span class="comment-author">Maria Santos:</span> What time does the exam start?</div>
                                </div>
                            </div>
                        </div>

<<<<<<< HEAD
                        <!-- Announcement 2 - Suspension -->
                        <div class="announcement-card" data-category="Suspension">
                            <div class="badge-group">
                                <span class="badge badge-suspension">Suspension</span>
                                <span class="badge badge-pinned"><i class="fas fa-thumbtack"></i> PINNED</span>
=======
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
                                <button type="button" class="pin-btn-top pinned" onclick="togglePinTop(this)"><i class="fas fa-thumbtack"></i></button>
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
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
<<<<<<< HEAD
                                <button class="action-btn" onclick="togglePin(this)"><i class="fas fa-thumbtack"></i> Unpin</button>
                                <button class="action-btn" onclick="toggleComments(this)"><i class="fas fa-comment"></i> Comment (1)</button>
=======
                                <button type="button" class="action-btn" onclick="toggleLike(this)"><i class="far fa-heart"></i> Like</button>
                                <button type="button" class="action-btn" onclick="toggleComments(this)"><i class="far fa-comment"></i> Comment</button>
                                <button type="button" class="action-btn" onclick="sharePost()"><i class="fas fa-share"></i> Share</button>
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
                            </div>
                            <div class="comments-section">
                                <div class="comment-input">
                                    <input type="text" placeholder="Write a comment..." />
                                    <button type="button" onclick="addComment(this)">Post</button>
                                </div>
                                <div class="comments-list">
                                    <div class="comment"><span class="comment-author">John Santos:</span> Stay safe everyone!</div>
                                </div>
                            </div>
                        </div>

<<<<<<< HEAD
                        <!-- Announcement 3 - Event -->
                        <div class="announcement-card" data-category="Event">
                            <div class="badge-group">
                                <span class="badge badge-event">Event</span>
=======
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
                                <button type="button" class="pin-btn-top" onclick="togglePinTop(this)"><i class="fas fa-thumbtack"></i></button>
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
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
<<<<<<< HEAD
                                <button class="action-btn" onclick="togglePin(this)"><i class="fas fa-thumbtack"></i> Pin</button>
                                <button class="action-btn" onclick="toggleComments(this)"><i class="fas fa-comment"></i> Comment (0)</button>
=======
                                <button type="button" class="action-btn" onclick="toggleLike(this)"><i class="far fa-heart"></i> Like</button>
                                <button type="button" class="action-btn" onclick="toggleComments(this)"><i class="far fa-comment"></i> Comment</button>
                                <button type="button" class="action-btn" onclick="sharePost()"><i class="fas fa-share"></i> Share</button>
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
                            </div>
                            <div class="comments-section">
                                <div class="comment-input">
                                    <input type="text" placeholder="Write a comment..." />
                                    <button type="button" onclick="addComment(this)">Post</button>
                                </div>
                                <div class="comments-list">
                                    <div class="no-comments">No comments yet. Be the first!</div>
                                </div>
                            </div>
                        </div>
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
<<<<<<< HEAD
                <div class="modal-text">
                    <strong>Version:</strong> 1.0<br>
                    <strong>Developed for:</strong> CTU Students & Faculty
                </div>
                <button class="modal-close" onclick="closeAboutModal()">Close</button>
=======
                <button type="button" class="modal-close" onclick="closeAboutModal()">Close</button>
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
            </div>
        </div>
    </form>

    <script>
        function toggleDropdown(id, trigger) {
            var dropdown = document.getElementById(id);
            var isOpen = dropdown.style.maxHeight && dropdown.style.maxHeight !== "0px";

            dropdown.style.maxHeight = isOpen ? "0px" : dropdown.scrollHeight + "px";

            if (trigger) {
                trigger.classList.toggle('open', !isOpen);
            }
        }

        function toggleSidebar() {
            document.querySelector('.sidebar').classList.toggle('collapsed');
        }

        document.querySelectorAll('.menu-item, .settings-item').forEach(function (item) {
            item.addEventListener('click', function () {
                document.querySelectorAll('.menu-item, .settings-item').forEach(function (i) {
                    i.classList.remove('active');
                });
                this.classList.add('active');
            });
        });

        function toggleNotificationDropdown() {
            var dropdown = document.getElementById('notificationDropdown');
            dropdown.classList.toggle('show');
        }

        document.addEventListener('click', function (e) {
            var bell = document.querySelector('.notification-bell');
            var dropdown = document.getElementById('notificationDropdown');
            if (!bell.contains(e.target) && !dropdown.contains(e.target)) {
                dropdown.classList.remove('show');
            }
        });

<<<<<<< HEAD
        // Toggle Comments
=======
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
        function toggleComments(btn) {
            var card = btn.closest('.announcement-card');
            var commentsSection = card.querySelector('.comments-section');
            commentsSection.classList.toggle('show');
        }

<<<<<<< HEAD
        // Filter Category
=======
        function scrollToComments(element) {
            var card = element.closest('.announcement-card');
            var commentsSection = card.querySelector('.comments-section');
            if (!commentsSection.classList.contains('show')) {
                commentsSection.classList.add('show');
            }
            commentsSection.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }

        function toggleLike(btn) {
            var card = btn.closest('.announcement-card');
            var likeIcon = btn.querySelector('i');
            var likeCountSpan = card.querySelector('.like-count');
            var currentCount = parseInt(likeCountSpan.innerText, 10);

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

        function toggleLikeFromStats(span) {
            var card = span.closest('.announcement-card');
            var likeBtn = card.querySelector('.action-btn:first-child');
            var likeIcon = likeBtn.querySelector('i');
            var likeCountSpan = span.querySelector('.like-count');
            var currentCount = parseInt(likeCountSpan.innerText, 10);

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

        function sharePost() {
            alert('Share this announcement with others!');
        }

        function togglePinTop(btn) {
            if (btn.classList.contains('pinned')) {
                btn.classList.remove('pinned');
                alert('Announcement unpinned!');
            } else {
                btn.classList.add('pinned');
                alert('Announcement pinned!');
            }
        }

        function addComment(btn) {
            var input = btn.parentElement.querySelector('input');
            var commentText = input.value.trim();

            if (commentText !== '') {
                var card = btn.closest('.announcement-card');
                var commentsList = card.querySelector('.comments-list');
                var noComments = commentsList.querySelector('.no-comments');
                var commentCountSpan = card.querySelector('.comment-count');
                var currentCommentCount = parseInt(commentCountSpan.innerText, 10);

                if (noComments) {
                    noComments.remove();
                }

                var newComment = document.createElement('div');
                newComment.className = 'comment';
                newComment.innerHTML = '<div class="comment-avatar"><i class="fas fa-user"></i></div>' +
                    '<div class="comment-content">' +
                    '<span class="comment-author">You</span>' +
                    '<div class="comment-text">' + escapeHtml(commentText) + '</div>' +
                    '<div class="comment-time">Just now</div>' +
                    '</div>';
                commentsList.appendChild(newComment);

                commentCountSpan.innerText = currentCommentCount + 1;

                var statsCommentSpan = card.querySelector('.post-stats span:nth-child(2) .comment-count');
                if (statsCommentSpan) {
                    statsCommentSpan.innerText = currentCommentCount + 1;
                }

                input.value = '';
                showToast('Comment posted successfully!');
            } else {
                showToast('Please enter a comment!');
            }
        }

        function escapeHtml(text) {
            var div = document.createElement('div');
            div.textContent = text;
            return div.innerHTML;
        }

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

>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
        function filterCategory(category) {
            var announcements = document.querySelectorAll('.announcement-card');
            var filterLabel = document.getElementById('activeFilterLabel');
            var dropdown = document.getElementById('categoryDropdown');
            var trigger = document.querySelector('[onclick*="toggleDropdown(\'categoryDropdown\'"]');

            announcements.forEach(function (ann) {
                if (category === 'All' || ann.getAttribute('data-category') === category) {
                    ann.style.display = 'block';
                } else {
                    ann.style.display = 'none';
                }
            });

            filterLabel.innerText = category;
            dropdown.style.maxHeight = '0px';
            if (trigger) {
                trigger.classList.remove('open');
            }
        }

        function searchAnnouncements() {
            var searchTerm = document.getElementById('searchInput').value.toLowerCase();
            var announcements = document.querySelectorAll('.announcement-card');
            var found = false;

            announcements.forEach(function (ann) {
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

<<<<<<< HEAD
        // Enter key search
        document.getElementById('searchInput').addEventListener('keypress', function (e) {
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
=======
        var searchInput = document.getElementById('searchInput');
        if (searchInput) {
            searchInput.addEventListener('keypress', function (e) {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    searchAnnouncements();
                }
            });
        }

>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
        function markRead(item) {
            item.classList.remove('unread');
            var dot = item.querySelector('.notification-dot');
            if (dot) {
                dot.remove();
            }
            updateBadgeCount();
        }

        function markAllRead() {
            var notifications = document.querySelectorAll('.notification-item.unread');
            notifications.forEach(function (notif) {
                notif.classList.remove('unread');
                var dot = notif.querySelector('.notification-dot');
                if (dot) {
                    dot.remove();
                }
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

        function toggleTheme(item) {
            var toggle = item.querySelector('.toggle-switch');
            toggle.classList.toggle('active');
<<<<<<< HEAD
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
=======
            document.body.classList.toggle('dark-mode');
>>>>>>> 4382a28f3047eb8f814cd69c4849256ab51172b0
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
