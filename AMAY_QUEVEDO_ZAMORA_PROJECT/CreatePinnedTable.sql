-- Run this once against CAPdb to enable per-user student pins
USE CAPdb;
GO

IF NOT EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'UserPins'
)
BEGIN
    CREATE TABLE UserPins (
        UserPinId      INT      PRIMARY KEY IDENTITY(1,1),
        UserId         INT      NOT NULL REFERENCES Users(UserId) ON DELETE CASCADE,
        AnnouncementId INT      NOT NULL REFERENCES Announcements(AnnouncementId) ON DELETE CASCADE,
        CreatedDate    DATETIME NOT NULL DEFAULT GETDATE(),
        UNIQUE (UserId, AnnouncementId)   -- one pin per user per post
    );
    PRINT 'UserPins table created.';
END
ELSE
BEGIN
    PRINT 'UserPins table already exists.';
END
GO
