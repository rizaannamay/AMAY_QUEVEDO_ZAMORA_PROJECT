<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Notifications.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Notifications" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Notifications</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --bg-image: url('wbg.jpg');
            --page-text: #000000;
            --surface: rgba(255, 255, 255, 0.92);
            --surface-soft: rgba(255, 255, 255, 0.96);
            --border: rgba(26, 58, 92, 0.12);
            --primary: #000000;
            --muted: #000000;
            --shadow: 0 14px 34px rgba(0, 0, 0, 0.12);
        }

        body {
            min-height: 100vh;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            color: var(--page-text);
            background-image: linear-gradient(rgba(255, 255, 255, 0.16), rgba(255, 255, 255, 0.16)), var(--bg-image);
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            background-attachment: fixed;
        }

        a {
            color: inherit;
            text-decoration: none;
        }

        .page-shell {
            min-height: 100vh;
            padding: 48px 32px 32px;
        }

        .page-wrap {
            max-width: 1400px;
            margin: 0 auto;
        }

        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            margin-bottom: 26px;
        }

        .page-title {
            display: flex;
            align-items: center;
            gap: 16px;
            font-size: 34px;
            font-weight: 800;
            color: #000000;
        }

        .page-title i {
            color: #000000;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 12px 18px;
            border-radius: 999px;
            background: var(--surface);
            color: var(--primary);
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            font-weight: 600;
        }

        .notifications-card {
            background: var(--surface);
            backdrop-filter: blur(12px);
            border-radius: 28px;
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        .notification-item {
            display: flex;
            align-items: center;
            gap: 20px;
            padding: 30px 36px;
            border-bottom: 1px solid rgba(26, 58, 92, 0.08);
            background: var(--surface-soft);
        }

        .notification-item:last-child {
            border-bottom: none;
        }

        .notification-icon {
            width: 64px;
            height: 64px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            flex-shrink: 0;
        }

        .icon-exam {
            background: #dbe7ff;
            color: #3b5bcc;
        }

        .icon-suspension {
            background: #ffe1e1;
            color: #dc2626;
        }

        .icon-event {
            background: #dcfce7;
            color: #15803d;
        }

        .notification-content {
            flex: 1;
            min-width: 0;
        }

        .notification-title {
            font-size: 18px;
            font-weight: 800;
            color: #000000;
            margin-bottom: 8px;
        }

        .notification-text {
            font-size: 16px;
            line-height: 1.6;
            color: #000000;
        }

        .notification-time {
            display: block;
            margin-top: 10px;
            font-size: 13px;
            color: #000000;
        }

        .notification-dot {
            width: 15px;
            height: 15px;
            border-radius: 50%;
            background: #dc2626;
            flex-shrink: 0;
        }

        .dark-mode {
            --bg-image: url('bg.jpg');
            --page-text: #ffffff;
            --surface: rgba(33, 38, 45, 0.9);
            --surface-soft: rgba(39, 44, 52, 0.96);
            --border: rgba(255, 255, 255, 0.08);
            --primary: #ffffff;
            --muted: #c4cfdb;
            --shadow: 0 14px 34px rgba(0, 0, 0, 0.28);
        }

        body.dark-mode {
            background-image: linear-gradient(rgba(18, 22, 28, 0.42), rgba(18, 22, 28, 0.42)), var(--bg-image);
        }

        .dark-mode .page-title,
        .dark-mode .page-title i,
        .dark-mode .back-link,
        .dark-mode .notification-title,
        .dark-mode .notification-text,
        .dark-mode .notification-time {
            color: #ffffff;
        }

        @media (max-width: 768px) {
            .page-shell {
                padding: 24px 16px;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .page-title {
                font-size: 28px;
            }

            .notification-item {
                padding: 22px 18px;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-shell">
            <div class="page-wrap">
                <div class="page-header">
                    <div class="page-title">
                        <i class="fas fa-bell"></i>
                        <span>Notifications</span>
                    </div>
                    <a class="back-link" href="Student.aspx">
                        <i class="fas fa-arrow-left"></i>
                        <span>Back to Student Portal</span>
                    </a>
                </div>

                <div class="notifications-card">
                    <div class="notification-item">
                        <div class="notification-icon icon-exam">
                            <i class="fas fa-file-alt"></i>
                        </div>
                        <div class="notification-content">
                            <div class="notification-title">New Exam Schedule Posted</div>
                            <div class="notification-text">The Midterm Examination schedule for 1st Semester is now available for viewing.</div>
                            <span class="notification-time">2 hours ago</span>
                        </div>
                        <div class="notification-dot"></div>
                    </div>

                    <div class="notification-item">
                        <div class="notification-icon icon-suspension">
                            <i class="fas fa-cloud-showers-heavy"></i>
                        </div>
                        <div class="notification-content">
                            <div class="notification-title">Emergency Suspension</div>
                            <div class="notification-text">Classes are suspended today starting 1:00 PM due to the incoming typhoon. Stay safe!</div>
                            <span class="notification-time">1 day ago</span>
                        </div>
                        <div class="notification-dot"></div>
                    </div>

                    <div class="notification-item">
                        <div class="notification-icon icon-event">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="notification-content">
                            <div class="notification-title">Foundation Week Kickoff</div>
                            <div class="notification-text">Join us at the Main Field for the opening ceremony of our 50th Foundation Anniversary.</div>
                            <span class="notification-time">3 days ago</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>
        var THEME_STORAGE_KEY = 'campusTheme';

        function applyStoredTheme() {
            var params = new URLSearchParams(window.location.search);
            var queryTheme = params.get('theme');
            var savedTheme = queryTheme || localStorage.getItem(THEME_STORAGE_KEY);

            if (queryTheme === 'dark' || queryTheme === 'light') {
                localStorage.setItem(THEME_STORAGE_KEY, queryTheme);
            }

            if (savedTheme === 'dark') {
                document.body.classList.add('dark-mode');
            } else {
                document.body.classList.remove('dark-mode');
            }
        }

        window.addEventListener('storage', function (event) {
            if (event.key === THEME_STORAGE_KEY) {
                applyStoredTheme();
            }
        });

        applyStoredTheme();
    </script>
</body>
</html>
