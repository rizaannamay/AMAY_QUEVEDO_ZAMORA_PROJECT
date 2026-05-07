<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="AMAY_QUEVEDO_ZAMORA_PROJECT.Admin" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Campus Connect - Admin Review Panel</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
<link rel="stylesheet" href="dark-mode.css" />
<style>
* { margin:0; padding:0; box-sizing:border-box; }
:root {
    --bg-image: url('wbg.jpg');
    --page-text: #1a2a3a;
    --surface: rgba(255,255,255,0.93);
    --surface-strong: #ffffff;
    --surface-soft: #f0f5ff;
    --border: rgba(26,58,92,0.12);
    --primary: #1a2a3a;
    --primary-2: #a87800;
    --muted: #6b7c8f;
    --shadow: 0 8px 24px rgba(0,0,0,0.08);
}
html, body, form { min-height:100%; }
html, body { overflow:auto; scrollbar-width:none; -ms-overflow-style:none; }
html::-webkit-scrollbar { display:none; }
body::before {
    content:''; position:fixed; top:0; left:0; right:0; height:80px;
    z-index:199; pointer-events:none;
    background-image:linear-gradient(rgba(255,255,255,0.18),rgba(255,255,255,0.18)),var(--bg-image);
    background-size:cover; background-position:center; background-attachment:fixed;
}
body {
    font-family:"Segoe UI",Tahoma,Geneva,Verdana,sans-serif;
    color:var(--page-text);
    background-image:linear-gradient(rgba(255,255,255,0.18),rgba(255,255,255,0.18)),var(--bg-image);
    background-size:cover; background-repeat:no-repeat;
    background-position:center; background-attachment:fixed;
    transition:background 0.4s ease, color 0.4s ease;
}
.shell { max-width:1100px; margin:0 auto; padding:90px 20px 60px; display:flex; flex-direction:column; gap:20px; }

