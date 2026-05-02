<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Campus Connect - Login</title>
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
        }

        /* ── OUTER CARD ── */
        .auth-card {
            display: flex;
            width: 100%;
            max-width: 820px;
            min-height: 500px;
            background: transparent;
            border-radius: 28px;
            overflow: hidden;
            box-shadow: 0 24px 60px rgba(0, 0, 0, 0.45);
            position: relative;
            z-index: 1;
        }

        /* ── LEFT TEAL PANEL — photo bg with teal overlay ── */
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

        /* teal overlay on top of the photo */
        .panel-left::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(160deg, rgba(0,188,212,0.78) 0%, rgba(0,131,143,0.85) 100%);
            pointer-events: none;
        }

        /* subtle radial highlights */
        .panel-left::after {
            content: '';
            position: absolute;
            inset: 0;
            background:
                radial-gradient(circle at 20% 20%, rgba(255,255,255,0.10) 0%, transparent 55%),
                radial-gradient(circle at 80% 80%, rgba(255,255,255,0.07) 0%, transparent 50%);
            pointer-events: none;
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
            margin-bottom: 32px;
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
            box-shadow: 0 6px 20px rgba(0,0,0,0.18);
        }

        /* ── RIGHT FORM PANEL — transparent glass ── */
        .panel-right {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 48px 44px;
            background: rgba(255, 255, 255, 0.18);
            backdrop-filter: blur(18px);
            -webkit-backdrop-filter: blur(18px);
            border-left: 1px solid rgba(255,255,255,0.25);
        }

        .panel-right h1 {
            font-size: 30px;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 28px;
            text-align: center;
            text-shadow: 0 2px 8px rgba(0,0,0,0.25);
        }

        /* ── INPUTS ── */
        .input-wrap {
            position: relative;
            width: 100%;
            margin-bottom: 16px;
        }
        .input-wrap input,
        .input-wrap select {
            width: 100%;
            padding: 13px 44px 13px 18px;
            background: rgba(255,255,255,0.85);
            border: 1.5px solid rgba(255,255,255,0.6);
            border-radius: 12px;
            font-size: 14px;
            color: #1a2a3a;
            font-family: inherit;
            transition: border-color 0.2s, box-shadow 0.2s;
            appearance: none;
            -webkit-appearance: none;
        }
        .input-wrap input::placeholder { color: #6b8090; }
        .input-wrap input:focus,
        .input-wrap select:focus {
            outline: none;
            border-color: #00bcd4;
            box-shadow: 0 0 0 3px rgba(0,188,212,0.22);
            background: rgba(255,255,255,0.97);
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
        .input-wrap select option { background:#fff; color:#1a2a3a; }

        .forgot-row {
            width: 100%;
            text-align: right;
            margin-bottom: 18px;
        }
        .forgot-row span {
            font-size: 12px;
            color: rgba(255,255,255,0.85);
            cursor: pointer;
            text-shadow: 0 1px 4px rgba(0,0,0,0.2);
        }
        .forgot-row span:hover { color: #ffffff; text-decoration: underline; }

        .btn-login {
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
            margin-bottom: 16px;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(0,131,143,0.4);
        }

        .social-label {
            font-size: 12px;
            color: rgba(255,255,255,0.8);
            margin-bottom: 12px;
            text-align: center;
            text-shadow: 0 1px 4px rgba(0,0,0,0.2);
        }
        .social-row {
            display: flex;
            gap: 10px;
            justify-content: center;
        }
        .social-btn {
            width: 44px; height: 44px;
            border: 1.5px solid rgba(255,255,255,0.5);
            border-radius: 10px;
            background: rgba(255,255,255,0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 17px;
            color: #ffffff;
            text-decoration: none;
            transition: all 0.2s;
        }
        .social-btn:hover {
            border-color: #ffffff;
            background: rgba(255,255,255,0.35);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .error-box {
            width: 100%;
            padding: 10px 14px;
            background: rgba(254,242,242,0.9);
            border-left: 3px solid #dc2626;
            border-radius: 10px;
            color: #dc2626;
            font-size: 13px;
            margin-bottom: 14px;
            text-align: center;
        }

        @media (max-width: 640px) {
            .auth-card { flex-direction: column; max-width: 420px; }
            .panel-left { width: 100%; padding: 36px 28px; }
            .panel-right { padding: 32px 24px; }
        }
    </style>
</head>
<body>
    <div class="auth-card">

        <!-- LEFT TEAL PANEL (photo + teal overlay) -->
        <div class="panel-left">
            <h2>Hello,<br />Welcome</h2>
            <div class="divider"></div>
            <p>Don't have an account?</p>
            <a href="signin.aspx" class="btn-outline-white">Register</a>
        </div>

        <!-- RIGHT FORM PANEL (glass / transparent) -->
        <div class="panel-right">
            <form id="form1" runat="server" style="width:100%;max-width:320px;">
                <h1>Login</h1>

                <div class="input-wrap">
                    <asp:DropDownList ID="txtRole" runat="server"
                        style="width:100%;padding:13px 44px 13px 18px;background:rgba(255,255,255,0.85);border:1.5px solid rgba(255,255,255,0.6);border-radius:12px;font-size:14px;color:#1a2a3a;font-family:inherit;appearance:none;-webkit-appearance:none;">
                        <asp:ListItem Text="Student" Value="Student" />
                        <asp:ListItem Text="Admin"   Value="Admin"   />
                    </asp:DropDownList>
                    <span class="icon"><i class="fas fa-chevron-down"></i></span>
                </div>

                <div class="input-wrap">
                    <asp:TextBox ID="txtUsername" runat="server"
                        style="width:100%;padding:13px 44px 13px 18px;background:rgba(255,255,255,0.85);border:1.5px solid rgba(255,255,255,0.6);border-radius:12px;font-size:14px;color:#1a2a3a;font-family:inherit;"
                        placeholder="Username"></asp:TextBox>
                    <span class="icon"><i class="fas fa-user"></i></span>
                </div>

                <div class="input-wrap">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"
                        style="width:100%;padding:13px 44px 13px 18px;background:rgba(255,255,255,0.85);border:1.5px solid rgba(255,255,255,0.6);border-radius:12px;font-size:14px;color:#1a2a3a;font-family:inherit;"
                        placeholder="Password"></asp:TextBox>
                    <span class="icon"><i class="fas fa-lock"></i></span>
                </div>

                <div class="forgot-row">
                    <span>Forgot Password?</span>
                </div>

                <asp:Label ID="lblError" runat="server" CssClass="error-box" style="display:none;"></asp:Label>

                <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click"
                    Text="Login" CssClass="btn-login" UseSubmitBehavior="true" />

                <div class="social-label">or login with social platforms</div>
                <div class="social-row">
                    <a href="#" class="social-btn" title="Google"><i class="fab fa-google"></i></a>
                    <a href="#" class="social-btn" title="Facebook"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social-btn" title="GitHub"><i class="fab fa-github"></i></a>
                    <a href="#" class="social-btn" title="LinkedIn"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </form>
        </div>
    </div>

    <script>
        (function () {
            var err = document.getElementById('<%= lblError.ClientID %>');
            if (err && err.innerText.trim() !== '') err.style.display = 'block';
        })();
    </script>
</body>
</html>
