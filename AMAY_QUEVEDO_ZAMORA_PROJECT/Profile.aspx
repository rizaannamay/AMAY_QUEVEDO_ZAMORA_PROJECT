<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Profile" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Campus Connect - My Profile</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        :root {
            --bg-image: url('wbg.jpg');
            --page-text: #1a2a3a;
            --surface: rgba(255, 255, 255, 0.93);
            --surface-strong: #ffffff;
            --surface-soft: #f0f5ff;
            --border: rgba(26, 58, 92, 0.12);
            --primary: #1a3a5c;
            --primary-2: #2563eb;
            --muted: #6b7c8f;
            --muted-light: #9db0c4;
            --shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
        }

        body {
            min-height: 100vh;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            color: var(--page-text);
            background-image: linear-gradient(rgba(255,255,255,0.18), rgba(255,255,255,0.18)), var(--bg-image);
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            background-attachment: fixed;
        }

        a { color: inherit; text-decoration: none; }

        .page-shell { min-height: 100vh; padding: 28px 20px 48px; }

        .page-wrap {
            max-width: 560px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            gap: 18px;
        }

        /* ── Topbar ── */
        .topbar {
            background: var(--surface);
            backdrop-filter: blur(14px);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 14px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: var(--shadow);
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 18px;
            font-weight: 800;
            color: var(--primary);
        }

        .brand-badge {
            width: 40px; height: 40px;
            border-radius: 12px;
            background: linear-gradient(135deg, #1a3a5c, #2563eb);
            color: #fff;
            display: flex; align-items: center; justify-content: center;
            font-size: 16px;
        }

        .back-btn {
            display: inline-flex; align-items: center; justify-content: center;
            width: 40px; height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #1a3a5c, #2563eb);
            color: #fff; border: none;
            box-shadow: var(--shadow);
            transition: transform 0.2s, box-shadow 0.2s;
            cursor: pointer; text-decoration: none;
        }
        .back-btn:hover { transform: translateY(-2px); box-shadow: 0 6px 18px rgba(37,99,235,0.35); }

        /* ── Profile Card ── */
        .profile-card {
            background: var(--surface);
            backdrop-filter: blur(14px);
            border: 1px solid var(--border);
            border-radius: 28px;
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        /* Banner */
        .profile-banner {
            height: 120px;
            background: linear-gradient(135deg, #1a3a5c 0%, #2563eb 55%, #7c3aed 100%);
            position: relative;
        }

        /* Avatar centered on banner bottom */
        .profile-avatar-wrap {
            position: absolute;
            bottom: -50px;
            left: 50%;
            transform: translateX(-50%);
            cursor: pointer;
        }

        .profile-avatar {
            width: 100px; height: 100px;
            border-radius: 50%;
            background: linear-gradient(135deg, #1e3a8a, #2563eb);
            border: 4px solid #ffffff;
            display: flex; align-items: center; justify-content: center;
            font-size: 40px; color: #fff;
            box-shadow: 0 8px 24px rgba(0,0,0,0.2);
            overflow: hidden;
            position: relative;
        }

        .profile-avatar img {
            width: 100%; height: 100%;
            object-fit: cover;
            display: block;
            border-radius: 50%;
        }

        .avatar-overlay {
            position: absolute;
            inset: 0;
            background: rgba(0,0,0,0.45);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            gap: 2px;
            opacity: 0;
            transition: opacity 0.2s;
        }
        .profile-avatar-wrap:hover .avatar-overlay { opacity: 1; }
        .avatar-overlay i { font-size: 20px; color: #fff; }
        .avatar-overlay span { font-size: 10px; color: #fff; font-weight: 600; }

        /* Body below banner */
        .profile-body {
            padding: 62px 28px 28px;
            text-align: center;
        }

        .profile-name {
            font-size: 24px; font-weight: 800;
            color: var(--primary); margin-bottom: 6px;
        }

        .profile-role-badge {
            display: inline-block;
            padding: 4px 16px; border-radius: 20px;
            font-size: 12px; font-weight: 700;
            background: #DBEAFE; color: #1E3A8A;
            margin-bottom: 6px;
        }
        .profile-role-badge.admin { background: #EDE9FE; color: #5B21B6; }

        .profile-tagline {
            color: var(--muted); font-size: 13px;
            margin-bottom: 20px;
        }

        /* Upload button */
        .upload-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            position: relative;
            background: linear-gradient(135deg, #2563eb, #3b82f6);
            color: #fff;
            border-radius: 40px;
            padding: 10px 22px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 4px 14px rgba(37,99,235,0.25);
            transition: transform 0.2s, box-shadow 0.2s;
            overflow: hidden;
        }
        .upload-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(37,99,235,0.35);
        }
        .upload-btn input[type="file"] {
            position: absolute;
            inset: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
            cursor: pointer;
        }

        .upload-status {
            display: none;
            margin-top: 10px;
            font-size: 12px;
            color: var(--primary);
            font-weight: 600;
        }

        /* ── Info list card ── */
        .info-card {
            background: var(--surface);
            backdrop-filter: blur(14px);
            border: 1px solid var(--border);
            border-radius: 24px;
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        .info-row {
            display: flex;
            align-items: center;
            gap: 16px;
            padding: 16px 22px;
            border-bottom: 1px solid var(--border);
        }
        .info-row:last-child { border-bottom: none; }

        .info-icon {
            width: 42px; height: 42px;
            border-radius: 12px;
            background: linear-gradient(135deg, #1a3a5c, #2563eb);
            color: #fff;
            display: flex; align-items: center; justify-content: center;
            font-size: 16px; flex-shrink: 0;
        }

        .info-text { flex: 1; min-width: 0; }

        .info-label {
            font-size: 11px; color: var(--muted);
            font-weight: 600; text-transform: uppercase;
            letter-spacing: 0.07em; margin-bottom: 2px;
        }

        .info-value {
            font-size: 15px; font-weight: 700;
            color: var(--primary);
            white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
        }

        /* ── Logout ── */
        .logout-btn {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 20px;
            background: linear-gradient(135deg, #dc2626, #b91c1c);
            color: #fff;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: all 0.2s;
            box-shadow: 0 4px 14px rgba(220,38,38,0.28);
        }
        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(220,38,38,0.38);
        }

        .footer-note {
            text-align: center; color: var(--muted);
            font-size: 12px; padding-bottom: 4px;
        }

        /* ── Toast ── */
        .toast-msg {
            position: fixed; bottom: 28px; left: 50%;
            transform: translateX(-50%);
            background: #1a3a5c; color: #fff;
            padding: 10px 24px; border-radius: 30px;
            font-size: 13px; z-index: 9999;
            box-shadow: 0 4px 16px rgba(0,0,0,.25);
            animation: toastFade 2.6s ease forwards;
            pointer-events: none;
        }
        @keyframes toastFade {
            0%   { opacity:0; transform:translateX(-50%) translateY(10px); }
            12%  { opacity:1; transform:translateX(-50%) translateY(0); }
            80%  { opacity:1; }
            100% { opacity:0; }
        }

        /* ── Dark mode ── */
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
        body.dark-mode {
            background-image: linear-gradient(rgba(15,23,42,0.85), rgba(15,23,42,0.85)), var(--bg-image);
        }
        body.dark-mode .profile-avatar { border-color: rgba(30,41,59,0.98); }
        body.dark-mode .profile-role-badge       { background: rgba(59,130,246,0.25); color: #93c5fd; }
        body.dark-mode .profile-role-badge.admin { background: rgba(139,92,246,0.25); color: #c4b5fd; }
        body.dark-mode .brand        { color: #e0e7ff; }
        body.dark-mode .profile-name { color: #e0e7ff; }
        body.dark-mode .info-value   { color: #e0e7ff; }

        @media (max-width: 600px) {
            .page-shell { padding: 14px 12px 40px; }
            .profile-body { padding: 60px 18px 22px; }
            .profile-banner { height: 100px; }
            .info-row { padding: 14px 16px; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div class="page-shell">
            <div class="page-wrap">

                <!-- Topbar -->
                <div class="topbar">
                    <div class="brand">
                        <div class="brand-badge"><i class="fas fa-university"></i></div>
                        <span>Campus Connect</span>
                    </div>
                    <a class="back-btn" href="<%= BackUrl %>" title="Back to Portal">
                        <i class="fas fa-home" style="font-size:16px;"></i>
                    </a>
                </div>

                <!-- Profile Card (banner + avatar + name + upload) -->
                <div class="profile-card">
                    <div class="profile-banner">
                        <div class="profile-avatar-wrap"
                             onclick="document.getElementById('photoUpload').click();"
                             title="Click to change photo">                            <div class="profile-avatar" id="avatarCircle">
                                <% if (!string.IsNullOrEmpty(ProfileImage)) { %>
                                    <img id="avatarImg"
                                         src="<%= ProfileImage %>"
                                         alt="Profile Photo"
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
                        <div class="profile-name"><%= FullName %></div>
                        <div class="profile-role-badge <%= Role == "Admin" ? "admin" : "" %>">
                            <i class="fas fa-<%= Role == "Admin" ? "chalkboard-teacher" : "user-graduate" %>"
                               style="margin-right:5px;"></i><%= Role %>
                        </div>
                        <div class="profile-tagline">
                            Cebu Technological University — Campus Connect Portal
                        </div>

                        <!-- Upload button -->
                        <asp:FileUpload ID="photoUpload" runat="server"
                            ClientIDMode="Static"
                            accept="image/*"
                            Style="display:none;" />
                        <button type="button" class="upload-btn" onclick="document.getElementById('photoUpload').click();">
                            <i class="fas fa-camera"></i>
                            Change Photo
                        </button>
                        <div class="upload-status" id="uploadStatus"></div>
                    </div>
                </div>

                <!-- Info List -->
                <div class="info-card">
                    <div class="info-row">
                        <div class="info-icon"><i class="fas fa-user"></i></div>
                        <div class="info-text">
                            <div class="info-label">Full Name</div>
                            <div class="info-value"><%= FullName %></div>
                        </div>
                    </div>
                    <div class="info-row">
                        <div class="info-icon"><i class="fas fa-at"></i></div>
                        <div class="info-text">
                            <div class="info-label">Username</div>
                            <div class="info-value"><%= Username %></div>
                        </div>
                    </div>
                    <div class="info-row">
                        <div class="info-icon"><i class="fas fa-envelope"></i></div>
                        <div class="info-text">
                            <div class="info-label">Email Address</div>
                            <div class="info-value"><%= Email %></div>
                        </div>
                    </div>
                    <div class="info-row">
                        <div class="info-icon"><i class="fas fa-shield-alt"></i></div>
                        <div class="info-text">
                            <div class="info-label">Role</div>
                            <div class="info-value"><%= Role %></div>
                        </div>
                    </div>
                </div>

                <!-- Logout -->
                <button type="button" class="logout-btn" onclick="confirmLogout()">
                    <i class="fas fa-sign-out-alt"></i>
                    Logout
                </button>

                <div class="footer-note">
                    <i class="fas fa-shield-alt" style="margin-right:4px;"></i>
                    Cebu Technological University — Campus Connect Portal
                </div>

            </div>
        </div>

        <% if (!string.IsNullOrEmpty(UploadMessage)) { %>
        <script>
            window.addEventListener('load', function() {
                showToast('<%= UploadMessage.Replace("'", "\\'") %>');
            });
        </script>
        <% } %>
    </form>

    <script>
        // ── Theme ──────────────────────────────────────────────
        (function () {
            var isDark = localStorage.getItem('campus_theme') === 'dark';
            document.body.classList.toggle('dark-mode', isDark);
            window.addEventListener('storage', function (e) {
                if (e.key === 'campus_theme')
                    document.body.classList.toggle('dark-mode', e.newValue === 'dark');
            });
        })();

        // ── Toast ──────────────────────────────────────────────
        function showToast(msg) {
            var t = document.createElement('div');
            t.className = 'toast-msg';
            t.textContent = msg;
            document.body.appendChild(t);
            setTimeout(function () { if (t.parentNode) t.parentNode.removeChild(t); }, 2700);
        }

        // ── Logout ─────────────────────────────────────────────
        function confirmLogout() {
            window.location.href = 'Logout.aspx';
        }

        // ── Photo upload ────────────────────────────────────────
        var photoInput = document.getElementById('photoUpload');
        if (photoInput) {
            photoInput.addEventListener('change', function () {
                var file = this.files[0];
                if (!file) return;

                if (!file.type.startsWith('image/')) {
                    showToast('Please select an image file.');
                    return;
                }
                if (file.size > 5 * 1024 * 1024) {
                    showToast('Image must be smaller than 5MB.');
                    return;
                }

                // Instant preview in avatar circle
                var reader = new FileReader();
                reader.onload = function (ev) {
                    var circle = document.getElementById('avatarCircle');
                    if (circle) {
                        var icon = circle.querySelector('#avatarIcon');
                        if (icon) icon.style.display = 'none';
                        var img = circle.querySelector('#avatarImg');
                        if (img) {
                            img.src = ev.target.result;
                        } else {
                            var newImg = document.createElement('img');
                            newImg.id = 'avatarImg';
                            newImg.alt = 'Profile Photo';
                            newImg.src = ev.target.result;
                            newImg.style.cssText = 'width:100%;height:100%;object-fit:cover;border-radius:50%;display:block;';
                            circle.insertBefore(newImg, circle.firstChild);
                        }
                    }
                };
                reader.readAsDataURL(file);

                // Show spinner
                var status = document.getElementById('uploadStatus');
                if (status) {
                    status.style.display = 'block';
                    status.innerHTML = '<i class="fas fa-spinner fa-spin" style="margin-right:6px;"></i>Uploading...';
                }

                document.getElementById('form1').submit();
            });
        }
    </script>
</body>
</html>
