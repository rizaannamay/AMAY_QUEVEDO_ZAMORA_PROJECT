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

        .search-btn, .comment-input button, .modal-close {
            background: none;
            border: 1px solid rgba(26,58,92,0.25);
            border-radius: 30px;
            padding: 10px 22px;
            color: var(--primary);
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
            border-bottom: 1px solid rgba(26,58,92,0.08);
            font-weight: 700;
            color: var(--primary);
            font-size: 16px;
        }

        .card-header i { margin-right: 10px; color: var(--primary); }

        .profile-section {
            text-align: center;
            padding: 20px;
            border-bottom: 1px solid rgba(26,58,92,0.08);
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

        body.dark-mode {
            background-image: linear-gradient(rgba(0,0,0,0), rgba(0,0,0,0)), url('bg.jpg');
            background-color: #0F172A;
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

        body.dark-mode::after {
            content: '';
            position: fixed;
            inset: 0;
            background: radial-gradient(circle at 50% 50%, rgba(79,70,229,0.12), transparent 70%);
            pointer-events: none;
            z-index: 0;
        }

        .dark-mode .header {
            background: rgba(15, 25, 55, 0.75);
            backdrop-filter: blur(12px);
            border-color: rgba(255, 255, 255, 0.1);
            box-shadow: 0 4px 24px rgba(0,0,0,0.4);
        }

        .dark-mode .card {
            background: rgba(15, 25, 55, 0.7);
            backdrop-filter: blur(12px);
            border-color: rgba(255, 255, 255, 0.1);
        }

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

        .dark-mode .announcement-board { background: rgba(0, 0, 0, 0.15); }

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

        .dark-mode .menu-item:hover,
        .dark-mode .settings-item:hover,
        .dark-mode .dropdown-item:hover { background: rgba(99,102,241,0.15); color: #ffffff; }

        .dark-mode .post-stats span:hover,
        .dark-mode .action-btn:hover { color: #818cf8; }

        .dark-mode .pin-btn-top:hover,
        .dark-mode .action-btn:hover { background: rgba(255, 255, 255, 0.06); }

        .dark-mode .notification-item.unread { background: rgba(99, 102, 241, 0.15); }
        .dark-mode .menu-item.active,
        .dark-mode .settings-item.active {
            background: rgba(99, 102, 241, 0.18);
            border-left-color: #818cf8;
        }

        .dark-mode .user-info {
            background: rgba(255, 255, 255, 0.07);
            border-color: rgba(255, 255, 255, 0.1);
        }

        .dark-mode .notification-bell {
            background: rgba(255, 255, 255, 0.07);
            border-color: rgba(255, 255, 255, 0.1);
        }

        .dark-mode .notification-bell:hover { background: rgba(99,102,241,0.2); }

        .dark-mode .notification-dropdown {
            background: rgba(15, 25, 55, 0.95);
            border-color: rgba(255, 255, 255, 0.1);
            box-shadow: 0 12px 40px rgba(0,0,0,0.5);
        }

        .dark-mode .notification-item { border-bottom-color: rgba(255, 255, 255, 0.06); }
        .dark-mode .notification-item:hover { background: rgba(99,102,241,0.12); }
        .dark-mode .notification-header { border-bottom-color: rgba(255, 255, 255, 0.08); }
        .dark-mode .card-header { border-bottom-color: rgba(255, 255, 255, 0.08); }
        .dark-mode .profile-section { border-bottom-color: rgba(255, 255, 255, 0.08); }

        .dark-mode .post-stats {
            border-top-color: rgba(255, 255, 255, 0.08);
            border-bottom-color: rgba(255, 255, 255, 0.08);
        }

        .dark-mode .comments-section { border-top-color: rgba(255, 255, 255, 0.08); }
        .dark-mode .comment { border-bottom-color: rgba(255, 255, 255, 0.06); }

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

        .dark-mode .comment-avatar { background: rgba(99, 102, 241, 0.2); }

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

        .dark-mode .post-category-exam { background: rgba(25,118,210,0.2); color: #90caf9; }
        .dark-mode .post-category-suspension { background: rgba(198,40,40,0.2); color: #ef9a9a; }
        .dark-mode .post-category-event { background: rgba(46,125,50,0.2); color: #a5d6a7; }

        .dark-mode .pin-btn-top { color: #64748b; }
        .dark-mode .pin-btn-top.pinned { color: #fb923c; }

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

        /* -- PAGE FLIP TRANSITION -- */
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

        *, *::before, *::after {
            transition: background-color 0.3s ease, border-color 0.3s ease, color 0.3s ease, box-shadow 0.3s ease;
        }
        .page-flip-out, .page-flip-in { transition: none !important; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="app-shell">
            <div class="header">
                <div class="logo" onclick="navigateWithFlip('Student.aspx')" style="cursor:pointer;">
                    <i class="fas fa-university"></i> CampusAnnouncement
                </div>

                <div class="search-container">
                    <asp:Button ID="searchButton" runat="server" CssClass="search-btn" Text="?? Search........" OnClientClick="navigateWithFlip('SearchStudent.aspx'); return false;" Width="420px" Font-Bold="False" Font-Size="Medium" Height="54px" UseSubmitBehavior="false" />
                </div>

                <div class="header-actions">
                    <div class="notification-bell" onclick="navigateWithFlip('Notifications.aspx')" style="cursor:pointer;">
                        <i class="fas fa-bell bell-icon"></i>
                        <span id="notificationBadge" class="badge-red" style="display:none;">0</span>
                    </div>
                    <div class="user-info" onclick="openProfileModal(event)">
                        <div class="avatar">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="user-details">
                            <div class="user-name" id="userName"><%= Session["FullName"] ?? "User" %></div>
                            <div class="user-role" id="userRole"><%= Session["Role"] ?? "Student" %></div>
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
                            <!-- Profile removed — info shown in header user pill -->

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

                            <button type="button" class="menu-item" onclick="navigateWithFlip('Pinned.aspx')">
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

                            <button type="button" class="settings-item" onclick="window.location.href='AboutUs.aspx?source=student'">
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

        <!-- ===== PROFILE MODAL ===== -->
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
                    <div style="display:flex;align-items:center;gap:12px;padding:12px 16px;background:var(--surface-soft);border-radius:12px;border:1px solid var(--border);">
                        <i class="fas fa-user" style="color:var(--primary);width:18px;text-align:center;"></i>
                        <div>
                            <div style="font-size:11px;color:var(--muted);font-weight:600;text-transform:uppercase;letter-spacing:.05em;">Username</div>
                            <div style="font-weight:600;color:var(--page-text);" id="pm-username"><%= Session["Username"] ?? "—" %></div>
                        </div>
                    </div>
                    <div style="display:flex;align-items:center;gap:12px;padding:12px 16px;background:var(--surface-soft);border-radius:12px;border:1px solid var(--border);">
                        <i class="fas fa-envelope" style="color:var(--primary);width:18px;text-align:center;"></i>
                        <div>
                            <div style="font-size:11px;color:var(--muted);font-weight:600;text-transform:uppercase;letter-spacing:.05em;">Email</div>
                            <div style="font-weight:600;color:var(--page-text);" id="pm-email"><%= Session["Email"] ?? "—" %></div>
                        </div>
                    </div>
                    <div style="display:flex;align-items:center;gap:12px;padding:12px 16px;background:var(--surface-soft);border-radius:12px;border:1px solid var(--border);">
                        <i class="fas fa-shield-alt" style="color:var(--primary);width:18px;text-align:center;"></i>
                        <div>
                            <div style="font-size:11px;color:var(--muted);font-weight:600;text-transform:uppercase;letter-spacing:.05em;">Role</div>
                            <div style="font-weight:600;color:var(--page-text);" id="pm-role2"><%= Session["Role"] ?? "Student" %></div>
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
                    <button type="button" onclick="logout()" style="flex:1;padding:12px;border:none;border-radius:12px;background:#fef2f2;color:#dc2626;font-weight:600;cursor:pointer;font-family:inherit;"><i class="fas fa-sign-out-alt"></i> Logout</button>
                </div>
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

        function openProfileModal(e) {
            if (e) e.stopPropagation();
            var modal = document.getElementById('profileModal');
            if (!modal) return;
            modal.style.display = 'flex';
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

        function toggleSidebar() {
            var sidebar = document.querySelector('.sidebar');
            if (sidebar) sidebar.classList.toggle('collapsed');
        }

        function toggleNotificationDropdown(e) {
            if (e) e.stopPropagation();
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

        // --------------------------------------------------------
        // SHARED LOCALSTORAGE STATE  (same keys as Teacher + Search)
        // --------------------------------------------------------
        var ST = {
            get: function(k) { try { return JSON.parse(localStorage.getItem(k) || 'null'); } catch(e) { return null; } },
            set: function(k, v) { localStorage.setItem(k, JSON.stringify(v)); }
        };

        var st_likes      = ST.get('sd_likes')      || {};
        var st_likeCounts = ST.get('sd_likeCounts')  || {};
        var st_pins       = (function() {
            var tp = ST.get('teacher_pins') || {};
            var cp = ST.get('campus_pins')  || {};
            return Object.assign({}, cp, tp);
        })();
        var st_notifs     = ST.get('sd_notifs')      || {};
        var st_comments   = ST.get('sd_comments')    || {};

        function saveSharedState() {
            ST.set('sd_likes',      st_likes);
            ST.set('sd_likeCounts', st_likeCounts);
            ST.set('campus_pins',   st_pins);   // shared with Search pages
            ST.set('teacher_pins',  st_pins);   // shared with Teacher.aspx
            ST.set('sd_notifs',     st_notifs);
            ST.set('sd_comments',   st_comments);
        }

        function pushNotification(msg, icon) {
            var notifs = JSON.parse(localStorage.getItem('campus_notifications') || '[]');
            notifs.unshift({ msg: msg, icon: icon || 'fa-bell', time: new Date().toISOString(), read: false });
            if (notifs.length > 50) notifs = notifs.slice(0, 50);
            localStorage.setItem('campus_notifications', JSON.stringify(notifs));
            window.dispatchEvent(new StorageEvent('storage', { key: 'campus_notifications', newValue: JSON.stringify(notifs) }));
        }

        function showToast(message) {
            var toast = document.createElement('div');
            toast.innerText = message;
            toast.style.cssText = 'position:fixed;bottom:50px;left:50%;transform:translateX(-50%);background:#1a3a5c;color:#fff;padding:10px 22px;border-radius:30px;font-size:13px;z-index:9999;box-shadow:0 4px 12px rgba(0,0,0,0.2);pointer-events:none;';
            document.body.appendChild(toast);
            setTimeout(function() { toast.remove(); }, 2500);
        }

        function escapeHtml(str) {
            if (!str) return '';
            return str.replace(/[&<>"']/g, function(m) {
                return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[m];
            });
        }

        // -- Render comments list HTML -------------------------
        function renderCommentsList(postId) {
            var list = st_comments[postId] || [];
            if (!list.length) return '<div class="no-comments">No comments yet. Be the first!</div>';
            return list.map(function(c) {
                return '<div class="comment">' +
                    '<div class="comment-avatar"><i class="fas fa-user"></i></div>' +
                    '<div class="comment-content">' +
                        '<span class="comment-author">' + escapeHtml(c.author) + '</span>' +
                        '<div class="comment-text">' + escapeHtml(c.text) + '</div>' +
                        '<div class="comment-time">' + escapeHtml(c.time) + '</div>' +
                    '</div></div>';
            }).join('');
        }

        // -- Apply shared state to a single card ---------------
        function applyCardState(card) {
            var postId = parseInt(card.getAttribute('data-post-id'));
            if (!postId) return;

            var liked   = !!st_likes[postId];
            var pinned  = !!st_pins[postId];
            var notifOn = !!st_notifs[postId];
            var lc      = st_likeCounts[postId] !== undefined ? st_likeCounts[postId] : null;
            var cc      = (st_comments[postId] || []).length;

            // -- Pin button --
            var pinBtn = card.querySelector('.pin-btn-top');
            if (pinBtn) {
                pinBtn.style.color = pinned ? '#e65100' : 'var(--muted-light)';
                pinBtn.innerHTML   = '<i class="' + (pinned ? 'fas' : 'far') + ' fa-thumbtack"></i>';
                pinBtn.title       = pinned ? 'Unpin' : 'Pin this announcement';
                pinBtn.onclick     = function() { togglePin(postId); };
            }

            // -- Like count --
            if (lc !== null) {
                var lcSpan = card.querySelector('.like-count');
                if (lcSpan) lcSpan.textContent = lc;
            }

            // -- Comment count --
            if (cc > 0) {
                var ccSpan = card.querySelector('.comment-count');
                if (ccSpan) ccSpan.textContent = cc;
            }

            // -- Like button --
            var likeBtn = card.querySelector('.action-btn.like-btn');
            if (likeBtn) {
                likeBtn.className = 'action-btn like-btn' + (liked ? ' liked' : '');
                likeBtn.innerHTML = '<i class="' + (liked ? 'fas' : 'far') + ' fa-heart"></i> ' + (liked ? 'Liked' : 'Like');
            }

            // -- Comments list --
            var cl = document.getElementById('commentsList_' + postId);
            if (cl && (st_comments[postId] || []).length > 0) {
                cl.innerHTML = renderCommentsList(postId);
            }
        }

        // -- Inject action buttons into server-rendered cards --
        function upgradeCards() {
            var cards = document.querySelectorAll('.announcement-card');
            cards.forEach(function(card) {
                var postId = parseInt(card.getAttribute('data-post-id'));
                if (!postId) return;

                // Initialize like count if not set
                if (st_likeCounts[postId] === undefined) {
                    var lcSpan = card.querySelector('.like-count');
                    st_likeCounts[postId] = lcSpan ? parseInt(lcSpan.textContent) || 0 : 0;
                }

                // Replace action-buttons with full set (Like, Comment, Share)
                var actionDiv = card.querySelector('.action-buttons');
                if (actionDiv) {
                    actionDiv.innerHTML =
                        '<button type="button" class="action-btn like-btn" onclick="toggleLike(' + postId + ')">' +
                            '<i class="far fa-heart"></i> Like' +
                        '</button>' +
                        '<button type="button" class="action-btn" onclick="toggleCommentSection(' + postId + ')">' +
                            '<i class="far fa-comment"></i> Comment' +
                        '</button>' +
                        '<button type="button" class="action-btn" onclick="sharePost(' + postId + ', this)">' +
                            '<i class="fas fa-share-alt"></i> Share' +
                        '</button>';
                }

                // Wire up stats bar clicks
                var statsSpans = card.querySelectorAll('.post-stats span');
                if (statsSpans[0]) statsSpans[0].onclick = function() { toggleLike(postId); };
                if (statsSpans[1]) statsSpans[1].onclick = function() { toggleCommentSection(postId); };
                if (statsSpans[2]) statsSpans[2].onclick = function() { sharePost(postId, null); };

                // Apply current state
                applyCardState(card);
            });

            saveSharedState();
            updateNotifBadge();
        }

        // -- Interactions --------------------------------------
        function toggleLike(postId) {
            fetch('LikeHandler.ashx?action=toggle&postId=' + postId, { credentials: 'same-origin' })
                .then(function(r) { return r.json(); })
                .then(function(res) {
                    if (!res.ok) { showToast('Error: ' + res.error); return; }
                    st_likes[postId]      = res.liked;
                    st_likeCounts[postId] = res.likeCount;
                    saveSharedState();
                    var card = document.querySelector('.announcement-card[data-post-id="' + postId + '"]');
                    if (card) applyCardState(card);
                    showToast(res.liked ? '?? Liked!' : 'Like removed');
                })
                .catch(function() { showToast('Could not update like'); });
        }

        function togglePin(postId) {
            st_pins[postId] = !st_pins[postId];
            saveSharedState();
            var anns = ST.get('teacher_announcements') || [];
            var ann = anns.find(function(a) { return a.id === postId; });
            if (ann) pushNotification((st_pins[postId] ? '?? Student pinned: ' : '?? Student unpinned: ') + ann.title, 'fa-thumbtack');
            window.dispatchEvent(new StorageEvent('storage', { key: 'campus_pins',  newValue: JSON.stringify(st_pins) }));
            window.dispatchEvent(new StorageEvent('storage', { key: 'teacher_pins', newValue: JSON.stringify(st_pins) }));
            var card = document.querySelector('.announcement-card[data-post-id="' + postId + '"]');
            if (card) applyCardState(card);
            sortCardsByPin();
            showToast(st_pins[postId] ? '?? Pinned!' : 'Unpinned');
        }

        function toggleNotif(postId) {
            st_notifs[postId] = !st_notifs[postId];
            saveSharedState();
            var card = document.querySelector('.announcement-card[data-post-id="' + postId + '"]');
            if (card) applyCardState(card);
            updateNotifBadge();
            showToast(st_notifs[postId] ? '?? Notifications on!' : '?? Notifications off');
        }

        function toggleCommentSection(postId) {
            var sec = document.getElementById('commentsSection_' + postId);
            if (!sec) return;
            var isHidden = sec.style.display === 'none' || sec.style.display === '';
            sec.style.display = isHidden ? 'block' : 'none';
            if (isHidden) {
                loadComments(postId);
                var input = document.getElementById('commentInput_' + postId);
                if (input) setTimeout(function() { input.focus(); }, 50);
            }
        }

        function loadComments(postId) {
            fetch('CommentHandler.ashx?action=get&postId=' + postId, { credentials: 'same-origin' })
                .then(function(r) { return r.json(); })
                .then(function(list) {
                    var cl = document.getElementById('commentsList_' + postId);
                    if (!cl) return;
                    if (!list.length) {
                        cl.innerHTML = '<div class="no-comments">No comments yet. Be the first!</div>';
                        return;
                    }
                    cl.innerHTML = list.map(function(c) {
                        return '<div class="comment">' +
                            '<div class="comment-avatar"><i class="fas fa-user"></i></div>' +
                            '<div class="comment-content">' +
                                '<span class="comment-author">' + escapeHtml(c.author) + '</span>' +
                                '<div class="comment-text">' + escapeHtml(c.text) + '</div>' +
                                '<div class="comment-time">' + escapeHtml(c.date) + '</div>' +
                            '</div></div>';
                    }).join('');
                    var ccSpan = document.querySelector('.announcement-card[data-post-id="' + postId + '"] .comment-count');
                    if (ccSpan) ccSpan.textContent = list.length;
                })
                .catch(function() {});
        }

        function addComment(btn, postId) {
            var input = document.getElementById('commentInput_' + postId);
            if (!input) return;
            var text = input.value.trim();
            if (!text) { showToast('Please enter a comment!'); return; }

            fetch('CommentHandler.ashx?action=add', {
                method: 'POST',
                credentials: 'same-origin',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ postId: postId, comment: text })
            })
            .then(function(r) { return r.json(); })
            .then(function(res) {
                if (!res.success) { showToast('Error: ' + (res.error || 'Could not post comment')); return; }
                input.value = '';
                loadComments(postId);
                showToast('?? Comment posted!');
            })
            .catch(function() { showToast('Could not post comment'); });
        }

        function sharePost(postId, btn) {
            var url = window.location.href.split('?')[0] + '?post=' + postId;
            var anns = ST.get('teacher_announcements') || [];
            var ann = anns.find(function(a) { return a.id === postId; });
            if (ann) pushNotification('?? Student shared "' + ann.title + '"', 'fa-share-alt');
            if (navigator.clipboard) {
                navigator.clipboard.writeText(url).then(function() { showToast('?? Link copied!'); });
            } else {
                showToast('?? Shared!');
            }
        }

        function sortCardsByPin() {
            var container = document.getElementById('announcementsContainer');
            if (!container) return;
            var cards = Array.from(container.querySelectorAll('.announcement-card'));
            cards.sort(function(a, b) {
                var aId = parseInt(a.getAttribute('data-post-id'));
                var bId = parseInt(b.getAttribute('data-post-id'));
                return (st_pins[bId] ? 1 : 0) - (st_pins[aId] ? 1 : 0);
            });
            cards.forEach(function(c) { container.appendChild(c); });
        }

        function updateNotifBadge() {
            var notifs = JSON.parse(localStorage.getItem('campus_notifications') || '[]');
            var count = notifs.filter(function(n) { return !n.read; }).length;
            var badge = document.getElementById('notificationBadge');
            if (badge) {
                badge.textContent = count;
                badge.style.display = count > 0 ? 'inline-block' : 'none';
            }
        }

        // -- Sync pins from other tabs -------------------------
        window.addEventListener('storage', function(e) {
            if (e.key === 'campus_pins' || e.key === 'teacher_pins') {
                var tp = ST.get('teacher_pins') || {};
                var cp = ST.get('campus_pins')  || {};
                st_pins = Object.assign({}, cp, tp);
                document.querySelectorAll('.announcement-card').forEach(function(card) {
                    applyCardState(card);
                });
                sortCardsByPin();
            }
        });

        // -- Category filter -----------------------------------
        function filterCategory(category) {
            var cards = document.querySelectorAll('.announcement-card');
            cards.forEach(function(card) {
                var cat = card.getAttribute('data-category') || '';
                card.style.display = (category === 'All' || cat.toLowerCase() === category.toLowerCase()) ? '' : 'none';
            });
            var label = document.getElementById('activeFilterLabel');
            if (label) label.innerText = category;
        }

        // -- Notification read ---------------------------------
        function markNotificationRead(item, notificationId) {
            item.classList.remove('unread');
            var dot = item.querySelector('.notification-dot');
            if (dot) dot.remove();
        }

        function markAllRead() {
            document.querySelectorAll('.notification-item.unread').forEach(function(item) {
                item.classList.remove('unread');
                var dot = item.querySelector('.notification-dot');
                if (dot) dot.remove();
            });
            var badge = document.getElementById('notificationBadge');
            if (badge) badge.style.display = 'none';
        }

        // -- Theme ---------------------------------------------
        function toggleTheme(btn) {
            var isDark = document.body.classList.toggle('dark-mode');
            var toggle = document.getElementById('themeToggle');
            if (toggle) toggle.classList.toggle('active', isDark);
            localStorage.setItem('campus_theme', isDark ? 'dark' : 'light');
        }

        function openAboutModal() {
            var modal = document.getElementById('aboutModal');
            if (modal) modal.style.display = 'flex';
        }

        function closeAboutModal() {
            var modal = document.getElementById('aboutModal');
            if (modal) modal.style.display = 'none';
        }

        function showToast(message) {
            var t = document.createElement('div');
            t.innerText = message;
            t.style.cssText = 'position:fixed;bottom:28px;left:50%;transform:translateX(-50%);background:#1a3a5c;color:#fff;padding:10px 24px;border-radius:30px;font-size:13px;z-index:9999;box-shadow:0 4px 16px rgba(0,0,0,.25);pointer-events:none;';
            document.body.appendChild(t);
            setTimeout(function() { if (t.parentNode) t.parentNode.removeChild(t); }, 2500);
        }

        function escapeHtml(s) {
            if (!s) return '';
            return String(s).replace(/[&<>"'\/]/g, function(c) {
                return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;','/':'&#x2F;'}[c];
            });
        }

        function logout() {
            window.location.href = 'Logout.aspx';
        }

        // -- Restore theme on load ------------------------------
        (function() {
            if (localStorage.getItem('campus_theme') === 'dark') {
                document.body.classList.add('dark-mode');
                var toggle = document.getElementById('themeToggle');
                if (toggle) toggle.classList.add('active');
            }
            // Sync theme changes from other tabs
            window.addEventListener('storage', function(e) {
                if (e.key === 'campus_theme') {
                    var dark = e.newValue === 'dark';
                    document.body.classList.toggle('dark-mode', dark);
                    var toggle = document.getElementById('themeToggle');
                    if (toggle) toggle.classList.toggle('active', dark);
                }
            });
        })();

        // -- Render announcements from DB ---------------------
        function renderAnnouncementsFromStorage() {
            var container = document.getElementById('announcementsContainer');
            if (container) container.innerHTML = '<div style="text-align:center;padding:40px;color:var(--muted)"><i class="fas fa-spinner fa-spin"></i> Loading...</div>';

            fetch('AnnouncementHandler.ashx?action=getAll', { credentials: 'same-origin' })
                .then(function(r) { return r.json(); })
                .then(function(res) {
                    if (!res.ok) { showToast('Error loading announcements'); return; }
                    var announcements = res.data;
                    if (!announcements.length) {
                        container.innerHTML = '<div style="text-align:center;padding:40px;color:var(--muted)">No announcements yet.</div>';
                        updateNotifBadge();
                        return;
                    }

                    var categoryClass = function(cat) {
                        return cat === 'Exam' ? 'post-category-exam'
                             : cat === 'Suspension' ? 'post-category-suspension'
                             : cat === 'Event' ? 'post-category-event'
                             : 'post-category-general';
                    };

                    container.innerHTML = announcements.map(function(post) {
                        var isPinned     = !!post.isPinned;
                        var liked        = !!st_likes[post.id];
                        var likeCount    = post.likeCount || 0;
                        var commentCount = post.commentCount || 0;

                        if (st_likeCounts[post.id] === undefined) st_likeCounts[post.id] = post.likeCount || 0;

                        return '<div class="announcement-card" data-post-id="' + post.id + '" data-category="' + escapeHtml(post.category) + '">' +
                            '<div class="post-header">' +
                                '<div class="post-header-left">' +
                                    '<div class="post-avatar"><i class="fas fa-user-tie"></i></div>' +
                                    '<div>' +
                                        '<div class="post-author">' + escapeHtml(post.author) + '</div>' +
                                        '<div class="post-meta">' +
                                            '<span><i class="far fa-calendar-alt"></i> ' + escapeHtml(post.date) + '</span>' +
                                            '<span class="post-category ' + categoryClass(post.category) + '">' + escapeHtml(post.category) + '</span>' +
                                        '</div>' +
                                    '</div>' +
                                '</div>' +
                                '<button type="button" class="pin-btn-top ' + (isPinned ? 'pinned' : '') + '" onclick="togglePin(' + post.id + ')" title="' + (isPinned ? 'Unpin' : 'Pin') + '">' +
                                    '<i class="' + (isPinned ? 'fas' : 'far') + ' fa-thumbtack"></i>' +
                                '</button>' +
                            '</div>' +
                            '<div class="post-content">' +
                                '<div class="post-title">' + escapeHtml(post.title) + '</div>' +
                                '<div class="post-text">' + escapeHtml(post.content) + '</div>' +
                                (post.imageUrl ? '<div class="post-image"><img src="' + escapeHtml(post.imageUrl) + '" alt="Announcement image" onerror="this.style.display=\'none\'" /></div>' : '') +
                            '</div>' +
                            '<div class="post-stats">' +
                                '<span onclick="toggleLike(' + post.id + ')"><i class="' + (liked ? 'fas' : 'far') + ' fa-heart"></i> <span class="like-count">' + likeCount + '</span> Likes</span>' +
                                '<span onclick="toggleCommentSection(' + post.id + ')"><i class="far fa-comment"></i> <span class="comment-count">' + commentCount + '</span> Comments</span>' +
                                '<span onclick="sharePost(' + post.id + ', null)"><i class="far fa-share-square"></i> Share</span>' +
                            '</div>' +
                            '<div class="action-buttons">' +
                                '<button type="button" class="action-btn like-btn' + (liked ? ' liked' : '') + '" onclick="toggleLike(' + post.id + ')">' +
                                    '<i class="' + (liked ? 'fas' : 'far') + ' fa-heart"></i> ' + (liked ? 'Liked' : 'Like') +
                                '</button>' +
                                '<button type="button" class="action-btn" onclick="toggleCommentSection(' + post.id + ')"><i class="far fa-comment"></i> Comment</button>' +
                                '<button type="button" class="action-btn" onclick="sharePost(' + post.id + ', null)"><i class="fas fa-share-alt"></i> Share</button>' +
                            '</div>' +
                            '<div class="comments-section" id="commentsSection_' + post.id + '" style="display:none;">' +
                                '<div class="comment-input">' +
                                    '<input type="text" id="commentInput_' + post.id + '" placeholder="Write a comment..." />' +
                                    '<button type="button" onclick="addComment(this, ' + post.id + ')">Post</button>' +
                                '</div>' +
                                '<div class="comments-list" id="commentsList_' + post.id + '">' +
                                    '<div class="no-comments">No comments yet. Be the first!</div>' +
                                '</div>' +
                            '</div>' +
                        '</div>';
                    }).join('');

                    // Sync pins to localStorage for Pinned.aspx / Search pages
                    st_pins = {};
                    announcements.forEach(function(a) { if (a.isPinned) st_pins[a.id] = true; });
                    saveSharedState();
                    updateNotifBadge();
                })
                .catch(function() { showToast('Could not load announcements'); });
        }

        function deletePost(postId) {
            if (!confirm('Delete this announcement?')) return;
            fetch('AnnouncementHandler.ashx?action=delete&id=' + postId, { credentials: 'same-origin' })
                .then(function(r) { return r.json(); })
                .then(function(res) {
                    if (!res.ok) { showToast('Error: ' + res.error); return; }
                    renderAnnouncementsFromStorage();
                    showToast('??? Post deleted');
                })
                .catch(function() { showToast('Could not delete post'); });
        }

        // -- Run on page load ----------------------------------
        (function() {
            renderAnnouncementsFromStorage();
        })();

        // -- Page Flip Transition -----------------------------------------------
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

        // -- Performance: prefetch linked pages --------------------------------
        (function() {
            var pages = ['SearchStudent.aspx', 'Pinned.aspx', 'Notifications.aspx'];
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