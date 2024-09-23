-- ≈‰‘«¡ ﬁ«⁄œ… «·»Ì«‰« 
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'StudentsDB')
BEGIN
    CREATE DATABASE [StudentsDB];
END
GO

USE [StudentsDB]
GO

-- ≈‰‘«¡ ÃœÊ· «·œÊ·
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Countries') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Countries](
        [CountryID] [int] IDENTITY(1,1) NOT NULL,
          NULL,
          NULL,
          NULL,
        PRIMARY KEY CLUSTERED 
        (
            [CountryID] ASC
        )
    ) ON [PRIMARY];
END
GO

-- ≈‰‘«¡ ÃœÊ· «·ÿ·«»
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.Students') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Students](
        [Id] [int] IDENTITY(1,1) NOT NULL,
          NOT NULL,
        [Age] [int] NOT NULL,
        [Grade] [int] NOT NULL,
        PRIMARY KEY CLUSTERED 
        (
            [Id] ASC
        )
    ) ON [PRIMARY];
END
GO

-- ≈Ã—«¡«  „Œ“‰… (Stored Procedures)

-- ≈÷«›… ÿ«·»
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.SP_AddStudent') AND type in (N'P'))
BEGIN
    CREATE PROCEDURE [dbo].[SP_AddStudent]
        @Name NVARCHAR(100),
        @Age INT,
        @Grade INT,
        @NewStudentId INT OUTPUT
    AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO Students (Name, Age, Grade) VALUES (@Name, @Age, @Grade);
        SET @NewStudentId = SCOPE_IDENTITY();
    END;
END
GO

-- Õ–› ÿ«·»
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.SP_DeleteStudent') AND type in (N'P'))
BEGIN
    CREATE PROCEDURE [dbo].[SP_DeleteStudent]
        @StudentId INT
    AS
    BEGIN
        SET NOCOUNT ON;
        DELETE FROM Students WHERE Id = @StudentId;
    END;
END
GO

-- «·Õ’Ê· ⁄·Ï Ã„Ì⁄ «·ÿ·«»
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.SP_GetAllStudents') AND type in (N'P'))
BEGIN
    CREATE PROCEDURE [dbo].[SP_GetAllStudents]
    AS
    BEGIN
        SET NOCOUNT ON;
        SELECT Id, Name, Age, Grade FROM Students;
    END;
END
GO

-- «·Õ’Ê· ⁄·Ï „ Ê”ÿ «·œ—Ã« 
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.SP_GetAverageGrade') AND type in (N'P'))
BEGIN
    CREATE PROCEDURE [dbo].[SP_GetAverageGrade]
    AS
    BEGIN
        SET NOCOUNT ON;
        SELECT AVG(Grade) AS AverageGrade FROM Students;
    END;
END
GO

-- «·Õ’Ê· ⁄·Ï «·ÿ·«» «·‰«ÃÕÌ‰
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.SP_GetPassedStudents') AND type in (N'P'))
BEGIN
    CREATE PROCEDURE [dbo].[SP_GetPassedStudents]
    AS
    BEGIN
        SET NOCOUNT ON;
        SELECT Id, Name, Age, Grade FROM Students WHERE Grade >= 50;
    END;
END
GO

-- «·Õ’Ê· ⁄·Ï ÿ«·» Õ”» ID
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.SP_GetStudentById') AND type in (N'P'))
BEGIN
    CREATE PROCEDURE [dbo].[SP_GetStudentById]
        @StudentId INT
    AS
    BEGIN
        SET NOCOUNT ON;
        SELECT Id, Name, Age, Grade FROM Students WHERE Id = @StudentId;
    END;
END
GO

--  ÕœÌÀ »Ì«‰«  «·ÿ«·»
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.SP_UpdateStudent') AND type in (N'P'))
BEGIN
    CREATE PROCEDURE [dbo].[SP_UpdateStudent]
        @StudentId INT,
        @Name NVARCHAR(100),
        @Age INT,
        @Grade INT
    AS
    BEGIN
        SET NOCOUNT ON;
        UPDATE Students SET Name = @Name, Age = @Age, Grade = @Grade WHERE Id = @StudentId;
    END;
END
GO

-- ≈œ—«Ã »Ì«‰«  «» œ«∆Ì… («Œ Ì«—Ì)
INSERT INTO Students (Name, Age, Grade) VALUES ('Ali', 20, 85);
INSERT INTO Students (Name, Age, Grade) VALUES ('Sara', 22, 70);
INSERT INTO Students (Name, Age, Grade) VALUES ('Omar', 19, 40);
