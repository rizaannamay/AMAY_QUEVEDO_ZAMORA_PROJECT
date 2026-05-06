using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    /// <summary>
    /// Saves the uploaded profile photo to disk (uploads/profiles/)
    /// and stores only the relative file path in Users.ProfileImage.
    /// </summary>
    public class UploadProfilePhoto : IHttpHandler, IRequiresSessionState
    {
        private static readonly string ConnStr =
            @"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CAPdb;User ID=CampusAnnouncementPortal;Password=campus123;";

        public bool IsReusable => false;

        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";
            ctx.Response.TrySkipIisCustomErrors = true;

            var js = new JavaScriptSerializer();

            // ── Auth check ──────────────────────────────────────────
            if (ctx.Session["IsLoggedIn"] == null || !(bool)ctx.Session["IsLoggedIn"])
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Not logged in." }));
                return;
            }

            int userId;
            if (ctx.Session["UserId"] == null ||
                !int.TryParse(ctx.Session["UserId"].ToString(), out userId))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Session expired." }));
                return;
            }

            // ── File check ──────────────────────────────────────────
            if (ctx.Request.Files.Count == 0 || ctx.Request.Files[0].ContentLength == 0)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "No file received." }));
                return;
            }

            var file = ctx.Request.Files[0];

            // Validate extension
            string ext = Path.GetExtension(file.FileName ?? "").ToLowerInvariant();
            if (ext != ".jpg" && ext != ".jpeg" && ext != ".png" && ext != ".gif" && ext != ".webp")
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Only JPG, PNG, GIF, or WEBP allowed." }));
                return;
            }

            // Validate size (2 MB)
            if (file.ContentLength > 2 * 1024 * 1024)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Image must be under 2 MB." }));
                return;
            }

            try
            {
                // ── Save file to disk ───────────────────────────────
                string folderPath = ctx.Server.MapPath("~/uploads/profiles/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                // Use userId as filename so each user has one photo (overwrites old one)
                string fileName    = userId + ext;
                string fullPath    = Path.Combine(folderPath, fileName);
                string relativePath = "uploads/profiles/" + fileName;

                file.SaveAs(fullPath);

                // ── Save path to database ───────────────────────────
                using (var con = new SqlConnection(ConnStr))
                {
                    con.Open();
                    using (var cmd = new SqlCommand(
                        "UPDATE Users SET ProfileImage = @img WHERE UserId = @uid", con))
                    {
                        cmd.Parameters.AddWithValue("@img", relativePath);
                        cmd.Parameters.AddWithValue("@uid", userId);
                        int rows = cmd.ExecuteNonQuery();

                        if (rows == 0)
                        {
                            ctx.Response.Write(js.Serialize(new { ok = false, error = "User not found." }));
                            return;
                        }
                    }
                }

                // ── Update session ──────────────────────────────────
                ctx.Session["ProfileImage"] = relativePath;

                ctx.Response.Write(js.Serialize(new { ok = true, imagePath = relativePath }));
            }
            catch (Exception ex)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = ex.Message }));
            }
        }
    }
}
