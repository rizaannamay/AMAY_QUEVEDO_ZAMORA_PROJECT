-- Migration: Add ReminderSent5Min column to CalendarEvents.
-- Safe to run multiple times (idempotent).

IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID(N'CalendarEvents') AND name = N'ReminderSent5Min'
)
BEGIN
    ALTER TABLE CalendarEvents
        ADD ReminderSent5Min BIT NOT NULL DEFAULT 0;
    PRINT 'ReminderSent5Min column added to CalendarEvents.';
END
ELSE
BEGIN
    PRINT 'ReminderSent5Min column already exists — no changes made.';
END
GO
