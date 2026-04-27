<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>
<html>
<head>
    <title>Database Check</title>
    <style>
        body { font-family: Arial; padding: 40px; background: #f5f5f5; }
        .container { max-width: 1000px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; }
        h1 { color: #1a3a5c; }
        .success { color: #10b981; background: #d1fae5; padding: 15px; border-radius: 5px; margin: 10px 0; }
        .error { color: #dc2626; background: #fee2e2; padding: 15px; border-radius: 5px; margin: 10px 0; }
        .info { color: #2563eb; background: #dbeafe; padding: 15px; border-radius: 5px; margin: 10px 0; }
        table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        th, td { padding: 12px; text-align: left; border: 1px solid #e5e7eb; }
        th { background: #f3f4f6; font-weight: 600; }
        .section { margin: 30px 0; padding: 20px; border: 1px solid #e5e7eb; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔍 Database Structure Check</h1>
        
        <%
            string connStr = @"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CAPdb;User ID=CampusAnnouncementPortal;Password=campus123;";
            
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    Response.Write("<div class='success'>✅ Database connection successful!</div>");
                    
                    // Check if Pinned table exists
                    Response.Write("<div class='section'>");
                    Response.Write("<h2>Pinned Table Check</h2>");
                    
                    SqlCommand checkTable = new SqlCommand("SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Pinned'", con);
                    int tableExists = (int)checkTable.ExecuteScalar();
                    
                    if (tableExists > 0)
                    {
                        Response.Write("<div class='success'>✅ Pinned table EXISTS</div>");
                        
                        // Get table structure
                        Response.Write("<h3>Table Structure:</h3>");
                        Response.Write("<table>");
                        Response.Write("<tr><th>Column Name</th><th>Data Type</th><th>Nullable</th></tr>");
                        
                        SqlCommand getColumns = new SqlCommand("SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Pinned' ORDER BY ORDINAL_POSITION", con);
                        SqlDataReader dr = getColumns.ExecuteReader();
                        while (dr.Read())
                        {
                            Response.Write("<tr>");
                            Response.Write("<td>" + dr["COLUMN_NAME"] + "</td>");
                            Response.Write("<td>" + dr["DATA_TYPE"] + "</td>");
                            Response.Write("<td>" + dr["IS_NULLABLE"] + "</td>");
                            Response.Write("</tr>");
                        }
                        dr.Close();
                        Response.Write("</table>");
                        
                        // Count pins
                        SqlCommand countPins = new SqlCommand("SELECT COUNT(*) FROM Pinned", con);
                        int pinCount = (int)countPins.ExecuteScalar();
                        Response.Write("<div class='info'>📌 Total pins in database: " + pinCount + "</div>");
                        
                        // Show recent pins
                        if (pinCount > 0)
                        {
                            Response.Write("<h3>Recent Pins:</h3>");
                            Response.Write("<table>");
                            Response.Write("<tr><th>User ID</th><th>Announcement ID</th><th>Created Date</th></tr>");
                            
                            SqlCommand getPins = new SqlCommand("SELECT TOP 10 UserId, AnnouncementId, CreatedDate FROM Pinned ORDER BY CreatedDate DESC", con);
                            SqlDataReader dr2 = getPins.ExecuteReader();
                            while (dr2.Read())
                            {
                                Response.Write("<tr>");
                                Response.Write("<td>" + dr2["UserId"] + "</td>");
                                Response.Write("<td>" + dr2["AnnouncementId"] + "</td>");
                                Response.Write("<td>" + (dr2["CreatedDate"] != DBNull.Value ? dr2["CreatedDate"].ToString() : "N/A") + "</td>");
                                Response.Write("</tr>");
                            }
                            dr2.Close();
                            Response.Write("</table>");
                        }
                    }
                    else
                    {
                        Response.Write("<div class='error'>❌ Pinned table DOES NOT EXIST!</div>");
                        Response.Write("<div class='info'><strong>Solution:</strong> Run the CreatePinnedTable.sql script to create the table.</div>");
                        Response.Write("<pre style='background:#f3f4f6;padding:15px;border-radius:5px;overflow-x:auto;'>");
                        Response.Write(@"CREATE TABLE Pinned (
    PinId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    AnnouncementId INT NOT NULL,
    CreatedDate DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Pinned_User FOREIGN KEY (UserId) REFERENCES Users(UserId) ON DELETE CASCADE,
    CONSTRAINT FK_Pinned_Announcement FOREIGN KEY (AnnouncementId) REFERENCES Announcements(AnnouncementId) ON DELETE CASCADE,
    CONSTRAINT UQ_Pinned_UserAnnouncement UNIQUE (UserId, AnnouncementId)
);");
                        Response.Write("</pre>");
                    }
                    Response.Write("</div>");
                    
                    // Check other required tables
                    Response.Write("<div class='section'>");
                    Response.Write("<h2>Other Required Tables</h2>");
                    Response.Write("<table>");
                    Response.Write("<tr><th>Table Name</th><th>Status</th><th>Row Count</th></tr>");
                    
                    string[] tables = { "Users", "Announcements", "UserLikes", "Comments", "Notifications" };
                    foreach (string table in tables)
                    {
                        SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '" + table + "'", con);
                        int exists = (int)checkCmd.ExecuteScalar();
                        
                        Response.Write("<tr>");
                        Response.Write("<td>" + table + "</td>");
                        
                        if (exists > 0)
                        {
                            Response.Write("<td style='color:#10b981;'>✅ EXISTS</td>");
                            try
                            {
                                SqlCommand countCmd = new SqlCommand("SELECT COUNT(*) FROM " + table, con);
                                int count = (int)countCmd.ExecuteScalar();
                                Response.Write("<td>" + count + "</td>");
                            }
                            catch
                            {
                                Response.Write("<td>N/A</td>");
                            }
                        }
                        else
                        {
                            Response.Write("<td style='color:#dc2626;'>❌ MISSING</td>");
                            Response.Write("<td>-</td>");
                        }
                        Response.Write("</tr>");
                    }
                    Response.Write("</table>");
                    Response.Write("</div>");
                    
                    // Session info
                    Response.Write("<div class='section'>");
                    Response.Write("<h2>Current Session</h2>");
                    if (Session["IsLoggedIn"] != null && (bool)Session["IsLoggedIn"])
                    {
                        Response.Write("<div class='success'>✅ User is logged in</div>");
                        Response.Write("<table>");
                        Response.Write("<tr><th>Property</th><th>Value</th></tr>");
                        Response.Write("<tr><td>User ID</td><td>" + Session["UserId"] + "</td></tr>");
                        Response.Write("<tr><td>Username</td><td>" + Session["Username"] + "</td></tr>");
                        Response.Write("<tr><td>Full Name</td><td>" + Session["FullName"] + "</td></tr>");
                        Response.Write("<tr><td>Role</td><td>" + Session["Role"] + "</td></tr>");
                        Response.Write("</table>");
                    }
                    else
                    {
                        Response.Write("<div class='error'>❌ No active session - Please login first!</div>");
                    }
                    Response.Write("</div>");
                    
                    con.Close();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<div class='error'>❌ Error: " + ex.Message + "</div>");
                Response.Write("<pre style='background:#fee2e2;padding:15px;border-radius:5px;'>" + ex.StackTrace + "</pre>");
            }
        %>
        
        <div style="margin-top: 30px; text-align: center;">
            <a href="login.aspx" style="display: inline-block; padding: 12px 24px; background: #1a3a5c; color: white; text-decoration: none; border-radius: 5px; margin: 5px;">Login</a>
            <a href="Student.aspx" style="display: inline-block; padding: 12px 24px; background: #2563eb; color: white; text-decoration: none; border-radius: 5px; margin: 5px;">Student Portal</a>
            <a href="QuickTest.html" style="display: inline-block; padding: 12px 24px; background: #059669; color: white; text-decoration: none; border-radius: 5px; margin: 5px;">Quick Test</a>
        </div>
    </div>
</body>
</html>
