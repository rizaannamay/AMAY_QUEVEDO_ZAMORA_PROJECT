<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Notifications.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Student" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Campus Connect - Notifications</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #e8f0fe 0%, #d4e0f0 100%);
            margin: 0;
            padding: 40px;
            display: flex;
            justify-content: center;
        }

        .container {
            width: 100%;
            max-width: 800px;
            background: white;
            border-radius: 24px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            overflow: hidden;
            border: 1px solid rgba(26,58,92,0.1);
        }

        .header {
            padding: 25px 30px;
            background: linear-gradient(135deg, #1a3a5c, #2c5a7a);
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h2 { margin: 0; font-size: 20px; }
        
        .back-link {
            color: white;
            text-decoration: none;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 8px;
            opacity: 0.9;
        }

        .notification-list { padding: 10px 0; }

        .notification-item {
            display: flex;
            padding: 20px 30px;
            border-bottom: 1px solid #f0f2f5;
            transition: background 0.3s;
            cursor: pointer;
            align-items: flex-start;
            gap: 15px;
        }

        .notification-item:hover { background: #f8fafc; }
        .notification-item.unread { background: #f0f7ff; }

        .icon-box {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .icon-blue { background: #e0e7ff; color: #4338ca; }
        .icon-red { background: #fee2e2; color: #dc2626; }
        .icon-green { background: #dcfce7; color: #15803d; }

        .content { flex: 1; }
        .title { font-weight: 600; color: #1a3a5c; font-size: 15px; margin-bottom: 4px; }
        .message { color: #5a6e7c; font-size: 14px; line-height: 1.4; }
        .time { font-size: 12px; color: #b0c4de; margin-top: 8px; }

        .unread-dot {
            width: 10px;
            height: 10px;
            background: #dc2626;
            border-radius: 50%;
            align-self: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="header">
                <h2><i class="fas fa-bell"></i> Notifications</h2>
                <a href="Student.aspx" class="back-link"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
            </div>

            <div class="notification-list">
                <div class="notification-item unread">
                    <div class="icon-box icon-blue">
                        <i class="fas fa-file-alt"></i>
                    </div>
                    <div class="content">
                        <div class="title">New Exam Schedule Posted</div>
                        <div class="message">The Midterm Examination schedule for 1st Semester is now available for viewing.</div>
                        <div class="time">2 hours ago</div>
                    </div>
                    <div class="unread-dot"></div>
                </div>

                <div class="notification-item unread">
                    <div class="icon-box icon-red">
                        <i class="fas fa-cloud-showers-heavy"></i>
                    </div>
                    <div class="content">
                        <div class="title">Emergency Suspension</div>
                        <div class="message">Classes are suspended today starting 1:00 PM due to the incoming typhoon. Stay safe!</div>
                        <div class="time">1 day ago</div>
                    </div>
                    <div class="unread-dot"></div>
                </div>

                <div class="notification-item">
                    <div class="icon-box icon-green">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="content">
                        <div class="title">Foundation Week Kickoff</div>
                        <div class="message">Join us at the Main Field for the opening ceremony of our 50th Foundation Anniversary.</div>
                        <div class="time">3 days ago</div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>