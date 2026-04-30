-- ============================================================
--  Password Migration Script
--  Converts existing plain-text passwords to SHA-256 hashes
--  Run this ONCE in SSMS after deploying the hashing update
-- ============================================================

USE CAPdb;
GO

-- SQL Server's HASHBYTES with SHA2_256 produces the same result
-- as C#'s SHA256.ComputeHash(Encoding.UTF8.GetBytes(password))
-- converted to lowercase hex.

-- Preview what will change (run this first to verify)
SELECT
    UserId,
    Username,
    Password                                          AS PlainText,
    LOWER(CONVERT(NVARCHAR(64),
        HASHBYTES('SHA2_256', CONVERT(VARBINARY, Password)),
        2))                                           AS SHA256Hash
FROM Users
WHERE LEN(Password) <> 64;   -- 64 chars = already a SHA-256 hex string
GO

-- Apply the migration (uncomment and run after verifying the preview above)
/*
UPDATE Users
SET Password = LOWER(CONVERT(NVARCHAR(64),
                   HASHBYTES('SHA2_256', CONVERT(VARBINARY, Password)),
                   2))
WHERE LEN(Password) <> 64;

PRINT 'Password migration complete.';
*/
GO
