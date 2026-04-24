using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class Student : Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CampusAnnouncementDB;User ID=Campus_Announcement;Password=campus123");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("login.aspx");
            }

            if (!IsPostBack)
            {
                LoadUserInfo();
                LoadAnnouncements();
            }
        }

        private void LoadUserInfo()
        {
            try
            {
                con.Open();
                string query = "SELECT FullName, Email, Role FROM Users WHERE Username = @Username";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Username", Session["Username"].ToString());
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    string fullName = reader["FullName"].ToString();
                    string email = reader["Email"].ToString();
                    string role = reader["Role"].ToString();

                    string script = $"<script>loadUserData('{fullName.Replace("'", "\\'")}', '{email}', '{role}');</script>";
                    ClientScript.RegisterStartupScript(this.GetType(), "LoadUser", script);
                }
                reader.Close();
                con.Close();
            }
            catch (Exception ex)
            {
                con.Close();
                System.Diagnostics.Debug.WriteLine("LoadUserInfo Error: " + ex.Message);
            }
        }

        private void LoadAnnouncements()
        {
            try
            {
                con.Open();
                string query = @"SELECT AnnouncementId, Title, Content, Category, AuthorName, 
                                        CreatedDate, LikeCount, CommentCount, ShareCount, IsPinned
                                 FROM Announcements 
                                 WHERE IsActive = 1 
                                 ORDER BY IsPinned DESC, CreatedDate DESC";

                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader reader = cmd.ExecuteReader();

                string html = "";
                while (reader.Read())
                {
                    int id = Convert.ToInt32(reader["AnnouncementId"]);
                    string title = reader["Title"].ToString();
                    string content = reader["Content"].ToString();
                    string category = reader["Category"].ToString();
                    string author = reader["AuthorName"].ToString();
                    DateTime date = Convert.ToDateTime(reader["CreatedDate"]);
                    int likes = Convert.ToInt32(reader["LikeCount"]);
                    int comments = Convert.ToInt32(reader["CommentCount"]);
                    int shares = Convert.ToInt32(reader["ShareCount"]);
                    bool pinned = Convert.ToBoolean(reader["IsPinned"]);

                    string categoryClass = "";
                    if (category.ToLower() == "exam") categoryClass = "post-category-exam";
                    else if (category.ToLower() == "suspension") categoryClass = "post-category-suspension";
                    else categoryClass = "post-category-event";

                    string pinnedClass = pinned ? "pinned" : "";

                    html += $@"
                        <div class='announcement-card' data-category='{category}' data-post-id='{id}'>
                            <div class='post-header'>
                                <div class='post-header-left'>
                                    <div class='post-avatar'><i class='fas fa-user-tie'></i></div>
                                    <div class='post-user-info'>
                                        <div class='post-author'>{EscapeHtml(author)}</div>
                                        <div class='post-meta'>
                                            <span><i class='far fa-calendar-alt'></i> {date:MMMM dd, yyyy}</span>
                                            <span class='post-category {categoryClass}'>{category}</span>
                                        </div>
                                    </div>
                                </div>
                                <button type='button' class='pin-btn-top {pinnedClass}' onclick='togglePinTop(this, {id})'><i class='fas fa-thumbtack'></i></button>
                            </div>
                            <div class='post-content'>
                                <div class='post-title'>{EscapeHtml(title)}</div>
                                <div class='post-text'>{EscapeHtml(content)}</div>
                            </div>
                            <div class='post-stats'>
                                <span onclick='toggleLikeFromStats(this, {id})'><i class='far fa-heart'></i> <span class='like-count'>{likes}</span> Likes</span>
                                <span onclick='scrollToComments(this)'><i class='far fa-comment'></i> <span class='comment-count'>{comments}</span> Comments</span>
                                <span onclick='sharePost({id})'><i class='far fa-share-square'></i> <span class='share-count'>{shares}</span> Shares</span>
                            </div>
                            <div class='action-buttons'>
                                <button type='button' class='action-btn' onclick='toggleLike(this, {id})'><i class='far fa-heart'></i> Like</button>
                                <button type='button' class='action-btn' onclick='toggleComments(this)'><i class='far fa-comment'></i> Comment</button>
                                <button type='button' class='action-btn' onclick='sharePost({id})'><i class='fas fa-share'></i> Share</button>
                            </div>
                            <div class='comments-section'>
                                <div class='comment-input'>
                                    <input type='text' placeholder='Write a comment...' id='commentInput_{id}' />
                                    <button type='button' onclick='addComment(this, {id})'>Post</button>
                                </div>
                                <div class='comments-list' id='commentsList_{id}'>
                                    <div class='no-comments'>No comments yet. Be the first!</div>
                                </div>
                            </div>
                        </div>";
                }
                reader.Close();
                con.Close();

                if (string.IsNullOrEmpty(html))
                {
                    html = "<div style='text-align:center;padding:40px;'>No announcements available.</div>";
                }

                string script = $"<script>document.getElementById('announcementsContainer').innerHTML = `{html}`;</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "LoadAnnouncements", script);
            }
            catch (Exception ex)
            {
                con.Close();
                string errorScript = $"<script>document.getElementById('announcementsContainer').innerHTML = '<div style=\"text-align:center;padding:40px;color:red;\">Error loading announcements: {ex.Message.Replace("'", "\\'")}</div>';</script>";
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