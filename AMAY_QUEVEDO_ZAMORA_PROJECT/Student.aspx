<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Student" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Student Dashboard - Campus Announcement</title>

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
        🎓 STUDENT DASHBOARD - CAMPUS ANNOUNCEMENT
    </div>

    <div class="container">

        <!-- SEARCH -->
        <div class="card">
            <h3>Search Announcements</h3>

            <asp:TextBox ID="txtSearch" runat="server"
                CssClass="post"
                Text="Search..." />

            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" />
        </div>

        <!-- PINNED -->
        <div class="card">
            <h3>📌 Pinned Announcement</h3>
            <p>No pinned announcements available.</p>
        </div>

        <!-- ANNOUNCEMENTS -->
        <div class="card">
            <h3>Announcements</h3>
            <p>No announcements yet.</p>
        </div>

        <!-- COMMENT -->
        <div class="card">
            <h3>Comment / Feedback</h3>

            <asp:TextBox ID="txtComment" runat="server"
                CssClass="post"
                TextMode="MultiLine"
                Rows="3" />

            <asp:Button ID="btnComment" runat="server" Text="Send Comment" CssClass="btn" />
        </div>

    </div>

</form>

</body>
</html>
