<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Campus Connect — Login</title>
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
            /* Darker overlay so text is always readable */
            position: relative;
        }

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
            max-width: 840px;
            min-height: 520px;
            background: transparent;
            border-radius: 28px;
            overflow: hidden;
            box-shadow: 0 28px 70px rgba(0, 0, 0, 0.55);
            position: relative;
            z-index: 1;
        }

        /* ── LEFT TEAL PANEL ── */
        .panel-left {
            width: 42%;
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

        .panel-left::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(160deg, rgba(0,150,170,0.88) 0%, rgba(0,80,100,0.94) 100%);
            pointer-events: none;
        }

        .panel-left::after {
            content: '';
            position: absolute;
            inset: 0;
            background:
                radial-gradient(circle at 20% 20%, rgba(255,255,255,0.10) 0%, transparent 55%),
                radial-gradient(circle at 80% 80%, rgba(255,255,255,0.07) 0%, transparent 50%);
            pointer-events: none;
        }

        /* Branding inside left panel */
        .brand-logo {
            width: 72px;
            height: 72px;
            object-fit: contain;
            border-radius: 50%;
            margin-bottom: 16px;
            position: relative;
            z-index: 1;
            filter: drop-shadow(0 4px 12px rgba(0,0,0,0.3));
        }

        .brand-name {
            font-size: 13px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            color: rgba(255,255,255,0.75);
            position: relative;
            z-index: 1;
            margin-bottom: 20px;
        }

        .panel-left h2 {
            font-size: 32px;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 10px;
            line-height: 1.25;
            position: relative;
            z-index: 1;
        }

        .panel-left .divider {
            width: 44px;
            height: 3px;
            background: rgba(255,255,255,0.45);
            border-radius: 2px;
            margin: 16px auto;
            position: relative;
            z-index: 1;
        }

        .panel-left p {
            font-size: 13px;
            color: rgba(255,255,255,0.90);
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
            background: rgba(255,255,255,0.22);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.2);
        }

        /* ── RIGHT FORM PANEL ── */
        .panel-right {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 48px 44px;
            background: rgba(255, 255, 255, 0.14);
            backdrop-filter: blur(22px);
            -webkit-backdrop-filter: blur(22px);
            border-left: 1px solid rgba(255,255,255,0.22);
        }

        .panel-right h1 {
            font-size: 30px;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 6px;
            text-align: center;
            text-shadow: 0 2px 10px rgba(0,0,0,0.35);
        }

        .panel-right .subtitle {
            font-size: 13px;
            color: rgba(255,255,255,0.72);
            margin-bottom: 26px;
            text-align: center;
        }

        /* ── INPUTS ── */
        .input-wrap {
            position: relative;
            width: 100%;
            margin-bottom: 14px;
        }

        .input-wrap input,
        .input-wrap select {
            width: 100%;
            padding: 13px 46px 13px 18px;
            background: rgba(255,255,255,0.92);
            border: 1.5px solid rgba(255,255,255,0.5);
            border-radius: 12px;
            font-size: 14px;
            color: #1a2a3a;
            font-family: inherit;
            transition: border-color 0.2s, box-shadow 0.2s, background 0.2s;
            appearance: none;
            -webkit-appearance: none;
        }

        .input-wrap input::placeholder { color: #7a8fa0; }

        .input-wrap input:focus,
        .input-wrap select:focus {
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

        /* Show/hide password toggle */
        .input-wrap .toggle-pw {
            pointer-events: all;
            cursor: pointer;
            transition: color 0.2s;
        }
        .input-wrap .toggle-pw:hover { color: #00838f; }

        .input-wrap select option { background: #fff; color: #1a2a3a; }

        /* ── FORGOT ROW ── */
        .forgot-row {
            width: 100%;
            text-align: right;
            margin-bottom: 18px;
        }
        .forgot-row span {
            font-size: 12px;
            color: rgba(255,255,255,0.80);
            cursor: pointer;
        }
        .forgot-row span:hover { color: #ffffff; text-decoration: underline; }

        /* ── ERROR BOX ── */
        .error-box {
            width: 100%;
            padding: 10px 14px;
            background: rgba(254,226,226,0.95);
            border-left: 3px solid #dc2626;
            border-radius: 10px;
            color: #b91c1c;
            font-size: 13px;
            font-weight: 500;
            margin-bottom: 14px;
            text-align: left;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* ── LOGIN BUTTON ── */
        .btn-login {
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
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        .btn-login:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(0,131,143,0.45);
        }
        .btn-login:active:not(:disabled) { transform: translateY(0); }
        .btn-login:disabled {
            opacity: 0.7;
            cursor: not-allowed;
        }

        /* Spinner inside button */
        .btn-spinner {
            display: none;
            width: 16px;
            height: 16px;
            border: 2px solid rgba(255,255,255,0.4);
            border-top-color: #ffffff;
            border-radius: 50%;
            animation: spin 0.7s linear infinite;
        }
        @keyframes spin { to { transform: rotate(360deg); } }

        /* ── DIVIDER ── */
        .or-divider {
            display: flex;
            align-items: center;
            gap: 10px;
            width: 100%;
            margin: 16px 0 4px;
        }
        .or-divider::before,
        .or-divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: rgba(255,255,255,0.3);
        }
        .or-divider span {
            font-size: 11px;
            color: rgba(255,255,255,0.6);
            white-space: nowrap;
        }

        /* ── SIGN UP LINK ── */
        .signup-link {
            margin-top: 14px;
            font-size: 13px;
            color: rgba(255,255,255,0.75);
            text-align: center;
        }
        .signup-link a {
            color: #7eeeff;
            font-weight: 600;
            text-decoration: none;
        }
        .signup-link a:hover { text-decoration: underline; }

        /* ── RESPONSIVE ── */
        @media (max-width: 640px) {
            .auth-card { flex-direction: column; max-width: 420px; }
            .panel-left { width: 100%; padding: 36px 28px; }
            .panel-right { padding: 32px 24px; }
        }
    </style>
</head>
<body>
    <div class="auth-card">

        <!-- LEFT TEAL PANEL -->
        <div class="panel-left">
            <img src="ctu-logo.png" alt="CTU Logo" class="brand-logo" />
            <div class="brand-name">Campus Announcement</div>
            <h2>Hello,<br />Welcome</h2>
            <div class="divider"></div>
           
            <a href="signin.aspx"></a>
        </div>

        <!-- RIGHT FORM PANEL -->
        <div class="panel-right">
            <form id="form1" runat="server" style="width:100%;max-width:320px;">
                <h1>Sign In</h1>
                <div class="subtitle">Welcome back — please login to continue</div>

                <!-- Role -->
                <div class="input-wrap">
                    <asp:DropDownList ID="txtRole" runat="server"
                        style="width:100%;padding:13px 46px 13px 18px;background:rgba(255,255,255,0.92);border:1.5px solid rgba(255,255,255,0.5);border-radius:12px;font-size:14px;color:#1a2a3a;font-family:inherit;appearance:none;-webkit-appearance:none;transition:border-color 0.2s,box-shadow 0.2s;">
                        <asp:ListItem Text="Student" Value="Student" />
                        <asp:ListItem Text="Admin"   Value="Admin"   />
                    </asp:DropDownList>
                    <span class="icon"><i class="fas fa-chevron-down"></i></span>
                </div>

                <!-- Username -->
                <div class="input-wrap">
                    <asp:TextBox ID="txtUsername" runat="server"
                        style="width:100%;padding:13px 46px 13px 18px;background:rgba(255,255,255,0.92);border:1.5px solid rgba(255,255,255,0.5);border-radius:12px;font-size:14px;color:#1a2a3a;font-family:inherit;transition:border-color 0.2s,box-shadow 0.2s;"
                        placeholder="Username"></asp:TextBox>
                    <span class="icon"><i class="fas fa-user"></i></span>
                </div>

                <!-- Password -->
                <div class="input-wrap">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"
                        style="width:100%;padding:13px 46px 13px 18px;background:rgba(255,255,255,0.92);border:1.5px solid rgba(255,255,255,0.5);border-radius:12px;font-size:14px;color:#1a2a3a;font-family:inherit;transition:border-color 0.2s,box-shadow 0.2s;"
                        placeholder="Password"></asp:TextBox>
                    <span class="icon toggle-pw" id="togglePw" title="Show/hide password">
                        <i class="fas fa-eye" id="togglePwIcon"></i>
                    </span>
                </div>

                <div class="forgot-row">
                    <span>Forgot Password?</span>
                </div>

                <!-- Error -->
                <asp:Label ID="lblError" runat="server" CssClass="error-box" style="display:none;"></asp:Label>

                <!-- Login button -->
                <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click"
                    Text="Login" CssClass="btn-login" UseSubmitBehavior="true" />

                <div class="or-divider"><span>Cebu Technological University</span></div>

                <div class="signup-link">
                    New here? <a href="signin.aspx">Create an account</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Show error if server returned one
        (function () {
            var err = document.getElementById('<%= lblError.ClientID %>');
            if (err && err.innerText.trim() !== '') err.style.display = 'flex';
        })();

        // Show/hide password toggle — uses a flag so it doesn't break postback
        (function () {
            var toggleBtn  = document.getElementById('togglePw');
            var toggleIcon = document.getElementById('togglePwIcon');
            var pwField    = document.getElementById('<%= txtPassword.ClientID %>');
            if (!toggleBtn || !pwField) return;
            var visible = false;
            toggleBtn.addEventListener('click', function (e) {
                e.preventDefault();
                visible = !visible;
                // ASP.NET renders TextMode="Password" as type="password" — we swap it via a wrapper trick
                var val = pwField.value;
                pwField.setAttribute('type', visible ? 'text' : 'password');
                pwField.value = val;
                toggleIcon.className = visible ? 'fas fa-eye-slash' : 'fas fa-eye';
            });
        })();

        // Loading state — fires AFTER form submits (safe for postback)
        (function () {
            var btn = document.getElementById('<%= btnLogin.ClientID %>');
            if (!btn) return;
            btn.addEventListener('click', function () {
                // Let the postback happen first, then show spinner
                setTimeout(function () {
                    btn.value = 'Signing in...';
                    btn.style.opacity = '0.75';
                    btn.style.cursor  = 'not-allowed';
                }, 10);
            });
        })();

        // Focus ring on inputs
        document.querySelectorAll('.input-wrap input, .input-wrap select').forEach(function(el) {
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
