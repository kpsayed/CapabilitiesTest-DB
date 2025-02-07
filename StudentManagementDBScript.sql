USE [StudentManagementDB]
GO
/****** Object:  Table [dbo].[MstNationalities]    Script Date: 07-Feb-25 11:01:54 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MstStudents]    Script Date: 07-Feb-25 11:01:54 AM ******/
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
/****** Object:  View [dbo].[ViewStudents]    Script Date: 07-Feb-25 11:01:54 AM ******/
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
/****** Object:  Table [dbo].[MstRelationship]    Script Date: 07-Feb-25 11:01:54 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FamilyMember]    Script Date: 07-Feb-25 11:01:54 AM ******/
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
/****** Object:  View [dbo].[ViewStudentRelatives]    Script Date: 07-Feb-25 11:01:54 AM ******/
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
SET IDENTITY_INSERT [dbo].[FamilyMember] ON 
GO
INSERT [dbo].[FamilyMember] ([MemberAID], [MemberFirstName], [MemberLastName], [DateOfBirth], [RelationshipID], [NationalityID], [StudentID], [IsDeleted], [EntDate]) VALUES (1, N'muhammed', N'malappuram', CAST(N'2025-01-31T07:41:54.503' AS DateTime), 2, 2, 1, 0, CAST(N'2025-01-31T09:56:53.710' AS DateTime))
GO
INSERT [dbo].[FamilyMember] ([MemberAID], [MemberFirstName], [MemberLastName], [DateOfBirth], [RelationshipID], [NationalityID], [StudentID], [IsDeleted], [EntDate]) VALUES (2, N'riyas', N'palakkat', CAST(N'2025-02-03T05:40:23.593' AS DateTime), 1, 1, 1, 0, CAST(N'2025-02-03T09:36:12.570' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[FamilyMember] OFF
GO
SET IDENTITY_INSERT [dbo].[MstNationalities] ON 
GO
INSERT [dbo].[MstNationalities] ([NationalityAID], [Nationality], [OrderIndex], [IsActive]) VALUES (1, N'United Arab Emirates', 1, 1)
GO
INSERT [dbo].[MstNationalities] ([NationalityAID], [Nationality], [OrderIndex], [IsActive]) VALUES (2, N'Bahrain', 2, 1)
GO
INSERT [dbo].[MstNationalities] ([NationalityAID], [Nationality], [OrderIndex], [IsActive]) VALUES (3, N'Kuwait', 3, 1)
GO
INSERT [dbo].[MstNationalities] ([NationalityAID], [Nationality], [OrderIndex], [IsActive]) VALUES (4, N'Oman', 4, 1)
GO
INSERT [dbo].[MstNationalities] ([NationalityAID], [Nationality], [OrderIndex], [IsActive]) VALUES (5, N'India', 5, 1)
GO
INSERT [dbo].[MstNationalities] ([NationalityAID], [Nationality], [OrderIndex], [IsActive]) VALUES (6, N'China', 6, 1)
GO
SET IDENTITY_INSERT [dbo].[MstNationalities] OFF
GO
SET IDENTITY_INSERT [dbo].[MstRelationship] ON 
GO
INSERT [dbo].[MstRelationship] ([RelationAID], [Relation], [OrderIndex], [IsActive]) VALUES (1, N'Parent', 1, 1)
GO
INSERT [dbo].[MstRelationship] ([RelationAID], [Relation], [OrderIndex], [IsActive]) VALUES (2, N'Sibling', 2, 1)
GO
INSERT [dbo].[MstRelationship] ([RelationAID], [Relation], [OrderIndex], [IsActive]) VALUES (3, N'Spouse', 3, 1)
GO
SET IDENTITY_INSERT [dbo].[MstRelationship] OFF
GO
SET IDENTITY_INSERT [dbo].[MstStudents] ON 
GO
INSERT [dbo].[MstStudents] ([StudentAID], [FirstName], [LastName], [DOB], [NationalityID], [IsDeleted], [EntDate]) VALUES (1, N'shamna', N'akaparam', CAST(N'2001-01-31T00:00:00.000' AS DateTime), 5, 0, CAST(N'2025-01-31T09:54:23.523' AS DateTime))
GO
INSERT [dbo].[MstStudents] ([StudentAID], [FirstName], [LastName], [DOB], [NationalityID], [IsDeleted], [EntDate]) VALUES (2, N'sayed', N'kallet', CAST(N'2025-01-31T00:00:00.000' AS DateTime), 3, 0, CAST(N'2025-01-31T11:46:00.533' AS DateTime))
GO
INSERT [dbo].[MstStudents] ([StudentAID], [FirstName], [LastName], [DOB], [NationalityID], [IsDeleted], [EntDate]) VALUES (3, N'shafi', N'malappuram', CAST(N'2025-02-03T00:00:00.000' AS DateTime), 4, 0, CAST(N'2025-02-03T09:31:39.573' AS DateTime))
GO
INSERT [dbo].[MstStudents] ([StudentAID], [FirstName], [LastName], [DOB], [NationalityID], [IsDeleted], [EntDate]) VALUES (4, N'riyas', N'palakkat', CAST(N'2025-02-03T00:00:00.000' AS DateTime), 5, 0, CAST(N'2025-02-03T11:51:35.837' AS DateTime))
GO
INSERT [dbo].[MstStudents] ([StudentAID], [FirstName], [LastName], [DOB], [NationalityID], [IsDeleted], [EntDate]) VALUES (5, N'tester', N'test address', CAST(N'1990-12-22T00:00:00.000' AS DateTime), 3, 0, CAST(N'2025-02-05T15:36:53.443' AS DateTime))
GO
INSERT [dbo].[MstStudents] ([StudentAID], [FirstName], [LastName], [DOB], [NationalityID], [IsDeleted], [EntDate]) VALUES (6, N'razi', N'manjeri malappuram', CAST(N'2012-02-22T00:00:00.000' AS DateTime), 3, 0, CAST(N'2025-02-07T10:43:14.993' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[MstStudents] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__MstNatio__2062829385D913FE]    Script Date: 07-Feb-25 11:01:54 AM ******/
ALTER TABLE [dbo].[MstNationalities] ADD  CONSTRAINT [UQ__MstNatio__2062829385D913FE] UNIQUE NONCLUSTERED 
(
	[Nationality] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__MstRelat__92ED18E14EE3452A]    Script Date: 07-Feb-25 11:01:54 AM ******/
ALTER TABLE [dbo].[MstRelationship] ADD UNIQUE NONCLUSTERED 
(
	[Relation] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
