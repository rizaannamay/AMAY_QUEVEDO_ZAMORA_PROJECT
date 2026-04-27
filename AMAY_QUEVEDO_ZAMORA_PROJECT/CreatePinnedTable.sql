-- Check if Pinned table exists and create it if not
USE CAPdb;
GO

-- Check if table exists
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Pinned')
BEGIN
    -- Create Pinned table
    CREATE TABLE Pinned (
        PinId INT IDENTITY(1,1) PRIMARY KEY,
        UserId INT NOT NULL,
        AnnouncementId INT NOT NULL,
        CreatedDate DATETIME DEFAULT GETDATE(),
        CONSTRAINT FK_Pinned_User FOREIGN KEY (UserId) REFERENCES Users(UserId) ON DELETE CASCADE,
        CONSTRAINT FK_Pinned_Announcement FOREIGN KEY (AnnouncementId) REFERENCES Announcements(AnnouncementId) ON DELETE CASCADE,
        CONSTRAINT UQ_Pinned_UserAnnouncement UNIQUE (UserId, AnnouncementId)
    );
    
    PRINT 'Pinned table created successfully!';
END
ELSE
BEGIN
    PRINT 'Pinned table already exists.';
END
GO

-- Verify table structure
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Pinned'
ORDER BY ORDINAL_POSITION;
GO

-- Check if there are any pins
SELECT COUNT(*) AS TotalPins FROM Pinned;
GO
