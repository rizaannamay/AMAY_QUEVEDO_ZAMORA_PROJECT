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

        /* ══════════════════════════════════════════
           LIGHT MODE (default)
        ══════════════════════════════════════════ */
        :root {
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
        }

        body {
            min-height: 100vh;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            color: var(--page-text);
            background:
                linear-gradient(rgba(255,255,255,0.3), rgba(255,255,255,0.3)),
                var(--bg-image) center/cover fixed no-repeat;
            padding: 28px;
            transition: background 0.4s ease, color 0.4s ease;
        }

        a { color: inherit; text-decoration: none; }

        /* ══════════════════════════════════════════
           DARK MODE — matches Notifications.aspx
           navy #0a0f1e base + indigo/blue accents
           + subtle wave atmosphere
        ══════════════════════════════════════════ */
        body.dark-mode {
            --page-text: #e4e6eb;
            --surface: rgba(10, 18, 45, 0.78);
            --surface-strong: rgba(8, 14, 36, 0.92);
            --surface-soft: rgba(255, 255, 255, 0.05);
            --border: rgba(99, 102, 241, 0.18);
            --primary: #93c5fd;
            --primary-2: #6366f1;
            --accent: #f59e0b;
            --muted: #94a3b8;
            --shadow: 0 12px 40px rgba(0, 0, 0, 0.55);

            background-color: #0a0f1e;
            background-image:
                radial-gradient(ellipse at 15% 40%, rgba(30, 58, 138, 0.22) 0%, transparent 55%),
                radial-gradient(ellipse at 85% 15%, rgba(99, 102, 241, 0.10) 0%, transparent 50%),
                radial-gradient(ellipse at 60% 85%, rgba(14, 30, 80, 0.30) 0%, transparent 45%);
            background-attachment: fixed;
        }

        /* Wave SVG — only visible in dark mode */
        #waveBg {
            display: none;
            position: fixed;
            bottom: 0; left: 0;
            width: 100%; height: 60%;
            pointer-events: none;
            z-index: 0;
            opacity: 0.2;
        }
        body.dark-mode #waveBg { display: block; }

        /* ── PAGE SHELL ── */
        .page-shell {
            max-width: 1240px;
            margin: 0 auto;
            display: grid;
            gap: 22px;
            position: relative;
            z-index: 1;
        }

        /* ── SHARED CARD STYLE ── */
        .topbar,
        .hero,
        .section-card {
            background: var(--surface);
            backdrop-filter: blur(18px);
            -webkit-backdrop-filter: blur(18px);
            border: 1px solid var(--border);
            border-radius: 28px;
            box-shadow: var(--shadow);
            transition: background 0.4s ease, border-color 0.4s ease, box-shadow 0.4s ease;
        }

        /* dark mode card hover glow */
        body.dark-mode .section-card:hover,
        body.dark-mode .topbar:hover {
            border-color: rgba(99, 102, 241, 0.32);
            box-shadow: 0 16px 48px rgba(0, 0, 0, 0.6), 0 0 0 1px rgba(99,102,241,0.15);
        }

        /* ── TOPBAR ── */
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
            color: var(--primary);
        }

        .brand-badge {
            width: 54px; height: 54px;
            border-radius: 18px;
            display: flex; align-items: center; justify-content: center;
            background: linear-gradient(135deg, #1e3a8a, #6366f1);
            color: #ffffff;
            font-size: 24px;
            box-shadow: 0 4px 16px rgba(99,102,241,0.35);
        }

        body:not(.dark-mode) .brand-badge {
            background: linear-gradient(135deg, #1a3a5c, #2563eb);
            color: #ffffff;
        }

        .brand-sub {
            font-size: 13px;
            color: var(--muted);
            font-weight: 500;
        }

        .top-actions { display: flex; gap: 12px; flex-wrap: wrap; }

        .action-link {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 44px; height: 44px;
            border-radius: 50%;
            background: linear-gradient(135deg, #1e3a8a, #6366f1);
            color: #ffffff;
            border: none;
            box-shadow: 0 4px 16px rgba(99,102,241,0.35);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        body:not(.dark-mode) .action-link {
            background: linear-gradient(135deg, #1a3a5c, #2563eb);
            box-shadow: 0 4px 16px rgba(37,99,235,0.3);
        }

        .action-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(99,102,241,0.5);
        }

        /* ── HERO ── */
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
            color: var(--primary);
        }

        body.dark-mode h1 { color: #ffffff; }

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
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 18px;
            transition: background 0.3s, border-color 0.3s;
        }

        body.dark-mode .stat {
            background: rgba(99, 102, 241, 0.08);
            border-color: rgba(99, 102, 241, 0.2);
        }

        .stat:hover {
            border-color: rgba(99, 102, 241, 0.4);
        }

        .stat strong {
            display: block;
            font-size: 1.5rem;
            color: var(--primary);
            margin-bottom: 6px;
        }

        body.dark-mode .stat strong { color: #93c5fd; }

        .stat span {
            color: var(--muted);
            font-size: 0.95rem;
        }

        .hero-visual {
            min-height: 100%;
            background:
                linear-gradient(rgba(10, 18, 45, 0.25), rgba(10, 18, 45, 0.65)),
                url('School Campus View.jpg') center/cover no-repeat;
        }

        /* ── SECTION CARD ── */
        .section-card { padding: 28px; }

        .section-heading {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 18px;
        }

        .section-heading i {
            width: 42px; height: 42px;
            display: flex; align-items: center; justify-content: center;
            border-radius: 14px;
            color: #ffffff;
            background: linear-gradient(135deg, #1e3a8a, #6366f1);
            box-shadow: 0 4px 12px rgba(99,102,241,0.3);
        }

        body:not(.dark-mode) .section-heading i {
            background: linear-gradient(135deg, #1a3a5c, #2563eb);
        }

        .section-heading h3 {
            color: var(--primary);
            font-size: 1.35rem;
        }

        body.dark-mode .section-heading h3 { color: #e2e8f0; }

        /* ── MISSION LIST ── */
        .mission-list { display: grid; gap: 14px; }

        .mission-item {
            padding: 18px;
            border-radius: 18px;
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid var(--border);
            transition: background 0.3s, border-color 0.3s, transform 0.25s;
        }

        body.dark-mode .mission-item {
            background: rgba(99, 102, 241, 0.06);
            border-color: rgba(99, 102, 241, 0.15);
        }

        .mission-item:hover {
            transform: translateY(-2px);
            border-color: rgba(99, 102, 241, 0.35);
        }

        .mission-item h4 {
            font-size: 1.05rem;
            margin-bottom: 8px;
            color: var(--primary);
        }

        body.dark-mode .mission-item h4 { color: #93c5fd; }

        .mission-item p {
            color: var(--muted);
            line-height: 1.7;
        }

        /* ── GALLERY ── */
        .gallery-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 16px;
        }

        .gallery-card {
            overflow: hidden;
            border-radius: 22px;
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid var(--border);
            cursor: pointer;
            transition: transform 0.25s ease, box-shadow 0.25s ease, border-color 0.25s ease;
        }

        body.dark-mode .gallery-card {
            background: rgba(10, 18, 45, 0.7);
            border-color: rgba(59, 130, 246, 0.2);
        }

        .gallery-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 16px 32px rgba(0, 0, 0, 0.3);
            border-color: rgba(99, 102, 241, 0.45);
        }

        body.dark-mode .gallery-card:hover {
            box-shadow: 0 16px 40px rgba(0, 0, 0, 0.55), 0 0 0 1px rgba(99,102,241,0.25);
        }

        .gallery-card img {
            width: 100%;
            height: 220px;
            object-fit: cover;
            display: block;
        }

        .gallery-copy { padding: 16px 18px 18px; }

        .gallery-copy h4 {
            color: var(--primary);
            margin-bottom: 8px;
            font-size: 1rem;
        }

        body.dark-mode .gallery-copy h4 { color: #93c5fd; }

        .gallery-copy p {
            color: var(--muted);
            line-height: 1.6;
            font-size: 0.94rem;
        }

        /* ── CREATORS ── */
        .creators-section { display: grid; gap: 18px; }

        .creators-intro {
            color: var(--muted);
            line-height: 1.7;
            font-size: 0.98rem;
            max-width: 760px;
        }

        .creators-grid { display: grid; gap: 18px; }

        .creator-card {
            display: grid;
            grid-template-columns: 120px 1fr;
            align-items: center;
            gap: 22px;
            padding: 22px;
            border-radius: 24px;
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid var(--border);
            cursor: pointer;
            transition: transform 0.25s ease, box-shadow 0.25s ease, border-color 0.25s ease;
        }

        body.dark-mode .creator-card {
            background: rgba(10, 18, 45, 0.7);
            border-color: rgba(59, 130, 246, 0.2);
        }

        .creator-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 16px 32px rgba(0, 0, 0, 0.25);
            border-color: rgba(99, 102, 241, 0.4);
        }

        body.dark-mode .creator-card:hover {
            box-shadow: 0 16px 40px rgba(0, 0, 0, 0.55), 0 0 0 1px rgba(99,102,241,0.28);
        }

        .creator-photo {
            width: 120px; height: 120px;
            border-radius: 50%;
            overflow: hidden;
            border: 3px solid rgba(99, 102, 241, 0.35);
            background: linear-gradient(135deg, rgba(99,102,241,0.25), rgba(59,130,246,0.2));
            display: flex; align-items: center; justify-content: center;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.25);
            transition: border-color 0.3s;
        }

        body.dark-mode .creator-photo {
            border-color: rgba(147, 197, 253, 0.3);
            box-shadow: 0 8px 24px rgba(0,0,0,0.4), 0 0 0 1px rgba(99,102,241,0.15);
        }

        .creator-card:hover .creator-photo {
            border-color: rgba(99, 102, 241, 0.6);
        }

        .creator-photo img {
            width: 100%; height: 100%;
            object-fit: cover;
            display: block;
        }

        .creator-photo i { font-size: 2.2rem; color: #ffffff; }

        .creator-info h4 {
            color: var(--primary);
            font-size: 1.2rem;
            margin-bottom: 8px;
        }

        body.dark-mode .creator-info h4 { color: #e2e8f0; }

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

        /* ── IMAGE MODAL ── */
        .image-modal {
            position: fixed;
            inset: 0;
            display: none;
            align-items: center;
            justify-content: center;
            padding: 24px;
            background: rgba(2, 6, 12, 0.84);
            backdrop-filter: blur(12px);
            z-index: 1500;
        }

        .image-modal.show { display: flex; }

        .image-modal-content {
            position: relative;
            width: min(960px, 100%);
            max-height: 90vh;
            background: rgba(8, 14, 36, 0.97);
            border: 1px solid rgba(99, 102, 241, 0.25);
            border-radius: 28px;
            padding: 22px;
            box-shadow: 0 24px 60px rgba(0, 0, 0, 0.6), 0 0 0 1px rgba(99,102,241,0.1);
        }

        body:not(.dark-mode) .image-modal-content {
            background: rgba(255, 255, 255, 0.97);
            border-color: rgba(26, 58, 92, 0.15);
        }

        .image-modal-close {
            position: absolute;
            top: 14px; right: 14px;
            width: 42px; height: 42px;
            border: none;
            border-radius: 50%;
            background: rgba(99, 102, 241, 0.15);
            border: 1px solid rgba(99, 102, 241, 0.25);
            color: #ffffff;
            font-size: 1.1rem;
            cursor: pointer;
            transition: background 0.2s;
        }

        .image-modal-close:hover { background: rgba(99, 102, 241, 0.3); }

        body:not(.dark-mode) .image-modal-close {
            background: rgba(0,0,0,0.08);
            border-color: rgba(0,0,0,0.1);
            color: #1a2a3a;
        }

        .image-preview {
            width: 100%;
            max-height: 68vh;
            object-fit: contain;
            display: block;
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.03);
        }

        .image-caption { padding-top: 16px; }

        .image-caption h4 {
            color: #93c5fd;
            font-size: 1.15rem;
            margin-bottom: 8px;
        }

        body:not(.dark-mode) .image-caption h4 { color: var(--primary); }

        .image-caption p { color: var(--muted); line-height: 1.7; }

        /* ── TRANSITIONS ── */
        *, *::before, *::after {
            transition: background-color 0.3s ease, border-color 0.3s ease,
                        color 0.3s ease, box-shadow 0.3s ease;
        }

        /* ── RESPONSIVE ── */
        @media (max-width: 980px) {
            body { padding: 16px; }
            .hero { grid-template-columns: 1fr; }
            .hero-copy, .section-card { padding: 24px; }
            .hero-stats, .gallery-grid { grid-template-columns: 1fr; }
            .topbar { align-items: flex-start; flex-direction: column; }
            .creator-card { grid-template-columns: 1fr; text-align: center; }
            .creator-photo { margin: 0 auto; }
        }
    </style>
</head>
<body>

    <!-- Wave SVG — visible in dark mode only -->
    <svg id="waveBg" viewBox="0 0 1440 500" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M0,280 C200,200 400,360 600,260 C800,160 1000,320 1200,240 C1320,200 1400,260 1440,280"
              fill="none" stroke="#3b82f6" stroke-width="1.5"/>
        <path d="M0,320 C240,240 480,380 720,300 C900,240 1100,360 1300,280 C1380,250 1420,300 1440,320"
              fill="none" stroke="#6366f1" stroke-width="1.2"/>
        <path d="M0,360 C180,300 360,400 540,340 C720,280 900,380 1080,320 C1260,260 1380,340 1440,360"
              fill="none" stroke="#818cf8" stroke-width="0.9"/>
        <path d="M0,240 C300,160 600,320 900,200 C1080,140 1260,260 1440,220"
              fill="none" stroke="#2563eb" stroke-width="1"/>
        <path d="M0,400 C360,340 720,420 1080,360 C1260,330 1380,390 1440,400"
              fill="none" stroke="#4f46e5" stroke-width="0.7"/>
    </svg>

    <form id="form1" runat="server">
        <div class="page-shell">

            <!-- ═══ TOPBAR ═══ -->
            <div class="topbar">
                <div class="brand">
                    <div class="brand-badge">
                        <i class="fas fa-university"></i>
                    </div>
                    <div>
                        <div>Campus Connect</div>
                        <div class="brand-sub">Cebu Technological University Announcement Portal</div>
                    </div>
                </div>
                <div class="top-actions">
                    <a class="action-link" href="<%= BackUrl %>" title="Back to Portal">
                        <i class="fas fa-home" style="font-size:18px;"></i>
                    </a>
                </div>
            </div>

            <!-- ═══ HERO ═══ -->
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

            <!-- ═══ GALLERY ═══ -->
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

            <!-- ═══ CREATORS ═══ -->
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
                    <article class="creator-card" onclick="openImageModal('Amay Riza Ann.jpg', 'Amay Riza Ann', 'Creator — We built this platform to make every important school update easier to reach, understand, and trust.')">
                        <div class="creator-photo">
                            <img src="Amay Riza Ann.jpg" alt="Amay Riza Ann" />
                        </div>
                        <div class="creator-info">
                            <h4>Amay Riza Ann</h4>
                            <div class="creator-role">Creator</div>
                            <div class="creator-quote">"We built this platform to make every important school update easier to reach, understand, and trust."</div>
                        </div>
                    </article>
                    <article class="creator-card" onclick="openImageModal('Quevedo Mary Chris.jpg', 'Quevedo Mary Chris', 'Creator — Good communication creates a stronger campus community, and this portal was designed to support that every day.')">
                        <div class="creator-photo">
                            <img src="Quevedo Mary Chris.jpg" alt="Quevedo Mary Chris" />
                        </div>
                        <div class="creator-info">
                            <h4>Quevedo Mary Chris</h4>
                            <div class="creator-role">Creator</div>
                            <div class="creator-quote">"Good communication creates a stronger campus community, and this portal was designed to support that every day."</div>
                        </div>
                    </article>
                    <article class="creator-card" onclick="openImageModal('Zamora Shaira Jane.jpg', 'Zamora Shaira Jane', 'Creator — Our vision was to create a space where announcements feel clear, official, and always within reach.')">
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

        </div><!-- /page-shell -->
    </form>

    <!-- ═══ IMAGE MODAL ═══ -->
    <div id="imageModal" class="image-modal" onclick="closeImageModal(event)">
        <div class="image-modal-content">
            <button type="button" class="image-modal-close" onclick="closeModalDirect()">
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
        // ── Theme sync — reads campus_theme set by other pages ──
        (function () {
            function applyTheme(val) {
                document.body.classList.toggle('dark-mode', val === 'dark');
            }
            applyTheme(localStorage.getItem('campus_theme') || 'light');
            window.addEventListener('storage', function (e) {
                if (e.key === 'campus_theme') applyTheme(e.newValue || 'light');
            });
        })();

        // ── Image modal ──
        function openImageModal(src, title, text) {
            document.getElementById('imageModalPreview').src = src;
            document.getElementById('imageModalPreview').alt = title;
            document.getElementById('imageModalTitle').textContent = title;
            document.getElementById('imageModalText').textContent = text;
            document.getElementById('imageModal').classList.add('show');
            document.body.style.overflow = 'hidden';
        }

        function closeImageModal(event) {
            if (event && event.target !== document.getElementById('imageModal')) return;
            _closeModal();
        }

        function closeModalDirect() { _closeModal(); }

        function _closeModal() {
            document.getElementById('imageModal').classList.remove('show');
            document.body.style.overflow = '';
        }

        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') _closeModal();
        });
    </script>
</body>
</html>
