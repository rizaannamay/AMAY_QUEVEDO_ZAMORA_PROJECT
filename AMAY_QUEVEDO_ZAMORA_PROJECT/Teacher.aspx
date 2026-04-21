using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class Teacher : System.Web.UI.Page
    {
        // Sample data storage using DataTable (in-memory, no database)
        private static DataTable announcements;
        private static DataTable comments;
        private static DataTable notifications;
        private static int nextAnnouncementId = 5;
        private static int nextCommentId = 4;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check login
                if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Teacher")
                {
                    Response.Redirect("login.aspx");
                }

                // Set user info
                string username = Session["Username"].ToString();
                lblUserInitial.Text = username.Length > 0 ? username.Substring(0, 1).ToUpper() : "T";

                // Initialize sample data
                InitializeSampleData();
                
                // Load data
                LoadAnnouncements();
                LoadPinnedItems();
                LoadNotifications();
                LoadStats();
            }
        }

        private void InitializeSampleData()
        {
            if (announcements == null)
            {
                announcements = new DataTable();
                announcements.Columns.Add("AnnouncementID", typeof(int));
                announcements.Columns.Add("Title", typeof(string));
                announcements.Columns.Add("Content", typeof(string));
                announcements.Columns.Add("Category", typeof(string));
                announcements.Columns.Add("DatePosted", typeof(DateTime));
                announcements.Columns.Add("Author", typeof(string));
                announcements.Columns.Add("IsPinned", typeof(bool));
                announcements.Columns.Add("CommentCount", typeof(int));

                // Sample announcements
                announcements.Rows.Add(1, "Final Exam Schedule", "The final examinations will be held on December 15-20, 2024.", "Exam", DateTime.Now.AddDays(-5), "Prof. Reyes", true, 2);
                announcements.Rows.Add(2, "Class Suspension - Typhoon", "Due to Typhoon Enteng, classes are suspended tomorrow.", "Suspension", DateTime.Now.AddDays(-2), "Prof. Reyes", true, 1);
                announcements.Rows.Add(3, "University Foundation Week", "Join us for Foundation Week celebration on Dec 1-5, 2024.", "Event", DateTime.Now.AddDays(-3), "Prof. Reyes", false, 0);
                announcements.Rows.Add(4, "Library Extended Hours", "Library will extend hours during exam week.", "Exam", DateTime.Now.AddDays(-1), "Prof. Reyes", false, 0);
            }

            if (comments == null)
            {
                comments = new DataTable();
                comments.Columns.Add("CommentID", typeof(int));
                comments.Columns.Add("AnnouncementID", typeof(int));
                comments.Columns.Add("Content", typeof(string));
                comments.Columns.Add("DatePosted", typeof(DateTime));
                comments.Columns.Add("Author", typeof(string));

                comments.Rows.Add(1, 1, "Thank you for the update!", DateTime.Now.AddDays(-4), "Juan Dela Cruz");
                comments.Rows.Add(2, 1, "What time does the exam start?", DateTime.Now.AddDays(-3), "Maria Santos");
                comments.Rows.Add(3, 2, "Stay safe everyone!", DateTime.Now.AddDays(-1), "John Santos");
            }

            if (notifications == null)
            {
                notifications = new DataTable();
                notifications.Columns.Add("NotificationID", typeof(int));
                notifications.Columns.Add("Message", typeof(string));
                notifications.Columns.Add("DatePosted", typeof(DateTime));
                notifications.Columns.Add("IsRead", typeof(bool));

                notifications.Rows.Add(1, "New comment on your post", DateTime.Now.AddHours(-2), false);
                notifications.Rows.Add(2, "Student replied to announcement", DateTime.Now.AddDays(-1), false);
                notifications.Rows.Add(3, "Your announcement was pinned", DateTime.Now.AddDays(-3), true);
            }
        }

        private void LoadAnnouncements()
        {
            string filter = ViewState["CurrentFilter"] != null ? ViewState["CurrentFilter"].ToString() : "All";
            string searchTerm = txtSearch.Text.Trim();

            DataTable filtered = announcements.Clone();

            foreach (DataRow row in announcements.Rows)
            {
                bool matchFilter = filter == "All" || row["Category"].ToString() == filter;
                bool matchSearch = string.IsNullOrEmpty(searchTerm) || 
                    row["Title"].ToString().ToLower().Contains(searchTerm.ToLower()) ||
                    row["Content"].ToString().ToLower().Contains(searchTerm.ToLower());

                if (matchFilter && matchSearch)
                {
                    // Update comment count
                    int commentCount = comments.Select("AnnouncementID = " + row["AnnouncementID"]).Length;
                    row["CommentCount"] = commentCount;
                    filtered.ImportRow(row);
                }
            }

            if (filtered.Rows.Count > 0)
            {
                rptAnnouncements.DataSource = filtered;
                rptAnnouncements.DataBind();
                pnlAnnouncements.Visible = true;
                pnlEmpty.Visible = false;
                lblFilterBadge.Text = filter;
            }
            else
            {
                pnlAnnouncements.Visible = false;
                pnlEmpty.Visible = true;
                lblFilterBadge.Text = filter;
            }
        }

        private void LoadPinnedItems()
        {
            pnlPinnedList.Controls.Clear();
            int pinCount = 0;
            
            foreach (DataRow row in announcements.Rows)
            {
                if (Convert.ToBoolean(row["IsPinned"]))
                {
                    pinCount++;
                    var item = new LiteralControl($"<div class='pinned-item'><i class='fas fa-thumbtack'></i> {row["Title"]}</div>");
                    pnlPinnedList.Controls.Add(item);
                }
            }
            
            lblPinnedCount.Text = pinCount.ToString();
            
            if (pinCount == 0)
            {
                pnlPinnedList.Controls.Add(new LiteralControl("<div style='padding: 8px 20px; font-size: 12px; color: var(--text-muted);'>No pinned items</div>"));
            }
        }

        private void LoadNotifications()
        {
            if (notifications.Rows.Count > 0)
            {
                rptNotifications.DataSource = notifications;
                rptNotifications.DataBind();
                pnlNotifications.Visible = true;
                pnlNoNotifications.Visible = false;
            }
            else
            {
                pnlNotifications.Visible = false;
                pnlNoNotifications.Visible = true;
            }
        }

        private void LoadStats()
        {
            lblTotalPosts.Text = announcements.Rows.Count.ToString();
            lblTotalComments.Text = comments.Rows.Count.ToString();
            
            int pinnedCount = 0;
            foreach (DataRow row in announcements.Rows)
            {
                if (Convert.ToBoolean(row["IsPinned"])) pinnedCount++;
            }
            lblYourPins.Text = pinnedCount.ToString();
        }

        private void LoadCommentsForAnnouncement(int announcementId, RepeaterItem item)
        {
            Repeater rptComments = (Repeater)item.FindControl("rptComments");
            DataTable announcementComments = comments.Clone();
            
            foreach (DataRow row in comments.Rows)
            {
                if (Convert.ToInt32(row["AnnouncementID"]) == announcementId)
                {
                    announcementComments.ImportRow(row);
                }
            }
            
            rptComments.DataSource = announcementComments;
            rptComments.DataBind();
        }

        // ==================== EVENT HANDLERS ====================

        protected void lnkCategory_Click(object sender, EventArgs e)
        {
            pnlCategoryDropdown.Visible = !pnlCategoryDropdown.Visible;
            lblArrow.Text = pnlCategoryDropdown.Visible ? 
                "<i class='fas fa-chevron-up dropdown-arrow'></i>" : 
                "<i class='fas fa-chevron-down dropdown-arrow'></i>";
        }

        protected void lnkSettings_Click(object sender, EventArgs e)
        {
            pnlSettingsDropdown.Visible = !pnlSettingsDropdown.Visible;
            lblSettingsArrow.Text = pnlSettingsDropdown.Visible ? 
                "<i class='fas fa-chevron-up dropdown-arrow'></i>" : 
                "<i class='fas fa-chevron-down dropdown-arrow'></i>";
        }

        protected void FilterCategory_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            ViewState["CurrentFilter"] = btn.CommandArgument;
            LoadAnnouncements();
        }

        protected void lnkPinnedSidebar_Click(object sender, EventArgs e)
        {
            ViewState["CurrentFilter"] = "Pinned";
            LoadAnnouncements();
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            LoadAnnouncements();
        }

        protected void btnPostAnnouncement_Click(object sender, EventArgs e)
        {
            string title = txtNewTitle.Text.Trim();
            string content = txtNewContent.Text.Trim();
            string category = ddlNewCategory.SelectedValue;

            if (string.IsNullOrEmpty(title) || string.IsNullOrEmpty(content) || string.IsNullOrEmpty(category))
            {
                // Show error message
                return;
            }

            announcements.Rows.Add(nextAnnouncementId, title, content, category, DateTime.Now, Session["Username"].ToString(), false, 0);
            nextAnnouncementId++;

            txtNewTitle.Text = "";
            txtNewContent.Text = "";
            ddlNewCategory.SelectedIndex = 0;

            LoadAnnouncements();
            LoadStats();
        }

        protected void rptAnnouncements_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int announcementId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "TogglePin")
            {
                foreach (DataRow row in announcements.Rows)
                {
                    if (Convert.ToInt32(row["AnnouncementID"]) == announcementId)
                    {
                        row["IsPinned"] = !Convert.ToBoolean(row["IsPinned"]);
                        break;
                    }
                }
                LoadAnnouncements();
                LoadPinnedItems();
                LoadStats();
            }
            else if (e.CommandName == "DeletePost")
            {
                // Delete the announcement
                DataRow toDelete = null;
                foreach (DataRow row in announcements.Rows)
                {
                    if (Convert.ToInt32(row["AnnouncementID"]) == announcementId)
                    {
                        toDelete = row;
                        break;
                    }
                }
                if (toDelete != null)
                {
                    announcements.Rows.Remove(toDelete);
                }
                
                // Delete associated comments
                var commentsToDelete = comments.Select("AnnouncementID = " + announcementId);
                foreach (var comment in commentsToDelete)
                {
                    comments.Rows.Remove(comment);
                }
                
                LoadAnnouncements();
                LoadStats();
            }
            else if (e.CommandName == "SaveEdit")
            {
                RepeaterItem item = (RepeaterItem)e.Item;
                TextBox txtEditTitle = (TextBox)item.FindControl("txtEditTitle");
                TextBox txtEditContent = (TextBox)item.FindControl("txtEditContent");
                DropDownList ddlEditCategory = (DropDownList)item.FindControl("ddlEditCategory");

                foreach (DataRow row in announcements.Rows)
                {
                    if (Convert.ToInt32(row["AnnouncementID"]) == announcementId)
                    {
                        row["Title"] = txtEditTitle.Text;
                        row["Content"] = txtEditContent.Text;
                        row["Category"] = ddlEditCategory.SelectedValue;
                        break;
                    }
                }
                
                LoadAnnouncements();
            }
            else if (e.CommandName == "EditPost")
            {
                RepeaterItem item = (RepeaterItem)e.Item;
                var card = item.FindControl("annCard_" + announcementId);
                if (card != null)
                {
                    // Toggle edit mode using JavaScript
                    ClientScript.RegisterStartupScript(this.GetType(), "EditMode", 
                        $"document.getElementById('annCard_{announcementId}').classList.toggle('edit-mode');", true);
                }
            }
            else if (e.CommandName == "CancelEdit")
            {
                RepeaterItem item = (RepeaterItem)e.Item;
                ClientScript.RegisterStartupScript(this.GetType(), "CancelEdit", 
                    $"document.getElementById('annCard_{announcementId}').classList.remove('edit-mode');", true);
            }
            else if (e.CommandName == "ViewComments")
            {
                RepeaterItem item = (RepeaterItem)e.Item;
                Panel pnlComments = (Panel)item.FindControl("pnlComments");
                pnlComments.Visible = !pnlComments.Visible;
                LoadCommentsForAnnouncement(announcementId, item);
            }
            else if (e.CommandName == "AddComment")
            {
                RepeaterItem item = (RepeaterItem)e.Item;
                TextBox txtNewComment = (TextBox)item.FindControl("txtNewComment");
                string commentText = txtNewComment.Text.Trim();

                if (!string.IsNullOrEmpty(commentText))
                {
                    comments.Rows.Add(nextCommentId, announcementId, commentText, DateTime.Now, Session["Username"].ToString());
                    nextCommentId++;
                    txtNewComment.Text = "";
                    LoadCommentsForAnnouncement(announcementId, item);
                    LoadStats();
                }
            }
        }

        protected void rptAnnouncements_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView row = (DataRowView)e.Item.DataItem;
                int announcementId = Convert.ToInt32(row["AnnouncementID"]);
                
                // Load comments if visible
                Panel pnlComments = (Panel)e.Item.FindControl("pnlComments");
                if (pnlComments != null && pnlComments.Visible)
                {
                    LoadCommentsForAnnouncement(announcementId, e.Item);
                }
            }
        }

        protected void btnMarkAllRead_Click(object sender, EventArgs e)
        {
            foreach (DataRow row in notifications.Rows)
            {
                row["IsRead"] = true;
            }
            LoadNotifications();
        }

        protected void ToggleDarkMode_Click(object sender, EventArgs e)
        {
            // Simple dark mode toggle via JavaScript
            ClientScript.RegisterStartupScript(this.GetType(), "DarkMode", 
                "document.body.classList.toggle('dark-mode');", true);
        }

        protected void Logout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("login.aspx");
        }
    }
}