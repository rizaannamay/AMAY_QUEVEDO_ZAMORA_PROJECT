<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Profile" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Campus Announcement Portal - My Profile</title>
    <link rel="stylesheet" href="font-awesome.min.css" />
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
            --surface: rgba(255, 255, 255, 0.93);
            --surface-strong: #ffffff;
            --surface-soft: #f0f5ff;
            --border: rgba(26, 58, 92, 0.12);
            --primary: #1a2a3a;
            --primary-2: #a87800;
            --muted: #6b7c8f;
            --muted-light: #9db0c4;
            --shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
        }

        html, body, form { min-height: 100%; }
        html, body { overflow: auto; }
        html::-webkit-scrollbar { display: none; }
        html { scrollbar-width: none; -ms-overflow-style: none; }

        body::before {
    display: none;
}

        body {
            min-height: 100vh;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            color: var(--page-text);
            background-image: var(--bg-image);
            background-size: cover; background-repeat: no-repeat;
            background-position: center center; background-attachment: fixed;
        }

        .page-shell { min-height: 100vh; padding: 90px 32px 48px; }
        .page-wrap { max-width: 900px; margin: 0 auto; display: flex; flex-direction: column; gap: 18px; }

        /* Single column layout */
        .profile-columns {
            display: flex;
            flex-direction: column;
            gap: 18px;
        }
        .profile-col-left  { display: flex; flex-direction: column; gap: 18px; }
        .profile-col-right { display: flex; flex-direction: column; gap: 18px; }

        /* Topbar � matches dashboard header */
        .topbar {
            background: var(--uni-header-bg);
            backdrop-filter: blur(10px);
            border-radius: 24px;
            padding: 12px 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.2);
            border: 1px solid rgba(255,255,255,0.15);
            position: fixed;
            top: 10px;
            left: 10px;
            right: 10px;
            z-index: 200;
        }
        .brand { display: flex; align-items: center; gap: 10px; font-size: 18px; font-weight: 800; color: #ffffff; }
        .brand-badge {
            width: 40px; height: 40px; border-radius: 12px;
            background: rgba(255,255,255,0.15);
            color: #fff; display: flex; align-items: center; justify-content: center; font-size: 16px;
        }
        .back-btn {
            display: inline-flex; align-items: center; justify-content: center;
            width: 40px; height: 40px; border-radius: 50%;
            background: rgba(255,255,255,0.15); border: 1px solid rgba(255,255,255,0.3);
            color: #fff; cursor: pointer; text-decoration: none;
            transition: background 0.2s;
        }
        .back-btn:hover { background: rgba(255,255,255,0.25); }

        /* Profile card */
        .profile-card {
            background: var(--surface); backdrop-filter: blur(14px);
            border: 1px solid var(--border); border-radius: 28px;
            box-shadow: var(--shadow); overflow: hidden;
        }
        .profile-banner {
            height: 120px;
            background: linear-gradient(135deg, var(--uni-accent) 0%, var(--uni-accent-dark) 55%, var(--uni-header-bg) 100%);
            position: relative;
        }
        .profile-avatar-wrap {
            position: absolute; bottom: -50px; left: 50%;
            transform: translateX(-50%); cursor: pointer;
        }
        .profile-avatar {
            width: 100px; height: 100px; border-radius: 50%;
            background: linear-gradient(135deg, var(--uni-accent), var(--uni-accent-dark));
            border: 4px solid #ffffff;
            display: flex; align-items: center; justify-content: center;
            font-size: 40px; color: #fff;
            box-shadow: 0 8px 24px rgba(0,0,0,0.2);
            overflow: hidden; position: relative;
        }
        .profile-avatar img { width: 100%; height: 100%; object-fit: cover; display: block; border-radius: 50%; }
        .avatar-overlay {
            position: absolute; inset: 0; background: rgba(0,0,0,0.45);
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            flex-direction: column; gap: 2px; opacity: 0; transition: opacity 0.2s;
        }
        .profile-avatar-wrap:hover .avatar-overlay { opacity: 1; }
        .avatar-overlay i { font-size: 20px; color: #fff; }
        .avatar-overlay span { font-size: 10px; color: #fff; font-weight: 600; }

        .profile-body { padding: 62px 28px 28px; text-align: center; }
        .profile-name { font-size: 24px; font-weight: 800; color: var(--primary); margin-bottom: 6px; }
        .profile-role-badge {
            display: inline-block; padding: 4px 16px; border-radius: 20px;
            font-size: 12px; font-weight: 700; background: #fef3c7; color: var(--uni-accent); margin-bottom: 6px;
        }
        .profile-role-badge.admin { background: #EDE9FE; color: #5B21B6; }
        .profile-tagline { color: var(--muted); font-size: 13px; margin-bottom: 20px; }

        .upload-btn {
            display: inline-flex; align-items: center; gap: 8px; position: relative;
            background: linear-gradient(135deg, var(--uni-accent), var(--uni-accent-dark)); color: #fff;
            border-radius: 40px; padding: 10px 22px; font-size: 13px; font-weight: 600;
            cursor: pointer; box-shadow: 0 4px 14px rgba(0,0,0,0.15);
            transition: transform 0.2s, box-shadow 0.2s; overflow: hidden; border: none;
        }
        .upload-btn:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(201,146,10,0.35); }
        .upload-status { display: none; margin-top: 10px; font-size: 12px; color: var(--primary); font-weight: 600; }

        /* Info card with edit */
        .info-card {
            background: var(--surface); backdrop-filter: blur(14px);
            border: 1px solid var(--border); border-radius: 24px;
            box-shadow: var(--shadow); overflow: hidden;
        }
        .info-card-header {
            padding: 14px 22px 10px;
            display: flex; align-items: center; justify-content: space-between;
            border-bottom: 1px solid var(--border);
        }
        .info-card-title { font-size: 13px; font-weight: 700; color: var(--primary); }
        .edit-toggle-btn {
            display: inline-flex; align-items: center; gap: 6px;
            background: var(--surface-soft); border: 1px solid var(--border);
            border-radius: 20px; padding: 6px 14px; font-size: 12px; font-weight: 600;
            color: var(--primary); cursor: pointer; transition: all 0.2s;
        }
        .edit-toggle-btn:hover { background: #fef3c7; border-color: var(--primary-2); }
        .edit-toggle-btn.active { background: linear-gradient(135deg, var(--uni-accent), var(--uni-accent-dark)); color: #fff; border-color: transparent; }

        .info-row {
            display: flex; align-items: center; gap: 16px;
            padding: 14px 22px; border-bottom: 1px solid var(--border);
        }
        .info-row:last-child { border-bottom: none; }
        .info-icon {
            width: 42px; height: 42px; border-radius: 12px;
            background: linear-gradient(135deg, var(--uni-accent), var(--uni-accent-dark)); color: #fff;
            display: flex; align-items: center; justify-content: center;
            font-size: 16px; flex-shrink: 0;
        }
        .info-icon.locked { background: linear-gradient(135deg,#64748b,#94a3b8); }
        .info-text { flex: 1; min-width: 0; }
        .info-label {
            font-size: 11px; color: var(--muted); font-weight: 600;
            text-transform: uppercase; letter-spacing: 0.07em; margin-bottom: 2px;
        }
        .info-value {
            font-size: 15px; font-weight: 700; color: var(--primary);
            white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
        }
        .info-input {
            display: none; width: 100%; padding: 8px 12px;
            background: var(--surface-soft); border: 1.5px solid var(--primary-2);
            border-radius: 10px; font-size: 14px; font-weight: 600;
            color: var(--primary); outline: none; font-family: inherit;
        }
        .info-input:focus { box-shadow: 0 0 0 3px rgba(201,146,10,0.15); }

        /* Save / Cancel buttons */
        .edit-actions {
            display: none; padding: 14px 22px;
            border-top: 1px solid var(--border);
            gap: 10px; justify-content: flex-end;
        }
        .btn-save {
            padding: 10px 24px; border: none; border-radius: 40px;
            background: linear-gradient(135deg, var(--uni-accent), var(--uni-accent-dark)); color: #fff;
            font-size: 13px; font-weight: 700; cursor: pointer;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15); transition: all 0.2s;
        }
        .btn-save:hover { transform: translateY(-1px); box-shadow: 0 6px 16px rgba(0,0,0,0.25); }
        .btn-cancel-edit {
            padding: 10px 20px; border: 1px solid var(--border); border-radius: 40px;
            background: none; color: var(--muted); font-size: 13px; font-weight: 600;
            cursor: pointer; transition: all 0.2s;
        }
        .btn-cancel-edit:hover { background: var(--surface-soft); }

        /* Logout */
        .logout-btn {
            width: 100%; padding: 15px; border: none; border-radius: 20px;
            background: linear-gradient(135deg, #dc2626, #b91c1c); color: #fff;
            font-size: 15px; font-weight: 700; cursor: pointer;
            display: flex; align-items: center; justify-content: center; gap: 10px;
            transition: all 0.2s; box-shadow: 0 4px 14px rgba(220,38,38,0.28);
        }
        .logout-btn:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(220,38,38,0.38); }

        /* Toast */
        .toast-msg {
            position: fixed; bottom: 28px; left: 50%; transform: translateX(-50%);
            background: var(--uni-accent); color: #fff; padding: 10px 24px; border-radius: 30px;
            font-size: 13px; z-index: 9999; box-shadow: 0 4px 16px rgba(0,0,0,.25);
            animation: toastFade 2.6s ease forwards; pointer-events: none;
        }
        @keyframes toastFade {
            0%   { opacity:0; transform:translateX(-50%) translateY(10px); }
            12%  { opacity:1; transform:translateX(-50%) translateY(0); }
            80%  { opacity:1; }
            100% { opacity:0; }
        }

        /* Dark mode */
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
            --shadow: 0 8px 32px rgba(0,0,0,0.5);
        }
        body.dark-mode { background-image: linear-gradient(rgba(18,18,18,0.92),rgba(18,18,18,0.92)),var(--bg-image); background-color: #121212; }
        body.dark-mode .topbar {
            background: rgba(25,25,25,0.95);
            border-color: rgba(255,255,255,0.08);
            box-shadow: 0 4px 24px rgba(0,0,0,0.5);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
        }
        body.dark-mode .profile-avatar { border-color: rgba(30,30,30,0.98); }
        body.dark-mode .profile-role-badge       { background: rgba(201,146,10,0.22); color: var(--uni-accent, #fcd34d); }
        body.dark-mode .profile-role-badge.admin { background: rgba(168,120,0,0.28); color: var(--primary, #fde68a); }
        body.dark-mode .profile-name { color: #e0e7ff; }
        body.dark-mode .info-value   { color: #e0e7ff; }
        body.dark-mode .info-input   { background: rgba(51,65,85,0.8); color: #e0e7ff; border-color: var(--uni-accent, #60a5fa); }
        body.dark-mode .info-card-title { color: #e0e7ff; }
        body.dark-mode .edit-toggle-btn { color: var(--primary, #93c5fd); }

        @media (max-width: 700px) {
            .topbar { top: 0; left: 0; right: 0; padding: 10px 16px; border-radius: 0 0 18px 18px; }
            .page-shell { padding: 70px 12px 40px; }
            .profile-body { padding: 60px 18px 22px; }
            .profile-banner { height: 100px; }
            .info-row { padding: 12px 16px; }
            .profile-columns { grid-template-columns: 1fr; }
        }
        @media (max-width: 480px) {
            .page-shell { padding: 66px 10px 32px; }
            .profile-name { font-size: 20px; }
            .info-value { font-size: 13px; }
            .upload-btn { font-size: 12px; padding: 8px 16px; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div class="page-shell profile-shell">
            <div class="page-wrap">

                <!-- Topbar -->
                <div class="topbar">
                    <div class="brand">
                        <div class="brand-badge"><i class="fas fa-university"></i></div>
                        <span>Campus Annnouncement</span>
                    </div>
                    <a class="back-btn" href="<%= BackUrl %>" title="Back to Portal">
                        <i class="fas fa-home" style="font-size:16px;"></i>
                    </a>
                </div>

                <!-- Two-column layout -->
                <div class="profile-columns">
                    <div class="profile-col-left">

                <!-- Profile Card -->
                <div class="profile-card">
                    <div class="profile-banner">
                        <div class="profile-avatar-wrap"
                             onclick="document.getElementById('photoUpload').click();"
                             title="Click to change photo">
                            <div class="profile-avatar" id="avatarCircle">
                                <% if (!string.IsNullOrEmpty(ProfileImage)) { %>
                                    <img id="avatarImg" src="<%= ProfileImage %>" alt="Profile Photo"
                                         style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;" />
                                <% } else { %>
                                    <i class="fas fa-user" id="avatarIcon"></i>
                                <% } %>
                                <div class="avatar-overlay">
                                    <i class="fas fa-camera"></i>
                                    <span>Change</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="profile-body">
                        <div class="profile-name" id="displayName"><%= Username %></div>
                        <div class="profile-role-badge <%= Role == "Admin" ? "admin" : "" %>">
                            <i class="fas fa-<%= Role == "Admin" ? "chalkboard-teacher" : "user-graduate" %>"
                               style="margin-right:5px;"></i><%= Role %>
                        </div>
                        <div class="profile-tagline">Cebu Technological University � Campus Connect Portal</div>

                        <asp:FileUpload ID="photoUpload" runat="server" ClientIDMode="Static"
                            accept="image/*" Style="display:none;" />
                        <button type="button" class="upload-btn"
                                onclick="document.getElementById('photoUpload').click();">
                            <i class="fas fa-camera"></i> Change Photo
                        </button>
                        <div class="upload-status" id="uploadStatus"></div>
                    </div>
                </div>

                    </div><!-- end col-left -->
                    <div class="profile-col-right">

                <!-- Info Card with Edit -->
                <div class="info-card">
                    <div class="info-card-header">
                        <span class="info-card-title"><i class="fas fa-id-card" style="margin-right:6px;"></i>Account Info</span>
                        <button type="button" class="edit-toggle-btn" id="editToggleBtn" onclick="toggleEdit()">
                            <i class="fas fa-pen"></i> Edit
                        </button>
                    </div>

                    <!-- Full Name -->
                    <div class="info-row">
                        <div class="info-icon"><i class="fas fa-user"></i></div>
                        <div class="info-text">
                            <div class="info-label">Full Name</div>
                            <div class="info-value" id="val-fullname"><%= FullName %></div>
                            <input type="text" class="info-input" id="inp-fullname"
                                   value="<%= System.Web.HttpUtility.HtmlAttributeEncode(FullName) %>"
                                   maxlength="100" placeholder="Full name" />
                        </div>
                    </div>

                    <!-- Username -->
                    <div class="info-row">
                        <div class="info-icon"><i class="fas fa-at"></i></div>
                        <div class="info-text">
                            <div class="info-label">Username</div>
                            <div class="info-value" id="val-username"><%= Username %></div>
                            <input type="text" class="info-input" id="inp-username"
                                   value="<%= System.Web.HttpUtility.HtmlAttributeEncode(Username) %>"
                                   maxlength="50" placeholder="Username" />
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="info-row">
                        <div class="info-icon"><i class="fas fa-envelope"></i></div>
                        <div class="info-text">
                            <div class="info-label">Email Address</div>
                            <div class="info-value" id="val-email"><%= Email %></div>
                            <input type="email" class="info-input" id="inp-email"
                                   value="<%= System.Web.HttpUtility.HtmlAttributeEncode(Email) %>"
                                   maxlength="100" placeholder="Email address" />
                        </div>
                    </div>

                    <!-- Role � read only -->
                    <div class="info-row">
                        <div class="info-icon locked"><i class="fas fa-shield-alt"></i></div>
                        <div class="info-text">
                            <div class="info-label">Role <span style="font-size:10px;color:var(--muted-light);">(cannot be changed)</span></div>
                            <div class="info-value"><%= Role %></div>
                        </div>
                    </div>

                    <!-- Save / Cancel -->
                    <div class="edit-actions" id="editActions">
                        <button type="button" class="btn-cancel-edit" onclick="cancelEdit()">Cancel</button>
                        <button type="button" class="btn-save" onclick="saveProfile()">
                            <i class="fas fa-check" style="margin-right:6px;"></i>Save Changes
                        </button>
                    </div>
                </div>

                <!-- Hidden fields for postback -->
                <asp:HiddenField ID="hfAction"   runat="server" />
                <asp:HiddenField ID="hfFullName" runat="server" />
                <asp:HiddenField ID="hfUsername" runat="server" />
                <asp:HiddenField ID="hfEmail"    runat="server" />

                    </div><!-- end col-right -->
                </div><!-- end profile-columns -->

                <!-- Logout � always at the bottom -->
                <button type="button" class="logout-btn" onclick="confirmLogout()">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </button>

            </div>
        </div>

        <% if (!string.IsNullOrEmpty(UploadMessage)) { %>
        <script>
            window.addEventListener('load', function () {
                showToast('<%= UploadMessage.Replace("'", "\\'") %>');
            });
        </script>
        <% } %>
    </form>

    <script>
        // -- Theme ----------------------------------------------
        (function () {
            document.body.classList.toggle('dark-mode', localStorage.getItem('campus_theme') === 'dark');
            window.addEventListener('storage', function (e) {
                if (e.key === 'campus_theme')
                    document.body.classList.toggle('dark-mode', e.newValue === 'dark');
            });
        })();

        // -- University Theme -----------------------------------------
        (function () {
            var UNIVERSITY_THEMES = {
                'Default':       { overlay: 'rgba(255,255,255,0)',      header: '#c9920a', accent: '#c9920a', accentDark: '#a87800' },
                'Intramurals':   { overlay: 'rgba(180,30,30,0.18)',     header: '#b91c1c', accent: '#b91c1c', accentDark: '#991b1b' },
                'FoundationWeek':{ overlay: 'rgba(201,146,10,0.18)',    header: '#a87800', accent: '#a87800', accentDark: '#7a5200' },
                'WomensMonth':   { overlay: 'rgba(147,51,234,0.18)',    header: '#7c3aed', accent: '#7c3aed', accentDark: '#5b21b6' },
                'Christmas':     { overlay: 'rgba(22,101,52,0.20)',     header: '#15803d', accent: '#15803d', accentDark: '#14532d' }
            };
            function applyUniversityTheme(name) {
                var t = UNIVERSITY_THEMES[name] || UNIVERSITY_THEMES['Default'];
                document.documentElement.style.setProperty('--uni-overlay', t.overlay);
                document.documentElement.style.setProperty('--uni-header-bg', t.header);
                document.documentElement.style.setProperty('--uni-accent', t.accent);
                document.documentElement.style.setProperty('--uni-accent-dark', t.accentDark);
                // Apply body class for university-theme-decorations.css
                var ALL_CLASSES = ['theme-default','theme-intramurals','theme-foundation','theme-womens','theme-christmas'];
                ALL_CLASSES.forEach(function(c){ document.body.classList.remove(c); });
                var clsMap = { 'Default':'theme-default','Intramurals':'theme-intramurals','FoundationWeek':'theme-foundation','WomensMonth':'theme-womens','Christmas':'theme-christmas' };
                document.body.classList.add(clsMap[name] || 'theme-default');
                localStorage.setItem('campus_uni_theme', name);
            }
            var saved = localStorage.getItem('campus_uni_theme');
            if (saved) applyUniversityTheme(saved);
            fetch('UserMgmtHandler.ashx?action=getTheme', { credentials: 'same-origin' })
                .then(function(r) { return r.json(); })
                .then(function(res) { if (res.ok) applyUniversityTheme(res.theme); })
                .catch(function() {});
            window.addEventListener('storage', function(e) {
                if (e.key === 'campus_uni_theme') applyUniversityTheme(e.newValue);
            });
        })();

        // -- Toast ----------------------------------------------
        function showToast(msg) {
            var t = document.createElement('div');
            t.className = 'toast-msg'; t.textContent = msg;
            document.body.appendChild(t);
            setTimeout(function () { if (t.parentNode) t.parentNode.removeChild(t); }, 2700);
        }

        // -- Logout ---------------------------------------------
        function confirmLogout() { window.location.href = 'Logout.aspx'; }

        // -- Edit toggle ----------------------------------------
        var editing = false;

        function toggleEdit() {
            editing = !editing;
            var btn = document.getElementById('editToggleBtn');
            var actions = document.getElementById('editActions');
            var values  = document.querySelectorAll('.info-value[id^="val-"]');
            var inputs  = document.querySelectorAll('.info-input');

            if (editing) {
                btn.innerHTML = '<i class="fas fa-times"></i> Cancel';
                btn.classList.add('active');
                values.forEach(function (v) { v.style.display = 'none'; });
                inputs.forEach(function (i) { i.style.display = 'block'; });
                actions.style.display = 'flex';
                document.getElementById('inp-fullname').focus();
            } else {
                cancelEdit();
            }
        }

        function cancelEdit() {
            editing = false;
            var btn = document.getElementById('editToggleBtn');
            btn.innerHTML = '<i class="fas fa-pen"></i> Edit';
            btn.classList.remove('active');
            document.querySelectorAll('.info-value[id^="val-"]').forEach(function (v) { v.style.display = ''; });
            document.querySelectorAll('.info-input').forEach(function (i) { i.style.display = 'none'; });
            document.getElementById('editActions').style.display = 'none';
        }

        function saveProfile() {
            var fullName = document.getElementById('inp-fullname').value.trim();
            var username = document.getElementById('inp-username').value.trim();
            var email    = document.getElementById('inp-email').value.trim();

            if (!fullName) { showToast('Full name cannot be empty.'); return; }
            if (!username) { showToast('Username cannot be empty.'); return; }
            if (!email || !email.includes('@')) { showToast('Please enter a valid email.'); return; }

            // Set hidden fields and submit
            document.getElementById('<%= hfAction.ClientID %>').value   = 'updateProfile';
            document.getElementById('<%= hfFullName.ClientID %>').value = fullName;
            document.getElementById('<%= hfUsername.ClientID %>').value = username;
            document.getElementById('<%= hfEmail.ClientID %>').value    = email;
            document.getElementById('form1').submit();
        }

        // -- Photo upload ----------------------------------------
        var photoInput = document.getElementById('photoUpload');
        if (photoInput) {
            photoInput.addEventListener('change', function () {
                var file = this.files[0];
                if (!file) return;
                if (!file.type.startsWith('image/')) { showToast('Please select an image file.'); return; }
                if (file.size > 2 * 1024 * 1024) { showToast('Image must be smaller than 2MB.'); return; }

                // Show local preview immediately
                var reader = new FileReader();
                reader.onload = function (ev) {
                    updateAvatarSrc(ev.target.result);
                };
                reader.readAsDataURL(file);

                // Show uploading status
                var status = document.getElementById('uploadStatus');
                if (status) {
                    status.style.display = 'block';
                    status.style.color = 'var(--muted)';
                    status.innerHTML = '<i class="fas fa-spinner fa-spin" style="margin-right:6px;"></i>Uploading...';
                }

                // Upload via AJAX � no page reload
                var fd = new FormData();
                fd.append('photo', file);

                fetch('UploadProfilePhoto.ashx', {
                    method: 'POST',
                    credentials: 'same-origin',
                    body: fd
                })
                .then(function(r) { return r.json(); })
                .then(function(res) {
                    if (res.ok) {
                        // imagePath already has cache-bust from server
                        updateAvatarSrc(res.imagePath);

                        if (status) {
                            status.style.color = '#16a34a';
                            status.innerHTML = '<i class="fas fa-check-circle" style="margin-right:6px;"></i>Profile photo updated!';
                            setTimeout(function() { status.style.display = 'none'; }, 3000);
                        }
                        showToast('? Profile photo updated!');

                        // Also update the header avatar on this page if it exists
                        var headerAvatar = document.getElementById('headerAvatar');
                        if (headerAvatar) {
                            var hImg = headerAvatar.querySelector('img');
                            if (hImg) { hImg.src = res.imagePath; }
                            else {
                                headerAvatar.innerHTML = '<img src="' + res.imagePath + '" style="width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;" />';
                            }
                        }
                    } else {
                        if (status) {
                            status.style.color = '#dc2626';
                            status.innerHTML = '<i class="fas fa-exclamation-circle" style="margin-right:6px;"></i>' + (res.error || 'Upload failed.');
                        }
                        showToast('? ' + (res.error || 'Upload failed.'));
                    }
                })
                .catch(function(err) {
                    if (status) {
                        status.style.color = '#dc2626';
                        status.innerHTML = '<i class="fas fa-exclamation-circle" style="margin-right:6px;"></i>Network error. Please try again.';
                    }
                    showToast('? Network error. Please try again.');
                });

                // Reset input so same file can be re-selected
                photoInput.value = '';
            });
        }

        function updateAvatarSrc(src) {
            var circle = document.getElementById('avatarCircle');
            if (!circle) return;
            var icon = circle.querySelector('#avatarIcon');
            if (icon) icon.style.display = 'none';
            var img = circle.querySelector('#avatarImg');
            if (img) {
                img.src = src;
            } else {
                var newImg = document.createElement('img');
                newImg.id = 'avatarImg';
                newImg.alt = 'Profile Photo';
                newImg.src = src;
                newImg.style.cssText = 'width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;';
                circle.insertBefore(newImg, circle.firstChild);
            }
        }
    </script>
<link rel="stylesheet" href="university-theme-decorations.css" />
<script src="university-theme.js"></script>
</body>
</html>


