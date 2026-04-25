<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Teacher.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Teacher" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Campus Connect - Teacher Portal</title>
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
            background: rgba(255,255,255,0.15);
            padding: 6px 18px;
            border-radius: 40px;
            border: 1.5px solid rgba(255,255,255,0.4);
            cursor: pointer;
            position: relative;
            transition: background 0.2s;
        }
        .user-info:hover { background: rgba(255,255,255,0.25); }

        /* User dropdown */
        .user-dropdown {
            display: none;
            position: absolute;
            top: calc(100% + 10px);
            right: 0;
            min-width: 220px;
            background: var(--surface-strong);
            border: 1px solid var(--border);
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            z-index: 300;
            overflow: hidden;
        }
        .user-dropdown.show { display: block; }
        .user-dropdown-header {
            padding: 16px 18px 12px;
            border-bottom: 1px solid var(--border);
            text-align: center;
        }
        .user-dropdown-avatar {
            width: 52px; height: 52px;
            border-radius: 50%;
            background: linear-gradient(135deg, #1e3a8a, #2563eb);
            color: #fff;
            display: flex; align-items: center; justify-content: center;
            font-size: 22px;
            margin: 0 auto 10px;
        }
        .user-dropdown-name  { font-weight: 700; font-size: 15px; color: var(--primary); }
        .user-dropdown-email { font-size: 12px; color: var(--muted); margin-top: 2px; }
        .user-dropdown-role  { display: inline-block; margin-top: 6px; padding: 2px 12px; border-radius: 20px; font-size: 11px; font-weight: 700; background: #DBEAFE; color: #1E3A8A; }
        body.dark-mode .user-dropdown-role { background: rgba(30,58,138,0.3); color: #93C5FD; }
        .user-dropdown-footer { padding: 8px; }
        .user-dropdown-footer button {
            width: 100%; padding: 9px; border: none; border-radius: 10px;
            background: #fef2f2; color: #dc2626; font-weight: 600; font-size: 13px;
            cursor: pointer; transition: background 0.2s; font-family: inherit;
        }
        .user-dropdown-footer button:hover { background: #fee2e2; }

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
            --muted-light: #64748b;
            --shadow: 0 8px 32px rgba(0, 0, 0, 0.5);
            --active-bg: rgba(99, 102, 241, 0.18);
        }

        /* Body background matches SearchDashboard exactly */
        body.dark-mode {
            background-image: linear-gradient(rgba(0,0,0,0), rgba(0,0,0,0)), url('bg.jpg');
            background-color: #0F172A;
        }

        /* Overlay gradient like SearchDashboard */
        body.dark-mode::after {
            content: '';
            position: fixed;
            inset: 0;
            background: radial-gradient(circle at 50% 50%, rgba(79,70,229,0.12), transparent 70%);
            pointer-events: none;
            z-index: 0;
        }

        /* Header / Nav — glass like SearchDashboard */
        .dark-mode .header {
            background: rgba(15, 25, 55, 0.75);
            backdrop-filter: blur(12px);
            border-color: rgba(255, 255, 255, 0.1);
            box-shadow: 0 4px 24px rgba(0,0,0,0.4);
        }

        /* Sidebar card */
        .dark-mode .card {
            background: rgba(15, 25, 55, 0.7);
            backdrop-filter: blur(12px);
            border-color: rgba(255, 255, 255, 0.1);
        }

        /* Announcement cards — glass style */
        .dark-mode .announcement-card {
            background: rgba(255, 255, 255, 0.06);
            border-color: rgba(255, 255, 255, 0.1);
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
        }

        .dark-mode .announcement-card:hover {
            background: rgba(255, 255, 255, 0.09);
            border-color: rgba(99, 102, 241, 0.4);
            box-shadow: 0 8px 30px rgba(0,0,0,0.4);
        }

        /* Announcement board background */
        .dark-mode .announcement-board {
            background: rgba(0, 0, 0, 0.15);
        }

        /* All text elements */
        .dark-mode .logo,
        .dark-mode .logo i,
        .dark-mode .card-header,
        .dark-mode .card-header i,
        .dark-mode .profile-name,
        .dark-mode .post-author,
        .dark-mode .post-title,
        .dark-mode .post-text,
        .dark-mode .modal-title,
        .dark-mode .modal-text,
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
        .dark-mode .comment-text,
        .dark-mode .bell-icon,
        .dark-mode .notification-header,
        .dark-mode .notification-header button,
        .dark-mode .notification-header a,
        .dark-mode .sidebar-toggle,
        .dark-mode .dropdown-icon,
        .dark-mode .no-comments,
        .dark-mode .footer,
        .dark-mode .notification-text,
        .dark-mode .notification-time { color: #e4e6eb; }

        .dark-mode .comment-avatar { color: #818cf8; }

        /* Hover states */
        .dark-mode .menu-item:hover,
        .dark-mode .settings-item:hover,
        .dark-mode .dropdown-item:hover { background: rgba(99,102,241,0.15); color: #ffffff; }

        .dark-mode .post-stats span:hover,
        .dark-mode .action-btn:hover { color: #818cf8; }

        .dark-mode .pin-btn-top:hover,
        .dark-mode .action-btn:hover { background: rgba(255, 255, 255, 0.06); }

        /* Active / unread states */
        .dark-mode .notification-item.unread { background: rgba(99, 102, 241, 0.15); }
        .dark-mode .menu-item.active,
        .dark-mode .settings-item.active {
            background: rgba(99, 102, 241, 0.18);
            border-left-color: #818cf8;
        }

        /* User info pill */
        .dark-mode .user-info {
            background: rgba(255, 255, 255, 0.07);
            border-color: rgba(255, 255, 255, 0.1);
        }

        /* Notification bell */
        .dark-mode .notification-bell {
            background: rgba(255, 255, 255, 0.07);
            border-color: rgba(255, 255, 255, 0.1);
        }

        .dark-mode .notification-bell:hover { background: rgba(99,102,241,0.2); }

        /* Notification dropdown */
        .dark-mode .notification-dropdown {
            background: rgba(15, 25, 55, 0.95);
            border-color: rgba(255, 255, 255, 0.1);
            box-shadow: 0 12px 40px rgba(0,0,0,0.5);
        }

        .dark-mode .notification-item {
            border-bottom-color: rgba(255, 255, 255, 0.06);
        }

        .dark-mode .notification-item:hover { background: rgba(99,102,241,0.12); }

        .dark-mode .notification-header {
            border-bottom-color: rgba(255, 255, 255, 0.08);
        }

        /* Card header borders */
        .dark-mode .card-header {
            border-bottom-color: rgba(255, 255, 255, 0.08);
        }

        /* Profile section border */
        .dark-mode .profile-section {
            border-bottom-color: rgba(255, 255, 255, 0.08);
        }

        /* Post stats / comments borders */
        .dark-mode .post-stats {
            border-top-color: rgba(255, 255, 255, 0.08);
            border-bottom-color: rgba(255, 255, 255, 0.08);
        }

        .dark-mode .comments-section {
            border-top-color: rgba(255, 255, 255, 0.08);
        }

        .dark-mode .comment {
            border-bottom-color: rgba(255, 255, 255, 0.06);
        }

        /* Comment input */
        .dark-mode .comment-input input {
            background: rgba(255, 255, 255, 0.07);
            border-color: rgba(255, 255, 255, 0.12);
            color: #e4e6eb;
        }

        .dark-mode .comment-input input::placeholder { color: #64748b; }

        .dark-mode .comment-input button {
            background: #6366f1;
            border-color: #6366f1;
            color: #ffffff;
        }

        .dark-mode .comment-input button:hover { background: #818cf8; }

        /* Comment avatar bg */
        .dark-mode .comment-avatar {
            background: rgba(99, 102, 241, 0.2);
        }

        /* Search / action buttons */
        .dark-mode .search-btn {
            background: rgba(255, 255, 255, 0.07) !important;
            border-color: rgba(255, 255, 255, 0.2) !important;
            color: #e4e6eb !important;
        }

        .dark-mode .search-btn:hover {
            background: rgba(99, 102, 241, 0.25) !important;
            border-color: #6366f1 !important;
            color: #ffffff !important;
        }

        /* Modal */
        .dark-mode .modal-content {
            background: rgba(15, 25, 55, 0.97);
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 20px 60px rgba(0,0,0,0.6);
        }

        .dark-mode .modal-icon { color: #818cf8; }
        .dark-mode .modal-title { color: #e4e6eb; }

        .dark-mode .modal-close {
            background: rgba(255,255,255,0.07);
            border-color: rgba(255,255,255,0.15);
            color: #e4e6eb;
        }

        .dark-mode .modal-close:hover {
            background: rgba(99,102,241,0.25);
            border-color: #6366f1;
            color: #ffffff;
        }

        /* Form inputs inside modal (Teacher create post) */
        .dark-mode .form-group label { color: #94a3b8; }

        .dark-mode .form-group input,
        .dark-mode .form-group select,
        .dark-mode .form-group textarea {
            background: rgba(255, 255, 255, 0.07);
            border-color: rgba(255, 255, 255, 0.12);
            color: #e4e6eb;
        }

        .dark-mode .form-group input:focus,
        .dark-mode .form-group select:focus,
        .dark-mode .form-group textarea:focus {
            border-color: #6366f1;
            box-shadow: 0 0 0 3px rgba(99,102,241,0.2);
        }

        .dark-mode .form-group input::placeholder,
        .dark-mode .form-group textarea::placeholder { color: #64748b; }

        .dark-mode .form-group select option {
            background: #0f172a;
            color: #e4e6eb;
        }

        /* Modal action buttons */
        .dark-mode .btn-cancel {
            border-color: rgba(255,255,255,0.15);
            color: #94a3b8;
        }

        .dark-mode .btn-cancel:hover {
            border-color: #6366f1;
            color: #818cf8;
        }

        /* Category badges — keep readable in dark */
        .dark-mode .post-category-exam { background: rgba(25,118,210,0.2); color: #90caf9; }
        .dark-mode .post-category-suspension { background: rgba(198,40,40,0.2); color: #ef9a9a; }
        .dark-mode .post-category-event { background: rgba(46,125,50,0.2); color: #a5d6a7; }
        .dark-mode .post-category-general { background: rgba(123,31,162,0.2); color: #ce93d8; }

        /* Pin button */
        .dark-mode .pin-btn-top { color: #64748b; }
        .dark-mode .pin-btn-top.pinned { color: #fb923c; }

        /* Post announcement button (Teacher) */
        .dark-mode .post-announcement-btn {
            background: linear-gradient(135deg, rgba(99,102,241,0.3), rgba(129,140,248,0.2));
            border: 1px solid rgba(99,102,241,0.4);
            box-shadow: 0 4px 15px rgba(99,102,241,0.2);
        }

        .dark-mode .post-announcement-btn:hover {
            background: linear-gradient(135deg, rgba(99,102,241,0.5), rgba(129,140,248,0.35));
            box-shadow: 0 8px 25px rgba(99,102,241,0.35);
        }
        .post-announcement-btn {
            background: linear-gradient(135deg, #1a3a5c, #2c5a7a);
            border: none;
            border-radius: 16px;
            padding: 16px 28px;
            color: white;
            font-weight: 700;
            font-size: 15px;
            cursor: pointer;
            transition: all 0.3s;
            width: 100%;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            box-shadow: 0 4px 15px rgba(26,58,92,0.3);
        }

        .post-announcement-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(26,58,92,0.4);
        }

        /* Create Post Modal wider */
        .modal-content.create-modal {
            max-width: 520px;
            text-align: left;
        }

        .modal-content.create-modal .modal-title {
            text-align: center;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 16px;
        }

        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 6px;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #dce4ec;
            border-radius: 12px;
            background: var(--surface-soft);
            color: var(--page-text);
            font-size: 14px;
            outline: none;
            transition: border-color 0.2s;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            border-color: var(--primary);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 90px;
        }

        .modal-actions {
            display: flex;
            gap: 12px;
            margin-top: 20px;
            justify-content: flex-end;
        }

        .btn-cancel {
            background: none;
            border: 2px solid #dce4ec;
            border-radius: 12px;
            padding: 10px 22px;
            color: var(--muted);
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-cancel:hover {
            border-color: var(--primary);
            color: var(--primary);
        }

        .btn-publish {
            background: linear-gradient(135deg, #1a3a5c, #2c5a7a);
            border: none;
            border-radius: 12px;
            padding: 10px 28px;
            color: white;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-publish:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }

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

        /* ── PAGE FLIP TRANSITION ── */
        @keyframes flipOut {
            0%   { transform: perspective(1200px) rotateY(0deg); opacity: 1; }
            100% { transform: perspective(1200px) rotateY(-90deg); opacity: 0; }
        }
        @keyframes flipIn {
            0%   { transform: perspective(1200px) rotateY(90deg); opacity: 0; }
            100% { transform: perspective(1200px) rotateY(0deg); opacity: 1; }
        }

        .page-flip-out {
            animation: flipOut 0.18s ease-in forwards;
            transform-origin: center center;
        }
        .page-flip-in {
            animation: flipIn 0.18s ease-out forwards;
            transform-origin: center center;
        }

        /* Smooth color transitions on all elements */
        *, *::before, *::after {
            transition: background-color 0.3s ease, border-color 0.3s ease, color 0.3s ease, box-shadow 0.3s ease;
        }
        /* Exclude transitions that would break animations */
        .page-flip-out, .page-flip-in { transition: none !important; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="app-shell">

            <!-- HEADER -->
            <div class="header">
                <div class="logo" onclick="navigateWithFlip('Teacher.aspx')" style="cursor:pointer;">
                    <i class="fas fa-university"></i> CampusAnnouncement
                </div>

                <div class="search-container">
                    <asp:Button ID="searchBtn" runat="server" CssClass="search-btn"
                        Text="🔎 Search........"
                        OnClientClick="navigateWithFlip('SearchDashboard.aspx'); return false;"
                        UseSubmitBehavior="false"
                        Width="420px" Font-Bold="False"
                        Font-Size="Medium" Height="54px" />
                </div>

                <div class="header-actions">
                    <div class="notification-bell" onclick="navigateWithFlip('Notifications.aspx')" style="cursor:pointer;">
                        <i class="fas fa-bell bell-icon"></i>
                        <span id="notificationBadge" class="badge-red" style="display:none;">0</span>
                    </div>
                    <div class="user-info" onclick="openProfileModal()">
                        <div class="avatar">
                            <i class="fas fa-chalkboard-user"></i>
                        </div>
                        <div class="user-details">
                            <div class="user-name" id="userName" style="color:#ffffff;">Loading...</div>
                            <div class="user-role" id="userRole" style="color:rgba(255,255,255,0.75);">Admin</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- NOTIFICATION DROPDOWN -->
            <div id="notificationDropdown" class="notification-dropdown">
                <div class="notification-header">
                    <a href="Notifications.aspx" style="text-decoration:none;color:inherit;">
                        <span><i class="fas fa-bell"></i> Notifications</span>
                    </a>
                    <button type="button" onclick="markAllReadNotif()">Mark all read</button>
                </div>
                <div class="notification-list" id="notificationList">
                    <div style="padding:20px;text-align:center;color:var(--muted);">No notifications yet.</div>
                </div>
            </div>

            <!-- CONTENT SHELL -->
            <div class="content-shell">

                <!-- SIDEBAR -->
                <aside class="sidebar">
                    <div class="card">
                        <div class="sidebar-content">

                            <!-- Profile removed — info shown in header user pill -->

                            <!-- Filters -->
                            <div class="card-header">
                                <i class="fas fa-filter"></i> Filters
                            </div>
                            <button type="button" class="menu-item" onclick="toggleCategoryMenu('categoryDropdown', this)">
                                <i class="fas fa-layer-group"></i>
                                <span class="menu-text">Filter by Category</span>
                                <i class="fas fa-chevron-down dropdown-icon"></i>
                            </button>
                            <div id="categoryDropdown" class="dropdown-content">
                                <button type="button" class="dropdown-item" onclick="setFilter('All')">All Announcements</button>
                                <button type="button" class="dropdown-item" onclick="setFilter('Exam')">Exam Schedule</button>
                                <button type="button" class="dropdown-item" onclick="setFilter('Suspension')">Class Suspension</button>
                                <button type="button" class="dropdown-item" onclick="setFilter('Event')">Campus Events</button>
                                <button type="button" class="dropdown-item" onclick="setFilter('General')">General</button>
                            </div>

                            <button type="button" class="menu-item" onclick="navigateWithFlip('Pinned.aspx')">
                                <i class="fas fa-thumbtack"></i>
                                <span class="menu-text">Pinned Announcements</span>
                            </button>

                            <!-- Settings -->
                            <div class="card-header" style="margin-top:5px;">
                                <i class="fas fa-cog"></i> Settings
                            </div>

                            <button type="button" class="settings-item" onclick="toggleDarkMode(this)">
                                <i class="fas fa-moon"></i>
                                <span class="settings-text">Dark / Light Mode</span>
                                <div class="toggle-switch" id="themeToggle"></div>
                            </button>

                            <button type="button" class="settings-item" onclick="openAboutModal()">
                                <i class="fas fa-info-circle"></i>
                                <span class="settings-text">About Us</span>
                            </button>

                            <button type="button" class="settings-item" onclick="logoutAction()">
                                <i class="fas fa-sign-out-alt"></i>
                                <span class="settings-text">Logout</span>
                            </button>

                        </div>
                    </div>
                </aside>

                <!-- MAIN PANEL -->
                <main class="main-panel card">

                    <div class="announcement-board">
                        <!-- Teacher-specific: Post Announcement Button -->
                        <button type="button" class="post-announcement-btn" onclick="openCreateModal()">
                            <i class="fas fa-plus-circle"></i> Want to post an announcement?
                        </button>

                        <!-- Announcements rendered by JS -->
                    <div class="card-header">
                        <i class="fas fa-bullhorn"></i> Announcement Board
                        <span class="header-filter">Showing: <span id="activeFilterLabel">All</span></span>
                    </div>

                        <div id="announcementsContainer"></div>
                    </div>
                </main>

            </div><!-- end content-shell -->
        </div><!-- end app-shell -->

        <!-- ===== CREATE POST MODAL ===== -->
        <div id="createPostModal" class="modal" style="display:none;">
            <div class="modal-content create-modal">
                <div class="modal-title"><i class="fas fa-bullhorn"></i> New Announcement</div>

                <div class="form-group">
                    <label for="postTitle">Title</label>
                    <input type="text" id="postTitle" placeholder="Enter announcement title..." />
                </div>

                <div class="form-group">
                    <label for="postCategory">Category</label>
                    <select id="postCategory">
                        <option value="General">General</option>
                        <option value="Exam">Exam</option>
                        <option value="Suspension">Suspension</option>
                        <option value="Event">Event</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="postContent">Content</label>
                    <textarea id="postContent" placeholder="Write your announcement here..."></textarea>
                </div>

                <div class="form-group">
                    <label for="postImageUrl">Image URL <span style="font-weight:400;color:var(--muted);">(optional)</span></label>
                    <input type="text" id="postImageUrl" placeholder="https://example.com/image.jpg" />
                </div>

                <div class="modal-actions">
                    <button type="button" class="btn-cancel" onclick="closeCreateModal()">Cancel</button>
                    <button type="button" class="btn-publish" onclick="publishAnnouncement()">
                        <i class="fas fa-paper-plane"></i> Publish
                    </button>
                </div>
            </div>
        </div>

        <!-- ===== PROFILE MODAL ===== -->
        <div id="profileModal" class="modal" style="display:none;">
            <div class="modal-content" style="max-width:420px;text-align:left;">
                <div style="text-align:center;margin-bottom:20px;">
                    <div style="width:72px;height:72px;border-radius:50%;background:linear-gradient(135deg,#1e3a8a,#2563eb);color:#fff;display:flex;align-items:center;justify-content:center;font-size:28px;margin:0 auto 12px;">
                        <i class="fas fa-chalkboard-user"></i>
                    </div>
                    <div class="modal-title" style="margin-bottom:4px;" id="pm-fullname">Loading...</div>
                    <span style="display:inline-block;padding:3px 14px;border-radius:20px;font-size:11px;font-weight:700;background:#DBEAFE;color:#1E3A8A;" id="pm-role">Admin</span>
                </div>
                <div style="display:flex;flex-direction:column;gap:12px;margin-bottom:24px;">
                    <div style="display:flex;align-items:center;gap:12px;padding:12px 16px;background:var(--surface-soft);border-radius:12px;border:1px solid var(--border);">
                        <i class="fas fa-user" style="color:var(--primary);width:18px;text-align:center;"></i>
                        <div>
                            <div style="font-size:11px;color:var(--muted);font-weight:600;text-transform:uppercase;letter-spacing:.05em;">Username</div>
                            <div style="font-weight:600;color:var(--page-text);" id="pm-username">—</div>
                        </div>
                    </div>
                    <div style="display:flex;align-items:center;gap:12px;padding:12px 16px;background:var(--surface-soft);border-radius:12px;border:1px solid var(--border);">
                        <i class="fas fa-envelope" style="color:var(--primary);width:18px;text-align:center;"></i>
                        <div>
                            <div style="font-size:11px;color:var(--muted);font-weight:600;text-transform:uppercase;letter-spacing:.05em;">Email</div>
                            <div style="font-weight:600;color:var(--page-text);" id="pm-email">—</div>
                        </div>
                    </div>
                    <div style="display:flex;align-items:center;gap:12px;padding:12px 16px;background:var(--surface-soft);border-radius:12px;border:1px solid var(--border);">
                        <i class="fas fa-shield-alt" style="color:var(--primary);width:18px;text-align:center;"></i>
                        <div>
                            <div style="font-size:11px;color:var(--muted);font-weight:600;text-transform:uppercase;letter-spacing:.05em;">Role</div>
                            <div style="font-weight:600;color:var(--page-text);" id="pm-role2">Admin</div>
                        </div>
                    </div>
                    <div style="display:flex;align-items:center;gap:12px;padding:12px 16px;background:var(--surface-soft);border-radius:12px;border:1px solid var(--border);">
                        <i class="fas fa-lock" style="color:var(--primary);width:18px;text-align:center;"></i>
                        <div>
                            <div style="font-size:11px;color:var(--muted);font-weight:600;text-transform:uppercase;letter-spacing:.05em;">Password</div>
                            <div style="font-weight:600;color:var(--page-text);">••••••••</div>
                        </div>
                    </div>
                </div>
                <div style="display:flex;gap:10px;">
                    <button type="button" onclick="closeProfileModal()" style="flex:1;padding:12px;border:1px solid var(--border);border-radius:12px;background:none;color:var(--page-text);font-weight:600;cursor:pointer;font-family:inherit;">Close</button>
                    <button type="button" onclick="logoutAction()" style="flex:1;padding:12px;border:none;border-radius:12px;background:#fef2f2;color:#dc2626;font-weight:600;cursor:pointer;font-family:inherit;"><i class="fas fa-sign-out-alt"></i> Logout</button>
                </div>
            </div>
        </div>

        <!-- ===== ABOUT MODAL ===== -->
        <div id="aboutModal" class="modal" style="display:none;">
            <div class="modal-content">
                <div class="modal-icon">
                    <i class="fas fa-university"></i>
                </div>
                <div class="modal-title">Campus Connect</div>
                <div class="modal-text">
                    Campus Connect is a centralized web-based announcement system for Cebu Technological University.
                    It allows faculty to post and manage official announcements, exam schedules, class suspensions, and campus events in one place.
                </div>
                <button type="button" class="modal-close" onclick="closeAboutModal()">Close</button>
            </div>
        </div>

    </form>

    <script>
        // ── Mock Data ──────────────────────────────────────────────────────────
        var teacher = { id: 1, name: "Prof. Emily Davis" };

        var posts = [
            {
                id: 101,
                title: "Midterm Examination Schedule",
                category: "Exam",
                content: "The midterm examinations will be held from October 14–18, 2024. Please check your respective department bulletin boards for the detailed room assignments and time slots. All students are required to bring their school IDs.",
                author: "Prof. Emily Davis",
                date: "Oct 10, 2024",
                likes: 24,
                shares: 8,
                comments: [],
                isPinned: true,
                imageUrl: null,
                liked: false
            },
            {
                id: 102,
                title: "Class Suspension - Typhoon Warning",
                category: "Suspension",
                content: "Due to Typhoon Signal No. 2 raised over the province, all classes in all levels are hereby suspended effective immediately. Students are advised to stay home and monitor official announcements for updates on class resumption.",
                author: "Prof. Emily Davis",
                date: "Oct 9, 2024",
                likes: 57,
                shares: 32,
                comments: [],
                isPinned: false,
                imageUrl: null,
                liked: false
            },
            {
                id: 103,
                title: "Campus Talent Fest 2024",
                category: "Event",
                content: "Get ready for the biggest campus event of the year! Campus Talent Fest 2024 will showcase the diverse talents of CTU students. Join us on October 25, 2024 at the University Gymnasium. Registration is open until October 20.",
                author: "Prof. Emily Davis",
                date: "Oct 8, 2024",
                likes: 89,
                shares: 45,
                comments: [],
                isPinned: false,
                imageUrl: "https://picsum.photos/id/20/400/200",
                liked: false
            },
            {
                id: 104,
                title: "Library Extended Hours",
                category: "General",
                content: "The university library will extend its operating hours starting October 11, 2024 until the end of the midterm examination period. New hours: Monday–Friday 7:00 AM – 9:00 PM, Saturday 8:00 AM – 6:00 PM.",
                author: "Prof. Emily Davis",
                date: "Oct 7, 2024",
                likes: 15,
                shares: 6,
                comments: [],
                isPinned: false,
                imageUrl: null,
                liked: false
            }
        ];

        var notifications = [];
        var currentFilter = 'All';
        var globalSearch = '';

        // ── Render Posts ───────────────────────────────────────────────────────
        function renderPosts() {
            var container = document.getElementById('announcementsContainer');
            if (!container) return;

            var filtered = posts.filter(function(p) {
                var matchFilter = currentFilter === 'All' || p.category === currentFilter;
                var matchSearch = globalSearch === '' ||
                    p.title.toLowerCase().indexOf(globalSearch.toLowerCase()) !== -1 ||
                    p.content.toLowerCase().indexOf(globalSearch.toLowerCase()) !== -1;
                return matchFilter && matchSearch;
            });

            // Pinned first
            filtered.sort(function(a, b) {
                return (b.isPinned ? 1 : 0) - (a.isPinned ? 1 : 0);
            });

            if (filtered.length === 0) {
                container.innerHTML = '<div style="text-align:center;padding:40px;color:var(--muted);">No announcements found.</div>';
                return;
            }

            var html = '';
            filtered.forEach(function(post) {
                var catClass = 'post-category-' + post.category.toLowerCase();
                var pinClass = post.isPinned ? 'pinned' : '';
                var pinIcon = post.isPinned ? 'fas fa-thumbtack' : 'far fa-thumbtack';
                var pinColor = post.isPinned ? '#e65100' : 'var(--muted-light)';
                var likedClass = post.liked ? 'liked' : '';
                var likeIcon = post.liked ? 'fas fa-heart' : 'far fa-heart';
                var likeLabel = post.liked ? 'Liked' : 'Like';

                var imageHtml = '';
                if (post.imageUrl) {
                    imageHtml = '<div class="post-image"><img src="' + post.imageUrl + '" alt="Post image" /></div>';
                }

                html += '<div class="announcement-card" data-id="' + post.id + '" data-category="' + post.category + '">';

                // Post header
                html += '<div class="post-header">';
                html += '  <div class="post-header-left">';
                html += '    <div class="post-avatar"><i class="fas fa-chalkboard-user"></i></div>';
                html += '    <div>';
                html += '      <div class="post-author">' + escHtml(post.author) + '</div>';
                html += '      <div class="post-meta">';
                html += '        <span>' + escHtml(post.date) + '</span>';
                html += '        <span class="post-category ' + catClass + '">' + escHtml(post.category) + '</span>';
                if (post.isPinned) {
                    html += '        <span style="color:#e65100;font-size:11px;"><i class="fas fa-thumbtack"></i> Pinned</span>';
                }
                html += '      </div>';
                html += '    </div>';
                html += '  </div>';
                html += '  <button type="button" class="pin-btn-top ' + pinClass + '" onclick="togglePin(' + post.id + ', this)" title="' + (post.isPinned ? 'Unpin' : 'Pin') + '" style="color:' + pinColor + '">';
                html += '    <i class="' + pinIcon + '"></i>';
                html += '  </button>';
                html += '</div>';

                // Post content
                html += '<div class="post-content">';
                html += '  <div class="post-title">' + escHtml(post.title) + '</div>';
                html += '  <div class="post-text">' + escHtml(post.content) + '</div>';
                html += imageHtml;
                html += '</div>';

                // Stats
                html += '<div class="post-stats">';
                html += '  <span onclick="likePost(' + post.id + ')"><i class="fas fa-heart" style="color:#dc2626;"></i> <span class="like-count">' + post.likes + '</span> Likes</span>';
                html += '  <span><i class="fas fa-comment"></i> <span class="comment-count">' + post.comments.length + '</span> Comments</span>';
                html += '  <span><i class="fas fa-share"></i> ' + post.shares + ' Shares</span>';
                html += '</div>';

                // Action buttons
                html += '<div class="action-buttons">';
                html += '  <button type="button" class="action-btn ' + likedClass + '" onclick="likePost(' + post.id + ', this)">';
                html += '    <i class="' + likeIcon + '"></i> ' + likeLabel;
                html += '  </button>';
                html += '  <button type="button" class="action-btn" onclick="toggleCommentSection(' + post.id + ')">';
                html += '    <i class="far fa-comment"></i> Comment';
                html += '  </button>';
                html += '  <button type="button" class="action-btn" onclick="sharePost(' + post.id + ')">';
                html += '    <i class="fas fa-share"></i> Share';
                html += '  </button>';
                html += '</div>';

                // Comments section
                html += '<div class="comments-section" id="commentsSection_' + post.id + '">';
                html += '  <div class="comment-input">';
                html += '    <input type="text" id="commentInput_' + post.id + '" placeholder="Write a comment..." />';
                html += '    <button type="button" onclick="addComment(' + post.id + ')">Post</button>';
                html += '  </div>';
                html += '  <div id="commentsList_' + post.id + '">';
                if (post.comments.length === 0) {
                    html += '<div class="no-comments">No comments yet. Be the first!</div>';
                } else {
                    post.comments.forEach(function(c) {
                        html += '<div class="comment">';
                        html += '  <div class="comment-avatar"><i class="fas fa-user"></i></div>';
                        html += '  <div class="comment-content">';
                        html += '    <span class="comment-author">' + escHtml(c.author) + '</span>';
                        html += '    <div class="comment-text">' + escHtml(c.text) + '</div>';
                        html += '    <div class="comment-time">' + escHtml(c.date) + '</div>';
                        html += '  </div>';
                        html += '</div>';
                    });
                }
                html += '  </div>';
                html += '</div>';

                html += '</div>'; // end announcement-card
            });

            container.innerHTML = html;
        }

        // ── Post Actions ───────────────────────────────────────────────────────
        function likePost(postId, btn) {
            var post = posts.find(function(p) { return p.id === postId; });
            if (!post) return;
            post.liked = !post.liked;
            post.likes += post.liked ? 1 : -1;
            renderPosts();
            showToast(post.liked ? 'You liked this post!' : 'Like removed.');
            addNotification(post.liked ? 'You liked: ' + post.title : 'You unliked: ' + post.title);
        }

        function sharePost(postId) {
            var post = posts.find(function(p) { return p.id === postId; });
            if (!post) return;
            post.shares += 1;
            renderPosts();
            showToast('Announcement shared!');
            addNotification('You shared: ' + post.title);
        }

        function addComment(postId) {
            var input = document.getElementById('commentInput_' + postId);
            if (!input) return;
            var text = input.value.trim();
            if (!text) { showToast('Please enter a comment!'); return; }
            var post = posts.find(function(p) { return p.id === postId; });
            if (!post) return;
            post.comments.push({ author: teacher.name, text: text, date: 'Just now' });
            renderPosts();
            showToast('Comment posted!');
            addNotification('You commented on: ' + post.title);
            // Re-open comments section after re-render
            var section = document.getElementById('commentsSection_' + postId);
            if (section) section.classList.add('show');
        }

        function togglePin(postId, btn) {
            var post = posts.find(function(p) { return p.id === postId; });
            if (!post) return;
            post.isPinned = !post.isPinned;

            // Sync to shared campus_pins localStorage key
            var campusPins = JSON.parse(localStorage.getItem('campus_pins') || '{}');
            campusPins[postId] = post.isPinned;
            localStorage.setItem('campus_pins', JSON.stringify(campusPins));
            // Notify other tabs
            window.dispatchEvent(new StorageEvent('storage', { key: 'campus_pins', newValue: JSON.stringify(campusPins) }));

            renderPosts();
            showToast(post.isPinned ? 'Announcement pinned!' : 'Announcement unpinned!');
            addNotification((post.isPinned ? 'Pinned: ' : 'Unpinned: ') + post.title);
        }

        function toggleCommentSection(postId) {
            var section = document.getElementById('commentsSection_' + postId);
            if (section) section.classList.toggle('show');
        }

        // ── Filter & Search ────────────────────────────────────────────────────
        function setFilter(category) {
            currentFilter = category;
            var label = document.getElementById('activeFilterLabel');
            if (label) label.textContent = category;
            renderPosts();
        }

        function performGlobalSearch(query) {
            globalSearch = query || '';
            renderPosts();
        }

        // ── Category Dropdown ──────────────────────────────────────────────────
        function toggleCategoryMenu(id, trigger) {
            var dropdown = document.getElementById(id);
            if (!dropdown) return;
            var isOpen = dropdown.style.maxHeight && dropdown.style.maxHeight !== '0px';
            dropdown.style.maxHeight = isOpen ? '0px' : dropdown.scrollHeight + 'px';
            if (trigger) trigger.classList.toggle('open', !isOpen);
        }

        // ── Notifications ──────────────────────────────────────────────────────
        function addNotification(message) {
            notifications.unshift({ message: message, time: 'Just now', read: false });
            updateNotificationUI();
        }

        function updateNotificationUI() {
            var badge = document.getElementById('notificationBadge');
            var list = document.getElementById('notificationList');
            var unread = notifications.filter(function(n) { return !n.read; }).length;

            if (badge) {
                badge.textContent = unread;
                badge.style.display = unread > 0 ? 'block' : 'none';
            }

            if (!list) return;
            if (notifications.length === 0) {
                list.innerHTML = '<div style="padding:20px;text-align:center;color:var(--muted);">No notifications yet.</div>';
                return;
            }

            var html = '';
            notifications.forEach(function(n, i) {
                html += '<div class="notification-item ' + (n.read ? '' : 'unread') + '" onclick="markRead(' + i + ')">';
                if (!n.read) html += '<div class="notification-dot"></div>';
                html += '<div>';
                html += '  <div class="notification-text">' + escHtml(n.message) + '</div>';
                html += '  <div class="notification-time">' + escHtml(n.time) + '</div>';
                html += '</div>';
                html += '</div>';
            });
            list.innerHTML = html;
        }

        function markRead(index) {
            if (notifications[index]) {
                notifications[index].read = true;
                updateNotificationUI();
            }
        }

        function markAllReadNotif() {
            notifications.forEach(function(n) { n.read = true; });
            updateNotificationUI();
        }

        function toggleNotificationPanel() {
            var dropdown = document.getElementById('notificationDropdown');
            if (dropdown) dropdown.classList.toggle('show');
        }

        document.addEventListener('click', function(e) {
            var bell = document.querySelector('.notification-bell');
            var dropdown = document.getElementById('notificationDropdown');
            if (bell && dropdown && !bell.contains(e.target) && !dropdown.contains(e.target)) {
                dropdown.classList.remove('show');
            }
        });

        // ── Theme (global — persists across all pages via campus_theme) ──────────
        var THEME_KEY = 'campus_theme';

        function toggleDarkMode(btn) {
            document.body.classList.toggle('dark-mode');
            var toggle = document.getElementById('themeToggle');
            if (toggle) toggle.classList.toggle('active');
            localStorage.setItem(THEME_KEY, document.body.classList.contains('dark-mode') ? 'dark' : 'light');
        }

        function loadThemePref() {
            if (localStorage.getItem(THEME_KEY) === 'dark') {
                document.body.classList.add('dark-mode');
                var toggle = document.getElementById('themeToggle');
                if (toggle) toggle.classList.add('active');
            }
            // Load shared pin state from campus_pins
            var campusPins = JSON.parse(localStorage.getItem('campus_pins') || '{}');
            posts.forEach(function(p) {
                if (campusPins[p.id] !== undefined) {
                    p.isPinned = !!campusPins[p.id];
                }
            });
        }

        // Sync theme + pins when changed from another tab
        window.addEventListener('storage', function(e) {
            if (e.key === THEME_KEY) {
                var dark = e.newValue === 'dark';
                document.body.classList.toggle('dark-mode', dark);
                var toggle = document.getElementById('themeToggle');
                if (toggle) toggle.classList.toggle('active', dark);
            }
            if (e.key === 'campus_pins') {
                var campusPins = JSON.parse(e.newValue || '{}');
                posts.forEach(function(p) {
                    if (campusPins[p.id] !== undefined) {
                        p.isPinned = !!campusPins[p.id];
                    }
                });
                renderPosts();
            }
        });

        // ── Modals ─────────────────────────────────────────────────────────────
        function openAboutModal() {
            var modal = document.getElementById('aboutModal');
            if (modal) modal.style.display = 'flex';
        }

        function closeAboutModal() {
            var modal = document.getElementById('aboutModal');
            if (modal) modal.style.display = 'none';
        }

        function openCreateModal() {
            var modal = document.getElementById('createPostModal');
            if (modal) modal.style.display = 'flex';
        }

        function closeCreateModal() {
            var modal = document.getElementById('createPostModal');
            if (modal) modal.style.display = 'none';
            // Clear fields
            var fields = ['postTitle', 'postContent', 'postImageUrl'];
            fields.forEach(function(id) {
                var el = document.getElementById(id);
                if (el) el.value = '';
            });
            var cat = document.getElementById('postCategory');
            if (cat) cat.value = 'General';
        }

        function publishAnnouncement() {
            var title = (document.getElementById('postTitle').value || '').trim();
            var category = document.getElementById('postCategory').value || 'General';
            var content = (document.getElementById('postContent').value || '').trim();
            var imageUrl = (document.getElementById('postImageUrl').value || '').trim();

            if (!title) { showToast('Please enter a title.'); return; }
            if (!content) { showToast('Please enter content.'); return; }

            var newId = posts.length > 0 ? Math.max.apply(null, posts.map(function(p) { return p.id; })) + 1 : 200;
            var now = new Date();
            var dateStr = now.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });

            posts.unshift({
                id: newId,
                title: title,
                category: category,
                content: content,
                author: teacher.name,
                date: dateStr,
                likes: 0,
                shares: 0,
                comments: [],
                isPinned: false,
                imageUrl: imageUrl || null,
                liked: false
            });

            closeCreateModal();
            renderPosts();
            showToast('Announcement published!');
            addNotification('You posted: ' + title);
        }

        function openProfileModal() {
            var modal = document.getElementById('profileModal');
            if (modal) modal.style.display = 'flex';
        }

        function closeProfileModal() {
            var modal = document.getElementById('profileModal');
            if (modal) modal.style.display = 'none';
        }

        // Close profile modal on backdrop click
        document.addEventListener('click', function(e) {
            var modal = document.getElementById('profileModal');
            if (modal && e.target === modal) modal.style.display = 'none';
        });

        // ── Misc ───────────────────────────────────────────────────────────────
        function logoutAction() {
            if (confirm('Are you sure you want to logout?')) {
                window.location.href = 'Logout.aspx';
            }
        }

        function showToast(message) {
            var toast = document.createElement('div');
            toast.innerText = message;
            toast.style.cssText = 'position:fixed;bottom:50px;left:50%;transform:translateX(-50%);background:#1a3a5c;color:#fff;padding:10px 22px;border-radius:30px;font-size:13px;z-index:9999;box-shadow:0 4px 12px rgba(0,0,0,0.2);';
            document.body.appendChild(toast);
            setTimeout(function() { toast.remove(); }, 2500);
        }

        function toggleSidebar() {
            var sidebar = document.querySelector('.sidebar');
            if (sidebar) sidebar.classList.toggle('collapsed');
        }

        function escHtml(str) {
            if (!str) return '';
            return String(str).replace(/[&<>"']/g, function(m) {
                return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[m];
            });
        }

        // ── Init ───────────────────────────────────────────────────────────────
        loadThemePref();
        renderPosts();

        // ── Page Flip Transition ───────────────────────────────────────────────
        function navigateWithFlip(url) {
            var shell = document.querySelector('.app-shell') || document.body;
            shell.classList.add('page-flip-out');
            setTimeout(function() { window.location.href = url; }, 180);
        }

        // Flip-in on page load
        (function() {
            var shell = document.querySelector('.app-shell') || document.body;
            shell.classList.add('page-flip-in');
            shell.addEventListener('animationend', function() {
                shell.classList.remove('page-flip-in');
            }, { once: true });
        })();

        // ── Performance: prefetch linked pages ────────────────────────────────
        (function() {
            var pages = ['SearchDashboard.aspx', 'Student.aspx', 'Pinned.aspx', 'Notifications.aspx'];
            pages.forEach(function(page) {
                var link = document.createElement('link');
                link.rel = 'prefetch';
                link.href = page;
                document.head.appendChild(link);
            });
        })();
    </script>
</body>
</html>
