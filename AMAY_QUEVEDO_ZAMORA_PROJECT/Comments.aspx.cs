using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class Comments : Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CampusAnnouncementDB;User ID=Campus_Announcement;Password=campus123");

        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request.QueryString["action"];

            if (action == "add")
            {
                AddComment();
            }
            else if (action == "get")
            {
                GetComments();
            }
            else
            {
                Response.Write("{\"error\":\"Invalid action\"}");
                Response.End();
            }
        }

        private void AddComment()
        {
            if (Session["UserId"] == null)
            {
                Response.Write("{\"success\":false,\"error\":\"Not logged in\"}");
                Response.End();
                return;
            }

            string json = "";
            using (var reader = new StreamReader(Request.InputStream))
            {
                json = reader.ReadToEnd();
            }

            var serializer = new JavaScriptSerializer();
            dynamic data = serializer.Deserialize<dynamic>(json);

            int announcementId = Convert.ToInt32(data["postId"]);
            string commentText = data["comment"].ToString();
            int userId = Convert.ToInt32(Session["UserId"]);
            string userName = Session["FullName"]?.ToString() ?? Session["Username"]?.ToString() ?? "User";

            try
            {
                con.Open();

                // Create Comments table if not exists
                string createTable = @"
                    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Comments')
                    CREATE TABLE Comments (
                        CommentId INT PRIMARY KEY IDENTITY(1,1),
                        AnnouncementId INT NOT NULL,
                        UserId INT NOT NULL,
                        UserName NVARCHAR(100) NOT NULL,
                        CommentText NVARCHAR(1000) NOT NULL,
                        CreatedDate DATETIME DEFAULT GETDATE(),
                        IsActive BIT DEFAULT 1
                    )";
                SqlCommand createCmd = new SqlCommand(createTable, con);
                createCmd.ExecuteNonQuery();

                // Insert comment
                string insertQuery = @"INSERT INTO Comments (AnnouncementId, UserId, UserName, CommentText, CreatedDate) 
                                       VALUES (@AnnouncementId, @UserId, @UserName, @CommentText, @CreatedDate)";
                SqlCommand insertCmd = new SqlCommand(insertQuery, con);
                insertCmd.Parameters.AddWithValue("@AnnouncementId", announcementId);
                insertCmd.Parameters.AddWithValue("@UserId", userId);
                insertCmd.Parameters.AddWithValue("@UserName", userName);
                insertCmd.Parameters.AddWithValue("@CommentText", commentText);
                insertCmd.Parameters.AddWithValue("@CreatedDate", DateTime.Now);
                insertCmd.ExecuteNonQuery();

                // Update comment count
                string updateQuery = "UPDATE Announcements SET CommentCount = CommentCount + 1 WHERE AnnouncementId = @AnnouncementId";
                SqlCommand updateCmd = new SqlCommand(updateQuery, con);
                updateCmd.Parameters.AddWithValue("@AnnouncementId", announcementId);
                updateCmd.ExecuteNonQuery();

                con.Close();
                Response.Write("{\"success\":true}");
            }
            catch (Exception ex)
            {
                if (con.State == ConnectionState.Open) con.Close();
                Response.Write($"{{\"success\":false,\"error\":\"{ex.Message}\"}}");
            }
            Response.End();
        }

        private void GetComments()
        {
            int announcementId = Convert.ToInt32(Request.QueryString["postId"]);

            try
            {
                con.Open();

                // Check if Comments table exists
                string checkTable = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Comments'";
                SqlCommand checkCmd = new SqlCommand(checkTable, con);
                int tableExists = Convert.ToInt32(checkCmd.ExecuteScalar());

                if (tableExists == 0)
                {
                    con.Close();
                    Response.Write("[]");
                    Response.End();
                    return;
                }

                string query = @"SELECT UserName, CommentText, CreatedDate 
                                 FROM Comments 
                                 WHERE AnnouncementId = @AnnouncementId AND IsActive = 1 
                                 ORDER BY CreatedDate ASC";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@AnnouncementId", announcementId);
                SqlDataReader reader = cmd.ExecuteReader();

                StringBuilder json = new StringBuilder("[");
                bool first = true;

                while (reader.Read())
                {
                    if (!first) json.Append(",");
                    first = false;

                    string userName = reader["UserName"].ToString();
                    string commentText = reader["CommentText"].ToString();
                    DateTime date = Convert.ToDateTime(reader["CreatedDate"]);
                    string timeAgo = GetTimeAgo(date);

                    json.Append($"{{\"author\":\"{EscapeJson(userName)}\",\"text\":\"{EscapeJson(commentText)}\",\"date\":\"{timeAgo}\"}}");
                }
                reader.Close();
                con.Close();

                json.Append("]");
                Response.ContentType = "application/json";
                Response.Write(json.ToString());
            }
            catch (Exception ex)
            {
                if (con.State == ConnectionState.Open) con.Close();
                Response.Write("[]");
            }
            Response.End();
        }

        private string GetTimeAgo(DateTime date)
        {
            TimeSpan timeSpan = DateTime.Now - date;
            if (timeSpan.TotalMinutes < 1) return "Just now";
            if (timeSpan.TotalMinutes < 60) return $"{(int)timeSpan.TotalMinutes}m ago";
            if (timeSpan.TotalHours < 24) return $"{(int)timeSpan.TotalHours}h ago";
            if (timeSpan.TotalDays < 7) return $"{(int)timeSpan.TotalDays}d ago";
            return date.ToString("MMM dd");
        }

        private string EscapeJson(string text)
        {
            if (string.IsNullOrEmpty(text)) return "";
            return text.Replace("\\", "\\\\").Replace("\"", "\\\"").Replace("\n", "\\n");
        }
    }
}