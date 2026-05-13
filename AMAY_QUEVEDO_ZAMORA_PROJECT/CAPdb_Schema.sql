-- ============================================================
-- CAPdb_Schema.sql  –  Complete Database Schema
-- Campus Announcement Portal (CAPdb)
-- Includes all tables + all migration columns
-- ============================================================

USE CAPdb;
GO

-- ── 1. USERS ─────────────────────────────────────────────────
--   Stores all portal users: Students, Teachers, and Admins.
CREATE TABLE Users (
    UserId          INT           PRIMARY KEY IDENTITY(1,1),
    FullName        NVARCHAR(100) NOT NULL,
    Email           NVARCHAR(100) NOT NULL UNIQUE,
    Username        NVARCHAR(50)  NOT NULL UNIQUE,
    Password        NVARCHAR(255) NOT NULL,                        -- SHA-256 hash
    Role            NVARCHAR(20)  NOT NULL
        CONSTRAINT CK_Users_Role
        CHECK (Role IN ('Student', 'Teacher', 'Admin')),
    AccountStatus   NVARCHAR(20)  NOT NULL DEFAULT 'Active'
        CONSTRAINT CK_Users_AccountStatus
        CHECK (AccountStatus IN ('Active', 'Pending', 'Suspended', 'Rejected')),
    IsEmailVerified BIT           NOT NULL DEFAULT 1,
    ProfileImage    NVARCHAR(MAX) NULL,
    CreatedDate     DATETIME      NOT NULL DEFAULT GETDATE()
);
GO

-- ── 2. ANNOUNCEMENTS ─────────────────────────────────────────
--   Posts created by Teachers (require approval) or Admins (auto-approved).
CREATE TABLE Announcements (
    AnnouncementId  INT           PRIMARY KEY IDENTITY(1,1),
    UserId          INT           NOT NULL REFERENCES Users(UserId),
    Title           NVARCHAR(200) NOT NULL,
    Content         NVARCHAR(MAX) NOT NULL,
    ImageUrl        NVARCHAR(MAX) NULL,                            -- supports multiple URLs
    Category        NVARCHAR(50)  NOT NULL DEFAULT 'General',
    Status          NVARCHAR(20)  NOT NULL DEFAULT 'Approved'
        CONSTRAINT CK_Announcements_Status
        CHECK (Status IN ('Pending', 'Approved', 'Rejected')),
    RejectionReason NVARCHAR(500) NULL,
    Date_Posted     DATETIME      NOT NULL DEFAULT GETDATE(),
    LikeCount       INT           NOT NULL DEFAULT 0,
    CommentCount    INT           NOT NULL DEFAULT 0,
    ShareCount      INT           NOT NULL DEFAULT 0,
    IsPinned        BIT           NOT NULL DEFAULT 0               -- global admin pin
);
GO

-- ── 3. COMMENTS ──────────────────────────────────────────────
--   Threaded comments on announcements (ParentCommentId enables replies).
CREATE TABLE Comments (
    CommentId       INT           PRIMARY KEY IDENTITY(1,1),
    AnnouncementId  INT           NOT NULL REFERENCES Announcements(AnnouncementId) ON DELETE CASCADE,
    UserId          INT           NOT NULL REFERENCES Users(UserId),
    ParentCommentId INT           NULL REFERENCES Comments(CommentId),  -- NULL = top-level
    CommentText     NVARCHAR(MAX) NOT NULL,
    CreatedDate     DATETIME      NOT NULL DEFAULT GETDATE()
);
GO

-- ── 4. USERLIKES ─────────────────────────────────────────────
--   Tracks which users liked which announcements (one like per user per post).
CREATE TABLE UserLikes (
    LikeId          INT      PRIMARY KEY IDENTITY(1,1),
    AnnouncementId  INT      NOT NULL REFERENCES Announcements(AnnouncementId) ON DELETE CASCADE,
    UserId          INT      NOT NULL REFERENCES Users(UserId),
    CreatedDate     DATETIME NOT NULL DEFAULT GETDATE(),
    UNIQUE (AnnouncementId, UserId)
);
GO