/* topbar */
.topbar {
    background:#c9920a; backdrop-filter:blur(10px);
    border:1px solid rgba(255,255,255,0.15); border-radius:24px;
    padding:12px 24px; display:flex; align-items:center;
    justify-content:space-between; gap:16px;
    box-shadow:0 4px 20px rgba(0,0,0,0.2);
    position:fixed; top:10px; left:10px; right:10px; z-index:200;
}
.brand { display:flex; align-items:center; gap:10px; font-size:18px; font-weight:800; color:#fff; }
.brand-badge {
    width:40px; height:40px; border-radius:12px;
    background:rgba(255,255,255,0.15);
    color:#fff; display:flex; align-items:center; justify-content:center; font-size:16px;
}
.brand-sub { font-size:11px; color:rgba(255,255,255,0.7); font-weight:500; }
.topbar-right { display:flex; align-items:center; gap:10px; }
.topbar-user { display:flex; align-items:center; gap:8px; background:rgba(255,255,255,0.12); border:1px solid rgba(255,255,255,0.25); border-radius:40px; padding:5px 14px; }
.topbar-user span { font-size:13px; font-weight:600; color:#fff; }
.back-btn {
    width:38px; height:38px; border-radius:50%;
    background:rgba(255,255,255,0.15); border:1px solid rgba(255,255,255,0.3);
    color:#fff; cursor:pointer; text-decoration:none;
    display:flex; align-items:center; justify-content:center; transition:background 0.2s;
}
.back-btn:hover { background:rgba(255,255,255,0.25); }

/* stat strip */
.stat-strip { display:grid; grid-template-columns:repeat(auto-fit,minmax(130px,1fr)); gap:14px; }
.stat-box {
    background:var(--surface); backdrop-filter:blur(14px);
    border:1px solid var(--border); border-radius:20px;
    padding:16px 18px; text-align:center; box-shadow:var(--shadow);
}
.stat-num { font-size:26px; font-weight:800; color:#c9920a; }
.stat-lbl { font-size:11px; color:var(--muted); font-weight:600; text-transform:uppercase; margin-top:4px; }

/* filter bar */
.filter-bar {
    background:var(--surface); backdrop-filter:blur(14px);
    border:1px solid var(--border); border-radius:20px;
    padding:14px 20px; display:flex; flex-wrap:wrap; gap:10px; align-items:center;
    box-shadow:var(--shadow);
}
.filter-btn {
    padding:8px 18px; border-radius:30px; border:1px solid var(--border);
    background:none; font-size:13px; font-weight:600; color:var(--muted);
    cursor:pointer; transition:all 0.2s;
}
.filter-btn:hover { background:var(--surface-soft); color:var(--primary); }
.filter-btn.active { background:linear-gradient(135deg,#c9920a,#a87800); color:#fff; border-color:transparent; box-shadow:0 4px 12px rgba(201,146,10,0.25); }
.filter-search {
    flex:1; min-width:180px; padding:8px 14px; border-radius:30px;
    border:1px solid var(--border); background:var(--surface-soft);
    font-size:13px; color:var(--primary); outline:none; font-family:inherit;
}
.filter-search:focus { border-color:#c9920a; box-shadow:0 0 0 3px rgba(201,146,10,0.12); }

/* post cards */
.posts-grid { display:flex; flex-direction:column; gap:16px; }
.post-card {
    background:var(--surface); backdrop-filter:blur(14px);
    border:1px solid var(--border); border-radius:24px;
    box-shadow:var(--shadow); overflow:hidden;
    transition:box-shadow 0.2s, border-color 0.2s;
}
.post-card:hover { box-shadow:0 12px 32px rgba(0,0,0,0.12); }
.post-card.status-pending  { border-left:4px solid #f59e0b; }
.post-card.status-approved { border-left:4px solid #10b981; }
.post-card.status-rejected { border-left:4px solid #ef4444; }

.post-head {
    padding:16px 20px 10px;
    display:flex; align-items:flex-start; justify-content:space-between; gap:12px;
}
.post-author-row { display:flex; align-items:center; gap:12px; }
.post-avatar {
    width:44px; height:44px; border-radius:50%; overflow:hidden;
    background:linear-gradient(135deg,#c9920a,#a87800);
    display:flex; align-items:center; justify-content:center;
    font-size:18px; color:#fff; flex-shrink:0;
}
.post-avatar img { width:100%; height:100%; object-fit:cover; border-radius:50%; display:block; }
.post-author-name { font-weight:700; font-size:15px; color:var(--primary); }
.post-date { font-size:12px; color:var(--muted); margin-top:2px; }
.status-badge {
    display:inline-flex; align-items:center; gap:5px;
    padding:4px 12px; border-radius:20px; font-size:11px; font-weight:700;
}
.badge-pending  { background:#fef3c7; color:#b45309; }
.badge-approved { background:#d1fae5; color:#065f46; }
.badge-rejected { background:#fee2e2; color:#991b1b; }

.post-body { padding:0 20px 14px; }
.post-title { font-size:17px; font-weight:700; color:var(--primary); margin-bottom:6px; }
.post-content { font-size:13px; color:var(--muted); line-height:1.65; }
.post-image { margin-top:10px; border-radius:14px; overflow:hidden; max-height:200px; }
.post-image img { width:100%; max-height:200px; object-fit:cover; display:block; }
.post-meta-row {
    display:flex; flex-wrap:wrap; gap:8px; margin-top:10px; align-items:center;
}
.cat-badge {
    display:inline-block; padding:3px 10px; border-radius:20px;
    font-size:10px; font-weight:700;
}
.cat-exam       { background:#fef3c7; color:#c9920a; }
.cat-suspension { background:#ffebee; color:#c62828; }
.cat-event      { background:#e8f5e9; color:#2e7d32; }
.cat-general    { background:#e0e7ff; color:#4f46e5; }

/* action buttons */
.post-actions {
    padding:12px 20px 16px;
    border-top:1px solid var(--border);
    display:flex; flex-wrap:wrap; gap:10px; align-items:center;
}
.btn-approve {
    display:inline-flex; align-items:center; gap:7px;
    padding:9px 20px; border:none; border-radius:30px;
    background:linear-gradient(135deg,#059669,#10b981); color:#fff;
    font-size:13px; font-weight:700; cursor:pointer;
    box-shadow:0 4px 12px rgba(5,150,105,0.25); transition:all 0.2s;
}
.btn-approve:hover { transform:translateY(-1px); box-shadow:0 6px 16px rgba(5,150,105,0.35); }
.btn-reject {
    display:inline-flex; align-items:center; gap:7px;
    padding:9px 20px; border:none; border-radius:30px;
    background:linear-gradient(135deg,#dc2626,#b91c1c); color:#fff;
    font-size:13px; font-weight:700; cursor:pointer;
    box-shadow:0 4px 12px rgba(220,38,38,0.25); transition:all 0.2s;
}
.btn-reject:hover { transform:translateY(-1px); box-shadow:0 6px 16px rgba(220,38,38,0.35); }
.btn-undo {
    display:inline-flex; align-items:center; gap:7px;
    padding:9px 20px; border:1px solid var(--border); border-radius:30px;
    background:none; color:var(--muted);
    font-size:13px; font-weight:600; cursor:pointer; transition:all 0.2s;
}
.btn-undo:hover { background:var(--surface-soft); color:var(--primary); }

/* rejection reason input */
.reject-reason-wrap { display:none; flex:1; min-width:200px; }
.reject-reason-wrap.show { display:flex; gap:8px; align-items:center; }
.reject-reason-input {
    flex:1; padding:8px 14px; border-radius:20px;
    border:1px solid #ef4444; background:var(--surface-soft);
    font-size:13px; color:var(--primary); outline:none; font-family:inherit;
}
.reject-reason-input:focus { box-shadow:0 0 0 3px rgba(239,68,68,0.12); }
.rejection-note {
    margin-top:8px; padding:8px 14px; border-radius:10px;
    background:#fee2e2; border:1px solid #fecaca;
    font-size:12px; color:#991b1b; display:flex; align-items:center; gap:6px;
}

/* empty state */
.empty-state {
    text-align:center; padding:60px 20px;
    background:var(--surface); border-radius:24px;
    border:1px solid var(--border); box-shadow:var(--shadow);
}
.empty-state i { font-size:48px; color:var(--muted); margin-bottom:14px; display:block; }
.empty-state p { color:var(--muted); font-size:15px; }

/* toast */
.toast-msg {
    position:fixed; bottom:28px; left:50%; transform:translateX(-50%);
    background:#c9920a; color:#fff; padding:10px 24px; border-radius:30px;
    font-size:13px; z-index:9999; box-shadow:0 4px 16px rgba(0,0,0,.25);
    animation:toastFade 2.6s ease forwards; pointer-events:none;
}
@keyframes toastFade {
    0%   { opacity:0; transform:translateX(-50%) translateY(10px); }
    12%  { opacity:1; transform:translateX(-50%) translateY(0); }
    80%  { opacity:1; }
    100% { opacity:0; }
}

/* dark mode */
body.dark-mode {
    --bg-image: url('bg.jpg');
    --page-text: #e4e6eb;
    --surface: rgba(30,41,59,0.95);
    --surface-strong: rgba(30,41,59,0.98);
    --surface-soft: rgba(51,65,85,0.6);
    --border: rgba(148,163,184,0.2);
    --primary: #93c5fd;
    --primary-2: #60a5fa;
    --muted: #cbd5e1;
    --shadow: 0 8px 32px rgba(0,0,0,0.5);
}
body.dark-mode { background-image:linear-gradient(rgba(18,18,18,0.92),rgba(18,18,18,0.92)),url('bg.jpg'); background-color:#121212; }
body.dark-mode::before { background-image:linear-gradient(rgba(18,18,18,0.92),rgba(18,18,18,0.92)),url('bg.jpg'); }
body.dark-mode .topbar { background:rgba(25,25,25,0.95); border-color:rgba(255,255,255,0.08); }
body.dark-mode .post-author-name { color:#e0e7ff; }
body.dark-mode .post-title { color:#e0e7ff; }
body.dark-mode .badge-pending  { background:rgba(245,158,11,0.18); color:#fcd34d; }
body.dark-mode .badge-approved { background:rgba(16,185,129,0.18); color:#6ee7b7; }
body.dark-mode .badge-rejected { background:rgba(239,68,68,0.18);  color:#fca5a5; }
body.dark-mode .rejection-note { background:rgba(239,68,68,0.15); border-color:rgba(239,68,68,0.3); color:#fca5a5; }
body.dark-mode .filter-search { background:rgba(51,65,85,0.6); color:#e2e8f0; border-color:rgba(148,163,184,0.3); }
body.dark-mode .reject-reason-input { background:rgba(51,65,85,0.6); color:#e2e8f0; }
body.dark-mode .stat-num { color:#fbbf24; }

@media (max-width:640px) {
    .shell { padding:80px 12px 40px; }
    .post-head { flex-direction:column; gap:8px; }
    .post-actions { flex-direction:column; align-items:stretch; }
    .btn-approve, .btn-reject, .btn-undo { justify-content:center; }
}
</style>
</head>
<body>
<script>
(function(){
    document.body.classList.toggle('dark-mode', localStorage.getItem('campus_theme') === 'dark');
    window.addEventListener('storage', function(e){
        if(e.key==='campus_theme') document.body.classList.toggle('dark-mode', e.newValue==='dark');
    });
})();
</script>
<form id="form1" runat="server">
<div class="shell">

    <!-- Topbar -->
    <div class="topbar">
        <div class="brand">
            <div class="brand-badge"><i class="fas fa-shield-alt"></i></div>
            <div>
                <div>Admin Review Panel</div>
                <div class="brand-sub">Campus Connect — Content Moderation</div>
            </div>
        </div>
        <div class="topbar-right">
            <div class="topbar-user">
                <i class="fas fa-user-shield" style="color:#fff;font-size:14px;"></i>
                <span><%= Session["Username"] ?? "Admin" %></span>
            </div>
            <a class="back-btn" href="login.aspx" title="Logout">
                <i class="fas fa-sign-out-alt" style="font-size:15px;"></i>
            </a>
        </div>
    </div>

    <!-- Stats -->
    <div class="stat-strip">
        <div class="stat-box">
            <div class="stat-num"><asp:Label ID="lblTotal"    runat="server">0</asp:Label></div>
            <div class="stat-lbl"><i class="fas fa-bullhorn"></i> Total Posts</div>
        </div>
        <div class="stat-box">
            <div class="stat-num" style="color:#f59e0b;"><asp:Label ID="lblPending"  runat="server">0</asp:Label></div>
            <div class="stat-lbl"><i class="fas fa-clock"></i> Pending</div>
        </div>
        <div class="stat-box">
            <div class="stat-num" style="color:#10b981;"><asp:Label ID="lblApproved" runat="server">0</asp:Label></div>
            <div class="stat-lbl"><i class="fas fa-check-circle"></i> Approved</div>
        </div>
        <div class="stat-box">
            <div class="stat-num" style="color:#ef4444;"><asp:Label ID="lblRejected" runat="server">0</asp:Label></div>
            <div class="stat-lbl"><i class="fas fa-times-circle"></i> Rejected</div>
        </div>
    </div>

    <!-- Filter bar -->
    <div class="filter-bar">
        <button type="button" class="filter-btn active" id="fAll"      onclick="setFilter('All')">All</button>
        <button type="button" class="filter-btn"        id="fPending"  onclick="setFilter('Pending')">
            <i class="fas fa-clock" style="margin-right:4px;"></i>Pending
        </button>
        <button type="button" class="filter-btn"        id="fApproved" onclick="setFilter('Approved')">
            <i class="fas fa-check" style="margin-right:4px;"></i>Approved
        </button>
        <button type="button" class="filter-btn"        id="fRejected" onclick="setFilter('Rejected')">
            <i class="fas fa-times" style="margin-right:4px;"></i>Rejected
        </button>
        <input type="text" class="filter-search" id="searchBox"
               placeholder="Search by title or author..." oninput="applyFilters()" />
    </div>

    <!-- Posts -->
    <div class="posts-grid" id="postsGrid">
        <asp:Repeater ID="rptPosts" runat="server">
            <ItemTemplate>
                <div class="post-card status-<%# Eval("Status") %>"
                     data-status="<%# Eval("Status") %>"
                     data-title="<%# System.Web.HttpUtility.HtmlAttributeEncode(Eval("Title").ToString()) %>"
                     data-author="<%# System.Web.HttpUtility.HtmlAttributeEncode(Eval("AuthorName").ToString()) %>">

                    <div class="post-head">
                        <div class="post-author-row">
                            <div class="post-avatar">
                                <%# !string.IsNullOrEmpty(Eval("ProfileImage") as string)
                                    ? "<img src=\"" + Eval("ProfileImage") + "\" alt=\"\" />"
                                    : "<i class=\"fas fa-user-tie\"></i>" %>
                            </div>
                            <div>
                                <div class="post-author-name"><%# Eval("AuthorName") %></div>
                                <div class="post-date">
                                    <i class="far fa-calendar-alt" style="margin-right:3px;"></i>
                                    <%# Convert.ToDateTime(Eval("Date_Posted")).ToString("MMM dd, yyyy hh:mm tt") %>
                                </div>
                            </div>
                        </div>
                        <span class="status-badge badge-<%# Eval("Status").ToString().ToLower() %>">
                            <i class="fas fa-<%# Eval("Status").ToString() == "Pending" ? "clock" : Eval("Status").ToString() == "Approved" ? "check-circle" : "times-circle" %>"></i>
                            <%# Eval("Status") %>
                        </span>
                    </div>

                    <div class="post-body">
                        <div class="post-title"><%# System.Web.HttpUtility.HtmlEncode(Eval("Title").ToString()) %></div>
                        <div class="post-content"><%# System.Web.HttpUtility.HtmlEncode(
                            Eval("Content").ToString().Length > 280
                            ? Eval("Content").ToString().Substring(0, 280) + "..."
                            : Eval("Content").ToString()) %></div>

                        <%# !string.IsNullOrEmpty(Eval("ImageUrl") as string)
                            ? "<div class=\"post-image\"><img src=\"" + Eval("ImageUrl") + "\" alt=\"Post image\" /></div>"
                            : "" %>

                        <div class="post-meta-row">
                            <span class="cat-badge cat-<%# Eval("Category").ToString().ToLower().Replace(" ","") %>">
                                <%# Eval("Category") %>
                            </span>
                            <span style="font-size:12px;color:var(--muted);">
                                <i class="fas fa-heart" style="margin-right:3px;color:#f87171;"></i><%# Eval("LikeCount") %>
                                &nbsp;
                                <i class="fas fa-comment" style="margin-right:3px;color:#60a5fa;"></i><%# Eval("CommentCount") %>
                            </span>
                        </div>

                        <%# !string.IsNullOrEmpty(Eval("RejectionReason") as string)
                            ? "<div class=\"rejection-note\"><i class=\"fas fa-exclamation-circle\"></i><strong>Rejection reason:</strong>&nbsp;" + System.Web.HttpUtility.HtmlEncode(Eval("RejectionReason").ToString()) + "</div>"
                            : "" %>
                    </div>

                    <div class="post-actions" id="actions-<%# Eval("AnnouncementId") %>">
                        <%# Eval("Status").ToString() != "Approved" ? string.Format(
                            "<button type=\"button\" class=\"btn-approve\" onclick=\"reviewPost({0},'Approve',this)\"><i class=\"fas fa-check\"></i> Approve</button>",
                            Eval("AnnouncementId")) : "" %>

                        <%# Eval("Status").ToString() != "Rejected" ? string.Format(
                            "<button type=\"button\" class=\"btn-reject\" onclick=\"showRejectBox({0},this)\"><i class=\"fas fa-times\"></i> Reject</button>",
                            Eval("AnnouncementId")) : "" %>

                        <%# Eval("Status").ToString() != "Pending" ? string.Format(
                            "<button type=\"button\" class=\"btn-undo\" onclick=\"reviewPost({0},'Pending',this)\"><i class=\"fas fa-undo\"></i> Reset to Pending</button>",
                            Eval("AnnouncementId")) : "" %>

                        <div class="reject-reason-wrap" id="rr-<%# Eval("AnnouncementId") %>">
                            <input type="text" class="reject-reason-input"
                                   id="rri-<%# Eval("AnnouncementId") %>"
                                   placeholder="Reason for rejection (optional)..." />
                            <button type="button" class="btn-reject"
                                    onclick="reviewPost(<%# Eval("AnnouncementId") %>,'Reject',this)">
                                <i class="fas fa-times"></i> Confirm
                            </button>
                            <button type="button" class="btn-undo"
                                    onclick="hideRejectBox(<%# Eval("AnnouncementId") %>)">Cancel</button>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <!-- Empty state (shown by JS when no cards match filter) -->
    <div class="empty-state" id="emptyState" style="display:none;">
        <i class="fas fa-inbox"></i>
        <p>No announcements match the current filter.</p>
    </div>

</div>
</form>

<script>
var currentFilter = 'All';

function setFilter(f) {
    currentFilter = f;
    ['All','Pending','Approved','Rejected'].forEach(function(x){
        var btn = document.getElementById('f' + x);
        if(btn) btn.classList.toggle('active', x === f);
    });
    applyFilters();
}

function applyFilters() {
    var q = (document.getElementById('searchBox').value || '').toLowerCase().trim();
    var cards = document.querySelectorAll('.post-card');
    var visible = 0;
    cards.forEach(function(c){
        var status = c.dataset.status || '';
        var title  = (c.dataset.title  || '').toLowerCase();
        var author = (c.dataset.author || '').toLowerCase();
        var matchFilter = currentFilter === 'All' || status === currentFilter;
        var matchSearch = !q || title.includes(q) || author.includes(q);
        var show = matchFilter && matchSearch;
        c.style.display = show ? '' : 'none';
        if(show) visible++;
    });
    document.getElementById('emptyState').style.display = visible === 0 ? '' : 'none';
}

function showRejectBox(id, btn) {
    var wrap = document.getElementById('rr-' + id);
    if(wrap) { wrap.classList.add('show'); if(btn) btn.style.display='none'; }
}
function hideRejectBox(id) {
    var wrap = document.getElementById('rr-' + id);
    if(wrap) { wrap.classList.remove('show'); }
    var rejectBtn = document.querySelector('#actions-' + id + ' .btn-reject:not([onclick*="showRejectBox"])');
    // re-show the original reject button
    var allBtns = document.querySelectorAll('#actions-' + id + ' .btn-reject');
    allBtns.forEach(function(b){ if(b.getAttribute('onclick') && b.getAttribute('onclick').includes('showRejectBox')) b.style.display=''; });
}

function reviewPost(id, action, btn) {
    var reason = '';
    if(action === 'Reject') {
        var inp = document.getElementById('rri-' + id);
        reason = inp ? inp.value.trim() : '';
    }
    if(btn) { btn.disabled = true; btn.style.opacity = '0.6'; }

    fetch('AdminHandler.ashx?action=' + action + '&id=' + id + '&reason=' + encodeURIComponent(reason), {
        credentials: 'same-origin'
    })
    .then(function(r){ return r.json(); })
    .then(function(res){
        if(!res.ok) { showToast('Error: ' + (res.error || 'Unknown error')); if(btn){btn.disabled=false;btn.style.opacity='';} return; }
        showToast(action === 'Approve' ? '✅ Post approved!' : action === 'Reject' ? '🚫 Post rejected.' : '↩️ Reset to pending.');
        setTimeout(function(){ location.reload(); }, 900);
    })
    .catch(function(){ showToast('Network error. Please try again.'); if(btn){btn.disabled=false;btn.style.opacity='';} });
}

function showToast(msg) {
    var t = document.createElement('div');
    t.className = 'toast-msg'; t.textContent = msg;
    document.body.appendChild(t);
    setTimeout(function(){ if(t.parentNode) t.parentNode.removeChild(t); }, 2700);
}
</script>
</body>
</html>
