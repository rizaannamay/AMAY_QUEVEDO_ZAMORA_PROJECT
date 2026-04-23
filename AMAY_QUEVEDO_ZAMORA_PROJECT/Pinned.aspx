<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pinned.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Pinned" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Pinned Announcements</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-image: url('bg.jpg'); /* This matches your Student.aspx */
            background-size: cover;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .main-container {
            padding: 50px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .card {
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            padding: 20px;
            width: 80%;
            margin-bottom: 20px;
            color: white;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="main-container">
            <h1 style="color: white;"><i class="fas fa-thumbtack"></i> Pinned Announcements</h1>
            
            <div class="card">
                <h3>Final Exam Schedule</h3>
                <p>Status: Pinned</p>
                <p>All examinations will be held on December 15-20, 2024.</p>
            </div>
        </div>
    </form>
</body>
</html>