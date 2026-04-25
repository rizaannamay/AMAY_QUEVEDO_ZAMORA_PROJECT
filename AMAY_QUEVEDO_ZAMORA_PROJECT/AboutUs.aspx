<%@ Page Language="C#" AutoEventWireup="true" %>
<script runat="server">
    protected string BackUrl
    {
        get
        {
            var source = (Request.QueryString["source"] ?? string.Empty).ToLowerInvariant();
            return source == "teacher" ? "Teacher.aspx" : "Student.aspx";
        }
    }

    protected string BackLabel
    {
        get
        {
            var source = (Request.QueryString["source"] ?? string.Empty).ToLowerInvariant();
            return source == "teacher" ? "Back to Teacher" : "Back to Student";
        }
    }

</script>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Campus Connect - About Us</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --bg-image: url('bg.jpg');
            --page-text: #e8edf3;
            --surface: rgba(15, 20, 27, 0.88);
            --surface-strong: rgba(22, 28, 36, 0.96);
            --surface-soft: rgba(40, 49, 61, 0.72);
            --border: rgba(255, 255, 255, 0.08);
            --primary: #7fc8ff;
            --primary-2: #2f80ed;
            --accent: #f7b267;
            --muted: #a9b7c8;
            --shadow: 0 22px 55px rgba(0, 0, 0, 0.35);
        }

        body {
            min-height: 100vh;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            color: var(--page-text);
            background:
                linear-gradient(rgba(6, 10, 15, 0.72), rgba(6, 10, 15, 0.88)),
                var(--bg-image) center/cover fixed no-repeat;
            padding: 28px;
        }

        a {
            color: inherit;
            text-decoration: none;
        }

        .page-shell {
            max-width: 1240px;
            margin: 0 auto;
            display: grid;
            gap: 22px;
        }

        .topbar,
        .hero,
        .section-card {
            background: var(--surface);
            backdrop-filter: blur(14px);
            border: 1px solid var(--border);
            border-radius: 28px;
            box-shadow: var(--shadow);
        }

        .topbar {
            padding: 18px 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 14px;
            font-size: 28px;
            font-weight: 800;
        }

        .brand-badge {
            width: 54px;
            height: 54px;
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, var(--primary-2), var(--primary));
            color: #07131f;
            font-size: 24px;
        }

        .top-actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .action-link {
            padding: 12px 20px;
            border-radius: 999px;
            border: 1px solid rgba(127, 200, 255, 0.22);
            background: var(--surface-soft);
            color: var(--page-text);
            font-weight: 600;
            transition: transform 0.2s ease, background 0.2s ease;
        }

        .action-link:hover {
            transform: translateY(-1px);
            background: rgba(127, 200, 255, 0.12);
        }

        .hero {
            overflow: hidden;
            display: grid;
            grid-template-columns: 1.2fr 0.8fr;
        }

        .hero-copy {
            padding: 40px;
            display: grid;
            gap: 18px;
        }

        .eyebrow {
            color: var(--accent);
            font-size: 13px;
            font-weight: 700;
            letter-spacing: 0.18em;
            text-transform: uppercase;
        }

        h1 {
            font-size: clamp(2.2rem, 4vw, 4rem);
            line-height: 1.05;
            color: #ffffff;
        }

        .hero-copy p {
            font-size: 1.05rem;
            line-height: 1.75;
            color: var(--muted);
            max-width: 680px;
        }

        .hero-stats {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 14px;
            margin-top: 8px;
        }

        .stat {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.06);
            border-radius: 20px;
            padding: 18px;
        }

        .stat strong {
            display: block;
            font-size: 1.5rem;
            color: #ffffff;
            margin-bottom: 6px;
        }

        .stat span {
            color: var(--muted);
            font-size: 0.95rem;
        }

        .hero-visual {
            min-height: 100%;
            background:
                linear-gradient(rgba(19, 39, 62, 0.2), rgba(19, 39, 62, 0.68)),
                url('campus-main.jpg') center/cover no-repeat;
            display: flex;
            align-items: flex-end;
            padding: 28px;
        }

        .hero-caption {
            width: 100%;
            background: rgba(6, 12, 18, 0.72);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 22px;
            padding: 18px 20px;
        }

        .hero-caption h2 {
            color: #ffffff;
            font-size: 1.2rem;
            margin-bottom: 8px;
        }

        .hero-caption p {
            color: var(--muted);
            line-height: 1.6;
            font-size: 0.95rem;
        }

        .content-grid {
            display: grid;
            grid-template-columns: 0.9fr 1.1fr;
            gap: 22px;
        }

        .section-card {
            padding: 28px;
        }

        .section-heading {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 18px;
        }

        .section-heading i {
            width: 42px;
            height: 42px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 14px;
            color: #091019;
            background: linear-gradient(135deg, var(--primary), var(--accent));
        }

        .section-heading h3 {
            color: #ffffff;
            font-size: 1.35rem;
        }

        .mission-list {
            display: grid;
            gap: 14px;
        }

        .mission-item {
            padding: 18px;
            border-radius: 18px;
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid rgba(255, 255, 255, 0.06);
        }

        .mission-item h4 {
            font-size: 1.05rem;
            margin-bottom: 8px;
            color: #ffffff;
        }

        .mission-item p {
            color: var(--muted);
            line-height: 1.7;
        }

        .gallery-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 16px;
        }

        .gallery-card {
            overflow: hidden;
            border-radius: 22px;
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid rgba(255, 255, 255, 0.06);
        }

        .gallery-card img {
            width: 100%;
            height: 220px;
            object-fit: cover;
            display: block;
        }

        .gallery-copy {
            padding: 16px 18px 18px;
        }

        .gallery-copy h4 {
            color: #ffffff;
            margin-bottom: 8px;
            font-size: 1rem;
        }

        .gallery-copy p {
            color: var(--muted);
            line-height: 1.6;
            font-size: 0.94rem;
        }

        .footer-note {
            text-align: center;
            color: var(--muted);
            font-size: 0.92rem;
            padding-bottom: 8px;
        }

        .creators-section {
            display: grid;
            gap: 18px;
        }

        .creators-intro {
            color: var(--muted);
            line-height: 1.7;
            font-size: 0.98rem;
            max-width: 760px;
        }

        .creators-grid {
            display: grid;
            gap: 18px;
        }

        .creator-card {
            display: grid;
            grid-template-columns: 120px 1fr;
            align-items: center;
            gap: 22px;
            padding: 22px;
            border-radius: 24px;
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid rgba(255, 255, 255, 0.06);
        }

        .creator-photo {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            overflow: hidden;
            border: 3px solid rgba(127, 200, 255, 0.24);
            background: linear-gradient(135deg, rgba(127, 200, 255, 0.28), rgba(247, 178, 103, 0.22));
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 14px 28px rgba(0, 0, 0, 0.18);
        }

        .creator-photo img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        .creator-photo i {
            font-size: 2.2rem;
            color: #ffffff;
        }

        .creator-info h4 {
            color: #ffffff;
            font-size: 1.2rem;
            margin-bottom: 8px;
        }

        .creator-role {
            color: var(--accent);
            font-size: 0.9rem;
            font-weight: 700;
            letter-spacing: 0.08em;
            text-transform: uppercase;
            margin-bottom: 10px;
        }

        .creator-quote {
            color: var(--muted);
            line-height: 1.7;
            font-size: 0.97rem;
            font-style: italic;
        }

        @media (max-width: 980px) {
            body { padding: 16px; }
            .hero,
            .content-grid { grid-template-columns: 1fr; }
            .hero-copy,
            .section-card { padding: 24px; }
            .hero-stats,
            .gallery-grid { grid-template-columns: 1fr; }
            .topbar { align-items: flex-start; flex-direction: column; }
            .creator-card { grid-template-columns: 1fr; text-align: center; }
            .creator-photo { margin: 0 auto; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-shell">
            <div class="topbar">
                <div class="brand">
                    <div class="brand-badge">
                        <i class="fas fa-university"></i>
                    </div>
                    <div>
                        <div>Campus Connect</div>
                        <div style="font-size:13px;color:var(--muted);font-weight:500;">Cebu Technological University Announcement Portal</div>
                    </div>
                </div>

                <div class="top-actions">
                    <a class="action-link" href="<%= BackUrl %>"><i class="fas fa-arrow-left"></i> <%= BackLabel %></a>
                </div>
            </div>

            <section class="hero">
                <div class="hero-copy">
                    <div class="eyebrow">About The Platform</div>
                    <h1>One place for trusted campus announcements, updates, and student connections.</h1>
                    <p>
                        Campus Connect is a centralized web-based announcement system for Cebu Technological University.
                        It helps students stay informed through official updates, exam schedules, class suspensions,
                        campus activities, and important school notices in a clean and accessible space.
                    </p>

                    <div class="hero-stats">
                        <div class="stat">
                            <strong>24/7</strong>
                            <span>Access to official school announcements</span>
                        </div>
                        <div class="stat">
                            <strong>1 Hub</strong>
                            <span>For events, schedules, and updates</span>
                        </div>
                        <div class="stat">
                            <strong>Fast</strong>
                            <span>Designed to help students respond quickly</span>
                        </div>
                    </div>
                </div>

                <div class="hero-visual">
                    <div class="hero-caption">
                        <h2>Showcase your campus</h2>
                        <p>
                            Replace `campus-main.jpg` with your best school photo, then add more images below for events,
                            announcements, offices, or student activities.
                        </p>
                    </div>
                </div>
            </section>

            <div class="content-grid">
                <section class="section-card">
                    <div class="section-heading">
                        <i class="fas fa-bullseye"></i>
                        <h3>What This Page Does</h3>
                    </div>

                    <div class="mission-list">
                        <div class="mission-item">
                            <h4>Highlights your system</h4>
                            <p>
                                This separate About Us page gives your project a more professional presentation instead of
                                keeping the introduction inside a small popup.
                            </p>
                        </div>
                        <div class="mission-item">
                            <h4>Supports more school photos</h4>
                            <p>
                                The gallery layout is ready for campus announcement images, event banners, registrar notices,
                                organization activities, and other school visuals.
                            </p>
                        </div>
                        <div class="mission-item">
                            <h4>Matches your dark mode</h4>
                            <p>
                                The design follows the same dark portal style so it feels consistent with the Student page.
                            </p>
                        </div>
                    </div>
                </section>

                <section class="section-card">
                    <div class="section-heading">
                        <i class="fas fa-image"></i>
                        <h3>Campus Gallery</h3>
                    </div>

                    <div class="gallery-grid">
                        <article class="gallery-card">
                            <img src="campus-event-1.jpg" alt="Campus event announcement" />
                            <div class="gallery-copy">
                                <h4>Student Activities</h4>
                                <p>Use this slot for announcement posters, student week photos, or campus program highlights.</p>
                            </div>
                        </article>

                        <article class="gallery-card">
                            <img src="campus-event-2.jpg" alt="Academic announcement board" />
                            <div class="gallery-copy">
                                <h4>Academic Updates</h4>
                                <p>Perfect for exam schedules, departmental notices, and registrar announcement images.</p>
                            </div>
                        </article>

                        <article class="gallery-card">
                            <img src="campus-event-3.jpg" alt="School campus view" />
                            <div class="gallery-copy">
                                <h4>Campus Highlights</h4>
                                <p>Add a photo of your university grounds, buildings, or student facilities to build identity.</p>
                            </div>
                        </article>

                        <article class="gallery-card">
                            <img src="campus-event-4.jpg" alt="School announcement campaign" />
                            <div class="gallery-copy">
                                <h4>Official Campaigns</h4>
                                <p>Use this area for orientation drives, reminders, safety announcements, or event promotions.</p>
                            </div>
                        </article>
                    </div>
                </section>
            </div>

            <div class="footer-note">
                Replace the image files `campus-main.jpg`, `campus-event-1.jpg`, `campus-event-2.jpg`, `campus-event-3.jpg`, and `campus-event-4.jpg`
                with your actual school photos in the same project folder.
            </div>

            <section class="section-card creators-section">
                <div class="section-heading">
                    <i class="fas fa-users"></i>
                    <h3>Meet The Creators</h3>
                </div>

                <p class="creators-intro">
                    This portal was created with the goal of making campus announcements more organized, accessible,
                    and helpful for both students and teachers. Add your real profile photos anytime by replacing the
                    image filenames below in the same project folder.
                </p>

                <div class="creators-grid">
                    <article class="creator-card">
                        <div class="creator-photo">
                            <img src="creator-amay.jpg" alt="Amay Riza Ann" />
                        </div>
                        <div class="creator-info">
                            <h4>Amay Riza Ann</h4>
                            <div class="creator-role">Creator</div>
                            <div class="creator-quote">"We built this platform to make every important school update easier to reach, understand, and trust."</div>
                        </div>
                    </article>

                    <article class="creator-card">
                        <div class="creator-photo">
                            <img src="creator-mary.jpg" alt="Quevedo Mary Chris" />
                        </div>
                        <div class="creator-info">
                            <h4>Quevedo Mary Chris</h4>
                            <div class="creator-role">Creator</div>
                            <div class="creator-quote">"Good communication creates a stronger campus community, and this portal was designed to support that every day."</div>
                        </div>
                    </article>

                    <article class="creator-card">
                        <div class="creator-photo">
                            <img src="creator-shaira.jpg" alt="Zamora Shaira Jane" />
                        </div>
                        <div class="creator-info">
                            <h4>Zamora Shaira Jane</h4>
                            <div class="creator-role">Creator</div>
                            <div class="creator-quote">"Our vision was to create a space where announcements feel clear, official, and always within reach."</div>
                        </div>
                    </article>
                </div>
            </section>
        </div>
    </form>
</body>
</html>
