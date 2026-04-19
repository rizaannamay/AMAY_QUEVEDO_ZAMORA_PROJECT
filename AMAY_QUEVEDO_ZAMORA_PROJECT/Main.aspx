<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Main" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Campus Announcement Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', Helvetica, Arial, sans-serif;
            background-color: #f0f2f5;
            color: #1c1e21;
            transition: background 0.3s, color 0.3s;
        }

        /* --- DARK MODE STYLES --- */
        body.dark-mode { background-color: #18191a; color: #e4e6eb; }
        body.dark-mode .header { background-color: #242526; border-bottom: 1px solid #3e4042; }
        body.dark-mode .card { background-color: #242526; border-color: #3e4042; color: #e4e6eb; }
        body.dark-mode .sidebar-item { color: #e4e6eb; }
        body.dark-mode .sidebar-item i { background: #3a3b3c; color: #e4e6eb; }
        body.dark-mode .dummy-input { background: #3a3b3c; color: #b0b3b8; }
        body.dark-mode .header-search { background: #3a3b3c; }
        body.dark-mode .header-search input { color: white; }

        /* --- HEADER --- */
        .header {
            background-color: #1a3a5c;
            height: 56px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 16px;
            position: fixed;
            top: 0; left: 0; right: 0;
            z-index: 1000;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .header-left { display: flex; align-items: center; gap: 10px; }
        .logo-text { color: white; font-weight: bold; font-size: 16px; letter-spacing: 0.5px; }

        .header-search {
            background: #f0f2f5;
            border-radius: 20px;
            padding: 7px 15px;
            width: 300px;
            display: flex;
            align-items: center;
            margin-left: 20px;
        }
        .header-search input { border: none; background: transparent; outline: none; margin-left: 8px; width: 100%; }

        /* --- LAYOUT --- */
        .app-container {
            display: grid;
            grid-template-columns: 280px 1fr 320px;
            gap: 16px;
            margin-top: 56px;
            padding: 16px;
            max-width: 1400px;
            margin-left: auto;
            margin-right: auto;
        }

        /* --- SIDEBAR --- */
        .sidebar-item {
            display: flex;
            align-items: center;
            padding: 10px 12px;
            cursor: pointer;
            border-radius: 8px;
            transition: 0.2s;
            text-decoration: none;
            color: #050505;
            font-weight: 500;
            border: none;
            background: transparent;
            width: 100%;
            text-align: left;
            font-size: 15px;
        }
        .sidebar-item:hover { background-color: #e4e6eb; }
        .sidebar-item i { 
            width: 36px; height: 36px; border-radius: 50%; background: #e4e6eb;
            display: flex; align-items: center; justify-content: center;
            margin-right: 12px; color: #1a3a5c;
        }
        .sidebar-item.active { background-color: #e7f3ff; color: #1877f2; }
        .sidebar-item.active i { background-color: #1877f2; color: white; }

        /* --- CARDS --- */
        .card {
            background: white;
            border-radius: 8px;
            margin-bottom: 16px;
            box-shadow: 0 1px 2px rgba(0,0,0,0.1);
            border: 1px solid #dddfe2;
            padding: 16px;
        }

        .post-top { display: flex; align-items: center; gap: 8px; margin-bottom: 12px; }
        .avatar { width: 40px; height: 40px; background: #ddd; border-radius: 50%; }
        .dummy-input {
            background: #f0f2f5; border-radius: 20px; padding: 10px 12px; flex: 1;
            color: #65676b; cursor: text; font-size: 15px;
        }

        .badge { background: #e7f3ff; color: #1877f2; padding: 2px 8px; border-radius: 5px; font-size: 12px; }
    </style>
</head>
<body>

<form id="form1" runat="server">
    <div class="header">
        <div class="header-left">
            <i class="fa-solid fa-bullhorn" style="color:white; font-size:24px;"></i>
            <asp:Label ID="Label1" runat="server" Text="CAMPUS ANNOUNCEMENT PORTAL" CssClass="logo-text"></asp:Label>
            <div class="header-search">
                <i class="fa fa-search" style="color:#65676b"></i>
                <input type="text" placeholder="Search Announcements..." />
            </div>
        </div>
        <div style="display:flex; gap:12px; color:white; align-items:center;">
            <i class="fa fa-bell"></i>
            <i class="fa fa-envelope"></i>
            <div class="avatar" style="width:32px; height:32px; border:2px solid white;"></div>
        </div>
    </div>

    <div class="app-container">
        <aside>
            <asp:LinkButton ID="btnHome" runat="server" OnClick="Nav_Click" CommandArgument="Home" CssClass="sidebar-item active">
                <i class="fa fa-home"></i> Announcement Board
            </asp:LinkButton>
            
            <asp:LinkButton ID="btnCat" runat="server" OnClick="Nav_Click" CommandArgument="Cats" CssClass="sidebar-item">
                <i class="fa fa-th-large"></i> Categories
            </asp:LinkButton>
            
            <asp:LinkButton ID="btnPin" runat="server" OnClick="Nav_Click" CommandArgument="Pinned" CssClass="sidebar-item">
                <i class="fa fa-thumbtack"></i> Pinned Announcements
            </asp:LinkButton>

            <div style="margin:8px 0; border-top:1px solid #ced0d4;"></div>

            <button type="button" onclick="toggleDarkMode()" class="sidebar-item">
                <i class="fa fa-moon"></i> Dark Mode
            </button>

            <asp:LinkButton ID="btnGroup" runat="server" OnClick="Nav_Click" CommandArgument="Groups" CssClass="sidebar-item">
                <i class="fa fa-users"></i> Create Group
            </asp:LinkButton>

            <asp:LinkButton ID="btnSet" runat="server" OnClick="Nav_Click" CommandArgument="Settings" CssClass="sidebar-item">
                <i class="fa fa-cog"></i> Settings
            </asp:LinkButton>
        </aside>

        <main>
            <asp:MultiView ID="MainMultiView" runat="server">
                
                <asp:View ID="ViewBoard" runat="server">
                    <div class="card">
                        <div class="post-top">
                            <div class="avatar" style="background: linear-gradient(45deg, #1a3a5c, #1877f2);"></div>
                            <div class="dummy-input">What's on your mind, Admin?</div>
                        </div>
                        <div style="display: flex; border-top: 1px solid #f0f2f5; padding-top: 10px; justify-content: space-around;">
                            <div style="cursor:pointer; color:#65676b; font-size:14px; font-weight:600;"><i class="fa fa-image" style="color:#45bd62"></i> Photo</div>
                            <div style="cursor:pointer; color:#65676b; font-size:14px; font-weight:600;"><i class="fa fa-calendar-check" style="color:#f7b928"></i> Event</div>
                            <div style="cursor:pointer; color:#65676b; font-size:14px; font-weight:600;"><i class="fa fa-poll" style="color:#1877f2"></i> Poll</div>
                        </div>
                    </div>

                    <div class="card" style="border-left: 5px solid #fa3e3e; background-color: #fffafa;">
                        <div style="display:flex; justify-content:space-between;">
                            <div style="display:flex; gap:12px;">
                                <div class="avatar" style="background-color:#fa3e3e; color:white; display:flex; align-items:center; justify-content:center;"><i class="fa fa-exclamation-triangle"></i></div>
                                <div>
                                    <b style="color:#d93025;">Admin Office</b> <span class="badge" style="background:#fa3e3e; color:white;">URGENT</span>
                                    <div style="font-size:12px; color:#65676b">10 mins ago</div>
                                </div>
                            </div>
                            <i class="fa fa-thumbtack" style="color:#1877f2;"></i>
                        </div>
                        <div style="margin-top:15px;">
                            <h4 style="margin-bottom:5px;">⚠️ Class Suspension Update</h4>
                            <p>Due to heavy rainfall, classes in all levels are suspended today, April 19, 2026.</p>
                        </div>
                    </div>

                    <div class="card">
                        <div style="display:flex; gap:12px; margin-bottom:12px;">
                            <div class="avatar" style="background-color:#1877f2; color:white; display:flex; align-items:center; justify-content:center;"><i class="fa fa-university"></i></div>
                            <div>
                                <b>Student Council</b> <span class="badge">Events</span>
                                <div style="font-size:12px; color:#65676b">2 hours ago</div>
                            </div>
                        </div>
                        <p>Join us for the <b>Campus Music Fest</b> this Friday! Registration is open.</p>
                        <div style="width:100%; height:180px; background:#e4e6eb; border-radius:8px; margin-top:12px; display:flex; align-items:center; justify-content:center; color:#8a8d91;">
                            <i class="fa fa-images" style="font-size:40px;"></i>
                        </div>
                    </div>
                </asp:View>

                <asp:View ID="ViewCategories" runat="server">
                    <div class="card">
                        <h3>Browse Categories</h3>
                        <div style="display:grid; grid-template-columns: 1fr 1fr; gap:10px; margin-top:15px;">
                            <div class="card" style="text-align:center; cursor:pointer;">Academics</div>
                            <div class="card" style="text-align:center; cursor:pointer;">Events</div>
                            <div class="card" style="text-align:center; cursor:pointer;">Sports</div>
                            <div class="card" style="text-align:center; cursor:pointer;">Admissions</div>
                        </div>
                    </div>
                </asp:View>

                <asp:View ID="ViewSettings" runat="server">
                    <div class="card">
                        <h3>Account Settings</h3>
                        <hr style="margin:10px 0; opacity:0.2;"/>
                        <p><b>Notification Settings:</b> Enabled</p>
                        <p><b>Privacy:</b> Campus Only</p>
                        <br />
                        <button type="button" class="badge" style="border:none; padding:10px; cursor:pointer;">Update Profile</button>
                    </div>
                </asp:View>
            </asp:MultiView>
        </main>

        <aside>
            <div class="card">
                <b>Notifications</b>
                <div style="margin-top:10px; font-size:13px; color:#65676b;">No new alerts today.</div>
            </div>
        </aside>
    </div>
</form>

<script>
    function toggleDarkMode() {
        const isDark = document.body.classList.toggle('dark-mode');
        localStorage.setItem('campusDarkMode', isDark);
    }
    window.onload = function () {
        if (localStorage.getItem('campusDarkMode') === 'true') {
            document.body.classList.add('dark-mode');
        }
    };
</script>
</body>
</html>