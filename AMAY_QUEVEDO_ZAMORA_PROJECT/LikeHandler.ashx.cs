using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public class LikeHandler : IHttpHandler, IRequiresSessionState
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CAPdb;User ID=CampusAnnouncementPortal;Password=campus123;");

        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";
            JavaScriptSerializer js = new JavaScriptSerializer();

            if (ctx.Session["IsLoggedIn"] == null || !(bool)ctx.Session["IsLoggedIn"] || ctx.Session["UserId"] == null)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Not logged in" }));
                return;
            }

            int userId = Convert.ToInt32(ctx.Session["UserId"]);
            string action = ctx.Request["action"] ?? "toggle";

            try
            {
                switch (action)
                {
                    case "toggle":
                        Toggle(ctx, js, userId);
                        break;

                    case "status":
                        Status(ctx, js, userId);
                        break;

                    default:
                        ctx.Response.Write(js.Serialize(new { ok = false, error = "Unknown action" }));
                        break;
                }
            }
            catch (Exception ex)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = ex.Message }));
                if (con.State == System.Data.ConnectionState.Open) con.Close();
            }
        }

        private void Toggle(HttpContext ctx, JavaScriptSerializer js, int userId)
        {
            int postId;
            if (!int.TryParse(ctx.Request["postId"], out postId))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid postId" }));
                return;
            }

            con.Open();

            SqlCommand checkCmd = new SqlCommand(
                "SELECT COUNT(1) FROM UserLikes WHERE AnnouncementId=@pid AND UserId=@uid", con);
            checkCmd.Parameters.AddWithValue("@pid", postId);
            checkCmd.Parameters.AddWithValue("@uid", userId);
            bool alreadyLiked = Convert.ToInt32(checkCmd.ExecuteScalar()) > 0;

            if (alreadyLiked)
            {
                SqlCommand delCmd = new SqlCommand(
                    "DELETE FROM UserLikes WHERE AnnouncementId=@pid AND UserId=@uid", con);
                delCmd.Parameters.AddWithValue("@pid", postId);
                delCmd.Parameters.AddWithValue("@uid", userId);
                delCmd.ExecuteNonQuery();

                SqlCommand updCmd = new SqlCommand(
                    "UPDATE Announcements SET LikeCount = CASE WHEN LikeCount > 0 THEN LikeCount - 1 ELSE 0 END WHERE AnnouncementId=@pid", con);
                updCmd.Parameters.AddWithValue("@pid", postId);
                updCmd.ExecuteNonQuery();
            }
            else
            {
                SqlCommand insCmd = new SqlCommand(
                    "INSERT INTO UserLikes (AnnouncementId, UserId) VALUES (@pid, @uid)", con);
                insCmd.Parameters.AddWithValue("@pid", postId);
                insCmd.Parameters.AddWithValue("@uid", userId);
                insCmd.ExecuteNonQuery();

                SqlCommand updCmd = new SqlCommand(
                    "UPDATE Announcements SET LikeCount = LikeCount + 1 WHERE AnnouncementId=@pid", con);
                updCmd.Parameters.AddWithValue("@pid", postId);
                updCmd.ExecuteNonQuery();

                SqlCommand notifCmd = new SqlCommand(
                    "INSERT INTO Notifications (UserId, AnnouncementId, Message, IsRead, CreatedDate) " +
                    "SELECT a.UserId, a.AnnouncementId, u.Username + ' liked your announcement: ' + a.Title, 0, GETDATE() " +
                    "FROM Announcements a " +
                    "JOIN Users u ON u.UserId = @uid " +
                    "WHERE a.AnnouncementId = @pid AND a.UserId <> @uid", con);
                notifCmd.Parameters.AddWithValue("@pid", postId);
                notifCmd.Parameters.AddWithValue("@uid", userId);
                notifCmd.ExecuteNonQuery();
            }

            SqlCommand countCmd = new SqlCommand(
                "SELECT ISNULL(LikeCount, 0) FROM Announcements WHERE AnnouncementId=@pid", con);
            countCmd.Parameters.AddWithValue("@pid", postId);
            int newCount = Convert.ToInt32(countCmd.ExecuteScalar());

            con.Close();

            ctx.Response.Write(js.Serialize(new
            {
                ok = true,
                liked = !alreadyLiked,
                likeCount = newCount
            }));
        }

        private void Status(HttpContext ctx, JavaScriptSerializer js, int userId)
        {
            int postId;
            if (!int.TryParse(ctx.Request["postId"], out postId))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid postId" }));
                return;
            }

            con.Open();

            SqlCommand likedCmd = new SqlCommand(
                "SELECT COUNT(1) FROM UserLikes WHERE AnnouncementId=@pid AND UserId=@uid", con);
            likedCmd.Parameters.AddWithValue("@pid", postId);
            likedCmd.Parameters.AddWithValue("@uid", userId);
            bool liked = Convert.ToInt32(likedCmd.ExecuteScalar()) > 0;

            SqlCommand countCmd = new SqlCommand(
                "SELECT ISNULL(LikeCount, 0) FROM Announcements WHERE AnnouncementId=@pid", con);
            countCmd.Parameters.AddWithValue("@pid", postId);
            int count = Convert.ToInt32(countCmd.ExecuteScalar());

            con.Close();

            ctx.Response.Write(js.Serialize(new
            {
                ok = true,
                liked = liked,
                likeCount = count
            }));
        }

        public bool IsReusable
        {
            get { return false; }
        }
    }
}
