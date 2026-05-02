USE CAPdb;
GO

-- Add ParentCommentId for replies (NULL = top-level comment)
IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('Comments') AND name = 'ParentCommentId'
)
BEGIN
    ALTER TABLE Comments ADD ParentCommentId INT NULL REFERENCES Comments(CommentId);
END
GO

-- Add LikeCount on comments
IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('Comments') AND name = 'LikeCount'
)
BEGIN
    ALTER TABLE Comments ADD LikeCount INT NOT NULL DEFAULT 0;
END
GO

-- Table to track who liked which comment
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'CommentLikes' AND type = 'U')
BEGIN
    CREATE TABLE CommentLikes (
        CommentLikeId INT      PRIMARY KEY IDENTITY(1,1),
        CommentId     INT      NOT NULL REFERENCES Comments(CommentId) ON DELETE CASCADE,
        UserId        INT      NOT NULL REFERENCES Users(UserId),
        CreatedDate   DATETIME NOT NULL DEFAULT GETDATE(),
        UNIQUE (CommentId, UserId)
    );
END
GO
