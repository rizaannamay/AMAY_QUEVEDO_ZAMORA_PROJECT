USE CAPdb;
GO

-- Add AnnouncementId column to Notifications (links a notification to a specific post)
IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('Notifications') AND name = 'AnnouncementId'
)
BEGIN
    ALTER TABLE Notifications
        ADD AnnouncementId INT NULL REFERENCES Announcements(AnnouncementId) ON DELETE SET NULL;
    PRINT 'AnnouncementId column added to Notifications.';
END
ELSE
BEGIN
    PRINT 'AnnouncementId column already exists in Notifications.';
END
GO
