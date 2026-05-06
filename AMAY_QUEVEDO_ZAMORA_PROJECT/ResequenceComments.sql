USE CAPdb;
GO

-- ══════════════════════════════════════════════════════════════
-- STEP 1: Save comments with new sequential IDs
-- ══════════════════════════════════════════════════════════════
IF OBJECT_ID('tempdb..#TempComments') IS NOT NULL DROP TABLE #TempComments;

SELECT
    ROW_NUMBER() OVER (ORDER BY CreatedDate ASC) AS NewCommentId,
    CommentId                                     AS OldCommentId,
    AnnouncementId,
    UserId,
    CommentText,
    ParentCommentId                               AS OldParentId,
    CAST(NULL AS INT)                             AS NewParentId,
    ISNULL(LikeCount, 0)                          AS LikeCount,
    CreatedDate
INTO #TempComments
FROM Comments;
GO

-- ══════════════════════════════════════════════════════════════
-- STEP 2: Remap ParentCommentId to new IDs
-- ══════════════════════════════════════════════════════════════
UPDATE t
SET t.NewParentId = p.NewCommentId
FROM #TempComments t
JOIN #TempComments p ON p.OldCommentId = t.OldParentId;
GO

-- ══════════════════════════════════════════════════════════════
-- STEP 3: Save CommentLikes with remapped CommentIds
-- ══════════════════════════════════════════════════════════════
IF OBJECT_ID('tempdb..#TempLikes') IS NOT NULL DROP TABLE #TempLikes;

SELECT
    ROW_NUMBER() OVER (ORDER BY cl.CreatedDate ASC) AS NewLikeId,
    t.NewCommentId AS NewCommentId,
    cl.UserId,
    cl.CreatedDate
INTO #TempLikes
FROM CommentLikes cl
JOIN #TempComments t ON t.OldCommentId = cl.CommentId;
GO

-- ══════════════════════════════════════════════════════════════
-- STEP 4: Delete child rows first, then parent
-- ══════════════════════════════════════════════════════════════
DELETE FROM CommentLikes;
DELETE FROM Comments;
GO

-- ══════════════════════════════════════════════════════════════
-- STEP 5: Reset identity seeds
-- ══════════════════════════════════════════════════════════════
DBCC CHECKIDENT ('Comments',     RESEED, 0);
DBCC CHECKIDENT ('CommentLikes', RESEED, 0);
GO

-- ══════════════════════════════════════════════════════════════
-- STEP 6: Reinsert Comments with forced sequential IDs
-- ══════════════════════════════════════════════════════════════
SET IDENTITY_INSERT Comments ON;

INSERT INTO Comments (CommentId, AnnouncementId, UserId, CommentText, ParentCommentId, LikeCount, CreatedDate)
SELECT NewCommentId, AnnouncementId, UserId, CommentText, NewParentId, LikeCount, CreatedDate
FROM #TempComments
ORDER BY NewCommentId ASC;

SET IDENTITY_INSERT Comments OFF;
GO

-- ══════════════════════════════════════════════════════════════
-- STEP 7: Reinsert CommentLikes with forced sequential IDs
-- ══════════════════════════════════════════════════════════════
SET IDENTITY_INSERT CommentLikes ON;

INSERT INTO CommentLikes (CommentLikeId, CommentId, UserId, CreatedDate)
SELECT NewLikeId, NewCommentId, UserId, CreatedDate
FROM #TempLikes
ORDER BY NewLikeId ASC;

SET IDENTITY_INSERT CommentLikes OFF;
GO

-- ══════════════════════════════════════════════════════════════
-- STEP 8: Reseed to current max so next inserts continue cleanly
-- ══════════════════════════════════════════════════════════════
DECLARE @maxC  INT; SELECT @maxC  = ISNULL(MAX(CommentId),     0) FROM Comments;
DBCC CHECKIDENT ('Comments', RESEED, @maxC);

DECLARE @maxCL INT; SELECT @maxCL = ISNULL(MAX(CommentLikeId), 0) FROM CommentLikes;
DBCC CHECKIDENT ('CommentLikes', RESEED, @maxCL);
GO

-- ══════════════════════════════════════════════════════════════
-- STEP 9: Verify results
-- ══════════════════════════════════════════════════════════════
SELECT * FROM Comments     ORDER BY CommentId;
SELECT * FROM CommentLikes ORDER BY CommentLikeId;

DROP TABLE #TempComments;
DROP TABLE #TempLikes;
GO
