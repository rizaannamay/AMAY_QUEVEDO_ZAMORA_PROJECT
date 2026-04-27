<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>
<html>
<head>
    <title>Database Connection Test</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 40px; background: #f5f5f5; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #1a3a5c; }
        .success { color: #10b981; background: #d1fae5; padding: 15px; border-radius: 5px; margin: 10px 0; }
        .error { color: #dc2626; background: #fee2e2; padding: 15px; border-radius: 5px; margin: 10px 0; }
        .info { color: #2563eb; background: #dbeafe; padding: 15px; border-radius: 5px; margin: 10px 0; }
        pre { background: #f3f4f6; padding: 15px; border-radius: 5px; overflow-x: auto; }
        .test-section { margin: 20px 0; padding: 20px; border: 1px solid #e5e7eb; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔌 Database Connection Test</h1>
        
        <%
            string result = "";
            string connectionString1 = @"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CAPdb;User ID=CampusAnnouncementPortal;Password=campus123;";
            string connectionString2 = @"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CAPdb;Integrated Security=True;TrustServerCertificate=True;";
            
            // Test 1: SQL Authentication (Used by handlers)
            result += "<div class='test-section'>";
            result += "<h2>Test 1: SQL Authentication (Handler Connection)</h2>";
            result += "<pre>" + connectionString1 + "</pre>";
            
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString1))
                {
                    con.Open();
                    result += "<div class='success'>✅ <strong>SUCCESS!</strong> Connected using SQL Authentication</div>";
                    
                    // Test query
                    SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Announcements", con);
                    int count = (int)cmd.ExecuteScalar();
                    result += "<div class='info'>📊 Found " + count + " announcements in database</div>";
                    
                    // Test tables
                    SqlCommand tablesCmd = new SqlCommand("SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' ORDER BY TABLE_NAME", con);
                    SqlDataReader dr = tablesCmd.ExecuteReader();
                    result += "<div class='info'><strong>Database Tables:</strong><br/>";
                    while (dr.Read())
                    {
                        result += "• " + dr["TABLE_NAME"].ToString() + "<br/>";
                    }
                    result += "</div>";
                    dr.Close();
                    
                    con.Close();
                }
            }
            catch (Exception ex)
            {
                result += "<div class='error'>❌ <strong>FAILED!</strong><br/>" + ex.Message + "</div>";
            }
            result += "</div>";
            
            // Test 2: Windows Authentication (Web.config)
            result += "<div class='test-section'>";
            result += "<h2>Test 2: Windows Authentication (Web.config)</h2>";
            result += "<pre>" + connectionString2 + "</pre>";
            
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString2))
                {
                    con.Open();
                    result += "<div class='success'>✅ <strong>SUCCESS!</strong> Connected using Windows Authentication</div>";
                    
                    SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Announcements", con);
                    int count = (int)cmd.ExecuteScalar();
                    result += "<div class='info'>📊 Found " + count + " announcements in database</div>";
                    
                    con.Close();
                }
            }
            catch (Exception ex)
            {
                result += "<div class='error'>❌ <strong>FAILED!</strong><br/>" + ex.Message + "</div>";
            }
            result += "</div>";
            
            // Session info
            result += "<div class='test-section'>";
            result += "<h2>Session Information</h2>";
            if (Session["IsLoggedIn"] != null && (bool)Session["IsLoggedIn"])
            {
                result += "<div class='success'>✅ User is logged in</div>";
                result += "<div class='info'>";
                result += "<strong>User ID:</strong> " + (Session["UserId"] ?? "N/A") + "<br/>";
                result += "<strong>Username:</strong> " + (Session["Username"] ?? "N/A") + "<br/>";
                result += "<strong>Full Name:</strong> " + (Session["FullName"] ?? "N/A") + "<br/>";
                result += "<strong>Role:</strong> " + (Session["Role"] ?? "N/A") + "<br/>";
                result += "</div>";
            }
            else
            {
                result += "<div class='error'>❌ No active session - User not logged in</div>";
            }
            result += "</div>";
            
            Response.Write(result);
        %>
        
        <div style="margin-top: 30px; padding: 20px; background: #f9fafb; border-radius: 5px;">
            <h3>🔧 Recommendations:</h3>
            <ul>
                <li>If <strong>Test 1 succeeds</strong>, your handlers should work (they use SQL Authentication)</li>
                <li>If <strong>Test 2 succeeds</strong>, update Web.config to match handler connection strings</li>
                <li>If <strong>both fail</strong>, check SQL Server is running and credentials are correct</li>
                <li>Make sure you're <strong>logged in</strong> to test the handlers properly</li>
            </ul>
        </div>
        
        <div style="margin-top: 20px; text-align: center;">
            <a href="login.aspx" style="display: inline-block; padding: 12px 24px; background: #1a3a5c; color: white; text-decoration: none; border-radius: 5px;">Go to Login</a>
            <a href="Student.aspx" style="display: inline-block; padding: 12px 24px; background: #2563eb; color: white; text-decoration: none; border-radius: 5px; margin-left: 10px;">Go to Student Portal</a>
        </div>
    </div>
</body>
</html>
