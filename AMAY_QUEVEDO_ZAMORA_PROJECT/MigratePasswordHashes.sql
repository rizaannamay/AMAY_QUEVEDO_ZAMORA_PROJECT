-- ============================================================
-- MigratePasswordHashes.sql
-- Run this ONCE in SSMS to hash all existing plain-text
-- passwords using SHA2_256 (matches the C# SHA-256 hex output).
--
-- After running this script, all new registrations (signin.aspx)
-- and logins (login.aspx) will use SHA-256 hashing automatically.
-- ============================================================

USE CAPdb;
GO

-- Convert every plain-text password to its SHA-256 hex string.
-- CONVERT(NVARCHAR(64), HASHBYTES('SHA2_256', Password), 2)
-- produces the same lowercase hex string as the C# HashPassword() method.

UPDATE Users
SET Password = LOWER(CONVERT(NVARCHAR(64), HASHBYTES('SHA2_256', Password), 2))
WHERE LEN(Password) <> 64   -- skip rows already hashed (SHA-256 hex = 64 chars)
   OR Password NOT LIKE '%[^0-9a-f]%' = 0;  -- skip if already looks like a hex hash
GO

-- Verify: all passwords should now be exactly 64 hex characters
SELECT UserId, Username, LEN(Password) AS PwdLen, Password
FROM Users
ORDER BY UserId;
GO
