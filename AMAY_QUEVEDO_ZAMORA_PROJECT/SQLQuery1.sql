CREATE TABLE Users (
        UserId INT PRIMARY KEY IDENTITY(1,1),
        FullName NVARCHAR(100) NOT NULL,
        Email NVARCHAR(100) NOT NULL UNIQUE,
        Username NVARCHAR(50) NOT NULL UNIQUE,
        Password NVARCHAR(255) NOT NULL,
        Role NVARCHAR(20) NOT NULL CHECK (Role IN ('Student', 'Admin')),
        IsActive BIT DEFAULT 1,
        CreatedDate DATETIME DEFAULT GETDATE(),
        LastLoginDate DATETIME NULL,
        ProfileImage NVARCHAR(500) NULL
    );