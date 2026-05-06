<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Teacher.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Teacher" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Campus Connect - Teacher Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="dark-mode.css" />
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
            --danger: #dc2626;
            --danger-hover: #b91c1c;
            --success: #10b981;
            --success-hover: #059669;
        }

        html, body, form { height: auto; min-height: 100%; }
        html, body { overflow: auto; }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: 120px;
            z-index: 1199;
            pointer-events: none;
            background-image: var(--bg-image);
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

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
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            gap: 16px;
            padding: 120px 20px 32px 16px;
            padding-left: 286px;
            overflow-y: visible;
        }

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

        .logo { font-size: 22px; font-weight: 800; color: var(--primary); white-space: nowrap; cursor: pointer; }
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

        .slideout-panel {
            position: fixed;
            top: 120px;
            left: 10px;
            width: 260px;
            height: calc(100vh - 130px);
            background: var(--surface-strong);
            backdrop-filter: blur(16px);
            box-shadow: 4px 0 24px rgba(0, 0, 0, 0.08);
            z-index: 1100;
            display: flex;
            flex-direction: column;
            border-radius: 16px;
            overflow: hidden;
            border-right: 1px solid var(--border);
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

        .avatar, .post-avatar, .create-post-avatar {
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
        .user-role, .post-meta, .comment-time { color: var(--muted); }

        .content-shell {
            flex: 1;
            display: grid;
            grid-template-columns: 1fr;
            gap: 25px;
            align-items: stretch;
            margin-bottom: 20px;
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

        .announcement-board {
            flex: 1 1 auto;
            overflow-y: auto;
            scrollbar-width: none;
            -ms-overflow-style: none;
            padding: 18px;
            background: rgba(248, 250, 252, 0.35);
        }

        main.main-panel {
            display: flex;
            flex-direction: column;
            gap: 0;
            height: calc(100vh - 140px);
            position: sticky;
            top: 120px;
        }

        main.main-panel > .card {
            flex: 1 1 0;
            min-height: 0;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        main.main-panel .card-header {
            padding: 18px 22px;
            border-bottom: 1px solid var(--border);
            flex-shrink: 0;
            font-weight: 700;
            font-size: 16px;
            color: var(--primary);
            border-radius: 24px 24px 0 0;
        }

        .focus-banner {
            background: linear-gradient(135deg, rgba(42,172,191,0.10), rgba(26,154,170,0.08));
            border: 1px solid var(--border);
            border-radius: 18px;
            padding: 14px 18px;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            flex-wrap: wrap;
        }

        .focus-back-btn {
            border: none;
            background: linear-gradient(135deg, #2AACBF, #1a9aaa);
            color: #fff;
            border-radius: 999px;
            padding: 10px 16px;
            cursor: pointer;
            font-weight: 700;
        }

        .announcement-card {
            background: var(--surface-strong);
            border-radius: 20px;
            margin-bottom: 20px;
            border: 1px solid var(--border);
            transition: all 0.3s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.03);
            overflow: hidden;
            scroll-margin-top: 100px;
        }

        .announcement-card:hover {
            box-shadow: 0 8px 18px rgba(0,0,0,0.08);
            border-color: var(--primary);
        }

        .announcement-card.notification-target {
            border-color: #f59e0b;
            box-shadow: 0 0 0 3px rgba(245, 158, 11, 0.22), 0 12px 28px rgba(245, 158, 11, 0.18);
            animation: targetPulse 2s ease-in-out 2;
        }

        @keyframes targetPulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.01); }
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
        .edit-btn-top:hover { color: #2AACBF; }
        .delete-btn-top:hover { color: #ef4444; }

        .post-content { padding: 0 22px 16px; }
        .post-title { font-size: 18px; font-weight: 700; margin-bottom: 10px; color: var(--primary); }
        .post-text { color: var(--page-text); line-height: 1.5; }
        .post-image { margin-top: 12px; border-radius: 16px; overflow: hidden; max-width: 100%; }
        .post-image img { width: 100%; max-height: 200px; object-fit: cover; border-radius: 16px; }

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
            background: linear-gradient(135deg, #2AACBF, #1a9aaa);
            border: none;
            border-radius: 30px;
            cursor: pointer;
            font-weight: 600;
            color: white;
        }

        .comment {
            display: flex;
            gap: 10px;
            padding: 10px 0;
            border-bottom: 1px solid var(--border);
            font-size: 13px;
        }

        .comment:last-child { border-bottom: none; }

        .comment-avatar {
            width: 32px;
            height: 32px;
            min-width: 32px;
            border-radius: 50%;
            overflow: hidden;
            background: var(--active-bg);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            color: var(--primary);
            flex-shrink: 0;
        }

        .comment-author { font-weight: 700; color: var(--primary); }
        .comment-time { font-size: 11px; color: var(--muted-light); margin-top: 2px; }
        .no-comments { padding: 12px; text-align: center; color: var(--muted-light); font-size: 12px; }

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

        body.dark-mode .announcement-board { background: transparent; }

        .announcement-board::-webkit-scrollbar { display: none; }

        body:not(.dark-mode) .announcement-card {
            border-color: #2AACBF;
        }

        body.dark-mode .announcement-card {
            background: #22314a;
            border-color: rgba(86, 136, 224, 0.45);
        }

        body.dark-mode .announcement-card.notification-target {
            border-color: #fbbf24;
            box-shadow: 0 0 0 3px rgba(251, 191, 36, 0.25), 0 12px 28px rgba(251, 191, 36, 0.18);
        }

        body.dark-mode .card {
            background: rgba(15,25,55,0.80);
            border-color: rgba(255,255,255,0.08);
        }

        body.dark-mode .header {
            background: rgba(15,25,55,0.85);
            border-color: rgba(255,255,255,0.08);
        }

        body.dark-mode .create-post-card {
            background: rgba(15,25,55,0.80);
            border-color: rgba(255,255,255,0.08);
        }

        body.dark-mode .create-post-input {
            background: rgba(255,255,255,0.07);
            color: #94a3b8;
            border-color: rgba(255,255,255,0.08);
        }

        body.dark-mode .post-author,
        body.dark-mode .post-title { color: #c7d2fe; }

        body.dark-mode .post-text { color: #cbd5e1; }

        body.dark-mode .post-meta,
        body.dark-mode .post-stats,
        body.dark-mode .post-stats span,
        body.dark-mode .action-btn,
        body.dark-mode .comment-time,
        body.dark-mode .no-comments { color: #94a3b8; }

        body.dark-mode .comment-author { color: #a5b4fc; }
        body.dark-mode .card-header { color: #c7d2fe; border-bottom-color: rgba(255,255,255,0.08); }
        body.dark-mode .logo { color: #c7d2fe; }
        body.dark-mode .user-name { color: #e2e8f0; }
        body.dark-mode .user-role { color: #94a3b8; }
        body.dark-mode .slideout-panel { background: rgba(10,15,40,0.97); border-color: rgba(255,255,255,0.08); }
        body.dark-mode .panel-header h3 { color: #c7d2fe; }
        body.dark-mode .panel-menu-item { color: #cbd5e1; }
        body.dark-mode .panel-menu-item i { color: #818cf8; }
        body.dark-mode .panel-menu-item:hover { background: rgba(99,102,241,0.15); color: #ffffff; border-left-color: #818cf8; }
        body.dark-mode .dropdown-item-panel { color: #cbd5e1; }
        body.dark-mode .dropdown-item-panel:hover { background: rgba(99,102,241,0.15); color: #ffffff; }
        body.dark-mode .divider-light { background: rgba(255,255,255,0.08); }

        body.dark-mode .comment-input input {
            background: rgba(255,255,255,0.07);
            border-color: rgba(255,255,255,0.1);
            color: #e2e8f0;
        }

        body.dark-mode .comment-input input::placeholder { color: #64748b; }

        body.dark-mode .form-group input,
        body.dark-mode .form-group textarea,
        body.dark-mode .form-group select {
            background: rgba(255,255,255,0.07);
            border-color: rgba(255,255,255,0.1);
            color: #e2e8f0;
        }

        body.dark-mode .post-category-exam { background: rgba(25,118,210,0.2); color: #90caf9; }
        body.dark-mode .post-category-suspension { background: rgba(198,40,40,0.2); color: #ef9a9a; }
        body.dark-mode .post-category-event { background: rgba(46,125,50,0.2); color: #a5d6a7; }
        body.dark-mode .post-category-general { background: rgba(99,102,241,0.2); color: #c7d2fe; }
        body.dark-mode .pin-btn-top.pinned { color: #fb923c; }
        body.dark-mode .search-btn { border-color: rgba(255,255,255,0.2); color: #e2e8f0; }
        body.dark-mode .edit-btn-top:hover { background: rgba(59,130,246,0.15); color: #93c5fd; }
        body.dark-mode .delete-btn-top:hover { background: rgba(239,68,68,0.15); color: #fca5a5; }
        body.dark-mode .modal-content { background: rgba(10,15,40,0.97); border: 1px solid rgba(255,255,255,0.1); }
        body.dark-mode .modal-header h2 { color: #c7d2fe; }
        body.dark-mode .form-group label { color: #a5b4fc; }
        body.dark-mode .modal-title { color: #e0e7ff; }
        body.dark-mode #pm-fullname { color: #e0e7ff; }
        body.dark-mode #pm-username,
        body.dark-mode #pm-email { color: #e2e8f0; }

        @media (max-width: 980px) {
            html, body { overflow: auto; }
            .app-shell { height: auto; min-height: 100%; overflow-y: auto; padding-left: 20px; padding-top: 120px; }
            .slideout-panel { display: none; }
            .dashboard-body { display: block; }
            .content-shell { overflow: visible; }
            .main-panel.card { height: auto; position: static; overflow: visible; }
            main.main-panel { height: auto; position: static; }
            main.main-panel > .card { overflow: visible; }
            .announcement-board { overflow: visible; }
        }

        .delete-modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.55);
            backdrop-filter: blur(6px);
            z-index: 9999;
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.2s ease, visibility 0.2s ease;
        }

        .delete-modal-overlay.active { opacity: 1; visibility: visible; }

        .delete-modal-card {
            background: var(--surface-strong);
            border: 1px solid var(--border);
            border-radius: 24px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.35);
            padding: 32px 28px 24px;
            max-width: 380px;
            width: 90%;
            text-align: center;
            transform: scale(0.94);
            transition: transform 0.2s ease;
        }

        .delete-modal-overlay.active .delete-modal-card { transform: scale(1); }

        .delete-modal-icon {
            width: 60px;
            height: 60px;
            background: rgba(220, 38, 38, 0.12);
            border: 1.5px solid rgba(220, 38, 38, 0.3);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
            font-size: 24px;
            color: #dc2626;
        }

        .delete-modal-title { font-size: 18px; font-weight: 800; color: var(--primary); margin-bottom: 8px; }
        .delete-modal-msg { font-size: 13px; color: var(--muted); margin-bottom: 24px; line-height: 1.5; }
        .delete-modal-btns { display: flex; gap: 10px; }

        .delete-modal-btns button {
            flex: 1;
            padding: 11px 0;
            border-radius: 40px;
            border: none;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s;
            font-family: inherit;
        }

        .btn-dm-cancel { background: var(--surface-soft); border: 1px solid var(--border) !important; color: var(--muted); }
        .btn-dm-cancel:hover { background: var(--active-bg); color: var(--primary); }
        .btn-dm-delete { background: linear-gradient(135deg, #dc2626, #b91c1c); color: #ffffff; }
        .btn-dm-delete:hover { transform: translateY(-1px); box-shadow: 0 6px 16px rgba(220,38,38,0.35); }

        body.dark-mode .delete-modal-card { background: rgba(30,41,59,0.98); border-color: rgba(148,163,184,0.2); }
        body.dark-mode .delete-modal-title { color: #e0e7ff; }
        body.dark-mode .btn-dm-cancel { background: rgba(51,65,85,0.6); color: #cbd5e1; border-color: rgba(148,163,184,0.3) !important; }
        body.dark-mode .btn-dm-cancel:hover { background: rgba(59,130,246,0.15); color: #93c5fd; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            <div class="logo" onclick="navigateWithFlip('Teacher.aspx')">
                <i class="fas fa-chalkboard-teacher"></i> Campus Announcement
            </div>
            <div class="search-container">
                <asp:Button ID="searchButton" runat="server" CssClass="search-btn"
                    Text="Search Announcements..." OnClick="SearchButton_Click"
                    UseSubmitBehavior="false" />
            </div>
            <div class="header-actions">
                <div class="notification-bell" onclick="openNotificationDropdown()">
                    <i class="fas fa-bell bell-icon"></i>
                    <span id="notificationBadge" class="badge-red" style="display:none;">0</span>
                </div>
                <div class="user-info" onclick="window.location.href='Profile.aspx'">
                    <div class="avatar" id="headerAvatar" style="overflow:hidden;">
                        <% if (Session["ProfileImage"] != null && !string.IsNullOrEmpty(Session["ProfileImage"].ToString())) { %>
                            <img src="<%= Session["ProfileImage"].ToString() %>" alt="Profile"
                                 style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;" />
                        <% } else { %>
                            <i class="fas fa-user"></i>
                        <% } %>
                    </div>
                    <div class="user-details">
                        <div class="user-name"><%= Session["Username"] ?? "User" %></div>
                        <div class="user-role"><%= Session["Role"] ?? "Teacher" %></div>
                    </div>
                </div>
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
                            <button type="button" class="dropdown-item-panel" data-filter="All" onclick="filterCategory('All'); event.stopPropagation();"><i class="fas fa-th-list"></i> All Announcements</button>
                            <button type="button" class="dropdown-item-panel" data-filter="Exam" onclick="filterCategory('Exam'); event.stopPropagation();"><i class="fas fa-file-alt"></i> Exam Schedule</button>
                            <button type="button" class="dropdown-item-panel" data-filter="Suspension" onclick="filterCategory('Suspension'); event.stopPropagation();"><i class="fas fa-cloud-rain"></i> Class Suspension</button>
                            <button type="button" class="dropdown-item-panel" data-filter="Event" onclick="filterCategory('Event'); event.stopPropagation();"><i class="fas fa-calendar-alt"></i> Campus Events</button>
                            <button type="button" class="dropdown-item-panel" data-filter="General" onclick="filterCategory('General'); event.stopPropagation();"><i class="fas fa-bullhorn"></i> General</button>
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
                        <div class="divider-light"></div>
                        <button type="button" class="panel-menu-item" onclick="navigateWithFlip('Backup.aspx');">
                            <i class="fas fa-database"></i> Database Backup
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
                        <div class="card">
                            <div class="card-header" style="padding:18px 22px; border-bottom:1px solid var(--border); flex-shrink:0; border-radius:24px 24px 0 0;">
                                <i class="fas fa-bullhorn"></i> Announcement Board
                                <span id="boardModeLabel" style="float: right; font-size: 12px;">Showing: <span id="activeFilterLabel">All</span></span>
                            </div>
                            <div id="announcementsContainer" class="announcement-board"></div>
                        </div>
                    </main>
                </div>
            </div>
        </div>

        <div id="createPostModal" class="modal">
            <div class="modal-content" style="max-width:520px;width:100%;">
                <div class="modal-header" style="padding:20px 24px 16px;border-bottom:1px solid var(--border);display:flex;justify-content:space-between;align-items:center;">
                    <h2 class="modal-title"><i class="fas fa-plus-circle" style="margin-right:8px;"></i>New Announcement</h2>
                    <button type="button" class="modal-close-btn" onclick="closeCreatePostModal()" style="background:none;border:none;font-size:24px;cursor:pointer;color:var(--muted);line-height:1;">&times;</button>
                </div>
                <div class="modal-body" style="padding:20px 24px;">
                    <div class="form-group" style="margin-bottom:16px;">
                        <label style="display:block;font-weight:600;margin-bottom:6px;font-size:13px;">Title</label>
                        <input type="text" id="announcementTitle" placeholder="Announcement title..." style="width:100%;padding:10px 14px;border:1px solid var(--border);border-radius:12px;background:var(--surface-soft);font-size:14px;outline:none;" />
                    </div>
                    <div class="form-group" style="margin-bottom:16px;">
                        <label style="display:block;font-weight:600;margin-bottom:6px;font-size:13px;">Category</label>
                        <select id="announcementCategory" style="width:100%;padding:10px 14px;border:1px solid var(--border);border-radius:12px;background:var(--surface-soft);font-size:14px;outline:none;">
                            <option>General</option>
                            <option>Exam</option>
                            <option>Suspension</option>
                            <option>Event</option>
                        </select>
                    </div>
                    <div class="form-group" style="margin-bottom:16px;">
                        <label style="display:block;font-weight:600;margin-bottom:6px;font-size:13px;">Content</label>
                        <textarea id="announcementContent" rows="4" placeholder="Write your announcement here..." style="width:100%;padding:10px 14px;border:1px solid var(--border);border-radius:12px;background:var(--surface-soft);font-size:14px;outline:none;resize:vertical;"></textarea>
                    </div>
                    <div class="form-group" style="margin-bottom:8px;">
                        <label style="display:block;font-weight:600;margin-bottom:6px;font-size:13px;">Attach Photos <span style="font-weight:400;color:var(--muted);">(optional, multiple)</span></label>
                        <label style="display:flex;align-items:center;gap:10px;padding:10px 14px;border:1.5px dashed var(--border);border-radius:12px;cursor:pointer;background:var(--surface-soft);transition:border-color 0.2s;" onmouseover="this.style.borderColor='var(--primary)'" onmouseout="this.style.borderColor='var(--border)'">
                            <i class="fas fa-image" style="color:var(--primary);font-size:18px;"></i>
                            <span style="font-size:13px;color:var(--muted);">Click to choose images</span>
                            <input type="file" id="announcementImageFile" accept="image/*" multiple onchange="previewImageFiles()" style="display:none;" />
                        </label>
                        <div id="imagePreviewContainer" style="margin-top:10px;flex-wrap:wrap;gap:8px;display:none;"></div>
                    </div>
                    <div class="form-group" style="margin-bottom:8px;">
                        <label style="display:block;font-weight:600;margin-bottom:6px;font-size:13px;">Attach Video <span style="font-weight:400;color:var(--muted);">(optional)</span></label>
                        <label style="display:flex;align-items:center;gap:10px;padding:10px 14px;border:1.5px dashed var(--border);border-radius:12px;cursor:pointer;background:var(--surface-soft);transition:border-color 0.2s;" onmouseover="this.style.borderColor='var(--primary)'" onmouseout="this.style.borderColor='var(--border)'">
                            <i class="fas fa-video" style="color:var(--primary);font-size:18px;"></i>
                            <span style="font-size:13px;color:var(--muted);">Click to choose a video</span>
                            <input type="file" id="announcementVideoFile" accept="video/*" onchange="previewVideoFile()" style="display:none;" />
                        </label>
                        <div id="videoPreviewContainer" style="display:none;margin-top:10px;border-radius:12px;overflow:hidden;border:1px solid var(--border);position:relative;">
                            <video id="previewVideo" controls style="width:100%;max-height:180px;display:block;border-radius:12px;"></video>
                            <button type="button" onclick="clearVideoPreview()" style="position:absolute;top:8px;right:8px;background:rgba(0,0,0,0.55);color:#fff;border:none;border-radius:50%;width:28px;height:28px;cursor:pointer;font-size:14px;display:flex;align-items:center;justify-content:center;">&times;</button>
                        </div>
                    </div>
                    <div class="form-group" style="margin-bottom:8px;">
                        <label style="display:block;font-weight:600;margin-bottom:6px;font-size:13px;">Attach File <span style="font-weight:400;color:var(--muted);">(PDF, DOCX, etc. — optional)</span></label>
                        <label style="display:flex;align-items:center;gap:10px;padding:10px 14px;border:1.5px dashed var(--border);border-radius:12px;cursor:pointer;background:var(--surface-soft);transition:border-color 0.2s;" onmouseover="this.style.borderColor='var(--primary)'" onmouseout="this.style.borderColor='var(--border)'">
                            <i class="fas fa-paperclip" style="color:var(--primary);font-size:18px;"></i>
                            <span style="font-size:13px;color:var(--muted);">Click to choose a file</span>
                            <input type="file" id="announcementAttachFile" accept=".pdf,.doc,.docx,.xls,.xlsx,.ppt,.pptx,.txt,.zip" onchange="previewAttachFile()" style="display:none;" />
                        </label>
                        <div id="attachPreviewContainer" style="display:none;margin-top:8px;padding:10px 14px;background:var(--surface-soft);border-radius:12px;border:1px solid var(--border);display:flex;align-items:center;gap:10px;">
                            <i class="fas fa-file" style="color:var(--primary);font-size:18px;"></i>
                            <span id="attachFileName" style="font-size:13px;flex:1;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;"></span>
                            <button type="button" onclick="clearAttachPreview()" style="background:none;border:none;cursor:pointer;color:var(--muted);font-size:16px;">&times;</button>
                        </div>
                    </div>
                </div>
                <div style="padding:14px 24px 20px;display:flex;gap:10px;justify-content:flex-end;border-top:1px solid var(--border);">
                    <button type="button" class="btn-cancel" onclick="closeCreatePostModal()" style="padding:10px 22px;border-radius:40px;border:1px solid var(--border);background:none;cursor:pointer;font-size:14px;">Cancel</button>
                    <button type="button" id="postBtn" class="btn-publish" onclick="publishAnnouncement()" style="padding:10px 28px;border-radius:40px;border:none;background:var(--success);color:#fff;cursor:pointer;font-size:14px;font-weight:600;"><i class="fas fa-paper-plane" style="margin-right:6px;"></i>Post</button>
                </div>
            </div>
        </div>

        <div id="profileModal" class="modal" style="display:none;">
            <div class="modal-content" style="max-width:420px;text-align:left;">
                <div style="text-align:center;margin-bottom:20px;">
                    <div style="width:72px;height:72px;border-radius:50%;background:linear-gradient(135deg,#2AACBF,#1a9aaa);color:#fff;display:flex;align-items:center;justify-content:center;font-size:28px;margin:0 auto 12px;">
                        <i class="fas fa-user"></i>
                    </div>
                    <div class="modal-title" style="margin-bottom:4px;" id="pm-fullname"><%= Session["FullName"] ?? "User" %></div>
                    <span style="display:inline-block;padding:3px 14px;border-radius:20px;font-size:11px;font-weight:700;background:#e0f7fa;color:#2AACBF;" id="pm-role"><%= Session["Role"] ?? "Admin" %></span>
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

        <div id="aboutModal" class="modal">
            <div class="modal-content" style="max-width:400px;">
                <div class="modal-header">
                    <h2>About Campus Connect</h2>
                    <button class="modal-close-btn" onclick="closeAboutModal()">&times;</button>
                </div>
                <div class="modal-body" style="text-align:center;">
                    <p>Campus Connect - CTU Announcement System. Teacher Edition.</p>
                    <button class="btn-publish" style="margin-top:16px;" onclick="closeAboutModal()">Got it</button>
                </div>
            </div>
        </div>
    </form>

    <div id="imageLightbox" onclick="if(event.target===this)closeLightbox()" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.88);z-index:9998;align-items:center;justify-content:center;padding:20px;">
        <button onclick="closeLightbox()" style="position:absolute;top:18px;right:22px;background:rgba(255,255,255,0.15);border:none;color:#fff;font-size:28px;width:44px;height:44px;border-radius:50%;cursor:pointer;display:flex;align-items:center;justify-content:center;line-height:1;">&times;</button>
        <img id="lightboxImg" src="" style="max-width:92vw;max-height:88vh;border-radius:12px;object-fit:contain;box-shadow:0 8px 40px rgba(0,0,0,0.6);" />
    </div>

    <div id="deleteConfirmModal" class="delete-modal-overlay">
        <div class="delete-modal-card">
            <div class="delete-modal-icon"><i class="fas fa-trash-alt"></i></div>
            <div class="delete-modal-title">Delete Announcement?</div>
            <div class="delete-modal-msg">This action cannot be undone. The announcement and all its comments will be permanently removed.</div>
            <div class="delete-modal-btns">
                <button type="button" class="btn-dm-cancel" id="deleteCancelBtn">Cancel</button>
                <button type="button" class="btn-dm-delete" id="deleteConfirmBtn"><i class="fas fa-trash-alt" style="margin-right:6px;"></i>Delete</button>
            </div>
        </div>
    </div>

    <script>
        let st_announcements = [], st_likes = {}, st_likeCounts = {}, st_pins = {}, st_comments = {};
        let focusPostId = 0;

        (function () {
            let params = new URLSearchParams(window.location.search);
            let pid = parseInt(params.get('postId') || '0', 10);
            if (!isNaN(pid) && pid > 0) focusPostId = pid;
        })();

        function saveSharedState() {
            localStorage.setItem('teacher_data', JSON.stringify({
                likes: st_likes,
                likeCounts: st_likeCounts,
                pins: st_pins,
                comments: st_comments
            }));
        }

        function loadSharedState() {
            try {
                var data = JSON.parse(localStorage.getItem('teacher_data') || '{}');
                st_likes = data.likes || {};
                st_likeCounts = data.likeCounts || {};
                st_pins = data.pins || {};
                st_comments = data.comments || {};
            } catch (e) {
                st_likes = {};
                st_likeCounts = {};
                st_pins = {};
                st_comments = {};
            }
        }

        loadSharedState();

        function loadAnnouncementsFromDB() {
            fetch('AnnouncementHandler.ashx?action=getAll', { credentials: 'same-origin' })
                .then(r => r.json())
                .then(res => {
                    if (res.ok) {
                        st_announcements = res.data.map(a => ({ ...a, pinned: a.isPinned }));
                        st_pins = {};
                        st_announcements.forEach(a => { if (a.isPinned) st_pins[a.id] = true; });
                        renderAnnouncements();
                    }
                });
        }

        function avatarHtml(imgSrc, size, isTeacher) {
            var icon = isTeacher ? 'fa-user-tie' : 'fa-user';
            if (imgSrc) {
                return `<div class="post-avatar" style="overflow:hidden;"><img src="${imgSrc}" style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;" /></div>`;
            }
            return `<div class="post-avatar"><i class="fas ${icon}"></i></div>`;
        }

        function commentAvatarHtml(imgSrc) {
            if (imgSrc) {
                return `<div class="comment-avatar" style="overflow:hidden;width:32px;height:32px;min-width:32px;"><img src="${imgSrc}" style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;" /></div>`;
            }
            return `<div class="comment-avatar"><i class="fas fa-user"></i></div>`;
        }

        function buildRepliesMap(comments) {
            const map = {};
            comments.forEach(c => {
                const key = c.parentCommentId == null ? 'root' : String(c.parentCommentId);
                if (!map[key]) map[key] = [];
                map[key].push(c);
            });
            return map;
        }

        function renderCommentNode(comment, repliesMap, postId, depth) {
            const children = repliesMap[String(comment.commentId)] || [];
            const indent = Math.min(depth * 28, 140);
            const childHtml = children.map(child => renderCommentNode(child, repliesMap, postId, depth + 1)).join('');

            return `
                <div class="comment" data-comment-id="${comment.commentId}" style="${depth > 0 ? `margin-left:${indent}px;` : ''}">
                    ${commentAvatarHtml(comment.profileImage)}
                    <div style="flex:1;min-width:0;">
                        <span class="comment-author">${escapeHtml(comment.author)}</span>
                        <div>${escapeHtml(comment.text)}</div>
                        <div style="display:flex;align-items:center;gap:12px;margin-top:4px;flex-wrap:wrap;">
                            <small>${comment.date || ''}</small>
                            <button type="button" class="comment-like-btn ${comment.userLiked ? 'liked' : ''}" onclick="likeComment(${comment.commentId},this)"
                                style="background:none;border:none;cursor:pointer;font-size:12px;color:${comment.userLiked ? '#dc2626' : 'var(--muted)'};display:flex;align-items:center;gap:4px;padding:0;">
                                <i class="${comment.userLiked ? 'fas' : 'far'} fa-heart"></i>
                                <span class="clc">${comment.likeCount > 0 ? comment.likeCount : ''}</span>
                            </button>
                            <button type="button" onclick="toggleReplyBox(${comment.commentId},${postId})"
                                style="background:none;border:none;cursor:pointer;font-size:12px;color:var(--muted);padding:0;">
                                <i class="fas fa-reply"></i> Reply
                            </button>
                        </div>
                        <div id="replyBox_${comment.commentId}" style="display:none;margin-top:8px;">
                            <div class="comment-input" style="margin:0;">
                                <input type="text" id="replyInput_${comment.commentId}" placeholder="Write a reply..." style="font-size:12px;" />
                                <button type="button" onclick="submitReply(${comment.commentId},${postId})" style="padding:8px 16px;font-size:12px;">Reply</button>
                            </div>
                        </div>
                        ${childHtml}
                    </div>
                </div>
            `;
        }

        function renderAnnouncements() {
            let container = document.getElementById('announcementsContainer');
            if (!container) return;

            let filter = localStorage.getItem('teacher_filter') || 'All';
            let activeFilterLabel = document.getElementById('activeFilterLabel');
            if (activeFilterLabel) activeFilterLabel.innerText = filter;

            let filtered = st_announcements.filter(a => filter === 'All' || a.category === filter);

            if (focusPostId > 0) {
                filtered = filtered.filter(a => a.id === focusPostId);
                let boardModeLabel = document.getElementById('boardModeLabel');
                if (boardModeLabel) boardModeLabel.innerHTML = 'Mode: <strong>Notification Post View</strong>';
            } else {
                let boardModeLabel = document.getElementById('boardModeLabel');
                if (boardModeLabel) boardModeLabel.innerHTML = 'Showing: <span id="activeFilterLabel">' + filter + '</span>';
            }

            filtered.sort((a, b) =>
                (st_pins[a.id] && !st_pins[b.id]) ? -1 :
                (!st_pins[a.id] && st_pins[b.id]) ? 1 :
                b.id - a.id
            );

            if (focusPostId > 0) {
                let exists = filtered.length > 0;
                container.innerHTML =
                    `<div class="focus-banner">
                        <button type="button" class="focus-back-btn" onclick="window.location.href='Teacher.aspx'">Back to All Posts</button>
                    </div>` +
                    (exists ? '' : `<div class="no-comments" style="padding:30px;">That announcement could not be found.</div>`);
            } else {
                container.innerHTML = '';
            }

            container.innerHTML += filtered.map(post => {
                let pinned = st_pins[post.id];
                let liked = !!post.userLiked;
                let likeCount = st_likeCounts[post.id] || post.likeCount || 0;
                let catClass = post.category === 'Exam' ? 'post-category-exam' :
                    post.category === 'Suspension' ? 'post-category-suspension' :
                    post.category === 'Event' ? 'post-category-event' : 'post-category-general';
                let commentsCount = (st_comments[post.id] || []).length || post.commentCount || 0;
                let avatar = avatarHtml(post.authorImage, 50, true);
                let targetClass = (focusPostId > 0 && focusPostId === post.id) ? ' notification-target' : '';

                return `<div class="announcement-card${targetClass}" data-id="${post.id}" id="post_${post.id}">
                    <div class="post-header">
                        <div class="post-header-left">
                            ${avatar}
                            <div>
                                <div class="post-author">${escapeHtml(post.author)}</div>
                                <div class="post-meta">
                                    <span>${timeAgo(post.date)}</span>
                                    <span class="post-category ${catClass}">${post.category}</span>
                                </div>
                            </div>
                        </div>
                        <div>
                            <button type="button" class="edit-btn-top" onclick="openEditModal(${post.id})"><i class="fas fa-edit"></i></button>
                            <button type="button" class="delete-btn-top" onclick="deletePost(${post.id})"><i class="fas fa-trash"></i></button>
                            <button type="button" class="pin-btn-top ${pinned ? 'pinned' : ''}" onclick="togglePin(${post.id})"><i class="fas fa-thumbtack"></i></button>
                        </div>
                    </div>
                    <div class="post-content">
                        <div class="post-title">${escapeHtml(post.title)}</div>
                        <div class="post-text">${escapeHtml(post.content)}</div>
                        ${renderMediaHtml(post.imageUrl)}
                    </div>
                    <div class="post-stats">
                        <span onclick="toggleLike(${post.id})"><i class="${liked ? 'fas' : 'far'} fa-heart" style="${liked ? 'color:#dc2626' : ''}"></i> <span class="like-count">${likeCount}</span> Likes</span>
                        <span onclick="toggleCommentSection(${post.id})"><i class="far fa-comment"></i> <span class="comment-count">${commentsCount}</span> Comments</span>
                        <span onclick="sharePost(${post.id})"><i class="far fa-share-square"></i> Share</span>
                    </div>
                    <div class="action-buttons">
                        <button type="button" class="action-btn ${liked ? 'liked' : ''}" onclick="toggleLike(${post.id})"><i class="${liked ? 'fas' : 'far'} fa-heart"></i> ${liked ? 'Liked' : 'Like'}</button>
                        <button type="button" class="action-btn" onclick="toggleCommentSection(${post.id})">Comment</button>
                        <button type="button" class="action-btn" onclick="sharePost(${post.id})">Share</button>
                    </div>
                    <div class="comments-section" id="commentsSection_${post.id}" style="${focusPostId === post.id ? 'display:block;' : 'display:none;'}">
                        <div class="comment-input">
                            <input id="commentInput_${post.id}" placeholder="Write a comment..."/>
                            <button type="button" onclick="addComment(${post.id})">Post</button>
                        </div>
                        <div id="commentsList_${post.id}">${renderCommentsList(post.id)}</div>
                    </div>
                </div>`;
            }).join('');

            if (focusPostId > 0) {
                loadComments(focusPostId);
            }
        }

        function renderCommentsList(postId) {
            let comments = st_comments[postId] || [];
            if (!comments.length) return '<div class="no-comments">No comments yet.</div>';

            const repliesMap = buildRepliesMap(comments);
            const rootComments = repliesMap.root || [];

            return rootComments.map(comment => renderCommentNode(comment, repliesMap, postId, 0)).join('');
        }

        var videoExts = ['mp4','webm','ogg','mov','avi'];
        var imageExts = ['jpg','jpeg','png','gif','webp','bmp'];

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
            var files = urls.filter(function(u) { return imageExts.indexOf(getExt(u)) === -1 && videoExts.indexOf(getExt(u)) === -1; });

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
                    <a href="${f}" download="${fname}" style="padding:6px 14px;background:#2AACBF;color:#fff;border-radius:20px;font-size:12px;font-weight:600;text-decoration:none;white-space:nowrap;"><i class="fas fa-download" style="margin-right:4px;"></i>Download</a>
                </div>`;
            });

            return html;
        }

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

        function escapeHtml(str) {
            if (!str) return '';
            return str.replace(/[&<>]/g, m => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;' })[m]);
        }

        function timeAgo(dateStr) {
            if (!dateStr) return '';
            var date = new Date(dateStr);
            if (isNaN(date)) return dateStr;
            var now = new Date();
            var sec = Math.floor((now - date) / 1000);
            if (sec < 60) return 'Just now';
            var min = Math.floor(sec / 60);
            if (min < 60) return min + (min === 1 ? ' min ago' : ' mins ago');
            var hr = Math.floor(min / 60);
            if (hr < 24) return hr + (hr === 1 ? ' hour ago' : ' hours ago');
            var day = Math.floor(hr / 24);
            if (day < 7) return day + (day === 1 ? ' day ago' : ' days ago');
            var wk = Math.floor(day / 7);
            if (wk < 5) return wk + (wk === 1 ? ' week ago' : ' weeks ago');
            var mo = Math.floor(day / 30);
            if (mo < 12) return mo + (mo === 1 ? ' month ago' : ' months ago');
            var yr = Math.floor(day / 365);
            return yr + (yr === 1 ? ' year ago' : ' years ago');
        }

        function showToast(msg) {
            let t = document.createElement('div');
            t.innerText = msg;
            t.style.cssText = 'position:fixed;bottom:30px;left:50%;transform:translateX(-50%);background:#2AACBF;color:#fff;padding:8px 20px;border-radius:30px;z-index:9999';
            document.body.appendChild(t);
            setTimeout(() => t.remove(), 2500);
        }

        function toggleLike(id) {
            fetch(`LikeHandler.ashx?action=toggle&postId=${id}`, { credentials: 'same-origin' })
                .then(r => r.json())
                .then(res => {
                    if (!res.ok) { showToast('Error'); return; }
                    let post = st_announcements.find(p => p.id === id);
                    if (post) post.userLiked = res.liked;
                    st_likeCounts[id] = res.likeCount;
                    saveSharedState();
                    renderAnnouncements();
                    showToast(res.liked ? 'Liked!' : 'Like removed');
                });
        }

        function togglePin(id) {
            fetch('AnnouncementHandler.ashx?action=togglePin&id=' + id, { credentials: 'same-origin' })
                .then(r => r.json())
                .then(res => {
                    if (!res.ok) { showToast('Error: ' + (res.error || 'Could not pin')); return; }
                    if (res.isPinned) st_pins[id] = true; else delete st_pins[id];
                    saveSharedState();
                    renderAnnouncements();
                    showToast(res.isPinned ? 'Pinned!' : 'Unpinned');
                })
                .catch(() => showToast('Could not update pin'));
        }

        function addComment(postId) {
            let input = document.getElementById(`commentInput_${postId}`);
            let text = input.value.trim();
            if (!text) return;
            fetch('CommentHandler.ashx?action=add', {
                method: 'POST',
                credentials: 'same-origin',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ postId, comment: text })
            }).then(() => {
                input.value = '';
                loadComments(postId);
            });
        }

        function loadComments(postId) {
            fetch(`CommentHandler.ashx?action=get&postId=${postId}`, { credentials: 'same-origin' })
                .then(r => r.json())
                .then(data => {
                    if (!Array.isArray(data)) return;
                    const list = data;
                    st_comments[postId] = list;
                    let listDiv = document.getElementById(`commentsList_${postId}`);
                    if (listDiv) listDiv.innerHTML = renderCommentsList(postId);
                    let countSpan = document.querySelector(`.announcement-card[data-id="${postId}"] .comment-count`);
                    if (countSpan) countSpan.textContent = list.length;
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
            box.style.display = box.style.display === 'none' ? 'block' : 'none';
            if (box.style.display === 'block') document.getElementById('replyInput_' + commentId)?.focus();
        }

        function submitReply(commentId, postId) {
            let input = document.getElementById('replyInput_' + commentId);
            let text = input ? input.value.trim() : '';
            if (!text) return showToast('Write a reply first');
            fetch('CommentHandler.ashx?action=reply', {
                method: 'POST',
                credentials: 'same-origin',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ postId: postId, parentCommentId: commentId, comment: text })
            }).then(r => r.json()).then(res => {
                if (res.success) {
                    input.value = '';
                    document.getElementById('replyBox_' + commentId).style.display = 'none';
                    loadComments(postId);
                    showToast('Reply posted');
                }
            });
        }

        function toggleCommentSection(id) {
            let sec = document.getElementById(`commentsSection_${id}`);
            if (sec) {
                let open = sec.style.display !== 'none' && sec.style.display !== '';
                sec.style.display = open ? 'none' : 'block';
                if (!open) loadComments(id);
            }
        }

        function sharePost(id) {
            navigator.clipboard?.writeText(window.location.href);
            showToast('Link copied!');
            fetch('NotificationHandler.ashx?action=notifyShare&postId=' + id, { credentials: 'same-origin' }).catch(() => { });
        }

        function filterCategory(cat) {
            localStorage.setItem('teacher_filter', cat);
            let activeFilterLabel = document.getElementById('activeFilterLabel');
            if (activeFilterLabel) activeFilterLabel.innerText = cat;
            renderAnnouncements();
            document.querySelectorAll('[data-filter]').forEach(btn => {
                btn.classList.toggle('active-filter', btn.getAttribute('data-filter') === cat);
            });
        }

        document.getElementById('filterCategoryBtn').addEventListener('click', function (e) {
            e.stopPropagation();
            let panel = document.getElementById('categoryDropdownPanel');
            panel.style.display = panel.style.display === 'flex' ? 'none' : 'flex';
        });

        function openCreatePostModal() {
            document.getElementById('createPostModal').style.display = 'flex';
            let btn = document.getElementById('postBtn');
            btn.innerHTML = '<i class="fas fa-paper-plane" style="margin-right:6px;"></i>Post';
            btn.onclick = publishAnnouncement;
        }

        let selectedImageFiles = [];
        let selectedVideoFile = null;
        let selectedAttachFile = null;
        let existingMediaUrls = [];

        function closeCreatePostModal() {
            document.getElementById('createPostModal').style.display = 'none';
            document.getElementById('announcementTitle').value = '';
            document.getElementById('announcementContent').value = '';
            document.getElementById('announcementImageFile').value = '';
            document.getElementById('announcementVideoFile').value = '';
            document.getElementById('announcementAttachFile').value = '';
            selectedImageFiles = [];
            selectedVideoFile = null;
            selectedAttachFile = null;
            existingMediaUrls = [];
            document.getElementById('imagePreviewContainer').style.display = 'none';
            document.getElementById('imagePreviewContainer').innerHTML = '';
            document.getElementById('videoPreviewContainer').style.display = 'none';
            document.getElementById('attachPreviewContainer').style.display = 'none';
        }

        function previewImageFiles() {
            let input = document.getElementById('announcementImageFile');
            let newFiles = Array.from(input.files);
            newFiles.forEach(function(f) {
                let isDupe = selectedImageFiles.some(function(e) { return e.name === f.name && e.size === f.size; });
                if (!isDupe) selectedImageFiles.push(f);
            });
            input.value = '';
            renderImagePreviews();
        }

        function renderImagePreviews() {
            let container = document.getElementById('imagePreviewContainer');
            container.innerHTML = '';
            if (!selectedImageFiles.length) { container.style.display = 'none'; return; }
            container.style.display = 'flex';
            selectedImageFiles.forEach(function(file, idx) {
                let reader = new FileReader();
                reader.onload = function(e) {
                    let wrap = document.createElement('div');
                    wrap.style.cssText = 'position:relative;border-radius:10px;overflow:hidden;border:1px solid var(--border);flex-shrink:0;';
                    wrap.innerHTML = `
                        <img src="${e.target.result}" style="width:100px;height:80px;object-fit:cover;display:block;" />
                        <button type="button" onclick="removeImageFile(${idx})"
                            style="position:absolute;top:4px;right:4px;width:22px;height:22px;border-radius:50%;
                                   background:rgba(0,0,0,0.6);color:#fff;border:none;cursor:pointer;
                                   font-size:13px;display:flex;align-items:center;justify-content:center;line-height:1;">
                            &times;
                        </button>`;
                    container.appendChild(wrap);
                };
                reader.readAsDataURL(file);
            });
        }

        function removeImageFile(idx) {
            selectedImageFiles.splice(idx, 1);
            renderImagePreviews();
        }

        function previewVideoFile() {
            let file = document.getElementById('announcementVideoFile').files[0];
            let container = document.getElementById('videoPreviewContainer');
            if (file) {
                selectedVideoFile = file;
                let url = URL.createObjectURL(file);
                document.getElementById('previewVideo').src = url;
                container.style.display = 'block';
                let clearBtn = container.querySelector('button');
                if (clearBtn) clearBtn.onclick = clearVideoPreview;
            } else {
                container.style.display = 'none';
            }
        }

        function clearVideoPreview() {
            selectedVideoFile = null;
            document.getElementById('announcementVideoFile').value = '';
            document.getElementById('previewVideo').src = '';
            document.getElementById('videoPreviewContainer').style.display = 'none';
        }

        function previewAttachFile() {
            let file = document.getElementById('announcementAttachFile').files[0];
            let container = document.getElementById('attachPreviewContainer');
            if (file) {
                selectedAttachFile = file;
                document.getElementById('attachFileName').textContent = file.name;
                container.style.display = 'flex';
                let clearBtn = container.querySelector('button');
                if (clearBtn) clearBtn.onclick = clearAttachPreview;
            } else {
                container.style.display = 'none';
            }
        }

        function clearAttachPreview() {
            selectedAttachFile = null;
            document.getElementById('announcementAttachFile').value = '';
            document.getElementById('attachPreviewContainer').style.display = 'none';
        }

        function clearImagePreview() {
            selectedImageFiles = [];
            document.getElementById('announcementImageFile').value = '';
            document.getElementById('imagePreviewContainer').style.display = 'none';
            document.getElementById('imagePreviewContainer').innerHTML = '';
        }

        function publishAnnouncement() {
            let title = document.getElementById('announcementTitle').value.trim();
            let content = document.getElementById('announcementContent').value.trim();
            let category = document.getElementById('announcementCategory').value;
            if (!title || !content) return showToast('Please fill in title and content');

            let btn = document.getElementById('postBtn');
            btn.disabled = true;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin" style="margin-right:6px;"></i>Posting...';

            let formData = new FormData();
            formData.append('title', title);
            formData.append('content', content);
            formData.append('category', category);

            for (let i = 0; i < selectedImageFiles.length; i++) {
                formData.append('imageFile', selectedImageFiles[i]);
            }

            let videoFile = selectedVideoFile || document.getElementById('announcementVideoFile').files[0];
            if (videoFile) formData.append('videoFile', videoFile);

            let attachFile = selectedAttachFile || document.getElementById('announcementAttachFile').files[0];
            if (attachFile) formData.append('attachFile', attachFile);

            fetch('AnnouncementHandler.ashx?action=create', {
                method: 'POST',
                credentials: 'same-origin',
                body: formData
            })
            .then(r => r.json())
            .then(res => {
                btn.disabled = false;
                btn.innerHTML = '<i class="fas fa-paper-plane" style="margin-right:6px;"></i>Post';
                if (res.ok) {
                    closeCreatePostModal();
                    loadAnnouncementsFromDB();
                    showToast('Posted!');
                } else {
                    showToast('Error: ' + (res.error || 'Could not post'));
                }
            })
            .catch(err => {
                btn.disabled = false;
                btn.innerHTML = '<i class="fas fa-paper-plane" style="margin-right:6px;"></i>Post';
                showToast('Network error. Please try again.');
                console.error('Publish error:', err);
            });
        }

        function openEditModal(id) {
            let post = st_announcements.find(p => p.id === id);
            if (!post) return;

            document.getElementById('announcementTitle').value = post.title;
            document.getElementById('announcementContent').value = post.content;
            document.getElementById('announcementCategory').value = post.category;

            selectedImageFiles = [];
            selectedVideoFile = null;
            selectedAttachFile = null;
            document.getElementById('announcementImageFile').value = '';
            document.getElementById('announcementVideoFile').value = '';
            document.getElementById('announcementAttachFile').value = '';
            document.getElementById('imagePreviewContainer').innerHTML = '';
            document.getElementById('imagePreviewContainer').style.display = 'none';
            document.getElementById('videoPreviewContainer').style.display = 'none';
            document.getElementById('attachPreviewContainer').style.display = 'none';

            existingMediaUrls = post.imageUrl
                ? post.imageUrl.split(',').map(u => u.trim()).filter(Boolean)
                : [];
            renderExistingMediaPreviews();

            openCreatePostModal();
            let btn = document.getElementById('postBtn');
            btn.innerHTML = '<i class="fas fa-save" style="margin-right:6px;"></i>Update';
            btn.onclick = () => updateAnnouncement(id);
        }

        function renderExistingMediaPreviews() {
            let imgContainer = document.getElementById('imagePreviewContainer');
            let existingImages = existingMediaUrls.filter(u => imageExts.indexOf(getExt(u)) !== -1);
            if (existingImages.length) {
                imgContainer.style.display = 'flex';
                existingImages.forEach(function(url) {
                    let wrap = document.createElement('div');
                    wrap.style.cssText = 'position:relative;border-radius:10px;overflow:hidden;border:2px solid #2AACBF;flex-shrink:0;';
                    wrap.dataset.url = url;
                    wrap.innerHTML = `
                        <img src="${url}" style="width:100px;height:80px;object-fit:cover;display:block;" />
                        <button type="button" onclick="removeExistingMedia('${url}')"
                            style="position:absolute;top:4px;right:4px;width:22px;height:22px;border-radius:50%;
                                   background:rgba(220,38,38,0.85);color:#fff;border:none;cursor:pointer;
                                   font-size:13px;display:flex;align-items:center;justify-content:center;line-height:1;">
                            &times;
                        </button>`;
                    imgContainer.appendChild(wrap);
                });
            }

            let existingVideo = existingMediaUrls.find(u => videoExts.indexOf(getExt(u)) !== -1);
            if (existingVideo) {
                let vc = document.getElementById('videoPreviewContainer');
                document.getElementById('previewVideo').src = existingVideo;
                vc.style.display = 'block';
                let clearBtn = vc.querySelector('button');
                if (clearBtn) clearBtn.onclick = function() { removeExistingMedia(existingVideo); };
            }

            let existingFile = existingMediaUrls.find(u => imageExts.indexOf(getExt(u)) === -1 && videoExts.indexOf(getExt(u)) === -1);
            if (existingFile) {
                let fname = existingFile.split('/').pop();
                document.getElementById('attachFileName').textContent = fname;
                let ac = document.getElementById('attachPreviewContainer');
                ac.style.display = 'flex';
                let clearBtn = ac.querySelector('button');
                if (clearBtn) clearBtn.onclick = function() { removeExistingMedia(existingFile); };
            }
        }

        function removeExistingMedia(url) {
            existingMediaUrls = existingMediaUrls.filter(u => u !== url);
            let ext = getExt(url);

            if (imageExts.indexOf(ext) !== -1) {
                let container = document.getElementById('imagePreviewContainer');
                let wrap = container.querySelector('[data-url="' + url + '"]');
                if (wrap) wrap.remove();
                if (!container.children.length) container.style.display = 'none';
            } else if (videoExts.indexOf(ext) !== -1) {
                document.getElementById('previewVideo').src = '';
                document.getElementById('videoPreviewContainer').style.display = 'none';
            } else {
                document.getElementById('attachPreviewContainer').style.display = 'none';
            }
        }

        function updateAnnouncement(id) {
            let title = document.getElementById('announcementTitle').value;
            let content = document.getElementById('announcementContent').value;
            let category = document.getElementById('announcementCategory').value;
            let formData = new FormData();
            formData.append('title', title);
            formData.append('content', content);
            formData.append('category', category);
            formData.append('keepUrls', existingMediaUrls.join(','));

            for (let i = 0; i < selectedImageFiles.length; i++) {
                formData.append('imageFile', selectedImageFiles[i]);
            }

            let videoFile = selectedVideoFile || document.getElementById('announcementVideoFile').files[0];
            if (videoFile) formData.append('videoFile', videoFile);

            let attachFile = selectedAttachFile || document.getElementById('announcementAttachFile').files[0];
            if (attachFile) formData.append('attachFile', attachFile);

            let btn = document.getElementById('postBtn');
            btn.disabled = true;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin" style="margin-right:6px;"></i>Updating...';

            fetch(`AnnouncementHandler.ashx?action=update&id=${id}`, {
                method: 'POST',
                body: formData,
                credentials: 'same-origin'
            })
            .then(r => r.json())
            .then(res => {
                btn.disabled = false;
                btn.innerHTML = '<i class="fas fa-save" style="margin-right:6px;"></i>Update';
                if (res.ok) {
                    closeCreatePostModal();
                    loadAnnouncementsFromDB();
                    showToast('Updated');
                } else {
                    showToast('Error: ' + (res.error || 'Could not update'));
                }
            })
            .catch(err => {
                btn.disabled = false;
                btn.innerHTML = '<i class="fas fa-save" style="margin-right:6px;"></i>Update';
                showToast('Network error. Please try again.');
                console.error('Update error:', err);
            });
        }

        function deletePost(id) {
            var modal = document.getElementById('deleteConfirmModal');
            if (!modal) return;
            modal.classList.add('active');

            document.getElementById('deleteConfirmBtn').onclick = function () {
                modal.classList.remove('active');
                fetch(`AnnouncementHandler.ashx?action=delete&id=${id}`, { credentials: 'same-origin' })
                    .then(() => {
                        if (focusPostId && focusPostId === id) {
                            window.location.href = 'Teacher.aspx';
                            return;
                        }
                        loadAnnouncementsFromDB();
                        showToast('Announcement deleted.');
                    });
            };
        }

        document.getElementById('deleteCancelBtn').addEventListener('click', function () {
            document.getElementById('deleteConfirmModal').classList.remove('active');
        });

        document.getElementById('deleteConfirmModal').addEventListener('click', function (e) {
            if (e.target === this) this.classList.remove('active');
        });

        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') {
                document.getElementById('deleteConfirmModal').classList.remove('active');
                closeLightbox();
            }
        });

        function openProfileModal() { document.getElementById('profileModal').style.display = 'flex'; }
        function closeProfileModal() { document.getElementById('profileModal').style.display = 'none'; }
        function openAboutModal() { document.getElementById('aboutModal').style.display = 'flex'; }
        function closeAboutModal() { document.getElementById('aboutModal').style.display = 'none'; }
        function logout() { window.location.href = 'Logout.aspx'; }
        function navigateWithFlip(url) { window.location.href = url; }

        function toggleTheme() {
            let isDark = !document.body.classList.contains('dark-mode');
            localStorage.setItem('campus_theme', isDark ? 'dark' : 'light');
            document.body.classList.toggle('dark-mode', isDark);
            document.querySelectorAll('.toggle-switch-panel').forEach(el => el.classList.toggle('active', isDark));
        }

        function openNotificationDropdown() { navigateWithFlip('Notifications.aspx'); }

        document.getElementById('settingsThemeBtn').addEventListener('click', (e) => {
            e.stopPropagation();
            toggleTheme();
        });

        let savedTheme = localStorage.getItem('campus_theme');
        if (savedTheme === 'dark') document.body.classList.add('dark-mode');

        let panelToggle = document.getElementById('panelThemeToggle');
        if (panelToggle) panelToggle.classList.toggle('active', savedTheme === 'dark');

        window.addEventListener('storage', function (e) {
            if (e.key === 'campus_theme') {
                let isDark = e.newValue === 'dark';
                document.body.classList.toggle('dark-mode', isDark);
                document.querySelectorAll('.toggle-switch-panel').forEach(el => el.classList.toggle('active', isDark));
            } else {
                loadAnnouncementsFromDB();
            }
        });

        loadAnnouncementsFromDB();
        updateNotifBadge();
        setInterval(updateNotifBadge, 30000);

        function updateNotifBadge() {
            fetch('NotificationHandler.ashx?action=getUnread', { credentials: 'same-origin' })
                .then(r => r.json())
                .then(res => {
                    let badge = document.getElementById('notificationBadge');
                    if (badge) {
                        if (res.ok && res.count > 0) {
                            badge.textContent = res.count;
                            badge.style.display = 'inline-block';
                        } else {
                            badge.style.display = 'none';
                        }
                    }
                })
                .catch(() => { });
        }
    </script>
</body>
</html>
