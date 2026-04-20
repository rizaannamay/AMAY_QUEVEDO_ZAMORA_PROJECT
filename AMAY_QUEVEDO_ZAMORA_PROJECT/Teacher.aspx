<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Teacher.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Teacher" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Teacher Dashboard - Campus Announcement</title>

    <style>
        body {
            margin: 0;
            font-family: Arial;
            background: #f0f2f5;
        }

        .header {
            background: #1a3a5c;
            color: white;
            padding: 15px;
            text-align: center;
            font-weight: bold;
        }

        .container {
            width: 70%;
            margin: auto;
            padding-top: 20px;
        }

        .card {
            background: white;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 10px;
        }

        .post {
            width: 100%;
            padding: 10px;
            border-radius: 8px;
        }

        .btn {
            margin-top: 10px;
            padding: 8px 12px;
            border: none;
            background: #1a3a5c;
            color: white;
            cursor: pointer;
            border-radius: 5px;
        }

        .btn:hover {
            background: #2a5a8a;
        }
    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="header">
        👩‍🏫 TEACHER DASHBOARD - CAMPUS ANNOUNCEMENT
    </div>

    <div class="container">

        <!-- POST ANNOUNCEMENT -->
        <div class="card">
            <h3>Create Announcement</h3>

            <asp:TextBox ID="txtPost" runat="server"
                CssClass="post"
                TextMode="MultiLine"
                Rows="4" />

            <br />

            <asp:DropDownList ID="ddlCategory" runat="server">
                <asp:ListItem>General</asp:ListItem>
                <asp:ListItem>Exams</asp:ListItem>
                <asp:ListItem>Events</asp:ListItem>
                <asp:ListItem>Suspension</asp:ListItem>
            </asp:DropDownList>

            <br />

            <asp:Button ID="btnPost" runat="server" Text="Post Announcement" CssClass="btn" />
            <asp:Button ID="btnPin" runat="server" Text="Pin Post" CssClass="btn" />
        </div>

        <!-- MANAGE ANNOUNCEMENTS -->
        <div class="card">
            <h3>Manage Announcements</h3>

            <asp:Button ID="btnEdit" runat="server" Text="Edit Selected" CssClass="btn" />
            <asp:Button ID="btnDelete" runat="server" Text="Delete Selected" CssClass="btn" />
        </div>

    </div>

</form>

</body>
</html>