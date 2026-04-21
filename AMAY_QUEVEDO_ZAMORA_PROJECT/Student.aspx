<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student.aspx.cs" Inherits="YourProjectName.Student" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Campus Announcement Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #1877f2;
            --primary-light: #e7f3ff;
            --bg: #f0f2f5;
            --card-bg: #ffffff;
            --text-main: #1c1e21;
            --text-muted: #65676b;
            --border: #e4e6eb;
            --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.1);
            --shadow-md: 0 4px 12px rgba(0, 0, 0, 0.08);
            --transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', system-ui, sans-serif; }
        body { background-color: var(--bg); color: var(--text-main); }

        /* --- HEADER --- */
        .navbar {
            background: rgba(255, 255, 255, 0.95); 
            backdrop-filter: blur(10px);
            height: 56px; display: flex; align-items: center;
            justify-content: space-between; padding: 0 16px; position: fixed;
            top: 0; left: 0; right: 0; z-index: 1000; border-bottom: 1px solid var(--border);
            box-shadow: var(--shadow-sm);
        }
        .logo { font-size: 20px; font-weight: 800; color: var(--primary); display: flex; align-items: center; gap: 8px; cursor: pointer; }
        .search-box { 
            background: #f0f2f5; border-radius: 20px; padding: 8px 16px; display: flex; align-items: center; 
            width: 300px; transition: var(--transition); border: 1px solid transparent;
        }
        .search-box:focus-within { white; border-color: var(--primary); box-shadow: 0 0 0 2px var(--primary-light); width: 350px; }
        .search-box input { border: none; background: transparent; outline: none; margin-left: 8px; width: 100%; font-size: 14px; }

        /* --- LAYOUT --- */
        .wrapper {
            display: grid; grid-template-columns: 280px 1fr 300px; gap: 24px;
            max-width: 1300px; margin: 76px auto 0; padding: 0 16px;
        }

        .card { 
            background: var(--card-bg); border-radius: 12px; border: 1px solid var(--border); 
            margin-bottom: 16px; overflow: hidden; box-shadow: var(--shadow-sm);
            transition: var(--transition);
        }

        /* --- SIDEBAR & DROPDOWNS --- */
        .sidebar-section-title { padding: 12px 24px 4px; font-size: 12px; font-weight: 700; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px; }
        .nav-link { 
            display: flex; align-items: center; gap: 12px; padding: 12px 16px; 
            text-decoration: none; color: var(--text-main); font-weight: 600; border-radius: 8px; margin: 2px 12px;
            transition: var(--transition); cursor: pointer;
        }
        .nav-link:hover { background: #f2f2f2; transform: translateX(4px); }
        .nav-link.active { background: var(--primary-light); color: var(--primary); }
        
        .dropdown-arrow { margin-left: auto; font-size: 11px; color: var(--text-muted); transition: var(--transition); }
        
        .dropdown-items {
            background: #fafafa;
            margin: 0 12px 8px 24px;
            border-left: 2px solid var(--primary-light);
            padding: 4px 0;
        }
        .sub-nav-link {
            display: flex; align-items: center; gap: 10px; padding: 8px 16px;
            text-decoration: none; color: var(--text-muted); font-size: 14px; font-weight: 500;
            transition: var(--transition); border-radius: 6px; margin: 2px 8px;
        }
        .sub-nav-link:hover { color: var(--primary); background: var(--primary-light); }

        /* --- CONTENT AREA --- */
        .composer-top { padding: 16px; display: flex; align-items: center; gap: 12px; }
        .avatar-circle { width: 40px; height: 40px; border-radius: 50%; background: var(--primary); color: white; display: flex; align-items: center; justify-content: center; font-weight: bold; }
        .asp-input { flex: 1; background: #f0f2f5; border: 1px solid transparent; border-radius: 24px; padding: 12px 20px; outline: none; }
        .tools-bar { display: flex; justify-content: space-between; align-items: center; padding: 10px 16px; border-top: 1px solid var(--border); background: #fafafa; }
        .pill { border: none; background: #e4e6eb; padding: 8px 20px; border-radius: 20px; font-weight: 600; cursor: pointer; }
        .pill.active { background: var(--primary); color: white; }
        .empty-view { text-align: center; padding: 60px 20px; color: var(--text-muted); }
        .badge { background: #fa3e3e; color: white; font-size: 11px; padding: 2px 8px; border-radius: 10px; }
        
        /* Blue Box Styling */
        .blue-header { background-color: var(--primary); color: white; border: none; margin-bottom: 16px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar">
            <div class="logo"> 
                <span>Campus<span style="color:var(--text-main)">Announcement</span></span>
            </div>
            <div class="search-box">
                <i class="fas fa-search" style="color:var(--text-muted)"></i>
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Search Announcements..."></asp:TextBox>
            </div>
            <div style="display:flex; gap:12px;">
                <div class="avatar-circle" style="width:36px; height:36px; background:#e4e6eb; color:black;"><i class="fas fa-bell"></i></div>
            </div>
        </nav>

        <div class="wrapper">
            <aside>
                <div class="card" style="padding: 12px 0;">
                    <div class="sidebar-section-title">Main Menu</div>
                    <div class="dropdown-container">
                        <asp:LinkButton ID="lnkCategory" runat="server" CssClass="nav-link" OnClick="lnkCategory_Click">
                            <i class="fas fa-layer-group"></i> 
                            <span>Category</span>
                            <asp:Label ID="lblArrow" runat="server"><i class="fas fa-chevron-down dropdown-arrow"></i></asp:Label>
                        </asp:LinkButton>
                        <asp:Panel ID="pnlCategoryDropdown" runat="server" Visible="false" CssClass="dropdown-items">
                            <asp:LinkButton ID="btnExamCat" runat="server" CssClass="sub-nav-link" OnClick="FilterCategory_Click" CommandArgument="Exam">Exam</asp:LinkButton>
                            <asp:LinkButton ID="btnSuspensionCat" runat="server" CssClass="sub-nav-link" OnClick="FilterCategory_Click" CommandArgument="Suspension">Suspension</asp:LinkButton>
                            <asp:LinkButton ID="btnEventCat" runat="server" CssClass="sub-nav-link" OnClick="FilterCategory_Click" CommandArgument="Event">Events</asp:LinkButton>
                        </asp:Panel>
                    </div>

                    <div class="sidebar-section-title" style="margin-top:10px;">Preferences</div>
                    <div class="dropdown-container">
                        <asp:LinkButton ID="lnkSettings" runat="server" CssClass="nav-link" OnClick="lnkSettings_Click">
                            <i class="fas fa-cog"></i> 
                            <span>Settings</span>
                            <asp:Label ID="lblSettingsArrow" runat="server"><i class="fas fa-chevron-down dropdown-arrow"></i></asp:Label>
                        </asp:LinkButton>
                        <asp:Panel ID="pnlSettingsDropdown" runat="server" Visible="false" CssClass="dropdown-items">
                            <asp:LinkButton ID="lnkDark" runat="server" CssClass="sub-nav-link">
                                <i class="fas fa-moon"></i> Dark Mode
                            </asp:LinkButton>
                            <asp:LinkButton ID="lnkAccount" runat="server" CssClass="sub-nav-link">
                                <i class="fas fa-user-shield"></i> Privacy
                            </asp:LinkButton>
                        </asp:Panel>
                    </div>

                    <hr style="border:0; border-top:1px solid var(--border); margin:12px 16px;">
                    <div class="sidebar-section-title">Saved</div>
                    <asp:LinkButton ID="lnkPinnedSidebar" runat="server" CssClass="nav-link active">
                        <i class="fas fa-thumbtack"></i> 
                        <span>Pinned</span>
                        <span class="badge" style="margin-left:auto;">0</span>
                    </asp:LinkButton>
                    <div style="padding: 4px 24px 12px; font-size: 11px; color: var(--text-muted);">No pinned items yet.</div>
                    <div style="padding: 0 24px; font-size: 11px; color: var(--text-muted);">&copy; 2026 University IT</div>
                </div>
            </aside>

            <main>
                <div class="card blue-header">
                    <div style="padding: 16px 24px; display: flex; align-items: center; gap: 12px; font-weight: 700;">
                        <i class="fas fa-bullhorn"></i>
                        <span>Announcement Board</span>
                    </div>
                </div>

                <div class="card">
                </div>

                <div class="card empty-view">
                    <i class="fas fa-newspaper" style="font-size:48px; margin-bottom:15px; opacity:0.2;"></i>
                    <h2><asp:Label ID="lblMain" runat="server" Text="No announcements yet"></asp:Label></h2>
                    <p><asp:Label ID="lblSub" runat="server" Text="Updates will appear here."></asp:Label></p>
                </div>
            </main>

            <aside>
                <div class="card">
                    <div style="padding:16px; font-weight:700; border-bottom: 1px solid var(--border);">Notifications</div>
                    <div class="empty-view" style="padding:30px;">
                        <i class="fas fa-bell-slash" style="font-size:24px;"></i>
                        <p style="font-size:12px;">No new alerts</p>
                    </div>
                </div>
            </aside>
        </div>
    </form>
</body>
</html>