<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CTU Login</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-card {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            text-align: center;
            width: 564px;
            height: 539px;
        }
        .ctu-logo {
            width: 100%; /* Spans the width of the card */
            height: auto;
            margin-bottom: 20px;
        }
        .input-group {
            margin-bottom: 15px;
            text-align: left;
        }
        .input-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #1a3a5c;
        }
        .input-field {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .btn-login {
            background-color: #1a3a5c;
            color: white;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
        }
        .btn-login:hover { background-color: #132a42; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-card">
            <asp:Image ID="imgLogo" runat="server" 
                ImageUrl="~/CTU LOGO.jpg" 
                CssClass="ctu-logo" 
                AlternateText="CTU Argao Logo" />

            <h2 style="color: #1a3a5c; margin-bottom: 25px;">Campus Announcement</h2>

            <div class="input-group">
                <asp:Label ID="Label1" runat="server" Text="Role:"></asp:Label>
                <asp:DropDownList ID="txtRole" runat="server" CssClass="input-field">
                    <asp:ListItem Text="Select Role" Value="" />
                    <asp:ListItem Text="Admin" Value="Admin" />
                    <asp:ListItem Text="Student" Value="Student" />
                </asp:DropDownList>
            </div>

            <div class="input-group">
                <asp:Label ID="Label3" runat="server" Text="Username:"></asp:Label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="input-field"></asp:TextBox>
            </div>

            <div class="input-group">
                <asp:Label ID="Label4" runat="server" Text="Password:"></asp:Label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="input-field" TextMode="Password"></asp:TextBox>
            </div>

            <asp:Label ID="lblError" runat="server" style="color: #FF0000; font-style: italic; display: block; margin-bottom: 10px;"></asp:Label>

            <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Log In" CssClass="btn-login" />
        </div>
    </form>
</body>
</html>