<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signin.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.signin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Campus Connect - Register</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #b2ebf2 0%, #80deea 50%, #4dd0e1 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        /* ── OUTER CARD ── */
        .auth-card {
            display: flex;
            width: 100%;
            max-width: 820px;
            min-height: 540px;
            background: #ffffff;
            border-radius: 28px;
            overflow: hidden;
            box-shadow: 0 24px 60px rgba(0, 0, 0, 0.18);
        }

        /* ── LEFT FORM PANEL ── */
        .panel-left {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 44px 44px;
            background: #ffffff;
        }

        .panel-left h1 {
            font-size: 28px;
            font-weight: 800;
            color: #1a2a3a;
            margin-bottom: 22px;
            text-align: center;
        }

        /* ── INPUTS ── */
        .input-wrap {
            position: relative;
            width: 100%;
            margin-bottom: 13px;
        }
        .input-wrap input {
            width: 100%;
            padding: 12px 44px 12px 18px;
            background: #f4f6f9;
            border: 1.5px solid #e0e6ed;
            border-radius: 12px;
            font-size: 14px;
            color: #1a2a3a;
            font-family: inherit;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .input-wrap input::placeholder { color: #a8b8c8; }
        .input-wrap input:focus {
            outline: none;
            border-color: #00838f;
            box-shadow: 0 0 0 3px rgba(0,131,143,0.12);
            background: #ffffff;
        }
        .input-wrap .icon {
            position: absolute;
            right: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #b0c0d0;
            font-size: 14px;
            pointer-events: none;
        }

        /* ── ROLE RADIOS ── */
        .role-row {
            display: flex;
            gap: 24px;
            width: 100%;
            background: #f4f6f9;
            border: 1.5px solid #e0e6ed;
            border-radius: 12px;
            padding: 11px 18px;
            margin-bottom: 13px;
        }
        .role-option {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            font-size: 14px;
            color: #2c3e50;
        }
        .role-option input[type="radio"] {
            width: 15px; height: 15px;
            accent-color: #00838f;
            cursor: pointer;
        }

        /* ── REGISTER BUTTON ── */
        .btn-register {
            width: 100%;
            padding: 13px;
            background: linear-gradient(135deg, #004d5e 0%, #00bcd4 100%);
            color: #ffffff;
            border: none;
            border-radius: 40px;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.25s;
            letter-spacing: 0.5px;
            margin-bottom: 14px;
        }
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(0,131,143,0.3);
        }

        /* ── SOCIAL ── */
        .social-label {
            font-size: 12px;
            color: #9aabb8;
            margin-bottom: 12px;
            text-align: center;
        }
        .social-row {
            display: flex;
            gap: 10px;
            justify-content: center;
        }
        .social-btn {
            width: 44px; height: 44px;
            border: 1.5px solid #dce4ec;
            border-radius: 10px;
            background: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 17px;
            color: #555;
            text-decoration: none;
            transition: all 0.2s;
        }
        .social-btn:hover {
            border-color: #00838f;
            color: #00838f;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,131,143,0.12);
        }

        /* ── MESSAGES ── */
        .msg-box {
            width: 100%;
            padding: 10px 14px;
            border-radius: 10px;
            font-size: 13px;
            margin-bottom: 12px;
            text-align: center;
            display: block;
        }
        .error-message   { background:#fef2f2; border-left:3px solid #dc2626; color:#dc2626; }
        .success-message { background:#f0fdf4; border-left:3px solid #16a34a; color:#16a34a; }

        /* ── RIGHT DARK TEAL PANEL ── */
        .panel-right {
            width: 42%;
            background: linear-gradient(160deg, #006978 0%, #003d47 100%);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 48px 36px;
            text-align: center;
            flex-shrink: 0;
            position: relative;
            overflow: hidden;
        }

        .panel-right::before {
            content: '';
            position: absolute;
            inset: 0;
            background:
                radial-gradient(circle at 25% 25%, rgba(255,255,255,0.09) 0%, transparent 55%),
                radial-gradient(circle at 75% 75%, rgba(255,255,255,0.06) 0%, transparent 50%);
            pointer-events: none;
        }

        .panel-right h2 {
            font-size: 32px;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 10px;
            line-height: 1.25;
            position: relative;
        }

        .panel-right .divider {
            width: 44px;
            height: 3px;
            background: rgba(255,255,255,0.4);
            border-radius: 2px;
            margin: 16px auto;
            position: relative;
        }

        .panel-right p {
            font-size: 13px;
            color: rgba(255,255,255,0.78);
            margin-bottom: 32px;
            position: relative;
        }

        .btn-outline-white {
            display: inline-block;
            padding: 11px 40px;
            border: 2px solid rgba(255,255,255,0.9);
            border-radius: 40px;
            color: #ffffff;
            font-size: 15px;
            font-weight: 700;
            text-decoration: none;
            background: transparent;
            transition: all 0.25s;
            letter-spacing: 0.5px;
            position: relative;
        }
        .btn-outline-white:hover {
            background: rgba(255,255,255,0.2);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }

        @media (max-width: 640px) {
            .auth-card { flex-direction: column-reverse; max-width: 420px; }
            .panel-right { width: 100%; padding: 36px 28px; }
            .panel-left { padding: 32px 24px; }
        }
    </style>
</head>
<body>
    <!-- ═══ SPLASH OVERLAY ═══ -->
    <div id="signinSplash" style="
        position:fixed;inset:0;background:#1c1f26;
        display:flex;flex-direction:column;align-items:center;justify-content:center;gap:22px;
        z-index:99999;transition:opacity 0.5s ease;">
        <img src="ctu-logo.png" alt="CTU Logo" style="
            width:150px;height:150px;object-fit:contain;
            filter:drop-shadow(0 0 18px rgba(0,188,212,0.55)) drop-shadow(0 0 40px rgba(0,188,212,0.25));
            animation:signinLogoPulse 2s ease-in-out infinite;" />
        <div style="font-family:'Segoe UI',sans-serif;font-size:15px;font-weight:700;
                    color:rgba(255,255,255,0.55);letter-spacing:3px;text-transform:uppercase;">
            Campus Announcement
        </div>
        <div style="font-family:'Segoe UI',sans-serif;font-size:11px;
                    color:rgba(255,255,255,0.3);letter-spacing:1.5px;margin-top:-14px;">
            Cebu Technological University
        </div>
    </div>
    <style>
        @keyframes signinLogoPulse {
            0%   { filter:drop-shadow(0 0 14px rgba(0,188,212,0.45)) drop-shadow(0 0 36px rgba(0,188,212,0.2)); }
            50%  { filter:drop-shadow(0 0 28px rgba(0,188,212,0.75)) drop-shadow(0 0 60px rgba(0,188,212,0.35)); }
            100% { filter:drop-shadow(0 0 14px rgba(0,188,212,0.45)) drop-shadow(0 0 36px rgba(0,188,212,0.2)); }
        }
    </style>
    <script>
        (function () {
            var splash = document.getElementById('signinSplash');
            if (!splash) return;
            setTimeout(function () {
                splash.style.opacity = '0';
                setTimeout(function () { splash.style.display = 'none'; }, 520);
            }, 1800);
        })();
    </script>

    <div class="auth-card">

        <!-- LEFT FORM PANEL -->
        <div class="panel-left">
            <form id="form1" runat="server" style="width:100%;max-width:320px;">
                <h1>Registration</h1>

                <div class="input-wrap">
                    <asp:TextBox ID="txtFullName" runat="server"
                        style="width:100%;padding:12px 44px 12px 18px;background:#f4f6f9;border:1.5px solid #e0e6ed;border-radius:12px;font-size:14px;color:#1a2a3a;font-family:inherit;"
                        placeholder="Full Name"></asp:TextBox>
                    <span class="icon"><i class="fas fa-user"></i></span>
                </div>

                <div class="input-wrap">
                    <asp:TextBox ID="txtUsername" runat="server"
                        style="width:100%;padding:12px 44px 12px 18px;background:#f4f6f9;border:1.5px solid #e0e6ed;border-radius:12px;font-size:14px;color:#1a2a3a;font-family:inherit;"
                        placeholder="Username"></asp:TextBox>
                    <span class="icon"><i class="fas fa-at"></i></span>
                </div>

                <div class="input-wrap">
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"
                        style="width:100%;padding:12px 44px 12px 18px;background:#f4f6f9;border:1.5px solid #e0e6ed;border-radius:12px;font-size:14px;color:#1a2a3a;font-family:inherit;"
                        placeholder="Email"></asp:TextBox>
                    <span class="icon"><i class="fas fa-envelope"></i></span>
                </div>

                <div class="input-wrap">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"
                        style="width:100%;padding:12px 44px 12px 18px;background:#f4f6f9;border:1.5px solid #e0e6ed;border-radius:12px;font-size:14px;color:#1a2a3a;font-family:inherit;"
                        placeholder="Password"></asp:TextBox>
                    <span class="icon"><i class="fas fa-lock"></i></span>
                </div>

                <div class="input-wrap">
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"
                        style="width:100%;padding:12px 44px 12px 18px;background:#f4f6f9;border:1.5px solid #e0e6ed;border-radius:12px;font-size:14px;color:#1a2a3a;font-family:inherit;"
                        placeholder="Confirm Password"></asp:TextBox>
                    <span class="icon"><i class="fas fa-lock"></i></span>
                </div>

                <div class="role-row">
                    <label class="role-option">
                        <asp:RadioButton ID="rbStudent" runat="server" GroupName="Role" Checked="true" />
                        <span>Student</span>
                    </label>
                    <label class="role-option">
                        <asp:RadioButton ID="rbAdmin" runat="server" GroupName="Role" />
                        <span>Admin</span>
                    </label>
                </div>

                <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="msg-box"></asp:Label>

                <asp:Button ID="btnSignUp" runat="server" Text="Register"
                    CssClass="btn-register" OnClick="BtnSignUp_Click" UseSubmitBehavior="true" />

                <div class="social-label">or register with social platforms</div>
                <div class="social-row">
                    <a href="#" class="social-btn" title="Google"><i class="fab fa-google"></i></a>
                    <a href="#" class="social-btn" title="Facebook"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social-btn" title="GitHub"><i class="fab fa-github"></i></a>
                    <a href="#" class="social-btn" title="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </form>
        </div>

        <!-- RIGHT DARK TEAL PANEL -->
        <div class="panel-right">
            <h2>Welcome<br />Back!</h2>
            <div class="divider"></div>
            <p>Already have an account?</p>
            <a href="login.aspx" class="btn-outline-white">Login</a>
        </div>
    </div>

    <script>
        (function () {
            var pw  = document.getElementById('<%= txtPassword.ClientID %>');
            var cpw = document.getElementById('<%= txtConfirmPassword.ClientID %>');
            if (pw && cpw) {
                cpw.addEventListener('input', function () {
                    this.style.borderColor = (this.value === pw.value && pw.value.length >= 6)
                        ? '#00838f' : '#e0e6ed';
                });
            }
        })();
    </script>
</body>
</html>
