USE CAPdb;
GO

-- ── Insert one sample announcement using the first Admin user ─────────────────
DECLARE @AdminId INT;
SELECT TOP 1 @AdminId = UserId FROM Users WHERE Role = 'Admin' ORDER BY UserId;

IF @AdminId IS NULL
BEGIN
    PRINT 'No Admin user found. Please register an Admin account first.';
END
ELSE
BEGIN
    INSERT INTO Announcements
        (UserId, Title, Content, Category, ImageUrl, IsPinned)
    VALUES
    (
        @AdminId,
        N'Welcome to Campus Connect!',
        N'Good day, everyone! Welcome to the official Campus Connect Announcement Portal of Cebu Technological University. '
        + N'This platform is your go-to source for all campus updates — from exam schedules and class suspensions to events and general announcements. '
        + N'Stay connected, stay informed, and make the most of your academic journey. '
        + N'For concerns or suggestions, please reach out to your respective department. God bless and have a productive semester!',
        N'General',
        NULL,
        1   -- IsPinned = true so it appears at the top
    );

    -- Also notify all students
    INSERT INTO Notifications (UserId, Message)
    SELECT UserId, N'New announcement: Welcome to Campus Connect!'
    FROM Users
    WHERE Role = 'Student';

    PRINT 'Sample announcement inserted successfully!';
END
GO
