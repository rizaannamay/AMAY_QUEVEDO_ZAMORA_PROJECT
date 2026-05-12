<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Backup.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Backup" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Campus Connect  Database Backup</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="dark-mode.css" />
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        :root {
            --bg-image: url('wbg.jpg');
            --uni-overlay: rgba(255,255,255,0.18);
            --primary:#7a5200; --primary-2:#c9920a;
            --surface:rgba(255,255,255,0.93);
            --border:rgba(26,58,92,0.12);
            --muted:#6b7c8f; --shadow:0 8px 24px rgba(0,0,0,0.08);
        }

        html, body, form { min-height: 100%; }
html, body { overflow: auto; }
html::-webkit-scrollbar, body::-webkit-scrollbar { display: none; }
html, body { scrollbar-width: none; -ms-overflow-style: none; }

/* Cover content that scrolls behind the fixed header */
body::before {
    display: none;
}

        body {
            font-family:"Segoe UI",Tahoma,Geneva,Verdana,sans-serif;
            min-height:100vh;
            background-image: var(--bg-image);
            background-size: cover; background-attachment: fixed;
            color:var(--primary);
        }
        .shell { max-width: calc(100% - 20px); margin:0 auto; padding:90px 20px 60px; display:flex; flex-direction:column; gap:20px; }

        /* topbar */
        .topbar {
            background: var(--uni-header-bg, #c9920a); backdrop-filter:blur(10px);
            border:1px solid rgba(255,255,255,0.15); border-radius:24px;
            padding:12px 24px; display:flex; align-items:center;
            justify-content:space-between; box-shadow:0 4px 20px rgba(0,0,0,0.2);
            position: fixed;
            top: 10px;
            left: 10px;
            right: 10px;
            z-index: 200;
            transition: background 0.3s ease, box-shadow 0.3s ease;
        }
        .brand { display:flex; align-items:center; gap:10px; font-size:18px; font-weight:800; color:#ffffff; }
        .brand-badge {
            width:40px; height:40px; border-radius:12px;
            background: linear-gradient(135deg, var(--uni-accent-dark, #7a5200), var(--uni-accent, #c9920a));
            color:#fff; display:flex; align-items:center; justify-content:center; font-size:16px;
        }
        .back-btn {
            width:40px; height:40px; border-radius:50%;
            background: linear-gradient(135deg, var(--uni-accent-dark, #7a5200), var(--uni-accent, #c9920a));
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
        .stat-num { font-size:28px; font-weight:800; color:var(--uni-accent, var(--primary-2)); }
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
        .btn-sql  { background:linear-gradient(135deg, var(--uni-accent-dark, #7a5200), var(--uni-accent, #c9920a)); color:#fff; box-shadow:0 4px 14px rgba(201,146,10,.25); }
        .btn-csv:hover  { box-shadow:0 8px 20px rgba(5,150,105,.35); }
        .btn-sql:hover  { box-shadow:0 8px 20px rgba(201,146,10,.35); }

        /* table preview */
        .table-wrap { overflow-x:auto; margin-top:20px; border-radius:14px; border:1px solid var(--border); }
        .backup-table { width:100%; border-collapse:collapse; font-size:13px; }
        .backup-table th {
            background:linear-gradient(135deg, var(--uni-accent-dark, #7a5200), var(--uni-accent, #c9920a)); color:#fff;
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

        /* ── DARK MODE ── */
        body.dark-mode {
            background-image: linear-gradient(rgba(18,18,18,0.92),rgba(18,18,18,0.92)), url('bg.jpg') !important;
            background-color: #121212 !important;
            background-size: cover !important;
            background-attachment: fixed !important;
            color: #e4e6eb;
        }
        body.dark-mode::before {
            background-image: linear-gradient(rgba(18,18,18,0.92),rgba(18,18,18,0.92)), url('bg.jpg') !important;
            background-size: cover !important;
            background-attachment: fixed !important;
        }
        body.dark-mode .card {
            background: rgba(30, 30, 30, 0.95) !important;
            border-color: rgba(255,255,255,0.08) !important;
        }
        body.dark-mode .card-header {
            color: #f5f5f5 !important;
            border-color: rgba(255,255,255,0.08) !important;
        }
        body.dark-mode .stat-box {
            background: rgba(45, 45, 45, 0.80) !important;
            border-color: rgba(255,255,255,0.10) !important;
        }
        body.dark-mode .stat-num { color: var(--primary-2, #fbbf24) !important; }
        body.dark-mode .stat-lbl { color: #94a3b8 !important; }
        body.dark-mode .backup-table th { background: linear-gradient(135deg, var(--uni-accent-dark, #7a5200), var(--uni-accent, #c9920a)) !important; }
        body.dark-mode .backup-table td {
            color: #e2e8f0 !important;
            border-color: rgba(255,255,255,0.08) !important;
            background: rgba(30, 30, 30, 0.95) !important;
        }
        body.dark-mode .backup-table tr { background: rgba(30, 30, 30, 0.95) !important; }
        body.dark-mode .backup-table tr:nth-child(even),
        body.dark-mode .backup-table tr:nth-child(even) td { background: rgba(45,45,45,0.80) !important; }
        body.dark-mode .backup-table tr:hover td { background: rgba(201,146,10,0.12) !important; }
        body.dark-mode .backup-table { color: #e2e8f0 !important; }
        body.dark-mode .table-wrap { border-color: rgba(255,255,255,0.08) !important; }
        body.dark-mode .msg-success { background: rgba(22,101,52,0.25) !important; color: #86efac !important; border-color: rgba(134,239,172,0.30) !important; }
        body.dark-mode .msg-error   { background: rgba(153,27,27,0.25) !important; color: #fca5a5 !important; border-color: rgba(252,165,165,0.30) !important; }
        body.dark-mode input[type="file"] { background: rgba(45,45,45,0.80) !important; border-color: rgba(255,255,255,0.12) !important; color: #e2e8f0 !important; }
        body.dark-mode code { background: rgba(255,255,255,0.08) !important; color: var(--primary-2, #fbbf24) !important; }
    </style>
</head>
<body>
    <script>
        (function () {
            document.body.classList.toggle('dark-mode', localStorage.getItem('campus_theme') === 'dark');
            window.addEventListener('storage', function (e) {
                if (e.key === 'campus_theme')
                    document.body.classList.toggle('dark-mode', e.newValue === 'dark');
            });
        })();
    </script>
    <form id="form1" runat="server">
        <div class="shell">

            <!-- Topbar -->
            <div class="topbar">
                <div class="brand">
                    <div class="brand-badge"><i class="fas fa-university"></i></div>
                    <span>Database Backup</span>
                </div>
                <a class="back-btn" href="Admin.aspx" title="Back to Dashboard">
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
                            Text="Export Announcements (CSV)"
                            OnClick="btnExportCSV_Click" UseSubmitBehavior="true" />
                        <asp:Button ID="btnExportSQL" runat="server" CssClass="export-btn btn-sql"
                            Text="Export Announcements (SQL)"
                            OnClick="btnExportSQL_Click" UseSubmitBehavior="true" />
                    </div>
                </div>
            </div>

            <!-- Data Recovery -->
            <div class="card">
                <div class="card-header"><i class="fas fa-upload"></i> Data Recovery</div>
                <div class="card-body">
                    <asp:Label ID="lblImportMsg" runat="server" CssClass="msg-box" style="display:none;"></asp:Label>

                    <p style="font-size:14px;color:var(--muted);margin-bottom:20px;">
                        Restore announcements from a previously exported backup file.
                        Supported formats: <strong>CSV</strong> (exported from this page) and <strong>SQL</strong> INSERT scripts.
                    </p>

                    <!-- CSV Import -->
                    <div style="margin-bottom:24px;">
                        <div style="display:flex;align-items:center;gap:8px;margin-bottom:10px;">
                            <div style="width:32px;height:32px;border-radius:10px;background:linear-gradient(135deg,#059669,#10b981);display:flex;align-items:center;justify-content:center;">
                                <i class="fas fa-file-csv" style="color:#fff;font-size:14px;"></i>
                            </div>
                            <span style="font-size:14px;font-weight:700;color:var(--primary);">Import from CSV</span>
                        </div>
                        <p style="font-size:12px;color:var(--muted);margin-bottom:10px;">
                            Upload a CSV file with columns: <code style="background:rgba(0,0,0,0.06);padding:1px 6px;border-radius:4px;">Title, Category, Content, DatePosted</code>
                            (matches the exported format).
                        </p>
                        <div style="display:flex;flex-wrap:wrap;align-items:center;gap:12px;">
                            <asp:FileUpload ID="fuCSV" runat="server"
                                style="font-size:13px;padding:8px 12px;border:1px solid var(--border);border-radius:12px;background:rgba(255,255,255,0.7);color:var(--primary);max-width:340px;" />
                            <asp:Button ID="btnImportCSV" runat="server" CssClass="export-btn btn-csv"
                                Text="Import CSV"
                                OnClick="btnImportCSV_Click" UseSubmitBehavior="true" />
                        </div>
                    </div>

                    <!-- SQL Import -->
                    <div>
                        <div style="display:flex;align-items:center;gap:8px;margin-bottom:10px;">
                            <div style="width:32px;height:32px;border-radius:10px;background:linear-gradient(135deg,#7a5200,#c9920a);display:flex;align-items:center;justify-content:center;">
                                <i class="fas fa-file-code" style="color:#fff;font-size:14px;"></i>
                            </div>
                            <span style="font-size:14px;font-weight:700;color:var(--primary);">Import from SQL</span>
                        </div>
                        <p style="font-size:12px;color:var(--muted);margin-bottom:10px;">
                            Upload a <code style="background:rgba(0,0,0,0.06);padding:1px 6px;border-radius:4px;">.sql</code> file containing
                            <code style="background:rgba(0,0,0,0.06);padding:1px 6px;border-radius:4px;">INSERT INTO Announcements</code> statements
                            (matches the exported format).
                        </p>
                        <div style="display:flex;flex-wrap:wrap;align-items:center;gap:12px;">
                            <asp:FileUpload ID="fuSQL" runat="server"
                                style="font-size:13px;padding:8px 12px;border:1px solid var(--border);border-radius:12px;background:rgba(255,255,255,0.7);color:var(--primary);max-width:340px;" />
                            <asp:Button ID="btnImportSQL" runat="server" CssClass="export-btn btn-sql"
                                Text="Import SQL"
                                OnClick="btnImportSQL_Click" UseSubmitBehavior="true" />
                        </div>
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
                            HeaderStyle-BackColor="#7a5200"
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
<link rel="stylesheet" href="university-theme-decorations.css" />
<script src="university-theme.js"></script>
</body>
</html>
