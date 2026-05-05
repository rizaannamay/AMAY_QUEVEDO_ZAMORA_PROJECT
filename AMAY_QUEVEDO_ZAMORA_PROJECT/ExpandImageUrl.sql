-- Run this once to expand ImageUrl column for multiple media URLs
ALTER TABLE Announcements ALTER COLUMN ImageUrl NVARCHAR(MAX) NULL;
GO
