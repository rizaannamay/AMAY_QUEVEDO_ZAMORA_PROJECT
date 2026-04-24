using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Text;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class Notifications : Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CampusAnnouncementDB;User ID=Campus_Announcement;Password=campus123");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("login.aspx");
            }

            if (!IsPostBack)
            {
                LoadNotificationsJSON();
            }
        }

        private void LoadNotificationsJSON()
        {
            try
            {
                con.Open();
                string query = @"SELECT NotificationId, Message, IsRead, CreatedDate 
                                 FROM Notifications 
                                 WHERE UserId = @UserId 
                                 ORDER BY CreatedDate DESC";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"].ToString());
                SqlDataReader reader = cmd.ExecuteReader();

                StringBuilder json = new StringBuilder("[");
                bool first = true;

                while (reader.Read())
                {
                    if (!first) json.Append(",");
                    first = false;

                    int id = Convert.ToInt32(reader["NotificationId"]);
                    string message = reader["Message"].ToString();
                    bool isRead = Convert.ToBoolean(reader["IsRead"]);
                    DateTime date = Convert.ToDateTime(reader["CreatedDate"]);
                    string timeAgo = GetTimeAgo(date);

                    json.Append($"{{\"id\":{id},\"message\":\"{EscapeJson(message)}\",\"isRead\":{isRead.ToString().ToLower()},\"timeAgo\":\"{timeAgo}\"}}");
                }
                reader.Close();
                con.Close();

                json.Append("]");

                string script = $"<script>window.notificationsData = {json.ToString()};</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "LoadNotifications", script);
            }
            catch (Exception ex)
            {
                if (con.State == ConnectionState.Open) con.Close();
            }
        }

        private string GetTimeAgo(DateTime date)
        {
            TimeSpan timeSpan = DateTime.Now - date;
            if (timeSpan.TotalMinutes < 1) return "Just now";
            if (timeSpan.TotalMinutes < 60) return $"{(int)timeSpan.TotalMinutes} minutes ago";
            if (timeSpan.TotalHours < 24) return $"{(int)timeSpan.TotalHours} hours ago";
            if (timeSpan.TotalDays < 7) return $"{(int)timeSpan.TotalDays} days ago";
            return date.ToString("MMM dd, yyyy");
        }

        private string EscapeJson(string text)
        {
            if (string.IsNullOrEmpty(text)) return "";
            return text.Replace("\\", "\\\\").Replace("\"", "\\\"").Replace("\n", "\\n");
        }
    }
}