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

        html, body, form { height: auto; min-height: 100%; }
        html, body { overflow: auto; }

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
            gap: 10px;
            padding: 16px 20px 20px;
            padding-left: 286px;
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
            top: 0;
            left: 0;
            width: 270px;
            height: 100vh;
            background: var(--surface-strong);
            backdrop-filter: blur(16px);
            box-shadow: 4px 0 24px rgba(0, 0, 0, 0.08);
            z-index: 1100;
            display: flex;
            flex-direction: column;
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
            color: var(--primary);
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
            background: linear-gradient(135deg, var(--primary), var(--primary-2));
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
            min-height: 600px;
            display: flex;
            flex-direction: column;
        }

        .announcement-board {
            flex: 1 1 auto;
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
            background: linear-gradient(135deg, var(--primary), var(--primary-2));
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
            .content-shell { overflow: visible; }
            .announcement-board { overflow: visible; }
            html, body { overflow: auto; }
            .app-shell { padding-left: 20px; }
            .slideout-panel { display: none; }
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
        <div class="app-shell">
            <div class="header">
                <div class="logo" onclick="navigateWithFlip('Teacher.aspx')">
                    <i class="fas fa-chalkboard-teacher"></i> Campus Announcement
                </div>
                <div class="search-container">
                    <asp:Button ID="searchButton" runat="server" CssClass="search-btn"
                        Text="🔎 Search Announcements..." OnClick="SearchButton_Click"
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
                        <label style="display:block;font-weight:600;margin-bottom:6px;font-size:13px;">Attach Photo <span style="font-weight:400;color:var(--muted);">(optional)</span></label>
                        <label style="display:flex;align-items:center;gap:10px;padding:10px 14px;border:1.5px dashed var(--border);border-radius:12px;cursor:pointer;background:var(--surface-soft);transition:border-color 0.2s;" onmouseover="this.style.borderColor='var(--primary)'" onmouseout="this.style.borderColor='var(--border)'">
                            <i class="fas fa-image" style="color:var(--primary);font-size:18px;"></i>
                            <span style="font-size:13px;color:var(--muted);">Click to choose an image</span>
                            <input type="file" id="announcementImageFile" accept="image/*" onchange="previewImageFile()" style="display:none;" />
                        </label>
                        <div id="imagePreview" style="display:none;margin-top:10px;border-radius:12px;overflow:hidden;border:1px solid var(--border);position:relative;">
                            <img id="previewImg" src="" style="width:100%;max-height:200px;object-fit:cover;display:block;" />
                            <button type="button" onclick="clearImagePreview()" style="position:absolute;top:8px;right:8px;background:rgba(0,0,0,0.55);color:#fff;border:none;border-radius:50%;width:28px;height:28px;cursor:pointer;font-size:14px;display:flex;align-items:center;justify-content:center;">&times;</button>
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

        <div class="footer"><i class="fas fa-shield-alt"></i> Secure Portal | Cebu Technological University</div>
    </form>

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
                        highlightFocusedPost();
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

        function renderAnnouncements() {
            let container = document.getElementById('announcementsContainer');
            if (!container) return;

            let filter = localStorage.getItem('teacher_filter') || 'All';
            document.getElementById('activeFilterLabel').innerText = filter;

            let filtered = st_announcements.filter(a => filter === 'All' || a.category === filter);
            filtered.sort((a, b) =>
                (st_pins[a.id] && !st_pins[b.id]) ? -1 :
                (!st_pins[a.id] && st_pins[b.id]) ? 1 :
                b.id - a.id
            );

            container.innerHTML = filtered.map(post => {
                let pinned = st_pins[post.id];
                let liked = !!post.userLiked;
                let likeCount = st_likeCounts[post.id] || post.likeCount || 0;
                let catClass = post.category === 'Exam' ? 'post-category-exam' :
                    post.category === 'Suspension' ? 'post-category-suspension' :
                    post.category === 'Event' ? 'post-category-event' : 'post-category-general';
                let commentsCount = (st_comments[post.id] || []).filter(c => !c.parentCommentId).length || post.commentCount || 0;
                let avatar = avatarHtml(post.authorImage, 50, true);
                let targetClass = focusPostId === post.id ? ' notification-target' : '';

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
                        ${post.imageUrl ? `<div class="post-image"><img src="${post.imageUrl}" /></div>` : ''}
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
                    <div class="comments-section" id="commentsSection_${post.id}" style="display:none;">
                        <div class="comment-input">
                            <input id="commentInput_${post.id}" placeholder="Write a comment..."/>
                            <button type="button" onclick="addComment(${post.id})">Post</button>
                        </div>
                        <div id="commentsList_${post.id}">${renderCommentsList(post.id)}</div>
                    </div>
                </div>`;
            }).join('');
        }

        function highlightFocusedPost() {
            if (!focusPostId) return;

            let card = document.getElementById('post_' + focusPostId);
            if (!card) return;

            setTimeout(() => {
                card.scrollIntoView({ behavior: 'smooth', block: 'center' });
                card.classList.add('notification-target');
            }, 250);

            toggleCommentSection(focusPostId);
        }

        function renderCommentsList(postId) {
            let comments = st_comments[postId] || [];
            if (!comments.length) return '<div class="no-comments">No comments yet.</div>';
            const topLevel = comments.filter(c => !c.parentCommentId);
            const replies = comments.filter(c => c.parentCommentId);
            return topLevel.map(c => {
                let rHtml = replies.filter(r => r.parentCommentId === c.commentId).map(r =>
                    `<div class="comment reply-comment" style="margin-left:42px;padding:6px 0;border-bottom:none;">
                        ${commentAvatarHtml(r.profileImage)}
                        <div><span class="comment-author">${escapeHtml(r.author)}</span><div>${escapeHtml(r.text)}</div><small>${r.date||''}</small></div>
                    </div>`
                ).join('');
                return `<div class="comment" data-comment-id="${c.commentId}">
                    ${commentAvatarHtml(c.profileImage)}
                    <div style="flex:1;min-width:0;">
                        <span class="comment-author">${escapeHtml(c.author)}</span>
                        <div>${escapeHtml(c.text)}</div>
                        <div style="display:flex;align-items:center;gap:12px;margin-top:4px;">
                            <small>${c.date||''}</small>
                            <button type="button" class="comment-like-btn ${c.userLiked?'liked':''}" onclick="likeComment(${c.commentId},this)"
                                style="background:none;border:none;cursor:pointer;font-size:12px;color:${c.userLiked?'#dc2626':'var(--muted)'};display:flex;align-items:center;gap:4px;padding:0;">
                                <i class="${c.userLiked?'fas':'far'} fa-heart"></i>
                                <span class="clc">${c.likeCount>0?c.likeCount:''}</span>
                            </button>
                            <button type="button" onclick="toggleReplyBox(${c.commentId},${postId})"
                                style="background:none;border:none;cursor:pointer;font-size:12px;color:var(--muted);padding:0;">
                                <i class="fas fa-reply"></i> Reply
                            </button>
                        </div>
                        <div id="replyBox_${c.commentId}" style="display:none;margin-top:8px;">
                            <div class="comment-input" style="margin:0;">
                                <input type="text" id="replyInput_${c.commentId}" placeholder="Write a reply..." style="font-size:12px;" />
                                <button type="button" onclick="submitReply(${c.commentId},${postId})" style="padding:8px 16px;font-size:12px;">Reply</button>
                            </div>
                        </div>
                        ${rHtml}
                    </div>
                </div>`;
            }).join('');
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
            t.style.cssText = 'position:fixed;bottom:30px;left:50%;transform:translateX(-50%);background:#1a3a5c;color:#fff;padding:8px 20px;border-radius:30px;z-index:9999';
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
                    if (focusPostId) highlightFocusedPost();
                    showToast(res.liked ? '❤️ Liked!' : 'Like removed');
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
                    if (focusPostId) highlightFocusedPost();
                    showToast(res.isPinned ? '📌 Pinned!' : 'Unpinned');
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
                .then(list => {
                    st_comments[postId] = list;
                    let listDiv = document.getElementById(`commentsList_${postId}`);
                    if (listDiv) listDiv.innerHTML = renderCommentsList(postId);
                    let countSpan = document.querySelector(`.announcement-card[data-id="${postId}"] .comment-count`);
                    if (countSpan) countSpan.textContent = list.filter(c => !c.parentCommentId).length;
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
                    showToast('↩️ Reply posted');
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
            document.getElementById('activeFilterLabel').innerText = cat;
            renderAnnouncements();
            if (focusPostId) highlightFocusedPost();
            document.querySelectorAll('.dropdown-item-panel').forEach(btn => {
                btn.style.fontWeight = btn.textContent.includes(cat) || (cat === 'All' && btn.textContent.includes('All')) ? '700' : '';
                btn.style.color = btn.style.fontWeight === '700' ? 'var(--primary)' : '';
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

        function closeCreatePostModal() {
            document.getElementById('createPostModal').style.display = 'none';
            document.getElementById('announcementTitle').value = '';
            document.getElementById('announcementContent').value = '';
            document.getElementById('announcementImageFile').value = '';
            document.getElementById('imagePreview').style.display = 'none';
        }

        function clearImagePreview() {
            document.getElementById('announcementImageFile').value = '';
            document.getElementById('imagePreview').style.display = 'none';
        }

        function publishAnnouncement() {
            let title = document.getElementById('announcementTitle').value.trim();
            let content = document.getElementById('announcementContent').value.trim();
            let category = document.getElementById('announcementCategory').value;
            if (!title || !content) return showToast('Please fill in title and content');

            let form = new FormData();
            form.append('title', title);
            form.append('content', content);
            form.append('category', category);

            let file = document.getElementById('announcementImageFile').files[0];
            if (file) form.append('imageFile', file);

            fetch('AnnouncementHandler.ashx?action=create', {
                method: 'POST',
                credentials: 'same-origin',
                body: form
            }).then(() => {
                closeCreatePostModal();
                loadAnnouncementsFromDB();
                showToast('Posted!');
            });
        }

        function openEditModal(id) {
            let post = st_announcements.find(p => p.id === id);
            if (post) {
                document.getElementById('announcementTitle').value = post.title;
                document.getElementById('announcementContent').value = post.content;
                document.getElementById('announcementCategory').value = post.category;
                openCreatePostModal();
                let btn = document.getElementById('postBtn');
                btn.innerHTML = '<i class="fas fa-save" style="margin-right:6px;"></i>Update';
                btn.onclick = () => updateAnnouncement(id);
            }
        }

        function updateAnnouncement(id) {
            let title = document.getElementById('announcementTitle').value;
            let content = document.getElementById('announcementContent').value;
            let category = document.getElementById('announcementCategory').value;
            let form = new FormData();
            form.append('title', title);
            form.append('content', content);
            form.append('category', category);
            let file = document.getElementById('announcementImageFile').files[0];
            if (file) form.append('imageFile', file);

            fetch(`AnnouncementHandler.ashx?action=update&id=${id}`, {
                method: 'POST',
                body: form,
                credentials: 'same-origin'
            }).then(() => {
                closeCreatePostModal();
                loadAnnouncementsFromDB();
                showToast('Updated');
            });
        }

        function deletePost(id) {
            var modal = document.getElementById('deleteConfirmModal');
            if (!modal) return;
            modal.classList.add('active');

            document.getElementById('deleteConfirmBtn').onclick = function () {
                modal.classList.remove('active');
                fetch(`AnnouncementHandler.ashx?action=delete&id=${id}`, { credentials: 'same-origin' })
                    .then(() => { loadAnnouncementsFromDB(); showToast('🗑️ Deleted'); });
            };
        }

        document.getElementById('deleteCancelBtn').addEventListener('click', function () {
            document.getElementById('deleteConfirmModal').classList.remove('active');
        });

        document.getElementById('deleteConfirmModal').addEventListener('click', function (e) {
            if (e.target === this) this.classList.remove('active');
        });

        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') document.getElementById('deleteConfirmModal').classList.remove('active');
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

        function previewImageFile() {
            let file = document.getElementById('announcementImageFile').files[0];
            if (file) {
                let reader = new FileReader();
                reader.onload = e => {
                    document.getElementById('previewImg').src = e.target.result;
                    document.getElementById('imagePreview').style.display = 'block';
                };
                reader.readAsDataURL(file);
            }
        }

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
