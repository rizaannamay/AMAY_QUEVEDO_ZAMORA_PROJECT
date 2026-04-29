USE CAPdb;
GO

-- ── DTR (Daily Time Record) ───────────────────────────────────
CREATE TABLE DTR (
    DTRId       INT      PRIMARY KEY IDENTITY(1,1),
    UserId      INT      NOT NULL REFERENCES Users(UserId),
    TimeIn      DATETIME NOT NULL DEFAULT GETDATE(),
    TimeOut     DATETIME NULL,
    WorkDate    DATE     NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    Notes       NVARCHAR(300) NULL
);
GO

-- Index for fast per-user lookups
CREATE INDEX IX_DTR_UserId_WorkDate ON DTR (UserId, WorkDate DESC);
GO
