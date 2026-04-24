using System;
using System.Text;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class Pinned : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("login.aspx");
                return;
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
                var html = new StringBuilder();

                // Pinned item: Final Exam Schedule (May 11-14)
                html.Append(@"
<div class='pinned-card'>
  <div class='card-top'>
    <div class='card-author'>
      <div class='avatar'><i class='fas fa-user-tie'></i></div>
      <div>
        <div class='author-name'>Office of the Registrar</div>
        <div class='meta'><span><i class='far fa-calendar-alt'></i> May 11-14, 2026</span><span class='status-pill'>Pinned</span></div>
      </div>
    </div>
    <i class='fas fa-thumbtack pin-icon'></i>
  </div>
  <div class='card-title'>Final Exam Schedule</div>
  <div class='card-text'>All final examinations will be conducted on May 11-14. Please check your department for room/time assignments.</div>
  <div class='card-image'><img src='https://placehold.co/1200x400/1a3a5c/ffffff?text=Exam+Schedule+May+11-14' alt='Exam Schedule' /></div>
</div>");

                // Add another pinned sample if desired
                html.Append(@"
<div class='pinned-card'>
  <div class='card-top'>
    <div class='card-author'>
      <div class='avatar'><i class='fas fa-bullhorn'></i></div>
      <div>
        <div class='author-name'>Student Affairs</div>
        <div class='meta'><span><i class='far fa-calendar-alt'></i> Apr 20, 2026</span><span class='status-pill'>Pinned</span></div>
      </div>
    </div>
    <i class='fas fa-thumbtack pin-icon'></i>
  </div>
  <div class='card-title'>Library Hours Extended</div>
  <div class='card-text'>Library extended hours during exam week: 7:00 AM - Midnight.</div>
</div>");

                var script = $"<script>document.querySelector('.pinned-list').innerHTML = `{EscapeJs(html.ToString())}`;</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "LoadPinned", script);
            }
            catch (Exception ex)
            {
                var errorScript = $"<script>document.querySelector('.pinned-list').innerHTML = '<div class=\"empty-state\">Error loading pinned announcements: {EscapeJs(ex.Message)}</div>';</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "LoadError", errorScript);
            }
        }

        private string EscapeJs(string s)
        {
            if (string.IsNullOrEmpty(s)) return "";
            return s.Replace("`", "\\`").Replace("\\", "\\\\").Replace("</script>", "<\\/script>");
        }
    }
}