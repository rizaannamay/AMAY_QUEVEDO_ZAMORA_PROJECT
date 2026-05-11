<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Student" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Campus Announcement Portal - Student Portal</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
<link rel="stylesheet" href="dark-mode.css" />
<link rel="stylesheet" href="responsive.css" />
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }
:root {
    --bg-image: url('wbg.jpg');
    --uni-overlay: rgba(255,255,255,0);
    --uni-header-bg: #c9920a;
    --uni-accent: #c9920a;
    --uni-accent-dark: #a87800;
    --page-text: #1a2a3a;
    --surface: rgba(255, 255, 255, 0.92);
    --surface-strong: #ffffff;
    --surface-soft: #f8fafc;
    --border: rgba(26, 58, 92, 0.12);
    --primary: #1a2a3a;
    --primary-2: #a87800;
    --muted: #6b7c8f;
    --muted-light: #9db0c4;
    --shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
    --active-bg: #fef9e7;
}
html, body, form { height: auto; min-height: 100%; }
html, body { overflow: auto; }
body::before {
   display: none;
}
body {
    font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
    color: var(--page-text);
    background-image: var(--bg-image);
    background-size: cover;
    background-repeat: no-repeat;
    background-position: center center;
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
.dashboard-body { display: flex; gap: 16px; align-items: flex-start; flex: 1; }
.header {
    background: var(--uni-header-bg);
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
    top: 10px; left: 10px; right: 10px;
    z-index: 1200;
}
form { height: auto; min-height: 100%; overflow: visible; }
.logo { font-size: 22px; font-weight: 800; color: var(--primary); white-space: nowrap; cursor: pointer; background: none; border: none; }
.logo i { color: var(--primary); margin-right: 8px; }
.search-container {
    display: flex; gap: 10px; align-items: center;
    flex: 1; justify-content: center; min-width: 0; overflow: hidden;
    position: relative; top: 1px; left: 0px; height: 54px;
}
.search-box { background: var(--surface-soft); border-radius: 30px; padding: 10px 18px; width: min(100%, 320px); display: flex; align-items: center; gap: 10px; border: 1px solid rgba(26,58,92,0.2); }
.search-box input { background: none; border: none; outline: none; width: 100%; font-size: 14px; color: var(--page-text); }
.search-box input::placeholder { color: var(--muted-light); }
.search-box i, .bell-icon { color: var(--primary); }
.search-btn {
    background: none;
    border: 1px solid rgba(26,58,92,0.25);
    border-radius: 30px; padding: 10px 22px;
    color: var(--primary); font-weight: 600; cursor: pointer;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
    width: 100%; max-width: 340px;
    white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
    position: relative; z-index: 1;
}
.search-btn::before { font-family: "Font Awesome 6 Free"; font-weight: 900; content: "\f002"; margin-right: 8px; }
.search-btn:hover { border-color: rgba(26,58,92,0.4); transform: translateY(-1px); box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
.header-actions { display: flex; gap: 15px; align-items: center; white-space: nowrap; position: relative; z-index: 2; flex-shrink: 0; }
.notification-bell { position: relative; cursor: pointer; background: var(--surface-soft); width: 42px; height: 42px; border-radius: 50%; display: flex; align-items: center; justify-content: center; border: 1px solid rgba(26,58,92,0.15); transition: background 0.3s; }
.notification-bell:hover { background: var(--active-bg); }
.badge-red { position: absolute; top: -5px; right: -5px; background: #dc2626; color: #ffffff; font-size: 10px; font-weight: bold; padding: 2px 6px; border-radius: 50%; min-width: 18px; text-align: center; }
.user-info { display: flex; align-items: center; gap: 12px; background: rgba(255,255,255,0.85); padding: 6px 18px; border-radius: 40px; border: 1.5px solid rgba(26,58,92,0.18); cursor: pointer; position: relative; transition: background 0.2s; }
.user-info:hover { background: rgba(255,255,255,1); }
.slideout-panel { position: fixed; top: 120px; left: 10px; width: 260px; height: calc(100vh - 130px); backdrop-filter: blur(16px); box-shadow: 4px 0 24px rgba(0,0,0,0.08); z-index: 1100; display: flex; flex-direction: column; border-radius: 16px; overflow: hidden; }
.panel-header { padding: 24px 16px 16px; border-bottom: 1px solid var(--border); display: flex; align-items: center; }
.panel-header h3 { font-size: 18px; font-weight: 700; color: var(--primary); margin: 0; }
.panel-menu-list { flex: 1; overflow-y: auto; padding: 12px 0; }
.panel-menu-item { display: flex; align-items: center; gap: 12px; padding: 12px 20px; cursor: pointer; width: 100%; border: none; background: none; text-align: left; font-size: 14px; font-weight: 500; color: var(--page-text); transition: all 0.2s; border-left: 3px solid transparent; }
.panel-menu-item i { width: 20px; font-size: 16px; color: var(--uni-accent); }
.panel-menu-item:hover { background: #fef9e7; color: #92650a; border-left-color: var(--uni-accent); }
.panel-menu-item.active { background: linear-gradient(135deg, var(--uni-accent-dark), var(--uni-accent)); color: #ffffff; border-left-color: transparent; }
.panel-menu-item.active i { color: #ffffff; }
.category-dropdown-panel { margin-left: 44px; margin-bottom: 8px; display: none; flex-direction: column; gap: 4px; }
.dropdown-item-panel { background: none; border: none; text-align: left; padding: 7px 10px; cursor: pointer; width: 100%; font-size: 13px; color: var(--page-text); border-radius: 10px; transition: all 0.2s; }
.dropdown-item-panel i { color: var(--uni-accent); }
.dropdown-item-panel:hover { background: var(--surface-soft); color: var(--primary); }
.dropdown-item-panel.active-filter { background: var(--uni-accent); color: #ffffff; font-weight: 700; }
.dropdown-item-panel.active-filter i { color: #ffffff; }
.theme-toggle-row { display: flex; align-items: center; justify-content: space-between; width: 100%; }
.theme-toggle-row .toggle-switch-panel { width: 40px; height: 20px; background: #dce4ec; border-radius: 30px; position: relative; cursor: pointer; transition: all 0.3s; flex-shrink: 0; }
.theme-toggle-row .toggle-switch-panel.active { background: linear-gradient(135deg, var(--uni-accent), var(--uni-accent-dark)); }
.theme-toggle-row .toggle-switch-panel::after { content: ''; width: 16px; height: 16px; background: #ffffff; border-radius: 50%; position: absolute; top: 2px; left: 2px; transition: all 0.3s; }
.theme-toggle-row .toggle-switch-panel.active::after { left: 22px; }
.divider-light { height: 1px; background: var(--border); margin: 6px 16px; }
.overlay-black { display: none !important; pointer-events: none !important; }
.app-shell { padding-left: 286px; }
.avatar, .profile-avatar, .post-avatar { background: linear-gradient(135deg, var(--uni-accent), var(--uni-accent-dark)); color: #ffffff; }
.avatar { width: 36px; height: 36px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; }
.user-name { font-size: 14px; font-weight: 600; }
.user-role, .profile-email, .post-meta, .comment-time { color: var(--muted); }
.content-shell { flex: 1 1 0; min-height: 0; display: grid; grid-template-columns: 1fr; gap: 25px; align-items: stretch; }
.card { background: var(--surface); backdrop-filter: blur(10px); border-radius: 24px; border: 1px solid var(--border); box-shadow: 0 4px 16px rgba(0,0,0,0.12); overflow: visible; }
.main-panel.card { height: calc(100vh - 140px); position: sticky; top: 120px; display: flex; flex-direction: column; overflow: hidden; }
.card-header { padding: 18px 22px; border-bottom: 1px solid rgba(26,58,92,0.08); font-weight: 700; color: var(--primary); font-size: 16px; flex-shrink: 0; border-radius: 24px 24px 0 0; }
.card-header i { margin-right: 10px; color: var(--primary); }
.announcement-board { flex: 1 1 auto; min-height: 0; overflow-y: auto; padding: 18px; background: rgba(248,250,252,0.35); scrollbar-width: none; -ms-overflow-style: none; }
.announcement-board::-webkit-scrollbar { display: none; }

/* ✅ Focus banner — shown when viewing a single post from a notification */
.focus-banner {
    background: linear-gradient(135deg, rgba(201,146,10,0.10), rgba(168,120,0,0.08));
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
    background: linear-gradient(135deg, var(--uni-accent), var(--uni-accent-dark));
    color: #fff;
    border-radius: 999px;
    padding: 10px 16px;
    cursor: pointer;
    font-weight: 700;
    font-size: 14px;
}

.announcement-card { background: var(--surface-strong); border-radius: 20px; margin-bottom: 20px; border: 1px solid var(--uni-accent); transition: all 0.3s; box-shadow: 0 2px 8px rgba(0,0,0,0.03); overflow: hidden; scroll-margin-top: 20px; }
.announcement-card:hover { box-shadow: 0 8px 18px rgba(0,0,0,0.08); border-color: var(--uni-accent-dark); }
.announcement-card.notification-target { border-color: #f59e0b; box-shadow: 0 0 0 3px rgba(245,158,11,0.22), 0 12px 28px rgba(245,158,11,0.18); animation: targetPulse 2s ease-in-out 2; }
@keyframes targetPulse { 0% { transform: scale(1); } 50% { transform: scale(1.01); } 100% { transform: scale(1); } }
.post-header { display: flex; align-items: center; justify-content: space-between; padding: 18px 22px 12px; }
.post-header-left { display: flex; align-items: center; gap: 15px; }
.post-avatar { width: 50px; height: 50px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 20px; font-weight: bold; flex-shrink: 0; }
.post-author { font-weight: 700; font-size: 16px; color: var(--primary); }
.post-meta { display: flex; gap: 12px; font-size: 12px; margin-top: 4px; flex-wrap: wrap; }
.post-category { display: inline-block; padding: 2px 10px; border-radius: 20px; font-size: 10px; font-weight: 600; }
.post-category-exam { background: #fef3c7; color: var(--uni-accent); }
.post-category-suspension { background: #ffebee; color: #c62828; }
.post-category-event { background: #e8f5e9; color: #2e7d32; }
.post-category-general { background: #e0e7ff; color: #4f46e5; }
.pin-btn-top { background: none; border: none; cursor: pointer; font-size: 18px; color: var(--muted-light); padding: 8px; border-radius: 50%; transition: all 0.3s; width: 36px; height: 36px; }
.pin-btn-top:hover { background: #f0f2f5; }
.pin-btn-top.pinned { color: #e65100; }
.post-content { padding: 0 22px 16px; }
.post-title { font-size: 18px; font-weight: 700; margin-bottom: 10px; color: var(--primary); }
.post-text, .comment-text, .notification-text { color: var(--page-text); line-height: 1.5; }
.post-image { margin-top: 12px; border-radius: 16px; overflow: hidden; max-width: 100%; }
.post-image img { width: 100%; max-height: 200px; object-fit: cover; border-radius: 16px; display: block; }
.post-stats { display: flex; gap: 20px; padding: 10px 22px; border-top: 1px solid rgba(26,58,92,0.08); border-bottom: 1px solid rgba(26,58,92,0.08); color: var(--muted); font-size: 13px; }
.post-stats span { display: flex; align-items: center; gap: 6px; cursor: pointer; }
.post-stats span:hover { color: var(--primary); }
.action-buttons { display: flex; gap: 5px; padding: 8px 22px; }
.action-btn { flex: 1; background: none; border: none; padding: 10px; border-radius: 10px; cursor: pointer; font-size: 14px; color: var(--muted); display: flex; align-items: center; justify-content: center; gap: 8px; transition: all 0.3s; }
.action-btn.liked { color: #dc2626; }
.action-btn.liked i { font-weight: 900; }
.comments-section { padding: 0 22px 18px; border-top: 1px solid rgba(26,58,92,0.08); display: none; }
.comments-section.show { display: block; }
.comment-input { display: flex; gap: 10px; margin: 15px 0; }
.comment-input input { flex: 1; padding: 10px 16px; background: var(--surface-soft); border: 1px solid rgba(26,58,92,0.15); border-radius: 30px; outline: none; font-size: 13px; color: var(--page-text); }
.comment-input button { padding: 10px 22px; background: linear-gradient(135deg, var(--uni-accent), var(--uni-accent-dark)); border: none; border-radius: 30px; cursor: pointer; font-weight: 600; color: white; }
.comment { padding: 10px 0; font-size: 13px; border-bottom: 1px solid rgba(26,58,92,0.08); display: flex; gap: 10px; }
.comment:last-child { border-bottom: none; }
.comment-avatar { width: 32px; height: 32px; background: #fef3c7; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 12px; color: var(--primary); font-weight: bold; flex-shrink: 0; }
.comment-author { font-weight: bold; color: var(--primary); }
.no-comments { padding: 15px; text-align: center; color: var(--muted-light); font-size: 12px; }
.notification-dropdown { position: absolute; top: 84px; right: 20px; width: 320px; background: var(--surface-strong); border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.15); border: 1px solid var(--border); z-index: 200; display: none; }
.notification-dropdown.show { display: block; }
.modal { display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.5); z-index: 9000; align-items: center; justify-content: center; padding: 20px; }
.modal-content { background: var(--surface-strong); border-radius: 24px; max-width: 400px; width: 100%; padding: 30px; text-align: center; }
body:not(.dark-mode) .header .logo,
body:not(.dark-mode) .header .logo i,
body:not(.dark-mode) .header .user-name,
body:not(.dark-mode) .header .user-role,
body:not(.dark-mode) .header .bell-icon,
body:not(.dark-mode) .header .search-btn { color: #ffffff; }
body:not(.dark-mode) .header .search-btn { border-color: rgba(255,255,255,0.35); }
body:not(.dark-mode) .header .user-info { background: rgba(255,255,255,0.12); border-color: rgba(255,255,255,0.25); }
body:not(.dark-mode) .header .user-info .user-name,
body:not(.dark-mode) .header .user-info .user-role { color: #ffffff; }
body:not(.dark-mode) .header .user-info:hover { background: rgba(255,255,255,0.2); }
body:not(.dark-mode) .header .notification-bell { background: rgba(255,255,255,0.12); border-color: rgba(255,255,255,0.25); }
body:not(.dark-mode) .header .notification-bell .bell-icon { color: #ffffff; }
body:not(.dark-mode) .header .search-btn:hover { background: rgba(255,255,255,0.18); border-color: rgba(255,255,255,0.6); color: #ffffff; }
.dark-mode {
    --bg-image: url('bg.jpg');
    --page-text: #e4e6eb;
    --surface: rgba(30,41,59,0.95);
    --surface-strong: rgba(30,41,59,0.98);
    --surface-soft: rgba(51,65,85,0.6);
    --border: rgba(148,163,184,0.2);
    --primary: #93c5fd;
    --primary-2: #60a5fa;
    --muted: #cbd5e1;
    --muted-light: #94a3b8;
    --shadow: 0 8px 32px rgba(0,0,0,0.6);
    --active-bg: rgba(59,130,246,0.2);
}
body.dark-mode { background-image: linear-gradient(rgba(18,18,18,0.92), rgba(18,18,18,0.92)), url('bg.jpg'); background-color: #121212; color: var(--page-text); }
body.dark-mode .announcement-card { background: rgba(35,35,35,0.95); border-color: var(--uni-accent); }
body.dark-mode .announcement-card:hover { border-color: var(--uni-accent); background: rgba(35,35,35,1); }
body.dark-mode .announcement-card.notification-target { border-color: var(--uni-accent); box-shadow: 0 0 0 3px rgba(201,146,10,0.25), 0 12px 28px rgba(201,146,10,0.18); }
body.dark-mode .card { background: rgba(30,30,30,0.95); border-color: rgba(255,255,255,0.08); }
body.dark-mode .header { background: var(--uni-header-bg); border-color: rgba(255,255,255,0.08); }
body.dark-mode .post-author, body.dark-mode .post-title { color: #e0e7ff; }
body.dark-mode .post-text, body.dark-mode .comment-text, body.dark-mode .notification-text { color: #e2e8f0; }
body.dark-mode .post-meta, body.dark-mode .post-stats, body.dark-mode .post-stats span, body.dark-mode .action-btn, body.dark-mode .comment-time, body.dark-mode .no-comments { color: #cbd5e1; }
body.dark-mode .comment-author { color: var(--uni-accent); }
body.dark-mode .card-header { color: #ffffff; border-bottom-color: rgba(255,255,255,0.08); }
body.dark-mode .logo { color: #e0e7ff; }
body.dark-mode .user-name { color: #f1f5f9; }
body.dark-mode .user-role { color: #cbd5e1; }
body.dark-mode .modal-content { background: rgba(25,25,25,0.98); border-color: rgba(255,255,255,0.10); }
body.dark-mode .modal-title, body.dark-mode #pm-fullname { color: #e0e7ff; }
body.dark-mode #pm-username, body.dark-mode #pm-email, body.dark-mode #pm-role { color: #e2e8f0; }
body.dark-mode .action-btn.liked { color: #f87171; }
body.dark-mode .pin-btn-top { color: rgba(148,163,184,0.5); }

/* ── University Theme dark mode — announcement card overrides ── */
body.theme-intramurals .announcement-card { background: rgba(20,10,5,0.88) !important; border-color: rgba(255,122,0,0.55) !important; }
body.theme-intramurals .post-author, body.theme-intramurals .post-title { color: #ff9a3c !important; }
body.theme-intramurals .post-text { color: #e0e0e0 !important; }
body.theme-intramurals .post-meta, body.theme-intramurals .action-btn { color: #d1d5db !important; }

body.theme-foundation.dark-mode .announcement-card { background: rgba(30,22,5,0.92) !important; border-color: rgba(234,179,8,0.45) !important; }
body.theme-foundation.dark-mode .post-author, body.theme-foundation.dark-mode .post-title { color: #fbbf24 !important; }
body.theme-foundation.dark-mode .post-text { color: #e0e0e0 !important; }
body.theme-foundation.dark-mode .post-meta, body.theme-foundation.dark-mode .action-btn { color: #d1d5db !important; }

body.theme-womens.dark-mode .announcement-card { background: rgba(20,12,35,0.92) !important; border-color: rgba(126,34,206,0.50) !important; }
body.theme-womens.dark-mode .post-author, body.theme-womens.dark-mode .post-title { color: #c084fc !important; }
body.theme-womens.dark-mode .post-text { color: #e0e0e0 !important; }
body.theme-womens.dark-mode .post-meta, body.theme-womens.dark-mode .action-btn { color: #d1d5db !important; }

body.theme-christmas.dark-mode .announcement-card { background: rgba(5,20,12,0.92) !important; border-color: rgba(21,128,61,0.50) !important; }
body.theme-christmas.dark-mode .post-author, body.theme-christmas.dark-mode .post-title { color: #4ade80 !important; }
body.theme-christmas.dark-mode .post-text { color: #e0e0e0 !important; }
body.theme-christmas.dark-mode .post-meta, body.theme-christmas.dark-mode .action-btn { color: #d1d5db !important; }
body.dark-mode .pin-btn-top.pinned { color: #fb923c; }
body.dark-mode .slideout-panel { background: rgba(20,20,20,0.98); border-color: rgba(148,163,184,0.2); }
body.dark-mode .panel-header h3 { color: #e0e7ff; }
body.dark-mode .panel-menu-item { color: #e2e8f0; }
body.dark-mode .panel-menu-item i { color: var(--uni-accent); }
body.dark-mode .panel-menu-item:hover { background: rgba(59,130,246,0.2); color: #ffffff; border-left-color: var(--uni-accent); }
body.dark-mode .dropdown-item-panel { color: #e2e8f0; }
body.dark-mode .dropdown-item-panel:hover { background: rgba(59,130,246,0.2); color: #ffffff; }
body.dark-mode .divider-light { background: rgba(148,163,184,0.2); }
body.dark-mode .comment-input input { background: rgba(51,65,85,0.6); border-color: rgba(148,163,184,0.3); color: #f1f5f9; }
body.dark-mode .comment-input input::placeholder { color: #94a3b8; }
body.dark-mode .search-box { background: rgba(51,65,85,0.6); border-color: rgba(148,163,184,0.3); }
body.dark-mode .search-box input { color: #f1f5f9; }
body.dark-mode .search-box input::placeholder { color: #94a3b8; }
body.dark-mode .post-category-exam { background: rgba(59,130,246,0.25); color: #93c5fd; }
body.dark-mode .post-category-suspension { background: rgba(239,68,68,0.25); color: #fca5a5; }
body.dark-mode .post-category-event { background: rgba(34,197,94,0.25); color: #86efac; }
body.dark-mode .post-category-general { background: rgba(139,92,246,0.25); color: #c4b5fd; }
body.dark-mode .pin-btn-top.pinned { color: #fb923c; }
body.dark-mode .search-btn { border-color: rgba(148,163,184,0.3); color: #e2e8f0; background: rgba(51,65,85,0.4); }
body.dark-mode .search-btn:hover { background: rgba(201,146,10,0.15); border-color: var(--uni-accent); }
body.dark-mode .notification-bell { background: rgba(45,45,45,0.80); border-color: rgba(255,255,255,0.12); }
body.dark-mode .notification-bell:hover { background: rgba(201,146,10,0.15); }
body.dark-mode .user-info { background: rgba(45,45,45,0.80); border-color: rgba(255,255,255,0.12); }
body.dark-mode .user-info:hover { background: rgba(55,55,55,0.90); }
body.dark-mode .modal-content { background: rgba(25,25,25,0.98); border: 1px solid rgba(255,255,255,0.10); }
body.dark-mode .modal-title { color: #e0e7ff; }
body.dark-mode .modal-text { color: #cbd5e1; }
body.dark-mode .action-btn:hover { background: rgba(201,146,10,0.12); color: var(--uni-accent); }
body.dark-mode .comment-avatar { background: rgba(201,146,10,0.18); color: var(--uni-accent); }
body.dark-mode .post-avatar { background: linear-gradient(135deg, var(--uni-accent), var(--uni-accent-dark)); }
body.dark-mode .announcement-board { background: rgba(18,18,18,0.60); }
body.dark-mode .focus-banner { background: rgba(201,146,10,0.08); border-color: rgba(201,146,10,0.22); }
@media (max-width: 980px) {
    html, body { overflow: auto; }
    .app-shell {
        height: auto !important;
        min-height: 100%;
        overflow: visible !important;
        padding-left: 20px !important;
        padding-top: 120px !important;
        padding-right: 20px !important;
    }
    .slideout-panel { display: none; }
    .dashboard-body { display: block !important; }
    .content-shell { overflow: visible !important; height: auto !important; }
    .main-panel.card {
        height: auto !important;
        min-height: unset !important;
        position: static !important;
        overflow: visible !important;
    }
    /* Break the flex-collapse: announcement-board uses flex:1 1 auto
       which collapses to 0 when parent has no fixed height */
    .announcement-board {
        flex: none !important;
        overflow: visible !important;
        height: auto !important;
        min-height: unset !important;
        max-height: none !important;
    }
}
@media (max-width: 768px) {
    #mobileSearchBtn { display: flex !important; }
    .app-shell {
        padding-left: 12px !important;
        padding-right: 12px !important;
        padding-top: 120px !important;
    }
}

/* ── Calendar panel (Student: view-only) ── */
.cal-overlay { display:none; position:fixed; inset:0; background:rgba(0,0,0,0.55); backdrop-filter:blur(4px); z-index:2000; align-items:center; justify-content:center; padding:20px; }
.cal-overlay.open { display:flex; }
.cal-box { background:var(--surface-strong); border-radius:24px; width:100%; max-width:700px; max-height:88vh; display:flex; flex-direction:column; overflow:hidden; box-shadow:0 24px 60px rgba(0,0,0,0.3); }
.cal-box-header { padding:18px 24px; border-bottom:1px solid var(--border); display:flex; justify-content:space-between; align-items:center; flex-shrink:0; }
.cal-box-header h2 { font-size:18px; font-weight:800; color:var(--primary); margin:0; }
.cal-box-body { flex:1; overflow-y:auto; padding:20px 24px; }
.cal-box-close { background:none; border:none; font-size:22px; cursor:pointer; color:var(--muted); line-height:1; }
.cal-nav { display:flex; align-items:center; justify-content:space-between; margin-bottom:12px; }
.cal-nav-btn { background:none; border:1px solid var(--border); border-radius:50%; width:32px; height:32px; cursor:pointer; font-size:14px; color:var(--primary); display:flex; align-items:center; justify-content:center; }
.cal-nav-btn:hover { background:var(--active-bg); }
.cal-grid { display:grid; grid-template-columns:repeat(7,1fr); gap:4px; }
.cal-day-hdr { text-align:center; font-size:11px; font-weight:700; color:var(--muted); padding:6px 0; }
.cal-day { min-height:52px; border:1px solid var(--border); border-radius:10px; padding:4px 6px; font-size:12px; cursor:pointer; transition:background 0.2s; }
.cal-day:hover { background:var(--active-bg); }
.cal-day.today { border-color: var(--uni-accent); background:rgba(201,146,10,0.08); font-weight:700; }
.cal-day.selected { border:2px solid #d49a00; background:rgba(212,154,0,0.14); box-shadow:0 0 0 2px rgba(212,154,0,0.18); }
.cal-day.other-month { opacity:0.35; }
.cal-day .day-num { font-size:12px; font-weight:600; }
.cal-day .event-dot { width:6px; height:6px; border-radius:50%; background: var(--uni-accent); display:inline-block; margin:1px; }
.cal-event-list { margin-top:16px; display:flex; flex-direction:column; gap:8px; }
.cal-event-item { padding:10px 14px; border-radius:12px; border-left:3px solid #c9920a; background:var(--surface-soft); font-size:13px; }
.cal-event-item .ev-title { font-weight:600; color:var(--primary); }
.cal-event-item .ev-meta { font-size:11px; color:var(--muted); margin-top:2px; }
.dark-mode .cal-box { background:rgba(20,20,20,0.98); }
.dark-mode .cal-box-header h2 { color:#e0e7ff; }
.dark-mode .cal-day { border-color:rgba(255,255,255,0.08); }
.dark-mode .cal-day.selected { border-color: var(--uni-accent); background:rgba(201,146,10,0.16); }
.dark-mode .cal-event-item { background:rgba(255,255,255,0.05); }
.dark-mode .cal-event-item .ev-title { color:#e2e8f0; }
</style>
</head>
<body>
<form id="form1" runat="server">
<div class="header">
    <button type="button" class="hamburger-btn" id="hamburgerBtn" aria-label="Open menu">
        <i class="fas fa-bars"></i>
    </button>
    <button type="button" class="logo" onclick="navigateWithFlip('Student.aspx')">
        <i class="fas fa-university"></i> Campus Announcement
    </button>
    <div class="search-container">
        <asp:Button ID="searchButton" runat="server" CssClass="search-btn" Text="Search........"
            OnClientClick="navigateWithFlip('SearchStudent.aspx'); return false;" UseSubmitBehavior="false" />
    </div>
    <div class="header-actions">
        <button type="button" class="notification-bell" id="mobileSearchBtn"
            style="display:none;"
            onclick="navigateWithFlip('SearchStudent.aspx')"
            title="Search">
            <i class="fas fa-search bell-icon"></i>
        </button>
        <button type="button" class="notification-bell" onclick="navigateWithFlip('Notifications.aspx')">
            <i class="fas fa-bell bell-icon"></i>
            <span id="notificationBadge" class="badge-red" style="display:none;">0</span>
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
                    <button type="button" class="dropdown-item-panel" data-filter="All"
                        onclick="filterCategory('All'); event.stopPropagation();">
                        <i class="fas fa-th-list"></i> All Announcements
                    </button>
                    <button type="button" class="dropdown-item-panel" data-filter="Exam"
                        onclick="filterCategory('Exam'); event.stopPropagation();">
                        <i class="fas fa-file-alt"></i> Exam Schedule
                    </button>
                    <button type="button" class="dropdown-item-panel" data-filter="Suspension"
                        onclick="filterCategory('Suspension'); event.stopPropagation();">
                        <i class="fas fa-cloud-rain"></i> Class Suspension
                    </button>
                    <button type="button" class="dropdown-item-panel" data-filter="Event"
                        onclick="filterCategory('Event'); event.stopPropagation();">
                        <i class="fas fa-calendar-alt"></i> Campus Events
                    </button>
                    <button type="button" class="dropdown-item-panel" data-filter="General"
                        onclick="filterCategory('General'); event.stopPropagation();">
                        <i class="fas fa-bullhorn"></i> General
                    </button>
                </div>
                <button type="button" class="panel-menu-item" onclick="navigateWithFlip('Pinned.aspx');">
                    <i class="fas fa-thumbtack"></i> Pinned Announcements
                </button>
                <div class="divider-light"></div>
                <button type="button" class="panel-menu-item" onclick="openCalendarPanel()">
                    <i class="fas fa-calendar-alt"></i> Academic Calendar
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
        <div id="mobileOverlay" onclick="closeSidebar()"></div>

        <div class="content-shell">
            <main class="main-panel card">
                <div class="card-header">
                    <i class="fas fa-bullhorn"></i> Announcement Board
                    <span id="boardModeLabel" style="float:right;font-size:12px;">
                        Showing: <span id="activeFilterLabel">All</span>
                    </span>
                </div>
                <div id="announcementsContainer" class="announcement-board">
                    <div style="text-align:center;padding:40px;">Loading announcements...</div>
                </div>
            </main>
        </div>
    </div>
</div>

<!-- Profile Modal -->
<div id="profileModal" class="modal" style="display:none;">
    <div class="modal-content" style="max-width:420px;text-align:left;">
        <div style="text-align:center;margin-bottom:20px;">
            <div style="width:72px;height:72px;border-radius:50%;background: linear-gradient(135deg, var(--uni-accent), var(--uni-accent-dark));color:#fff;display:flex;align-items:center;justify-content:center;font-size:28px;margin:0 auto 12px;">
                <i class="fas fa-user"></i>
            </div>
            <div class="modal-title" style="margin-bottom:4px;" id="pm-fullname"><%= Session["FullName"] ?? "User" %></div>
            <span style="display:inline-block;padding:3px 14px;border-radius:20px;font-size:11px;font-weight:700;background:#fef3c7;color: var(--uni-accent);" id="pm-role"><%= Session["Role"] ?? "Student" %></span>
        </div>
        <div style="display:flex;flex-direction:column;gap:12px;margin-bottom:24px;">
            <div style="display:flex;align-items:center;gap:12px;padding:12px 16px;background:var(--surface-soft);border-radius:12px;">
                <i class="fas fa-user" style="color:var(--primary);"></i>
                <div>
                    <div style="font-size:11px;color:var(--muted);">Username</div>
                    <div style="font-weight:600;" id="pm-username"><%= Session["Username"] ?? "User" %></div>
                </div>
            </div>
            <div style="display:flex;align-items:center;gap:12px;padding:12px 16px;background:var(--surface-soft);border-radius:12px;">
                <i class="fas fa-envelope" style="color:var(--primary);"></i>
                <div>
                    <div style="font-size:11px;color:var(--muted);">Email</div>
                    <div style="font-weight:600;" id="pm-email"><%= Session["Email"] ?? "student@ctu.edu" %></div>
                </div>
            </div>
        </div>
        <div style="display:flex;gap:10px;">
            <button onclick="closeProfileModal()" style="flex:1;padding:12px;border:1px solid var(--border);border-radius:12px;background:none;cursor:pointer;">Close</button>
            <button onclick="logout()" style="flex:1;padding:12px;border:none;border-radius:12px;background:#fef2f2;color:#dc2626;cursor:pointer;">
                <i class="fas fa-sign-out-alt"></i> Logout
            </button>
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

<!-- Academic Calendar Panel (Student: personal events + public events) -->
<div id="calendarOverlay" class="cal-overlay">
    <div class="cal-box">
        <div class="cal-box-header">
            <h2><i class="fas fa-calendar-alt" style="color: var(--uni-accent);margin-right:8px;"></i>Academic Calendar</h2>
            <button type="button" class="cal-box-close" onclick="closeCalendarPanel()">&times;</button>
        </div>
        <div class="cal-box-body">
            <div style="display:grid;grid-template-columns:1fr 260px;gap:20px;align-items:start;">
                <!-- Left: Calendar grid -->
                <div>
                    <div class="cal-nav">
                        <button type="button" class="cal-nav-btn" onclick="calPrev()"><i class="fas fa-chevron-left"></i></button>
                        <strong id="calMonthLabel" style="font-size:15px;color:var(--primary);"></strong>
                        <button type="button" class="cal-nav-btn" onclick="calNext()"><i class="fas fa-chevron-right"></i></button>
                    </div>
                    <div class="cal-grid" id="calGrid"></div>
                    <!-- Selected day events -->
                    <div id="calDayEvents" style="display:none;margin-top:14px;padding:12px 14px;background:var(--surface-soft);border-radius:14px;border:1px solid var(--border);">
                        <div style="font-weight:700;font-size:13px;color:var(--primary);margin-bottom:8px;" id="calDayLabel"></div>
                        <div id="calDayEventList"></div>
                    </div>
                </div>
                <!-- Right: Add form + upcoming list -->
                <div>
                    <!-- Header row: title + plus button -->
                    <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:10px;">
                        <span style="font-weight:700;font-size:14px;color:var(--primary);">Upcoming Events</span>
                        <button type="button" id="calAddToggleBtn" onclick="toggleCalForm(true)"
                            title="Add event"
                            style="width:30px;height:30px;border-radius:50%;border:none;background: linear-gradient(135deg, var(--uni-accent), var(--uni-accent-dark));color:#fff;cursor:pointer;display:flex;align-items:center;justify-content:center;font-size:16px;flex-shrink:0;">
                            <i class="fas fa-plus"></i>
                        </button>
                    </div>
                    <!-- Add form (hidden by default) -->
                    <div id="calFormBody" style="display:none;flex-direction:column;gap:8px;margin-bottom:16px;padding:14px;background:var(--surface-soft);border-radius:14px;border:1px solid var(--border);">
                        <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:4px;">
                            <span style="font-weight:700;font-size:13px;color:var(--primary);"><i class="fas fa-plus-circle" style="color: var(--uni-accent);margin-right:5px;"></i>Add Personal Event</span>
                            <button type="button" onclick="toggleCalForm(false)" title="Close"
                                style="background:none;border:none;cursor:pointer;color:var(--muted);font-size:18px;line-height:1;padding:2px 4px;">&times;</button>
                        </div>
                        <input type="text" id="calTitle" placeholder="Event title..." style="padding:9px 14px;border:1px solid var(--border);border-radius:12px;background:var(--surface-strong);font-size:13px;outline:none;" />
                        <input type="date" id="calDate" style="padding:9px 14px;border:1px solid var(--border);border-radius:12px;background:var(--surface-strong);font-size:13px;outline:none;" />
                        <input type="time" id="calTime" placeholder="Time (optional)" style="padding:9px 14px;border:1px solid var(--border);border-radius:12px;background:var(--surface-strong);font-size:13px;outline:none;" />
                        <select id="calType" style="padding:9px 14px;border:1px solid var(--border);border-radius:12px;background:var(--surface-strong);font-size:13px;outline:none;">
                            <option value="General">General</option>
                            <option value="Exam">Exam</option>
                            <option value="Deadline">Deadline</option>
                            <option value="Reminder">Reminder</option>
                            <option value="Quiz">Quiz</option>
                        </select>
                        <textarea id="calDesc" rows="2" placeholder="Note (optional)..." style="padding:9px 14px;border:1px solid var(--border);border-radius:12px;background:var(--surface-strong);font-size:13px;outline:none;resize:vertical;"></textarea>
                        <button type="button" id="calSaveBtn" onclick="saveCalEvent()" style="padding:10px;border-radius:40px;border:none;background: linear-gradient(135deg, var(--uni-accent), var(--uni-accent-dark));color:#fff;font-size:13px;font-weight:700;cursor:pointer;"><i class="fas fa-plus" style="margin-right:6px;"></i>Save Event</button>
                    </div>
                    <!-- Upcoming events list -->
                    <div class="cal-event-list" id="calEventList">
                        <div style="text-align:center;padding:20px;color:var(--muted);font-size:13px;">Loading...</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</form>

<script>
    // ====================== GLOBAL STATE ======================
    let st_likes = {}, st_likeCounts = {}, st_pins = {}, st_comments = {};

    // ✅ CHANGE 1: Read focusPostId from URL at page load
    let focusPostId = 0;
    (function () {
        var params = new URLSearchParams(window.location.search);
        var pid = parseInt(params.get('postId') || '0', 10);
        if (!isNaN(pid) && pid > 0) focusPostId = pid;
        // Open calendar panel if redirected from a reminder notification
        if (params.get('openCalendar') === '1') {
            window.addEventListener('load', function () { openCalendarPanel(); });
        }
    })();

    function showToast(msg) {
        let t = document.createElement('div');
        t.innerText = msg;
        t.style.cssText = 'position:fixed;bottom:30px;left:50%;transform:translateX(-50%);background: var(--uni-accent);color:#fff;padding:8px 20px;border-radius:30px;z-index:9999';
        document.body.appendChild(t);
        setTimeout(() => t.remove(), 2500);
    }

    var videoExts = ['mp4', 'webm', 'ogg', 'mov', 'avi'];
    var imageExts = ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp'];
    function getExt(url) { return (url.split('.').pop() || '').toLowerCase().split('?')[0]; }

    function renderMediaHtml(mediaUrl) {
        if (!mediaUrl) return '';
        var urls = mediaUrl.split(',').map(function (u) { return u.trim(); }).filter(Boolean);
        if (!urls.length) return '';
        var html = '';
        var images = urls.filter(function (u) { return imageExts.indexOf(getExt(u)) !== -1; });
        var videos = urls.filter(function (u) { return videoExts.indexOf(getExt(u)) !== -1; });
        var files = urls.filter(function (u) { return imageExts.indexOf(getExt(u)) === -1 && videoExts.indexOf(getExt(u)) === -1; });
        if (images.length === 1) {
            html += `<div class="post-image"><img src="${images[0]}" style="cursor:zoom-in;" onclick="openLightbox('${images[0]}')" onerror="this.style.display='none'" /></div>`;
        } else if (images.length > 1) {
            html += `<div class="post-image" style="display:flex;flex-wrap:wrap;gap:6px;">`;
            images.forEach(function (img) {
                html += `<img src="${img}" style="width:calc(50% - 3px);max-height:160px;object-fit:cover;border-radius:12px;cursor:zoom-in;flex:1 1 calc(50% - 3px);" onclick="openLightbox('${img}')" onerror="this.style.display='none'" />`;
            });
            html += `</div>`;
        }
        videos.forEach(function (vid) {
            html += `<div class="post-image" style="margin-top:10px;"><video controls style="width:100%;max-height:280px;border-radius:16px;display:block;"><source src="${vid}" />Your browser does not support video.</video></div>`;
        });
        files.forEach(function (f) {
            var fname = f.split('/').pop();
            html += `<div style="margin-top:10px;padding:10px 14px;background:var(--surface-soft);border:1px solid var(--border);border-radius:12px;display:flex;align-items:center;gap:10px;">
            <i class="fas fa-file-alt" style="color:var(--primary);font-size:18px;"></i>
            <span style="flex:1;font-size:13px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">${fname}</span>
            <a href="${f}" download="${fname}" style="padding:6px 14px;background:var(--primary);color:#fff;border-radius:20px;font-size:12px;font-weight:600;text-decoration:none;white-space:nowrap;">
                <i class="fas fa-download" style="margin-right:4px;"></i>Download
            </a>
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
    document.addEventListener('keydown', function (e) { if (e.key === 'Escape') closeLightbox(); });

    function escapeHtml(str) {
        if (!str) return '';
        return str.replace(/[&<>]/g, m => ({ '&': '&', '<': '<', '>': '>' })[m]);
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

    document.getElementById('filterCategoryBtn').addEventListener('click', function (e) {
        e.stopPropagation();
        let panel = document.getElementById('categoryDropdownPanel');
        panel.style.display = panel.style.display === 'flex' ? 'none' : 'flex';
    });
    document.getElementById('settingsThemeBtn').addEventListener('click', function (e) {
        e.stopPropagation();
        toggleTheme();
    });

    function filterCategory(category) {
        localStorage.setItem('student_filter', category);
        let label = document.getElementById('activeFilterLabel');
        if (label) label.innerText = category;
        document.querySelectorAll('.announcement-card').forEach(card => {
            let cat = card.getAttribute('data-category') || '';
            let show = category === 'All' || cat === category;
            card.style.display = show ? '' : 'none';
        });
        document.querySelectorAll('[data-filter]').forEach(btn => {
            btn.classList.toggle('active-filter', btn.getAttribute('data-filter') === category);
        });
    }

    function applyTheme(isDark) {
        document.body.classList.toggle('dark-mode', isDark);
        document.querySelectorAll('.toggle-switch-panel, #panelThemeToggle').forEach(el => el.classList.toggle('active', isDark));
    }
    function toggleTheme() {
        let isDark = !document.body.classList.contains('dark-mode');
        localStorage.setItem('campus_theme', isDark ? 'dark' : 'light');
        applyTheme(isDark);
    }
    applyTheme(localStorage.getItem('campus_theme') === 'dark');
    window.addEventListener('storage', function (e) {
        if (e.key === 'campus_theme') applyTheme(e.newValue === 'dark');
    });

    // ── University Theme ─────────────────────────────────────────
    var UNIVERSITY_THEMES = {
        'Default': { overlay: 'rgba(255,255,255,0)', header: '#c9920a', accent: '#c9920a', accentDark: '#a87800' },
        'Intramurals': { overlay: 'rgba(180,30,30,0.18)', header: '#b91c1c', accent: '#b91c1c', accentDark: '#991b1b' },
        'FoundationWeek': { overlay: 'rgba(201,146,10,0.18)', header: '#a87800', accent: '#a87800', accentDark: '#7a5200' },
        'WomensMonth': { overlay: 'rgba(147,51,234,0.18)', header: '#7c3aed', accent: '#7c3aed', accentDark: '#5b21b6' },
        'Christmas': { overlay: 'rgba(22,101,52,0.20)', header: '#15803d', accent: '#15803d', accentDark: '#14532d' }
    };
    function applyUniversityTheme(name) {
        var t = UNIVERSITY_THEMES[name] || UNIVERSITY_THEMES['Default'];
        document.documentElement.style.setProperty('--uni-overlay', t.overlay);
        document.documentElement.style.setProperty('--uni-header-bg', t.header);
        document.documentElement.style.setProperty('--uni-accent', t.accent);
        document.documentElement.style.setProperty('--uni-accent-dark', t.accentDark);
        // Apply body class for university-theme-decorations.css
        var ALL_CLASSES = ['theme-default', 'theme-intramurals', 'theme-foundation', 'theme-womens', 'theme-christmas'];
        ALL_CLASSES.forEach(function (c) { document.body.classList.remove(c); });
        var clsMap = { 'Default': 'theme-default', 'Intramurals': 'theme-intramurals', 'FoundationWeek': 'theme-foundation', 'WomensMonth': 'theme-womens', 'Christmas': 'theme-christmas' };
        document.body.classList.add(clsMap[name] || 'theme-default');
        localStorage.setItem('campus_uni_theme', name);
    }
    var savedUniTheme = localStorage.getItem('campus_uni_theme');
    if (savedUniTheme) applyUniversityTheme(savedUniTheme);
    fetch('UserMgmtHandler.ashx?action=getTheme', { credentials: 'same-origin' })
        .then(function (r) { return r.json(); })
        .then(function (res) { if (res.ok) applyUniversityTheme(res.theme); })
        .catch(function () { });
    window.addEventListener('storage', function (e) {
        if (e.key === 'campus_uni_theme') applyUniversityTheme(e.newValue);
    });

    function openProfileModal(e) { if (e) e.stopPropagation(); document.getElementById('profileModal').style.display = 'flex'; }
    function closeProfileModal() { document.getElementById('profileModal').style.display = 'none'; }
    function openAboutModal() { document.getElementById('aboutModal').style.display = 'flex'; }
    function closeAboutModal() { document.getElementById('aboutModal').style.display = 'none'; }
    function logout() { window.location.href = 'Logout.aspx'; }
    document.addEventListener('click', function (e) {
        let pm = document.getElementById('profileModal');
        if (pm && pm.style.display === 'flex' && e.target === pm) pm.style.display = 'none';
        let am = document.getElementById('aboutModal');
        if (am && am.style.display === 'flex' && e.target === am) am.style.display = 'none';
    });

    function toggleLike(postId) {
        fetch('LikeHandler.ashx?action=toggle&postId=' + postId, { credentials: 'same-origin' })
            .then(r => r.json()).then(res => {
                if (!res.ok) { showToast('Error: ' + (res.error || 'Could not update like')); return; }
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
            }).catch(() => showToast('Could not update like'));
    }

    function togglePin(postId) {
        fetch('UserPinHandler.ashx?action=toggle&announcementId=' + postId, { credentials: 'same-origin' })
            .then(r => r.json()).then(res => {
                if (!res.ok) { showToast('Error: ' + (res.error || 'Could not update pin')); return; }
                if (res.isPinned) { st_pins[postId] = true; } else { delete st_pins[postId]; }
                let btn = document.querySelector(`.pin-btn-top[onclick="togglePin(${postId})"]`);
                if (btn) { btn.classList.toggle('pinned', res.isPinned); btn.title = res.isPinned ? 'Unpin' : 'Pin'; }
                showToast(res.isPinned ? '📌 Pinned!' : 'Unpinned');
            }).catch(() => showToast('Could not update pin'));
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
            .then(r => r.json()).then(data => {
                if (!Array.isArray(data)) { listDiv.innerHTML = '<div class="no-comments">Could not load comments.</div>'; return; }
                const comments = data;
                if (!comments.length) { listDiv.innerHTML = '<div class="no-comments">No comments yet.</div>'; return; }
                const topLevel = comments.filter(c => !c.parentCommentId);
                const replies = comments.filter(c => c.parentCommentId);
                if (!topLevel.length) { listDiv.innerHTML = '<div class="no-comments">No comments yet.</div>'; return; }
                listDiv.innerHTML = topLevel.map(c => {
                    let cAvatar = c.profileImage
                        ? `<div class="comment-avatar" style="overflow:hidden;width:32px;height:32px;min-width:32px;"><img src="${c.profileImage}" style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;" /></div>`
                        : `<div class="comment-avatar"><i class="fas fa-user"></i></div>`;
                    let commentReplies = replies.filter(r => r.parentCommentId === c.commentId);
                    let repliesHtml = commentReplies.map(r => {
                        let rAvatar = r.profileImage
                            ? `<div class="comment-avatar" style="overflow:hidden;width:26px;height:26px;min-width:26px;"><img src="${r.profileImage}" style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;" /></div>`
                            : `<div class="comment-avatar" style="width:26px;height:26px;min-width:26px;font-size:10px;"><i class="fas fa-user"></i></div>`;
                        return `<div class="comment reply-comment" style="margin-left:42px;padding:6px 0;border-bottom:none;">
                        ${rAvatar}
                        <div style="flex:1;min-width:0;">
                            <span class="comment-author">${escapeHtml(r.author)}</span>
                            <div class="comment-text">${escapeHtml(r.text)}</div>
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
            }).catch(() => { listDiv.innerHTML = '<div class="no-comments">Could not load comments</div>'; });
    }

    function likeComment(commentId, btn) {
        fetch('CommentHandler.ashx?action=likeComment&commentId=' + commentId, { credentials: 'same-origin' })
            .then(r => r.json()).then(res => {
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
            } else { showToast('Error: ' + (res.error || 'Could not reply')); }
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
            } else { showToast('Error: ' + (res.error || 'Could not add comment')); }
        }).catch(() => showToast('Could not add comment'));
    }

    function sharePost(postId) {
        let url = window.location.href.split('?')[0];
        if (navigator.clipboard) {
            navigator.clipboard.writeText(url).then(() => showToast('Link copied!')).catch(() => showToast('Shared!'));
        } else { showToast('Shared!'); }
        fetch('NotificationHandler.ashx?action=notifyShare&postId=' + postId, { credentials: 'same-origin' }).catch(() => { });
    }

    // ====================== RENDER ANNOUNCEMENTS ======================
    // ✅ CHANGE 2: renderAnnouncements now handles focus mode (single post + back button)
    function renderAnnouncements() {
        let container = document.getElementById('announcementsContainer');
        if (!container) return;

        Promise.all([
            fetch('AnnouncementHandler.ashx?action=getAll', { credentials: 'same-origin' }).then(r => r.json()),
            fetch('UserPinHandler.ashx?action=getUserPins', { credentials: 'same-origin' }).then(r => r.json())
        ]).then(([res, pinRes]) => {
            if (!res.ok) { container.innerHTML = '<div style="padding:40px;text-align:center;">Error loading</div>'; return; }

            let announcements = res.data;
            if (!announcements.length) { container.innerHTML = '<div style="padding:40px;text-align:center;">No announcements</div>'; return; }

            st_pins = {};
            if (pinRes.ok && pinRes.pinnedIds) {
                pinRes.pinnedIds.forEach(id => { st_pins[id] = true; });
            }

            // ✅ Sort announcements: admin-pinned posts (isPinned=true) appear first
            announcements.sort(function (a, b) {
                let aPinned = a.isPinned === true;
                let bPinned = b.isPinned === true;
                if (aPinned && !bPinned) return -1;  // a is pinned, comes first
                if (!aPinned && bPinned) return 1;   // b is pinned, comes first
                // If both or neither are pinned, sort by date (newest first)
                return new Date(b.date) - new Date(a.date);
            });

            // ✅ If focusPostId is set, only show that one post
            let displayList = focusPostId > 0
                ? announcements.filter(post => post.id === focusPostId)
                : announcements;

            let savedFilter = localStorage.getItem('student_filter') || 'All';

            // ✅ Update board mode label
            let boardModeLabel = document.getElementById('boardModeLabel');
            if (focusPostId > 0) {
                if (boardModeLabel) boardModeLabel.innerHTML = 'Mode: <strong>Notification Post View</strong>';
            } else {
                if (boardModeLabel) boardModeLabel.innerHTML = 'Showing: <span id="activeFilterLabel">' + savedFilter + '</span>';
            }

            // ✅ Focus banner with Back to All Posts button
            let bannerHtml = '';
            if (focusPostId > 0) {
                bannerHtml = `<div class="focus-banner">
                <button type="button" class="focus-back-btn" onclick="window.location.href='Student.aspx'">
                    <i class="fas fa-arrow-left" style="margin-right:6px;"></i>Back to All Posts
                </button>
            </div>`;
            }

            container.innerHTML = bannerHtml + displayList.map(post => {
                let isPinned = !!st_pins[post.id];
                let isAdminPin = post.isPinned === true;  // Pinned by admin (global)
                let liked = !!post.userLiked;
                let likeCount = post.likeCount || 0;
                let catClass = post.category === 'Exam' ? 'post-category-exam'
                    : post.category === 'Suspension' ? 'post-category-suspension'
                        : post.category === 'Event' ? 'post-category-event'
                            : 'post-category-general';

                // In normal mode, respect the saved filter
                let visible = focusPostId > 0 || savedFilter === 'All' || post.category === savedFilter;

                let postAvatar = post.authorImage
                    ? `<div class="post-avatar" style="overflow:hidden;"><img src="${post.authorImage}" style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;" /></div>`
                    : `<div class="post-avatar"><i class="fas fa-user-tie"></i></div>`;

                // Admin-pinned badge
                let adminPinBadge = isAdminPin
                    ? `<span class="post-category" style="background:#fff0db;color:#d97706;"><i class="fas fa-thumbtack" style="margin-right:4px;"></i>Pinned</span>`
                    : '';

                return `<div class="announcement-card${focusPostId === post.id ? ' notification-target' : ''}"
                        data-post-id="${post.id}" data-category="${post.category}"
                        style="${visible ? '' : 'display:none'}">
                <div class="post-header">
                    <div class="post-header-left">
                        ${postAvatar}
                        <div>
                            <div class="post-author">${escapeHtml(post.author)}</div>
                            <div class="post-meta">
                                <span>${escapeHtml(timeAgo(post.date))}</span>
                                <span class="post-category ${catClass}">${escapeHtml(post.category)}</span>
                                ${adminPinBadge}
                            </div>
                        </div>
                    </div>
                    <button type="button" class="pin-btn-top ${isPinned ? 'pinned' : ''}"
                        onclick="togglePin(${post.id})" title="${isPinned ? 'Unpin' : 'Pin'}">
                        <i class="fas fa-thumbtack"></i>
                    </button>
                </div>
                <div class="post-content">
                    <div class="post-title">${escapeHtml(post.title)}</div>
                    <div class="post-text">${escapeHtml(post.content)}</div>
                    ${renderMediaHtml(post.imageUrl)}
                </div>
                <div class="post-stats">
                    <span onclick="toggleLike(${post.id})">
                        <i class="${liked ? 'fas' : 'far'} fa-heart" style="${liked ? 'color:#dc2626' : ''}"></i>
                        <span class="like-count">${likeCount}</span> Likes
                    </span>
                    <span onclick="toggleCommentSection(${post.id})">
                        <i class="far fa-comment"></i>
                        <span class="comment-count">${post.commentCount || 0}</span> Comments
                    </span>
                    <span onclick="sharePost(${post.id})">
                        <i class="far fa-share-square"></i> Share
                    </span>
                </div>
                <div class="action-buttons">
                    <button type="button" class="action-btn like-btn ${liked ? 'liked' : ''}" onclick="toggleLike(${post.id})">
                        <i class="${liked ? 'fas' : 'far'} fa-heart"></i> ${liked ? 'Liked' : 'Like'}
                    </button>
                    <button type="button" class="action-btn" onclick="toggleCommentSection(${post.id})">
                        <i class="far fa-comment"></i> Comment
                    </button>
                    <button type="button" class="action-btn" onclick="sharePost(${post.id})">
                        <i class="fas fa-share-alt"></i> Share
                    </button>
                </div>
                <div class="comments-section" id="commentsSection_${post.id}"
                    style="${focusPostId === post.id ? 'display:block;' : 'display:none;'}">
                    <div class="comment-input">
                        <input type="text" id="commentInput_${post.id}" placeholder="Write a comment..." />
                        <button type="button" onclick="addComment(this, ${post.id})">Post</button>
                    </div>
                    <div class="comments-list" id="commentsList_${post.id}">
                        <div class="no-comments">No comments yet.</div>
                    </div>
                </div>
            </div>`;
            }).join('');

            // ✅ Auto-load comments when in focus mode
            if (focusPostId > 0 && displayList.length > 0) {
                loadCommentsFromDB(focusPostId);
            }

            // Update filter label only in normal mode
            if (focusPostId === 0) {
                let label = document.getElementById('activeFilterLabel');
                if (label) label.innerText = savedFilter;
                document.querySelectorAll('[data-filter]').forEach(btn => {
                    btn.classList.toggle('active-filter', btn.getAttribute('data-filter') === savedFilter);
                });
            }

            updateNotifBadge();

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
            .then(r => r.json()).then(res => {
                let badge = document.getElementById('notificationBadge');
                if (badge) {
                    if (res.ok && res.count > 0) {
                        badge.textContent = res.count;
                        badge.style.display = 'inline-block';
                    } else badge.style.display = 'none';
                }
            });
    }

    function navigateWithFlip(url) { window.location.href = url; }

    // ====================== MOBILE SIDEBAR ======================
    (function () {
        var btn = document.getElementById('hamburgerBtn');
        var panel = document.getElementById('slideoutPanel');
        var overlay = document.getElementById('mobileOverlay');
        if (!btn || !panel) return;
        btn.addEventListener('click', function () {
            var isOpen = panel.classList.contains('mobile-open');
            if (isOpen) { closeSidebar(); } else { openSidebar(); }
        });
        function openSidebar() {
            panel.classList.add('mobile-open');
            panel.style.display = 'flex';
            if (overlay) overlay.classList.add('show');
            document.body.style.overflow = 'hidden';
        }
        window.closeSidebar = function () {
            panel.classList.remove('mobile-open');
            panel.style.display = '';
            if (overlay) overlay.classList.remove('show');
            document.body.style.overflow = '';
        };
    })();

    // ====================== INITIALIZE ======================
    renderAnnouncements();
    updateNotifBadge();
    setInterval(updateNotifBadge, 30000);

    // ── 5-minute calendar reminder polling ───────────────────────
    function pollCalendarReminders() {
        fetch('ReminderCheckHandler.ashx', { credentials: 'same-origin' })
            .then(r => r.json())
            .then(res => { if (res.ok && res.triggered > 0) updateNotifBadge(); })
            .catch(() => { });
    }
    pollCalendarReminders();
    setInterval(pollCalendarReminders, 60000);

    // ── ACADEMIC CALENDAR (Student) ──────────────
    var calYear = new Date().getFullYear(), calMonth = new Date().getMonth();
    var calEvents = [];
    var selectedCalDate = '';
    var currentUserId = <%= Session["UserId"] != null ? Session["UserId"].ToString() : "0" %>;

    function fmtTime(t) {
        if (!t) return '';
        var parts = t.split(':');
        var h = parseInt(parts[0], 10), m = parts[1] || '00';
        if (isNaN(h)) return t;
        var suffix = h >= 12 ? 'PM' : 'AM';
        return (h % 12 || 12) + ':' + m + ' ' + suffix;
    }

    function openCalendarPanel() {
        document.getElementById('calendarOverlay').classList.add('open');
        loadCalEvents();
        renderCal();
    }
    function closeCalendarPanel() {
        document.getElementById('calendarOverlay').classList.remove('open');
        toggleCalForm(false);
    }
    document.getElementById('calendarOverlay').addEventListener('click', function (e) {
        if (e.target === this) closeCalendarPanel();
    });

    // Toggle the add-event form: show=true opens, show=false closes
    var calEditingId = null; // null = adding new event; integer = editing existing event

    function toggleCalForm(show) {
        var form = document.getElementById('calFormBody');
        var btn = document.getElementById('calAddToggleBtn');
        if (show) {
            form.style.display = 'flex';
            if (btn) btn.style.display = 'none';
        } else {
            form.style.display = 'none';
            if (btn) btn.style.display = 'flex';
            // Clear form
            document.getElementById('calTitle').value = '';
            document.getElementById('calDate').value = '';
            document.getElementById('calTime').value = '';
            document.getElementById('calDesc').value = '';
            // Reset edit state
            calEditingId = null;
            var saveBtn = document.getElementById('calSaveBtn');
            if (saveBtn) saveBtn.textContent = 'Save Event';
        }
    }

    function loadCalEvents() {
        fetch('CalendarHandler.ashx?action=getEvents', { credentials: 'same-origin' })
            .then(function (r) { return r.json(); })
            .then(function (res) {
                if (res.ok) { calEvents = res.data; renderCal(); renderCalList(); }
            }).catch(function () { });
    }

    function calPrev() { calMonth--; if (calMonth < 0) { calMonth = 11; calYear--; } selectedCalDate = ''; renderCal(); hideDayEvents(); }
    function calNext() { calMonth++; if (calMonth > 11) { calMonth = 0; calYear++; } selectedCalDate = ''; renderCal(); hideDayEvents(); }

    function renderCal() {
        var label = document.getElementById('calMonthLabel');
        var grid = document.getElementById('calGrid');
        if (!label || !grid) return;
        var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
        label.textContent = months[calMonth] + ' ' + calYear;
        var days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
        var html = days.map(function (d) { return '<div class="cal-day-hdr">' + d + '</div>'; }).join('');
        var first = new Date(calYear, calMonth, 1).getDay();
        var daysInMonth = new Date(calYear, calMonth + 1, 0).getDate();
        var daysInPrev = new Date(calYear, calMonth, 0).getDate();
        var today = new Date();
        var typeColorMap = { Exam: '#f59e0b', Deadline: '#ef4444', Event: '#10b981', Quiz: '#3b82f6', Reminder: '#8b5cf6', General: '#c9920a' };

        for (var i = first - 1; i >= 0; i--)
            html += '<div class="cal-day other-month"><div class="day-num">' + (daysInPrev - i) + '</div></div>';

        for (var d = 1; d <= daysInMonth; d++) {
            var isToday = (d === today.getDate() && calMonth === today.getMonth() && calYear === today.getFullYear());
            var ds = calYear + '-' + String(calMonth + 1).padStart(2, '0') + '-' + String(d).padStart(2, '0');
            var dayEvents = calEvents.filter(function (e) { return e.eventDate === ds; });
            var isSelected = (ds === selectedCalDate);

            // Build colored dots — one per event type (max 3)
            var dots = '';
            var shown = {};
            dayEvents.forEach(function (ev) {
                if (Object.keys(shown).length >= 3) return;
                var color = typeColorMap[ev.eventType] || '#c9920a';
                if (!shown[ev.eventType]) {
                    dots += '<span style="display:inline-block;width:6px;height:6px;border-radius:50%;background:' + color + ';margin:1px;"></span>';
                    shown[ev.eventType] = true;
                }
            });

            var cls = 'cal-day' + (isToday ? ' today' : '') + (isSelected ? ' selected' : '');
            html += '<div class="' + cls + '" onclick="calDayPick(\'' + ds + '\')" style="cursor:pointer;">';
            html += '<div class="day-num">' + d + '</div>';
            if (dots) html += '<div style="display:flex;flex-wrap:wrap;justify-content:center;margin-top:2px;">' + dots + '</div>';
            html += '</div>';
        }

        var total = first + daysInMonth, rem = total % 7 === 0 ? 0 : 7 - (total % 7);
        for (var n = 1; n <= rem; n++)
            html += '<div class="cal-day other-month"><div class="day-num">' + n + '</div></div>';
        grid.innerHTML = html;
    }

    function calDayPick(ds) {
        selectedCalDate = ds;
        document.getElementById('calDate').value = ds;
        renderCal();
        showDayEvents(ds);
    }

    function showDayEvents(ds) {
        var dayEvents = calEvents.filter(function (e) { return e.eventDate === ds; });
        var panel = document.getElementById('calDayEvents');
        var label = document.getElementById('calDayLabel');
        var list = document.getElementById('calDayEventList');
        if (!panel) return;

        var d = new Date(ds + 'T00:00:00');
        var dl = d.toLocaleDateString('en-US', { weekday: 'long', month: 'long', day: 'numeric' });
        label.textContent = dl;

        if (!dayEvents.length) {
            list.innerHTML = '<div style="font-size:12px;color:var(--muted);">No events on this day.</div>';
        } else {
            var typeColorMap = { Exam: '#fef3c7|#b45309', Deadline: '#fee2e2|#991b1b', Event: '#d1fae5|#065f46', Quiz: '#dbeafe|#1e40af', Reminder: '#ede9fe|#5b21b6', General: '#f3f4f6|#374151' };
            list.innerHTML = dayEvents.map(function (ev) {
                var tc = (typeColorMap[ev.eventType] || typeColorMap.General).split('|');
                var isOwn = (ev.ownerId == currentUserId);
                var lockIcon = !ev.isPublic ? ' <i class="fas fa-lock" style="font-size:9px;color:var(--muted);"></i>' : '';
                return '<div style="display:flex;align-items:center;gap:8px;padding:6px 0;border-bottom:1px solid var(--border);">'
                    + '<span style="padding:2px 8px;border-radius:20px;font-size:10px;font-weight:700;background:' + tc[0] + ';color:' + tc[1] + ';white-space:nowrap;">' + ev.eventType + '</span>'
                    + '<div style="flex:1;">'
                    + '<div style="font-size:13px;font-weight:600;color:var(--primary);">' + escapeHtml(ev.title) + lockIcon + '</div>'
                    + (ev.eventTime ? '<div style="font-size:11px;color:var(--muted);">⏰ ' + fmtTime(ev.eventTime) + '</div>' : '')
                    + '</div>'
                    + (isOwn ? '<button type="button" onclick="openCalEditFormById(' + ev.eventId + ')" style="background:none;border:none;cursor:pointer;color: var(--uni-accent);font-size:13px;padding:2px;" title="Edit"><i class="fas fa-edit"></i></button>'
                        + '<button type="button" onclick="delCalEvent(' + ev.eventId + ')" style="background:none;border:none;cursor:pointer;color:var(--muted);font-size:14px;padding:2px;">&times;</button>' : '')
                    + '</div>';
            }).join('');
        }
        panel.style.display = 'block';
    }

    function hideDayEvents() {
        var panel = document.getElementById('calDayEvents');
        if (panel) panel.style.display = 'none';
    }

    function renderCalList() {
        var today = new Date().toISOString().slice(0, 10);
        var upcoming = calEvents.filter(function (e) { return e.eventDate >= today; })
            .sort(function (a, b) { return a.eventDate.localeCompare(b.eventDate); })
            .slice(0, 8);
        var container = document.getElementById('calEventList');
        if (!container) return;
        if (!upcoming.length) {
            container.innerHTML = '<div style="text-align:center;padding:20px;color:var(--muted);font-size:13px;">No upcoming events.</div>';
            return;
        }
        var typeColorMap = { Exam: '#fef3c7|#b45309', Deadline: '#fee2e2|#991b1b', Event: '#d1fae5|#065f46', Quiz: '#dbeafe|#1e40af', Reminder: '#ede9fe|#5b21b6', General: '#f3f4f6|#374151' };
        container.innerHTML = upcoming.map(function (ev) {
            var d = new Date(ev.eventDate + 'T00:00:00');
            var dl = d.toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
            var tc = (typeColorMap[ev.eventType] || typeColorMap.General).split('|');
            var isOwn = (ev.ownerId == currentUserId);
            var lockIcon = !ev.isPublic ? ' <i class="fas fa-lock" style="font-size:9px;color:var(--muted);" title="Personal"></i>' : '';
            return '<div class="cal-event-item" style="display:flex;align-items:flex-start;gap:8px;cursor:pointer;" onclick="calDayPick(\'' + ev.eventDate + '\')">'
                + '<div style="flex:1;">'
                + '<div class="ev-title">' + escapeHtml(ev.title) + lockIcon + '</div>'
                + '<div class="ev-meta" style="display:flex;align-items:center;gap:6px;margin-top:3px;">'
                + '<span>' + dl + '</span>'
                + (ev.eventTime ? '<span>⏰ ' + fmtTime(ev.eventTime) + '</span>' : '')
                + '<span style="padding:2px 7px;border-radius:20px;font-size:10px;font-weight:700;background:' + tc[0] + ';color:' + tc[1] + ';">' + ev.eventType + '</span>'
                + '</div>'
                + (ev.description ? '<div style="font-size:11px;color:var(--muted);margin-top:3px;">' + escapeHtml(ev.description) + '</div>' : '')
                + '</div>'
                + (isOwn ? '<button type="button" onclick="event.stopPropagation();openCalEditForm(ev)" style="background:none;border:none;cursor:pointer;color: var(--uni-accent);font-size:13px;padding:2px 4px;flex-shrink:0;" title="Edit"><i class="fas fa-edit"></i></button>'
                    + '<button type="button" onclick="event.stopPropagation();delCalEvent(' + ev.eventId + ')" style="background:none;border:none;cursor:pointer;color:var(--muted);font-size:15px;padding:2px 4px;flex-shrink:0;">&times;</button>' : '')
                + '</div>';
        }).join('');
    }

    function openCalEditForm(ev) {
        calEditingId = ev.eventId;
        document.getElementById('calTitle').value = ev.title || '';
        document.getElementById('calDate').value = ev.eventDate || '';
        document.getElementById('calTime').value = ev.eventTime || '';
        document.getElementById('calType').value = ev.eventType || 'General';
        document.getElementById('calDesc').value = ev.description || '';
        toggleCalForm(true);
        var saveBtn = document.getElementById('calSaveBtn');
        if (saveBtn) saveBtn.textContent = 'Update Event';
    }

    function openCalEditFormById(id) {
        var ev = calEvents.find(function (e) { return e.eventId === id; });
        if (ev) openCalEditForm(ev);
    }

    function saveCalEvent() {
        var title = document.getElementById('calTitle').value.trim();
        var date = document.getElementById('calDate').value;
        var time = document.getElementById('calTime').value;
        var type = document.getElementById('calType').value;
        var desc = document.getElementById('calDesc').value.trim();
        if (!title || !date) { showToast('Enter a title and date.'); return; }

        var url;
        if (calEditingId) {
            url = 'CalendarHandler.ashx?action=updateEvent&id=' + calEditingId
                + '&title=' + encodeURIComponent(title)
                + '&date=' + encodeURIComponent(date)
                + '&time=' + encodeURIComponent(time)
                + '&type=' + encodeURIComponent(type)
                + '&desc=' + encodeURIComponent(desc)
                + '&isPublic=0';
        } else {
            url = 'CalendarHandler.ashx?action=addEvent&title=' + encodeURIComponent(title)
                + '&date=' + encodeURIComponent(date)
                + '&time=' + encodeURIComponent(time)
                + '&type=' + encodeURIComponent(type)
                + '&desc=' + encodeURIComponent(desc)
                + '&isPublic=0';
        }

        fetch(url, { credentials: 'same-origin' })
            .then(function (r) { return r.json(); })
            .then(function (res) {
                if (!res.ok) { showToast('Error: ' + (res.error || 'Unknown')); return; }
                showToast(calEditingId ? 'Event updated!' : 'Event added!');
                toggleCalForm(false);
                selectedCalDate = date;
                loadCalEvents();
            }).catch(function () { showToast('Network error.'); });
    }

    function delCalEvent(id) {
        fetch('CalendarHandler.ashx?action=deleteEvent&id=' + id, { credentials: 'same-origin' })
            .then(function (r) { return r.json(); })
            .then(function (res) {
                if (res.ok) {
                    showToast('Event removed.');
                    loadCalEvents();
                    hideDayEvents();
                }
            }).catch(function () { });
    }
</script>

<!-- Image Lightbox -->
<div id="imageLightbox" onclick="if(event.target===this)closeLightbox()"
    style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.88);z-index:9998;align-items:center;justify-content:center;padding:20px;">
    <button onclick="closeLightbox()"
        style="position:absolute;top:18px;right:22px;background:rgba(255,255,255,0.15);border:none;color:#fff;font-size:28px;width:44px;height:44px;border-radius:50%;cursor:pointer;display:flex;align-items:center;justify-content:center;line-height:1;">&times;</button>
    <img id="lightboxImg" src=""
        style="max-width:92vw;max-height:88vh;border-radius:12px;object-fit:contain;box-shadow:0 8px 40px rgba(0,0,0,0.6);" />
</div>

<link rel="stylesheet" href="university-theme-decorations.css" />
<script src="university-theme.js"></script>
</body>
</html>

