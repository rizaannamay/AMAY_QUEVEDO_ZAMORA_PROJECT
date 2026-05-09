-- Migration: Create CalendarEvents table (if missing) and add ReminderSent column.
-- Safe to run multiple times (fully idempotent).

-- Step 1: Create CalendarEvents if it doesn't exist yet
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
    PRINT 'CalendarEvents table created.';
END
ELSE
BEGIN
    PRINT 'CalendarEvents table already exists.';
END
GO

-- Step 2: Add ReminderSent column if it doesn't exist yet
IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID(N'CalendarEvents') AND name = N'ReminderSent'
)
BEGIN
    ALTER TABLE CalendarEvents
        ADD ReminderSent BIT NOT NULL DEFAULT 0;
    PRINT 'ReminderSent column added to CalendarEvents.';
END
ELSE
BEGIN
    PRINT 'ReminderSent column already exists — no changes made.';
END
GO
