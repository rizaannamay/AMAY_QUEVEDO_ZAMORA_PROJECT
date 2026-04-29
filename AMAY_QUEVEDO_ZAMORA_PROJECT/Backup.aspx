<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Backup.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Backup" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Campus Connect – Database Backup</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        :root {
            --primary:#1a3a5c; --primary-2:#2563eb;
            --surface:rgba(255,255,255,0.93);
            --border:rgba(26,58,92,0.12);
            --muted:#6b7c8f; --shadow:0 8px 24px rgba(0,0,0,0.08);
        }
        body {
            font-family:"Segoe UI",Tahoma,Geneva,Verdana,sans-serif;
            min-height:100vh;
            background-image:linear-gradient(rgba(255,255,255,0.18),rgba(255,255,255,0.18)),url('wbg.jpg');
            background-size:cover; background-attachment:fixed;
            color:var(--primary);
        }
        .shell { max-width:700px; margin:0 auto; padding:32px 20px 60px; display:flex; flex-direction:column; gap:20px; }

        /* topbar */
        .topbar {
            background:var(--surface); backdrop-filter:blur(14px);
            border:1px solid var(--border); border-radius:20px;
            padding:14px 22px; display:flex; align-items:center;
            justify-content:space-between; box-shadow:var(--shadow);
        }
        .brand { display:flex; align-items:center; gap:10px; font-size:18px; font-weight:800; }
        .brand-badge {
            width:40px; height:40px; border-radius:12px;
            background:linear-gradient(135deg,#1a3a5c,#2563eb);
            color:#fff; display:flex; align-items:center; justify-content:center; font-size:16px;
        }
        .back-btn {
            width:40px; height:40px; border-radius:50%;
            background:linear-gradient(135deg,#1a3a5c,#2563eb);
            color:#fff; border:none; cursor:pointer; text-decoration:none;
            display:flex; align-items:center; justify-content:center;
            box-shadow:var(--shadow); transition:transform .2s;
        }
        .back-btn:hover { transform:translateY(-2px); }

        /* card */
        .card {
            background:var(--surface); backdrop-filter:blur(14px);
            border:1px solid var(--border); border-radius:24px;
            box-shadow:var(--shadow); overflow:hidden;
        }
        .card-header {
            padding:18px 24px; border-bottom:1px solid var(--border);
            font-size:16px; font-weight:700; display:flex; align-items:center; gap:10px;
        }
        .card-header i { color:var(--primary-2); }
        .card-body { padding:24px; }

        /* stat grid */
        .stat-grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(140px,1fr)); gap:14px; margin-bottom:24px; }
        .stat-box {
            background:#f0f5ff; border:1px solid var(--border); border-radius:16px;
            padding:16px 18px; text-align:center;
        }
        .stat-num { font-size:28px; font-weight:800; color:var(--primary-2); }
        .stat-lbl { font-size:11px; color:var(--muted); font-weight:600; text-transform:uppercase; margin-top:4px; }

        /* export buttons */
        .btn-row { display:flex; flex-wrap:wrap; gap:12px; }
        .export-btn {
            display:inline-flex; align-items:center; gap:8px;
            padding:12px 22px; border:none; border-radius:40px;
            font-size:14px; font-weight:600; cursor:pointer;
            transition:transform .2s, box-shadow .2s;
        }
        .export-btn:hover { transform:translateY(-2px); }
        .btn-csv  { background:linear-gradient(135deg,#059669,#10b981); color:#fff; box-shadow:0 4px 14px rgba(5,150,105,.25); }
        .btn-sql  { background:linear-gradient(135deg,#1a3a5c,#2563eb); color:#fff; box-shadow:0 4px 14px rgba(37,99,235,.25); }
        .btn-csv:hover  { box-shadow:0 8px 20px rgba(5,150,105,.35); }
        .btn-sql:hover  { box-shadow:0 8px 20px rgba(37,99,235,.35); }

        /* table preview */
        .table-wrap { overflow-x:auto; margin-top:20px; border-radius:14px; border:1px solid var(--border); }
        .backup-table { width:100%; border-collapse:collapse; font-size:13px; }
        .backup-table th {
            background:linear-gradient(135deg,#1a3a5c,#2563eb); color:#fff;
            padding:10px 14px; text-align:left; font-weight:600;
        }
        .backup-table td { padding:9px 14px; border-bottom:1px solid var(--border); color:#334155; }
        .backup-table tr:last-child td { border-bottom:none; }
        .backup-table tr:nth-child(even) td { background:#f8fafc; }

        .msg-box {
            padding:12px 18px; border-radius:12px; font-size:13px; font-weight:600;
            margin-bottom:16px; display:none;
        }
        .msg-success { background:#dcfce7; color:#166534; border:1px solid #bbf7d0; }
        .msg-error   { background:#fee2e2; color:#991b1b; border:1px solid #fecaca; }

        /* dark mode */
        .dark-mode body { background-image:linear-gradient(rgba(15,23,42,.85),rgba(15,23,42,.85)),url('bg.jpg'); }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="shell">

            <!-- Topbar -->
            <div class="topbar">
                <div class="brand">
                    <div class="brand-badge"><i class="fas fa-university"></i></div>
                    <span>Database Backup</span>
                </div>
                <a class="back-btn" href="Teacher.aspx" title="Back to Dashboard">
                    <i class="fas fa-home" style="font-size:16px;"></i>
                </a>
            </div>

            <!-- Stats -->
            <div class="card">
                <div class="card-header"><i class="fas fa-database"></i> Database Summary</div>
                <div class="card-body">
                    <div class="stat-grid">
                        <div class="stat-box">
                            <div class="stat-num"><asp:Label ID="lblUsers" runat="server">0</asp:Label></div>
                            <div class="stat-lbl"><i class="fas fa-users"></i> Users</div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-num"><asp:Label ID="lblAnnouncements" runat="server">0</asp:Label></div>
                            <div class="stat-lbl"><i class="fas fa-bullhorn"></i> Announcements</div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-num"><asp:Label ID="lblComments" runat="server">0</asp:Label></div>
                            <div class="stat-lbl"><i class="fas fa-comments"></i> Comments</div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-num"><asp:Label ID="lblLikes" runat="server">0</asp:Label></div>
                            <div class="stat-lbl"><i class="fas fa-heart"></i> Likes</div>
                        </div>
                        <div class="stat-box">
                            <div class="stat-num"><asp:Label ID="lblNotifications" runat="server">0</asp:Label></div>
                            <div class="stat-lbl"><i class="fas fa-bell"></i> Notifications</div>
                        </div>
                    </div>
                    <p style="font-size:12px;color:var(--muted);">
                        <i class="fas fa-clock" style="margin-right:4px;"></i>
                        Last checked: <asp:Label ID="lblTimestamp" runat="server"></asp:Label>
                    </p>
                </div>
            </div>

            <!-- Export -->
            <div class="card">
                <div class="card-header"><i class="fas fa-download"></i> Export / Backup</div>
                <div class="card-body">
                    <asp:Label ID="lblMsg" runat="server" CssClass="msg-box" style="display:none;"></asp:Label>

                    <p style="font-size:14px;color:var(--muted);margin-bottom:18px;">
                        Export all announcements to a file for backup or record-keeping.
                    </p>
                    <div class="btn-row">
                        <asp:Button ID="btnExportCSV" runat="server" CssClass="export-btn btn-csv"
                            Text="⬇ Export Announcements (CSV)"
                            OnClick="btnExportCSV_Click" UseSubmitBehavior="true" />
                        <asp:Button ID="btnExportSQL" runat="server" CssClass="export-btn btn-sql"
                            Text="⬇ Export Announcements (SQL)"
                            OnClick="btnExportSQL_Click" UseSubmitBehavior="true" />
                    </div>
                </div>
            </div>

            <!-- Recent Announcements Preview -->
            <div class="card">
                <div class="card-header"><i class="fas fa-table"></i> Recent Announcements Preview</div>
                <div class="card-body" style="padding:0;">
                    <div class="table-wrap">
                        <asp:GridView ID="gvAnnouncements" runat="server"
                            AutoGenerateColumns="False"
                            GridLines="None"
                            Width="100%"
                            CssClass="backup-table"
                            HeaderStyle-BackColor="#1a3a5c"
                            HeaderStyle-ForeColor="White"
                            RowStyle-BackColor="#ffffff"
                            AlternatingRowStyle-BackColor="#f8fafc">
                            <Columns>
                                <asp:BoundField DataField="AnnouncementId" HeaderText="ID" ItemStyle-Width="50px" />
                                <asp:BoundField DataField="Title"          HeaderText="Title" />
                                <asp:BoundField DataField="Category"       HeaderText="Category" ItemStyle-Width="100px" />
                                <asp:BoundField DataField="Author"         HeaderText="Author" ItemStyle-Width="130px" />
                                <asp:BoundField DataField="Date_Posted"    HeaderText="Date" DataFormatString="{0:MMM dd, yyyy}" ItemStyle-Width="110px" />
                                <asp:BoundField DataField="LikeCount"      HeaderText="Likes" ItemStyle-Width="60px" />
                                <asp:BoundField DataField="CommentCount"   HeaderText="Comments" ItemStyle-Width="80px" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>

        </div>
    </form>
    <script>
        (function () {
            if (localStorage.getItem('campus_theme') === 'dark')
                document.body.classList.add('dark-mode');
        })();
    </script>
</body>
</html>
