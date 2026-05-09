-- ============================================================
-- TABLES_ONLY.sql
-- Run this INSIDE CampusAnnouncementPortalDB.
-- Creates all tables + default admin account.
-- ============================================================

USE CampusAnnouncementPortalDB;
GO

-- ── 1. USERS ─────────────────────────────────────────────────
CREATE TABLE Users (
    UserId          INT           PRIMARY KEY IDENTITY(1,1),
    FullName        NVARCHAR(100) NOT NULL,
    Email           NVARCHAR(100) NOT NULL UNIQUE,
    Username        NVARCHAR(50)  NOT NULL UNIQUE,
    Password        NVARCHAR(255) NOT NULL,
    Role            NVARCHAR(20)  NOT NULL
        CONSTRAINT CK_Users_Role
        CHECK (Role IN ('Student', 'Teacher', 'Admin')),
    AccountStatus   NVARCHAR(20)  NOT NULL DEFAULT 'Active'
        CONSTRAINT CK_Users_AccountStatus
        CHECK (AccountStatus IN ('Active','Pending','Suspended','Rejected')),
    IsEmailVerified BIT           NOT NULL DEFAULT 1,
    ProfileImage    NVARCHAR(MAX) NULL,
    CreatedDate     DATETIME      NOT NULL DEFAULT GETDATE()
);
GO

-- ── 2. ANNOUNCEMENTS ─────────────────────────────────────────
CREATE TABLE Announcements (
    AnnouncementId  INT           PRIMARY KEY IDENTITY(1,1),
    UserId          INT           NOT NULL REFERENCES Users(UserId),
    Title           NVARCHAR(200) NOT NULL,
    Content         NVARCHAR(MAX) NOT NULL,
    ImageUrl        NVARCHAR(MAX) NULL,
    Category        NVARCHAR(50)  NOT NULL DEFAULT 'General',
    Status          NVARCHAR(20)  NOT NULL DEFAULT 'Approved'
        CONSTRAINT CK_Announcements_Status
        CHECK (Status IN ('Pending','Approved','Rejected')),
    RejectionReason NVARCHAR(500) NULL,
    Date_Posted     DATETIME      NOT NULL DEFAULT GETDATE(),
    LikeCount       INT           NOT NULL DEFAULT 0,
    CommentCount    INT           NOT NULL DEFAULT 0,
    ShareCount      INT           NOT NULL DEFAULT 0,
    IsPinned        BIT           NOT NULL DEFAULT 0
);
GO

-- ── 3. COMMENTS ──────────────────────────────────────────────
CREATE TABLE Comments (
    CommentId       INT           PRIMARY KEY IDENTITY(1,1),
    AnnouncementId  INT           NOT NULL REFERENCES Announcements(AnnouncementId) ON DELETE CASCADE,
    UserId          INT           NOT NULL REFERENCES Users(UserId),
    ParentCommentId INT           NULL REFERENCES Comments(CommentId),
    CommentText     NVARCHAR(MAX) NOT NULL,
    CreatedDate     DATETIME      NOT NULL DEFAULT GETDATE()
);
GO

-- ── 4. USERLIKES ─────────────────────────────────────────────
CREATE TABLE UserLikes (
    LikeId          INT      PRIMARY KEY IDENTITY(1,1),
    AnnouncementId  INT      NOT NULL REFERENCES Announcements(AnnouncementId) ON DELETE CASCADE,
    UserId          INT      NOT NULL REFERENCES Users(UserId),
    CreatedDate     DATETIME NOT NULL DEFAULT GETDATE(),
    UNIQUE (AnnouncementId, UserId)
);
GO

-- ── 5. COMMENTLIKES ──────────────────────────────────────────
CREATE TABLE CommentLikes (
    CommentLikeId   INT      PRIMARY KEY IDENTITY(1,1),
    CommentId       INT      NOT NULL REFERENCES Comments(CommentId) ON DELETE CASCADE,
    UserId          INT      NOT NULL REFERENCES Users(UserId),
    CreatedDate     DATETIME NOT NULL DEFAULT GETDATE(),
    UNIQUE (CommentId, UserId)
);
GO

