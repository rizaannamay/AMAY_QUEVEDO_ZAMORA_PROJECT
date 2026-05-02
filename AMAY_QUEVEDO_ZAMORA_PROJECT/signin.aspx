<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signin.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.signin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Campus Connect — Register</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-image: url('ctu.png');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
            position: relative;
        }

        /* Darker overlay for readability */
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, 0.52);
            z-index: 0;
            pointer-events: none;
        }

        /* ── OUTER CARD ── */
        .auth-card {
            display: flex;
            width: 100%;
            max-width: 860px;
            min-height: 560px;
            background: transparent;
            border-radius: 28px;
            overflow: hidden;
            box-shadow: 0 28px 70px rgba(0, 0, 0, 0.55);
            position: relative;
            z-index: 1;
        }

        /* ── LEFT FORM PANEL ── */
        .panel-left {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 40px 44px;
            background: rgba(255, 255, 255, 0.14);
            backdrop-filter: blur(22px);
            -webkit-backdrop-filter: blur(22px);
            border-right: 1px solid rgba(255,255,255,0.22);
        }

        .panel-left h1 {
            font-size: 28px;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 4px;
            text-align: center;
            text-shadow: 0 2px 10px rgba(0,0,0,0.35);
        }

        .panel-left .subtitle {
            font-size: 13px;
            color: rgba(255,255,255,0.70);
            margin-bottom: 22px;
            text-align: center;
        }

        /* ── INPUTS ── */
        .input-wrap {
            position: relative;
            width: 100%;
            margin-bottom: 12px;
        }

        .input-wrap input {
            width: 100%;
            padding: 12px 46px 12px 18px;
            background: rgba(255,255,255,0.92);
            border: 1.5px solid rgba(255,255,255,0.5);
            border-radius: 12px;
            font-size: 14px;
            color: #1a2a3a;
            font-family: inherit;
            transition: border-color 0.2s, box-shadow 0.2s, background 0.2s;
        }

        .input-wrap input::placeholder { color: #7a8fa0; }

        .input-wrap input:focus {
            outline: none;
            border-color: #00bcd4;
            box-shadow: 0 0 0 3px rgba(0,188,212,0.28);
            background: #ffffff;
        }

        .input-wrap .icon {
            position: absolute;
            right: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #7a9aaa;
            font-size: 14px;
            pointer-events: none;
        }

        .input-wrap .toggle-pw {
            pointer-events: all;
            cursor: pointer;
            transition: color 0.2s;
        }
        .input-wrap .toggle-pw:hover { color: #00838f; }

        /* ── ROLE SELECT ── */
        .role-wrap {
            position: relative;
            width: 100%;
            margin-bottom: 12px;
        }
        .role-wrap select {
            width: 100%;
            padding: 12px 46px 12px 18px;
            background: rgba(255,255,255,0.92);
            border: 1.5px solid rgba(255,255,255,0.5);
            border-radius: 12px;
            font-size: 14px;
            color: #1a2a3a;
            font-family: inherit;
            appearance: none;
            -webkit-appearance: none;
            cursor: pointer;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .role-wrap select:focus {
            outline: none;
            border-color: #00bcd4;
            box-shadow: 0 0 0 3px rgba(0,188,212,0.28);
            background: #ffffff;
        }
        .role-wrap .icon { position: absolute; right: 16px; top: 50%; transform: translateY(-50%); color: #7a9aaa; font-size: 14px; pointer-events: none; }

        /* ── MESSAGES ── */
        .msg-box {
            width: 100%;
            padding: 10px 14px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 500;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .error-message   { background: rgba(254,226,226,0.95); border-left: 3px solid #dc2626; color: #b91c1c; }
        .success-message { background: rgba(240,253,244,0.95); border-left: 3px solid #16a34a; color: #15803d; }

        /* ── REGISTER BUTTON ── */
        .btn-register {
            width: 100%;
            padding: 13px;
            background: linear-gradient(135deg, #005f73 0%, #00bcd4 100%);
            color: #ffffff;
            border: none;
            border-radius: 40px;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.25s;
            letter-spacing: 0.5px;
            margin-bottom: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        .btn-register:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(0,131,143,0.45);
        }
        .btn-register:active:not(:disabled) { transform: translateY(0); }
        .btn-register:disabled { opacity: 0.7; cursor: not-allowed; }

        /* ── DIVIDER ── */
        .or-divider {
            display: flex;
            align-items: center;
            gap: 10px;
            width: 100%;
            margin: 4px 0 12px;
        }
        .or-divider::before,
        .or-divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: rgba(255,255,255,0.3);
        }
        .or-divider span { font-size: 11px; color: rgba(255,255,255,0.6); white-space: nowrap; }

        /* ── LOGIN LINK ── */
        .login-link {
            font-size: 13px;
            color: rgba(255,255,255,0.75);
            text-align: center;
        }
        .login-link a { color: #7eeeff; font-weight: 600; text-decoration: none; }
        .login-link a:hover { text-decoration: underline; }

        /* ── RIGHT DARK TEAL PANEL ── */
        .panel-right {
            width: 40%;
            background-image: url('ctu.png');
            background-size: cover;
            background-position: center;
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
            background: linear-gradient(160deg, rgba(0,100,120,0.90) 0%, rgba(0,35,50,0.95) 100%);
            pointer-events: none;
        }

        .panel-right::after {
            content: '';
            position: absolute;
            inset: 0;
            background:
                radial-gradient(circle at 25% 25%, rgba(255,255,255,0.07) 0%, transparent 55%),
                radial-gradient(circle at 75% 75%, rgba(255,255,255,0.05) 0%, transparent 50%);
            pointer-events: none;
        }

        .brand-logo {
            width: 72px;
            height: 72px;
            object-fit: contain;
            border-radius: 50%;
            margin-bottom: 16px;
            position: relative;
            z-index: 1;
            filter: drop-shadow(0 4px 12px rgba(0,0,0,0.4));
        }

        .brand-name {
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: rgba(255,255,255,0.65);
            position: relative;
            z-index: 1;
            margin-bottom: 20px;
        }

        .panel-right h2 {
            font-size: 32px;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 10px;
            line-height: 1.25;
            position: relative;
            z-index: 1;
        }

        .panel-right .divider {
            width: 44px;
            height: 3px;
            background: rgba(255,255,255,0.4);
            border-radius: 2px;
            margin: 16px auto;
            position: relative;
            z-index: 1;
        }

        .panel-right p {
            font-size: 13px;
            color: rgba(255,255,255,0.85);
            margin-bottom: 28px;
            position: relative;
            z-index: 1;
        }

        .btn-outline-white {
            display: inline-block;
            padding: 11px 40px;
            border: 2px solid rgba(255,255,255,0.95);
            border-radius: 40px;
            color: #ffffff;
            font-size: 15px;
            font-weight: 700;
            text-decoration: none;
            background: transparent;
            transition: all 0.25s;
            letter-spacing: 0.5px;
            position: relative;
            z-index: 1;
        }
        .btn-outline-white:hover {
            background: rgba(255,255,255,0.2);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.2);
        }

        /* ── RESPONSIVE ── */
        @media (max-width: 640px) {
            .auth-card { flex-direction: column-reverse; max-width: 420px; }
            .panel-right { width: 100%; padding: 36px 28px; }
            .panel-left { padding: 32px 24px; }
        }

        @keyframes spin { to { transform: rotate(360deg); } }
    </style>
</head>
<body>
    <!-- ═══ SPLASH OVERLAY ═══ -->
    <div id="signinSplash" style="
        position:fixed;inset:0;background:#0d1a2e;
        display:flex;flex-direction:column;align-items:center;justify-content:center;gap:20px;
        z-index:99999;transition:opacity 0.5s ease;">
        <img src="ctu-logo.png" alt="CTU Logo" style="
            width:130px;height:130px;object-fit:contain;
            filter:drop-shadow(0 0 18px rgba(0,188,212,0.6)) drop-shadow(0 0 40px rgba(0,188,212,0.25));
            animation:signinLogoPulse 2s ease-in-out infinite;" />
        <div style="font-family:'Segoe UI',sans-serif;font-size:14px;font-weight:700;
                    color:rgba(255,255,255,0.55);letter-spacing:3px;text-transform:uppercase;">
            Campus Announcement
        </div>
        <div style="font-family:'Segoe UI',sans-serif;font-size:11px;
                    color:rgba(255,255,255,0.3);letter-spacing:1.5px;margin-top:-12px;">
            Cebu Technological University
        </div>
    </div>
    <style>
        @keyframes signinLogoPulse {
            0%   { filter:drop-shadow(0 0 14px rgba(0,188,212,0.45)) drop-shadow(0 0 36px rgba(0,188,212,0.2)); }
            50%  { filter:drop-shadow(0 0 28px rgba(0,188,212,0.80)) drop-shadow(0 0 60px rgba(0,188,212,0.35)); }
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
                <h1>Create Account</h1>
                <div class="subtitle">Fill in the details below to register</div>

                <!-- Full Name -->
                <div class="input-wrap">
                    <asp:TextBox ID="txtFullName" runat="server"
                        style="width:100%;padding:12px 46px 12px 18px;background:rgba(255,255,255,0.92);border:1.5px solid rgba(255,255,255,0.5);border-radius:12px;font-size:14px;color:#1a2a3a;font-family:inherit;transition:border-color 0.2s,box-shadow 0.2s;"
                        placeholder="Full Name"></asp:TextBox>
                    <span class="icon"><i class="fas fa-user"></i></span>
                </div>

                <!-- Username -->
                <div class="input-wrap">
                    <asp:TextBox ID="txtUsername" runat="server"
                        style="width:100%;padding:12px 46px 12px 18px;background:rgba(255,255,255,0.92);border:1.5px solid rgba(255,255,255,0.5);border-radius:12px;font-size:14px;color:#1a2a3a;font-family:inherit;transition:border-color 0.2s,box-shadow 0.2s;"
                        placeholder="Username"></asp:TextBox>
                    <span class="icon"><i class="fas fa-at"></i></span>
                </div>

                <!-- Email -->
                <div class="input-wrap">
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"
                        style="width:100%;padding:12px 46px 12px 18px;background:rgba(255,255,255,0.92);border:1.5px solid rgba(255,255,255,0.5);border-radius:12px;font-size:14px;color:#1a2a3a;font-family:inherit;transition:border-color 0.2s,box-shadow 0.2s;"
                        placeholder="Email Address"></asp:TextBox>
                    <span class="icon"><i class="fas fa-envelope"></i></span>
                </div>

                <!-- Password -->
                <div class="input-wrap">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"
                        style="width:100%;padding:12px 46px 12px 18px;background:rgba(255,255,255,0.92);border:1.5px solid rgba(255,255,255,0.5);border-radius:12px;font-size:14px;color:#1a2a3a;font-family:inherit;transition:border-color 0.2s,box-shadow 0.2s;"
                        placeholder="Password (min. 6 characters)"></asp:TextBox>
                    <span class="icon toggle-pw" id="togglePw1" title="Show/hide password">
                        <i class="fas fa-eye" id="togglePw1Icon"></i>
                    </span>
                </div>

                <!-- Confirm Password -->
                <div class="input-wrap">
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password"
                        style="width:100%;padding:12px 46px 12px 18px;background:rgba(255,255,255,0.92);border:1.5px solid rgba(255,255,255,0.5);border-radius:12px;font-size:14px;color:#1a2a3a;font-family:inherit;transition:border-color 0.2s,box-shadow 0.2s;"
                        placeholder="Confirm Password"></asp:TextBox>
                    <span class="icon toggle-pw" id="togglePw2" title="Show/hide password">
                        <i class="fas fa-eye" id="togglePw2Icon"></i>
                    </span>
                </div>

                <!-- Role dropdown -->
                <div class="role-wrap">
                    <select id="roleSelect" onchange="syncRole(this.value)">
                        <option value="Student">Student</option>
                        <option value="Admin">Admin</option>
                    </select>
                    <span class="icon"><i class="fas fa-chevron-down"></i></span>
                    <!-- Hidden radio buttons kept for server-side compatibility -->
                    <asp:RadioButton ID="rbStudent" runat="server" GroupName="Role" Checked="true" style="display:none;" />
                    <asp:RadioButton ID="rbAdmin"   runat="server" GroupName="Role" style="display:none;" />
                </div>

                <!-- Message -->
                <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="msg-box"></asp:Label>

                <!-- Register button -->
                <asp:Button ID="btnSignUp" runat="server" Text="Create Account"
                    CssClass="btn-register" OnClick="BtnSignUp_Click" UseSubmitBehavior="true" />

                <div class="or-divider"><span>Cebu Technological University</span></div>

                <div class="login-link">
                    Already have an account? <a href="login.aspx">Sign in</a>
                </div>
            </form>
        </div>

        <!-- RIGHT DARK TEAL PANEL -->
        <div class="panel-right">
            <img src="ctu-logo.png" alt="CTU Logo" class="brand-logo" />
            <div class="brand-name">Campus Announcement</div>
            <h2>Welcome<br />Back!</h2>
            <div class="divider"></div>
            <p>Already have an account?<br />Sign in to continue.</p>
            <a href="login.aspx" class="btn-outline-white">Sign In</a>
        </div>
    </div>

    <script>
        // Sync visible dropdown → hidden radio buttons for server-side
        function syncRole(val) {
            var rbStudent = document.getElementById('<%= rbStudent.ClientID %>');
            var rbAdmin   = document.getElementById('<%= rbAdmin.ClientID %>');
            if (!rbStudent || !rbAdmin) return;
            if (val === 'Admin') {
                rbAdmin.checked   = true;
                rbStudent.checked = false;
            } else {
                rbStudent.checked = true;
                rbAdmin.checked   = false;
            }
        }

        // Show/hide password — field 1
        (function () {
            var btn  = document.getElementById('togglePw1');
            var icon = document.getElementById('togglePw1Icon');
            var pw   = document.getElementById('<%= txtPassword.ClientID %>');
            if (!btn || !pw) return;
            btn.addEventListener('click', function () {
                var show = pw.getAttribute('type') === 'password';
                pw.setAttribute('type', show ? 'text' : 'password');
                icon.className = show ? 'fas fa-eye-slash' : 'fas fa-eye';
            });
        })();

        // Show/hide password — field 2
        (function () {
            var btn  = document.getElementById('togglePw2');
            var icon = document.getElementById('togglePw2Icon');
            var cpw  = document.getElementById('<%= txtConfirmPassword.ClientID %>');
            if (!btn || !cpw) return;
            btn.addEventListener('click', function () {
                var show = cpw.getAttribute('type') === 'password';
                cpw.setAttribute('type', show ? 'text' : 'password');
                icon.className = show ? 'fas fa-eye-slash' : 'fas fa-eye';
            });
        })();

        // Password match indicator
        (function () {
            var pw  = document.getElementById('<%= txtPassword.ClientID %>');
            var cpw = document.getElementById('<%= txtConfirmPassword.ClientID %>');
            if (!pw || !cpw) return;
            cpw.addEventListener('input', function () {
                if (cpw.value.length === 0) {
                    cpw.style.borderColor = 'rgba(255,255,255,0.5)';
                } else if (cpw.value === pw.value && pw.value.length >= 6) {
                    cpw.style.borderColor = '#00bcd4';
                    cpw.style.boxShadow   = '0 0 0 3px rgba(0,188,212,0.22)';
                } else {
                    cpw.style.borderColor = '#dc2626';
                    cpw.style.boxShadow   = '0 0 0 3px rgba(220,38,38,0.18)';
                }
            });
        })();

        // Loading state — fires after postback starts (safe)
        (function () {
            var btn = document.getElementById('<%= btnSignUp.ClientID %>');
            if (!btn) return;
            btn.addEventListener('click', function () {
                setTimeout(function () {
                    btn.value = 'Creating account...';
                    btn.style.opacity = '0.75';
                    btn.style.cursor  = 'not-allowed';
                }, 10);
            });
        })();

        // Focus ring on inputs
        document.querySelectorAll('.input-wrap input, .role-wrap select').forEach(function(el) {
            el.addEventListener('focus', function() {
                this.style.borderColor = '#00bcd4';
                this.style.boxShadow   = '0 0 0 3px rgba(0,188,212,0.28)';
                this.style.background  = '#ffffff';
            });
            el.addEventListener('blur', function() {
                this.style.borderColor = 'rgba(255,255,255,0.5)';
                this.style.boxShadow   = 'none';
                this.style.background  = 'rgba(255,255,255,0.92)';
            });
        });
    </script>
</body>
</html>
