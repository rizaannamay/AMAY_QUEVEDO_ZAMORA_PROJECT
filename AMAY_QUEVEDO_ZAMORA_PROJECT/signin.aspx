<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signin.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.signin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Campus Connect - Create Account</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #e8f0fe 0%, #d4e0f0 100%);
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        padding: 20px;
    }

    .signup-container {
        width: 100%;
        max-width: 500px;
    }

    .logo {
        text-align: center;
        margin-bottom: 30px;
    }

    .logo img {
        width: 80px;
        height: auto;
        filter: drop-shadow(0 4px 12px rgba(0,100,200,0.2));
    }

    .logo h1 {
        font-size: 32px;
        font-weight: 800;
        color: #1a3a5c;
        margin-top: 12px;
        letter-spacing: 1px;
    }

    .logo p {
        color: #5a6e7c;
        font-size: 13px;
        margin-top: 5px;
    }

    .signup-card {
        background: white;
        border-radius: 24px;
        padding: 40px 35px;
        border: 1px solid rgba(26,58,92,0.1);
        box-shadow: 0 20px 35px rgba(0,0,0,0.05);
    }

    .card-header {
        text-align: center;
        margin-bottom: 30px;
    }

    .card-header h2 {
        color: #1a3a5c;
        font-size: 28px;
        font-weight: 700;
    }

    .card-header span {
        color: #7a8e9e;
        font-size: 14px;
    }

    .input-group {
        margin-bottom: 20px;
    }

    .input-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        color: #2c3e50;
        font-size: 13px;
    }

    .input-group label i {
        margin-right: 8px;
        color: #1a3a5c;
        width: 16px;
    }

    .input-field {
        width: 100%;
        padding: 14px 16px;
        background: #f8fafc;
        border: 1px solid #dce4ec;
        border-radius: 12px;
        font-size: 14px;
        color: #1a2a3a;
        transition: all 0.2s;
        box-sizing: border-box;
        font-family: inherit;
    }

    .input-field:focus {
        outline: none;
        border-color: #2c5a7a;
        box-shadow: 0 0 0 3px rgba(44,90,122,0.1);
        background: white;
    }

    .input-field::placeholder {
        color: #b0c4de;
    }

    .role-group {
        margin-bottom: 20px;
    }

    .role-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        color: #2c3e50;
        font-size: 13px;
    }

    .role-options {
        display: flex;
        gap: 25px;
        background: #f8fafc;
        padding: 12px 20px;
        border-radius: 12px;
        border: 1px solid #dce4ec;
    }

    .role-option {
        display: flex;
        align-items: center;
        gap: 8px;
        cursor: pointer;
    }

    .role-option input {
        width: 18px;
        height: 18px;
        cursor: pointer;
        accent-color: #1a3a5c;
    }

    .role-option span {
        font-size: 14px;
        color: #2c3e50;
    }

    .btn-signup {
        width: 100%;
        padding: 15px;
        background: linear-gradient(135deg, #1a3a5c, #2c5a7a);
        color: white;
        border: none;
        border-radius: 12px;
        font-size: 16px;
        font-weight: 700;
        cursor: pointer;
        transition: all 0.3s;
        margin-top: 10px;
    }

    .btn-signup:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(26,58,92,0.2);
        background: linear-gradient(135deg, #0f2a40, #1a4a6a);
    }

    .error-message {
        color: #dc2626;
        font-size: 13px;
        display: block;
        margin: 12px 0;
        padding: 12px;
        background: #fef2f2;
        border-radius: 10px;
        text-align: center;
        border-left: 3px solid #dc2626;
    }

    .success-message {
        color: #16a34a;
        font-size: 13px;
        display: block;
        margin: 12px 0;
        padding: 12px;
        background: #f0fdf4;
        border-radius: 10px;
        text-align: center;
        border-left: 3px solid #16a34a;
    }

    .password-requirements {
        font-size: 11px;
        color: #8a9bb0;
        margin-top: 6px;
        padding-left: 5px;
    }

    .footer-links {
        text-align: center;
        margin-top: 25px;
        padding-top: 20px;
        border-top: 1px solid #eef2f6;
    }

    .footer-links a {
        color: #1a3a5c;
        text-decoration: none;
        font-weight: 600;
        font-size: 14px;
    }

    .footer-links a:hover {
        text-decoration: underline;
    }

    .footer-links p {
        color: #8a9bb0;
        font-size: 13px;
        margin-bottom: 8px;
    }

    @media (max-width: 550px) {
        .signup-card {
            padding: 30px 25px;
        }
        .role-options {
            flex-direction: column;
            gap: 12px;
        }
    }

    /* ── Dark Mode ── */
    body.dark-mode {
        background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
    }
    body.dark-mode .signup-card {
        background: rgba(15, 25, 55, 0.97);
        border-color: rgba(255,255,255,0.1);
        box-shadow: 0 20px 35px rgba(0,0,0,0.5);
    }
    body.dark-mode .logo h1 { color: #818cf8; }
    body.dark-mode .logo p  { color: #94a3b8; }
    body.dark-mode .card-header h2 { color: #e4e6eb; }
    body.dark-mode .card-header span { color: #94a3b8; }
    body.dark-mode .input-group label,
    body.dark-mode .input-group span,
    body.dark-mode .role-group label,
    body.dark-mode .role-group span { color: #94a3b8; }
    body.dark-mode .input-group label i { color: #818cf8; }
    body.dark-mode .input-field {
        background: rgba(255,255,255,0.07);
        border-color: rgba(255,255,255,0.12);
        color: #e4e6eb;
    }
    body.dark-mode .input-field::placeholder { color: #64748b; }
    body.dark-mode .role-options {
        background: rgba(255,255,255,0.05);
        border-color: rgba(255,255,255,0.1);
    }
    body.dark-mode .role-option span { color: #e4e6eb; }
    body.dark-mode .btn-signup { background: linear-gradient(135deg, #4f46e5, #6366f1); }
    body.dark-mode .btn-signup:hover { background: linear-gradient(135deg, #4338ca, #4f46e5); }
    body.dark-mode .footer-links { border-top-color: rgba(255,255,255,0.08); }
    body.dark-mode .footer-links p { color: #94a3b8; }
    body.dark-mode .footer-links a { color: #818cf8; }
    body.dark-mode .password-requirements { color: #64748b; }
    body.dark-mode .error-message { background: rgba(220,38,38,0.15); color: #fca5a5; border-left-color: #ef4444; }
    body.dark-mode .success-message { background: rgba(22,163,74,0.15); color: #86efac; border-left-color: #22c55e; }
</style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="signup-container">
            <div class="logo">
                <img src="ctu-logo.png" alt="CTU Logo" />
                <h1>CAMPUS CONNECT</h1>
                <p>Cebu Technological University</p>
            </div>

            <div class="signup-card">
                <div class="card-header">
                    <h2>Create Account</h2>
                    <span>Join the Campus Connect community</span>
                </div>

                <div class="input-group">
                    <label><i class="fas fa-user-circle"></i> Full Name</label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="input-field" placeholder="Enter your full name"></asp:TextBox>
                </div>

                <div class="input-group">
                    <label><i class="fas fa-envelope"></i> Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="input-field" placeholder="Enter your email address" TextMode="Email"></asp:TextBox>
                </div>

                <div class="input-group">
                    <label><i class="fas fa-user"></i> Username</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="input-field" placeholder="Choose a username"></asp:TextBox>
                </div>

                <div class="input-group">
                    <label><i class="fas fa-lock"></i> Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="input-field" placeholder="Create a password" TextMode="Password"></asp:TextBox>
                    <div class="password-requirements" id="passwordReq">
                        <i class="fas fa-info-circle"></i> Password must be at least 6 characters
                    </div>
                </div>

                <div class="input-group">
                    <label><i class="fas fa-check-circle"></i> Confirm Password</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="input-field" placeholder="Confirm your password" TextMode="Password"></asp:TextBox>
                </div>

                <div class="role-group">
                    <label><i class="fas fa-users"></i> I am a</label>
                    <div class="role-options">
                        <label class="role-option">
                            <asp:RadioButton ID="rbStudent" runat="server" GroupName="Role" Checked="true" />
                            <span>Student</span>
                        </label>
                        <label class="role-option">
                            <asp:RadioButton ID="rbAdmin" runat="server" GroupName="Role" />
                            <span>Admin</span>
                        </label>
                    </div>
                </div>

                <asp:Label ID="lblMessage" runat="server" Visible="false"></asp:Label>

                <asp:Button ID="btnSignUp" runat="server" Text="Create Account" CssClass="btn-signup" OnClick="BtnSignUp_Click" />

                <div class="footer-links">
                    <p>Already have an account?</p>
                    <a href="login.aspx">Log In Here</a>
                </div>
            </div>
        </div>
    </form>

    <script>
        (function () {
            if (localStorage.getItem('campus_theme') === 'dark') {
                document.body.classList.add('dark-mode');
            }
            window.addEventListener('storage', function (e) {
                if (e.key === 'campus_theme') {
                    document.body.classList.toggle('dark-mode', e.newValue === 'dark');
                }
            });
        })();

        document.addEventListener('DOMContentLoaded', function () {
            var passwordField = document.getElementById('<%= txtPassword.ClientID %>');
            var confirmField  = document.getElementById('<%= txtConfirmPassword.ClientID %>');
            var passwordReq   = document.getElementById('passwordReq');

            if (passwordField && passwordReq) {
                passwordField.addEventListener('keyup', function () {
                    if (this.value.length >= 6) {
                        passwordReq.innerHTML = '<i class="fas fa-check-circle"></i> Password strength: Good';
                        passwordReq.style.color = '#16a34a';
                    } else {
                        passwordReq.innerHTML = '<i class="fas fa-info-circle"></i> Password must be at least 6 characters';
                        passwordReq.style.color = '#8a9bb0';
                    }
                });
            }

            if (confirmField && passwordField) {
                confirmField.addEventListener('keyup', function () {
                    this.style.borderColor = (this.value === passwordField.value && passwordField.value.length >= 6)
                        ? '#16a34a' : '#dce4ec';
                });
            }
        });
    </script>
</body>
</html>
