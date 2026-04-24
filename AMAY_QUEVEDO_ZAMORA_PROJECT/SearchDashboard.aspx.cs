using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class SearchDashboard : System.Web.UI.Page
    {
        // Control declarations
        protected TextBox searchBox;
        protected Literal searchQueryLiteral;
        protected Literal resultCountLiteral;
        protected Repeater resultsRepeater;
        protected Panel noResultsPanel;

        // Sample data source
        private List<Announcement> announcementsDB;

        protected void Page_Load(object sender, EventArgs e)
        {
            InitializeAnnouncements();

            if (!IsPostBack)
            {
                // Get search keyword from query string
                string query = Request.QueryString["query"];

                if (!string.IsNullOrWhiteSpace(query))
                {
                    // Trim spaces
                    query = query.Trim();
                    searchBox.Text = query;
                    PerformSearch(query);
                }
                else
                {
                    // If no query, redirect back
                    Response.Redirect("TeacherDashboard.aspx");
                }
            }
        }

        private void InitializeAnnouncements()
        {
            // Sample announcement data
            announcementsDB = new List<Announcement>
            {
                new Announcement {
                    Id = 1, Title = "Final Exam Schedule Spring 2026", Category = "Exam Schedule",
                    Date = "2026-05-10", Time = "09:00 AM", Professor = "Dr. Reyes",
                    ProfessorAvatar = "👨‍🏫",
                    Description = "Final exams will be held from May 15-20, 2026. Please check your exam permits online. Bring school ID and test permit.",
                    BannerText = "EXAM SCHEDULE", BannerType = "exam" },

                new Announcement {
                    Id = 2, Title = "Class Suspension due to Typhoon", Category = "Class Suspension",
                    Date = "2026-04-25", Time = "08:00 PM", Professor = "Admin Office",
                    ProfessorAvatar = "🏫",
                    Description = "Classes suspended on April 26-27 due to Typhoon. All activities will shift to online learning platforms.",
                    BannerText = "CLASS SUSPENSION", BannerType = "suspension" },

                new Announcement {
                    Id = 3, Title = "University Hackathon 2026", Category = "Campus Events",
                    Date = "2026-05-20", Time = "10:00 AM", Professor = "IT Department",
                    ProfessorAvatar = "💻",
                    Description = "48-hour coding challenge with exciting prizes. Form teams of 3-4 members. Registration ends May 15.",
                    BannerText = "HACKATHON", BannerType = "events" },

                new Announcement {
                    Id = 4, Title = "Midterm Grade Release", Category = "Exam Schedule",
                    Date = "2026-04-22", Time = "02:00 PM", Professor = "Registrar",
                    ProfessorAvatar = "📊",
                    Description = "Midterm grades are now available via the student portal. Check your assessment and email your instructors for concerns.",
                    BannerText = "GRADES OUT", BannerType = "exam" },

                new Announcement {
                    Id = 5, Title = "Transport Strike Advisory", Category = "Class Suspension",
                    Date = "2026-04-28", Time = "07:30 AM", Professor = "Student Affairs",
                    ProfessorAvatar = "🚌",
                    Description = "No face-to-face classes on April 30 due to nationwide transport strike. Asynchronous activities will be provided.",
                    BannerText = "STRIKE DAY", BannerType = "suspension" },

                new Announcement {
                    Id = 6, Title = "Cultural Festival 2026", Category = "Campus Events",
                    Date = "2026-05-05", Time = "09:00 AM", Professor = "OSA",
                    ProfessorAvatar = "🎭",
                    Description = "Celebration of arts, international food fair, and cultural performances. Free entrance for all students!",
                    BannerText = "CULTURAL FEST", BannerType = "events" },

                new Announcement {
                    Id = 7, Title = "Research Colloquium", Category = "Campus Events",
                    Date = "2026-05-12", Time = "11:00 AM", Professor = "Graduate School",
                    ProfessorAvatar = "🔬",
                    Description = "Present your research papers and get feedback from panelists. Best paper receives recognition award.",
                    BannerText = "CALL FOR PAPERS", BannerType = "events" }
            };
        }

        private void PerformSearch(string keyword)
        {
            // Trim and convert to lowercase for case-insensitive search
            string searchTerm = keyword.ToLower().Trim();

            // Store the search query for display
            searchQueryLiteral.Text = Server.HtmlEncode(keyword);

            // Filter data using LINQ - Case-insensitive search
            var results = announcementsDB.Where(a =>
                a.Title.ToLower().Contains(searchTerm) ||
                a.Description.ToLower().Contains(searchTerm) ||
                a.Professor.ToLower().Contains(searchTerm) ||
                a.Category.ToLower().Contains(searchTerm)
            ).ToList();

            // Display result count
            resultCountLiteral.Text = $"{results.Count} announcement{(results.Count != 1 ? "s" : "")}";

            // Check if no results found
            if (results.Count == 0)
            {
                noResultsPanel.Visible = true;
                resultsRepeater.Visible = false;
                return;
            }

            // Show results
            noResultsPanel.Visible = false;
            resultsRepeater.Visible = true;
            resultsRepeater.DataSource = results;
            resultsRepeater.DataBind();
        }

        // Helper method to highlight keywords in search results
        protected string HighlightKeyword(string text)
        {
            if (string.IsNullOrEmpty(text))
                return "";

            string searchTerm = Request.QueryString["query"];
            if (string.IsNullOrWhiteSpace(searchTerm))
                return Server.HtmlEncode(text);

            string encodedText = Server.HtmlEncode(text);
            string encodedTerm = Server.HtmlEncode(searchTerm.Trim());

            try
            {
                // Case-insensitive highlighting using regex
                var regex = new Regex($"({Regex.Escape(encodedTerm)})", RegexOptions.IgnoreCase);
                return regex.Replace(encodedText, "<span class='highlight'>$1</span>");
            }
            catch
            {
                return encodedText;
            }
        }

        // Format date for display
        protected string FormatDate(string dateStr)
        {
            if (DateTime.TryParse(dateStr, out DateTime date))
            {
                return date.ToString("MMMM d, yyyy");
            }
            return dateStr;
        }

        // Get category icon based on category type
        protected string GetCategoryIcon(string category)
        {
            switch (category)
            {
                case "Exam Schedule":
                    return "📅";
                case "Class Suspension":
                    return "⚠️";
                case "Campus Events":
                    return "🎉";
                default:
                    return "📢";
            }
        }

        // Get CSS class for category badge
        protected string GetCategoryClass(string category)
        {
            switch (category)
            {
                case "Exam Schedule":
                    return "exam";
                case "Class Suspension":
                    return "suspension";
                case "Campus Events":
                    return "event";
                default:
                    return "exam";
            }
        }

        // Handle new search from the search box
        protected void searchBox_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(searchBox.Text))
            {
                // Redirect with the new search query
                Response.Redirect($"SearchDashboard.aspx?query={Server.UrlEncode(searchBox.Text.Trim())}");
            }
        }
    }

    // Announcement Model
    public class Announcement
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Category { get; set; }
        public string Date { get; set; }
        public string Time { get; set; }
        public string Professor { get; set; }
        public string ProfessorAvatar { get; set; }
        public string Description { get; set; }
        public string BannerText { get; set; }
        public string BannerType { get; set; }
    }
}