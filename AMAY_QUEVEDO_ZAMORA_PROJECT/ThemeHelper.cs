using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    /// <summary>
    /// Server-side university theme helper.
    /// Reads the active theme from the DB and returns an inline &lt;script&gt; block
    /// that sets CSS custom properties on :root immediately — no client-side fetch,
    /// no flash of wrong theme.
    ///
    /// Usage in Page_Load (code-behind):
    ///   ThemeHelper.InjectThemeScript(this);
    ///
    /// Usage in .aspx &lt;head&gt; (for zero-flash):
    ///   &lt;%= ThemeHelper.GetInlineThemeScript() %&gt;
    /// </summary>
    public static class ThemeHelper
    {
        private const string Conn =
            "Data Source=DESKTOP-O39NPLV\\SQLEXPRESS1;Initial Catalog=CampusAnnouncementPortalDB;" +
            "User ID=CampusAnnouncementPortall;Password=campus123;Connect Timeout=30;TrustServerCertificate=True;";

        // ── Theme definitions ─────────────────────────────────────────────────
        // Each theme: overlay (light), darkOverlay, bgImage, header, accent, accentDark
        // Palette aligned with Campus Connect university theme mocks (foundation / Christmas / women’s month / intramurals).
        private static readonly Dictionary<string, ThemeConfig> Themes =
            new Dictionary<string, ThemeConfig>(StringComparer.OrdinalIgnoreCase)
        {
            ["Default"]       = new ThemeConfig("rgba(255,255,255,0)",     "rgba(18,18,18,0.92)", "wbg.jpg",            "#c9920a", "#c9920a", "#a87800"),
            ["FoundationWeek"]= new ThemeConfig("rgba(255,252,220,0.55)", "rgba(45,35,14,0.88)", "Foundation_bg.png",  "#f0a500", "#e09400", "#c07800"),
            ["Christmas"]     = new ThemeConfig("rgba(240,255,245,0.60)", "rgba(12,32,26,0.92)", "Christmas_bg.png",   "#c0392b", "#27ae60", "#1e8449"),
            ["WomensMonth"]   = new ThemeConfig("rgba(245,240,255,0.55)", "rgba(30,22,54,0.90)", "Womens_bg.png",      "#7c3aed", "#6d28d9", "#5b21b6"),
            ["Intramurals"]   = new ThemeConfig("rgba(0,0,0,0.55)",       "rgba(0,0,0,0.82)",    "Intramurals_bg.png", "#ff6b00", "#ff6500", "#cc5200"),
        };

        // ── Read active theme from DB ─────────────────────────────────────────
        public static string GetActiveTheme()
        {
            try
            {
                using (var con = new SqlConnection(Conn))
                {
                    con.Open();
                    using (var cmd = new SqlCommand(
                        "SELECT SettingValue FROM SiteSettings WHERE SettingKey='ActiveTheme'", con))
                    {
                        var result = cmd.ExecuteScalar();
                        if (result != null && Themes.ContainsKey(result.ToString()))
                            return result.ToString();
                    }
                }
            }
            catch { }
            return "Default";
        }

        // ── Build the inline <script> block ──────────────────────────────────
        /// <summary>
        /// Returns a &lt;script&gt; string that sets all --uni-* CSS vars on :root.
        /// Call this from an ASPX expression in &lt;head&gt; for zero-flash theming.
        /// </summary>
        public static string GetInlineThemeScript()
        {
            string name = GetActiveTheme();
            ThemeConfig t = Themes.ContainsKey(name) ? Themes[name] : Themes["Default"];

            return string.Format(
                "<script>" +
                "(function(){{" +
                "  var r=document.documentElement;" +
                "  r.style.setProperty('--uni-overlay','{0}');" +
                "  r.style.setProperty('--uni-header-bg','{1}');" +
                "  r.style.setProperty('--uni-accent','{2}');" +
                "  r.style.setProperty('--uni-accent-dark','{3}');" +
                "  r.style.setProperty('--bg-image',\"url('{4}')\");" +
                "  r.style.setProperty('--uni-dark-overlay','{5}');" +
                "  document.body && document.body.setAttribute('data-uni-theme','{6}');" +
                "  localStorage.setItem('campus_uni_theme','{6}');" +
                "}})();" +
                "</script>",
                t.Overlay, t.Header, t.Accent, t.AccentDark, t.BgImage, t.DarkOverlay, name
            );
        }

        /// <summary>
        /// Registers the theme script as a startup script via ClientScript.
        /// Call from Page_Load in code-behind.
        /// </summary>
        public static void InjectThemeScript(System.Web.UI.Page page)
        {
            string name = GetActiveTheme();
            ThemeConfig t = Themes.ContainsKey(name) ? Themes[name] : Themes["Default"];

            string script = string.Format(
                "(function(){{" +
                "  var r=document.documentElement;" +
                "  r.style.setProperty('--uni-overlay','{0}');" +
                "  r.style.setProperty('--uni-header-bg','{1}');" +
                "  r.style.setProperty('--uni-accent','{2}');" +
                "  r.style.setProperty('--uni-accent-dark','{3}');" +
                "  r.style.setProperty('--bg-image',\"url('{4}')\");" +
                "  r.style.setProperty('--uni-dark-overlay','{5}');" +
                "  document.body && document.body.setAttribute('data-uni-theme','{6}');" +
                "  localStorage.setItem('campus_uni_theme','{6}');" +
                "}})();",
                t.Overlay, t.Header, t.Accent, t.AccentDark, t.BgImage, t.DarkOverlay, name
            );

            page.ClientScript.RegisterStartupScript(
                typeof(ThemeHelper), "UniTheme", script, addScriptTags: true);
        }

        // ── Theme config record ───────────────────────────────────────────────
        private class ThemeConfig
        {
            public string Overlay     { get; }
            public string DarkOverlay { get; }
            public string BgImage     { get; }
            public string Header      { get; }
            public string Accent      { get; }
            public string AccentDark  { get; }

            public ThemeConfig(string overlay, string darkOverlay, string bgImage,
                               string header, string accent, string accentDark)
            {
                Overlay     = overlay;
                DarkOverlay = darkOverlay;
                BgImage     = bgImage;
                Header      = header;
                Accent      = accent;
                AccentDark  = accentDark;
            }
        }
    }
}
