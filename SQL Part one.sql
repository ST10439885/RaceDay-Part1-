-- =====================================================
-- RaceDay Database Schema
-- PROG6212: Part 1
-- Author:ST10439885
-- Date: 2026-09-03
-- =====================================================

USE master;
GO

-- Drop database if exists (for clean testing)
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'RaceDayDB')
BEGIN
    ALTER DATABASE RaceDayDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE RaceDayDB;
END
GO

CREATE DATABASE RaceDayDB;
GO

USE RaceDayDB;
GO

-- =====================================================
-- 1. ROLES TABLE
-- =====================================================
CREATE TABLE Roles (
    RoleId      INT IDENTITY(1,1) PRIMARY KEY,
    RoleName    VARCHAR(50) NOT NULL UNIQUE
);
GO

-- =====================================================
-- 2. USERS TABLE
-- =====================================================
CREATE TABLE Users (
    UserId          INT IDENTITY(1,1) PRIMARY KEY,
    RoleId          INT NOT NULL,
    Email           VARCHAR(255) NOT NULL UNIQUE,
    PasswordHash    VARCHAR(255) NOT NULL,
    FirstName       VARCHAR(100) NOT NULL,
    LastName        VARCHAR(100) NOT NULL,
    PhoneNumber     VARCHAR(20),
    CreatedAt       DATETIME DEFAULT GETDATE(),
    
    CONSTRAINT FK_Users_Roles FOREIGN KEY (RoleId) REFERENCES Roles(RoleId)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT CHK_User_Email CHECK (Email LIKE '%_@__%.__%')
);
GO

CREATE INDEX IX_Users_Email ON Users(Email);
GO

-- =====================================================
-- 3. EVENTS TABLE
-- =====================================================
CREATE TABLE Events (
    EventId         INT IDENTITY(1,1) PRIMARY KEY,
    OrganiserId     INT NOT NULL,
    EventName       VARCHAR(255) NOT NULL,
    Description     TEXT,
    EventDate       DATETIME NOT NULL,
    Location        VARCHAR(255) NOT NULL,
    DistanceKm      DECIMAL(5,2),
    EventType       VARCHAR(20) NOT NULL,
    CreatedAt       DATETIME DEFAULT GETDATE(),
    
    CONSTRAINT FK_Events_Users FOREIGN KEY (OrganiserId) REFERENCES Users(UserId)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT CHK_EventType CHECK (EventType IN ('Run', 'Walk', 'Cycle'))
);
GO

CREATE INDEX IX_Events_EventDate ON Events(EventDate);
GO

-- =====================================================
-- 4. CATEGORIES TABLE
-- =====================================================
CREATE TABLE Categories (
    CategoryId      INT IDENTITY(1,1) PRIMARY KEY,
    EventId         INT NOT NULL,
    CategoryName    VARCHAR(100) NOT NULL,
    Description     VARCHAR(255),
    MinAge          INT,
    MaxAge          INT,
    Distance        DECIMAL(5,2),
    
    CONSTRAINT FK_Categories_Events FOREIGN KEY (EventId) REFERENCES Events(EventId)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT CHK_AgeRange CHECK (MinAge IS NULL OR MaxAge IS NULL OR MinAge <= MaxAge)
);
GO

-- =====================================================
-- 5. ENROLMENTS TABLE
-- =====================================================
CREATE TABLE Enrolments (
    EnrolmentId     INT IDENTITY(1,1) PRIMARY KEY,
    ParticipantId   INT NOT NULL,
    EventId         INT NOT NULL,
    CategoryId      INT NOT NULL,
    EnrolmentDate   DATETIME DEFAULT GETDATE(),
    Status          VARCHAR(20) DEFAULT 'Pending',
    
    CONSTRAINT FK_Enrolments_Users FOREIGN KEY (ParticipantId) REFERENCES Users(UserId),
    CONSTRAINT FK_Enrolments_Events FOREIGN KEY (EventId) REFERENCES Events(EventId),
    CONSTRAINT FK_Enrolments_Categories FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId),
    CONSTRAINT CHK_Status CHECK (Status IN ('Pending', 'Confirmed', 'Cancelled')),
    CONSTRAINT UQ_Enrolment UNIQUE (ParticipantId, EventId)
);
GO

CREATE INDEX IX_Enrolments_Participant ON Enrolments(ParticipantId);
CREATE INDEX IX_Enrolments_Event ON Enrolments(EventId);
GO

-- =====================================================
-- 6. RESULTS TABLE
-- =====================================================
CREATE TABLE Results (
    ResultId        INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentId     INT NOT NULL UNIQUE,
    FinishTime      TIME NOT NULL,
    Position        INT,
    RecordedAt      DATETIME DEFAULT GETDATE(),
    
    CONSTRAINT FK_Results_Enrolments FOREIGN KEY (EnrolmentId) REFERENCES Enrolments(EnrolmentId)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT CHK_Position CHECK (Position > 0)
);
GO

-- =====================================================
-- SEED DATA
-- =====================================================

