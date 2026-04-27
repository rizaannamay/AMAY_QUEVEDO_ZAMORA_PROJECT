<%@ Page Language="C#" AutoEventWireup="true" %>
<script runat="server">
    protected string BackUrl {
        get {
            string source = (Request.QueryString["source"] ?? string.Empty).ToLowerInvariant();
            return source == "teacher" ? "Teacher.aspx" : "Student.aspx";
        }
    }
    protected string BackLabel {
        get {
            string source = (Request.QueryString["source"] ?? string.Empty).ToLowerInvariant();
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
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 44px;
            height: 44px;
            border-radius: 50%;
            background: linear-gradient(135deg, #1a3a5c, #2563eb);
            color: #ffffff;
            border: none;
            box-shadow: var(--shadow);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .action-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(37,99,235,0.35);
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
                url('School Campus View.jpg') center/cover no-repeat;
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
            cursor: pointer;
            transition: transform 0.25s ease, box-shadow 0.25s ease, border-color 0.25s ease;
        }

        .gallery-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 16px 28px rgba(0, 0, 0, 0.24);
            border-color: rgba(127, 200, 255, 0.2);
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
            cursor: pointer;
            transition: transform 0.25s ease, box-shadow 0.25s ease, border-color 0.25s ease;
        }

        .creator-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 16px 28px rgba(0, 0, 0, 0.24);
            border-color: rgba(127, 200, 255, 0.2);
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

        .image-modal {
            position: fixed;
            inset: 0;
            display: none;
            align-items: center;
            justify-content: center;
            padding: 24px;
            background: rgba(2, 6, 12, 0.84);
            backdrop-filter: blur(10px);
            z-index: 1500;
        }

        .image-modal.show {
            display: flex;
        }

        .image-modal-content {
            position: relative;
            width: min(960px, 100%);
            max-height: 90vh;
            background: rgba(14, 19, 26, 0.96);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 28px;
            padding: 22px;
            box-shadow: 0 24px 60px rgba(0, 0, 0, 0.45);
        }

        .image-modal-close {
            position: absolute;
            top: 14px;
            right: 14px;
            width: 42px;
            height: 42px;
            border: none;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.08);
            color: #ffffff;
            font-size: 1.1rem;
            cursor: pointer;
        }

        .image-modal-close:hover {
            background: rgba(255, 255, 255, 0.16);
        }

        .image-preview {
            width: 100%;
            max-height: 68vh;
            object-fit: contain;
            display: block;
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.03);
        }

        .image-caption {
            padding-top: 16px;
        }

        .image-caption h4 {
            color: #ffffff;
            font-size: 1.15rem;
            margin-bottom: 8px;
        }

        .image-caption p {
            color: var(--muted);
            line-height: 1.7;
        }

        @media (max-width: 980px) {
            body { padding: 16px; }
            .hero { grid-template-columns: 1fr; }
            .hero-copy,
            .section-card { padding: 24px; }
            .hero-stats,
            .gallery-grid { grid-template-columns: 1fr; }
            .topbar { align-items: flex-start; flex-direction: column; }
            .creator-card { grid-template-columns: 1fr; text-align: center; }
            .creator-photo { margin: 0 auto; }
        }

        /* ── Light mode overrides ── */
        body:not(.dark-mode) {
            --bg-image: url('wbg.jpg');
            --page-text: #1a2a3a;
            --surface: rgba(255, 255, 255, 0.92);
            --surface-strong: #ffffff;
            --surface-soft: rgba(240, 245, 255, 0.9);
            --border: rgba(26, 58, 92, 0.12);
            --primary: #1a3a5c;
            --primary-2: #2c5a7a;
            --accent: #d97706;
            --muted: #6b7c8f;
            --shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
            background: linear-gradient(rgba(255,255,255,0.3), rgba(255,255,255,0.3)), var(--bg-image) center/cover fixed no-repeat;
            color: var(--page-text);
        }
        body:not(.dark-mode) h1,
        body:not(.dark-mode) .section-heading h3,
        body:not(.dark-mode) .mission-item h4,
        body:not(.dark-mode) .gallery-copy h4,
        body:not(.dark-mode) .creator-info h4,
        body:not(.dark-mode) .stat strong,
        body:not(.dark-mode) .image-caption h4 { color: var(--primary); }
        body:not(.dark-mode) .brand { color: var(--primary); }
        body:not(.dark-mode) .eyebrow { color: var(--accent); }
        body:not(.dark-mode) .creator-role { color: var(--accent); }
        
        /* Dark mode home button */
        body.dark-mode .action-link {
            background: linear-gradient(135deg, #818cf8, #6366f1);
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
                    <a class="action-link" href="<%= BackUrl %>" title="Back to Portal">
                        <i class="fas fa-home" style="font-size:18px;"></i>
                    </a>
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

                <div class="hero-visual"></div>
            </section>

            <section class="section-card">
                <div class="section-heading">
                    <i class="fas fa-image"></i>
                    <h3>Campus Gallery</h3>
                </div>

                <div class="gallery-grid">
                    <article class="gallery-card" onclick="openImageModal('Students activities.jpg', 'Student Activities', 'Celebrating student life through meaningful activities, shared experiences, and campus program highlights.')">
                        <img src="Students activities.jpg" alt="Campus event announcement" />
                        <div class="gallery-copy">
                            <h4>Student Activities</h4>
                           
                        </div>
                    </article>

                    <article class="gallery-card" onclick="openImageModal('Academic Updates.jpg', 'Academic Updates', 'A space for exam schedules, department notices, and registrar reminders that keep students informed.')">
                        <img src="Academic Updates.jpg" alt="Academic announcement board" />
                        <div class="gallery-copy">
                            <h4>Academic Updates</h4>
                           
                        </div>
                    </article>

                    <article class="gallery-card" onclick="openImageModal('School Campus View.jpg', 'Campus Highlights', 'Showcasing the campus environment, learning spaces, and facilities that shape student identity.')">
                        <img src="School Campus View.jpg" alt="School campus view" />
                        <div class="gallery-copy">
                            <h4>Campus Highlights</h4>
                           
                        </div>
                    </article>

                    <article class="gallery-card" onclick="openImageModal('School Announcent Campaign.jpg', 'Official Campaigns', 'Featuring school campaigns, bulletin reminders, awareness drives, and official event promotions.')">
                        <img src="School Announcent Campaign.jpg" alt="School announcement campaign" />
                        <div class="gallery-copy">
                            <h4>Official Campaigns</h4>
                           
                        </div>
                    </article>
                </div>
            </section>

         

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
                    <article class="creator-card" onclick="openImageModal('Amay Riza Ann.jpg', 'Amay Riza Ann', 'Creator - We built this platform to make every important school update easier to reach, understand, and trust.')">
                        <div class="creator-photo">
                            <img src="Amay Riza Ann.jpg" alt="Amay Riza Ann" />
                        </div>
                        <div class="creator-info">
                            <h4>Amay Riza Ann</h4>
                            <div class="creator-role">Creator</div>
                            <div class="creator-quote">"We built this platform to make every important school update easier to reach, understand, and trust."</div>
                        </div>
                    </article>

                    <article class="creator-card" onclick="openImageModal('Quevedo Mary Chris.jpg', 'Quevedo Mary Chris', 'Creator - Good communication creates a stronger campus community, and this portal was designed to support that every day.')">
                        <div class="creator-photo">
                            <img src="Quevedo Mary Chris.jpg" alt="Quevedo Mary Chris" />
                        </div>
                        <div class="creator-info">
                            <h4>Quevedo Mary Chris</h4>
                            <div class="creator-role">Creator</div>
                            <div class="creator-quote">"Good communication creates a stronger campus community, and this portal was designed to support that every day."</div>
                        </div>
                    </article>

                    <article class="creator-card" onclick="openImageModal('Zamora Shaira Jane.jpg', 'Zamora Shaira Jane', 'Creator - Our vision was to create a space where announcements feel clear, official, and always within reach.')">
                        <div class="creator-photo">
                            <img src="Zamora Shaira Jane.jpg" alt="Zamora Shaira Jane" />
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

    <div id="imageModal" class="image-modal" onclick="closeImageModal(event)">
        <div class="image-modal-content">
            <button type="button" class="image-modal-close" onclick="closeImageModal()">
                <i class="fas fa-times"></i>
            </button>
            <img id="imageModalPreview" class="image-preview" src="about:blank" alt="Gallery preview" />
            <div class="image-caption">
                <h4 id="imageModalTitle"></h4>
                <p id="imageModalText"></p>
            </div>
        </div>
    </div>

    <script>
        // ── Theme sync ────────────────────────────────────────
        (function() {
            var isDark = localStorage.getItem('campus_theme') === 'dark';
            document.body.classList.toggle('dark-mode', isDark);
            window.addEventListener('storage', function(e) {
                if (e.key === 'campus_theme') {
                    document.body.classList.toggle('dark-mode', e.newValue === 'dark');
                }
            });
        })();

        function openImageModal(src, title, text) {
            var modal    = document.getElementById('imageModal');
            var preview  = document.getElementById('imageModalPreview');
            var titleEl  = document.getElementById('imageModalTitle');
            var textEl   = document.getElementById('imageModalText');
            if (!modal) return;
            preview.src        = src;
            preview.alt        = title;
            titleEl.textContent = title;
            textEl.textContent  = text;
            modal.classList.add('show');
            document.body.style.overflow = 'hidden';
        }

        function closeImageModal(event) {
            var modal = document.getElementById('imageModal');
            if (!modal) return;
            // close when clicking the backdrop or the close button (no event = button click)
            if (event && event.target !== modal) return;
            modal.classList.remove('show');
            document.body.style.overflow = '';
        }

        // close button click (no event argument)
        document.getElementById('imageModal')
            .querySelector('.image-modal-close')
            .addEventListener('click', function() {
                var modal = document.getElementById('imageModal');
                modal.classList.remove('show');
                document.body.style.overflow = '';
            });

        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                var modal = document.getElementById('imageModal');
                if (modal) { modal.classList.remove('show'); document.body.style.overflow = ''; }
            }
        });
    </script>
</body>
</html>