-- ── 6. NOTIFICATIONS ─────────────────────────────────────────
CREATE TABLE Notifications (
    NotificationId  INT           PRIMARY KEY IDENTITY(1,1),
    UserId          INT           NOT NULL REFERENCES Users(UserId) ON DELETE CASCADE,
    AnnouncementId  INT           NULL REFERENCES Announcements(AnnouncementId) ON DELETE SET NULL,
    Message         NVARCHAR(500) NOT NULL,
    IsRead          BIT           NOT NULL DEFAULT 0,
    CreatedDate     DATETIME      NOT NULL DEFAULT GETDATE()
);
GO

-- ── 7. USERPINS ──────────────────────────────────────────────
CREATE TABLE UserPins (
    UserPinId       INT      PRIMARY KEY IDENTITY(1,1),
    UserId          INT      NOT NULL REFERENCES Users(UserId) ON DELETE CASCADE,
    AnnouncementId  INT      NOT NULL REFERENCES Announcements(AnnouncementId) ON DELETE CASCADE,
    CreatedDate     DATETIME NOT NULL DEFAULT GETDATE(),
    UNIQUE (UserId, AnnouncementId)
);
GO

-- ── 8. SITESETTINGS ──────────────────────────────────────────
CREATE TABLE SiteSettings (
    SettingKey      NVARCHAR(100) PRIMARY KEY,
    SettingValue    NVARCHAR(500) NOT NULL,
    UpdatedDate     DATETIME      NOT NULL DEFAULT GETDATE()
);
GO

INSERT INTO SiteSettings (SettingKey, SettingValue)
VALUES ('ActiveTheme', 'Default');
GO

-- ── 9. CALENDAREVENTS ────────────────────────────────────────
CREATE TABLE CalendarEvents (
    EventId         INT           PRIMARY KEY IDENTITY(1,1),
    UserId          INT           NOT NULL REFERENCES Users(UserId) ON DELETE CASCADE,
    Title           NVARCHAR(200) NOT NULL,
    Description     NVARCHAR(MAX) NULL,
    EventDate       DATE          NOT NULL,
    EventTime       TIME          NULL,
    EventType       NVARCHAR(50)  NOT NULL DEFAULT 'General'
        CONSTRAINT CK_CalendarEvents_Type
        CHECK (EventType IN ('Exam','Deadline','Reminder','Quiz','Event','General')),
    IsPublic        BIT           NOT NULL DEFAULT 1,
    CreatedDate     DATETIME      NOT NULL DEFAULT GETDATE()
);
GO

-- ── 10. LOGINATTEMPTS ────────────────────────────────────────
CREATE TABLE LoginAttempts (
    AttemptId       INT           PRIMARY KEY IDENTITY(1,1),
    Username        NVARCHAR(50)  NOT NULL,
    IpAddress       NVARCHAR(50)  NULL,
    AttemptTime     DATETIME      NOT NULL DEFAULT GETDATE(),
    Success         BIT           NOT NULL DEFAULT 0
);
GO

-- ── 11. EMAILVERIFICATION ────────────────────────────────────
CREATE TABLE EmailVerification (
    VerificationId  INT           PRIMARY KEY IDENTITY(1,1),
    UserId          INT           NOT NULL REFERENCES Users(UserId) ON DELETE CASCADE,
    Token           NVARCHAR(100) NOT NULL,
    ExpiresAt       DATETIME      NOT NULL,
    IsUsed          BIT           NOT NULL DEFAULT 0,
    CreatedDate     DATETIME      NOT NULL DEFAULT GETDATE()
);
GO

-- ── 12. DEFAULT ADMIN ACCOUNT ────────────────────────────────
-- Username : admin
-- Password : Admin@2026  (SHA-256 hash)
INSERT INTO Users (FullName, Email, Username, Password, Role, AccountStatus, IsEmailVerified)
VALUES (
    'System Administrator',
    'admin@ctu.edu.ph',
    'admin',
    'a36aef5a11c4073fbe60314fc9df530a9d5f986533594d1f5190742ff9e0e408',
    'Admin',
    'Active',
    1
);
GO

PRINT 'All tables created successfully.';
PRINT 'Default admin -> Username: admin | Password: Admin@2026';
GO
