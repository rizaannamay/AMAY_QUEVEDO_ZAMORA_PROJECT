<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pinned.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Pinned" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Pinned Announcements</title>
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
            --surface: rgba(255, 255, 255, 0.9);
            --surface-strong: rgba(255, 255, 255, 0.95);
            --border: rgba(26, 58, 92, 0.14);
            --primary: #000000;
            --primary-2: #2c5a7a;
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
            transition: background 0.3s ease, color 0.3s ease;
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
            max-width: 1460px;
            margin: 0 auto;
        }

        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            color: #000000;
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

        .pinned-list {
            display: grid;
            gap: 24px;
        }

        .pinned-card {
            background: var(--surface);
            backdrop-filter: blur(12px);
            border-radius: 28px;
            border: 1px solid var(--border);
            box-shadow: var(--shadow);
            padding: 28px;
        }

        .card-top {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 18px;
            margin-bottom: 18px;
        }

        .card-author {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .avatar {
            width: 58px;
            height: 58px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, var(--primary), var(--primary-2));
            color: #ffffff;
            font-size: 22px;
        }

        .author-name {
            font-size: 17px;
            font-weight: 700;
            color: var(--primary);
        }

        .meta {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin-top: 6px;
            font-size: 13px;
            color: var(--muted);
        }

        .status-pill {
            display: inline-flex;
            align-items: center;
            padding: 4px 12px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 700;
            background: #fff0db;
            color: #d97706;
        }

        .pin-icon {
            color: #ea580c;
            font-size: 24px;
            padding-top: 6px;
        }

        .card-title {
            font-size: 21px;
            font-weight: 800;
            color: var(--primary);
            margin-bottom: 12px;
        }

        .card-text {
            font-size: 16px;
            line-height: 1.65;
            margin-bottom: 22px;
        }

        .card-image img {
            width: 100%;
            max-height: 420px;
            object-fit: cover;
            display: block;
            border-radius: 24px;
        }

        .empty-state {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 28px;
            padding: 40px 28px;
            text-align: center;
            color: var(--muted);
            box-shadow: var(--shadow);
        }

        .dark-mode {
            --bg-image: url('bg.jpg');
            --page-text: #f2f6fb;
            --surface: rgba(33, 38, 45, 0.9);
            --surface-strong: rgba(39, 44, 52, 0.96);
            --border: rgba(255, 255, 255, 0.08);
            --primary: #ffffff;
            --primary-2: #7fa6d1;
            --muted: #c4cfdb;
            --shadow: 0 14px 34px rgba(0, 0, 0, 0.28);
        }

        body.dark-mode {
            background-image: linear-gradient(rgba(18, 22, 28, 0.42), rgba(18, 22, 28, 0.42)), var(--bg-image);
        }

        .dark-mode .back-link,
        .dark-mode .pinned-card,
        .dark-mode .empty-state {
            color: #ffffff;
        }

        .dark-mode .status-pill {
            background: rgba(234, 88, 12, 0.18);
            color: #ffd3b0;
        }

        .dark-mode .pin-icon {
            color: #ff8a3d;
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

            .pinned-card {
                padding: 20px;
            }

            .card-top {
                flex-direction: column;
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
                        <i class="fas fa-thumbtack"></i>
                        <span>Pinned Announcements</span>
                    </div>
                    <a class="back-link" href="Student.aspx">
                        <i class="fas fa-arrow-left"></i>
                        <span>Back to Student Portal</span>
                    </a>
                </div>

                <div class="pinned-list">
                    <div style="text-align:center;padding:40px;">Loading pinned announcements...</div>
                </div>
            </div>
        </div>
    </form>

    <script>
        var THEME_STORAGE_KEY = 'campus_theme';

function applyStoredTheme() {
    var savedTheme = localStorage.getItem(THEME_STORAGE_KEY);
    if (savedTheme === 'dark') {
        document.body.classList.add('dark-mode');
    } else {
        document.body.classList.remove('dark-mode');
    }
}

window.addEventListener('storage', function(event) {
    if (event.key === THEME_STORAGE_KEY) {
        applyStoredTheme();
    }
});

applyStoredTheme();
    </script>
</body>
</html>