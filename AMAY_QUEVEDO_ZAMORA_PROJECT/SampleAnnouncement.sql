USE CAPdb;
GO

-- ── Insert one sample announcement per category ───────────────────────────────
-- Uses the first Admin user found in the database
DECLARE @AdminId INT;
SELECT TOP 1 @AdminId = UserId FROM Users WHERE Role = 'Admin' ORDER BY UserId;

IF @AdminId IS NULL
BEGIN
    PRINT 'No Admin user found. Please register an Admin account first.';
END
ELSE
BEGIN

    -- ── 1. General ────────────────────────────────────────────────────────────
    INSERT INTO Announcements (UserId, Title, Content, Category, ImageUrl, IsPinned)
    VALUES (
        @AdminId,
        N'Welcome to Campus Connect!',
        N'Good day, everyone! Welcome to the official Campus Connect Announcement Portal of Cebu Technological University. '
        + N'This platform is your go-to source for all campus updates — from exam schedules and class suspensions to events and general announcements. '
        + N'Stay connected, stay informed, and make the most of your academic journey. '
        + N'For concerns or suggestions, please reach out to your respective department. God bless and have a productive semester!',
        N'General',
        NULL,
        1   -- Pinned so it appears at the top
    );

    -- ── 2. Exam ───────────────────────────────────────────────────────────────
    INSERT INTO Announcements (UserId, Title, Content, Category, ImageUrl, IsPinned)
    VALUES (
        @AdminId,
        N'Midterm Examination Schedule — 2nd Semester AY 2025–2026',
        N'The Midterm Examinations for the 2nd Semester of Academic Year 2025–2026 will be held from '
        + N'May 12–16, 2026. All students are required to present their examination permits before entering the examination room. '
        + N'No permit, no exam. Please coordinate with your respective department heads for room assignments. '
        + N'Review your schedules carefully and prepare accordingly. Good luck to all!',
        N'Exam',
        NULL,
        0
    );

    -- ── 3. Suspension ─────────────────────────────────────────────────────────
    INSERT INTO Announcements (UserId, Title, Content, Category, ImageUrl, IsPinned)
    VALUES (
        @AdminId,
        N'Class Suspension — May 2, 2026 (Signal No. 1)',
        N'Due to Tropical Storm "Amang" raising Signal No. 1 over the province, '
        + N'all classes in Cebu Technological University — Main Campus are SUSPENDED on May 2, 2026. '
        + N'This applies to all year levels, both undergraduate and graduate programs. '
        + N'Online classes may proceed at the discretion of the instructor. '
        + N'Please monitor official CTU channels for further updates. Stay safe everyone!',
        N'Suspension',
        NULL,
        0
    );

    -- ── 4. Event ──────────────────────────────────────────────────────────────
    INSERT INTO Announcements (UserId, Title, Content, Category, ImageUrl, IsPinned)
    VALUES (
        @AdminId,
        N'CTU Cultural Festival 2026 — "Kultura at Pagkakaisa"',
        N'We are thrilled to invite all students, faculty, and staff to the CTU Cultural Festival 2026 '
        + N'themed "Kultura at Pagkakaisa" (Culture and Unity). '
        + N'The event will be held on May 20–21, 2026 at the CTU Main Campus Gymnasium and Grounds. '
        + N'Highlights include: cultural dance competitions, art exhibits, food fair, live performances, '
        + N'and the crowning of the Festival Queen and King. '
        + N'Admission is FREE for all CTU students with valid school ID. See you there!',
        N'Event',
        NULL,
        0
    );

    -- ── Notify all students about the new announcements ───────────────────────
    INSERT INTO Notifications (UserId, Message)
    SELECT UserId, N'New announcement: Welcome to Campus Connect!'
    FROM Users WHERE Role = 'Student';

    INSERT INTO Notifications (UserId, Message)
    SELECT UserId, N'New announcement: Midterm Examination Schedule — 2nd Semester AY 2025–2026'
    FROM Users WHERE Role = 'Student';

    INSERT INTO Notifications (UserId, Message)
    SELECT UserId, N'New announcement: Class Suspension — May 2, 2026'
    FROM Users WHERE Role = 'Student';

    INSERT INTO Notifications (UserId, Message)
    SELECT UserId, N'New announcement: CTU Cultural Festival 2026'
    FROM Users WHERE Role = 'Student';

    PRINT 'Sample announcements inserted successfully! (General, Exam, Suspension, Event)';
END
GO
