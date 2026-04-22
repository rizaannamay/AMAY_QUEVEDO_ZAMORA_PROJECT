<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Campus Connect - Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

<<<<<<< HEAD
       body {
            background-image: url('bg.jpg');
            background-size: cover;
            transition: background 0.5s ease-in-out;
            background-repeat: no-repeat;
            background-position: center;
        }

        /* Ensure the main container doesn't have a solid color blocking the image */
        .main-content, .announcement-board {
            background: transparent !important;
        }

        /* Glassmorphism effect for your cards so the image peeks through */
        .card, .announcement-card {
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.1);
}

        /* Header */
        .header {
            background: white;
            border-radius: 24px;
            padding: 12px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            border: 1px solid rgba(26,58,92,0.1);
=======
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #e8f0fe 0%, #d4e0f0 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .login-container {
            width: 100%;
            max-width: 440px;
>>>>>>> 5a70aa160eda3870e5d83879f6dcfdb610a51895
        }

        /* Logo */
        .neon-logo {
            text-align: center;
            margin-bottom: 40px;
        }

        .neon-logo img {
            width: 90px;
            height: auto;
            filter: drop-shadow(0 4px 12px rgba(0,100,200,0.2));
        }

        .neon-logo h1 {
            font-size: 32px;
            font-weight: 800;
            background: linear-gradient(135deg, #1a3a5c, #2c5a7a);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-top: 15px;
            letter-spacing: 1px;
        }

        .neon-logo p {
            color: #5a6e7c;
            font-size: 13px;
            margin-top: 6px;
        }

        /* Card */
        .neon-card {
            background: #ffffff;
            border-radius: 24px;
            padding: 45px 40px;
            border: 1px solid rgba(26,58,92,0.1);
            box-shadow: 0 20px 35px rgba(0,0,0,0.05);
        }

        .card-header {
            text-align: center;
            margin-bottom: 35px;
        }

        .card-header h2 {
            color: #1a3a5c;
            font-size: 26px;
            font-weight: 700;
        }

        .card-header span {
            color: #7a8e9e;
            font-size: 14px;
        }

        .input-group {
            margin-bottom: 22px;
        }

        .input-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #2c3e50;
            font-size: 13px;
        }

        .input-field {
            width: 100%;
            padding: 14px 16px;
            background: #f8fafc;
            border: 1px solid #dce4ec;
            border-radius: 12px;
            font-size: 14px;
            color: #1a2a3a;
            transition: all 0.2s;
            box-sizing: border-box;
            font-family: inherit;
        }

        .input-field option {
            background: #ffffff;
            color: #1a2a3a;
        }

        .input-field:focus {
            outline: none;
            border-color: #2c5a7a;
            box-shadow: 0 0 0 3px rgba(44,90,122,0.1);
        }

        .input-field::placeholder {
            color: #b0c4de;
        }

        .btn-login {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #1a3a5c, #2c5a7a);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(26,58,92,0.2);
            background: linear-gradient(135deg, #0f2a40, #1a4a6a);
        }

        #lblError {
            color: #dc2626;
            font-size: 12px;
            display: block;
            margin: 12px 0;
            padding: 10px;
            background: #fef2f2;
            border-radius: 10px;
            text-align: center;
        }

        .footer {
            text-align: center;
            margin-top: 25px;
            font-size: 12px;
            color: #8a9bb0;
        }

        .footer a {
            color: #1a3a5c;
            text-decoration: none;
            font-weight: 600;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        .divider {
            margin: 15px 0 10px;
            font-size: 12px;
            color: #b0c4de;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="neon-logo">
            <img src="ctu-logo.png" alt="CTU Logo" />
            <h1>CAMPUS CONNECT</h1>
            <p>Cebu Technological University</p>
        </div>

        <form id="form1" runat="server">
            <div class="neon-card">
                <div class="card-header">
                    <h2>Log In</h2>
                    <span>Access announcement portal</span>
                </div>

                <div class="input-group">
                    <asp:Label ID="Label1" runat="server" Text="Role"></asp:Label>
                    <asp:DropDownList ID="txtRole" runat="server" CssClass="input-field">
                        <asp:ListItem Text="Student" Value="Student" />
                        <asp:ListItem Text="Admin" Value="Admin" />
                    </asp:DropDownList>
                </div>

                <div class="input-group">
                    <asp:Label ID="Label3" runat="server" Text="Username"></asp:Label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="input-field" placeholder="Enter username"></asp:TextBox>
                </div>

                <div class="input-group">
                    <asp:Label ID="Label4" runat="server" Text="Password"></asp:Label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="input-field" TextMode="Password" placeholder="Enter password"></asp:TextBox>
                </div>

                <asp:Label ID="lblError" runat="server"></asp:Label>

                <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_Click" Text="Log In" CssClass="btn-login" />

                <div class="footer">
                    <div class="divider">────────── OR ──────────</div>
                    <p>Don't have an account? <a href="signin.aspx">Sign Up Here</a></p>
                </div>
            </div>
<<<<<<< HEAD
        </div>

        <!-- Main Layout -->
        <div class="main-layout">
            <!-- LEFT SIDEBAR -->
            <aside>
                <div class="card">
                    <!-- Profile -->
                    <div class="profile-section">
                        <div class="profile-avatar">
                            <i class="fas fa-user-graduate"></i>
                        </div>
                        <div class="profile-name">John Dela Cruz</div>
                        <div class="profile-email">john.delacruz@ctu.edu.ph</div>
                    </div>

                    <!-- Category Dropdown -->
                    <div class="card-header">
                        <i class="fas fa-filter"></i> Filters
                    </div>
                    <div class="menu-item" onclick="toggleDropdown('categoryDropdown')">
                        <i class="fas fa-layer-group"></i> Filter by Category
                        <i class="fas fa-chevron-down dropdown-icon"></i>
                    </div>
                    <div id="categoryDropdown" class="dropdown-content">
                        <button class="dropdown-item" onclick="filterCategory('All')">📋 All Announcements</button>
                        <button class="dropdown-item" onclick="filterCategory('Exam')">📝 Exam Schedule</button>
                        <button class="dropdown-item" onclick="filterCategory('Suspension')">⚠️ Class Suspension</button>
                        <button class="dropdown-item" onclick="filterCategory('Event')">🎉 Campus Events</button>
                    </div>

                    <!-- Pinned Items -->
                    <div class="card-header" style="margin-top: 5px;">
                        <i class="fas fa-thumbtack"></i> Pinned Items
                    </div>
                    <div id="pinnedContainer">
                        <div class="pinned-item">
                            <div><i class="fas fa-thumbtack"></i> Final Exam Schedule</div>
                            <button class="remove-pin" onclick="removePin(this)">✕</button>
                        </div>
                        <div class="pinned-item">
                            <div><i class="fas fa-thumbtack"></i> Class Suspension</div>
                            <button class="remove-pin" onclick="removePin(this)">✕</button>
                        </div>
                    </div>

                    <!-- Settings -->
                    <div class="card-header" style="margin-top: 5px;">
                        <i class="fas fa-cog"></i> Settings
                    </div>
                    
                    <!-- Dark/Light Mode -->
                    <div class="settings-item" onclick="toggleTheme(this)">
                        <i class="fas fa-moon"></i> Dark / Light Mode
                        <div class="toggle-switch" id="themeToggle"></div>
                    </div>
                    
                    <!-- About Us -->
                    <div class="settings-item" onclick="openAboutModal()">
                        <i class="fas fa-info-circle"></i> About Us
                    </div>
                    
                    <!-- Logout -->
                    <div class="settings-item" onclick="logout()">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </div>
                </div>
            </aside>

            <!-- MAIN CONTENT - Announcement Board -->
            <main>
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-bullhorn"></i> Announcement Board
                        <span style="float: right; font-size: 12px; color: #1a3a5c;">Showing: <span id="activeFilterLabel">All</span></span>
                    </div>

                    <!-- Announcements Container -->
                    <div id="announcementsContainer" class="announcement-board">
                        <!-- Announcement 1 - Exam -->
                        <div class="announcement-card" data-category="Exam">
                            <div class="badge-group">
                                <span class="badge badge-exam">Exam</span>
                                <span class="badge badge-pinned"><i class="fas fa-thumbtack"></i> PINNED</span>
                            </div>
                            <div class="announcement-title">Final Exam Schedule</div>
                            <div class="announcement-meta">
                                <span><i class="far fa-calendar-alt"></i> December 15-20, 2024</span>
                                <span><i class="fas fa-user"></i> Admin</span>
                            </div>
                            <div class="announcement-content">
                                The final examinations will be held on December 15-20, 2024. Please check your respective departments for room assignments.
                            </div>
                            <div class="action-buttons">
                                <button class="action-btn" onclick="togglePin(this)"><i class="fas fa-thumbtack"></i> Unpin</button>
                                <button class="action-btn" onclick="toggleComments(this)"><i class="fas fa-comment"></i> Comment (2)</button>
                            </div>
                            <div class="comments-section">
                                <div class="comment-input">
                                    <input type="text" placeholder="Write a comment..." />
                                    <button onclick="addComment(this)">Post</button>
                                </div>
                                <div class="comments-list">
                                    <div class="comment"><span class="comment-author">Juan Dela Cruz:</span> Thank you for the update!</div>
                                    <div class="comment"><span class="comment-author">Maria Santos:</span> What time does the exam start?</div>
                                </div>
                            </div>
                        </div>

                        <!-- Announcement 2 - Suspension -->
                        <div class="announcement-card" data-category="Suspension">
                            <div class="badge-group">
                                <span class="badge badge-suspension">Suspension</span>
                                <span class="badge badge-pinned"><i class="fas fa-thumbtack"></i> PINNED</span>
                            </div>
                            <div class="announcement-title">Class Suspension - Typhoon</div>
                            <div class="announcement-meta">
                                <span><i class="far fa-calendar-alt"></i> November 25, 2024</span>
                                <span><i class="fas fa-user"></i> Admin</span>
                            </div>
                            <div class="announcement-content">
                                Due to Typhoon Enteng, classes in all levels are suspended tomorrow, November 25, 2024.
                            </div>
                            <div class="action-buttons">
                                <button class="action-btn" onclick="togglePin(this)"><i class="fas fa-thumbtack"></i> Unpin</button>
                                <button class="action-btn" onclick="toggleComments(this)"><i class="fas fa-comment"></i> Comment (1)</button>
                            </div>
                            <div class="comments-section">
                                <div class="comment-input">
                                    <input type="text" placeholder="Write a comment..." />
                                    <button onclick="addComment(this)">Post</button>
                                </div>
                                <div class="comments-list">
                                    <div class="comment"><span class="comment-author">John Santos:</span> Stay safe everyone!</div>
                                </div>
                            </div>
                        </div>

                        <!-- Announcement 3 - Event -->
                        <div class="announcement-card" data-category="Event">
                            <div class="badge-group">
                                <span class="badge badge-event">Event</span>
                            </div>
                            <div class="announcement-title">University Foundation Week</div>
                            <div class="announcement-meta">
                                <span><i class="far fa-calendar-alt"></i> December 1-5, 2024</span>
                                <span><i class="fas fa-user"></i> Admin</span>
                            </div>
                            <div class="announcement-content">
                                Join us for the annual University Foundation Week celebration. Activities include parade, talent show, and sportsfest.
                            </div>
                            <div class="action-buttons">
                                <button class="action-btn" onclick="togglePin(this)"><i class="fas fa-thumbtack"></i> Pin</button>
                                <button class="action-btn" onclick="toggleComments(this)"><i class="fas fa-comment"></i> Comment (0)</button>
                            </div>
                            <div class="comments-section">
                                <div class="comment-input">
                                    <input type="text" placeholder="Write a comment..." />
                                    <button onclick="addComment(this)">Post</button>
                                </div>
                                <div class="comments-list">
                                    <div class="no-comments">No comments yet. Be the first!</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>

        <div class="footer">
            <i class="fas fa-shield-alt"></i> Secure Portal | Cebu Technological University | © 2024 Campus Connect
        </div>

        <!-- About Us Modal -->
        <div id="aboutModal" class="modal">
            <div class="modal-content">
                <div class="modal-icon">
                    <i class="fas fa-university"></i>
                </div>
                <div class="modal-title">Campus Connect</div>
                <div class="modal-text">
                    Campus Connect is a centralized web-based announcement system for Cebu Technological University. 
                    It allows students to access official announcements, exam schedules, class suspensions, and campus events in one place.
                </div>
                <div class="modal-text">
                    <strong>Version:</strong> 1.0<br>
                    <strong>Developed for:</strong> CTU Students & Faculty
                </div>
                <button class="modal-close" onclick="closeAboutModal()">Close</button>
            </div>
        </div>
    </form>

    <script>
        // Toggle Dropdown
        function toggleDropdown(id) {
            var dropdown = document.getElementById(id);
            if (dropdown.style.display === 'none' || dropdown.style.display === '') {
                dropdown.style.display = 'block';
            } else {
                dropdown.style.display = 'none';
            }
        }

        // Toggle Notification Dropdown
        function toggleNotificationDropdown() {
            var dropdown = document.getElementById('notificationDropdown');
            dropdown.classList.toggle('show');
        }

        // Close notification dropdown when clicking outside
        document.addEventListener('click', function(e) {
            var bell = document.querySelector('.notification-bell');
            var dropdown = document.getElementById('notificationDropdown');
            if (!bell.contains(e.target) && !dropdown.contains(e.target)) {
                dropdown.classList.remove('show');
            }
        });

        // Toggle Comments
        function toggleComments(btn) {
            var card = btn.closest('.announcement-card');
            var commentsSection = card.querySelector('.comments-section');
            commentsSection.classList.toggle('show');
        }

        // Filter Category
        function filterCategory(category) {
            var announcements = document.querySelectorAll('.announcement-card');
            var filterLabel = document.getElementById('activeFilterLabel');
            
            announcements.forEach(function(ann) {
                if (category === 'All' || ann.getAttribute('data-category') === category) {
                    ann.style.display = 'block';
                } else {
                    ann.style.display = 'none';
                }
            });
            
            filterLabel.innerText = category;
            document.getElementById('categoryDropdown').style.display = 'none';
        }

        // Search Announcements
        function searchAnnouncements() {
            var searchTerm = document.getElementById('searchInput').value.toLowerCase();
            var announcements = document.querySelectorAll('.announcement-card');
            var found = false;
            
            announcements.forEach(function(ann) {
                var title = ann.querySelector('.announcement-title').innerText.toLowerCase();
                var content = ann.querySelector('.announcement-content').innerText.toLowerCase();
                
                if (title.includes(searchTerm) || content.includes(searchTerm)) {
                    ann.style.display = 'block';
                    found = true;
                } else {
                    ann.style.display = 'none';
                }
            });
            
            if (!found && searchTerm !== '') {
                alert('No announcements found matching "' + searchTerm + '"');
            }
        }

        // Enter key search
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                searchAnnouncements();
            }
        });

        // Toggle Pin
        function togglePin(btn) {
            if (btn.innerHTML.includes('Pin')) {
                btn.innerHTML = '<i class="fas fa-thumbtack"></i> Unpin';
                alert('Announcement pinned!');
            } else {
                btn.innerHTML = '<i class="fas fa-thumbtack"></i> Pin';
                alert('Announcement unpinned!');
            }
        }

        // Add Comment
        function addComment(btn) {
            var input = btn.parentElement.querySelector('input');
            var commentText = input.value.trim();
            
            if (commentText !== '') {
                var commentsList = btn.parentElement.parentElement.querySelector('.comments-list');
                var noComments = commentsList.querySelector('.no-comments');
                
                if (noComments) {
                    noComments.remove();
                }
                
                var newComment = document.createElement('div');
                newComment.className = 'comment';
                newComment.innerHTML = '<span class="comment-author">You:</span> ' + commentText;
                commentsList.appendChild(newComment);
                input.value = '';
            }
        }

        // Remove Pin
        function removePin(btn) {
            btn.parentElement.remove();
            alert('Item removed from pinned!');
        }

        // Mark Notification Read
        function markRead(item) {
            item.classList.remove('unread');
            var dot = item.querySelector('.notification-dot');
            if (dot) dot.remove();
            updateBadgeCount();
        }

        function markAllRead() {
            var notifications = document.querySelectorAll('.notification-item.unread');
            notifications.forEach(function(notif) {
                notif.classList.remove('unread');
                var dot = notif.querySelector('.notification-dot');
                if (dot) dot.remove();
            });
            updateBadgeCount();
        }

        function updateBadgeCount() {
            var unreadCount = document.querySelectorAll('.notification-item.unread').length;
            var badge = document.getElementById('notificationBadge');
            if (unreadCount > 0) {
                badge.textContent = unreadCount;
                badge.style.display = 'inline-block';
            } else {
                badge.style.display = 'none';
            }
        }

        // Theme Toggle
        function toggleTheme(item) {
            var toggle = item.querySelector('.toggle-switch');
            toggle.classList.toggle('active');
            var body = document.body;

            if (body.classList.contains('dark-mode')) {
                // Switch to LIGHT MODE
                body.classList.remove('dark-mode');
                body.style.backgroundImage = "url('wbg.jpg')"; // Your light image
                body.style.backgroundSize = "cover";
                body.style.backgroundAttachment = "fixed";

                // Update card backgrounds to be semi-transparent white
                document.querySelectorAll('.card, .announcement-card, .header').forEach(function (el) {
                    el.style.background = 'rgba(255, 255, 255, 0.7)';
                    el.style.color = '#1a2a3a';
                });
            } else {
                // Switch to DARK MODE
                body.classList.add('dark-mode');
                body.style.backgroundImage = "url('bg.jpg')"; // Your dark image
                body.style.backgroundSize = "cover";
                body.style.backgroundAttachment = "fixed";

                // Update card backgrounds to be semi-transparent dark
                document.querySelectorAll('.card, .announcement-card, .header').forEach(function (el) {
                    el.style.background = 'rgba(42, 42, 42, 0.7)';
                    el.style.color = '#e4e6eb';
                });
            }
        }

        // About Modal
        function openAboutModal() {
            document.getElementById('aboutModal').style.display = 'flex';
        }

        function closeAboutModal() {
            document.getElementById('aboutModal').style.display = 'none';
        }

        // Logout
        function logout() {
            if (confirm('Are you sure you want to logout?')) {
                window.location.href = 'login.aspx';
            }
        }
    </script>
=======
        </form>
    </div>
>>>>>>> 5a70aa160eda3870e5d83879f6dcfdb610a51895
</body>
</html>