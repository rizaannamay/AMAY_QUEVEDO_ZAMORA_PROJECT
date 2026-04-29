

USE CAPdb;
GO

-- ── 1. USERS ─────────────────────────────────────────────────
CREATE TABLE Users (
    UserId       INT           PRIMARY KEY IDENTITY(1,1),
    FullName     NVARCHAR(100) NOT NULL,
    Email        NVARCHAR(100) NOT NULL UNIQUE,
    Username     NVARCHAR(50)  NOT NULL UNIQUE,
    Password     NVARCHAR(255) NOT NULL,
    Role         NVARCHAR(20)  NOT NULL CHECK (Role IN ('Student', 'Admin')),
    CreatedDate  DATETIME      NOT NULL DEFAULT GETDATE(),
    ProfileImage NVARCHAR(MAX) NULL
);
GO

-- ── 2. ANNOUNCEMENTS ─────────────────────────────────────────
CREATE TABLE Announcements (
    AnnouncementId INT           PRIMARY KEY IDENTITY(1,1),
    UserId         INT           NOT NULL REFERENCES Users(UserId),
    Title          NVARCHAR(200) NOT NULL,
    Content        NVARCHAR(MAX) NOT NULL,
    ImageUrl       NVARCHAR(500) NULL,
    Category       NVARCHAR(50)  NOT NULL DEFAULT 'General',
    Date_Posted    DATETIME      NOT NULL DEFAULT GETDATE(),
    LikeCount      INT           NOT NULL DEFAULT 0,
    CommentCount   INT           NOT NULL DEFAULT 0,
    ShareCount     INT           NOT NULL DEFAULT 0,
    IsPinned       BIT           NOT NULL DEFAULT 0
);
GO

-- ── 3. COMMENTS ──────────────────────────────────────────────
CREATE TABLE Comments (
    CommentId      INT           PRIMARY KEY IDENTITY(1,1),
    AnnouncementId INT           NOT NULL REFERENCES Announcements(AnnouncementId),
    UserId         INT           NOT NULL REFERENCES Users(UserId),
    CommentText    NVARCHAR(MAX) NOT NULL,
    CreatedDate    DATETIME      NOT NULL DEFAULT GETDATE()
);
GO

-- ── 4. USERLIKES ─────────────────────────────────────────────
CREATE TABLE UserLikes (
    LikeId         INT      PRIMARY KEY IDENTITY(1,1),
    AnnouncementId INT      NOT NULL REFERENCES Announcements(AnnouncementId),
    UserId         INT      NOT NULL REFERENCES Users(UserId),
    CreatedDate    DATETIME NOT NULL DEFAULT GETDATE(),
    UNIQUE (AnnouncementId, UserId)   -- one like per user per post
);
GO

-- ── 5. NOTIFICATIONS ─────────────────────────────────────────
CREATE TABLE Notifications (
    NotificationId INT           PRIMARY KEY IDENTITY(1,1),
    UserId         INT           NOT NULL REFERENCES Users(UserId),
    Message        NVARCHAR(500) NOT NULL,
    IsRead         BIT           NOT NULL DEFAULT 0,
    CreatedDate    DATETIME      NOT NULL DEFAULT GETDATE()
);
GO



