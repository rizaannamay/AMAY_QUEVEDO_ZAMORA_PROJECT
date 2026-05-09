-- ============================================================
-- AdminMigration.sql
-- Run this script ONCE to upgrade the CAPdb schema for all
-- new features: Teacher role, approval workflow, themes,
-- calendar events, announcement approval, login attempts.
-- ============================================================

USE CAPdb;
GO

-- ── 1. Add Teacher role to Users CHECK constraint ────────────
-- Drop old constraint and recreate with Teacher included
ALTER TABLE Users DROP CONSTRAINT IF EXISTS CK__Users__Role__XXXXXX;
GO
-- Find and drop the role check constraint dynamically
DECLARE @cn NVARCHAR(200);
SELECT @cn = name FROM sys.check_constraints
WHERE parent_object_id = OBJECT_ID('Users') AND definition LIKE '%Role%';
IF @cn IS NOT NULL
    EXEC('ALTER TABLE Users DROP CONSTRAINT [' + @cn + ']');
GO

ALTER TABLE Users ADD CONSTRAINT CK_Users_Role
    CHECK (Role IN ('Student', 'Teacher', 'Admin'));
GO

-- ── 2. Add AccountStatus column to Users ─────────────────────
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('Users') AND name = 'AccountStatus')
    ALTER TABLE Users ADD AccountStatus NVARCHAR(20) NOT NULL DEFAULT 'Active'
        CONSTRAINT CK_Users_AccountStatus CHECK (AccountStatus IN ('Active','Pending','Suspended','Rejected'));
GO

-- Set existing Teachers (if any) to Active, new Teachers default to Pending
-- (handled in application code)

-- ── 3. Add Status column to Announcements ────────────────────
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('Announcements') AND name = 'Status')
    ALTER TABLE Announcements ADD Status NVARCHAR(20) NOT NULL DEFAULT 'Approved';
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('Announcements') AND name = 'RejectionReason')
    ALTER TABLE Announcements ADD RejectionReason NVARCHAR(500) NULL;
GO

-- Admin-posted announcements stay Approved; Teacher posts default to Pending
-- (handled in application code on insert)

-- ── 4. SiteSettings table (theme + other global settings) ────
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'SiteSettings')
BEGIN
    CREATE TABLE SiteSettings (
        SettingKey   NVARCHAR(100) PRIMARY KEY,
        SettingValue NVARCHAR(500) NOT NULL,
        UpdatedDate  DATETIME      NOT NULL DEFAULT GETDATE()
    );
    -- Default theme
    INSERT INTO SiteSettings (SettingKey, SettingValue) VALUES ('ActiveTheme', 'Default');
END
GO

-- ── 5. CalendarEvents table ───────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'CalendarEvents')
BEGIN
    CREATE TABLE CalendarEvents (
        EventId     INT           PRIMARY KEY IDENTITY(1,1),
        UserId      INT           NOT NULL REFERENCES Users(UserId),
        Title       NVARCHAR(200) NOT NULL,
        Description NVARCHAR(MAX) NULL,
        EventDate   DATE          NOT NULL,
        EventTime   TIME          NULL,
        EventType   NVARCHAR(50)  NOT NULL DEFAULT 'General'
            CONSTRAINT CK_CalendarEvents_Type CHECK (EventType IN ('Exam','Deadline','Reminder','Quiz','Event','General')),
        IsPublic    BIT           NOT NULL DEFAULT 0,
        CreatedDate DATETIME      NOT NULL DEFAULT GETDATE()
    );
END
GO

-- ── 6. LoginAttempts table (brute-force protection) ──────────
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'CalendarEvents')
AND NOT EXISTS (
    SELECT 1
    FROM sys.columns
    WHERE object_id = OBJECT_ID('CalendarEvents')
      AND name = 'EventTime'
)
BEGIN
    ALTER TABLE CalendarEvents ADD EventTime TIME NULL;
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'LoginAttempts')
BEGIN
    CREATE TABLE LoginAttempts (
        AttemptId   INT           PRIMARY KEY IDENTITY(1,1),
        Username    NVARCHAR(50)  NOT NULL,
        IpAddress   NVARCHAR(50)  NULL,
        AttemptTime DATETIME      NOT NULL DEFAULT GETDATE(),
        Success     BIT           NOT NULL DEFAULT 0
    );
END
GO

-- ── 7. EmailVerification table ────────────────────────────────
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'EmailVerification')
BEGIN
    CREATE TABLE EmailVerification (
        VerificationId INT           PRIMARY KEY IDENTITY(1,1),
        UserId         INT           NOT NULL REFERENCES Users(UserId) ON DELETE CASCADE,
        Token          NVARCHAR(100) NOT NULL,
        ExpiresAt      DATETIME      NOT NULL,
        IsUsed         BIT           NOT NULL DEFAULT 0,
        CreatedDate    DATETIME      NOT NULL DEFAULT GETDATE()
    );
END
GO

-- ── 8. Add IsEmailVerified to Users ──────────────────────────
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id = OBJECT_ID('Users') AND name = 'IsEmailVerified')
    ALTER TABLE Users ADD IsEmailVerified BIT NOT NULL DEFAULT 0;
GO

-- Mark all existing users as verified (backward compat)
UPDATE Users SET IsEmailVerified = 1 WHERE IsEmailVerified = 0;
GO

PRINT 'Migration complete.';
GO
