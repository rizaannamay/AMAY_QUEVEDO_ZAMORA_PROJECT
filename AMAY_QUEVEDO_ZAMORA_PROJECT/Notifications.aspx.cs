using System;
using System.Text;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class Notifications : Page
    {
        protected string BackUrl
        {
            get
            {
                return string.Equals(
                    Session["Role"] != null ? Session["Role"].ToString() : "",
                    "Admin", StringComparison.OrdinalIgnoreCase)
                    ? "Teacher.aspx" : "Student.aspx";
            }
        }

        protected string BackLabel
        {
            get
            {
                return string.Equals(
                    Session["Role"] != null ? Session["Role"].ToString() : "",
                    "Admin", StringComparison.OrdinalIgnoreCase)
                    ? "Back to Teacher Portal" : "Back to Student Portal";
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IsLoggedIn"] == null || !(bool)Session["IsLoggedIn"])
            {
                Response.Redirect("login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
                LoadNotificationsData();
        }

        private void LoadNotificationsData()
        {
            var notes = new[]
            {
                new { Id=1, Message="Final Exam Schedule has been posted.",          IsRead=false, Created=DateTime.Now.AddHours(-2) },
                new { Id=2, Message="Class suspension on April 26-27 due to Typhoon.", IsRead=false, Created=DateTime.Now.AddHours(-5) },
                new { Id=3, Message="University Hackathon 2026 registration is open.", IsRead=true,  Created=DateTime.Now.AddDays(-1)  },
                new { Id=4, Message="Midterm grades are now available.",              IsRead=true,  Created=DateTime.Now.AddDays(-3)  },
                new { Id=5, Message="Cultural Festival 2026 — free entrance!",        IsRead=true,  Created=DateTime.Now.AddDays(-7)  }
            };

            var sb = new StringBuilder();
            int unread = 0;
            foreach (var n in notes)
            {
                if (!n.IsRead) unread++;
                string cls = n.IsRead ? "" : "unread";
                string dot = n.IsRead ? "" : "<div class='notification-dot'></div>";
                sb.Append("<div class='notification-item " + cls + "' onclick='markRead(this)'>");
                sb.Append(dot);
                sb.Append("<div class='notification-content'>");
                sb.Append("<div class='notification-title'>" + EscapeHtml(n.Message) + "</div>");
                sb.Append("<span class='notification-time'>" + GetTimeAgo(n.Created) + "</span>");
                sb.Append("</div></div>");
            }

            string html    = sb.Length == 0
                ? "<div style='padding:40px;text-align:center;color:#6b7c8f;'>No notifications yet.</div>"
                : sb.ToString();
            string encoded = System.Web.HttpUtility.JavaScriptStringEncode(html);

            string script = "<script>"
                + "var nc=document.querySelector('.notifications-card');"
                + "if(nc) nc.innerHTML=\"" + encoded + "\";"
                + "</script>";
            ClientScript.RegisterStartupScript(GetType(), "LoadNotifications", script);
        }

        private string GetTimeAgo(DateTime d)
        {
            var ts = DateTime.Now - d;
            if (ts.TotalMinutes < 1)  return "Just now";
            if (ts.TotalMinutes < 60) return (int)ts.TotalMinutes + " minutes ago";
            if (ts.TotalHours   < 24) return (int)ts.TotalHours   + " hours ago";
            if (ts.TotalDays    < 7)  return (int)ts.TotalDays    + " days ago";
            return d.ToString("MMM dd, yyyy");
        }

        private string EscapeHtml(string t) =>
            string.IsNullOrEmpty(t) ? "" : System.Security.SecurityElement.Escape(t);
    }
}
