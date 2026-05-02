<%@ Page Language="C#" AutoEventWireup="false" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Campus Announcement</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        html, body {
            width: 100%;
            height: 100%;
            background: #1c1f26;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .splash-wrap {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 28px;
            opacity: 0;
            animation: fadeIn 0.7s ease 0.15s forwards;
        }

        /* Logo — no background circle, just the real CTU logo big and centered */
        .logo-img {
            width: 160px;
            height: 160px;
            object-fit: contain;
            /* subtle glow ring around the logo */
            filter: drop-shadow(0 0 18px rgba(0, 188, 212, 0.55))
                    drop-shadow(0 0 40px rgba(0, 188, 212, 0.25));
            animation: logoPulse 2s ease-in-out infinite;
        }

        /* App name */
        .app-name {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 16px;
            font-weight: 700;
            color: rgba(255, 255, 255, 0.6);
            letter-spacing: 3px;
            text-transform: uppercase;
            text-align: center;
        }

        .app-sub {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 12px;
            color: rgba(255, 255, 255, 0.35);
            letter-spacing: 1.5px;
            text-align: center;
            margin-top: -18px;
        }

        /* Fade-out applied by JS */
        .splash-wrap.fade-out {
            animation: fadeOut 0.5s ease forwards;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.82); }
            to   { opacity: 1; transform: scale(1); }
        }

        @keyframes fadeOut {
            from { opacity: 1; transform: scale(1); }
            to   { opacity: 0; transform: scale(1.08); }
        }

        /* Gentle breathing glow on the logo */
        @keyframes logoPulse {
            0%   { filter: drop-shadow(0 0 14px rgba(0,188,212,0.45)) drop-shadow(0 0 36px rgba(0,188,212,0.2)); }
            50%  { filter: drop-shadow(0 0 28px rgba(0,188,212,0.75)) drop-shadow(0 0 60px rgba(0,188,212,0.35)); }
            100% { filter: drop-shadow(0 0 14px rgba(0,188,212,0.45)) drop-shadow(0 0 36px rgba(0,188,212,0.2)); }
        }
    </style>
</head>
<body>
    <div class="splash-wrap" id="splashWrap">
        <img src="ctu-logo.png" alt="CTU Logo" class="logo-img" />
        <div class="app-name">Campus Announcement</div>
        <div class="app-sub">Cebu Technological University</div>
    </div>

    <script>
        (function () {
            function getParam(name) {
                var m = new RegExp('[?&]' + name + '=([^&]*)').exec(window.location.search);
                return m ? decodeURIComponent(m[1]) : null;
            }

            var dest = getParam('dest');
            var target = dest === 'Teacher' ? 'Teacher.aspx'
                       : dest === 'Student' ? 'Student.aspx'
                       : 'login.aspx?from=splash';

            // Show for 2.5 s, fade out, then navigate
            setTimeout(function () {
                var wrap = document.getElementById('splashWrap');
                if (wrap) wrap.classList.add('fade-out');
                setTimeout(function () {
                    window.location.replace(target);
                }, 520);
            }, 2500);
        })();
    </script>
</body>
</html>
