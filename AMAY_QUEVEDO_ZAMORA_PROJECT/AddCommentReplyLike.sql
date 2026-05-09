bjects WHERE name = 'CommentLikes' AND type = 'U')
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
