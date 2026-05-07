-- ── Admin Setup Migration ────────────────────────────────────────────────────
-- Run this once in SQL Server Management Studio against CAPdb

USE CAPdb;
GO

-- 1. Add Status column to Announcements (Pending / Approved / Rejected)
IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('Announcements') AND name = 'Status'
)
BEGIN
    ALTER TABLE Announcements
    ADD Status NVARCHAR(20) NOT NULL DEFAULT 'Approved';
    -- Existing posts default to Approved so nothing breaks
END
GO

-- 2. Add RejectionReason column for admin feedback
IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('Announcements') AND name = 'RejectionReason'
)
BEGIN
    ALTER TABLE Announcements
    ADD RejectionReason NVARCHAR(500) NULL;
END
GO

-- 3. Expand the Role CHECK constraint to allow 'SuperAdmin'
--    (Drop old constraint, add new one)
IF EXISTS (
    SELECT 1 FROM sys.check_constraints
    WHERE parent_object_id = OBJECT_ID('Users') AND name = 'CK__Users__Role__3A81B327'
)
    ALTER TABLE Users DROP CONSTRAINT CK__Users__Role__3A81B327;
GO

-- Find and drop any check constraint on Users.Role
DECLARE @cname NVARCHAR(200);
SELECT @cname = name FROM sys.check_constraints
WHERE parent_object_id = OBJECT_ID('Users')
  AND OBJECT_DEFINITION(object_id) LIKE '%Role%';
IF @cname IS NOT NULL
    EXEC('ALTER TABLE Users DROP CONSTRAINT [' + @cname + ']');
GO

ALTER TABLE Users
ADD CONSTRAINT CK_Users_Role
CHECK (Role IN ('Student', 'Admin', 'SuperAdmin'));
GO

-- 4. Insert a default SuperAdmin account (password: superadmin123)
--    SHA-256 of "superadmin123" = 9a6e8a...  use the app's HashPassword logic
--    For now insert plain text — the app will auto-upgrade on first login
IF NOT EXISTS (SELECT 1 FROM Users WHERE Role = 'SuperAdmin')
BEGIN
    INSERT INTO Users (FullName, Email, Username, Password, Role)
    VALUES ('Super Admin', 'superadmin@ctu.edu', 'superadmin', 'superadmin123', 'SuperAdmin');
END
GO
