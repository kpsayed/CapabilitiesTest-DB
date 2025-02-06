USE [master]
GO
/****** Object:  Database [StudentManagementDB]    Script Date: 06-Feb-25 3:58:32 PM ******/
CREATE DATABASE [StudentManagementDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'StudentManagementDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\StudentManagementDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'StudentManagementDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\StudentManagementDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [StudentManagementDB] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [StudentManagementDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [StudentManagementDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [StudentManagementDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [StudentManagementDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [StudentManagementDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [StudentManagementDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [StudentManagementDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [StudentManagementDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [StudentManagementDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [StudentManagementDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [StudentManagementDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [StudentManagementDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [StudentManagementDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [StudentManagementDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [StudentManagementDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [StudentManagementDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [StudentManagementDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [StudentManagementDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [StudentManagementDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [StudentManagementDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [StudentManagementDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [StudentManagementDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [StudentManagementDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [StudentManagementDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [StudentManagementDB] SET  MULTI_USER 
GO
ALTER DATABASE [StudentManagementDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [StudentManagementDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [StudentManagementDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [StudentManagementDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [StudentManagementDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [StudentManagementDB] SET QUERY_STORE = OFF
GO
USE [StudentManagementDB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [StudentManagementDB]
GO
/****** Object:  Table [dbo].[MstNationalities]    Script Date: 06-Feb-25 3:58:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MstNationalities](
	[NationalityAID] [int] IDENTITY(1,1) NOT NULL,
	[Nationality] [nvarchar](100) NOT NULL,
	[OrderIndex] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_MstNationalities] PRIMARY KEY CLUSTERED 
(
	[NationalityAID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__MstNatio__2062829385D913FE] UNIQUE NONCLUSTERED 
(
	[Nationality] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MstStudents]    Script Date: 06-Feb-25 3:58:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MstStudents](
	[StudentAID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
	[DOB] [datetime] NULL,
	[NationalityID] [int] NULL,
	[IsDeleted] [bit] NULL,
	[EntDate] [datetime] NULL,
 CONSTRAINT [PK_MstStudents] PRIMARY KEY CLUSTERED 
(
	[StudentAID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ViewStudents]    Script Date: 06-Feb-25 3:58:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW  [dbo].[ViewStudents] AS
SELECT  Stud.StudentAID, Stud.FirstName, Stud.LastName, Stud.DOB, Stud.NationalityID, Nat.Nationality
FROM    MstStudents AS Stud LEFT OUTER JOIN
        MstNationalities AS Nat ON Stud.NationalityID = Nat.NationalityAID
WHERE   ISNULL(Stud.IsDeleted,0)=0
GO
/****** Object:  Table [dbo].[MstRelationship]    Script Date: 06-Feb-25 3:58:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MstRelationship](
	[RelationAID] [int] IDENTITY(1,1) NOT NULL,
	[Relation] [nvarchar](50) NULL,
	[OrderIndex] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_MstRelationships] PRIMARY KEY CLUSTERED 
(
	[RelationAID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Relation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FamilyMember]    Script Date: 06-Feb-25 3:58:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FamilyMember](
	[MemberAID] [int] IDENTITY(1,1) NOT NULL,
	[MemberFirstName] [nvarchar](100) NULL,
	[MemberLastName] [nvarchar](100) NULL,
	[DateOfBirth] [datetime] NULL,
	[RelationshipID] [int] NULL,
	[NationalityID] [int] NULL,
	[StudentID] [int] NULL,
	[IsDeleted] [bit] NULL,
	[EntDate] [datetime] NULL,
 CONSTRAINT [PK_MstFamilyMembers] PRIMARY KEY CLUSTERED 
(
	[MemberAID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ViewStudentRelatives]    Script Date: 06-Feb-25 3:58:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW  [dbo].[ViewStudentRelatives] AS
SELECT        Fam.MemberAID, Fam.MemberFirstName, 
              Fam.MemberLastName, Fam.DateOfBirth , Fam.RelationshipID AS RelativeRelationID,Relation.Relation,
			  Fam.NationalityID AS RelativeNationalityID,  Nat.Nationality RelativeNationality,Fam.StudentID
			  -- , Stud.FirstName StudFirstName, Stud.LastName StudLastName, Stud.DOB StudDOB,
			  --Stud.NationalityID AS StudNationalityID, Stud.Nationality AS StudNationality
              
FROM          FamilyMember AS Fam  LEFT OUTER JOIN ViewStudents AS Stud
              ON Stud.StudentAID = Fam.StudentID LEFT OUTER JOIN
              MstNationalities AS Nat ON Fam.NationalityID = Nat.NationalityAID LEFT OUTER JOIN
              MstRelationship AS Relation ON Fam.RelationshipID = Relation.RelationAID
WHERE        (ISNULL(Fam.IsDeleted, 0) = 0)
        
GO
ALTER TABLE [dbo].[FamilyMember] ADD  CONSTRAINT [DF_MstFamilyMembers_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[FamilyMember] ADD  CONSTRAINT [DF_MstFamilyMembers_EntDate]  DEFAULT (getdate()) FOR [EntDate]
GO
ALTER TABLE [dbo].[MstNationalities] ADD  CONSTRAINT [DF_MstNationalities_OrderIndex]  DEFAULT ((0)) FOR [OrderIndex]
GO
ALTER TABLE [dbo].[MstNationalities] ADD  CONSTRAINT [DF_MstNationalities_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[MstRelationship] ADD  CONSTRAINT [DF_MstRelationships_OrderIndex]  DEFAULT ((0)) FOR [OrderIndex]
GO
ALTER TABLE [dbo].[MstRelationship] ADD  CONSTRAINT [DF_MstRelationships_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[MstStudents] ADD  CONSTRAINT [DF_MstStudents_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[MstStudents] ADD  CONSTRAINT [DF_MstStudents_EntDate]  DEFAULT (getdate()) FOR [EntDate]
GO
ALTER TABLE [dbo].[FamilyMember]  WITH CHECK ADD  CONSTRAINT [FK_MstFamilyMembers_MstRelationships] FOREIGN KEY([RelationshipID])
REFERENCES [dbo].[MstRelationship] ([RelationAID])
GO
ALTER TABLE [dbo].[FamilyMember] CHECK CONSTRAINT [FK_MstFamilyMembers_MstRelationships]
GO
USE [master]
GO
ALTER DATABASE [StudentManagementDB] SET  READ_WRITE 
GO
