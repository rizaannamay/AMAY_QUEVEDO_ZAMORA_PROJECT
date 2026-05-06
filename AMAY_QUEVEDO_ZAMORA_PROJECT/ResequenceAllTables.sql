USE CAPdb;
GO

-- ══════════════════════════════════════════════════════════════
-- RESEQUENCE ALL PRIMARY KEYS TO 1, 2, 3...
-- Users are NOT touched (keeps logins intact)
-- ══════════════════════════════════════════════════════════════

-- Cleanup any leftover temp tables from previous failed runs
IF OBJECT_ID('tempdb..#TAnnouncements') IS NOT NULL DROP TABLE #TAnnouncements;
IF OBJECT_ID('tempdb..#TComments')      IS NOT NULL DROP TABLE #TComments;
IF OBJECT_ID('tempdb..#TUserLikes')     IS NOT NULL DROP TABLE #TUserLikes;
IF OBJECT_ID('tempdb..#TNotifications') IS NOT NULL DROP TABLE #TNotifications;
IF OBJECT_ID('tempdb..#TUserPins')      IS NOT NULL DROP TABLE #TUserPins;
IF OBJECT_ID('tempdb..#TCommentLikes')  IS NOT NULL DROP TABLE #TCommentLikes;
GO

-- ── STEP 1: Snapshot all tables with OLD and NEW id columns ───

SELECT
    ROW_NUMBER() OVER (ORDER BY Date_Posted ASC) AS NewId,
    AnnouncementId AS OldId,
    UserId,        -- real UserId stays unchanged
    Title, Content, ImageUrl, Category, Date_Posted,
    LikeCount, CommentCount, ShareCount, IsPinned
INTO #TAnnouncements
FROM Announcements;

SELECT
    ROW_NUMBER() OVER (ORDER BY CreatedDate ASC) AS NewId,
    CommentId      AS OldId,
    AnnouncementId AS OldAnnouncementId,
    UserId,
    CommentText,
    ParentCommentId AS OldParentId,
    CAST(NULL AS INT) AS NewParentId,
    ISNULL(LikeCount,0) AS LikeCount,
    CreatedDate
INTO #TComments
FROM Comments;

SELECT
    ROW_NUMBER() OVER (ORDER BY CreatedDate ASC) AS NewId,
    LikeId         AS OldId,
    AnnouncementId AS OldAnnouncementId,
    UserId,
    CreatedDate
INTO #TUserLikes
FROM UserLikes;

SELECT
    ROW_NUMBER() OVER (ORDER BY CreatedDate ASC) AS NewId,
    NotificationId AS OldId,
    UserId,
    AnnouncementId AS OldAnnouncementId,
    Message, IsRead, CreatedDate
INTO #TNotifications
FROM Notifications;

SELECT
    ROW_NUMBER() OVER (ORDER BY CreatedDate ASC) AS NewId,
    UserPinId      AS OldId,
    UserId,
    AnnouncementId AS OldAnnouncementId,
    CreatedDate
INTO #TUserPins
FROM UserPins;

SELECT
    ROW_NUMBER() OVER (ORDER BY cl.CreatedDate ASC) AS NewId,
    cl.CommentLikeId AS OldId,
    cl.CommentId     AS OldCommentId,
    cl.UserId,
    cl.CreatedDate
INTO #TCommentLikes
FROM CommentLikes cl;

GO

-- ── STEP 2: Remap FK references using separate mapping columns ─

-- Remap Announcements FK: OldAnnouncementId -> NewId
UPDATE c SET c.OldAnnouncementId = a.NewId
FROM #TComments c JOIN #TAnnouncements a ON a.OldId = c.OldAnnouncementId;

UPDATE l SET l.OldAnnouncementId = a.NewId
FROM #TUserLikes l JOIN #TAnnouncements a ON a.OldId = l.OldAnnouncementId;

UPDATE n SET n.OldAnnouncementId = a.NewId
FROM #TNotifications n JOIN #TAnnouncements a ON a.OldId = n.OldAnnouncementId
WHERE n.OldAnnouncementId IS NOT NULL;

UPDATE p SET p.OldAnnouncementId = a.NewId
FROM #TUserPins p JOIN #TAnnouncements a ON a.OldId = p.OldAnnouncementId;

-- Remap Comments self-reference: OldParentId -> NewParentId
UPDATE c SET c.NewParentId = p.NewId
FROM #TComments c JOIN #TComments p ON p.OldId = c.OldParentId
WHERE c.OldParentId IS NOT NULL;

-- Remap CommentLikes FK: OldCommentId -> NewId
UPDATE cl SET cl.OldCommentId = c.NewId
FROM #TCommentLikes cl JOIN #TComments c ON c.OldId = cl.OldCommentId;

GO

-- ── STEP 3: Delete all data (child tables first) ──────────────

DELETE FROM CommentLikes;
DELETE FROM UserPins;
DELETE FROM Notifications;
DELETE FROM UserLikes;
DELETE FROM Comments;
DELETE FROM Announcements;

GO

-- ── STEP 4: Reset all identity seeds to 0 ────────────────────

