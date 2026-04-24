<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Campus Connect - Login</title>
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

        .login-container {
            width: 100%;
            max-width: 440px;
        }

        /* Logo */
        .neon-logo {
            text-align: center;
            margin-bottom: 40px;
        }

        .neon-logo img {
            width: 90px;
            height: auto;
            filter: drop-shadow(0 4px 12px rgba(0,100,200,0.2));
        }

        .neon-logo h1 {
            font-size: 32px;
            font-weight: 800;
            /* Solid color fallback — removes background-clip usage that VS flags */
            color: #1a3a5c;
            margin-top: 15px;
            letter-spacing: 1px;
        }

        .neon-logo p {
            color: #5a6e7c;
            font-size: 13px;
            margin-top: 6px;
        }

        /* Card */
        .neon-card {
            background: #ffffff;
            border-radius: 24px;
            padding: 45px 40px;
            border: 1px solid rgba(26,58,92,0.1);
            box-shadow: 0 20px 35px rgba(0,0,0,0.05);
        }

        .card-header {
            text-align: center;
            margin-bottom: 35px;
        }

        .card-header h2 {
            color: #1a3a5c;
            font-size: 26px;
            font-weight: 700;
        }

        .card-header span {
            color: #7a8e9e;
            font-size: 14px;
        }

        .input-group {
            margin-bottom: 22px;
        }

        .input-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #2c3e50;
            font-size: 13px;
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

        .input-field option {
            background: #ffffff;
            color: #1a2a3a;
        }

        .input-field:focus {
            outline: none;
            border-color: #2c5a7a;
            box-shadow: 0 0 0 3px rgba(44,90,122,0.1);
        }

        .input-field::placeholder {
            color: #b0c4de;
        }

        .btn-login {
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
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(26,58,92,0.2);
            background: linear-gradient(135deg, #0f2a40, #1a4a6a);
        }

        #lblError {
            color: #dc2626;
            font-size: 12px;
            display: block;
            margin: 12px 0;
            padding: 10px;
            background: #fef2f2;
            border-radius: 10px;
            text-align: center;
        }

        .footer {
            text-align: center;
            margin-top: 25px;
            font-size: 12px;
            color: #8a9bb0;
        }

        .footer a {
            color: #1a3a5c;
            text-decoration: none;
            font-weight: 600;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        .divider {
            margin: 15px 0 10px;
            font-size: 12px;
            color: #b0c4de;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="neon-logo">
            <img src="ctu-logo.png" alt="CTU Logo" />
            <h1>CAMPUS CONNECT</h1>
            <p>Cebu Technological University</p>
        </div>

        <form id="form1" runat="server">
            <div class="neon-card">
                <div class="card-header">
                    <h2>Log In</h2>
                    <span>Access announcement portal</span>
                </div>

                <div class="input-group">
                    <asp:Label ID="Label1" runat="server" Text="Role"></asp:Label>
                    <asp:DropDownList ID="txtRole" runat="server" CssClass="input-field">
                        <asp:ListItem Text="Student" Value="Student" />
                        <asp:ListItem Text="Admin" Value="Admin" />
                    </asp:DropDownList>
                </div>

                <div class="input-group">
                    <asp:Label ID="Label3" runat="server" Text="Username"></asp:Label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="input-field" placeholder="Enter username"></asp:TextBox>
                </div>

                <div class="input-group">
                    <asp:Label ID="Label4" runat="server" Text="Password"></asp:Label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="input-field" TextMode="Password" placeholder="Enter password"></asp:TextBox>
                </div>

                <asp:Label ID="lblError" runat="server"></asp:Label>

                <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Log In" CssClass="btn-login" />

                <div class="footer">
                    <div class="divider">────────── OR ──────────</div>
                    <p>Don't have an account? <a href="signin.aspx">Sign Up Here</a></p>
                </div>
            </div>
        </form>
    </div>
</body>
</html>