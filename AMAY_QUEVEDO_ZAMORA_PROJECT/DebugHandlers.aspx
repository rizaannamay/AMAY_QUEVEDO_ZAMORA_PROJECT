<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>
<html>
<head>
    <title>Debug Handlers</title>
    <style>
        body { font-family: Arial; padding: 40px; background: #f5f5f5; }
        .container { max-width: 900px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; }
        button { padding: 12px 24px; margin: 10px; background: #2563eb; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }
        button:hover { background: #1d4ed8; }
        .result { margin: 20px 0; padding: 15px; border-radius: 5px; font-family: monospace; white-space: pre-wrap; }
        .success { background: #d1fae5; color: #065f46; }
        .error { background: #fee2e2; color: #991b1b; }
        .info { background: #dbeafe; color: #1e40af; }
        h2 { color: #1a3a5c; margin-top: 30px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔧 Handler Debug Tool</h1>
        <p>Click buttons to test each handler directly. Check console (F12) for detailed logs.</p>

        <h2>Session Info</h2>
        <div class="result info">
            <% 
                if (Session["IsLoggedIn"] != null && (bool)Session["IsLoggedIn"])
                {
                    Response.Write("✅ Logged In\n");
                    Response.Write("User ID: " + Session["UserId"] + "\n");
                    Response.Write("Username: " + Session["Username"] + "\n");
                    Response.Write("Full Name: " + Session["FullName"] + "\n");
                    Response.Write("Role: " + Session["Role"]);
                }
                else
                {
                    Response.Write("❌ NOT LOGGED IN - Please login first!");
                }
            %>
        </div>

        <h2>Test Handlers</h2>
        
        <button onclick="testAnnouncementHandler()">Test AnnouncementHandler</button>
        <button onclick="testLikeHandler()">Test LikeHandler</button>
        <button onclick="testPinHandler()">Test UserPinHandler</button>
        <button onclick="testCommentHandler()">Test CommentHandler</button>
        
        <div id="results"></div>

        <h2>Quick Actions</h2>
        <a href="login.aspx" style="display: inline-block; padding: 12px 24px; background: #059669; color: white; text-decoration: none; border-radius: 5px; margin: 10px;">Go to Login</a>
        <a href="Student.aspx" style="display: inline-block; padding: 12px 24px; background: #7c3aed; color: white; text-decoration: none; border-radius: 5px; margin: 10px;">Go to Student Portal</a>
    </div>

    <script>
        function showResult(title, data, isError = false) {
            const results = document.getElementById('results');
            const div = document.createElement('div');
            div.className = 'result ' + (isError ? 'error' : 'success');
            div.innerHTML = '<strong>' + title + '</strong>\n' + JSON.stringify(data, null, 2);
            results.appendChild(div);
        }

        function testAnnouncementHandler() {
            console.log('Testing AnnouncementHandler...');
            fetch('AnnouncementHandler.ashx?action=getAll', { credentials: 'same-origin' })
                .then(r => {
                    console.log('Response status:', r.status);
                    return r.json();
                })
                .then(data => {
                    console.log('AnnouncementHandler response:', data);
                    showResult('AnnouncementHandler.ashx?action=getAll', data);
                })
                .catch(err => {
                    console.error('AnnouncementHandler error:', err);
                    showResult('AnnouncementHandler ERROR', { error: err.message }, true);
                });
        }

        function testLikeHandler() {
            console.log('Testing LikeHandler...');
            // Test with announcement ID 1
            fetch('LikeHandler.ashx?action=toggle&postId=1', { credentials: 'same-origin' })
                .then(r => {
                    console.log('Response status:', r.status);
                    return r.json();
                })
                .then(data => {
                    console.log('LikeHandler response:', data);
                    showResult('LikeHandler.ashx?action=toggle&postId=1', data);
                })
                .catch(err => {
                    console.error('LikeHandler error:', err);
                    showResult('LikeHandler ERROR', { error: err.message }, true);
                });
        }

        function testPinHandler() {
            console.log('Testing UserPinHandler...');
            // Test with announcement ID 1
            fetch('UserPinHandler.ashx?action=toggle&announcementId=1', { credentials: 'same-origin' })
                .then(r => {
                    console.log('Response status:', r.status);
                    return r.json();
                })
                .then(data => {
                    console.log('UserPinHandler response:', data);
                    showResult('UserPinHandler.ashx?action=toggle&announcementId=1', data);
                })
                .catch(err => {
                    console.error('UserPinHandler error:', err);
                    showResult('UserPinHandler ERROR', { error: err.message }, true);
                });
        }

        function testCommentHandler() {
            console.log('Testing CommentHandler...');
            // First get comments
            fetch('CommentHandler.ashx?action=get&postId=1', { credentials: 'same-origin' })
                .then(r => {
                    console.log('Response status:', r.status);
                    return r.json();
                })
                .then(data => {
                    console.log('CommentHandler response:', data);
                    showResult('CommentHandler.ashx?action=get&postId=1', data);
                })
                .catch(err => {
                    console.error('CommentHandler error:', err);
                    showResult('CommentHandler ERROR', { error: err.message }, true);
                });
        }

        // Auto-test on load if logged in
        window.onload = function() {
            <% if (Session["IsLoggedIn"] != null && (bool)Session["IsLoggedIn"]) { %>
                console.log('User is logged in, running auto-tests...');
                setTimeout(() => {
                    testAnnouncementHandler();
                }, 500);
            <% } else { %>
                console.log('User not logged in. Please login first.');
            <% } %>
        };
    </script>
</body>
</html>
