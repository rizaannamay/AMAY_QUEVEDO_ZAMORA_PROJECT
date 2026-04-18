<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Main" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Campus Announcement Portal</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
        }

        /* HEADER */
        .header {
            background-color: #1a3a5c;
            height: 60px;
            display: flex;
            align-items: center;
            padding: 0 24px;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
        }

        .logo-text {
            color: white;
            font-weight: bold;
            font-size: 18px;
        }

        /* LAYOUT */
        .app-container {
            display: flex;
            margin-top: 60px;
        }

        /* LEFT SIDEBAR */
        .left-sidebar {
            width: 240px;
            background: white;
            position: fixed;
            top: 60px;
            left: 0;
            bottom: 0;
            border-right: 1px solid #e0e0e0;
            padding-top: 10px;
        }

        .menu-item {
            padding: 12px 20px;
            cursor: pointer;
        }

        .menu-item:hover {
            background: #f0f2f5;
        }

        .menu-divider {
            height: 1px;
            background: #e0e0e0;
            margin: 10px 0;
        }

        /* MAIN CONTENT */
        .main-content {
            flex: 1;
            margin-left: 240px;
            margin-right: 320px;
            padding: 24px;
        }

        /* RIGHT SIDEBAR */
        .right-sidebar {
            width: 320px;
            background: white;
            position: fixed;
            top: 60px;
            right: 0;
            bottom: 0;
            border-left: 1px solid #e0e0e0;
            padding: 16px;
            overflow-y: auto;
        }

        /* CARD */
        .card {
            background: white;
            border-radius: 12px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .card-header {
            padding: 16px;
            font-weight: bold;
            border-bottom: 1px solid #e0e0e0;
        }

        /* SEARCH BOX */
        .search-box {
            width: 100%;
            padding: 10px 16px;
            border-radius: 20px;
            border: 1px solid #ccc;
            outline: none;
        }

        /* POST AREA */
        .post-area {
            padding: 16px;
        }

        .post-input {
            width: 100%;
            border: none;
            background: #f0f2f5;
            padding: 12px;
            border-radius: 20px;
            outline: none;
        }

        .post-actions {
            display: flex;
            gap: 15px;
            padding: 12px 16px;
        }

        .btn {
            border: none;
            background: none;
            cursor: pointer;
            color: #1a3a5c;
            font-size: 14px;
            padding: 8px;
        }

        .section-title {
            font-weight: bold;
            margin-bottom: 10px;
        }
    </style>

</head>

<body>

<form id="form1" runat="server">

    <!-- HEADER -->
    <div class="header">
        <asp:Label ID="Label1" runat="server"
            ForeColor="White"
            Text="CAMPUS ANNOUNCEMENT PORTAL"
            CssClass="logo-text">
        </asp:Label>
    </div>

    <div class="app-container">

        <!-- LEFT SIDEBAR -->
        <div class="left-sidebar">
            <div class="menu-item">Announcement Board</div>
            <div class="menu-item">Categories</div>
            <div class="menu-item">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Pinned</div>
            <div class="menu-divider"></div>
            <div class="menu-item">&nbsp;&nbsp;&nbsp;&nbsp; Settings</div>
        </div>

        <!-- MAIN CONTENT -->
        <div class="main-content">

            <!-- SEARCH (NOW ABOVE ANNOUNCEMENTS) -->
            <div class="card" style="padding:16px;">
                <asp:TextBox ID="txtSearch" runat="server"
                    CssClass="search-box"
                    placeholder="Search announcements..." >    Search.....</asp:TextBox>
            </div>

            <!-- ANNOUNCEMENT BOARD -->
            <div class="card">

                <div class="card-header">Announcement Board</div>

                <div class="post-area">
                    <asp:TextBox ID="txtPost" runat="server"
                        CssClass="post-input"
                        TextMode="MultiLine"
                        Rows="3" />
                </div>

                <div class="post-actions">
                    <asp:LinkButton ID="btnPost" runat="server" CssClass="btn">Post</asp:LinkButton>
                    <asp:LinkButton ID="btnMedia" runat="server" CssClass="btn">Media</asp:LinkButton>
                    <asp:LinkButton ID="btnEvent" runat="server" CssClass="btn">Event</asp:LinkButton>
                </div>

            </div>

            <!-- PINNED -->
            <div class="card">
                <div class="card-header">Pinned Announcements</div>
            </div>

            <!-- RECENT -->
            <div class="card">
                <div class="card-header">Recent Announcements</div>
            </div>

        </div>

        <!-- RIGHT SIDEBAR -->
        <div class="right-sidebar">
            <div class="section-title">Notifications</div>
        </div>

    </div>

</form>

</body>
</html>