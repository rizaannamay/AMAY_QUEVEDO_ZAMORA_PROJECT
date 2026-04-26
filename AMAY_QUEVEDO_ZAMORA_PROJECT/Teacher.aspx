<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Teacher.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Teacher" %>

<script runat="server">
    protected void SearchButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("SearchDashboard.aspx");
    }
</script>


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

        html, body, form { height: 100%; }
        html, body { overflow: hidden; }

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

        .logo { font-size: 22px; font-weight: 800; color: var(--primary); white-space: nowrap; cursor: pointer; }
        .logo i { color: var(--primary); margin-right: 8px; }

        .search-container {
            display: flex;
            gap: 10px;
            align-items: center;
            flex: 1;
            justify-content: center;
            min-width: 0;
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
            flex: 1 1 0;
            min-height: 0;
            display: grid;
            grid-template-columns: 280px minmax(0, 1fr);
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
            border-bottom: 1px solid var(--border);
            font-weight: 700;
            color: var(--primary);
            font-size: 16px;
        }

        .card-header i { margin-right: 10px; color: var(--primary); }

        .sidebar-toggle {
            border: none;
            background: none;
            color: var(--primary);
            font-size: 22px;
            cursor: pointer;
            margin-bottom: 12px;
            width: 100%;
            text-align: left;
            padding: 8px 0;
        }

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
            color: var(--page-text);
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
            color: var(--page-text);
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

        .main-panel {
            height: 100%;
            min-width: 0;
            min-height: 0;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .create-post-card {
            background: var(--surface-strong);
            border-radius: 16px;
            padding: 14px 18px;
            border: 1px solid var(--border);
            flex-shrink: 0;
            cursor: pointer;
            transition: all 0.3s;
        }
        .create-post-card:hover { transform: translateY(-1px); box-shadow: var(--shadow); }

        .create-post-header {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .create-post-avatar {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            flex-shrink: 0;
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
            border: 1px solid var(--border);
            transition: all 0.3s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.03);
            overflow: hidden;
        }

        .announcement-card:hover {
            box-shadow: 0 8px 18px rgba(0,0,0,0.08);
            border-color: var(--primary);
        }

        .filter-option {
            display: block;
            width: 100%;
            padding: 11px 18px;
            background: none;
            border: none;
            text-align: left;
            font-size: 13px;
            color: var(--page-text);
            cursor: pointer;
            transition: background 0.2s;
            border-bottom: 1px solid var(--border);
        }

        .filter-option:last-child { border-bottom: none; }

        .filter-option:hover {
            background: var(--active-bg);
            color: var(--primary);
        }

        .filter-option.active-filter {
            background: var(--active-bg);
            color: var(--primary);
            font-weight: 600;
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

        .pin-btn-top:hover { background: var(--surface-soft); }
        .pin-btn-top.pinned { color: #e65100; }

        .edit-btn-top, .delete-btn-top {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 16px;
            color: var(--muted-light);
            padding: 8px;
            border-radius: 50%;
            transition: all 0.3s;
            width: 36px;
            height: 36px;
        }

        .edit-btn-top:hover {
            background: rgba(59, 130, 246, 0.1);
            color: #3b82f6;
        }

        .delete-btn-top:hover {
            background: rgba(239, 68, 68, 0.1);
            color: #ef4444;
        }

        .post-content { padding: 0 22px 16px; }
        .post-title { font-size: 18px; font-weight: 700; margin-bottom: 10px; color: var(--primary); }
        .post-text { color: var(--page-text); line-height: 1.5; }

        .post-image { margin-top: 12px; border-radius: 16px; overflow: hidden; max-width: 100%; }
        .post-image img { width: 100%; max-height: 300px; object-fit: cover; border-radius: 16px; display: block; }

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
        .action-btn.liked i { font-weight: 900; }

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
            font-size: 13px;
            color: var(--page-text);
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
            padding: 10px 0;
            font-size: 13px;
            border-bottom: 1px solid var(--border);
            display: flex;
            gap: 10px;
        }

        .comment:last-child { border-bottom: none; }

        .comment-avatar {
            width: 32px;
            height: 32px;
            background: var(--active-bg);
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
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            border: 1px solid var(--border);
            z-index: 200;
            display: none;
        }

        .notification-dropdown.show { display: block; }

        .notification-header {
            padding: 15px 18px;
            border-bottom: 1px solid var(--border);
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

        .notification-list { max-height: 350px; overflow-y: auto; }

        .notification-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 18px;
            border-bottom: 1px solid var(--border);
            cursor: pointer;
        }

        .notification-item:hover { background: var(--surface-soft); }
        .notification-item.unread { background: var(--active-bg); }
        .notification-dot { width: 8px; height: 8px; background: #dc2626; border-radius: 50%; }
        .notification-time { font-size: 10px; color: var(--muted-light); }

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
            color: var(--muted);
        }

        .sidebar.collapsed { width: 88px; }
        .sidebar.collapsed .card-header span,
        .sidebar.collapsed .menu-text,
        .sidebar.collapsed .settings-text,
        .sidebar.collapsed .dropdown-content,
        .sidebar.collapsed .sidebar-toggle { display: none; }
        .sidebar.collapsed .menu-item,
        .sidebar.collapsed .settings-item { justify-content: center; }
        .sidebar.collapsed .dropdown-icon,
        .sidebar.collapsed .toggle-switch { display: none; }

        /* MODAL STYLES */
        .modal {
            display: none;
            position: fixed;
            inset: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(4px);
            z-index: 1000;
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
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            border: 1px solid var(--border);
        }

        .modal-header {
            padding: 20px 24px;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h2 {
            font-size: 20px;
            font-weight: 700;
            color: var(--primary);
        }

        .modal-close-btn {
            background: none;
            border: none;
            font-size: 24px;
            cursor: pointer;
            color: var(--muted);
            transition: color 0.2s;
        }

        .modal-close-btn:hover { color: var(--danger); }

        .modal-body { padding: 24px; }

        /* Profile Card Styles - Exact Design */
        #profileModal .modal-content {
    background-color: #111827; /* Dark navy background */
    color: #ffffff;
    border: none;
    padding: 30px;
    max-width: 400px;
    border-radius: 30px;
}

.profile-card-header {
    text-align: center;
    margin-bottom: 25px;
}

.profile-avatar-circle {
    width: 90px;
    height: 90px;
    background: #2563eb;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 15px;
    font-size: 40px;
    box-shadow: 0 0 20px rgba(37, 99, 235, 0.3);
}

.role-pill {
    background: #dbeafe;
    color: #1e40af;
    padding: 4px 16px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 700;
    display: inline-block;
    margin-top: 8px;
}

.info-box {
    background: #1f2937;
    border-radius: 16px;
    padding: 12px 16px;
    display: flex;
    align-items: center;
    gap: 15px;
    margin-bottom: 12px;
}

.info-icon-wrapper {
    color: #818cf8;
    font-size: 18px;
    width: 20px;
    text-align: center;
}

.info-text-container {
    display: flex;
    flex-direction: column;
}

.info-label-small {
    font-size: 10px;
    text-transform: uppercase;
    color: #9ca3af;
    letter-spacing: 1px;
    font-weight: 600;
}

.info-data-text {
    font-size: 15px;
    font-weight: 600;
    color: #f3f4f6;
}

.modal-action-row {
    display: flex;
    gap: 12px;
    margin-top: 25px;
}

.btn-modal-dark {
    flex: 1;
    padding: 14px;
    border-radius: 14px;
    font-weight: 600;
    cursor: pointer;
    border: 1px solid #374151;
    background: #111827;
    color: white;
}

.btn-modal-logout {
    flex: 1;
    background: #fff1f2;
    color: #be123c;
    border: none;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--primary);
            font-size: 14px;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 12px 16px;
            background: var(--surface-soft);
            border: 1px solid var(--border);
            border-radius: 16px;
            font-size: 14px;
            color: var(--page-text);
            transition: all 0.2s;
            outline: none;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 2px rgba(26, 58, 92, 0.1);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-group input[type="file"] {
            padding: 10px;
            cursor: pointer;
            font-size: 13px;
        }

        .form-group input[type="file"]::file-selector-button {
            padding: 8px 16px;
            background: linear-gradient(135deg, var(--primary), var(--primary-2));
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            margin-right: 12px;
            transition: all 0.2s;
        }

        .form-group input[type="file"]::file-selector-button:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(26, 58, 92, 0.3);
        }

        .image-preview {
            margin-top: 12px;
            border-radius: 16px;
            overflow: hidden;
            max-width: 100%;
            display: none;
        }

        .image-preview img {
            width: 100%;
            max-height: 200px;
            object-fit: cover;
            border-radius: 16px;
        }

        .modal-footer-buttons {
            padding: 16px 24px 24px;
            display: flex;
            gap: 12px;
            justify-content: flex-end;
            border-top: 1px solid var(--border);
        }

        .btn-cancel {
            padding: 10px 24px;
            background: none;
            border: 1px solid var(--border);
            border-radius: 40px;
            cursor: pointer;
            font-weight: 600;
            color: var(--page-text);
            transition: all 0.2s;
        }

        .btn-cancel:hover {
            background: var(--surface-soft);
        }

        .btn-publish {
            padding: 10px 28px;
            background: linear-gradient(135deg, var(--success), var(--success-hover));
            border: none;
            border-radius: 40px;
            cursor: pointer;
            font-weight: 600;
            color: white;
            transition: all 0.2s;
        }

        .btn-publish:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
        }

        /* Dark Mode Overrides */
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

        .dark-mode .search-btn {
            border-color: rgba(255,255,255,0.2);
            color: #e4e6eb;
            background: transparent;
        }

        .dark-mode .search-btn:hover {
            background: rgba(99,102,241,0.25);
            border-color: #6366f1;
            color: #ffffff;
        }

        .dark-mode .comment-input button { background: linear-gradient(135deg, #6366f1, #818cf8); }
        .dark-mode .notification-bell { border-color: var(--border); }
        .dark-mode .user-info { border-color: var(--border); background: rgba(255,255,255,0.07); }
        .dark-mode .card-header { border-bottom-color: rgba(255,255,255,0.04); }
        .dark-mode .post-stats { border-top-color: rgba(255,255,255,0.04); border-bottom-color: rgba(255,255,255,0.04); }
        .dark-mode .comment { border-bottom-color: rgba(255,255,255,0.03); }
        .dark-mode .notification-header { border-bottom-color: rgba(255,255,255,0.04); }
        .dark-mode .comment-input input { border-color: rgba(255,255,255,0.06); background: var(--surface-soft); color: var(--page-text); }
        .dark-mode .create-post-input { background: var(--surface-soft); border-color: rgba(255,255,255,0.06); color: var(--muted); }
        .dark-mode .announcement-board { background: rgba(18, 22, 28, 0.28); }
        .dark-mode .notification-item.unread { background: rgba(99, 102, 241, 0.15); }
        .dark-mode .modal-content { background: rgba(15, 25, 55, 0.97); border: 1px solid var(--border); }
        .dark-mode .form-group input,
        .dark-mode .form-group textarea,
        .dark-mode .form-group select { background: rgba(255,255,255,0.07); border-color: rgba(255,255,255,0.1); color: #e4e6eb; }
        .dark-mode .form-group input:focus,
        .dark-mode .form-group textarea:focus { border-color: #818cf8; }

        .dark-mode .form-group input[type="file"]::file-selector-button {
            background: linear-gradient(135deg, #6366f1, #818cf8);
        }
        .dark-mode .btn-cancel { border-color: rgba(255,255,255,0.2); color: #e4e6eb; }
        .dark-mode .btn-cancel:hover { background: rgba(255,255,255,0.07); }
        .dark-mode .info-grid { background: rgba(255,255,255,0.05); }
        .dark-mode .info-row { border-bottom-color: rgba(255,255,255,0.08); }
        .dark-mode .info-label { color: #94a3b8; }
        .dark-mode .info-value { color: #e4e6eb; }
        .dark-mode .btn-close-modal { border-color: rgba(255,255,255,0.2); color: #e4e6eb; }
        .dark-mode .btn-close-modal:hover { background: rgba(255,255,255,0.07); }

        @media (max-width: 980px) {
            html, body { overflow: auto; }
            .app-shell, form { height: auto; min-height: 100%; overflow: visible; }
            .footer { position: static; height: auto; line-height: normal; padding: 6px 0 0; }
            .header { flex-wrap: wrap; }
            .search-container { order: 3; width: 100%; justify-content: stretch; }
            .content-shell { grid-template-columns: 1fr; overflow: visible; }
            .sidebar, .main-panel, .sidebar .card { height: auto; }
            .announcement-board, .sidebar-content { overflow: visible; max-height: none; }
            .notification-dropdown { right: 12px; left: 12px; width: auto; }
        }

        /* Page Flip Animation */
        @keyframes flipOut {
            0%   { transform: perspective(1200px) rotateY(0deg); opacity: 1; }
            100% { transform: perspective(1200px) rotateY(-90deg); opacity: 0; }
        }
        @keyframes flipIn {
            0%   { transform: perspective(1200px) rotateY(90deg); opacity: 0; }
            100% { transform: perspective(1200px) rotateY(0deg); opacity: 1; }
        }

        .page-flip-out { animation: flipOut 0.18s ease-in forwards; transform-origin: center center; }
        .page-flip-in { animation: flipIn 0.18s ease-out forwards; transform-origin: center center; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="app-shell">
            <div class="header">
                <div class="logo" onclick="navigateWithFlip('Teacher.aspx')">
                    <i class="fas fa-chalkboard-teacher"></i> CampusConnect Teacher
                </div>

                <div class="search-container">
                    <asp:Button ID="searchButton" runat="server" CssClass="search-btn"
                        Text="🔎 Search Announcements..." OnClick="SearchButton_Click"
                        Width="420px" Font-Bold="False" Font-Size="Medium" Height="54px"
                        UseSubmitBehavior="false" />
                </div>

                <div class="header-actions">
                    <div class="notification-bell" onclick="openNotificationDropdown()">
                        <i class="fas fa-bell bell-icon"></i>
                        <span id="notificationBadge" class="badge-red" style="display:none;">0</span>
                    </div>
                    <div class="user-info" onclick="openProfileModal()">
                        <div class="avatar">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="user-details">
                            <div class="user-name"><%= Session["FullName"] ?? "User" %></div>
                            <div class="user-role"><%= Session["Role"] ?? "Teacher" %></div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="notificationDropdown" class="notification-dropdown">
                <div class="notification-header">
                    <a href="Notifications.aspx" style="text-decoration:none;color:inherit;">
                        <span><i class="fas fa-bell"></i> Notifications</span>
                    </a>
                    <button type="button" onclick="markAllRead()">Mark all read</button>
                </div>
                <div class="notification-list">
                    <div class="notification-item unread" onclick="markNotificationRead(this)">
                        <div class="notification-dot"></div>
                        <div class="notification-text">New exam schedule announced</div>
                        <div class="notification-time">2 hours ago</div>
                    </div>
                    <div class="notification-item unread" onclick="markNotificationRead(this)">
                        <div class="notification-dot"></div>
                        <div class="notification-text">Class suspension due to typhoon</div>
                        <div class="notification-time">1 day ago</div>
                    </div>
                    <div class="notification-item" onclick="markNotificationRead(this)">
                        <div class="notification-text">Foundation Week activities posted</div>
                        <div class="notification-time">3 days ago</div>
                    </div>
                </div>
            </div>

            <div class="content-shell">
                <aside class="sidebar">
                    <div class="card">
                        <div class="sidebar-content">
                            <div class="card-header">
                                <i class="fas fa-filter"></i> <span>Filters</span>
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
                                <button type="button" class="dropdown-item" onclick="filterCategory('General')">General</button>
                            </div>

                            <button type="button" class="menu-item" onclick="navigateWithFlip('Pinned.aspx')">
                                <i class="fas fa-thumbtack"></i>
                                <span class="menu-text">Pinned Announcements</span>
                            </button>

                            <div class="card-header" style="margin-top:5px;">
                                <i class="fas fa-cog"></i> <span>Settings</span>
                            </div>

                            <button type="button" class="settings-item" onclick="toggleTheme()">
                                <i class="fas fa-moon"></i>
                                <span class="settings-text">Dark / Light Mode</span>
                                <div class="toggle-switch" id="themeToggle" role="switch"></div>
                            </button>

                            <button type="button" class="settings-item" onclick="window.location.href='AboutUs.aspx?source=teacher'">
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

                <main class="main-panel">
                    <div class="create-post-card" onclick="openCreatePostModal()">
                        <div class="create-post-header">
                            <div class="create-post-avatar">
                                <i class="fas fa-plus-circle"></i>
                            </div>
                            <div class="create-post-input">
                                Share an announcement with students...
                            </div>
                        </div>
                    </div>

                    <div class="card" style="flex:1 1 0; min-height:0; display:flex; flex-direction:column;">
                        <div class="card-header" style="flex-shrink:0;">
                            <i class="fas fa-bullhorn"></i> Announcement Board
                            <span style="float: right; font-size: 12px;">Showing: <span id="activeFilterLabel">All</span></span>
                        </div>

                        <div id="announcementsContainer" class="announcement-board">
                            <!-- Announcements will be displayed here -->
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <!-- CREATE ANNOUNCEMENT MODAL -->
        <div id="createPostModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2><i class="fas fa-plus-circle"></i> New Announcement</h2>
                    <button type="button" class="modal-close-btn" onclick="closeCreatePostModal()">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label><i class="fas fa-heading"></i> Title</label>
                        <input type="text" id="announcementTitle" placeholder="Enter announcement title..." />
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-tag"></i> Category</label>
                        <select id="announcementCategory">
                            <option value="General">📢 General</option>
                            <option value="Exam">📝 Exam Schedule</option>
                            <option value="Suspension">⚠️ Class Suspension</option>
                            <option value="Event">🎉 Campus Events</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-align-left"></i> Content</label>
                        <textarea id="announcementContent" placeholder="Write your announcement here..."></textarea>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-image"></i> Image Upload (optional)</label>
                        <input type="file" id="announcementImageFile" accept="image/*" onchange="previewImageFile()" />
                        <div id="imagePreview" class="image-preview">
                            <img id="previewImg" src="" alt="Preview" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer-buttons">
                    <button type="button" class="btn-cancel" onclick="closeCreatePostModal()">Cancel</button>
                    <button type="button" class="btn-publish" onclick="publishAnnouncement()"><i class="fas fa-paper-plane"></i> Publish</button>
                </div>
            </div>
        </div>

        <!-- PROFILE MODAL - EXACT DESIGN -->
        <div id="profileModal" class="modal">
    <div class="modal-content">
        <div class="profile-card-header">
            <div class="profile-avatar-circle">
                <i class="fas fa-user"></i>
            </div>
            <h2 style="color: white; margin: 0;"><%= Session["FullName"] ?? "User" %></h2>
            <span class="role-pill"><%= Session["Role"] ?? "Teacher" %></span>
        </div>

        <div class="info-box">
            <div class="info-icon-wrapper"><i class="fas fa-user"></i></div>
            <div class="info-text-container">
                <span class="info-label-small">Username</span>
                <span class="info-data-text"><%= Session["Username"] ?? "�" %></span>
            </div>
        </div>

        <div class="info-box">
            <div class="info-icon-wrapper"><i class="fas fa-envelope"></i></div>
            <div class="info-text-container">
                <span class="info-label-small">Email</span>
                <span class="info-data-text"><%= Session["Email"] ?? "�" %></span>
            </div>
        </div>

        <div class="info-box">
            <div class="info-icon-wrapper"><i class="fas fa-shield-alt"></i></div>
            <div class="info-text-container">
                <span class="info-label-small">Role</span>
                <span class="info-data-text"><%= Session["Role"] ?? "Teacher" %></span>
            </div>
        </div>

        <div class="info-box">
            <div class="info-icon-wrapper"><i class="fas fa-lock"></i></div>
            <div class="info-text-container">
                <span class="info-label-small">Password</span>
                <span class="info-data-text">&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;</span>
            </div>
        </div>

        <div class="modal-action-row">
            <button type="button" class="btn-modal-dark" onclick="closeProfileModal()">Close</button>
            <button type="button" class="btn-modal-dark btn-modal-logout" onclick="handleLogout()">
                <i class="fas fa-sign-out-alt"></i> Logout
            </button>
        </div>
    </div>
</div>

        <!-- ABOUT MODAL -->
        <div id="aboutModal" class="modal">
            <div class="modal-content" style="text-align:center; max-width: 450px;">
                <div class="modal-header">
                    <h2><i class="fas fa-info-circle"></i> About Campus Connect</h2>
                    <button type="button" class="modal-close-btn" onclick="closeAboutModal()">&times;</button>
                </div>
                <div class="modal-body">
                    <div style="font-size: 48px; color: var(--primary); margin-bottom: 16px;">
                        <i class="fas fa-university"></i>
                    </div>
                    <p style="margin-bottom: 16px; line-height: 1.6;">Campus Connect is a centralized web-based announcement system for Cebu Technological University. It allows teachers to post announcements, manage exam schedules, class suspensions, and campus events.</p>
                    <p style="color: var(--muted); font-size: 12px;">Version 2.0 | � 2024 Campus Connect</p>
                </div>
                <div class="modal-footer-buttons" style="justify-content: center;">
                    <button type="button" class="btn-publish" onclick="closeAboutModal()">Got it</button>
                </div>
            </div>
        </div>

        <div class="footer">
            <i class="fas fa-shield-alt"></i> Secure Portal | Cebu Technological University | � 2024 Campus Connect
        </div>
    </form>

    <script>
        // ====================== SHARED LOCALSTORAGE STATE ======================
        var ST = {
            get: function(k) { try { return JSON.parse(localStorage.getItem(k) || 'null'); } catch(e) { return null; } },
            set: function(k, v) { localStorage.setItem(k, JSON.stringify(v)); }
        };

        var st_announcements = [];
        var st_likes         = ST.get('teacher_likes')      || {};
        var st_likeCounts    = ST.get('teacher_likeCounts') || {};
        var st_pins          = ST.get('teacher_pins')       || {};
        var st_comments      = ST.get('teacher_comments')   || {};

        function saveSharedState() {
            ST.set('teacher_announcements', st_announcements);
            ST.set('teacher_likes', st_likes);
            ST.set('teacher_likeCounts', st_likeCounts);
            ST.set('teacher_pins', st_pins);
            ST.set('campus_pins',  st_pins);   // shared with Student.aspx & Search pages
            ST.set('teacher_comments', st_comments);
        }

        function pushNotification(msg, icon) {
            var notifs = JSON.parse(localStorage.getItem('campus_notifications') || '[]');
            notifs.unshift({ msg: msg, icon: icon || 'fa-bell', time: new Date().toISOString(), read: false });
            if (notifs.length > 50) notifs = notifs.slice(0, 50);
            localStorage.setItem('campus_notifications', JSON.stringify(notifs));
            window.dispatchEvent(new StorageEvent('storage', { key: 'campus_notifications', newValue: JSON.stringify(notifs) }));
        }

        // -- Load announcements from DB on page load ----------
        function loadAnnouncementsFromDB() {
            var container = document.getElementById('announcementsContainer');
            if (container) container.innerHTML = '<div style="text-align:center;padding:40px;color:var(--muted)"><i class="fas fa-spinner fa-spin"></i> Loading...</div>';

            fetch('AnnouncementHandler.ashx?action=getAll', { credentials: 'same-origin' })
                .then(function(r) { return r.json(); })
                .then(function(res) {
                    if (!res.ok) { showToast('Error loading announcements'); return; }
                    st_announcements = res.data.map(function(a) {
                        return {
                            id:       a.id,
                            title:    a.title,
                            content:  a.content,
                            category: a.category,
                            author:   a.author,
                            date:     a.date,
                            imageUrl: a.imageUrl,
                            pinned:   a.isPinned,
                            likeCount: a.likeCount
                        };
                    });
                    // Update in-memory pins — no localStorage write needed
                    st_pins = {};
                    st_announcements.forEach(function(a) { if (a.pinned) st_pins[a.id] = true; });
                    renderAnnouncements();
                })
                .catch(function() { showToast('Could not reach server'); });
        }

        function renderAnnouncements() {
            var container = document.getElementById('announcementsContainer');
            if (!container) return;
            
            var filtered = st_announcements.filter(function(a) {
                var currentFilter = document.getElementById('activeFilterLabel')?.innerText || 'All';
                return currentFilter === 'All' || a.category === currentFilter;
            });
            
            filtered.sort(function(a, b) {
                if (st_pins[a.id] && !st_pins[b.id]) return -1;
                if (!st_pins[a.id] && st_pins[b.id]) return 1;
                return b.id - a.id;
            });
            
            container.innerHTML = filtered.map(function(post) {
                var isPinned = st_pins[post.id] || false;
                var likeCount = st_likeCounts[post.id] || post.likeCount || 0;
                var commentCount = (st_comments[post.id] || []).length;
                var categoryClass = post.category === 'Exam' ? 'post-category-exam' : 
                                   (post.category === 'Suspension' ? 'post-category-suspension' : 
                                   (post.category === 'Event' ? 'post-category-event' : 'post-category-general'));
                
                return '<div class="announcement-card" data-post-id="' + post.id + '" data-category="' + post.category + '">' +
                    '<div class="post-header">' +
                        '<div class="post-header-left">' +
                            '<div class="post-avatar"><i class="fas fa-user-tie"></i></div>' +
                            '<div>' +
                                '<div class="post-author">' + escapeHtml(post.author) + '</div>' +
                                '<div class="post-meta">' +
                                    '<span><i class="far fa-calendar-alt"></i> ' + escapeHtml(post.date) + '</span>' +
                                    '<span class="post-category ' + categoryClass + '">' + escapeHtml(post.category) + '</span>' +
                                '</div>' +
                            '</div>' +
                        '</div>' +
                        '<div style="display:flex;gap:8px;align-items:center;">' +
                            '<button type="button" class="edit-btn-top" onclick="openEditModal(' + post.id + ')" title="Edit">' +
                                '<i class="fas fa-edit"></i>' +
                            '</button>' +
                            '<button type="button" class="delete-btn-top" onclick="deletePost(' + post.id + ')" title="Delete">' +
                                '<i class="fas fa-trash"></i>' +
                            '</button>' +
                            '<button type="button" class="pin-btn-top ' + (isPinned ? 'pinned' : '') + '" onclick="togglePin(' + post.id + ')" title="' + (isPinned ? 'Unpin' : 'Pin') + '">' +
                                '<i class="' + (isPinned ? 'fas' : 'far') + ' fa-thumbtack"></i>' +
                            '</button>' +
                        '</div>' +
                    '</div>' +
                    '<div class="post-content">' +
                        '<div class="post-title">' + escapeHtml(post.title) + '</div>' +
                        '<div class="post-text">' + escapeHtml(post.content) + '</div>' +
                        (post.imageUrl ? '<div class="post-image"><img src="' + escapeHtml(post.imageUrl) + '" alt="Announcement image" onerror="this.style.display=\'none\'" /></div>' : '') +
                    '</div>' +
                    '<div class="post-stats">' +
                        '<span onclick="toggleLike(' + post.id + ')"><i class="' + (st_likes[post.id] ? 'fas' : 'far') + ' fa-heart"></i> <span class="like-count">' + likeCount + '</span> Likes</span>' +
                        '<span onclick="toggleCommentSection(' + post.id + ')"><i class="far fa-comment"></i> <span class="comment-count">' + commentCount + '</span> Comments</span>' +
                        '<span onclick="sharePost(' + post.id + ')"><i class="far fa-share-square"></i> Share</span>' +
                    '</div>' +
                    '<div class="action-buttons">' +
                        '<button type="button" class="action-btn like-btn" onclick="toggleLike(' + post.id + ')">' +
                            '<i class="' + (st_likes[post.id] ? 'fas' : 'far') + ' fa-heart"></i> ' + (st_likes[post.id] ? 'Liked' : 'Like') +
                        '</button>' +
                        '<button type="button" class="action-btn" onclick="toggleCommentSection(' + post.id + ')"><i class="far fa-comment"></i> Comment</button>' +
                        '<button type="button" class="action-btn" onclick="sharePost(' + post.id + ')"><i class="fas fa-share"></i> Share</button>' +
                    '</div>' +
                    '<div class="comments-section" id="commentsSection_' + post.id + '" style="display:none;">' +
                        '<div class="comment-input">' +
                            '<input type="text" id="commentInput_' + post.id + '" placeholder="Write a comment..." />' +
                            '<button type="button" onclick="addComment(' + post.id + ')">Post</button>' +
                        '</div>' +
                        '<div class="comments-list" id="commentsList_' + post.id + '">' +
                            renderCommentsList(post.id) +
                        '</div>' +
                    '</div>' +
                '</div>';
            }).join('');
        }

        function renderCommentsList(postId) {
            var comments = st_comments[postId] || [];
            if (comments.length === 0) {
                return '<div class="no-comments">No comments yet. Be the first!</div>';
            }
            return comments.map(function(c) {
                return '<div class="comment">' +
                    '<div class="comment-avatar"><i class="fas fa-user"></i></div>' +
                    '<div class="comment-content">' +
                        '<span class="comment-author">' + escapeHtml(c.author) + '</span>' +
                        '<div class="comment-text">' + escapeHtml(c.text) + '</div>' +
                        '<div class="comment-time">' + escapeHtml(c.time) + '</div>' +
                    '</div></div>';
            }).join('');
        }

        function escapeHtml(str) {
            if (!str) return '';
            return str.replace(/[&<>]/g, function(m) {
                return { '&': '&amp;', '<': '&lt;', '>': '&gt;' }[m];
            });
        }

        // ====================== INTERACTIONS ======================
        function toggleLike(postId) {
            fetch('LikeHandler.ashx?action=toggle&postId=' + postId, { credentials: 'same-origin' })
                .then(function(r) { return r.json(); })
                .then(function(res) {
                    if (!res.ok) { showToast('Error: ' + res.error); return; }
                    st_likes[postId]      = res.liked;
                    st_likeCounts[postId] = res.likeCount;
                    var ann = st_announcements.find(function(a) { return a.id === postId; });
                    if (res.liked && ann) pushNotification('?? Someone liked "' + ann.title + '"', 'fa-heart');
                    saveSharedState();
                    renderAnnouncements();
                    showToast(res.liked ? '?? Liked!' : 'Like removed');
                })
                .catch(function() { showToast('Could not update like'); });
        }

        function togglePin(postId) {
            fetch('AnnouncementHandler.ashx?action=togglePin&id=' + postId, { credentials: 'same-origin' })
                .then(function(r) { return r.json(); })
                .then(function(res) {
                    if (!res.ok) { showToast('Error: ' + res.error); return; }
                    var ann = st_announcements.find(function(a) { return a.id === postId; });
                    if (ann) {
                        ann.pinned = res.isPinned;
                        st_pins[postId] = res.isPinned;
                        if (!res.isPinned) delete st_pins[postId];
                        saveSharedState();
                        pushNotification((res.isPinned ? '?? Pinned: ' : '?? Unpinned: ') + ann.title, 'fa-thumbtack');
                        window.dispatchEvent(new StorageEvent('storage', { key: 'teacher_pins', newValue: JSON.stringify(st_pins) }));
                        window.dispatchEvent(new StorageEvent('storage', { key: 'campus_pins',  newValue: JSON.stringify(st_pins) }));
                    }
                    renderAnnouncements();
                    showToast(res.isPinned ? '?? Pinned!' : 'Unpinned');
                })
                .catch(function() { showToast('Could not update pin'); });
        }

        function toggleCommentSection(postId) {
            var section = document.getElementById('commentsSection_' + postId);
            if (!section) return;
            var isHidden = section.style.display === 'none' || section.style.display === '';
            section.style.display = isHidden ? 'block' : 'none';
            if (isHidden) {
                var input = document.getElementById('commentInput_' + postId);
                if (input) setTimeout(function() { input.focus(); }, 50);
            }
        }

        function addComment(postId) {
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
                var ann = st_announcements.find(function(a) { return a.id === postId; });
                if (ann) pushNotification('?? Teacher commented on "' + ann.title + '": ' + text, 'fa-comment');
                input.value = '';
                // Reload comments from DB
                loadComments(postId);
                showToast('?? Comment posted!');
            })
            .catch(function() { showToast('Could not post comment'); });
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
                    // Update comment count in stats bar
                    var ccSpan = document.querySelector('.announcement-card[data-post-id="' + postId + '"] .comment-count');
                    if (ccSpan) ccSpan.textContent = list.length;
                })
                .catch(function() {});
        }

        function sharePost(postId) {
            var url = window.location.href.split('?')[0] + '?post=' + postId;
            var ann = st_announcements.find(function(a) { return a.id === postId; });
            if (ann) pushNotification('🔗 "' + ann.title + '" was shared', 'fa-share-alt');
            if (navigator.clipboard) {
                navigator.clipboard.writeText(url).then(function() { showToast('🔗 Link copied!'); });
            } else {
                showToast('📤 Shared!');
            }
        }

        function publishAnnouncement() {
            var title    = document.getElementById('announcementTitle').value.trim();
            var content  = document.getElementById('announcementContent').value.trim();
            var category = document.getElementById('announcementCategory').value;
            var imageFileInput = document.getElementById('announcementImageFile');

            if (!title)   { showToast('Please enter a title!'); return; }
            if (!content) { showToast('Please enter content!'); return; }

            var publishBtn = document.querySelector('.btn-publish');
            if (publishBtn) { publishBtn.disabled = true; publishBtn.textContent = 'Publishing...'; }

            // Use FormData so the server can read ctx.Request.Form and ctx.Request.Files
            var formData = new FormData();
            formData.append('title',    title);
            formData.append('content',  content);
            formData.append('category', category);
            if (imageFileInput && imageFileInput.files && imageFileInput.files[0]) {
                formData.append('imageFile', imageFileInput.files[0]);
            }

            fetch('AnnouncementHandler.ashx?action=create', {
                method: 'POST',
                credentials: 'same-origin',
                body: formData   // no Content-Type header — browser sets multipart boundary automatically
            })
            .then(function(r) {
                if (!r.ok) return r.text().then(function(t) { throw new Error('Server error ' + r.status + ': ' + t.substring(0, 200)); });
                return r.json();
            })
            .then(function(res) {
                if (!res.ok) { showToast('❌ ' + res.error); return; }
                closeCreatePostModal();
                showToast('✅ Announcement published!');
                loadAnnouncementsFromDB();
            })
            .catch(function(err) {
                showToast('❌ ' + (err.message || 'Could not save announcement'));
                console.error('publishAnnouncement error:', err);
            })
            .finally(function() {
                if (publishBtn) { publishBtn.disabled = false; publishBtn.innerHTML = '<i class="fas fa-paper-plane"></i> Publish'; }
            });
        }

        function previewImageFile() {
            var fileInput = document.getElementById('announcementImageFile');
            var preview = document.getElementById('imagePreview');
            var img = document.getElementById('previewImg');
            
            if (fileInput.files && fileInput.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    img.src = e.target.result;
                    preview.style.display = 'block';
                };
                reader.readAsDataURL(fileInput.files[0]);
            } else {
                preview.style.display = 'none';
                img.src = '';
            }
        }

        // ====================== EDIT POST ======================
        function openEditModal(postId) {
            var post = st_announcements.find(function(a) { return a.id === postId; });
            if (!post) { showToast('Post not found'); return; }

            // Populate the create post modal with existing data
            document.getElementById('announcementTitle').value = post.title;
            document.getElementById('announcementContent').value = post.content;
            document.getElementById('announcementCategory').value = post.category;
            
            // Change modal title and button
            var modalTitle = document.querySelector('#createPostModal .modal-title');
            if (modalTitle) modalTitle.textContent = 'Edit Announcement';
            
            var publishBtn = document.querySelector('.btn-publish');
            if (publishBtn) {
                publishBtn.innerHTML = '<i class="fas fa-save"></i> Update';
                publishBtn.onclick = function() { updateAnnouncement(postId); };
            }
            
            openCreatePostModal();
        }

        function updateAnnouncement(postId) {
            var title    = document.getElementById('announcementTitle').value.trim();
            var content  = document.getElementById('announcementContent').value.trim();
            var category = document.getElementById('announcementCategory').value;
            var imageFile = document.getElementById('announcementImageFile').files[0];

            if (!title)   { showToast('Please enter a title!');   return; }
            if (!content) { showToast('Please enter content!');   return; }

            var publishBtn = document.querySelector('.btn-publish');
            if (publishBtn) { publishBtn.disabled = true; publishBtn.textContent = 'Updating...'; }

            var formData = new FormData();
            formData.append('title', title);
            formData.append('content', content);
            formData.append('category', category);
            if (imageFile) {
                formData.append('imageFile', imageFile);
            }

            fetch('AnnouncementHandler.ashx?action=update&id=' + postId, {
                method: 'POST',
                credentials: 'same-origin',
                body: formData
            })
            .then(function(r) {
                if (!r.ok) {
                    return r.text().then(function(t) { throw new Error('Server error ' + r.status); });
                }
                return r.json();
            })
            .then(function(res) {
                if (!res.ok) { showToast('Error: ' + res.error); return; }
                closeCreatePostModal();
                showToast('✅ Announcement updated!');
                loadAnnouncementsFromDB();
            })
            .catch(function(err) {
                showToast('Error: ' + (err.message || 'Could not update announcement'));
                console.error('updateAnnouncement error:', err);
            })
            .finally(function() {
                if (publishBtn) { 
                    publishBtn.disabled = false; 
                    publishBtn.innerHTML = '<i class="fas fa-paper-plane"></i> Publish';
                    publishBtn.onclick = publishAnnouncement;
                }
            });
        }

        // ====================== DELETE POST ======================
        function deletePost(postId) {
            var post = st_announcements.find(function(a) { return a.id === postId; });
            if (!post) return;

            if (!confirm('Are you sure you want to delete "' + post.title + '"?\n\nThis action cannot be undone.')) {
                return;
            }

            fetch('AnnouncementHandler.ashx?action=delete&id=' + postId, {
                method: 'GET',
                credentials: 'same-origin'
            })
            .then(function(r) { return r.json(); })
            .then(function(res) {
                if (!res.ok) { showToast('Error: ' + res.error); return; }
                showToast('🗑️ Announcement deleted');
                loadAnnouncementsFromDB();
            })
            .catch(function() { showToast('Could not delete announcement'); });
        }

        // ====================== UI HELPERS ======================
        function showToast(message) {
            var toast = document.createElement('div');
            toast.innerText = message;
            toast.style.cssText = 'position:fixed;bottom:28px;left:50%;transform:translateX(-50%);background:#1a3a5c;color:#fff;padding:10px 24px;border-radius:30px;font-size:13px;z-index:9999;box-shadow:0 4px 16px rgba(0,0,0,.25);pointer-events:none;';
            document.body.appendChild(toast);
            setTimeout(function() { if (toast.parentNode) toast.parentNode.removeChild(toast); }, 2500);
        }

        function filterCategory(category) {
            var label = document.getElementById('activeFilterLabel');
            if (label) label.innerText = category;
            renderAnnouncements();
            var dropdown = document.getElementById('categoryDropdown');
            if (dropdown) dropdown.style.maxHeight = '0px';
        }

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

        function markNotificationRead(item) {
            item.classList.remove('unread');
            var dot = item.querySelector('.notification-dot');
            if (dot) dot.remove();
            
            // Update localStorage
            var notifs = JSON.parse(localStorage.getItem('campus_notifications') || '[]');
            var index = Array.from(document.querySelectorAll('.notification-item')).indexOf(item);
            if (notifs[index]) {
                notifs[index].read = true;
            }
            localStorage.setItem('campus_notifications', JSON.stringify(notifs));
            
            // Update badge
            updateNotificationBadge();
        }

        function markAllRead() {
            // Update database first
            fetch('NotificationHandler.ashx?action=markAllRead', { credentials: 'same-origin' })
                .then(function(r) { return r.json(); })
                .then(function(res) {
                    if (res.ok) {
                        // Update UI
                        document.querySelectorAll('.notification-item.unread').forEach(function(item) {
                            item.classList.remove('unread');
                            var dot = item.querySelector('.notification-dot');
                            if (dot) dot.remove();
                        });
                        
                        // Clear localStorage
                        var notifs = JSON.parse(localStorage.getItem('campus_notifications') || '[]');
                        notifs.forEach(function(n) { n.read = true; });
                        localStorage.setItem('campus_notifications', JSON.stringify(notifs));
                        
                        // Update badge to 0
                        var badge = document.getElementById('notificationBadge');
                        if (badge) badge.style.display = 'none';
                        
                        showToast('✅ All notifications marked as read');
                    }
                })
                .catch(function(err) {
                    console.error('Error marking notifications as read:', err);
                    showToast('Could not mark notifications as read');
                });
        }

        function updateNotificationBadge() {
            var notifs = JSON.parse(localStorage.getItem('campus_notifications') || '[]');
            var unreadCount = notifs.filter(function(n) { return !n.read; }).length;
            var badge = document.getElementById('notificationBadge');
            
            if (badge) {
                if (unreadCount > 0) {
                    badge.textContent = unreadCount;
                    badge.style.display = 'flex';
                } else {
                    badge.style.display = 'none';
                }
            }
        }

        function openNotificationDropdown() {
            // Mark all as read in database
            markAllRead();
            // Navigate to notifications page
            setTimeout(function() {
                navigateWithFlip('Notifications.aspx');
            }, 300);
        }

        function clearAllNotifications() {
            if (!confirm('Clear all notifications?')) return;
            
            // Clear localStorage
            localStorage.removeItem('campus_notifications');
            
            // Clear database
            fetch('NotificationHandler.ashx?action=markAllRead', { credentials: 'same-origin' })
                .then(function(r) { return r.json(); })
                .then(function(res) {
                    if (res.ok) {
                        showToast('✅ All notifications cleared');
                        updateNotificationBadge();
                    }
                })
                .catch(function() {});
        }

        function toggleTheme() {
            var isDark = document.body.classList.toggle('dark-mode');
            var toggle = document.getElementById('themeToggle');
            if (toggle) toggle.classList.toggle('active', isDark);
            localStorage.setItem('campus_theme', isDark ? 'dark' : 'light');
        }

        function openCreatePostModal() {
            var modal = document.getElementById('createPostModal');
            if (modal) modal.style.display = 'flex';
        }

        function closeCreatePostModal() {
            var modal = document.getElementById('createPostModal');
            if (modal) modal.style.display = 'none';
            
            // Reset form
            document.getElementById('announcementTitle').value = '';
            document.getElementById('announcementContent').value = '';
            document.getElementById('announcementCategory').value = 'General';
            document.getElementById('announcementImageFile').value = '';
            document.getElementById('imagePreview').style.display = 'none';
            
            // Reset modal title and button
            var modalTitle = document.querySelector('#createPostModal .modal-title');
            if (modalTitle) modalTitle.textContent = 'Create New Announcement';
            
            var publishBtn = document.querySelector('.btn-publish');
            if (publishBtn) {
                publishBtn.innerHTML = '<i class="fas fa-paper-plane"></i> Publish';
                publishBtn.onclick = publishAnnouncement;
            }
        }

        function openProfileModal() {
            var modal = document.getElementById('profileModal');
            if (modal) modal.style.display = 'flex';
        }

        function closeProfileModal() {
            var modal = document.getElementById('profileModal');
            if (modal) modal.style.display = 'none';
        }

        function openAboutModal() {
            var modal = document.getElementById('aboutModal');
            if (modal) modal.style.display = 'flex';
        }

        function closeAboutModal() {
            var modal = document.getElementById('aboutModal');
            if (modal) modal.style.display = 'none';
        }

        function logout() {
            window.location.href = 'Logout.aspx';
        }

        function handleLogout() {
            window.location.href = 'Logout.aspx';
        }

        function navigateWithFlip(url) {
            var shell = document.querySelector('.app-shell') || document.body;
            shell.classList.add('page-flip-out');
            setTimeout(function() { window.location.href = url; }, 180);
        }

        // Close modals on backdrop click
        document.addEventListener('click', function(e) {
            var createModal = document.getElementById('createPostModal');
            if (createModal && e.target === createModal) createModal.style.display = 'none';
            var profileModal = document.getElementById('profileModal');
            if (profileModal && e.target === profileModal) profileModal.style.display = 'none';
            var aboutModal = document.getElementById('aboutModal');
            if (aboutModal && e.target === aboutModal) aboutModal.style.display = 'none';
            
            var bell = document.querySelector('.notification-bell');
            var dropdown = document.getElementById('notificationDropdown');
            if (bell && dropdown && !bell.contains(e.target) && !dropdown.contains(e.target)) {
                dropdown.classList.remove('show');
            }
        });

        // Initialize on load
        document.addEventListener('DOMContentLoaded', function() {
            var isDark = localStorage.getItem('campus_theme') === 'dark';
            document.body.classList.toggle('dark-mode', isDark);
            var toggle = document.getElementById('themeToggle');
            if (toggle) toggle.classList.toggle('active', isDark);
            
            renderAnnouncements();
            loadAnnouncementsFromDB();

            var shell = document.querySelector('.app-shell') || document.body;
            shell.classList.add('page-flip-in');
            shell.addEventListener('animationend', function() {
                shell.classList.remove('page-flip-in');
            }, { once: true });
        });

        // ── Load Notifications from Database ──────────────────
        function loadNotificationsFromDB() {
            fetch('NotificationHandler.ashx?action=getUnread', { credentials: 'same-origin' })
                .then(function(r) { return r.json(); })
                .then(function(res) {
                    if (res.ok) {
                        var badge = document.getElementById('notificationBadge');
                        if (badge) {
                            if (res.count > 0) {
                                badge.textContent = res.count;
                                badge.style.display = 'flex';
                            } else {
                                badge.style.display = 'none';
                            }
                        }
                    }
                })
                .catch(function(err) {
                    console.error('Could not load notifications:', err);
                });
        }

        // ── Sync pins from Student/Search pages ───────────────
        window.addEventListener('storage', function(e) {
            if (e.key === 'campus_pins' || e.key === 'teacher_pins') {
                var tp = ST.get('teacher_pins') || {};
                var cp = ST.get('campus_pins')  || {};
                var merged = Object.assign({}, cp, tp);
                Object.keys(merged).forEach(function(k) { if (!/^\d+$/.test(k)) delete merged[k]; });
                st_pins = merged;
                renderAnnouncements();
            }
            if (e.key === 'campus_notifications') {
                var notifs = JSON.parse(e.newValue || '[]');
                var count = notifs.filter(function(n) { return !n.read; }).length;
                var badge = document.getElementById('notificationBadge');
                if (badge) {
                    badge.textContent = count;
                    badge.style.display = count > 0 ? 'inline-block' : 'none';
                }
            }
        });

        // -- Init notification badge on load -------------------
        (function() {
            var notifs = JSON.parse(localStorage.getItem('campus_notifications') || '[]');
            var count = notifs.filter(function(n) { return !n.read; }).length;
            var badge = document.getElementById('notificationBadge');
            if (badge) {
                badge.textContent = count;
                badge.style.display = count > 0 ? 'inline-block' : 'none';
            }
        })();
    </script>
</body>
</html>