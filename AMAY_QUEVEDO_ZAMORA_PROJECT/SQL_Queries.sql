-- ============================================================
--  CampusConnect Announcement Portal
--  Required SQL Queries (1–10)
--  Database: CAPdb
-- ============================================================

USE CAPdb;
GO

-- ── QUERY 1: INSERT (Add data) ────────────────────────────────────────────────
-- Insert a new announcement posted by an Admin user
INSERT INTO Announcements (UserId, Title, Content, Category, ImageUrl)
VALUES (
    1,
    N'Midterm Exam Schedule',
    N'Midterm examinations will be held from May 5–9, 2026.',
    N'Exam',
    NULL
);
GO

-- ── QUERY 2: SELECT (Display data) ───────────────────────────────────────────
-- Retrieve all announcements with the author's full name
SELECT
    a.AnnouncementId,
    a.Title,
    a.Category,
    a.Date_Posted,
    a.LikeCount,
    a.CommentCount,
    u.FullName AS Author
FROM Announcements a
JOIN Users u ON u.UserId = a.UserId
ORDER BY a.Date_Posted DESC;
GO

-- ── QUERY 3: UPDATE (Edit data) ──────────────────────────────────────────────
-- Update the title and content of an existing announcement
UPDATE Announcements
SET
    Title   = N'Updated: Midterm Exam Schedule',
    Content = N'Midterm exams rescheduled to May 12–16, 2026.'
WHERE AnnouncementId = 1;
GO

-- ── QUERY 4: DELETE (Remove data) ────────────────────────────────────────────
-- Delete an announcement and its related comments and likes first
DELETE FROM Comments   WHERE AnnouncementId = 1;
DELETE FROM UserLikes  WHERE AnnouncementId = 1;
DELETE FROM Announcements WHERE AnnouncementId = 1;
GO

-- ── QUERY 5: SEARCH query (using WHERE) ──────────────────────────────────────
-- Search announcements by keyword in title or content
SELECT
    a.AnnouncementId,
    a.Title,
    a.Category,
    a.Date_Posted,
    u.FullName AS Author
FROM Announcements a
JOIN Users u ON u.UserId = a.UserId
WHERE a.Title    LIKE N'%exam%'
   OR a.Content  LIKE N'%exam%'
ORDER BY a.Date_Posted DESC;
GO

-- ── QUERY 6: FILTER query (by category and/or date) ──────────────────────────
-- Filter announcements by category and a specific date
SELECT
    a.AnnouncementId,
    a.Title,
    a.Category,
    a.Date_Posted,
    u.FullName AS Author
FROM Announcements a
JOIN Users u ON u.UserId = a.UserId
WHERE a.Category = N'Exam'
  AND CAST(a.Date_Posted AS DATE) = '2026-05-01'
ORDER BY a.Date_Posted DESC;
GO

-- ── QUERY 7: JOIN query (combine tables) ─────────────────────────────────────
-- Get all comments with the commenter's name and the announcement title
SELECT
    c.CommentId,
    u.FullName      AS Commenter,
    a.Title         AS Announcement,
    c.CommentText,
    c.CreatedDate
FROM Comments c
JOIN Users         u ON u.UserId         = c.UserId
JOIN Announcements a ON a.AnnouncementId = c.AnnouncementId
ORDER BY c.CreatedDate DESC;
GO

-- ── QUERY 8: COUNT / AGGREGATE query ─────────────────────────────────────────
-- Count total records in each table (used on the Backup/Dashboard page)
SELECT
    (SELECT COUNT(1) FROM Users)         AS TotalUsers,
    (SELECT COUNT(1) FROM Announcements) AS TotalAnnouncements,
    (SELECT COUNT(1) FROM Comments)      AS TotalComments,
    (SELECT COUNT(1) FROM UserLikes)     AS TotalLikes,
    (SELECT COUNT(1) FROM Notifications) AS TotalNotifications;
GO

-- Also: total likes per announcement (aggregate with GROUP BY)
SELECT
    a.Title,
    COUNT(ul.LikeId) AS TotalLikes
FROM Announcements a
LEFT JOIN UserLikes ul ON ul.AnnouncementId = a.AnnouncementId
GROUP BY a.AnnouncementId, a.Title
ORDER BY TotalLikes DESC;
GO

-- ── QUERY 9: ORDER BY query ───────────────────────────────────────────────────
-- Get announcements ordered by pinned first, then newest first
SELECT
    a.AnnouncementId,
    a.Title,
    a.Category,
    a.IsPinned,
    a.Date_Posted,
    u.FullName AS Author
FROM Announcements a
JOIN Users u ON u.UserId = a.UserId
ORDER BY a.IsPinned DESC, a.Date_Posted DESC;
GO

-- ── QUERY 10: CUSTOM query (system-specific) ─────────────────────────────────
-- Get the top 5 most-liked announcements with comment count and author
-- Used for analytics / admin dashboard summary
SELECT TOP 5
    a.AnnouncementId,
    a.Title,
    a.Category,
    u.FullName                                    AS Author,
    a.LikeCount,
    a.CommentCount,
    (SELECT COUNT(1) FROM UserLikes ul
     WHERE ul.AnnouncementId = a.AnnouncementId)  AS VerifiedLikes,
    a.Date_Posted
FROM Announcements a
JOIN Users u ON u.UserId = a.UserId
ORDER BY a.LikeCount DESC, a.CommentCount DESC;
GO
