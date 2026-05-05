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
            --primary: #1a2a3a;
            --primary-2: #1a9aaa;
            --muted: #6b7c8f;
            --muted-light: #9db0c4;
            --shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
            --active-bg: #e0f7fa;
        }

        html, body, form { height: auto; min-height: 100%; }
        html, body { overflow: auto; }
        html::-webkit-scrollbar { display: none; }
        html { scrollbar-width: none; -ms-overflow-style: none; }

        /* Cover content that scrolls behind the fixed header */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: 10px;
            z-index: 1199;
            pointer-events: none;
            background: transparent;
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

        a { color: inherit; text-decoration: none; }
        button, input, textarea { font: inherit; }

        .app-shell {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            gap: 16px;
            padding: 120px 20px 32px 16px;
            overflow-y: visible;
        }

        /* Dashboard layout: sidebar + main side by side */
        .dashboard-body {
            display: flex;
            gap: 16px;
            align-items: flex-start;
            flex: 1;
        }

        .header {
            background: #2AACBF;
            backdrop-filter: blur(10px);
            border-radius: 24px;
            padding: 12px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.2);
            border: 1px solid rgba(255,255,255,0.15);
            position: fixed;
            top: 10px;
            left: 10px;
            right: 10px;
            z-index: 1200;
        }

        form { height: auto; min-height: 100%; overflow: visible; }

        .logo { font-size: 22px; font-weight: 800; color: var(--primary); white-space: nowrap; cursor: pointer; background: none; border: none; }
        .logo i { color: var(--primary); margin-right: 8px; }

        .search-container {
            display: flex;
            gap: 10px;
            align-items: center;
            flex: 1;
            justify-content: center;
            min-width: 0;
            overflow: hidden;
            position: relative;
            top: 1px;
            left: 0px;
            height: 54px;
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
            width: 100%;
            max-width: 340px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            position: relative;
            z-index: 1;
        }

        .search-btn::before {
            font-family: "Font Awesome 6 Free";
            font-weight: 900;
            content: "\f002";
            margin-right: 8px;
        }

        .search-btn:hover {
            border-color: rgba(26,58,92,0.4);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        .header-actions {
            display: flex;
            gap: 15px;
            align-items: center;
            white-space: nowrap;
            position: relative;
            z-index: 2;
            flex-shrink: 0;
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

        /* LEFT SIDEBAR — always visible */
        .slideout-panel {
            position: fixed;
            top: 120px;
            left: 10px;
            width: 260px;
            height: calc(100vh - 130px);
            backdrop-filter: blur(16px);
            box-shadow: 4px 0 24px rgba(0, 0, 0, 0.08);
            z-index: 1100;
            display: flex;
            flex-direction: column;
            border-radius: 16px;
            overflow: hidden;
            }
        .panel-header {
            padding: 24px 16px 16px;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
        }
        .panel-header h3 {
            font-size: 18px;
            font-weight: 700;
            color: var(--primary);
            margin: 0;
        }
        .panel-menu-list {
            flex: 1;
            overflow-y: auto;
            padding: 12px 0;
        }
        .panel-menu-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 20px;
            cursor: pointer;
            width: 100%;
            border: none;
            background: none;
            text-align: left;
            font-size: 14px;
            font-weight: 500;
            color: var(--page-text);
            transition: all 0.2s;
            border-left: 3px solid transparent;
        }
        .panel-menu-item i {
            width: 20px;
            font-size: 16px;
            color: #2AACBF;
        }
        .panel-menu-item:hover {
            background: #e6f7f9;
            color: #007a8a;
            border-left-color: #00bcd4;
        }
        .panel-menu-item.active {
            background: linear-gradient(135deg, #005f73, #00bcd4);
            color: #ffffff;
            border-left-color: transparent;
        }
        .panel-menu-item.active i { color: #ffffff; }
        .category-dropdown-panel {
            margin-left: 44px;
            margin-bottom: 8px;
            display: none;
            flex-direction: column;
            gap: 4px;
        }
        .dropdown-item-panel {
            background: none;
            border: none;
            text-align: left;
            padding: 7px 10px;
            cursor: pointer;
            width: 100%;
            font-size: 13px;
            color: var(--page-text);
            border-radius: 10px;
            transition: all 0.2s;
        }
        .dropdown-item-panel i { color: #2AACBF; }
        .dropdown-item-panel:hover {
            background: var(--surface-soft);
            color: var(--primary);
        }
        .dropdown-item-panel.active-filter {
            background: #2AACBF;
            color: #ffffff;
            font-weight: 700;
        }
        .dropdown-item-panel.active-filter i { color: #ffffff; }
        .theme-toggle-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%;
        }
        .theme-toggle-row .toggle-switch-panel {
            width: 40px;
            height: 20px;
            background: #dce4ec;
            border-radius: 30px;
            position: relative;
            cursor: pointer;
            transition: all 0.3s;
            flex-shrink: 0;
        }
        .theme-toggle-row .toggle-switch-panel.active {
            background: linear-gradient(135deg, #2AACBF, #1a9aaa);
        }
        .theme-toggle-row .toggle-switch-panel::after {
            content: '';
            width: 16px;
            height: 16px;
            background: #ffffff;
            border-radius: 50%;
            position: absolute;
            top: 2px;
            left: 2px;
            transition: all 0.3s;
        }
        .theme-toggle-row .toggle-switch-panel.active::after {
            left: 22px;
        }
        .divider-light {
            height: 1px;
            background: var(--border);
            margin: 6px 16px;
        }
        .overlay-black {
            display: none !important;
            pointer-events: none !important;
        }

        /* Dashboard always offset by sidebar width */
        .app-shell {
            padding-left: 286px;
        }

        .avatar, .profile-avatar, .post-avatar {
            background: linear-gradient(135deg, #2AACBF, #1a9aaa);
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
        .user-role, .profile-email, .post-meta, .comment-time { color: var(--muted); }

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
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
            overflow: visible;
        }

        .main-panel.card {
            height: calc(100vh - 140px);
            position: sticky;
            top: 120px;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        .card-header {
            padding: 18px 22px;
            border-bottom: 1px solid rgba(26,58,92,0.08);
            font-weight: 700;
            color: var(--primary);
            font-size: 16px;
            flex-shrink: 0;
            border-radius: 24px 24px 0 0;
        }

        .card-header i { margin-right: 10px; color: var(--primary); }

        .announcement-board {
            flex: 1 1 auto;
            min-height: 0;
            overflow-y: auto;
            padding: 18px;
            background: rgba(248, 250, 252, 0.35);
            scrollbar-width: none;
            -ms-overflow-style: none;
        }

        .announcement-board::-webkit-scrollbar { display: none; }

        .announcement-card {
            background: var(--surface-strong);
            border-radius: 20px;
            margin-bottom: 20px;
            border: 1px solid #2AACBF;
            transition: all 0.3s;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
            overflow: hidden;
            scroll-margin-top: 20px;
        }

        .announcement-card:hover {
            box-shadow: 0 8px 18px rgba(0, 0, 0, 0.08);
            border-color: #1a9aaa;
        }

        .announcement-card.notification-target {
            border-color: #f59e0b;
            box-shadow: 0 0 0 3px rgba(245, 158, 11, 0.22), 0 12px 28px rgba(245, 158, 11, 0.18);
            animation: targetPulse 2s ease-in-out 2;
        }

        @keyframes targetPulse {
            0%   { transform: scale(1); }
            50%  { transform: scale(1.01); }
            100% { transform: scale(1); }
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

        .post-category-exam { background: #e0f7fa; color: #2AACBF; }
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
            max-height: 200px;
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
            background: linear-gradient(135deg, #2AACBF, #1a9aaa);
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
            background: #e0f7fa;
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
            z-index: 9000;
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

        /* Light mode — white text on dark #1a3a5c header */
        body:not(.dark-mode) .header .logo,
        body:not(.dark-mode) .header .logo i,
        body:not(.dark-mode) .header .user-name,
        body:not(.dark-mode) .header .user-role,
        body:not(.dark-mode) .header .bell-icon,
        body:not(.dark-mode) .header .search-btn { color: #ffffff; }
        body:not(.dark-mode) .header .search-btn { border-color: rgba(255,255,255,0.35); }
        body:not(.dark-mode) .header .user-info {
            background: rgba(255,255,255,0.12);
            border-color: rgba(255,255,255,0.25);
        }
        body:not(.dark-mode) .header .user-info .user-name,
        body:not(.dark-mode) .header .user-info .user-role { color: #ffffff; }
        body:not(.dark-mode) .header .user-info:hover { background: rgba(255,255,255,0.2); }
        body:not(.dark-mode) .header .notification-bell {
            background: rgba(255,255,255,0.12);
            border-color: rgba(255,255,255,0.25);
        }
        body:not(.dark-mode) .header .notification-bell .bell-icon { color: #ffffff; }
        body:not(.dark-mode) .header .search-btn:hover {
            background: rgba(255,255,255,0.18);
            border-color: rgba(255,255,255,0.6);
            color: #ffffff;
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
        body.dark-mode .announcement-card.notification-target {
            border-color: #fbbf24;
            box-shadow: 0 0 0 3px rgba(251, 191, 36, 0.25), 0 12px 28px rgba(251, 191, 36, 0.18);
        }
        body.dark-mode .card               { 
            background: rgba(30, 41, 59, 0.95); 
            border-color: rgba(148, 163, 184, 0.2); 
        }
        body.dark-mode .header             { 
            background: rgba(15,25,55,0.85); 
            border-color: rgba(255,255,255,0.08);
            box-shadow: 0 4px 24px rgba(0,0,0,0.5);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
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
        /* Modal text */
        body.dark-mode .modal-content      { background: rgba(30,41,59,0.98); border-color: rgba(148,163,184,0.2); }
        body.dark-mode .modal-title,
        body.dark-mode #pm-fullname        { color: #e0e7ff; }
        body.dark-mode #pm-username,
        body.dark-mode #pm-email,
        body.dark-mode #pm-role            { color: #e2e8f0; }
        /* Like button active */
        body.dark-mode .action-btn.liked   { color: #f87171; }
        /* Pin button unpinned in dark */
        body.dark-mode .pin-btn-top        { color: rgba(148,163,184,0.5); }
        body.dark-mode .pin-btn-top.pinned { color: #fb923c; }
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
            border-left-color: #93c5fd;
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
        
        /* Hamburger menu — removed (sidebar is always visible) */

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
            .app-shell { height: auto; min-height: 100%; overflow: visible; padding-left: 20px; padding-top: 120px; }
            .slideout-panel { display: none; }
            .dashboard-body { display: block; }
            .content-shell { overflow: visible; }
            .main-panel.card { height: auto; position: static; overflow: visible; }
            .announcement-board { overflow: visible; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
                <button type="button" class="logo" onclick="navigateWithFlip('Student.aspx')">
                    <i class="fas fa-university"></i> Campus Announcement</button>

                <div class="search-container">
                    <asp:Button ID="searchButton" runat="server" CssClass="search-btn" Text="Search........" OnClientClick="navigateWithFlip('SearchStudent.aspx'); return false;" UseSubmitBehavior="false" />
                </div>

                <div class="header-actions">
                    <button type="button" class="notification-bell" onclick="navigateWithFlip('Notifications.aspx')">
                        <i class="fas fa-bell bell-icon"></i>
                        <span id="notificationBadge" class="badge-red" style="display:none;">0="display:none;">0</span>
                    </button>
                    <button type="button" class="user-info" onclick="window.location.href='Profile.aspx'">
                        <div class="avatar" id="headerAvatar" style="overflow:hidden;">
                            <% if (Session["ProfileImage"] != null && !string.IsNullOrEmpty(Session["ProfileImage"].ToString())) { %>
                                <img src="<%= Session["ProfileImage"].ToString() %>" alt="Profile"
                                     style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;" />
                            <% } else { %>
                                <i class="fas fa-user"></i>
                            <% } %>
                        </div>
                        <div class="user-details">
                            <div class="user-name" id="userName"><%= Session["Username"] ?? "User" %></div>
                            <div class="user-role" id="userRole"><%= Session["Role"] ?? "Student" %></div>
                        </div>
                    </button>
                    <!-- Hamburger button removed — sidebar is always visible -->
                </div>
            </div>
        <div class="app-shell">
            <div class="dashboard-body">
            <div id="slideoutPanel" class="slideout-panel">
                <div class="panel-header">
                    <h3><i class="fas fa-sliders-h"></i> Menu</h3>
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
            </div><!-- end dashboard-body -->
        </div>

        <!-- Profile Modal -->
        <div id="profileModal" class="modal" style="display:none;">
            <div class="modal-content" style="max-width:420px;text-align:left;">
                <div style="text-align:center;margin-bottom:20px;">
                    <div style="width:72px;height:72px;border-radius:50%;background:linear-gradient(135deg,#2AACBF,#1a9aaa);color:#fff;display:flex;align-items:center;justify-content:center;font-size:28px;margin:0 auto 12px;">
                        <i class="fas fa-user"></i>
                    </div>
                    <div class="modal-title" style="margin-bottom:4px;" id="pm-fullname"><%= Session["FullName"] ?? "User" %></div>
                    <span style="display:inline-block;padding:3px 14px;border-radius:20px;font-size:11px;font-weight:700;background:#e0f7fa;color:#2AACBF;" id="pm-role"><%= Session["Role"] ?? "Student" %></span>
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
            t.style.cssText = 'position:fixed;bottom:30px;left:50%;transform:translateX(-50%);background:#2AACBF;color:#fff;padding:8px 20px;border-radius:30px;z-index:9999';
            document.body.appendChild(t);
            setTimeout(() => t.remove(), 2500);
        }

        // ====================== MEDIA RENDER HELPER ======================
        var videoExts  = ['mp4','webm','ogg','mov','avi'];
        var imageExts  = ['jpg','jpeg','png','gif','webp','bmp'];

        function getExt(url) {
            return (url.split('.').pop() || '').toLowerCase().split('?')[0];
        }

        function renderMediaHtml(mediaUrl) {
            if (!mediaUrl) return '';
            var urls = mediaUrl.split(',').map(function(u) { return u.trim(); }).filter(Boolean);
            if (!urls.length) return '';
            var html = '';
            var images = urls.filter(function(u) { return imageExts.indexOf(getExt(u)) !== -1; });
            var videos = urls.filter(function(u) { return videoExts.indexOf(getExt(u)) !== -1; });
            var files  = urls.filter(function(u) { return imageExts.indexOf(getExt(u)) === -1 && videoExts.indexOf(getExt(u)) === -1; });

            if (images.length === 1) {
                html += `<div class="post-image"><img src="${images[0]}" style="cursor:zoom-in;" onclick="openLightbox('${images[0]}')" onerror="this.style.display='none'" /></div>`;
            } else if (images.length > 1) {
                html += `<div class="post-image" style="display:flex;flex-wrap:wrap;gap:6px;">`;
                images.forEach(function(img) {
                    html += `<img src="${img}" style="width:calc(50% - 3px);max-height:160px;object-fit:cover;border-radius:12px;cursor:zoom-in;flex:1 1 calc(50% - 3px);" onclick="openLightbox('${img}')" onerror="this.style.display='none'" />`;
                });
                html += `</div>`;
            }

            videos.forEach(function(vid) {
                html += `<div class="post-image" style="margin-top:10px;"><video controls style="width:100%;max-height:280px;border-radius:16px;display:block;"><source src="${vid}" />Your browser does not support video.</video></div>`;
            });

            files.forEach(function(f) {
                var fname = f.split('/').pop();
                html += `<div style="margin-top:10px;padding:10px 14px;background:var(--surface-soft);border:1px solid var(--border);border-radius:12px;display:flex;align-items:center;gap:10px;">
                    <i class="fas fa-file-alt" style="color:var(--primary);font-size:18px;"></i>
                    <span style="flex:1;font-size:13px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">${fname}</span>
                    <a href="${f}" download="${fname}" style="padding:6px 14px;background:var(--primary);color:#fff;border-radius:20px;font-size:12px;font-weight:600;text-decoration:none;white-space:nowrap;"><i class="fas fa-download" style="margin-right:4px;"></i>Download</a>
                </div>`;
            });

            return html;
        }

        // ====================== LIGHTBOX ======================
        function openLightbox(src) {
            var lb = document.getElementById('imageLightbox');
            var lbImg = document.getElementById('lightboxImg');
            if (!lb || !lbImg) return;
            lbImg.src = src;
            lb.style.display = 'flex';
            document.body.style.overflow = 'hidden';
        }

        function closeLightbox() {
            var lb = document.getElementById('imageLightbox');
            if (lb) lb.style.display = 'none';
            document.body.style.overflow = '';
        }

        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') closeLightbox();
        });

        function escapeHtml(str) { if (!str) return ''; return str.replace(/[&<>]/g, m => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;' })[m]); }

        function timeAgo(dateStr) {
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

        // ====================== SIDEBAR (always visible, no toggle needed) ======================

        // Category dropdown toggle inside panel
        document.getElementById('filterCategoryBtn').addEventListener('click', function (e) {
            e.stopPropagation();
            let panel = document.getElementById('categoryDropdownPanel');
            panel.style.display = panel.style.display === 'flex' ? 'none' : 'flex';
        });

        // Theme toggle from panel
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
                btn.classList.toggle('active-filter', val === category);
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
                    showToast(res.liked ? 'Liked!' : 'Like removed');
                })
                .catch(err => {
                    console.error('Like error:', err);
                    showToast('Could not update like');
                });
        }

        function togglePin(postId) {
            fetch('UserPinHandler.ashx?action=toggle&announcementId=' + postId, { credentials: 'same-origin' })
                .then(r => r.json())
                .then(res => {
                    if (!res.ok) { showToast('Error: ' + (res.error || 'Could not update pin')); return; }
                    if (res.isPinned) {
                        st_pins[postId] = true;
                    } else {
                        delete st_pins[postId];
                    }
                    // Update pin button UI without full re-render
                    let btn = document.querySelector(`.pin-btn-top[onclick="togglePin(${postId})"]`);
                    if (btn) {
                        btn.classList.toggle('pinned', res.isPinned);
                        btn.title = res.isPinned ? 'Unpin' : 'Pin';
                    }
                    showToast(res.isPinned ? '📌 Pinned!' : 'Unpinned');
                })
                .catch(() => showToast('Could not update pin'));
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
                .then(data => {
                    // API returns array on success, object with success:false on error
                    if (!Array.isArray(data)) {
                        console.error('CommentHandler error:', data);
                        listDiv.innerHTML = '<div class="no-comments" style="color:#ef4444;">Error: ' + escapeHtml(data.error || 'Unknown error') + '</div>';
                        return;
                    }
                    const comments = data;
                    if (!comments.length) { listDiv.innerHTML = '<div class="no-comments">No comments yet.</div>'; return; }

                    // Build a map for quick lookup
                    const commentMap = {};
                    comments.forEach(c => { commentMap[c.commentId] = c; });

                    // Find the root ancestor of any comment
                    function getRootId(c) {
                        let visited = new Set();
                        while (c.parentCommentId != null && c.parentCommentId !== 0) {
                            if (visited.has(c.commentId)) break; // cycle guard
                            visited.add(c.commentId);
                            let parent = commentMap[c.parentCommentId];
                            if (!parent) break;
                            c = parent;
                        }
                        return c.commentId;
                    }

                    // Separate top-level and all replies (flatten all nested replies under root)
                    const topLevel = comments.filter(c => c.parentCommentId == null || c.parentCommentId === 0);
                    const replies  = comments.filter(c => c.parentCommentId != null && c.parentCommentId !== 0);

                    if (!topLevel.length) {
                        listDiv.innerHTML = comments.map(c => {
                            let cAvatar = c.profileImage
                                ? `<div class="comment-avatar" style="overflow:hidden;width:32px;height:32px;min-width:32px;"><img src="${c.profileImage}" style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;" /></div>`
                                : `<div class="comment-avatar"><i class="fas fa-user"></i></div>`;
                            return `<div class="comment" data-comment-id="${c.commentId}">
                                ${cAvatar}
                                <div style="flex:1;min-width:0;">
                                    <span class="comment-author">${escapeHtml(c.author)}</span>
                                    <div class="comment-text">${escapeHtml(c.text)}</div>
                                    <div class="comment-time">${escapeHtml(c.date)}</div>
                                </div>
                            </div>`;
                        }).join('');
                        return;
                    }

                    listDiv.innerHTML = topLevel.map(c => {
                        let cAvatar = c.profileImage
                            ? `<div class="comment-avatar" style="overflow:hidden;width:32px;height:32px;min-width:32px;"><img src="${c.profileImage}" style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;" /></div>`
                            : `<div class="comment-avatar"><i class="fas fa-user"></i></div>`;

                        // All replies that belong to this root comment (any depth)
                        let commentReplies = replies.filter(r => getRootId(r) == c.commentId);
                        let repliesHtml = commentReplies.map(r => {
                            let rAvatar = r.profileImage
                                ? `<div class="comment-avatar" style="overflow:hidden;width:26px;height:26px;min-width:26px;"><img src="${r.profileImage}" style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;" /></div>`
                                : `<div class="comment-avatar" style="width:26px;height:26px;min-width:26px;font-size:10px;"><i class="fas fa-user"></i></div>`;
                            // Show @mention if replying to another reply
                            let replyingTo = (r.parentCommentId != null && r.parentCommentId !== 0 && r.parentCommentId != c.commentId)
                                ? `<span style="color:var(--primary-2);font-weight:600;">@${escapeHtml((commentMap[r.parentCommentId] || {}).author || '')}</span> `
                                : '';
                            return `<div class="comment reply-comment" style="margin-left:42px;padding:6px 0;border-bottom:none;">
                                ${rAvatar}
                                <div style="flex:1;min-width:0;">
                                    <span class="comment-author">${escapeHtml(r.author)}</span>
                                    <div class="comment-text">${replyingTo}${escapeHtml(r.text)}</div>
                                    <div style="display:flex;align-items:center;gap:12px;margin-top:4px;">
                                        <div class="comment-time">${escapeHtml(r.date)}</div>
                                        <button type="button" class="comment-like-btn ${r.userLiked ? 'liked' : ''}"
                                            onclick="likeComment(${r.commentId}, this)"
                                            style="background:none;border:none;cursor:pointer;font-size:12px;color:${r.userLiked ? '#dc2626' : 'var(--muted)'};display:flex;align-items:center;gap:4px;padding:0;transition:color 0.2s;">
                                            <i class="${r.userLiked ? 'fas' : 'far'} fa-heart"></i>
                                            <span class="clc">${r.likeCount > 0 ? r.likeCount : ''}</span>
                                        </button>
                                        <button type="button" onclick="toggleReplyBox(${r.commentId}, ${postId})"
                                            style="background:none;border:none;cursor:pointer;font-size:12px;color:var(--muted);padding:0;transition:color 0.2s;"
                                            onmouseover="this.style.color='var(--primary)'" onmouseout="this.style.color='var(--muted)'">
                                            <i class="fas fa-reply"></i> Reply
                                        </button>
                                    </div>
                                    <div id="replyBox_${r.commentId}" style="display:none;margin-top:8px;">
                                        <div class="comment-input" style="margin:0;">
                                            <input type="text" id="replyInput_${r.commentId}" placeholder="Write a reply..." style="font-size:12px;" />
                                            <button type="button" onclick="submitReply(${r.commentId}, ${postId})" style="padding:8px 16px;font-size:12px;">Reply</button>
                                        </div>
                                    </div>
                                </div>
                            </div>`;
                        }).join('');

                        return `<div class="comment" data-comment-id="${c.commentId}">
                            ${cAvatar}
                            <div style="flex:1;min-width:0;">
                                <span class="comment-author">${escapeHtml(c.author)}</span>
                                <div class="comment-text">${escapeHtml(c.text)}</div>
                                <div style="display:flex;align-items:center;gap:12px;margin-top:4px;">
                                    <div class="comment-time">${escapeHtml(c.date)}</div>
                                    <button type="button" class="comment-like-btn ${c.userLiked ? 'liked' : ''}"
                                        onclick="likeComment(${c.commentId}, this)"
                                        style="background:none;border:none;cursor:pointer;font-size:12px;color:${c.userLiked ? '#dc2626' : 'var(--muted)'};display:flex;align-items:center;gap:4px;padding:0;transition:color 0.2s;">
                                        <i class="${c.userLiked ? 'fas' : 'far'} fa-heart"></i>
                                        <span class="clc">${c.likeCount > 0 ? c.likeCount : ''}</span>
                                    </button>
                                    <button type="button" onclick="toggleReplyBox(${c.commentId}, ${postId})"
                                        style="background:none;border:none;cursor:pointer;font-size:12px;color:var(--muted);padding:0;transition:color 0.2s;"
                                        onmouseover="this.style.color='var(--primary)'" onmouseout="this.style.color='var(--muted)'">
                                        <i class="fas fa-reply"></i> Reply
                                    </button>
                                </div>
                                <div id="replyBox_${c.commentId}" style="display:none;margin-top:8px;">
                                    <div class="comment-input" style="margin:0;">
                                        <input type="text" id="replyInput_${c.commentId}" placeholder="Write a reply..." style="font-size:12px;" />
                                        <button type="button" onclick="submitReply(${c.commentId}, ${postId})" style="padding:8px 16px;font-size:12px;">Reply</button>
                                    </div>
                                </div>
                                ${repliesHtml}
                            </div>
                        </div>`;
                    }).join('');
                })
                .catch(err => {
                    console.error('Load comments error:', err);
                    listDiv.innerHTML = '<div class="no-comments">Could not load comments</div>';
                });
        }

        function likeComment(commentId, btn) {
            fetch('CommentHandler.ashx?action=likeComment&commentId=' + commentId, { credentials: 'same-origin' })
                .then(r => r.json())
                .then(res => {
                    if (!res.success) return;
                    btn.className = 'comment-like-btn' + (res.liked ? ' liked' : '');
                    btn.style.color = res.liked ? '#dc2626' : 'var(--muted)';
                    btn.querySelector('i').className = res.liked ? 'fas fa-heart' : 'far fa-heart';
                    btn.querySelector('.clc').textContent = res.likeCount > 0 ? res.likeCount : '';
                });
        }

        function toggleReplyBox(commentId, postId) {
            let box = document.getElementById('replyBox_' + commentId);
            if (!box) return;
            let isHidden = box.style.display === 'none';
            box.style.display = isHidden ? 'block' : 'none';
            if (isHidden) document.getElementById('replyInput_' + commentId)?.focus();
        }

        function submitReply(commentId, postId) {
            let input = document.getElementById('replyInput_' + commentId);
            let text = input ? input.value.trim() : '';
            if (!text) return showToast('Write a reply first');
            fetch('CommentHandler.ashx?action=reply', {
                method: 'POST', credentials: 'same-origin',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ postId: postId, parentCommentId: commentId, comment: text })
            }).then(r => r.json()).then(res => {
                if (res.success) {
                    input.value = '';
                    document.getElementById('replyBox_' + commentId).style.display = 'none';
                    loadCommentsFromDB(postId);
                    showToast('Reply posted');
                } else {
                    showToast('Error: ' + (res.error || 'Could not reply'));
                }
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
                    showToast('Comment added');
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
                    showToast('Link copied!');
                }).catch(() => {
                    showToast('Shared!');
                });
            } else {
                showToast('Shared!');
            }
            // Notify the announcement author
            fetch('NotificationHandler.ashx?action=notifyShare&postId=' + postId, { credentials: 'same-origin' })
                .catch(() => {});
        }

        // ====================== RENDER ANNOUNCEMENTS FROM API ======================
        function renderAnnouncements() {
            let container = document.getElementById('announcementsContainer');
            if (!container) return;

            // Load both announcements and user pins in parallel
            Promise.all([
                fetch('AnnouncementHandler.ashx?action=getAll', { credentials: 'same-origin' }).then(r => r.json()),
                fetch('UserPinHandler.ashx?action=getUserPins', { credentials: 'same-origin' }).then(r => r.json())
            ]).then(([res, pinRes]) => {
                    if (!res.ok) { container.innerHTML = '<div style="padding:40px;text-align:center;">Error loading</div>'; return; }
                    let announcements = res.data;
                    if (!announcements.length) { container.innerHTML = '<div style="padding:40px;text-align:center;">No announcements</div>'; return; }

                    // Build pin map from DB (includes both user pins + admin global pins)
                    st_pins = {};
                    if (pinRes.ok && pinRes.pinnedIds) {
                        pinRes.pinnedIds.forEach(id => { st_pins[id] = true; });
                    }
                    // Also mark DB-pinned posts (admin pins) as pinned
                    announcements.forEach(function(post) {
                        if (post.isPinned) st_pins[post.id] = true;
                    });

                    setTimeout(function () {
                        // If coming from a notification, reset filter to 'All' so the target post is visible
                        var notifPostId = parseInt(new URLSearchParams(window.location.search).get('postId') || '0', 10);
                        let savedFilter = (notifPostId > 0) ? 'All' : (localStorage.getItem('student_filter') || 'All');
                        if (notifPostId > 0) localStorage.setItem('student_filter', 'All');

                        container.innerHTML = announcements.map(post => {
                            let isPinned  = !!st_pins[post.id];
                            let liked     = !!post.userLiked;
                            let likeCount = post.likeCount || 0;
                            let catClass = post.category === 'Exam' ? 'post-category-exam'
                                : post.category === 'Suspension' ? 'post-category-suspension'
                                    : post.category === 'Event' ? 'post-category-event'
                                        : 'post-category-general';

                            let visible = savedFilter === 'All' || post.category === savedFilter;

                            // Post avatar — use profile image if available
                            let postAvatar = post.authorImage
                                ? `<div class="post-avatar" style="overflow:hidden;"><img src="${post.authorImage}" style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;" /></div>`
                                : `<div class="post-avatar"><i class="fas fa-user-tie"></i></div>`;

                            return `<div class="announcement-card" data-post-id="${post.id}" data-category="${post.category}" style="${visible ? '' : 'display:none'}">
                                    <div class="post-header">
                                        <div class="post-header-left">
                                            ${postAvatar}
                                            <div>
                                                <div class="post-author">${escapeHtml(post.author)}</div>
                                                <div class="post-meta"><span>${escapeHtml(timeAgo(post.date))}</span><span class="post-category ${catClass}">${escapeHtml(post.category)}</span></div>
                                            </div>
                                        </div>
                                        <button type="button" class="pin-btn-top ${isPinned ? 'pinned' : ''}" onclick="togglePin(${post.id})" title="${isPinned ? 'Unpin' : 'Pin'}"><i class="fas fa-thumbtack"></i></button>
                                    </div>
                                    <div class="post-content">
                                        <div class="post-title">${escapeHtml(post.title)}</div>
                                        <div class="post-text">${escapeHtml(post.content)}</div>
                                        ${renderMediaHtml(post.imageUrl)}
                                    </div>
                                    <div class="post-stats">
                                        <span onclick="toggleLike(${post.id})"><i class="${liked ? 'fas' : 'far'} fa-heart" style="${liked ? 'color:#dc2626' : ''}"></i> <span class="like-count">${likeCount}</span> Likes</span>
                                        <span onclick="toggleCommentSection(${post.id})"><i class="far fa-comment"></i> <span class="comment-count">${post.commentCount || 0}</span> Comments</span>
                                        <span onclick="sharePost(${post.id})"><i class="far fa-share-square"></i> Share</span>
                                    </div>
                                    <div class="action-buttons">
                                        <button type="button" class="action-btn like-btn ${liked ? 'liked' : ''}" onclick="toggleLike(${post.id})"><i class="${liked ? 'fas' : 'far'} fa-heart"></i> ${liked ? 'Liked' : 'Like'}</button>
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
                        document.querySelectorAll('[data-filter]').forEach(btn => {
                            btn.classList.toggle('active-filter', btn.getAttribute('data-filter') === savedFilter);
                        });

                        updateNotifBadge();

                        // ── Highlight post from notification link after render ──
                        (function () {
                            var params = new URLSearchParams(window.location.search);
                            var pid = parseInt(params.get('postId') || '0', 10);
                            if (!isNaN(pid) && pid > 0) {
                                var card = document.querySelector('.announcement-card[data-post-id="' + pid + '"]');
                                if (card) {
                                    card.classList.add('notification-target');

                                    var board = document.getElementById('announcementsContainer');
                                    var boardStyle = board ? window.getComputedStyle(board).overflowY : 'visible';
                                    var boardScrollable = boardStyle === 'auto' || boardStyle === 'scroll';

                                    if (board && boardScrollable) {
                                        // Board is the scroll container
                                        var boardRect = board.getBoundingClientRect();
                                        var cardRect  = card.getBoundingClientRect();
                                        var offset    = cardRect.top - boardRect.top + board.scrollTop - 20;
                                        board.scrollTo({ top: offset, behavior: 'smooth' });
                                    } else {
                                        // Page is the scroll container (mobile/responsive)
                                        card.scrollIntoView({ behavior: 'smooth', block: 'center' });
                                    }

                                    var sec = document.getElementById('commentsSection_' + pid);
                                    if (sec) { sec.style.display = 'block'; loadCommentsFromDB(pid); }
                                    setTimeout(function () { card.classList.remove('notification-target'); }, 6000);
                                }
                            }
                        })();
                    });
                }).catch(() => {
                    container.innerHTML = '<div style="padding:40px;text-align:center;">Could not load announcements.</div>';
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
        updateNotifBadge();

        // ── Highlight post from notification link (?postId=X) ──────────────
        // (handled inside renderAnnouncements after DOM is written)

        // Refresh badge every 30 seconds
        setInterval(updateNotifBadge, 30000);
    </script>
    <!-- Image Lightbox -->
    <div id="imageLightbox" onclick="if(event.target===this)closeLightbox()" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.88);z-index:9998;align-items:center;justify-content:center;padding:20px;">
        <button onclick="closeLightbox()" style="position:absolute;top:18px;right:22px;background:rgba(255,255,255,0.15);border:none;color:#fff;font-size:28px;width:44px;height:44px;border-radius:50%;cursor:pointer;display:flex;align-items:center;justify-content:center;line-height:1;">&times;</button>
        <img id="lightboxImg" src="" style="max-width:92vw;max-height:88vh;border-radius:12px;object-fit:contain;box-shadow:0 8px 40px rgba(0,0,0,0.6);" />
    </div>
</body>
</html>