DBCC CHECKIDENT ('Announcements', RESEED, 0);
DBCC CHECKIDENT ('Comments',      RESEED, 0);
DBCC CHECKIDENT ('UserLikes',     RESEED, 0);
DBCC CHECKIDENT ('Notifications', RESEED, 0);
DBCC CHECKIDENT ('UserPins',      RESEED, 0);
DBCC CHECKIDENT ('CommentLikes',  RESEED, 0);

GO

-- ── STEP 5: Reinsert with forced sequential IDs ───────────────

SET IDENTITY_INSERT Announcements ON;
INSERT INTO Announcements
    (AnnouncementId, UserId, Title, Content, ImageUrl, Category,
     Date_Posted, LikeCount, CommentCount, ShareCount, IsPinned)
SELECT NewId, UserId, Title, Content, ImageUrl, Category,
       Date_Posted, LikeCount, CommentCount, ShareCount, IsPinned
FROM #TAnnouncements ORDER BY NewId;
SET IDENTITY_INSERT Announcements OFF;

SET IDENTITY_INSERT Comments ON;
INSERT INTO Comments
    (CommentId, AnnouncementId, UserId, CommentText, ParentCommentId, LikeCount, CreatedDate)
SELECT NewId, OldAnnouncementId, UserId, CommentText, NewParentId, LikeCount, CreatedDate
FROM #TComments ORDER BY NewId;
SET IDENTITY_INSERT Comments OFF;

SET IDENTITY_INSERT UserLikes ON;
INSERT INTO UserLikes (LikeId, AnnouncementId, UserId, CreatedDate)
SELECT NewId, OldAnnouncementId, UserId, CreatedDate
FROM #TUserLikes ORDER BY NewId;
SET IDENTITY_INSERT UserLikes OFF;

SET IDENTITY_INSERT Notifications ON;
INSERT INTO Notifications (NotificationId, UserId, AnnouncementId, Message, IsRead, CreatedDate)
SELECT NewId, UserId, OldAnnouncementId, Message, IsRead, CreatedDate
FROM #TNotifications ORDER BY NewId;
SET IDENTITY_INSERT Notifications OFF;

SET IDENTITY_INSERT UserPins ON;
INSERT INTO UserPins (UserPinId, UserId, AnnouncementId, CreatedDate)
SELECT NewId, UserId, OldAnnouncementId, CreatedDate
FROM #TUserPins ORDER BY NewId;
SET IDENTITY_INSERT UserPins OFF;

SET IDENTITY_INSERT CommentLikes ON;
INSERT INTO CommentLikes (CommentLikeId, CommentId, UserId, CreatedDate)
SELECT NewId, OldCommentId, UserId, CreatedDate
FROM #TCommentLikes ORDER BY NewId;
SET IDENTITY_INSERT CommentLikes OFF;

GO

-- ── STEP 6: Reseed to current max ────────────────────────────

DECLARE @a  INT; SELECT @a  = ISNULL(MAX(AnnouncementId), 0) FROM Announcements;
DBCC CHECKIDENT ('Announcements', RESEED, @a);

DECLARE @c  INT; SELECT @c  = ISNULL(MAX(CommentId),      0) FROM Comments;
DBCC CHECKIDENT ('Comments', RESEED, @c);

DECLARE @ul INT; SELECT @ul = ISNULL(MAX(LikeId),         0) FROM UserLikes;
DBCC CHECKIDENT ('UserLikes', RESEED, @ul);

DECLARE @n  INT; SELECT @n  = ISNULL(MAX(NotificationId), 0) FROM Notifications;
DBCC CHECKIDENT ('Notifications', RESEED, @n);

DECLARE @up INT; SELECT @up = ISNULL(MAX(UserPinId),      0) FROM UserPins;
DBCC CHECKIDENT ('UserPins', RESEED, @up);

DECLARE @cl INT; SELECT @cl = ISNULL(MAX(CommentLikeId),  0) FROM CommentLikes;
DBCC CHECKIDENT ('CommentLikes', RESEED, @cl);

GO

-- ── STEP 7: Verify ────────────────────────────────────────────

SELECT 'Announcements'  AS [Table], MIN(AnnouncementId) AS MinId, MAX(AnnouncementId) AS MaxId, COUNT(*) AS [Rows] FROM Announcements
UNION ALL
SELECT 'Comments',       MIN(CommentId),      MAX(CommentId),      COUNT(*) FROM Comments
UNION ALL
SELECT 'UserLikes',      MIN(LikeId),         MAX(LikeId),         COUNT(*) FROM UserLikes
UNION ALL
SELECT 'Notifications',  MIN(NotificationId), MAX(NotificationId), COUNT(*) FROM Notifications
UNION ALL
SELECT 'UserPins',       MIN(UserPinId),      MAX(UserPinId),      COUNT(*) FROM UserPins
UNION ALL
SELECT 'CommentLikes',   MIN(CommentLikeId),  MAX(CommentLikeId),  COUNT(*) FROM CommentLikes;

-- Cleanup
DROP TABLE #TAnnouncements;
DROP TABLE #TComments;
DROP TABLE #TUserLikes;
DROP TABLE #TNotifications;
DROP TABLE #TUserPins;
DROP TABLE #TCommentLikes;

PRINT 'Done — all PKs are now 1, 2, 3...';
GO
