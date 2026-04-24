using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class Pinned : Page
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
                LoadPinnedAnnouncements();
            }
        }

        private void LoadPinnedAnnouncements()
        {
            try
            {
                con.Open();
                string query = @"SELECT AnnouncementId, Title, Content, Category, AuthorName, 
                                        ImageUrl, CreatedDate, LikeCount, ShareCount
                                 FROM Announcements 
                                 WHERE IsActive = 1 AND IsPinned = 1 
                                 ORDER BY CreatedDate DESC";
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader reader = cmd.ExecuteReader();

                string html = "";
                bool hasPinned = false;

                while (reader.Read())
                {
                    hasPinned = true;
                    int id = Convert.ToInt32(reader["AnnouncementId"]);
                    string title = reader["Title"].ToString();
                    string content = reader["Content"].ToString();
                    string category = reader["Category"].ToString();
                    string author = reader["AuthorName"].ToString();
                    string imageUrl = reader["ImageUrl"] != DBNull.Value ? reader["ImageUrl"].ToString() : "";
                    DateTime date = Convert.ToDateTime(reader["CreatedDate"]);

                    string iconClass = "";
                    string iconHtml = "<i class='fas fa-user-tie'></i>";

                    if (category == "Exam") { iconClass = "avatar"; }
                    else if (category == "Suspension") { iconClass = "avatar"; }
                    else { iconClass = "avatar"; }

                    string imageHtml = string.IsNullOrEmpty(imageUrl) ? "" : $@"
                        <div class='card-image'>
                            <img src='{imageUrl}' alt='{EscapeHtml(title)}' />
                        </div>";

                    html += $@"
                        <div class='pinned-card'>
                            <div class='card-top'>
                                <div class='card-author'>
                                    <div class='avatar'>
                                        {iconHtml}
                                    </div>
                                    <div>
                                        <div class='author-name'>{EscapeHtml(author)}</div>
                                        <div class='meta'>
                                            <span><i class='far fa-calendar-alt'></i> {date:MMMM dd, yyyy}</span>
                                            <span class='status-pill'>Pinned</span>
                                        </div>
                                    </div>
                                </div>
                                <i class='fas fa-thumbtack pin-icon'></i>
                            </div>
                            <div class='card-title'>{EscapeHtml(title)}</div>
                            <div class='card-text'>{EscapeHtml(content)}</div>
                            {imageHtml}
                        </div>";
                }
                reader.Close();
                con.Close();

                if (!hasPinned)
                {
                    html = "<div class='empty-state'><i class='fas fa-thumbtack'></i> No pinned announcements available.</div>";
                }

                string script = $"<script>document.querySelector('.pinned-list').innerHTML = `{html}`;</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "LoadPinned", script);
            }
            catch (Exception ex)
            {
                con.Close();
                string errorScript = $"<script>document.querySelector('.pinned-list').innerHTML = '<div class=\"empty-state\">Error loading pinned announcements: {ex.Message}</div>';</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "LoadError", errorScript);
            }
        }

        private string EscapeHtml(string text)
        {
            if (string.IsNullOrEmpty(text)) return "";
            return System.Security.SecurityElement.Escape(text);
        }
    }
}