-- ── 5. COMMENTLIKES ──────────────────────────────────────────
--   Tracks which users liked which comments (one like per user per comment).
CREATE TABLE CommentLikes (
    CommentLikeId   INT      PRIMARY KEY IDENTITY(1,1),
    CommentId       INT      NOT NULL REFERENCES Comments(CommentId) ON DELETE CASCADE,
    UserId          INT      NOT NULL REFERENCES Users(UserId),
    CreatedDate     DATETIME NOT NULL DEFAULT GETDATE(),
    UNIQUE (CommentId, UserId)
);
GO

-- ── 6. NOTIFICATIONS ─────────────────────────────────────────
--   In-app notifications sent to users (linked to an announcement when applicable).
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
--   Per-user personal pins on announcements (one pin per user per post).
CREATE TABLE UserPins (
    UserPinId       INT      PRIMARY KEY IDENTITY(1,1),
    UserId          INT      NOT NULL REFERENCES Users(UserId)          ON DELETE CASCADE,
    AnnouncementId  INT      NOT NULL REFERENCES Announcements(AnnouncementId) ON DELETE CASCADE,
    CreatedDate     DATETIME NOT NULL DEFAULT GETDATE(),
    UNIQUE (UserId, AnnouncementId)
);
GO

-- ── 8. SITESETTINGS ──────────────────────────────────────────
--   Key-value store for global site configuration (e.g. active theme).
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
--   Personal and public calendar events created by any user.
CREATE TABLE CalendarEvents (
    EventId          INT           PRIMARY KEY IDENTITY(1,1),
    UserId           INT           NOT NULL REFERENCES Users(UserId) ON DELETE CASCADE,
    Title            NVARCHAR(200) NOT NULL,
    Description      NVARCHAR(MAX) NULL,
    EventDate        DATE          NOT NULL,
    EventTime        TIME          NULL,
    EventType        NVARCHAR(50)  NOT NULL DEFAULT 'General'
        CONSTRAINT CK_CalendarEvents_Type
        CHECK (EventType IN ('Exam', 'Deadline', 'Reminder', 'Quiz', 'Event', 'General')),
    IsPublic         BIT           NOT NULL DEFAULT 1,
    CreatedDate      DATETIME      NOT NULL DEFAULT GETDATE(),
    ReminderSent     BIT           NOT NULL DEFAULT 0,             -- 1-day reminder fired
    ReminderSent5Min BIT           NOT NULL DEFAULT 0              -- 5-min reminder fired
);
GO

-- ── 10. LOGINATTEMPTS ────────────────────────────────────────
--   Logs every login attempt for brute-force protection.
CREATE TABLE LoginAttempts (
    AttemptId       INT           PRIMARY KEY IDENTITY(1,1),
    Username        NVARCHAR(50)  NOT NULL,
    IpAddress       NVARCHAR(50)  NULL,
    AttemptTime     DATETIME      NOT NULL DEFAULT GETDATE(),
    Success         BIT           NOT NULL DEFAULT 0
);
GO

-- ── 11. EMAILVERIFICATION ────────────────────────────────────
--   Tokens issued for email address verification on sign-up.
CREATE TABLE EmailVerification (
    VerificationId  INT           PRIMARY KEY IDENTITY(1,1),
    UserId          INT           NOT NULL REFERENCES Users(UserId) ON DELETE CASCADE,
    Token           NVARCHAR(100) NOT NULL,
    ExpiresAt       DATETIME      NOT NULL,
    IsUsed          BIT           NOT NULL DEFAULT 0,
    CreatedDate     DATETIME      NOT NULL DEFAULT GETDATE()
);
GO

-- ============================================================
-- DEFAULT ADMIN ACCOUNT
--   Username : admin
--   Password : Admin@2026  (SHA-256 hash stored below)
-- ============================================================
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

PRINT '============================================================';
PRINT 'CAPdb schema created successfully.';
PRINT 'Tables: Users, Announcements, Comments, UserLikes,';
PRINT '        CommentLikes, Notifications, UserPins,';
PRINT '        SiteSettings, CalendarEvents, LoginAttempts,';
PRINT '        EmailVerification';
PRINT 'Default admin -> Username: admin | Password: Admin@2026';
PRINT '============================================================';
GO
