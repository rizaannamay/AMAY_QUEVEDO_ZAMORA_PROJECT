using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class Backup : Page
    {
        // Controls declared here since there is no designer file
        protected Label    lblUsers;
        protected Label    lblAnnouncements;
        protected Label    lblComments;
        protected Label    lblLikes;
        protected Label    lblNotifications;
        protected Label    lblTimestamp;
        protected Label    lblMsg;
        protected Label    lblImportMsg;
        protected Button   btnExportCSV;
        protected Button   btnExportSQL;
        protected Button   btnImportCSV;
        protected Button   btnImportSQL;
        protected FileUpload fuCSV;
        protected FileUpload fuSQL;
        protected GridView gvAnnouncements;

        private readonly string _conn =
            @"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CampusAnnouncementPortalDB;User ID=CampusAnnouncementPortall;Password=campus123;";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Admin-only guard
            if (Session["IsLoggedIn"] == null || !(bool)Session["IsLoggedIn"] ||
                !string.Equals(Session["Role"] != null ? Session["Role"].ToString() : "", "Admin", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
                LoadStats();
        }

        // ── Query #8 COUNT / AGGREGATE ───────────────────────────────────────
        private void LoadStats()
        {
            using (var con = new SqlConnection(_conn))
            {
                con.Open();

                lblUsers.Text         = GetCount(con, "SELECT COUNT(1) FROM Users");
                lblAnnouncements.Text = GetCount(con, "SELECT COUNT(1) FROM Announcements");
                lblComments.Text      = GetCount(con, "SELECT COUNT(1) FROM Comments");
                lblLikes.Text         = GetCount(con, "SELECT COUNT(1) FROM UserLikes");
                lblNotifications.Text = GetCount(con, "SELECT COUNT(1) FROM Notifications");
                lblTimestamp.Text     = DateTime.Now.ToString("MMMM dd, yyyy hh:mm tt");

                // ── Query #2 SELECT + #7 JOIN + #9 ORDER BY — preview grid ──
                string sql = "SELECT TOP 20 a.AnnouncementId, a.Title, a.Category, " +
                             "u.FullName AS Author, a.Date_Posted, a.LikeCount, a.CommentCount " +
                             "FROM Announcements a " +
                             "JOIN Users u ON u.UserId = a.UserId " +
                             "ORDER BY a.Date_Posted DESC";

                using (var cmd = new SqlCommand(sql, con))
                using (var da  = new SqlDataAdapter(cmd))
                {
                    var dt = new DataTable();
                    da.Fill(dt);
                    gvAnnouncements.DataSource = dt;
                    gvAnnouncements.DataBind();
                }
            }
        }

        private string GetCount(SqlConnection con, string sql)
        {
            using (var cmd = new SqlCommand(sql, con))
                return cmd.ExecuteScalar().ToString();
        }

        // ── BACKUP: Export CSV ───────────────────────────────────────────────
        protected void btnExportCSV_Click(object sender, EventArgs e)
        {
            var sb = new StringBuilder();
            sb.AppendLine("AnnouncementId,Title,Category,Author,DatePosted,LikeCount,CommentCount,Content");

            using (var con = new SqlConnection(_conn))
            {
                con.Open();
                string sql = "SELECT a.AnnouncementId, a.Title, a.Category, u.FullName, " +
                             "a.Date_Posted, a.LikeCount, a.CommentCount, a.Content " +
                             "FROM Announcements a JOIN Users u ON u.UserId = a.UserId " +
                             "ORDER BY a.Date_Posted DESC";

                using (var cmd = new SqlCommand(sql, con))
                using (var dr  = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        sb.AppendLine(string.Format("{0},{1},{2},{3},{4},{5},{6},{7}",
                            dr["AnnouncementId"],
                            CsvEscape(dr["Title"].ToString()),
                            CsvEscape(dr["Category"].ToString()),
                            CsvEscape(dr["FullName"].ToString()),
                            Convert.ToDateTime(dr["Date_Posted"]).ToString("yyyy-MM-dd HH:mm:ss"),
                            dr["LikeCount"],
                            dr["CommentCount"],
                            CsvEscape(dr["Content"].ToString())));
                    }
                }
            }

            string fileName = "CAPdb_Announcements_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".csv";
            Response.Clear();
            Response.ContentType = "text/csv";
            Response.AddHeader("Content-Disposition", "attachment; filename=" + fileName);
            Response.Write(sb.ToString());
            Response.End();
        }

        // ── BACKUP: Export SQL INSERT statements ─────────────────────────────
        protected void btnExportSQL_Click(object sender, EventArgs e)
        {
            var sb = new StringBuilder();
            sb.AppendLine("-- CampusConnect Database Backup");
            sb.AppendLine("-- Generated: " + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
            sb.AppendLine("-- Table: Announcements");
            sb.AppendLine();
            sb.AppendLine("USE CAPdb;");
            sb.AppendLine("GO");
            sb.AppendLine();

            using (var con = new SqlConnection(_conn))
            {
                con.Open();

                // Export Users (without passwords for safety — just structure)
                sb.AppendLine("-- ── USERS ──────────────────────────────────────────────────────");
                string userSql = "SELECT UserId, FullName, Email, Username, Role, CreatedDate FROM Users ORDER BY UserId";
                using (var cmd = new SqlCommand(userSql, con))
                using (var dr  = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        sb.AppendLine(string.Format(
                            "-- User: {0} | {1} | {2} | Role: {3} | Joined: {4}",
                            dr["UserId"], dr["FullName"], dr["Email"],
                            dr["Role"], Convert.ToDateTime(dr["CreatedDate"]).ToString("yyyy-MM-dd")));
                    }
                }
                sb.AppendLine();

                // Export Announcements as INSERT statements
                sb.AppendLine("-- ── ANNOUNCEMENTS ──────────────────────────────────────────────");
                string annSql = "SELECT AnnouncementId, UserId, Title, Content, Category, " +
                                "ImageUrl, Date_Posted, LikeCount, CommentCount, IsPinned " +
                                "FROM Announcements ORDER BY AnnouncementId";
                using (var cmd = new SqlCommand(annSql, con))
                using (var dr  = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        string imgVal = dr["ImageUrl"] == DBNull.Value ? "NULL" :
                                        "N'" + dr["ImageUrl"].ToString().Replace("'", "''") + "'";
                        sb.AppendLine(string.Format(
                            "INSERT INTO Announcements (UserId,Title,Content,Category,ImageUrl,Date_Posted,LikeCount,CommentCount,IsPinned) " +
                            "VALUES ({0},N'{1}',N'{2}',N'{3}',{4},'{5}',{6},{7},{8});",
                            dr["UserId"],
                            dr["Title"].ToString().Replace("'", "''"),
                            dr["Content"].ToString().Replace("'", "''"),
                            dr["Category"].ToString().Replace("'", "''"),
                            imgVal,
                            Convert.ToDateTime(dr["Date_Posted"]).ToString("yyyy-MM-dd HH:mm:ss"),
                            dr["LikeCount"],
                            dr["CommentCount"],
                            Convert.ToBoolean(dr["IsPinned"]) ? 1 : 0));
                    }
                }
                sb.AppendLine();

                // Export Comments
                sb.AppendLine("-- ── COMMENTS ───────────────────────────────────────────────────");
                string comSql = "SELECT CommentId, AnnouncementId, UserId, CommentText, CreatedDate FROM Comments ORDER BY CommentId";
                using (var cmd = new SqlCommand(comSql, con))
                using (var dr  = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        sb.AppendLine(string.Format(
                            "INSERT INTO Comments (AnnouncementId,UserId,CommentText,CreatedDate) " +
                            "VALUES ({0},{1},N'{2}','{3}');",
                            dr["AnnouncementId"], dr["UserId"],
                            dr["CommentText"].ToString().Replace("'", "''"),
                            Convert.ToDateTime(dr["CreatedDate"]).ToString("yyyy-MM-dd HH:mm:ss")));
                    }
                }
            }

            string fileName = "CAPdb_Backup_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".sql";
            Response.Clear();
            Response.ContentType = "text/plain";
            Response.AddHeader("Content-Disposition", "attachment; filename=" + fileName);
            Response.Write(sb.ToString());
            Response.End();
        }

        private static string CsvEscape(string s)
        {
            if (s == null) return "";
            if (s.Contains(",") || s.Contains("\"") || s.Contains("\n"))
                return "\"" + s.Replace("\"", "\"\"") + "\"";
            return s;
        }

        // ── RECOVERY: Import from CSV ────────────────────────────────────────
        protected void btnImportCSV_Click(object sender, EventArgs e)
        {
            if (!fuCSV.HasFile)
            {
                ShowImportMsg("Please select a CSV file first.", false);
                return;
            }

            string ext = Path.GetExtension(fuCSV.FileName).ToLowerInvariant();
            if (ext != ".csv")
            {
                ShowImportMsg("Invalid file type. Please upload a .csv file.", false);
                return;
            }

            int inserted = 0, skipped = 0;

            try
            {
                using (var reader = new StreamReader(fuCSV.FileContent, Encoding.UTF8))
                using (var con = new SqlConnection(_conn))
                {
                    con.Open();

                    // Read header line to detect column positions
                    string headerLine = reader.ReadLine();
                    if (string.IsNullOrWhiteSpace(headerLine))
                    {
                        ShowImportMsg("CSV file is empty or has no header row.", false);
                        return;
                    }

                    string[] headers = ParseCsvLine(headerLine);
                    int idxTitle    = Array.FindIndex(headers, h => h.Equals("Title",       StringComparison.OrdinalIgnoreCase));
                    int idxCategory = Array.FindIndex(headers, h => h.Equals("Category",    StringComparison.OrdinalIgnoreCase));
                    int idxContent  = Array.FindIndex(headers, h => h.Equals("Content",     StringComparison.OrdinalIgnoreCase));
                    int idxDate     = Array.FindIndex(headers, h => h.Equals("DatePosted",  StringComparison.OrdinalIgnoreCase)
                                                                  || h.Equals("Date_Posted", StringComparison.OrdinalIgnoreCase)
                                                                  || h.Equals("Date",        StringComparison.OrdinalIgnoreCase));

                    if (idxTitle < 0 || idxCategory < 0 || idxContent < 0)
                    {
                        ShowImportMsg("CSV must contain at least Title, Category, and Content columns.", false);
                        return;
                    }

                    // Use the logged-in admin's UserId for restored rows
                    int adminUserId = GetAdminUserId(con);

                    string insertSql =
                        "INSERT INTO Announcements (UserId, Title, Content, Category, Date_Posted, LikeCount, CommentCount, IsPinned) " +
                        "VALUES (@uid, @title, @content, @category, @date, 0, 0, 0)";

                    string line;
                    while ((line = reader.ReadLine()) != null)
                    {
                        if (string.IsNullOrWhiteSpace(line)) continue;
                        string[] cols = ParseCsvLine(line);

                        string title    = SafeGet(cols, idxTitle).Trim();
                        string category = SafeGet(cols, idxCategory).Trim();
                        string content  = SafeGet(cols, idxContent).Trim();

                        if (string.IsNullOrEmpty(title)) { skipped++; continue; }

                        // Validate category
                        if (!IsValidCategory(category)) category = "General";

                        DateTime datePosted = DateTime.Now;
                        if (idxDate >= 0)
                        {
                            string rawDate = SafeGet(cols, idxDate).Trim();
                            if (!DateTime.TryParse(rawDate, out datePosted))
                                datePosted = DateTime.Now;
                        }

                        using (var cmd = new SqlCommand(insertSql, con))
                        {
                            cmd.Parameters.AddWithValue("@uid",      adminUserId);
                            cmd.Parameters.AddWithValue("@title",    title);
                            cmd.Parameters.AddWithValue("@content",  content);
                            cmd.Parameters.AddWithValue("@category", category);
                            cmd.Parameters.AddWithValue("@date",     datePosted);
                            cmd.ExecuteNonQuery();
                            inserted++;
                        }
                    }
                }

                LoadStats();
                ShowImportMsg(
                    string.Format("CSV import complete. {0} announcement(s) restored, {1} row(s) skipped.", inserted, skipped),
                    true);
            }
            catch (Exception ex)
            {
                ShowImportMsg("Import failed: " + ex.Message, false);
            }
        }

        // ── RECOVERY: Import from SQL ────────────────────────────────────────
        protected void btnImportSQL_Click(object sender, EventArgs e)
        {
            if (!fuSQL.HasFile)
            {
                ShowImportMsg("Please select a SQL file first.", false);
                return;
            }

            string ext = Path.GetExtension(fuSQL.FileName).ToLowerInvariant();
            if (ext != ".sql")
            {
                ShowImportMsg("Invalid file type. Please upload a .sql file.", false);
                return;
            }

            int inserted = 0, skipped = 0;

            try
            {
                string sqlText;
                using (var reader = new StreamReader(fuSQL.FileContent, Encoding.UTF8))
                    sqlText = reader.ReadToEnd();

                // Match INSERT INTO Announcements (...) VALUES (...) statements
                var insertRegex = new Regex(
                    @"INSERT\s+INTO\s+Announcements\s*\([^)]+\)\s*VALUES\s*\(([^;]+)\)\s*;",
                    RegexOptions.IgnoreCase | RegexOptions.Singleline);

                var matches = insertRegex.Matches(sqlText);
                if (matches.Count == 0)
                {
                    ShowImportMsg("No valid INSERT INTO Announcements statements found in the SQL file.", false);
                    return;
                }

                using (var con = new SqlConnection(_conn))
                {
                    con.Open();
                    int adminUserId = GetAdminUserId(con);

                    // Parse column list from first INSERT to map positions
                    var colListRegex = new Regex(
                        @"INSERT\s+INTO\s+Announcements\s*\(([^)]+)\)",
                        RegexOptions.IgnoreCase);

                    foreach (Match m in matches)
                    {
                        try
                        {
                            // Get the full INSERT statement for this match
                            string fullInsert = m.Value;

                            // Extract column names
                            var colMatch = colListRegex.Match(fullInsert);
                            if (!colMatch.Success) { skipped++; continue; }

                            string[] colNames = colMatch.Groups[1].Value
                                .Split(',');
                            for (int i = 0; i < colNames.Length; i++)
                                colNames[i] = colNames[i].Trim();

                            // Extract values string
                            string valuesStr = m.Groups[1].Value.Trim();
                            string[] values  = ParseSqlValues(valuesStr);

                            if (values.Length != colNames.Length) { skipped++; continue; }

                            // Build a dictionary col -> value
                            var dict = new System.Collections.Generic.Dictionary<string, string>(
                                StringComparer.OrdinalIgnoreCase);
                            for (int i = 0; i < colNames.Length; i++)
                                dict[colNames[i]] = values[i];

                            string title    = dict.ContainsKey("Title")    ? UnquoteSql(dict["Title"])    : "";
                            string content  = dict.ContainsKey("Content")  ? UnquoteSql(dict["Content"])  : "";
                            string category = dict.ContainsKey("Category") ? UnquoteSql(dict["Category"]) : "General";
                            string imgUrl   = dict.ContainsKey("ImageUrl") ? UnquoteSql(dict["ImageUrl"]) : null;
                            bool   isPinned = dict.ContainsKey("IsPinned") && dict["IsPinned"].Trim() == "1";

                            if (string.IsNullOrEmpty(title)) { skipped++; continue; }
                            if (!IsValidCategory(category)) category = "General";

                            DateTime datePosted = DateTime.Now;
                            if (dict.ContainsKey("Date_Posted"))
                            {
                                string rawDate = dict["Date_Posted"].Trim().Trim('\'');
                                if (!DateTime.TryParse(rawDate, out datePosted))
                                    datePosted = DateTime.Now;
                            }

                            string insertSql =
                                "INSERT INTO Announcements (UserId, Title, Content, Category, ImageUrl, Date_Posted, LikeCount, CommentCount, IsPinned) " +
                                "VALUES (@uid, @title, @content, @category, @img, @date, 0, 0, @pin)";

                            using (var cmd = new SqlCommand(insertSql, con))
                            {
                                cmd.Parameters.AddWithValue("@uid",      adminUserId);
                                cmd.Parameters.AddWithValue("@title",    title);
                                cmd.Parameters.AddWithValue("@content",  content);
                                cmd.Parameters.AddWithValue("@category", category);
                                cmd.Parameters.AddWithValue("@img",      string.IsNullOrEmpty(imgUrl) ? (object)DBNull.Value : imgUrl);
                                cmd.Parameters.AddWithValue("@date",     datePosted);
                                cmd.Parameters.AddWithValue("@pin",      isPinned ? 1 : 0);
                                cmd.ExecuteNonQuery();
                                inserted++;
                            }
                        }
                        catch
                        {
                            skipped++;
                        }
                    }
                }

                LoadStats();
                ShowImportMsg(
                    string.Format("SQL import complete. {0} announcement(s) restored, {1} statement(s) skipped.", inserted, skipped),
                    true);
            }
            catch (Exception ex)
            {
                ShowImportMsg("Import failed: " + ex.Message, false);
            }
        }

        // ── Helpers ──────────────────────────────────────────────────────────

        private void ShowImportMsg(string text, bool success)
        {
            lblImportMsg.Text      = (success ? "<i class='fas fa-check-circle' style='margin-right:6px;'></i>" : "<i class='fas fa-exclamation-circle' style='margin-right:6px;'></i>") + text;
            lblImportMsg.CssClass  = "msg-box " + (success ? "msg-success" : "msg-error");
            lblImportMsg.Style["display"] = "block";
        }

        private int GetAdminUserId(SqlConnection con)
        {
            // Use the currently logged-in user's ID; fall back to first Admin in DB
            if (Session["UserId"] != null && int.TryParse(Session["UserId"].ToString(), out int sid))
                return sid;

            using (var cmd = new SqlCommand("SELECT TOP 1 UserId FROM Users WHERE Role='Admin' ORDER BY UserId", con))
            {
                object result = cmd.ExecuteScalar();
                return result != null ? Convert.ToInt32(result) : 1;
            }
        }

        private static bool IsValidCategory(string cat)
        {
            return cat == "Exam Schedule" || cat == "Class Suspension" ||
                   cat == "Campus Events" || cat == "General";
        }

        private static string SafeGet(string[] arr, int idx)
        {
            return (idx >= 0 && idx < arr.Length) ? arr[idx] : "";
        }

        /// <summary>Parses a single CSV line respecting quoted fields.</summary>
        private static string[] ParseCsvLine(string line)
        {
            var fields = new System.Collections.Generic.List<string>();
            bool inQuotes = false;
            var current = new StringBuilder();

            for (int i = 0; i < line.Length; i++)
            {
                char c = line[i];
                if (inQuotes)
                {
                    if (c == '"')
                    {
                        if (i + 1 < line.Length && line[i + 1] == '"') { current.Append('"'); i++; }
                        else inQuotes = false;
                    }
                    else current.Append(c);
                }
                else
                {
                    if (c == '"') inQuotes = true;
                    else if (c == ',') { fields.Add(current.ToString()); current.Clear(); }
                    else current.Append(c);
                }
            }
            fields.Add(current.ToString());
            return fields.ToArray();
        }

        /// <summary>Splits a SQL VALUES(...) string into individual value tokens.</summary>
        private static string[] ParseSqlValues(string valuesStr)
        {
            var tokens = new System.Collections.Generic.List<string>();
            int depth = 0;
            bool inStr = false;
            var cur = new StringBuilder();

            for (int i = 0; i < valuesStr.Length; i++)
            {
                char c = valuesStr[i];
                if (inStr)
                {
                    cur.Append(c);
                    if (c == '\'' && (i + 1 >= valuesStr.Length || valuesStr[i + 1] != '\''))
                        inStr = false;
                    else if (c == '\'' && i + 1 < valuesStr.Length && valuesStr[i + 1] == '\'')
                    { cur.Append('\''); i++; }
                }
                else
                {
                    if (c == '\'') { inStr = true; cur.Append(c); }
                    else if (c == ',' && depth == 0) { tokens.Add(cur.ToString().Trim()); cur.Clear(); }
                    else { cur.Append(c); }
                }
            }
            if (cur.Length > 0) tokens.Add(cur.ToString().Trim());
            return tokens.ToArray();
        }

        /// <summary>Strips surrounding N'...' or '...' SQL string quotes and unescapes ''.</summary>
        private static string UnquoteSql(string val)
        {
            if (val == null) return "";
            val = val.Trim();
            if (val.Equals("NULL", StringComparison.OrdinalIgnoreCase)) return null;
            if (val.StartsWith("N'") || val.StartsWith("n'")) val = val.Substring(1);
            if (val.StartsWith("'") && val.EndsWith("'"))
                val = val.Substring(1, val.Length - 2).Replace("''", "'");
            return val;
        }
    }
}
