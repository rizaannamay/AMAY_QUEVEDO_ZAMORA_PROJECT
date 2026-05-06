USE CAPdb;
GO

-- ── Fix CommentLikes identity seed ────────────────────────────────────────────
-- Reseeds to the current max ID so the next insert continues from there.

DECLARE @maxId INT;
SELECT @maxId = ISNULL(MAX(CommentLikeId), 0) FROM CommentLikes;
DBCC CHECKIDENT ('CommentLikes', RESEED, @maxId);
GO

-- ── Also reseed other tables in case they have the same issue ─────────────────
DECLARE @maxComment INT;
SELECT @maxComment = ISNULL(MAX(CommentId), 0) FROM Comments;
DBCC CHECKIDENT ('Comments', RESEED, @maxComment);
GO

DECLARE @maxAnnouncement INT;
SELECT @maxAnnouncement = ISNULL(MAX(AnnouncementId), 0) FROM Announcements;
DBCC CHECKIDENT ('Announcements', RESEED, @maxAnnouncement);
GO

DECLARE @maxUser INT;
SELECT @maxUser = ISNULL(MAX(UserId), 0) FROM Users;
DBCC CHECKIDENT ('Users', RESEED, @maxUser);
GO

DECLARE @maxNotif INT;
SELECT @maxNotif = ISNULL(MAX(NotificationId), 0) FROM Notifications;
DBCC CHECKIDENT ('Notifications', RESEED, @maxNotif);
GO

PRINT 'Identity seeds fixed.';
GO
