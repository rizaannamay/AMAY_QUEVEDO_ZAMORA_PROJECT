<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signin.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.signin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Campus Announcement Portal — Register</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="university-theme-decorations.css" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        html, body { scrollbar-width: none; -ms-overflow-style: none; }
        html::-webkit-scrollbar, body::-webkit-scrollbar { display: none; }

        :root {
            --uni-accent: #c9920a;
            --uni-accent-dark: #a87800;
        }

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
            border-color: var(--uni-accent, #d97706);
            box-shadow: 0 0 0 3px rgba(217,119,6,0.25);
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

        /* Hide browser-native password reveal button */
        .input-wrap input[type="password"]::-ms-reveal,
        .input-wrap input[type="password"]::-ms-clear,
        .input-wrap input::-webkit-credentials-auto-fill-button,
        .input-wrap input::-webkit-textfield-decoration-container { display: none !important; }

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
            border-color: #d97706;
            box-shadow: 0 0 0 3px rgba(217,119,6,0.25);
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
            background: linear-gradient(135deg, var(--uni-accent) 0%, var(--uni-accent-dark) 100%);
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
            box-shadow: 0 8px 24px rgba(var(--uni-accent-rgb, 180,130,0), 0.50);
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
        .login-link a { color: var(--uni-accent, #fbbf24); font-weight: 600; text-decoration: none; }
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
            background: linear-gradient(160deg, var(--uni-accent, #c9920a) 0%, var(--uni-accent-dark, #a87800) 100%);
            opacity: 0.93;
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
            .auth-card { flex-direction: column-reverse; max-width: 100%; border-radius: 20px; margin: 8px; }
            .panel-right { width: 100%; padding: 28px 20px; min-height: unset; }
            .panel-left { padding: 24px 16px; }
            .panel-right h2 { font-size: 26px; }
            .panel-left h1 { font-size: 24px; }
        }
        @media (max-width: 480px) {
            body { padding: 12px; }
            .panel-left h1 { font-size: 22px; }
            .btn-register { font-size: 14px; }
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
            filter:drop-shadow(0 0 18px rgba(201,146,10,0.6)) drop-shadow(0 0 40px rgba(201,146,10,0.25));
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
            0%   { filter:drop-shadow(0 0 14px rgba(201,146,10,0.45)) drop-shadow(0 0 36px rgba(201,146,10,0.2)); }
            50%  { filter:drop-shadow(0 0 28px rgba(201,146,10,0.80)) drop-shadow(0 0 60px rgba(201,146,10,0.40)); }
            100% { filter:drop-shadow(0 0 14px rgba(201,146,10,0.45)) drop-shadow(0 0 36px rgba(201,146,10,0.2)); }
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
                        placeholder="Password (min. 8 chars, A-Z, 0-9, !@#$)"></asp:TextBox>
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

                <!-- Role dropdown — Student & Teacher only; Admin is created by existing admins -->
                <div class="role-wrap">
                    <select id="roleSelect" onchange="syncRole(this.value)">
                        <option value="Student">Student</option>
                        <option value="Teacher">Teacher</option>
                    </select>
                    <span class="icon"><i class="fas fa-chevron-down"></i></span>
                    <!-- Hidden radio buttons kept for server-side compatibility -->
                    <asp:RadioButton ID="rbStudent" runat="server" GroupName="Role" Checked="true" style="display:none;" />
                    <asp:RadioButton ID="rbTeacher" runat="server" GroupName="Role" style="display:none;" />
                </div>
                <!-- Teacher pending notice -->
                <div id="teacherNotice" style="display:none;width:100%;padding:9px 14px;background:rgba(251,191,36,0.18);border-left:3px solid #f59e0b;border-radius:10px;font-size:12px;color:#92400e;margin-bottom:10px;">
                    <i class="fas fa-info-circle"></i> Teacher accounts require <strong>admin approval</strong> before activation.
                </div>
                <!-- Password strength indicator -->
                <div id="pwStrengthBar" style="width:100%;height:4px;border-radius:4px;background:#e5e7eb;margin-bottom:8px;overflow:hidden;display:none;">
                    <div id="pwStrengthFill" style="height:100%;width:0%;transition:width 0.3s,background 0.3s;border-radius:4px;"></div>
                </div>
                <div id="pwStrengthLabel" style="font-size:11px;color:rgba(255,255,255,0.65);margin-bottom:8px;display:none;"></div>
                <div id="pwRules" style="font-size:11px;color:rgba(255,255,255,0.65);margin-bottom:10px;display:none;line-height:1.8;">
                    <span id="r8" style="margin-right:10px;">&#x25CB; 8+ chars</span>
                    <span id="rU" style="margin-right:10px;">&#x25CB; Uppercase</span>
                    <span id="rL" style="margin-right:10px;">&#x25CB; Lowercase</span>
                    <span id="rN" style="margin-right:10px;">&#x25CB; Number</span>
                    <span id="rS">&#x25CB; Special (!@#$...)</span>
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
            <h2>Hello,<br />Welcome!</h2>
            <div class="divider"></div>
            <a href="login.aspx"> </a>
        </div>
    </div>

    <script>
        // Sync visible dropdown → hidden radio buttons for server-side
        function syncRole(val) {
            var rbStudent = document.getElementById('<%= rbStudent.ClientID %>');
            var rbTeacher = document.getElementById('<%= rbTeacher.ClientID %>');
            if (!rbStudent || !rbTeacher) return;
            if (val === 'Teacher') {
                rbTeacher.checked = true;
                rbStudent.checked = false;
                document.getElementById('teacherNotice').style.display = 'block';
            } else {
                rbStudent.checked = true;
                rbTeacher.checked = false;
                document.getElementById('teacherNotice').style.display = 'none';
            }
        }

        // Password strength checker
        function checkPasswordStrength(pw) {
            var rules = {
                len:     pw.length >= 8,
                upper:   /[A-Z]/.test(pw),
                lower:   /[a-z]/.test(pw),
                number:  /[0-9]/.test(pw),
                special: /[^A-Za-z0-9]/.test(pw)
            };
            var score = Object.values(rules).filter(Boolean).length;
            var bar   = document.getElementById('pwStrengthFill');
            var lbl   = document.getElementById('pwStrengthLabel');
            var colors = ['#ef4444','#f97316','#eab308','#22c55e','#16a34a'];
            var labels = ['Very Weak','Weak','Fair','Strong','Very Strong'];
            bar.style.width     = (score * 20) + '%';
            bar.style.background = colors[score - 1] || '#e5e7eb';
            lbl.textContent     = score > 0 ? labels[score - 1] : '';

            function mark(id, ok) {
                var el = document.getElementById(id);
                if (!el) return;
                el.innerHTML = (ok ? '&#x2714; ' : '&#x25CB; ') + el.textContent.replace(/^[✔○] /, '');
                el.style.color = ok ? '#4ade80' : 'rgba(255,255,255,0.65)';
            }
            mark('r8', rules.len);
            mark('rU', rules.upper);
            mark('rL', rules.lower);
            mark('rN', rules.number);
            mark('rS', rules.special);
            return rules;
        }

        // Show/hide password — field 1
        (function () {
            var btn  = document.getElementById('togglePw1');
            var icon = document.getElementById('togglePw1Icon');
            var pw   = document.getElementById('<%= txtPassword.ClientID %>');
            if (!btn || !pw) return;

            // Show strength bar when typing
            pw.addEventListener('input', function () {
                var bar   = document.getElementById('pwStrengthBar');
                var lbl   = document.getElementById('pwStrengthLabel');
                var rules = document.getElementById('pwRules');
                if (pw.value.length > 0) {
                    bar.style.display   = 'block';
                    lbl.style.display   = 'block';
                    rules.style.display = 'block';
                } else {
                    bar.style.display   = 'none';
                    lbl.style.display   = 'none';
                    rules.style.display = 'none';
                }
                checkPasswordStrength(pw.value);
            });

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
                    cpw.style.boxShadow   = 'none';
                } else if (cpw.value === pw.value) {
                    cpw.style.borderColor = '#22c55e';
                    cpw.style.boxShadow   = '0 0 0 3px rgba(34,197,94,0.22)';
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
                    btn.value  = 'Creating account...';
                    btn.style.opacity = '0.75';
                    btn.style.cursor  = 'not-allowed';
                }, 10);
            });
        })();

        // Focus ring on inputs
        document.querySelectorAll('.input-wrap input, .role-wrap select').forEach(function (el) {
            el.addEventListener('focus', function () {
                this.style.borderColor = '#d97706';
                this.style.boxShadow   = '0 0 0 3px rgba(217,119,6,0.25)';
                this.style.background  = '#ffffff';
            });
            el.addEventListener('blur', function () {
                this.style.borderColor = 'rgba(255,255,255,0.5)';
                this.style.boxShadow   = 'none';
                this.style.background  = 'rgba(255,255,255,0.92)';
            });
        });
    </script>
    <script src="university-theme.js"></script>
</body>
</html>
