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
        }

        html, body, form { height: 100%; }
        html, body { overflow: hidden; }

        body {
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            color: var(--page-text);
            background-image: linear-gradient(rgba(255,255,255,0.3), rgba(255,255,255,0.3)), var(--bg-image);
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

        /* ── HEADER ── */
        .header {
            flex: 0 0 auto;
            background: var(--surface);
            backdrop-filter: blur(10px);
            border-radius: 24px;
            padding: 12px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            border: 1.5px solid rgba(26,58,92,0.25);
            flex-wrap: wrap;
            gap: 15px;
        }

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
        .logo i { margin-right: 8px; }

        .search-btn {
            background: none;
            border: 2px solid #0F172A;
            border-radius: 30px;
            padding: 10px 22px;
            color: #0F172A;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .search-btn:hover {
            background: #e8f0fe;
            border-color: rgba(26,58,92,0.4);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        .header-actions {
            display: flex;
            gap: 15px;
            align-items: center;
            justify-content: center;
            gap: 12px;
            gap: 12px;

        .post-announcement-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(26,58,92,0.3);
            background: linear-gradient(135deg, #234f78, #3a6f94);
        }

        /* Notification Bell */

        .post-announcement-btn:hover {
            cursor: pointer;
            background: var(--surface-soft);
            width: 42px;
            height: 42px;

        /* Notification Bell */
        .notification-bell {
            position: relative;
            border: 1px solid #dce4ec;
            transition: background 0.3s;
            width: 42px;

        .notification-bell:hover {
            background: #e8f0fe;
        }

        .bell-icon {
            font-size: 20px;
            color: #1a3a5c;
        }

            align-items: center;
            justify-content: center;
            border: 1px solid #dce4ec;
            transition: background 0.3s;
        }

        .notification-bell:hover {
            background: #e8f0fe;
        }

        .bell-icon {
            font-size: 20px;
            color: #1a3a5c;
        }

        .badge-red {
            background: var(--surface-soft);
            padding: 6px 18px;
            right: -5px;
            border: 1px solid #dce4ec;
            color: #ffffff;

            font-weight: bold;
            width: 36px;
            height: 36px;
            min-width: 18px;
        }
        .user-info {
            display: flex;
            font-weight: bold;
            gap: 12px;
            background: var(--surface-soft);
            padding: 6px 18px;
            border-radius: 40px;
        .user-name { font-size: 14px; font-weight: 600; }
        .user-role, .profile-email, .post-meta, .comment-time, .footer { color: var(--muted); }

        /* ── CONTENT SHELL ── */
        .content-shell {
            flex: 1 1 0;
            min-height: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            align-items: stretch;
        .user-name { font-weight: 700; font-size: 14px; }
        .user-role { font-size: 11px; color: var(--muted); }
        .sidebar { height: 100%; min-height: 0; overflow: hidden; }

        .user-role, .profile-email, .post-meta, .comment-time, .footer { color: var(--muted); }
            background: var(--surface);
            backdrop-filter: blur(10px);
            border-radius: 24px;
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            overflow: hidden;
            grid-template-columns: 300px minmax(0, 1fr);

        .sidebar .card, .main-panel.card {
            height: 100%;
            min-height: 100%;
            display: flex;
            flex-direction: column;
        }

        .sidebar-content { min-height: 0; overflow-y: auto; }

            border-radius: 24px;
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            overflow: hidden;
            color: var(--primary);
            font-size: 16px;
        .sidebar .card, .main-panel.card {

        .card-header i {
            margin-right: 10px;
            color: #1a3a5c;
        }

        /* Profile Section */
        }
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
    margin: 0 auto 12px;
    font-size: 28px;
}

        .sidebar-toggle {
            border: none;
            background: none;
            color: var(--primary);
            font-size: 22px;
            cursor: pointer;
            transition: all 0.3s;
        }


        .menu-item:hover, .settings-item:hover, .dropdown-item:hover, .action-btn:hover {
            background: var(--surface-soft);
            color: var(--primary);
        }

        .dropdown-icon {
            margin-left: auto;
            font-size: 12px;
            color: var(--muted-light);
            transition: transform 0.3s ease;
        }

        .menu-item.open .dropdown-icon { transform: rotate(180deg); }

            transition: all 0.3s;
            border-left: 3px solid transparent;
        }

        .menu-item:hover, .settings-item:hover, .dropdown-item:hover, .action-btn:hover {
            background: var(--surface-soft);
            color: var(--primary);
        }

        .dropdown-icon {
            margin-left: auto;
            font-size: 12px;
            color: var(--muted-light);
            transition: transform 0.3s ease;
            transition: all 0.3s;
        }


        .dropdown-content {
            margin-left: 45px;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease;
        }
            flex-shrink: 0;
            display: block;

        .toggle-switch.active { background: linear-gradient(135deg, var(--primary), var(--primary-2)); }

            background: none;
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
            margin-left: auto;
        .toggle-switch.active::after { left: 24px; }

        /* ── MAIN PANEL ── */
       .main-panel {
    height: 100%;
    min-width: 0;
    min-height: 0;
    display: flex;
    flex-direction: column;
    gap: 12px;
}
            position: absolute;
        /* Announcement Cards */
            left: 2px;
            flex: 1 1 auto;
            min-height: 0;
            overflow-y: auto;
            padding: 18px;
            background: rgba(248, 250, 252, 0.35);


       .main-panel {
            background: var(--surface-strong);
            border-radius: 20px;
            margin-bottom: 20px;
            border: 1px solid rgba(26, 58, 92, 0.08);
            transition: all 0.3s;
            box-shadow: 0 2px 8px rgba(0,0,0,0.03);
            overflow: hidden;


        .announcement-card:hover {
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            border-color: rgba(26,58,92,0.35);
        }

            background: rgba(248, 250, 252, 0.35);
        }

            padding: 18px 22px 12px;
            background: var(--surface-strong);

        .post-header-left { display: flex; align-items: center; gap: 15px; }

            transition: all 0.3s;
            width: 50px;
            height: 50px;
        }

        .announcement-card:hover {
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            font-size: 20px;
            font-weight: bold;
            flex-shrink: 0;
        .post-header {

        .post-author { font-weight: 700; font-size: 16px; }

        .post-meta {
            display: flex;
            gap: 12px;
            font-size: 12px;
            margin-top: 4px;
            flex-wrap: wrap;
        }

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

        .post-image { margin-top: 12px; border-radius: 16px; overflow: hidden; max-width: 100%; }
        .post-image img { width: 100%; max-height: 300px; object-fit: cover; border-radius: 16px; display: block; }

            color: var(--muted-light);
            padding: 8px;
            gap: 20px;
            padding: 10px 22px;
            border-top: 1px solid #eef2f6;
            border-bottom: 1px solid #eef2f6;
            color: var(--muted);

        .pin-btn-top:hover { background: #f0f2f5; }

        .post-stats span { display: flex; align-items: center; gap: 6px; cursor: pointer; }
        .post-stats span:hover { color: var(--primary); }

        .action-buttons { display: flex; gap: 5px; padding: 8px 22px; }

        .post-image { margin-top: 12px; border-radius: 16px; overflow: hidden; max-width: 100%; }
        .post-image img { width: 100%; max-height: 300px; object-fit: cover; border-radius: 16px; display: block; }

        .post-stats {
            display: flex;
            gap: 20px;
            padding: 10px 22px;
            font-size: 14px;
            color: #5a6e7c;
            color: var(--muted);
            font-size: 13px;
        }

            transition: all 0.3s;
        }

        .action-btn.liked { color: #dc2626; }
        .action-btn.liked i { font-weight: 900; }
        .action-btn {
            flex: 1;
            padding: 0 22px 18px;
            border-top: 1px solid #eef2f6;
            padding: 10px;
            border-radius: 40px;

        .comments-section.show { display: block; }

        .comment-input { display: flex; gap: 10px; margin: 15px 0; }

            justify-content: center;
            gap: 8px;
            padding: 10px 16px;
            background: var(--surface-soft);
            border: 1px solid #dce4ec;
            border-radius: 30px;
        .action-btn.liked i { font-weight: 900; }
            font-size: 13px;
        .comments-section {
            padding: 0 22px 18px;
            padding: 10px 22px;
            background: linear-gradient(135deg, var(--primary), var(--primary-2));
        }

        .comments-section.show { display: block; }

        .comment-input { display: flex; gap: 10px; margin: 15px 0; }

        .comment-input input {
            flex: 1;
            padding: 10px 16px;
            background: var(--surface-soft);
            border: 1px solid #dce4ec;
            border-radius: 30px;
            outline: none;

        }
        .comment-input button {
            padding: 10px 22px;
            background: linear-gradient(135deg, var(--primary), var(--primary-2));
            border: none;
            padding: 0 24px;
            border-radius: 40px;
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
            background: #e8f0fe;
            border-radius: 50%;
            display: flex;
            align-items: center;
        /* Notification Dropdown */
            font-size: 12px;
            color: var(--primary);
            top: 84px;
            right: 20px;
        }
            background: var(--surface-strong);
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            border: 1px solid var(--border);
            padding: 15px;
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

        .notification-list { max-height: 350px; overflow-y: auto; }

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

        .notification-dot { width: 8px; height: 8px; background: #dc2626; border-radius: 50%; }
        .notification-time { font-size: 10px; color: var(--muted-light); }

        /* ── MODAL ── */
        .notification-list { max-height: 350px; overflow-y: auto; }

        .notification-item {
            inset: 0;
            width: 100%;
            height: 100%;
            padding: 12px 18px;
            border-bottom: 1px solid #eef2f6;
            cursor: pointer;
            padding: 20px;

        .notification-item:hover { background: var(--surface-soft); }
            background: var(--surface-strong);
            border-radius: 24px;
            max-width: 400px;
            width: 100%;
            padding: 30px;
            text-align: center;
        .modal {
            display: none;
            position: fixed;
        .modal-icon { font-size: 50px; color: var(--primary); margin-bottom: 15px; }
        .modal-title { font-size: 24px; font-weight: 700; margin-bottom: 10px; }
        .modal-text { margin: 15px 0; font-size: 13px; }
            background: rgba(0,0,0,0.5);
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
        /* footer removed - no footer element */

        .modal-icon { font-size: 50px; color: var(--primary); margin-bottom: 15px; }
        .modal-title { font-size: 24px; font-weight: 700; margin-bottom: 10px; }
        .modal-text { margin: 15px 0; font-size: 13px; }

        .modal-close {
            background: none;
            border: 2px solid #0F172A;
            border-radius: 30px;
            padding: 10px 22px;
            color: #0F172A;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .modal-close:hover {
            background: #e8f0fe;
            border-color: rgba(26,58,92,0.4);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        /* ── FOOTER ── */
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

        /* ── SIDEBAR COLLAPSED ── */
        .sidebar.collapsed { width: 88px; }
        .sidebar.collapsed .profile-name,
        .sidebar.collapsed .profile-email,
        .sidebar.collapsed .card-header,
        .sidebar.collapsed .menu-text,
        .sidebar.collapsed .settings-text,
        .sidebar.collapsed .dropdown-content { display: none; }
        .sidebar.collapsed .menu-item,
        .sidebar.collapsed .settings-item,
        .dark-mode .search-btn, .dark-mode .modal-close {
            border-color: rgba(255,255,255,0.08);
            color: #ffffff;
            background: transparent;
        }

        .dark-mode .search-btn:hover, .dark-mode .modal-close:hover {
            background: rgba(255,255,255,0.04);
            box-shadow: none;
            transform: translateY(0);
        }

        .dark-mode .comment-input button { background: linear-gradient(135deg, var(--primary), var(--primary-2)); }
        .dark-mode .notification-bell { border-color: var(--border); }
        .dark-mode .user-info { border-color: var(--border); }
        .dark-mode .card-header { border-bottom-color: rgba(255,255,255,0.04); }
        .dark-mode .post-stats { border-top-color: rgba(255,255,255,0.04); border-bottom-color: rgba(255,255,255,0.04); }
        .dark-mode .comment { border-bottom-color: rgba(255,255,255,0.03); }
        .dark-mode .notification-header { border-bottom-color: rgba(255,255,255,0.04); }
        .dark-mode .comment-input input { border-color: rgba(255,255,255,0.06); background: var(--surface-soft); color: var(--page-text); }
        .dark-mode .create-post-input { background: var(--surface-soft); border-color: rgba(255,255,255,0.06); color: var(--muted); }
        .dark-mode .announcement-board { background: rgba(18, 22, 28, 0.28); }
        .dark-mode .notification-item.unread,
        .dark-mode .menu-item.active,
        .dark-mode .settings-item.active { background: rgba(64, 96, 128, 0.36); }

        .dark-mode .logo, .dark-mode .logo i, .dark-mode .card-header, .dark-mode .card-header i,
        .dark-mode .profile-name, .dark-mode .post-author, .dark-mode .post-title, .dark-mode .modal-title,
        .dark-mode .user-name, .dark-mode .user-role, .dark-mode .profile-email, .dark-mode .menu-item,
        .dark-mode .settings-item, .dark-mode .dropdown-item, .dark-mode .header-filter,
        .dark-mode .post-stats, .dark-mode .post-stats span, .dark-mode .action-btn,
        .dark-mode .comment-author, .dark-mode .comment-avatar, .dark-mode .bell-icon,
        .dark-mode .notification-header, .dark-mode .notification-header button,
        .dark-mode .sidebar-toggle, .dark-mode .dropdown-icon,
        .dark-mode .no-comments, .dark-mode .footer { color: #ffffff; }

        .dark-mode .menu-item:hover, .dark-mode .settings-item:hover,
        .dark-mode .dropdown-item:hover, .dark-mode .post-stats span:hover,
        .dark-mode .action-btn:hover { color: #ffffff; }

        .dark-mode .pin-btn-top:hover, .dark-mode .action-btn:hover { background: rgba(255,255,255,0.06); }

        /* ── RESPONSIVE ── */
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

        .dark-mode .menu-item:hover, .dark-mode .settings-item:hover,
        .dark-mode .dropdown-item:hover, .dark-mode .post-stats span:hover,
        .dark-mode .action-btn:hover { color: #ffffff; }

        .dark-mode .pin-btn-top:hover, .dark-mode .action-btn:hover { background: rgba(255,255,255,0.06); }

        /* ── RESPONSIVE ── */
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
        <div class="app-shell">

            <!-- ── HEADER ── -->
            <div class="header">
                <div class="logo">
                    <i class="fas fa-chalkboard-teacher"></i> CampusConnect Teacher
                </div>

                <div class="search-container">
                    <asp:Button ID="searchButton" runat="server" CssClass="search-btn"
                        Text=" 🔎 Search........" OnClick="SearchButton_Click"
                        Width="420px" Font-Bold="False" ForeColor="#0F172A"
                        Font-Size="Medium" Height="54px" />
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
                            <div class="user-name" id="userName">Mariia Santos</div>
                            <div class="user-role" id="userRole">Teacher</div>
                        </div>
                    </div>
                </div>
            </div>
                </div>
            <!-- ── NOTIFICATION DROPDOWN ── -->
            <div id="notificationDropdown" class="notification-dropdown">
                <div class="notification-header">
                    <a href="Notifications.aspx" style="text-decoration:none;color:inherit;">
                        <span><i class="fas fa-bell"></i> Notifications</span>
                    </a>
                    <button type="button" onclick="markAllRead()">Mark all read</button>
                </div>
                <div class="notification-list" id="notificationList">
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
                </div>
            <!-- ── CONTENT SHELL ── -->
            <div class="content-shell">

                <!-- ── SIDEBAR ── -->
                <aside class="sidebar">
                    <div class="card">
                        <div class="sidebar-content">
                            <div class="profile-section">
                                <button type="button" class="sidebar-toggle" onclick="toggleSidebar()">
                                    <i class="fas fa-bars"></i>
                                </button>
                                <div class="profile-name" id="profileName">Maria Santos</div>
                                <div class="profile-email" id="profileEmail">maria.santos@ctu.edu.ph</div>
                            </div>
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
                                <div class="profile-name" id="profileName">Maria Santos</div>
                            <button type="button" class="menu-item" onclick="window.location.href='Pinned.aspx'">
                                <i class="fas fa-thumbtack"></i>
                                <span class="menu-text">Pinned Announcements</span>
                            </button>

                            <div class="card-header" style="margin-top:5px;">
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
                            <button type="button" class="settings-item" onclick="toggleTheme(this)">
                <!-- ── MAIN PANEL ── -->
                <main class="main-panel">
    <!-- Post Announcement Button -->
    <button type="button" class="post-announcement-btn" onclick="openCreatePostModal()">
        <i class="fas fa-plus-circle"></i> Want to post an announcement?
    </button>
                                <i class="fas fa-info-circle"></i>
    <!-- Create Post Box -->
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
                <!-- ── MAIN PANEL ── -->
    <!-- Announcement Board Card (scrolls independently) -->
    <div class="card" style="flex:1 1 0; min-height:0; display:flex; flex-direction:column;">
       <div class="card-header" style="flex-shrink:0; position:relative;">
    <i class="fas fa-bullhorn"></i> Announcement Board
    <span class="header-filter" onclick="toggleFilterDropdown()" style="cursor:pointer; float:right; font-size:12px; color:var(--primary); display:flex; align-items:center; gap:6px; float:right;">
        Showing: <strong id="activeFilterLabel">All</strong> <i class="fas fa-chevron-down" id="filterChevron" style="font-size:10px;"></i>
    </span>
    <div id="filterDropdown" style="
        display:none;
        position:absolute;
        top:52px;
        right:18px;
        background:var(--surface-strong);
        border:1px solid var(--border);
        border-radius:14px;
        box-shadow:0 8px 24px rgba(0,0,0,0.12);
        z-index:100;
        min-width:180px;
        overflow:hidden;
    ">
        <button type="button" onclick="filterCategory('All')"       class="filter-option">All Announcements</button>
        <button type="button" onclick="filterCategory('Exam')"      class="filter-option">Exam Schedule</button>
        <button type="button" onclick="filterCategory('Suspension')" class="filter-option">Class Suspension</button>
        <button type="button" onclick="filterCategory('Event')"     class="filter-option">Campus Events</button>
    </div>
</div>
        <!-- Scrollable Announcements -->
        <div id="announcementsContainer" class="announcement-board">
        top:52px;
                            <!-- Announcement 1 - Exam -->
                            <div class="announcement-card" data-category="Exam" data-post-id="1">
                                <div class="post-header">
                                    <div class="post-header-left">
                                        <div class="post-avatar"><i class="fas fa-user-tie"></i></div>
                                        <div>
                                            <div class="post-author">Prof. Michael Reyes</div>
                                            <div class="post-meta">
                                                <span><i class="far fa-calendar-alt"></i> December 10, 2024</span>
                                                <span><i class="far fa-clock"></i> 9:00 AM</span>
                                                <span class="post-category post-category-exam">Exam</span>
                                            </div>
                                        </div>
                                    </div>
                                    <button type="button" class="pin-btn-top pinned" onclick="togglePinTop(this)"><i class="fas fa-thumbtack"></i></button>
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
                                    <button type="button" class="action-btn" onclick="toggleLike(this)"><i class="far fa-heart"></i> Like</button>
                                    <button type="button" class="action-btn" onclick="toggleComments(this)"><i class="far fa-comment"></i> Comment</button>
                                    <button type="button" class="action-btn" onclick="sharePost()"><i class="fas fa-share"></i> Share</button>
                                </div>
                                <div class="comments-section">
                                    <div class="comment-input">
                                        <input type="text" placeholder="Write a comment..." />
                                        <button type="button" onclick="addComment(this)">Post</button>
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
                                </div>
                                <div class="comments-section">
                                    <div class="comment-input">
                                        <input type="text" placeholder="Write a comment..." />
                                        <button type="button" onclick="addComment(this)">Post</button>
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
                                        <div class="post-avatar"><i class="fas fa-building"></i></div>
                                        <div>
                                            <div class="post-author">Admin Office</div>
                                            <div class="post-meta">
                                                <span><i class="far fa-calendar-alt"></i> November 24, 2024</span>
                                                <span><i class="far fa-clock"></i> 6:00 AM</span>
                                                <span class="post-category post-category-suspension">Suspension</span>
                                            </div>
                                        </div>
                                    </div>
                                    <button type="button" class="pin-btn-top pinned" onclick="togglePinTop(this)"><i class="fas fa-thumbtack"></i></button>
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
                                    <button type="button" class="action-btn" onclick="toggleLike(this)"><i class="far fa-heart"></i> Like</button>
                                    <button type="button" class="action-btn" onclick="toggleComments(this)"><i class="far fa-comment"></i> Comment</button>
                                    <button type="button" class="action-btn" onclick="sharePost()"><i class="fas fa-share"></i> Share</button>
                                </div>
                            <!-- Announcement 3 - Event -->
                            <div class="announcement-card" data-category="Event" data-post-id="3">
                                <div class="post-header">
                                    <div class="post-header-left">
                                        <div class="post-avatar"><i class="fas fa-calendar-alt"></i></div>
                                        <div>
                                            <div class="post-author">Student Affairs Office</div>
                                            <div class="post-meta">
                                                <span><i class="far fa-calendar-alt"></i> November 20, 2024</span>
                                                <span><i class="far fa-clock"></i> 10:00 AM</span>
                                                <span class="post-category post-category-event">Event</span>
                                            </div>
                                        </div>
                                    </div>
                                    <button type="button" class="pin-btn-top" onclick="togglePinTop(this)"><i class="fas fa-thumbtack"></i></button>
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
                                    <button type="button" class="action-btn" onclick="toggleLike(this)"><i class="far fa-heart"></i> Like</button>
                                    <button type="button" class="action-btn" onclick="toggleComments(this)"><i class="far fa-comment"></i> Comment</button>
                                    <button type="button" class="action-btn" onclick="sharePost()"><i class="fas fa-share"></i> Share</button>
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
                    </div>
                </main>
            </div>
        </div>
                                    <button type="button" class="action-btn" onclick="sharePost()"><i class="fas fa-share"></i> Share</button>
        <!-- About Modal -->
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
                    </div>
                </main>
            </div>
        </div>

        <!-- About Modal -->
        <div id="aboutModal" class="modal">
            <div class="modal-content">
                <div class="modal-icon"><i class="fas fa-university"></i></div>
                <div class="modal-title">Campus Connect</div>
                <div class="modal-text">
                    Campus Connect is a centralized web-based announcement system for Cebu Technological University.
                    It allows teachers to post official announcements, exam schedules, class suspensions, and campus events.
                </div>
                <button type="button" class="modal-close" onclick="closeAboutModal()">Close</button>
            </div>
        </div>
    </form>

    <script>

        // ── DARK MODE ──────────────────────────────────────────────
        function toggleTheme(item) {
            var isDark = document.body.classList.toggle('dark-mode');
            var toggle = document.getElementById('themeToggle');
            if (toggle) toggle.classList.toggle('active', isDark);
            localStorage.setItem('theme', isDark ? 'dark' : 'light');
        }

        (function initTheme() {
            if (localStorage.getItem('theme') === 'dark') {
                document.body.classList.add('dark-mode');
                document.addEventListener('DOMContentLoaded', function () {
                    var toggle = document.getElementById('themeToggle');
                    if (toggle) toggle.classList.add('active');
                });
            }
        })();
        // ──────────────────────────────────────────────────────────

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

        document.addEventListener('click', function (e) {
            var bell = document.querySelector('.notification-bell');
            var dropdown = document.getElementById('notificationDropdown');
            if (bell && dropdown && !bell.contains(e.target) && !dropdown.contains(e.target)) {
                dropdown.classList.remove('show');
            }
        });
        function toggleFilterDropdown() {
            var dd = document.getElementById('filterDropdown');
            var chevron = document.getElementById('filterChevron');
            var isOpen = dd.style.display === 'block';
            dd.style.display = isOpen ? 'none' : 'block';
            chevron.style.transform = isOpen ? 'rotate(0deg)' : 'rotate(180deg)';
            chevron.style.transition = 'transform 0.3s';
        }

        // Close filter dropdown when clicking outside
        document.addEventListener('click', function (e) {
            var dd = document.getElementById('filterDropdown');
            var trigger = document.querySelector('.header-filter');
            if (dd && trigger && !trigger.contains(e.target) && !dd.contains(e.target)) {
                dd.style.display = 'none';
                var chevron = document.getElementById('filterChevron');
                if (chevron) chevron.style.transform = 'rotate(0deg)';
            }
        });

        function filterCategory(category) {
            var cards = document.querySelectorAll('.announcement-card');
            document.getElementById('activeFilterLabel').innerText = category;
            cards.forEach(function (card) {
                card.style.display = (category === 'All' || card.dataset.category === category) ? 'block' : 'none';
            });

            // highlight active
            document.querySelectorAll('.filter-option').forEach(function (btn) {
                btn.classList.remove('active-filter');
                if (btn.textContent.trim().startsWith(category) || (category === 'All' && btn.textContent.trim() === 'All Announcements')) {
                    btn.classList.add('active-filter');
                }
            });

            // close both dropdowns
            var dd = document.getElementById('filterDropdown');
            if (dd) dd.style.display = 'none';
            var chevron = document.getElementById('filterChevron');
            if (chevron) chevron.style.transform = 'rotate(0deg)';
            var catDd = document.getElementById('categoryDropdown');
            if (catDd) catDd.style.maxHeight = '0px';
        }

        function toggleLike(btn) {
            btn.classList.toggle('liked');
            btn.innerHTML = btn.classList.contains('liked')
                ? '<i class="fas fa-heart"></i> Liked'
                : '<i class="far fa-heart"></i> Like';
            var card = btn.closest('.announcement-card');
            var likeCount = card.querySelector('.like-count');
            likeCount.innerText = btn.classList.contains('liked')
                ? parseInt(likeCount.innerText) + 1
                : parseInt(likeCount.innerText) - 1;
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
            if (!comment) { showToast('Please enter a comment!'); return; }
            var card = btn.closest('.announcement-card');
            var list = card.querySelector('.comments-list');
            var noComments = list.querySelector('.no-comments');
            if (noComments) noComments.remove();
            var newComment = document.createElement('div');
            newComment.className = 'comment';
            newComment.innerHTML =
                '<div class="comment-avatar"><i class="fas fa-user"></i></div>' +
                '<div class="comment-content">' +
                '<span class="comment-author">You</span>' +
                '<div class="comment-text">' + comment.replace(/</g, '&lt;') + '</div>' +
                '<div class="comment-time">Just now</div>' +
                '</div>';
            list.appendChild(newComment);
            var count = card.querySelector('.comment-count');
            count.innerText = parseInt(count.innerText) + 1;
            input.value = '';
            showToast('Comment posted!');
        }

        function sharePost() { showToast('Share feature coming soon!'); }

        function togglePinTop(btn) {
            btn.classList.toggle('pinned');
            showToast(btn.classList.contains('pinned') ? 'Announcement pinned!' : 'Announcement unpinned!');
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
            badge.innerText = count;
            badge.style.display = count > 0 ? 'inline-block' : 'none';
        }

        function showToast(message) {
            var toast = document.createElement('div');
            toast.style.cssText = 'position:fixed;bottom:20px;right:20px;background:#1a3a5c;color:white;padding:12px 24px;border-radius:30px;font-size:14px;z-index:9999;box-shadow:0 4px 12px rgba(0,0,0,0.3);';
            toast.innerHTML = message;
            document.body.appendChild(toast);
            setTimeout(function () {
                toast.style.opacity = '0';
                toast.style.transition = 'opacity 0.3s';
                setTimeout(function () { toast.remove(); }, 300);
            }, 2000);
        }

        function openAboutModal() { document.getElementById('aboutModal').style.display = 'flex'; }
        function closeAboutModal() { document.getElementById('aboutModal').style.display = 'none'; }
        function openCreatePostModal() { showToast('Create post feature coming soon!'); }

        function logout() {
            if (confirm('Are you sure you want to logout?')) {
                window.location.href = 'login.aspx';
            }
        }

    </script>
>>>>>>> fa6f73f1f4eefd367af5254f688c3ed50e2751ff
</body>
</html>