-- Insert Roles
INSERT INTO Roles (RoleName) VALUES 
    ('Organiser'),
    ('Participant');
GO

-- Insert Organisers (UserId 1 and 2)
INSERT INTO Users (RoleId, Email, PasswordHash, FirstName, LastName, PhoneNumber) VALUES
    (1, 'sarah.mokoena@raceday.co.za', '$2a$10$hashedpasswordplaceholder1', 'Sarah', 'Mokoena', '0821234567'),
    (1, 'james.peterson@raceday.co.za', '$2a$10$hashedpasswordplaceholder2', 'James', 'Peterson', '0839876543');
GO

-- Insert Participants (UserId 3 and 4)
INSERT INTO Users (RoleId, Email, PasswordHash, FirstName, LastName, PhoneNumber) VALUES
    (2, 'thabo.ndlovu@gmail.com', '$2a$10$hashedpasswordplaceholder3', 'Thabo', 'Ndlovu', '0712345678'),
    (2, 'lisa.vanwyk@yahoo.com', '$2a$10$hashedpasswordplaceholder4', 'Lisa', 'Van Wyk', '0728765432');
GO

-- Insert Events (EventId 1, 2, 3)
INSERT INTO Events (OrganiserId, EventName, Description, EventDate, Location, DistanceKm, EventType) VALUES
    (1, 'Soweto Marathon 2026', 'The iconic 42.2km road race through the streets of Soweto, celebrating community and endurance.', '2026-11-15 06:00:00', 'Soweto, Johannesburg', 42.20, 'Run'),
    (1, 'Cape Town Cycle Tour 2027', 'The largest timed cycling event in the world, circling the Cape Peninsula.', '2027-03-08 06:00:00', 'Cape Town City Centre', 109.00, 'Cycle'),
    (2, 'Durban Beachfront Parkrun', 'A free weekly 5km timed run along the beautiful Durban beachfront promenade.', '2026-09-14 07:00:00', 'Durban Beachfront', 5.00, 'Run');
GO

-- Categories for Soweto Marathon (EventId = 1) -> CategoryId 1, 2, 3
INSERT INTO Categories (EventId, CategoryName, Description, MinAge, MaxAge, Distance) VALUES
    (1, 'Senior Men', 'Open category for male runners aged 20-34', 20, 34, 42.20),
    (1, 'Senior Women', 'Open category for female runners aged 20-34', 20, 34, 42.20),
    (1, 'Veteran Men', 'Male runners aged 35-49', 35, 49, 42.20);
GO

-- Categories for Cape Town Cycle Tour (EventId = 2) -> CategoryId 4, 5
INSERT INTO Categories (EventId, CategoryName, Description, MinAge, MaxAge, Distance) VALUES
    (2, 'Elite', 'Professional and elite amateur cyclists', 18, NULL, 109.00),
    (2, 'Social', 'Recreational cyclists riding at a social pace', 16, NULL, 109.00);
GO

-- Categories for Durban Parkrun (EventId = 3) -> CategoryId 6
INSERT INTO Categories (EventId, CategoryName, Description, MinAge, MaxAge, Distance) VALUES
    (3, 'Open', 'All ages welcome - fun run category', 4, NULL, 5.00);
GO

-- Insert Enrolments (EnrolmentId 1, 2, 3, 4)
-- Enrolment 1: Thabo (User 3) -> Soweto Marathon (Event 1) -> Senior Men (Category 1)
-- Enrolment 2: Thabo (User 3) -> Durban Parkrun (Event 3) -> Open (Category 6)
-- Enrolment 3: Lisa (User 4) -> Cape Town Cycle Tour (Event 2) -> Elite (Category 4)
-- Enrolment 4: Lisa (User 4) -> Durban Parkrun (Event 3) -> Open (Category 6)
INSERT INTO Enrolments (ParticipantId, EventId, CategoryId, EnrolmentDate, Status) VALUES
    (3, 1, 1, '2026-08-20 10:30:00', 'Confirmed'),
    (3, 3, 6, '2026-09-01 08:15:00', 'Confirmed'),
    (4, 2, 4, '2026-02-10 14:00:00', 'Confirmed'),
    (4, 3, 6, '2026-09-02 09:00:00', 'Pending');
GO

-- Insert Results
-- Result for Enrolment 3 (Lisa in Cape Town Cycle Tour)
INSERT INTO Results (EnrolmentId, FinishTime, Position, RecordedAt) VALUES
    (3, '03:15:42', 47, '2027-03-08 12:30:00');
GO

-- =====================================================
-- VERIFICATION QUERIES
-- =====================================================
SELECT 'Roles' AS [TableName], COUNT(*) AS [TotalRows] FROM Roles
UNION ALL
SELECT 'Users', COUNT(*) FROM Users
UNION ALL
SELECT 'Events', COUNT(*) FROM Events
UNION ALL
SELECT 'Categories', COUNT(*) FROM Categories
UNION ALL
SELECT 'Enrolments', COUNT(*) FROM Enrolments
UNION ALL
SELECT 'Results', COUNT(*) FROM Results;
GO