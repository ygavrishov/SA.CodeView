/*
Run this script on SQL Server 2008 or later. There may be flaws if running on earlier versions of SQL Server.
*/
/*
Run this script on SQL Server 2008 or later. There may be flaws if running on earlier versions of SQL Server.
*/
USE [master]
GO

IF  EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'LRDBG')
DROP DATABASE [LRDBG]
GO

USE [master]
GO

CREATE DATABASE [LRDBG] ON  PRIMARY 
( NAME = N'LRDBG', FILENAME = N'D:\SQL_Database\LRDBG.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'LRDBG_log', FILENAME = N'E:\SQL_Database\LRDBG_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10240KB )
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LRDBG].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [LRDBG] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [LRDBG] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [LRDBG] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [LRDBG] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [LRDBG] SET ARITHABORT OFF 
GO

ALTER DATABASE [LRDBG] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [LRDBG] SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE [LRDBG] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [LRDBG] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [LRDBG] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [LRDBG] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [LRDBG] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [LRDBG] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [LRDBG] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [LRDBG] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [LRDBG] SET  READ_WRITE 
GO

ALTER DATABASE [LRDBG] SET RECOVERY FULL 
GO

ALTER DATABASE [LRDBG] SET  MULTI_USER 
GO

if ( ((@@microsoftversion / power(2, 24) = 8) and (@@microsoftversion & 0xffff >= 760)) or 
		(@@microsoftversion / power(2, 24) >= 9) )begin 
	exec dbo.sp_dboption @dbname =  N'LRDBG', @optname = 'db chaining', @optvalue = 'OFF'
 end
GO



USE [lrdbk]
GO
ALTER DATABASE [lrdbk]
SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [lrdbk]
SET ANSI_NULLS OFF
GO
ALTER DATABASE [lrdbk]
SET ANSI_PADDING OFF
GO
ALTER DATABASE [lrdbk]
SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [lrdbk]
SET ARITHABORT OFF
GO
ALTER DATABASE [lrdbk]
SET AUTO_CLOSE OFF
GO
ALTER DATABASE [lrdbk]
SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [lrdbk]
SET AUTO_SHRINK OFF
GO
ALTER DATABASE [lrdbk]
SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [lrdbk]
SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [lrdbk]
SET ENABLE_BROKER
GO
ALTER DATABASE [lrdbk]
COLLATE Polish_CI_AS
GO
ALTER DATABASE [lrdbk]
SET COMPATIBILITY_LEVEL = 80
GO
ALTER DATABASE [lrdbk]
SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [lrdbk]
SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [lrdbk]
SET DB_CHAINING OFF
GO
ALTER DATABASE [lrdbk]
SET READ_WRITE
GO
ALTER DATABASE [lrdbk]
SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [lrdbk]
SET CURSOR_DEFAULT GLOBAL
GO
exec sp_fulltext_database disable
GO
ALTER DATABASE [lrdbk]
SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [lrdbk]
SET PAGE_VERIFY TORN_PAGE_DETECTION
GO
ALTER DATABASE [lrdbk]
SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [lrdbk]
SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [lrdbk]
SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [lrdbk]
SET RECOVERY SIMPLE
GO
ALTER DATABASE [lrdbk]
SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [lrdbk]
SET MULTI_USER
WITH ROLLBACK IMMEDIATE
GO
ALTER DATABASE [lrdbk]
SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [lrdbk]
SET TRUSTWORTHY OFF
GO
IF NOT EXISTS ( SELECT * FROM sys.server_principals WHERE type in ('U', 'G', 'S', 'C', 'K') and name = N'ASTOR\Accounting' )
CREATE LOGIN [ASTOR\Accounting] WITH PASSWORD = ''
GO
CREATE USER [ASTOR\Accounting] FOR LOGIN [ASTOR\Accounting] WITH DEFAULT_SCHEMA = [dbo]
GO
IF NOT EXISTS ( SELECT * FROM sys.server_principals WHERE type in ('U', 'G', 'S', 'C', 'K') and name = N'ASTOR\ANNAS' )
CREATE LOGIN [ASTOR\ANNAS] WITH PASSWORD = ''
GO
CREATE USER [ASTOR\ANNAS] FOR LOGIN [ASTOR\ANNAS] WITH DEFAULT_SCHEMA = [ASTOR\ANNAS]
GO
EXEC sp_addrolemember N'db_owner', N'ASTOR\ANNAS'
GO
IF NOT EXISTS ( SELECT * FROM sys.server_principals WHERE type in ('U', 'G', 'S', 'C', 'K') and name = N'ASTOR\Baza nbdk dlladmins' )
CREATE LOGIN [ASTOR\Baza nbdk dlladmins] WITH PASSWORD = ''
GO
CREATE USER [ASTOR\Baza nbdk dlladmins] FOR LOGIN [ASTOR\Baza nbdk dlladmins] WITH DEFAULT_SCHEMA = [dbo]
GO
EXEC sp_addrolemember N'db_datareader', N'ASTOR\Baza nbdk dlladmins'
GO
EXEC sp_addrolemember N'db_datawriter', N'ASTOR\Baza nbdk dlladmins'
GO
EXEC sp_addrolemember N'db_ddladmin', N'ASTOR\Baza nbdk dlladmins'
GO
IF NOT EXISTS ( SELECT * FROM sys.server_principals WHERE type in ('U', 'G', 'S', 'C', 'K') and name = N'ASTOR\Baza nbdk users' )
CREATE LOGIN [ASTOR\Baza nbdk users] WITH PASSWORD = ''
GO
CREATE USER [ASTOR\Baza nbdk users] FOR LOGIN [ASTOR\Baza nbdk users] WITH DEFAULT_SCHEMA = [dbo]
GO
EXEC sp_addrolemember N'db_datareader', N'ASTOR\Baza nbdk users'
GO
EXEC sp_addrolemember N'db_datawriter', N'ASTOR\Baza nbdk users'
GO
IF NOT EXISTS ( SELECT * FROM sys.server_principals WHERE type in ('U', 'G', 'S', 'C', 'K') and name = N'ASTOR\Baza nbdk viewers' )
CREATE LOGIN [ASTOR\Baza nbdk viewers] WITH PASSWORD = ''
GO
CREATE USER [ASTOR\Baza nbdk viewers] FOR LOGIN [ASTOR\Baza nbdk viewers] WITH DEFAULT_SCHEMA = [dbo]
GO
CREATE ROLE [BDKProgramyZewnetrzne] AUTHORIZATION [dbo]
GO
EXEC sp_addrolemember N'BDKProgramyZewnetrzne', N'ASTOR\Baza nbdk viewers'
GO
EXEC sp_addrolemember N'db_datareader', N'ASTOR\Baza nbdk viewers'
GO
IF NOT EXISTS ( SELECT * FROM sys.server_principals WHERE type in ('U', 'G', 'S', 'C', 'K') and name = N'ASTOR\GRZEGORZSZ' )
CREATE LOGIN [ASTOR\GRZEGORZSZ] WITH PASSWORD = ''
GO
CREATE USER [ASTOR\GRZEGORZSZ] FOR LOGIN [ASTOR\GRZEGORZSZ] WITH DEFAULT_SCHEMA = [ASTOR\GRZEGORZSZ]
GO
IF NOT EXISTS ( SELECT * FROM sys.server_principals WHERE type in ('U', 'G', 'S', 'C', 'K') and name = N'ASTOR\JAROSLAWG' )
CREATE LOGIN [ASTOR\JAROSLAWG] WITH PASSWORD = ''
GO
CREATE USER [ASTOR\JAROSLAWG] FOR LOGIN [ASTOR\JAROSLAWG] WITH DEFAULT_SCHEMA = [ASTOR\JAROSLAWG]
GO
IF NOT EXISTS ( SELECT * FROM sys.server_principals WHERE type in ('U', 'G', 'S', 'C', 'K') and name = N'ASTOR\LukaszRTEST' )
CREATE LOGIN [ASTOR\LukaszRTEST] WITH PASSWORD = ''
GO
CREATE USER [ASTOR\LukaszRTEST] FOR LOGIN [ASTOR\LukaszRTEST] WITH DEFAULT_SCHEMA = [ASTOR\LukaszRTEST]
GO
IF NOT EXISTS ( SELECT * FROM sys.server_principals WHERE type in ('U', 'G', 'S', 'C', 'K') and name = N'ASTOR\MarcinR' )
CREATE LOGIN [ASTOR\MarcinR] WITH PASSWORD = ''
GO
CREATE USER [ASTOR\MARCINR] FOR LOGIN [ASTOR\MarcinR] WITH DEFAULT_SCHEMA = [ASTOR\MARCINR]
GO
IF NOT EXISTS ( SELECT * FROM sys.server_principals WHERE type in ('U', 'G', 'S', 'C', 'K') and name = N'ASTOR\MARCINWO' )
CREATE LOGIN [ASTOR\MARCINWO] WITH PASSWORD = ''
GO
CREATE USER [ASTOR\MARCINWO] FOR LOGIN [ASTOR\MARCINWO] WITH DEFAULT_SCHEMA = [ASTOR\MARCINWO]
GO
IF NOT EXISTS ( SELECT * FROM sys.server_principals WHERE type in ('U', 'G', 'S', 'C', 'K') and name = N'ASTOR\MichalJ' )
CREATE LOGIN [ASTOR\MichalJ] WITH PASSWORD = ''
GO
CREATE USER [ASTOR\MichalJ] FOR LOGIN [ASTOR\MichalJ] WITH DEFAULT_SCHEMA = [ASTOR\MichalJ]
GO
IF NOT EXISTS ( SELECT * FROM sys.server_principals WHERE type in ('U', 'G', 'S', 'C', 'K') and name = N'ASTOR\nBDKdbUser' )
CREATE LOGIN [ASTOR\nBDKdbUser] WITH PASSWORD = ''
GO
CREATE USER [ASTOR\nBDKdbUser] FOR LOGIN [ASTOR\nBDKdbUser] WITH DEFAULT_SCHEMA = [ASTOR\nBDKdbUser]
GO
EXEC sp_addrolemember N'db_datareader', N'ASTOR\nBDKdbUser'
GO
EXEC sp_addrolemember N'db_datawriter', N'ASTOR\nBDKdbUser'
GO
EXEC sp_addrolemember N'db_ddladmin', N'ASTOR\nBDKdbUser'
GO
IF NOT EXISTS ( SELECT * FROM sys.server_principals WHERE type in ('U', 'G', 'S', 'C', 'K') and name = N'ASTOR\sql2k5svr' )
CREATE LOGIN [ASTOR\sql2k5svr] WITH PASSWORD = ''
GO
CREATE USER [ASTOR\sql2k5svr] FOR LOGIN [ASTOR\sql2k5svr] WITH DEFAULT_SCHEMA = [ASTOR\sql2k5svr]
GO
EXEC sp_addrolemember N'db_owner', N'ASTOR\sql2k5svr'
GO
CREATE ROLE [MSmerge_088C28474D1D4D578FED3D0B087A6766] AUTHORIZATION [dbo]
GO
EXEC sp_addrolemember N'MSmerge_088C28474D1D4D578FED3D0B087A6766', N'ASTOR\sql2k5svr'
GO
CREATE ROLE [MSmerge_PAL_role] AUTHORIZATION [dbo]
GO
EXEC sp_addrolemember N'MSmerge_PAL_role', N'MSmerge_088C28474D1D4D578FED3D0B087A6766'
GO
IF NOT EXISTS ( SELECT * FROM sys.server_principals WHERE type in ('U', 'G', 'S', 'C', 'K') and name = N'formularze2' )
CREATE LOGIN [formularze2] WITH PASSWORD = ''
GO
CREATE USER [formularze2] FOR LOGIN [formularze2] WITH DEFAULT_SCHEMA = [formularze2]
GO
CREATE ROLE [RaportyWEB] AUTHORIZATION [dbo]
GO
EXEC sp_addrolemember N'RaportyWEB', N'formularze2'
GO
IF NOT EXISTS ( SELECT * FROM sys.server_principals WHERE type in ('U', 'G', 'S', 'C', 'K') and name = N'ASTOR\MICHAL' )
CREATE LOGIN [ASTOR\MICHAL] WITH PASSWORD = ''
GO
CREATE USER [MICHAL] FOR LOGIN [ASTOR\MICHAL] WITH DEFAULT_SCHEMA = [MICHAL]
GO
EXEC sp_addrolemember N'db_datareader', N'MICHAL'
GO
EXEC sp_addrolemember N'db_ddladmin', N'MICHAL'
GO
IF NOT EXISTS ( SELECT * FROM sys.server_principals WHERE type in ('U', 'G', 'S', 'C', 'K') and name = N'raportszkolenia' )
CREATE LOGIN [raportszkolenia] WITH PASSWORD = ''
GO
CREATE USER [raportszkolenia] FOR LOGIN [raportszkolenia] WITH DEFAULT_SCHEMA = [raportszkolenia]
GO
CREATE ROLE [RaportyWEBZewn] AUTHORIZATION [dbo]
GO
EXEC sp_addrolemember N'RaportyWEBZewn', N'raportszkolenia'
GO
CREATE USER [sareplikacja] WITHOUT LOGIN WITH DEFAULT_SCHEMA = [sareplikacja]
GO
EXEC sp_addrolemember N'db_owner', N'sareplikacja'
GO
CREATE SCHEMA [ASTOR\Accounting] AUTHORIZATION [ASTOR\Accounting]
GO
CREATE SCHEMA [ASTOR\ANNAS] AUTHORIZATION [ASTOR\ANNAS]
GO
CREATE SCHEMA [ASTOR\Baza nbdk dlladmins] AUTHORIZATION [ASTOR\Baza nbdk dlladmins]
GO
CREATE SCHEMA [ASTOR\Baza nbdk users] AUTHORIZATION [ASTOR\Baza nbdk users]
GO
CREATE SCHEMA [ASTOR\Baza nbdk viewers] AUTHORIZATION [ASTOR\Baza nbdk viewers]
GO
CREATE SCHEMA [ASTOR\GRZEGORZSZ] AUTHORIZATION [ASTOR\GRZEGORZSZ]
GO
CREATE SCHEMA [ASTOR\JAROSLAWG] AUTHORIZATION [ASTOR\JAROSLAWG]
GO
CREATE SCHEMA [ASTOR\LukaszRTEST] AUTHORIZATION [ASTOR\LukaszRTEST]
GO
CREATE SCHEMA [ASTOR\MARCINR] AUTHORIZATION [ASTOR\MARCINR]
GO
CREATE SCHEMA [ASTOR\MARCINWO] AUTHORIZATION [ASTOR\MARCINWO]
GO
CREATE SCHEMA [ASTOR\MichalJ] AUTHORIZATION [ASTOR\MichalJ]
GO
CREATE SCHEMA [ASTOR\nBDKdbUser] AUTHORIZATION [ASTOR\nBDKdbUser]
GO
CREATE SCHEMA [ASTOR\sql2k5svr] AUTHORIZATION [ASTOR\sql2k5svr]
GO
CREATE SCHEMA [formularze2] AUTHORIZATION [formularze2]
GO
CREATE SCHEMA [MICHAL] AUTHORIZATION [MICHAL]
GO
CREATE SCHEMA [raportszkolenia] AUTHORIZATION [raportszkolenia]
GO
CREATE SCHEMA [sareplikacja] AUTHORIZATION [sareplikacja]
GO
CREATE TABLE [dbo].[AE_DownloadHistory] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[FileName]				[varchar](2000)		 COLLATE Polish_CI_AS NOT NULL,
	[Link]					[varchar](4000)		 COLLATE Polish_CI_AS NOT NULL,
	[Date]					[datetime]			 NOT NULL,
	[CompanyPersonId]		[bigint]			 NOT NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AE_DownloadHistory] ADD CONSTRAINT [DF_AE_DownloadHistory_REPLID] DEFAULT (newid())FOR [REPLID]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_AE_DownloadHistory] ON [dbo].[AE_DownloadHistory]([Id]) ON [PRIMARY]
GO
GRANT INSERT ON [dbo].[AE_DownloadHistory] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[AE_Menu] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[IndexSection]		[int]				 NOT NULL,
	[Section]			[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[IndexTitle]		[int]				 NULL,
	[Title]				[varchar](100)		 COLLATE Polish_CI_AS NULL,
	[Description]		[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[Link]				[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[NewWindow]			[bit]				 NOT NULL,
	[GUID]				[uniqueidentifier]	 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AE_Menu] ADD CONSTRAINT [DF_AE_Menu_Description] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[AE_Menu] ADD CONSTRAINT [DF_AE_Menu_NewWindow] DEFAULT (0)FOR [NewWindow]
GO
ALTER TABLE [dbo].[AE_Menu] ADD CONSTRAINT [DF_AE_Menu_REPLID] DEFAULT (newid())FOR [REPLID]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_AE_Menu] ON [dbo].[AE_Menu]([Id]) ON [PRIMARY]
GO
GRANT SELECT ON [dbo].[AE_Menu] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[AE_Offer] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[CompanyId]				[bigint]			 NOT NULL,
	[CompanyPersonId]		[bigint]			 NOT NULL,
	[OfferStatusId]			[bigint]			 NOT NULL,
	[Date]					[datetime]			 NOT NULL,
	[Name]					[varchar](200)		 COLLATE Polish_CI_AS NOT NULL,
	[Comment]				[varchar](2000)		 COLLATE Polish_CI_AS NOT NULL,
	[OfferFor]				[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[OfferNr]				[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[ShipTo]				[varchar](500)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AE_Offer] ADD CONSTRAINT [DF_AE_Offer_Guid] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[AE_Offer] ADD CONSTRAINT [DF_AE_Order_Date] DEFAULT (getdate())FOR [Date]
GO
ALTER TABLE [dbo].[AE_Offer] ADD CONSTRAINT [DF_AE_Offer_REPLID] DEFAULT (newid())FOR [REPLID]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_AE_Offer] ON [dbo].[AE_Offer]([Id]) ON [PRIMARY]
GO
GRANT DELETE ON [dbo].[AE_Offer] TO [RaportyWEB]
GO
GRANT INSERT ON [dbo].[AE_Offer] TO [RaportyWEB]
GO
GRANT SELECT ON [dbo].[AE_Offer] TO [RaportyWEB]
GO
GRANT UPDATE ON [dbo].[AE_Offer] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[AE_OfferItem] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[OfferId]			[bigint]			 NOT NULL,
	[Index]				[int]				 NOT NULL,
	[CatalogNr]			[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]		[varchar](200)		 COLLATE Polish_CI_AS NOT NULL,
	[Amount]			[int]				 NOT NULL,
	[UserComment]		[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AE_OfferItem] ADD CONSTRAINT [DF_AE_OfferItem_Guid] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[AE_OfferItem] ADD CONSTRAINT [DF_AE_OfferItem_REPLID] DEFAULT (newid())FOR [REPLID]
GO
CREATE NONCLUSTERED INDEX [IX_AE_OfferItem] ON [dbo].[AE_OfferItem]([Id]) ON [PRIMARY]
GO
GRANT DELETE ON [dbo].[AE_OfferItem] TO [RaportyWEB]
GO
GRANT INSERT ON [dbo].[AE_OfferItem] TO [RaportyWEB]
GO
GRANT SELECT ON [dbo].[AE_OfferItem] TO [RaportyWEB]
GO
GRANT UPDATE ON [dbo].[AE_OfferItem] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[AE_OfferStatus] (
	[Id]		[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Name]		[varchar](200)		 COLLATE Polish_CI_AS NOT NULL,
	[Index]		[int]				 NOT NULL,
	[Guid]		[uniqueidentifier]	 NOT NULL,
	[REPLID]	[uniqueidentifier]	 NOT NULL ROWGUIDCOL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AE_OfferStatus] ADD CONSTRAINT [DF_AE_OfferStatus_Guid] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[AE_OfferStatus] ADD CONSTRAINT [DF_AE_OfferStatus_REPLID] DEFAULT (newid())FOR [REPLID]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_AE_OfferStatus] ON [dbo].[AE_OfferStatus]([Id]) ON [PRIMARY]
GO
GRANT SELECT ON [dbo].[AE_OfferStatus] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[AE_Security] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[GUID]				[uniqueidentifier]	 NOT NULL,
	[Index]				[int]				 NOT NULL,
	[SecurityGroup]		[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]		[varchar](500)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AE_Security] ADD CONSTRAINT [DF_AE_Security_ID] DEFAULT (newid())FOR [GUID]
GO
ALTER TABLE [dbo].[AE_Security] ADD CONSTRAINT [DF_AE_Security_REPLID] DEFAULT (newid())FOR [REPLID]
GO
CREATE NONCLUSTERED INDEX [IX_AE_Security] ON [dbo].[AE_Security]([Id]) ON [PRIMARY]
GO
GRANT SELECT ON [dbo].[AE_Security] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[AE_SecurityMenu] (
	[Id]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[MenuId]		[bigint]			 NOT NULL,
	[SecurityId]	[bigint]			 NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AE_SecurityMenu] ADD CONSTRAINT [DF_AE_SecurityMenu_REPLID] DEFAULT (newid())FOR [REPLID]
GO
CREATE NONCLUSTERED INDEX [IX_AE_SecurityMenu] ON [dbo].[AE_SecurityMenu]([Id]) ON [PRIMARY]
GO
GRANT SELECT ON [dbo].[AE_SecurityMenu] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[CAttribute] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NULL,
	[TypeId]			[bigint]			 NOT NULL,
	[Code]				[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[DataTypeId]		[bigint]			 NOT NULL,
	[Length]			[smallint]			 NOT NULL,
	[MinLength]			[smallint]			 NOT NULL,
	[MinValue]			[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[MaxValue]			[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[RegExp]			[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]		[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[Important]			[bit]				 NOT NULL,
	[DbVersion]			[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[UniqueValues]		[bit]				 NOT NULL,
	[AllowNull]			[bit]				 NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CAttribute] ADD CONSTRAINT [DF__CAttribut__GuidI__18984625] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[CAttribute] ADD CONSTRAINT [DF__CAttribute__Code__DefaultValue] DEFAULT ('')FOR [Code]
GO
ALTER TABLE [dbo].[CAttribute] ADD CONSTRAINT [DF__CAttribute__Length__DefaultValue] DEFAULT (0)FOR [Length]
GO
ALTER TABLE [dbo].[CAttribute] ADD CONSTRAINT [DF_CAttribute_Important] DEFAULT (0)FOR [Important]
GO
ALTER TABLE [dbo].[CAttribute] ADD CONSTRAINT [DF_CAttribute_UniqueValues] DEFAULT (0)FOR [UniqueValues]
GO
ALTER TABLE [dbo].[CAttribute] ADD CONSTRAINT [DF_CAttribute_AllowNull] DEFAULT (0)FOR [AllowNull]
GO
ALTER TABLE [dbo].[CAttribute] ADD CONSTRAINT [DF_CAttribute_REPLID] DEFAULT (newid())FOR [REPLID]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1977058079] ON [dbo].[CAttribute]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CAttribute] ADD CONSTRAINT [PK__CAttribute__17A421EC] PRIMARY KEY CLUSTERED ([ID])
GO
CREATE TABLE [dbo].[CDataType] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[Code]				[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[LengthRequired]	[bit]				 NOT NULL,
	[DefaultLength]		[int]				 NOT NULL,
	[IsNullable]		[bit]				 NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CDataType] ADD CONSTRAINT [DF__CDataType__GuidI__09560295] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[CDataType] ADD CONSTRAINT [DF__CDataType__Code__DefaultValue] DEFAULT ('')FOR [Code]
GO
ALTER TABLE [dbo].[CDataType] ADD CONSTRAINT [DF__CDataType__LengthRequired__DefaultValue] DEFAULT (0)FOR [LengthRequired]
GO
ALTER TABLE [dbo].[CDataType] ADD CONSTRAINT [DF__CDataType__DefaultLength__DefaultValue] DEFAULT (0)FOR [DefaultLength]
GO
ALTER TABLE [dbo].[CDataType] ADD CONSTRAINT [DF_CDataType_IsNullable] DEFAULT (0)FOR [IsNullable]
GO
ALTER TABLE [dbo].[CDataType] ADD CONSTRAINT [DF_CDataType_REPLID] DEFAULT (newid())FOR [REPLID]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2105058535] ON [dbo].[CDataType]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CDataType] ADD CONSTRAINT [PK__CDataType__0861DE5C] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[CAttribute] WITH NOCHECK ADD CONSTRAINT [FK__CAttribute__DataTypeId] FOREIGN KEY ([DataTypeId]) REFERENCES [dbo].[CDataType] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[CType] (
	[ID]							[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]							[uniqueidentifier]	 NULL,
	[Code]							[varchar](40)		 COLLATE Polish_CI_AS NOT NULL,
	[IsRelation]					[bit]				 NOT NULL,
	[IsList]						[bit]				 NOT NULL,
	[IsTree]						[bit]				 NOT NULL,
	[CreateDb]						[bit]				 NOT NULL,
	[Namespace]						[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[Module]						[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[DbVersion]						[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[HistoryModificationType]		[int]				 NOT NULL,
	[HistoryUserType]				[int]				 NOT NULL,
	[Indexed]						[bit]				 NOT NULL,
	[REPLID]						[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[IsServerSide]					[bit]				 NOT NULL,
	[GenerateExternal]				[bit]				 NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CType] ADD CONSTRAINT [DF__CType__GuidID__76432E21] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[CType] ADD CONSTRAINT [DF__CType__Code__DefaultValue] DEFAULT ('')FOR [Code]
GO
ALTER TABLE [dbo].[CType] ADD CONSTRAINT [DF__CType__IsRelation__DefaultValue] DEFAULT (0)FOR [IsRelation]
GO
ALTER TABLE [dbo].[CType] ADD CONSTRAINT [DF__CType__IsList__DefaultValue] DEFAULT (0)FOR [IsList]
GO
ALTER TABLE [dbo].[CType] ADD CONSTRAINT [DF__CType__IsTree__DefaultValue] DEFAULT (0)FOR [IsTree]
GO
ALTER TABLE [dbo].[CType] ADD CONSTRAINT [DF_CType_CreateDatabase] DEFAULT (1)FOR [CreateDb]
GO
ALTER TABLE [dbo].[CType] ADD CONSTRAINT [DF_CType_HistoryModificationType] DEFAULT (0)FOR [HistoryModificationType]
GO
ALTER TABLE [dbo].[CType] ADD CONSTRAINT [DF_CType_HistoryUserType] DEFAULT (0)FOR [HistoryUserType]
GO
ALTER TABLE [dbo].[CType] ADD CONSTRAINT [DF_CType_Indexed] DEFAULT (0)FOR [Indexed]
GO
ALTER TABLE [dbo].[CType] ADD CONSTRAINT [DF_CType_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[CType] ADD CONSTRAINT [DF_CType_IsServerSide] DEFAULT (0)FOR [IsServerSide]
GO
ALTER TABLE [dbo].[CType] ADD CONSTRAINT [DF__CType__GenerateExternal] DEFAULT (0)FOR [GenerateExternal]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_85575343] ON [dbo].[CType]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CType] ADD CONSTRAINT [PK__CType__754F09E8] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[CAttribute] WITH NOCHECK ADD CONSTRAINT [FK__CAttribute__TypeId] FOREIGN KEY ([TypeId]) REFERENCES [dbo].[CType] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[CAttributeList] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NULL,
	[TypeId]			[bigint]			 NOT NULL,
	[Code]				[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[ListId]			[bigint]			 NOT NULL,
	[AllowNull]			[bit]				 NOT NULL,
	[Description]		[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[DbVersion]			[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CAttributeList] ADD CONSTRAINT [DF__CAttribut__GuidI__212D8C26] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[CAttributeList] ADD CONSTRAINT [DF__CAttributeList__Code__DefaultValue] DEFAULT ('')FOR [Code]
GO
ALTER TABLE [dbo].[CAttributeList] ADD CONSTRAINT [DF__CAttributeList__AllowNull__DefaultValue] DEFAULT (0)FOR [AllowNull]
GO
ALTER TABLE [dbo].[CAttributeList] ADD CONSTRAINT [DF_CAttributeList_Description] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[CAttributeList] ADD CONSTRAINT [DF_CAttributeList_REPLID] DEFAULT (newid())FOR [REPLID]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_277576027] ON [dbo].[CAttributeList]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CAttributeList] ADD CONSTRAINT [PK__CAttributeList__203967ED] PRIMARY KEY CLUSTERED ([ID])
GO
CREATE TABLE [dbo].[CAttributeTree] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NULL,
	[TypeId]			[bigint]			 NOT NULL,
	[Code]				[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[TreeId]			[bigint]			 NOT NULL,
	[AllowNull]			[bit]				 NOT NULL,
	[Description]		[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[DbVersion]			[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CAttributeTree] ADD CONSTRAINT [DF__CAttribut__GuidI__3440609A] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[CAttributeTree] ADD CONSTRAINT [DF__CAttributeTree__Code__DefaultValue] DEFAULT ('')FOR [Code]
GO
ALTER TABLE [dbo].[CAttributeTree] ADD CONSTRAINT [DF__CAttributeTree__AllowNull__DefaultValue] DEFAULT (0)FOR [AllowNull]
GO
ALTER TABLE [dbo].[CAttributeTree] ADD CONSTRAINT [DF_CAttributeTree_REPLID] DEFAULT (newid())FOR [REPLID]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_373576369] ON [dbo].[CAttributeTree]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CAttributeTree] ADD CONSTRAINT [PK__CAttributeTree__334C3C61] PRIMARY KEY CLUSTERED ([ID])
GO
CREATE TABLE [dbo].[CTree] (
	[ID]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NULL,
	[Code]			[varchar](35)		 COLLATE Polish_CI_AS NOT NULL,
	[TypeId]		[bigint]			 NOT NULL,
	[MaxWidth]		[int]				 NOT NULL,
	[MaxDepth]		[int]				 NOT NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CTree] ADD CONSTRAINT [DF__CTree__GuidID__04914D78] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[CTree] ADD CONSTRAINT [DF__CTree__Code__DefaultValue] DEFAULT ('')FOR [Code]
GO
ALTER TABLE [dbo].[CTree] ADD CONSTRAINT [DF_CTree_REPLID] DEFAULT (newid())FOR [REPLID]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_453576654] ON [dbo].[CTree]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CTree] ADD CONSTRAINT [PK__CTree__039D293F] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[CAttributeTree] WITH NOCHECK ADD CONSTRAINT [FK__CAttributeTree__TreeID] FOREIGN KEY ([TreeId]) REFERENCES [dbo].[CTree] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[CAttributeTree] WITH NOCHECK ADD CONSTRAINT [FK__CAttributeTree__TypeID] FOREIGN KEY ([TypeId]) REFERENCES [dbo].[CType] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[ChangeLog] (
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[TableChanged]		[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[RowID]				[bigint]			 NOT NULL,
	[Operation]			[char](10)			 COLLATE Polish_CI_AS NOT NULL,
	[Processed]			[bit]				 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[RowGuid]			[uniqueidentifier]	 NULL,
	[TempTableName]		[varchar](50)		 COLLATE Polish_CI_AS NULL,
	[ErrorMessage]		[varchar](2000)		 COLLATE Polish_CI_AS NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChangeLog] ADD CONSTRAINT [DF__ChangeLog__Guid__7F23583C] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[ChangeLog] ADD CONSTRAINT [DF__ChangeLog__Proce__00177C75] DEFAULT (0)FOR [Processed]
GO
ALTER TABLE [dbo].[ChangeLog] ADD CONSTRAINT [DF__ChangeLog__Creat__010BA0AE] DEFAULT (getdate())FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ChangeLog] ADD CONSTRAINT [DF_ChangeLog_REPLID] DEFAULT (newid())FOR [REPLID]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1397580017] ON [dbo].[ChangeLog]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChangeLog] ADD CONSTRAINT [PK_ChangeLog] PRIMARY KEY CLUSTERED ([Guid])
GO
CREATE TABLE [dbo].[CList] (
	[ID]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NULL,
	[Code]			[varchar](35)		 COLLATE Polish_CI_AS NOT NULL,
	[TypeID]		[bigint]			 NOT NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[IsOrdered]		[bit]				 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CList] ADD CONSTRAINT [DF__CList__GuidID__0D269379] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[CList] ADD CONSTRAINT [DF__CList__Code__DefaultValue] DEFAULT ('')FOR [Code]
GO
ALTER TABLE [dbo].[CList] ADD CONSTRAINT [DF_CList_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[CList] ADD CONSTRAINT [DF_CList_IsOrdered] DEFAULT (0)FOR [IsOrdered]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1477580302] ON [dbo].[CList]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CList] ADD CONSTRAINT [PK__CList__0C326F40] PRIMARY KEY CLUSTERED ([ID])
GO
CREATE TABLE [dbo].[CLog] (
	[ID]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NOT NULL,
	[Table]			[varchar](200)		 COLLATE Polish_CI_AS NOT NULL,
	[Column]		[varchar](200)		 COLLATE Polish_CI_AS NULL,
	[DbVersion]		[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[Date]			[datetime]			 NOT NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CLog] ADD CONSTRAINT [DF_CLog_Guid] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[CLog] ADD CONSTRAINT [DF_CLog_REPLID] DEFAULT (newid())FOR [REPLID]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1541580530] ON [dbo].[CLog]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CLog] ADD CONSTRAINT [PK_CLog] PRIMARY KEY CLUSTERED ([ID])
GO
CREATE TABLE [dbo].[CRelation] (
	[ID]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NULL,
	[Code]			[varchar](40)		 COLLATE Polish_CI_AS NOT NULL,
	[Type1ID]		[bigint]			 NOT NULL,
	[Type2ID]		[bigint]			 NOT NULL,
	[DbVersion]		[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CRelation] ADD CONSTRAINT [DF__CRelation__GuidI__7CF02BB0] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[CRelation] ADD CONSTRAINT [DF__CRelation__Code__DefaultValue] DEFAULT ('')FOR [Code]
GO
ALTER TABLE [dbo].[CRelation] ADD CONSTRAINT [DF_CRelation_REPLID] DEFAULT (newid())FOR [REPLID]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1589580701] ON [dbo].[CRelation]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CRelation] ADD CONSTRAINT [PK__CRelation__7BFC0777] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[CRelation] WITH NOCHECK ADD CONSTRAINT [FK__CRelation__Type1ID] FOREIGN KEY ([Type1ID]) REFERENCES [dbo].[CType] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[CRelation] WITH NOCHECK ADD CONSTRAINT [FK__CRelation__Type2ID] FOREIGN KEY ([Type2ID]) REFERENCES [dbo].[CType] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[EHLFlagQuestion] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[OperationType]		[int]				 NOT NULL,
	[OriginalId]		[bigint]			 NOT NULL,
	[CompletedOn]		[datetime]			 NOT NULL,
	[CompletedBy]		[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EHLFlagQuestion] ADD CONSTRAINT [DF__EHLFlagQue__Guid__1CD47DDC] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[EHLFlagQuestion] ADD CONSTRAINT [DF__EHLFlagQuestion__OperationType__DefaultValue] DEFAULT (0)FOR [OperationType]
GO
ALTER TABLE [dbo].[EHLFlagQuestion] ADD CONSTRAINT [DF__EHLFlagQuestion__OriginalId__DefaultValue] DEFAULT (0)FOR [OriginalId]
GO
ALTER TABLE [dbo].[EHLFlagQuestion] ADD CONSTRAINT [DF__EHLFlagQuestion__CompletedOn__DefaultValue] DEFAULT (getdate())FOR [CompletedOn]
GO
ALTER TABLE [dbo].[EHLFlagQuestion] ADD CONSTRAINT [DF_EHLFlagQuestion_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[EHLFlagQuestion] ADD CONSTRAINT [PK__EHLFlagQuestion__1BE059A3] PRIMARY KEY CLUSTERED ([Id])
GO
CREATE TABLE [dbo].[IDTSItem] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[DTSName]				[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[OnlyValidation]		[bit]				 NOT NULL,
	[ErrorMessage]			[text]				 COLLATE Polish_CI_AS NULL,
	[ValidationStatus]		[text]				 COLLATE Polish_CI_AS NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[IDTSItem] ADD CONSTRAINT [DF_IDTSItem_Guid] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[IDTSItem] ADD CONSTRAINT [DF_IDTSItem_REPLID] DEFAULT (newid())FOR [REPLID]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1026102696] ON [dbo].[IDTSItem]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[IDTSItem] ADD CONSTRAINT [PK_IDTSItem] PRIMARY KEY CLUSTERED ([Id])
GO
GRANT DELETE ON [dbo].[IDTSItem] TO [ASTOR\GRZEGORZSZ]
GO
GRANT INSERT ON [dbo].[IDTSItem] TO [ASTOR\GRZEGORZSZ]
GO
GRANT SELECT ON [dbo].[IDTSItem] TO [ASTOR\GRZEGORZSZ]
GO
GRANT UPDATE ON [dbo].[IDTSItem] TO [ASTOR\GRZEGORZSZ]
GO
CREATE TABLE [dbo].[IRValidationItemDTSItem] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1ValidationItemId]	[bigint]			 NOT NULL,
	[R2DTSItemId]			[bigint]			 NOT NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[IRValidationItemDTSItem] ADD CONSTRAINT [DF_IRValidationItemDTSItem_Guid] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[IRValidationItemDTSItem] ADD CONSTRAINT [DF_IRValidationItemDTSItem_REPLID] DEFAULT (newid())FOR [REPLID]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1074102867] ON [dbo].[IRValidationItemDTSItem]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[IRValidationItemDTSItem] ADD CONSTRAINT [PK_IRValidationItemDTSItem] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[IRValidationItemDTSItem] WITH NOCHECK ADD CONSTRAINT [FK_IRValidationItemDTSItem_IDTSItem] FOREIGN KEY ([R2DTSItemId]) REFERENCES [dbo].[IDTSItem] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LTemplate] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NULL,
	[Subject]				[text]				 COLLATE Polish_CI_AS NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[Body]					[text]				 COLLATE Polish_CI_AS NULL,
	[TemplateFormatId]		[bigint]			 NOT NULL,
	[EncodingId]			[bigint]			 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LTemplate] ADD CONSTRAINT [DF__LMailingMe__Guid__0822B291] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LTemplate] ADD CONSTRAINT [DF__LMailingMessage__Subject__DefaultValue] DEFAULT ('')FOR [Subject]
GO
ALTER TABLE [dbo].[LTemplate] ADD CONSTRAINT [DF__LMailingMessage__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LTemplate] ADD CONSTRAINT [DF_LTemplate_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LTemplate] ADD CONSTRAINT [DF_LTemplate_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LTemplate] ADD CONSTRAINT [DF_LTemplate_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LTemplate] ADD CONSTRAINT [DF_LTemplate_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1563152614] ON [dbo].[LTemplate]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LTemplate] ADD CONSTRAINT [PK__LMailingMessage__072E8E58] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LTemplate] WITH NOCHECK ADD CONSTRAINT [FK__LTemplate__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LEncoding] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NULL,
	[Name]				[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LEncoding] ADD CONSTRAINT [DF__LMailEncod__Guid__4343785F] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LEncoding] ADD CONSTRAINT [DF__LMailEncoding__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LEncoding] ADD CONSTRAINT [DF__LMailEncoding__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LEncoding] ADD CONSTRAINT [DF_LEncoding_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LEncoding] ADD CONSTRAINT [DF_LEncoding_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LEncoding] ADD CONSTRAINT [DF_LEncoding_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LEncoding] ADD CONSTRAINT [DF_LEncoding_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_750625717] ON [dbo].[LEncoding]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LEncoding] ADD CONSTRAINT [PK__LMailEncoding__424F5426] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LEncoding] WITH NOCHECK ADD CONSTRAINT [FK__LEncoding__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LEncoding] WITH NOCHECK ADD CONSTRAINT [FK__LEncoding__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LTemplate] WITH NOCHECK ADD CONSTRAINT [FK__LTemplate__EncodingId] FOREIGN KEY ([EncodingId]) REFERENCES [dbo].[LEncoding] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LTemplate] WITH NOCHECK ADD CONSTRAINT [FK__LTemplate__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LCounter] WITH NOCHECK ADD CONSTRAINT [FK__LCounter__TemplateId] FOREIGN KEY ([TemplateId]) REFERENCES [dbo].[LTemplate] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LDatabaseLogOperation] (
	[Id]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NOT NULL,
	[Name]			[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LDatabaseLogOperation] ADD CONSTRAINT [DF__LDatabaseL__Guid__511274C9] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LDatabaseLogOperation] ADD CONSTRAINT [DF__LDatabaseLogOperation__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LDatabaseLogOperation] ADD CONSTRAINT [DF_LDatabaseLogOperation_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LDatabaseLogOperation] ADD CONSTRAINT [DF_LDatabaseLogOperation_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LDatabaseLogOperation] ADD CONSTRAINT [DF_LDatabaseLogOperation_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LDatabaseLogOperation] ADD CONSTRAINT [DF_LDatabaseLogOperation_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_270624007] ON [dbo].[LDatabaseLogOperation]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LDatabaseLogOperation] ADD CONSTRAINT [PK__LDatabaseLogOper__501E5090] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LDatabaseLogOperation] WITH NOCHECK ADD CONSTRAINT [FK__LDatabaseLogOperation__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LDatabaseLogOperation] WITH NOCHECK ADD CONSTRAINT [FK__LDatabaseLogOperation__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LEmailType] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[Name]				[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[Index]				[int]				 NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LEmailType] ADD CONSTRAINT [DF__LEmailType__Guid__1D88AF22] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LEmailType] ADD CONSTRAINT [DF__LEmailType__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LEmailType] ADD CONSTRAINT [DF__LEmailType__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LEmailType] ADD CONSTRAINT [DF__LEmailType__Index__DefaultValue] DEFAULT (0)FOR [Index]
GO
ALTER TABLE [dbo].[LEmailType] ADD CONSTRAINT [DF_LEmailType_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LEmailType] ADD CONSTRAINT [DF_LEmailType_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LEmailType] ADD CONSTRAINT [DF_LEmailType_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LEmailType] ADD CONSTRAINT [DF_LEmailType_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_622625261] ON [dbo].[LEmailType]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LEmailType] ADD CONSTRAINT [PK__LEmailType__1C948AE9] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LEmailType] WITH NOCHECK ADD CONSTRAINT [FK__LEmailType__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LEmailType] WITH NOCHECK ADD CONSTRAINT [FK__LEmailType__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LEventCompanyRole] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NULL,
	[Description]		[varchar](500)		 COLLATE Polish_CI_AS NOT NULL,
	[Name]				[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LEventCompanyRole] ADD CONSTRAINT [DF__LEventCom__GuidI__3B2D554B] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LEventCompanyRole] ADD CONSTRAINT [DF__LEventCompanyRole__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LEventCompanyRole] ADD CONSTRAINT [DF__LEventCompanyRole__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LEventCompanyRole] ADD CONSTRAINT [DF_LEventCompanyRole_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LEventCompanyRole] ADD CONSTRAINT [DF_LEventCompanyRole_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LEventCompanyRole] ADD CONSTRAINT [DF_LEventCompanyRole_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LEventCompanyRole] ADD CONSTRAINT [DF_LEventCompanyRole_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_862626116] ON [dbo].[LEventCompanyRole]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LEventCompanyRole] ADD CONSTRAINT [PK__LEventCompanyRol__3A393112] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[LEventCompanyRole] WITH NOCHECK ADD CONSTRAINT [FK__LEventCompanyRole__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LEventCompanyRole] WITH NOCHECK ADD CONSTRAINT [FK__LEventCompanyRole__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LEventPersonRole] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NULL,
	[Description]		[varchar](500)		 COLLATE Polish_CI_AS NOT NULL,
	[Name]				[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LEventPersonRole] ADD CONSTRAINT [DF__LEventPer__GuidI__3850E8A0] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LEventPersonRole] ADD CONSTRAINT [DF__LEventPersonRole__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LEventPersonRole] ADD CONSTRAINT [DF__LEventPersonRole__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LEventPersonRole] ADD CONSTRAINT [DF_LEventPersonRole_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LEventPersonRole] ADD CONSTRAINT [DF_LEventPersonRole_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LEventPersonRole] ADD CONSTRAINT [DF_LEventPersonRole_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LEventPersonRole] ADD CONSTRAINT [DF_LEventPersonRole_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_974626515] ON [dbo].[LEventPersonRole]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LEventPersonRole] ADD CONSTRAINT [PK__LEventPersonRole__375CC467] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[LEventPersonRole] WITH NOCHECK ADD CONSTRAINT [FK__LEventPersonRole__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LEventPersonRole] WITH NOCHECK ADD CONSTRAINT [FK__LEventPersonRole__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LEventRole] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[Index]				[int]				 NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[Name]				[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LEventRole] ADD CONSTRAINT [DF__LEventRole__Guid__00307F92] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LEventRole] ADD CONSTRAINT [DF__LEventRole__Index__DefaultValue] DEFAULT (0)FOR [Index]
GO
ALTER TABLE [dbo].[LEventRole] ADD CONSTRAINT [DF__LEventRole__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LEventRole] ADD CONSTRAINT [DF__LEventRole__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LEventRole] ADD CONSTRAINT [DF__LEventRol__REPLI__05E958E8] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LEventRole] ADD CONSTRAINT [DF_LEventRole_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LEventRole] ADD CONSTRAINT [DF_LEventRole_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LEventRole] ADD CONSTRAINT [DF_LEventRole_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2118661920] ON [dbo].[LEventRole]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LEventRole] ADD CONSTRAINT [PK__LEventRole__7F3C5B59] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LEventRole] WITH NOCHECK ADD CONSTRAINT [FK__LEventRole__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LEventRole] WITH NOCHECK ADD CONSTRAINT [FK__LEventRole__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LExternalSupportType] (
	[ID]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NULL,
	[Name]						[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]				[varchar](2000)		 COLLATE Polish_CI_AS NOT NULL,
	[Email]						[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[EmailSubject]				[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[SRDescriptionPattern]		[varchar](200)		 COLLATE Polish_CI_AS NOT NULL,
	[SRNamingPattern]			[varchar](200)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[CreatedOn]					[datetime]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LExternalSupportType] ADD CONSTRAINT [DF__LExternalS__Guid__5912BDED] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LExternalSupportType] ADD CONSTRAINT [DF__LExternalSupportType__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LExternalSupportType] ADD CONSTRAINT [DF__LExternalSupportType__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LExternalSupportType] ADD CONSTRAINT [DF__LExternalSupportType__Email__DefaultValue] DEFAULT ('')FOR [Email]
GO
ALTER TABLE [dbo].[LExternalSupportType] ADD CONSTRAINT [DF__LExternalSupportType__EmailSubject__DefaultValue] DEFAULT ('')FOR [EmailSubject]
GO
ALTER TABLE [dbo].[LExternalSupportType] ADD CONSTRAINT [DF__LExternalSupportType__SRDescriptionPattern__DefaultValue] DEFAULT ('')FOR [SRDescriptionPattern]
GO
ALTER TABLE [dbo].[LExternalSupportType] ADD CONSTRAINT [DF__LExternalSupportType__SRNamingPattern__DefaultValue] DEFAULT ('')FOR [SRNamingPattern]
GO
ALTER TABLE [dbo].[LExternalSupportType] ADD CONSTRAINT [DF_LExternalSupportType_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LExternalSupportType] ADD CONSTRAINT [DF_LExternalSupportType_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LExternalSupportType] ADD CONSTRAINT [DF_LExternalSupportType_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LExternalSupportType] ADD CONSTRAINT [DF_LExternalSupportType_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1182627256] ON [dbo].[LExternalSupportType]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LExternalSupportType] ADD CONSTRAINT [PK__LExternalSupport__581E99B4] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[LExternalSupportType] WITH NOCHECK ADD CONSTRAINT [FK__LExternalSupportType__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LExternalSupportType] WITH NOCHECK ADD CONSTRAINT [FK__LExternalSupportType__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LFlagQuestionSuggestedAnswer] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NULL,
	[Content]			[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[FlagQuestionId]	[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LFlagQuestionSuggestedAnswer] ADD CONSTRAINT [DF__LFlagQuest__Guid__50486DC2] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LFlagQuestionSuggestedAnswer] ADD CONSTRAINT [DF__LFlagQuestionSuggestedAnswer__Content__DefaultValue] DEFAULT ('')FOR [Content]
GO
ALTER TABLE [dbo].[LFlagQuestionSuggestedAnswer] ADD CONSTRAINT [DF_LFlagQuestionSuggestedAnswer_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LFlagQuestionSuggestedAnswer] ADD CONSTRAINT [DF_LFlagQuestionSuggestedAnswer_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LFlagQuestionSuggestedAnswer] ADD CONSTRAINT [DF_LFlagQuestionSuggestedAnswer_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LFlagQuestionSuggestedAnswer] ADD CONSTRAINT [DF_LFlagQuestionSuggestedAnswer_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1470628282] ON [dbo].[LFlagQuestionSuggestedAnswer]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LFlagQuestionSuggestedAnswer] ADD CONSTRAINT [PK__LFlagQuestionSug__4F544989] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LFlagQuestionSuggestedAnswer] WITH NOCHECK ADD CONSTRAINT [FK__LFlagQuestionSuggestedAnswer__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LFlagQuestionSuggestedAnswer] WITH NOCHECK ADD CONSTRAINT [FK__LFlagQuestionSuggestedAnswer__FlagQuestionId] FOREIGN KEY ([FlagQuestionId]) REFERENCES [dbo].[LFlagQuestion] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LFlagQuestionSuggestedAnswer] WITH NOCHECK ADD CONSTRAINT [FK__LFlagQuestionSuggestedAnswer__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LFlagType] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NULL,
	[Type]				[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[RelatedType]		[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LFlagType] ADD CONSTRAINT [DF__LFlagType__Guid__6A3D49EF] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LFlagType] ADD CONSTRAINT [DF__LFlagType__ClassName__DefaultValue] DEFAULT ('')FOR [Type]
GO
ALTER TABLE [dbo].[LFlagType] ADD CONSTRAINT [DF__LFlagType__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LFlagType] ADD CONSTRAINT [DF__LFlagType__RelatedType__DefaultValue] DEFAULT ('')FOR [RelatedType]
GO
ALTER TABLE [dbo].[LFlagType] ADD CONSTRAINT [DF_LFlagType_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LFlagType] ADD CONSTRAINT [DF_LFlagType_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LFlagType] ADD CONSTRAINT [DF_LFlagType_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LFlagType] ADD CONSTRAINT [DF_LFlagType_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1582628681] ON [dbo].[LFlagType]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LFlagType] ADD CONSTRAINT [PK__LFlagType__694925B6] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[LFlagType] WITH NOCHECK ADD CONSTRAINT [FK__LFlagType__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LFlagType] WITH NOCHECK ADD CONSTRAINT [FK__LFlagType__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LFolder] (
	[ID]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NOT NULL,
	[URIPrefix]					[varchar](200)		 COLLATE Polish_CI_AS NOT NULL,
	[Name]						[varchar](200)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]				[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[AlternativeURIPrefix]		[varchar](2000)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[CreatedOn]					[datetime]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LFolder] ADD CONSTRAINT [DF__OFolders__GuidID__34956655] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LFolder] ADD CONSTRAINT [DF__OFolders__URIPrefix__DefaultValue] DEFAULT ('')FOR [URIPrefix]
GO
ALTER TABLE [dbo].[LFolder] ADD CONSTRAINT [DF__OFolders__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LFolder] ADD CONSTRAINT [DF__OFolders__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LFolder] ADD CONSTRAINT [DF__LFolder__AlternativeURIPrefix__DefaultValue] DEFAULT ('')FOR [AlternativeURIPrefix]
GO
ALTER TABLE [dbo].[LFolder] ADD CONSTRAINT [DF_LFolder_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LFolder] ADD CONSTRAINT [DF_LFolder_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LFolder] ADD CONSTRAINT [DF_LFolder_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LFolder] ADD CONSTRAINT [DF_LFolder_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1710629137] ON [dbo].[LFolder]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LFolder] ADD CONSTRAINT [PK__OFolders__33A1421C] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[LFolder] WITH NOCHECK ADD CONSTRAINT [FK__LFolder__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LFolder] WITH NOCHECK ADD CONSTRAINT [FK__LFolder__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[LFolder] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[LFolderType] (
	[Id]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NOT NULL,
	[Index]			[int]				 NOT NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[Name]			[varchar](200)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LFolderType] ADD CONSTRAINT [DF__LFolderTyp__Guid__29D9A938] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LFolderType] ADD CONSTRAINT [DF__LFolderType__Index__DefaultValue] DEFAULT (0)FOR [Index]
GO
ALTER TABLE [dbo].[LFolderType] ADD CONSTRAINT [DF__LFolderType__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LFolderType] ADD CONSTRAINT [DF_LFolderType_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LFolderType] ADD CONSTRAINT [DF_LFolderType_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LFolderType] ADD CONSTRAINT [DF_LFolderType_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LFolderType] ADD CONSTRAINT [DF_LFolderType_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1118131970] ON [dbo].[LFolderType]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LFolderType] ADD CONSTRAINT [PK__LFolderType__28E584FF] PRIMARY KEY CLUSTERED ([Id])
GO
CREATE TABLE [dbo].[LGraphicType] (
	[ID]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NULL,
	[Name]			[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LGraphicType] ADD CONSTRAINT [DF__LGraphicT__GuidI__0ABF281A] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LGraphicType] ADD CONSTRAINT [DF__LGraphicType__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LGraphicType] ADD CONSTRAINT [DF_LGraphicType_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LGraphicType] ADD CONSTRAINT [DF_LGraphicType_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LGraphicType] ADD CONSTRAINT [DF_LGraphicType_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LGraphicType] ADD CONSTRAINT [DF_LGraphicType_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1854629650] ON [dbo].[LGraphicType]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LGraphicType] ADD CONSTRAINT [PK__LGraphicType__09CB03E1] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[LGraphicType] WITH NOCHECK ADD CONSTRAINT [FK__LGraphicType__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LGraphicType] WITH NOCHECK ADD CONSTRAINT [FK__LGraphicType__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LLanguage] (
	[Id]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NULL,
	[Name]			[varchar](100)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LLanguage] ADD CONSTRAINT [DF__LLanguage__Guid__70B53D54] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LLanguage] ADD CONSTRAINT [DF__LLanguage__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LLanguage] ADD CONSTRAINT [DF_LLanguage_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LLanguage] ADD CONSTRAINT [DF_LLanguage_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LLanguage] ADD CONSTRAINT [DF_LLanguage_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LLanguage] ADD CONSTRAINT [DF_LLanguage_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1950629992] ON [dbo].[LLanguage]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LLanguage] ADD CONSTRAINT [PK__LLanguage__6FC1191B] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LLanguage] WITH NOCHECK ADD CONSTRAINT [FK__LLanguage__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LLanguage] WITH NOCHECK ADD CONSTRAINT [FK__LLanguage__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[LLanguage] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[LLoyaltyCardCompanyType] (
	[Id]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NULL,
	[Name]			[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LLoyaltyCardCompanyType] ADD CONSTRAINT [DF__LLoyaltyCa__Guid__09B5F548] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LLoyaltyCardCompanyType] ADD CONSTRAINT [DF__LLoyaltyCardCompanyType__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LLoyaltyCardCompanyType] ADD CONSTRAINT [DF_LLoyaltyCardCompanyType_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LLoyaltyCardCompanyType] ADD CONSTRAINT [DF_LLoyaltyCardCompanyType_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LLoyaltyCardCompanyType] ADD CONSTRAINT [DF_LLoyaltyCardCompanyType_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LLoyaltyCardCompanyType] ADD CONSTRAINT [DF_LLoyaltyCardCompanyType_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2046630334] ON [dbo].[LLoyaltyCardCompanyType]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LLoyaltyCardCompanyType] ADD CONSTRAINT [PK__LLoyaltyCardComp__08C1D10F] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LLoyaltyCardCompanyType] WITH NOCHECK ADD CONSTRAINT [FK__LLoyaltyCardCompanyType__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LLoyaltyCardCompanyType] WITH NOCHECK ADD CONSTRAINT [FK__LLoyaltyCardCompanyType__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[LLoyaltyCardCompanyType] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[LLoyaltyCardType] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NULL,
	[Name]					[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[LetterColor]			[int]				 NOT NULL,
	[BackgroundColor]		[int]				 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LLoyaltyCardType] ADD CONSTRAINT [DF__LLoyaltyCa__Guid__11571710] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LLoyaltyCardType] ADD CONSTRAINT [DF__LLoyaltyCardType__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LLoyaltyCardType] ADD CONSTRAINT [DF__LLoyaltyCardType__LetterColor__DefaultValue] DEFAULT (0)FOR [LetterColor]
GO
ALTER TABLE [dbo].[LLoyaltyCardType] ADD CONSTRAINT [DF__LLoyaltyCardType__BackgroundColor__DefaultValue] DEFAULT (0)FOR [BackgroundColor]
GO
ALTER TABLE [dbo].[LLoyaltyCardType] ADD CONSTRAINT [DF_LLoyaltyCardType_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LLoyaltyCardType] ADD CONSTRAINT [DF_LLoyaltyCardType_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LLoyaltyCardType] ADD CONSTRAINT [DF_LLoyaltyCardType_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LLoyaltyCardType] ADD CONSTRAINT [DF_LLoyaltyCardType_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2142630676] ON [dbo].[LLoyaltyCardType]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LLoyaltyCardType] ADD CONSTRAINT [PK__LLoyaltyCardType__1062F2D7] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LLoyaltyCardType] WITH NOCHECK ADD CONSTRAINT [FK__LLoyaltyCardType__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LLoyaltyCardType] WITH NOCHECK ADD CONSTRAINT [FK__LLoyaltyCardType__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[LLoyaltyCardType] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[LMailingSender] (
	[Id]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NOT NULL,
	[FirstName]		[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[Surname]		[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[Email]			[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[ReplyTo]		[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LMailingSender] ADD CONSTRAINT [DF__LMailingSe__Guid__4848249E] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LMailingSender] ADD CONSTRAINT [DF__LMailingSender__FirstName__DefaultValue] DEFAULT ('')FOR [FirstName]
GO
ALTER TABLE [dbo].[LMailingSender] ADD CONSTRAINT [DF__LMailingSender__Surname__DefaultValue] DEFAULT ('')FOR [Surname]
GO
ALTER TABLE [dbo].[LMailingSender] ADD CONSTRAINT [DF__LMailingSender__Email__DefaultValue] DEFAULT ('')FOR [Email]
GO
ALTER TABLE [dbo].[LMailingSender] ADD CONSTRAINT [DF__LMailingSender__ReplyTo__DefaultValue] DEFAULT ('')FOR [ReplyTo]
GO
ALTER TABLE [dbo].[LMailingSender] ADD CONSTRAINT [DF_LMailingSender_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LMailingSender] ADD CONSTRAINT [DF_LMailingSender_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LMailingSender] ADD CONSTRAINT [DF_LMailingSender_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LMailingSender] ADD CONSTRAINT [DF_LMailingSender_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_123147484] ON [dbo].[LMailingSender]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LMailingSender] ADD CONSTRAINT [PK__LMailingSender__47540065] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LMailingSender] WITH NOCHECK ADD CONSTRAINT [FK__LMailingSender__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LMailingSender] WITH NOCHECK ADD CONSTRAINT [FK__LMailingSender__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LOccupationStatus] (
	[ID]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NULL,
	[Name]					[varchar](30)		 COLLATE Polish_CI_AS NULL,
	[LetterColor]			[int]				 NOT NULL,
	[BackgroundColor]		[int]				 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[NotWorking]			[bit]				 NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LOccupationStatus] ADD CONSTRAINT [DF__LOccupatio__Guid__6C8FA6B5] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LOccupationStatus] ADD CONSTRAINT [DF__LOccupationStatus__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LOccupationStatus] ADD CONSTRAINT [DF__LOccupationStatus__LetterColor__DefaultValue] DEFAULT (0)FOR [LetterColor]
GO
ALTER TABLE [dbo].[LOccupationStatus] ADD CONSTRAINT [DF__LOccupationStatus__BackgroundColor__DefaultValue] DEFAULT (0)FOR [BackgroundColor]
GO
ALTER TABLE [dbo].[LOccupationStatus] ADD CONSTRAINT [DF_LOccupationStatus_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LOccupationStatus] ADD CONSTRAINT [DF__LOccupationStatus__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LOccupationStatus] ADD CONSTRAINT [DF_LOccupationStatus_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LOccupationStatus] ADD CONSTRAINT [DF_LOccupationStatus_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LOccupationStatus] ADD CONSTRAINT [DF_LOccupationStatus_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_267147997] ON [dbo].[LOccupationStatus]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LOccupationStatus] ADD CONSTRAINT [PK__LOccupationStatu__6B9B827C] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[LOccupationStatus] WITH NOCHECK ADD CONSTRAINT [FK__LOccupationStatus__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LOccupationStatus] WITH NOCHECK ADD CONSTRAINT [FK__LOccupationStatus__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LPersonTitle] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[Name]					[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[Index]					[int]				 NOT NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[AlternativeNames]		[varchar](500)		 COLLATE Polish_CI_AS NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LPersonTitle] ADD CONSTRAINT [DF__LPersonTit__Guid__16DBB193] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LPersonTitle] ADD CONSTRAINT [DF__LPersonTitle__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LPersonTitle] ADD CONSTRAINT [DF__LPersonTitle__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LPersonTitle] ADD CONSTRAINT [DF__LPersonTitle__Index__DefaultValue] DEFAULT (0)FOR [Index]
GO
ALTER TABLE [dbo].[LPersonTitle] ADD CONSTRAINT [DF_LPersonTitle_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LPersonTitle] ADD CONSTRAINT [DF_LPersonTitle_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LPersonTitle] ADD CONSTRAINT [DF_LPersonTitle_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LPersonTitle] ADD CONSTRAINT [DF_LPersonTitle_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_395148453] ON [dbo].[LPersonTitle]([REPLID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_LPersonTitle] ON [dbo].[LPersonTitle]([Id], [Name]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LPersonTitle] ADD CONSTRAINT [PK__LPersonTitle__15E78D5A] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LPersonTitle] WITH NOCHECK ADD CONSTRAINT [FK__LPersonTitle__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LPersonTitle] WITH NOCHECK ADD CONSTRAINT [FK__LPersonTitle__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[LPersonTitle] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[LPhonePrefix] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[DefaultPrefix]		[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LPhonePrefix] ADD CONSTRAINT [DF__LPhonePref__Guid__7BFCD2CE] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LPhonePrefix] ADD CONSTRAINT [DF__LPhonePrefix__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LPhonePrefix] ADD CONSTRAINT [DF__LPhonePrefix__DefaultPrefix__DefaultValue] DEFAULT ('')FOR [DefaultPrefix]
GO
ALTER TABLE [dbo].[LPhonePrefix] ADD CONSTRAINT [DF_LPhonePrefix_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LPhonePrefix] ADD CONSTRAINT [DF_LPhonePrefix_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LPhonePrefix] ADD CONSTRAINT [DF_LPhonePrefix_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LPhonePrefix] ADD CONSTRAINT [DF_LPhonePrefix_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_523148909] ON [dbo].[LPhonePrefix]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LPhonePrefix] ADD CONSTRAINT [PK__LPhonePrefix__7B08AE95] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LPhonePrefix] WITH NOCHECK ADD CONSTRAINT [FK__LPhonePrefix__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LPhonePrefix] WITH NOCHECK ADD CONSTRAINT [FK__LPhonePrefix__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LPhoneProvider] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[DefaultPrefix]		[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LPhoneProvider] ADD CONSTRAINT [DF__LPhoneProv__Guid__7ED93F79] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LPhoneProvider] ADD CONSTRAINT [DF__LPhoneProvider__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LPhoneProvider] ADD CONSTRAINT [DF__LPhoneProvider__DefaultPrefix__DefaultValue] DEFAULT ('')FOR [DefaultPrefix]
GO
ALTER TABLE [dbo].[LPhoneProvider] ADD CONSTRAINT [DF_LPhoneProvider_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LPhoneProvider] ADD CONSTRAINT [DF_LPhoneProvider_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LPhoneProvider] ADD CONSTRAINT [DF_LPhoneProvider_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LPhoneProvider] ADD CONSTRAINT [DF_LPhoneProvider_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_635149308] ON [dbo].[LPhoneProvider]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LPhoneProvider] ADD CONSTRAINT [PK__LPhoneProvider__7DE51B40] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LPhoneProvider] WITH NOCHECK ADD CONSTRAINT [FK__LPhoneProvider__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LPhoneProvider] WITH NOCHECK ADD CONSTRAINT [FK__LPhoneProvider__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LPhoneType] (
	[ID]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NULL,
	[Name]						[varchar](30)		 COLLATE Polish_CI_AS NULL,
	[Description]				[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[DefaultNumberFormat]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[CreatedOn]					[datetime]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[Index]						[int]				 NOT NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[Hidden]					[bit]				 NOT NULL,
	[DisplayFormat]				[varchar](310)		 COLLATE Polish_CI_AS NOT NULL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LPhoneType] ADD CONSTRAINT [DF__LPhoneTyp__GuidI__2EFC8890] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LPhoneType] ADD CONSTRAINT [DF__LPhoneType__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LPhoneType] ADD CONSTRAINT [DF__LPhoneType__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LPhoneType] ADD CONSTRAINT [DF__LPhoneType__DefaultNumberFormat__DefaultValue] DEFAULT ('')FOR [DefaultNumberFormat]
GO
ALTER TABLE [dbo].[LPhoneType] ADD CONSTRAINT [DF__LPhoneType__Index__DefaultValue] DEFAULT (0)FOR [Index]
GO
ALTER TABLE [dbo].[LPhoneType] ADD CONSTRAINT [DF_LPhoneType_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LPhoneType] ADD CONSTRAINT [DF__LPhoneTyp__Hidde__16461B29] DEFAULT (0)FOR [Hidden]
GO
ALTER TABLE [dbo].[LPhoneType] ADD CONSTRAINT [DF__LPhoneTyp__Displ__0F1D59D3] DEFAULT ('')FOR [DisplayFormat]
GO
ALTER TABLE [dbo].[LPhoneType] ADD CONSTRAINT [DF_LPhoneType_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LPhoneType] ADD CONSTRAINT [DF_LPhoneType_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LPhoneType] ADD CONSTRAINT [DF_LPhoneType_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_747149707] ON [dbo].[LPhoneType]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LPhoneType] ADD CONSTRAINT [PK__LPhoneType__2E086457] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[LPhoneType] WITH NOCHECK ADD CONSTRAINT [FK__LPhoneType__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LPhoneType] WITH NOCHECK ADD CONSTRAINT [FK__LPhoneType__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[LPhoneType] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[LProjectItemBonusType] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[Name]				[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[MinValue]			[real]				 NOT NULL,
	[MaxValue]			[real]				 NOT NULL,
	[DefaultValue]		[real]				 NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LProjectItemBonusType] ADD CONSTRAINT [DF__LProjectIt__Guid__3780B47C] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LProjectItemBonusType] ADD CONSTRAINT [DF__LProjectItemBonusType__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LProjectItemBonusType] ADD CONSTRAINT [DF__LProjectItemBonusType__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LProjectItemBonusType] ADD CONSTRAINT [DF__LProjectItemBonusType__MinValue__DefaultValue] DEFAULT (0)FOR [MinValue]
GO
ALTER TABLE [dbo].[LProjectItemBonusType] ADD CONSTRAINT [DF__LProjectItemBonusType__MaxValue__DefaultValue] DEFAULT (0)FOR [MaxValue]
GO
ALTER TABLE [dbo].[LProjectItemBonusType] ADD CONSTRAINT [DF__LProjectItemBonusType__DefaultValue__DefaultValue] DEFAULT (0)FOR [DefaultValue]
GO
ALTER TABLE [dbo].[LProjectItemBonusType] ADD CONSTRAINT [DF__LProjectI__REPLI__3F21D644] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LProjectItemBonusType] ADD CONSTRAINT [DF_LProjectItemBonusType_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LProjectItemBonusType] ADD CONSTRAINT [DF_LProjectItemBonusType_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LProjectItemBonusType] ADD CONSTRAINT [DF_LProjectItemBonusType_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_899181578] ON [dbo].[LProjectItemBonusType]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LProjectItemBonusType] ADD CONSTRAINT [PK__LProjectItemBonu__368C9043] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LProjectItemBonusType] WITH NOCHECK ADD CONSTRAINT [FK__LProjectItemBonusType__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LProjectItemBonusType] WITH NOCHECK ADD CONSTRAINT [FK__LProjectItemBonusType__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LProjectItemDateType] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[Name]				[varchar](30)		 COLLATE Polish_CI_AS NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LProjectItemDateType] ADD CONSTRAINT [DF__LProjectIt__Guid__5889795F] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LProjectItemDateType] ADD CONSTRAINT [DF__LProjectItemDateType__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LProjectItemDateType] ADD CONSTRAINT [DF__LProjectItemDateType__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LProjectItemDateType] ADD CONSTRAINT [DF_LProjectItemDateType_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LProjectItemDateType] ADD CONSTRAINT [DF_LProjectItemDateType_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LProjectItemDateType] ADD CONSTRAINT [DF_LProjectItemDateType_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LProjectItemDateType] ADD CONSTRAINT [DF_LProjectItemDateType_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2085582468] ON [dbo].[LProjectItemDateType]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LProjectItemDateType] ADD CONSTRAINT [PK__LProjectItemDate__57955526] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LProjectItemDateType] WITH NOCHECK ADD CONSTRAINT [FK__LProjectItemDateType__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LProjectItemDateType] WITH NOCHECK ADD CONSTRAINT [FK__LProjectItemDateType__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LProjectItemRole] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[Name]				[varchar](30)		 COLLATE Polish_CI_AS NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[Index]				[int]				 NOT NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LProjectItemRole] ADD CONSTRAINT [DF__LProjectIt__Guid__0B14F92C] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LProjectItemRole] ADD CONSTRAINT [DF__LProjectItemRole__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LProjectItemRole] ADD CONSTRAINT [DF__LProjectItemRole__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LProjectItemRole] ADD CONSTRAINT [DF_LProjectItemRole_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LProjectItemRole] ADD CONSTRAINT [DF__LprojectI__Index__3C4FC133] DEFAULT (0)FOR [Index]
GO
ALTER TABLE [dbo].[LProjectItemRole] ADD CONSTRAINT [DF_LProjectItemRole_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LProjectItemRole] ADD CONSTRAINT [DF_LProjectItemRole_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LProjectItemRole] ADD CONSTRAINT [DF_LProjectItemRole_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_891150220] ON [dbo].[LProjectItemRole]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LProjectItemRole] ADD CONSTRAINT [PK__LProjectItemRole__0A20D4F3] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LProjectItemRole] WITH NOCHECK ADD CONSTRAINT [FK__LProjectItemRole__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LProjectItemRole] WITH NOCHECK ADD CONSTRAINT [FK__LProjectItemRole__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LProjectItemStatus] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[Name]				[varchar](50)		 COLLATE Polish_CI_AS NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[IsFinal]			[bit]				 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[Index]				[int]				 NOT NULL,
	[Archived]			[bit]				 NOT NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LProjectItemStatus] ADD CONSTRAINT [DF__LProjectIt__Guid__5E4252B5] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LProjectItemStatus] ADD CONSTRAINT [DF__LProjectItemStatus__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LProjectItemStatus] ADD CONSTRAINT [DF__LProjectItemStatus__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LProjectItemStatus] ADD CONSTRAINT [DF__LProjectItemStatus__IsFinal__DefaultValue] DEFAULT (0)FOR [IsFinal]
GO
ALTER TABLE [dbo].[LProjectItemStatus] ADD CONSTRAINT [DF_LProjectItemStatus_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LProjectItemStatus] ADD CONSTRAINT [DF__LProjectItemStatus__Index__DefaultValue] DEFAULT (0)FOR [Index]
GO
ALTER TABLE [dbo].[LProjectItemStatus] ADD CONSTRAINT [DF__LProjectItemStatus__Archived__DefaultValue] DEFAULT (0)FOR [Archived]
GO
ALTER TABLE [dbo].[LProjectItemStatus] ADD CONSTRAINT [DF_LProjectItemStatus_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LProjectItemStatus] ADD CONSTRAINT [DF_LProjectItemStatus_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LProjectItemStatus] ADD CONSTRAINT [DF_LProjectItemStatus_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_66099276] ON [dbo].[LProjectItemStatus]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LProjectItemStatus] ADD CONSTRAINT [PK__LProjectItemStat__5D4E2E7C] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LProjectItemStatus] WITH NOCHECK ADD CONSTRAINT [FK__LProjectItemStatus__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LProjectItemStatus] WITH NOCHECK ADD CONSTRAINT [FK__LProjectItemStatus__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[LProjectItemStatus] TO [formularze2]
GO
CREATE TABLE [dbo].[LResourceCompanyFunction] (
	[Id]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NOT NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LResourceCompanyFunction] ADD CONSTRAINT [DF__LResourceC__Guid__37F357F2] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LResourceCompanyFunction] ADD CONSTRAINT [DF_LResourceCompanyFunction_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LResourceCompanyFunction] ADD CONSTRAINT [DF_LResourceCompanyFunction_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LResourceCompanyFunction] ADD CONSTRAINT [DF_LResourceCompanyFunction_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LResourceCompanyFunction] ADD CONSTRAINT [DF_LResourceCompanyFunction_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1012458931] ON [dbo].[LResourceCompanyFunction]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LResourceCompanyFunction] ADD CONSTRAINT [PK__LResourceCompany__36FF33B9] PRIMARY KEY CLUSTERED ([Id])
GO
CREATE TABLE [dbo].[LResourcePersonFunction] (
	[Id]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NOT NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LResourcePersonFunction] ADD CONSTRAINT [DF__LResourceP__Guid__40889DF3] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LResourcePersonFunction] ADD CONSTRAINT [DF_LResourcePersonFunction_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LResourcePersonFunction] ADD CONSTRAINT [DF_LResourcePersonFunction_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LResourcePersonFunction] ADD CONSTRAINT [DF_LResourcePersonFunction_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LResourcePersonFunction] ADD CONSTRAINT [DF_LResourcePersonFunction_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_884458475] ON [dbo].[LResourcePersonFunction]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LResourcePersonFunction] ADD CONSTRAINT [PK__LResourcePersonF__3F9479BA] PRIMARY KEY CLUSTERED ([Id])
GO
CREATE TABLE [dbo].[LResourceRole] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[Name]				[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LResourceRole] ADD CONSTRAINT [DF__LResourceR__Guid__6370E62D] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LResourceRole] ADD CONSTRAINT [DF__LResourceRole__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LResourceRole] ADD CONSTRAINT [DF__LResourceRole__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LResourceRole] ADD CONSTRAINT [DF_LResourceRole_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LResourceRole] ADD CONSTRAINT [DF_LResourceRole_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LResourceRole] ADD CONSTRAINT [DF_LResourceRole_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LResourceRole] ADD CONSTRAINT [DF_LResourceRole_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_212390209] ON [dbo].[LResourceRole]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LResourceRole] ADD CONSTRAINT [PK__LResourceRole__627CC1F4] PRIMARY KEY CLUSTERED ([Id])
GO
CREATE TABLE [dbo].[LResourceStatus] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[Name]				[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]		[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LResourceStatus] ADD CONSTRAINT [DF__LResourceS__Guid__0C5C5679] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LResourceStatus] ADD CONSTRAINT [DF__LResourceStatus__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LResourceStatus] ADD CONSTRAINT [DF__LResourceStatus__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LResourceStatus] ADD CONSTRAINT [DF_LResourceStatus_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LResourceStatus] ADD CONSTRAINT [DF_LResourceStatus_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LResourceStatus] ADD CONSTRAINT [DF_LResourceStatus_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LResourceStatus] ADD CONSTRAINT [DF_LResourceStatus_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1503382658] ON [dbo].[LResourceStatus]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LResourceStatus] ADD CONSTRAINT [PK__LResourceStatus__0B683240] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LResourceStatus] WITH NOCHECK ADD CONSTRAINT [FK__LResourceStatus__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LResourceStatus] WITH NOCHECK ADD CONSTRAINT [FK__LResourceStatus__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LResourceType] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[Name]				[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[IsPerson]			[bit]				 NOT NULL,
	[IsPlace]			[bit]				 NOT NULL,
	[Disabled]			[bit]				 NOT NULL,
	[IsOrganisation]	[bit]				 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LResourceType] ADD CONSTRAINT [DF__LResourceT__Guid__3DAC3148] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LResourceType] ADD CONSTRAINT [DF__LResourceType__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LResourceType] ADD CONSTRAINT [DF__LResourceType__IsPerson__DefaultValue] DEFAULT (0)FOR [IsPerson]
GO
ALTER TABLE [dbo].[LResourceType] ADD CONSTRAINT [DF__LResourceType__IsPlace__DefaultValue] DEFAULT (0)FOR [IsPlace]
GO
ALTER TABLE [dbo].[LResourceType] ADD CONSTRAINT [DF__LResourceType__Disabled__DefaultValue] DEFAULT (0)FOR [Disabled]
GO
ALTER TABLE [dbo].[LResourceType] ADD CONSTRAINT [DF__LResourceType__IsOrganisation__DefaultValue] DEFAULT (0)FOR [IsOrganisation]
GO
ALTER TABLE [dbo].[LResourceType] ADD CONSTRAINT [DF_LResourceType_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LResourceType] ADD CONSTRAINT [DF_LResourceType_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LResourceType] ADD CONSTRAINT [DF_LResourceType_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LResourceType] ADD CONSTRAINT [DF_LResourceType_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_692457791] ON [dbo].[LResourceType]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LResourceType] ADD CONSTRAINT [PK__LResourceType__3CB80D0F] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LResourceType] WITH NOCHECK ADD CONSTRAINT [FK__LResourceType__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LResourceType] WITH NOCHECK ADD CONSTRAINT [FK__LResourceType__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LSecurityRole] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[Index]				[int]				 NOT NULL,
	[Name]				[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LSecurityRole] ADD CONSTRAINT [DF__LSecurityR__Guid__4BC24285] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LSecurityRole] ADD CONSTRAINT [DF_LSecurityRole_Index_DefaultValue] DEFAULT (0)FOR [Index]
GO
ALTER TABLE [dbo].[LSecurityRole] ADD CONSTRAINT [DF_LSecurityRole_Name_DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LSecurityRole] ADD CONSTRAINT [DF_LSecurityRole_Description_DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LSecurityRole] ADD CONSTRAINT [DF_LSecurityRole_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LSecurityRole] ADD CONSTRAINT [DF_LSecurityRole_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LSecurityRole] ADD CONSTRAINT [DF_LSecurityRole_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
ALTER TABLE [dbo].[LSecurityRole] ADD CONSTRAINT [DF_LSecurityRole_REPLID] DEFAULT (newid())FOR [REPLID]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1239022099] ON [dbo].[LSecurityRole]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LSecurityRole] ADD CONSTRAINT [PK__LSecurityRole__4ACE1E4C] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LSecurityRole] WITH NOCHECK ADD CONSTRAINT [FK__LSecurityRole_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LSecurityRole] WITH NOCHECK ADD CONSTRAINT [FK__LSecurityRole_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LShipmentAddressType] (
	[ID]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NULL,
	[REPLID]		[uniqueidentifier]	 NULL ROWGUIDCOL,
	[Name]			[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[CreatedOn]		[datetime]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LShipmentAddressType] ADD CONSTRAINT [DF_LShipmentAddressType_Guid] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LShipmentAddressType] ADD CONSTRAINT [DF_LShipmentAddressType_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LShipmentAddressType] ADD CONSTRAINT [DF_LShipmentAddressType_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LShipmentAddressType] ADD CONSTRAINT [DF_LShipmentAddressType_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LShipmentAddressType] ADD CONSTRAINT [DF_LShipmentAddressType_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1350412726] ON [dbo].[LShipmentAddressType]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LShipmentAddressType] ADD CONSTRAINT [PK_LShipmentAddressType] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[LShipmentAddressType] WITH NOCHECK ADD CONSTRAINT [FK__LShipmentAddressType_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT DELETE ON [dbo].[LShipmentAddressType] TO [BDKProgramyZewnetrzne]
GO
GRANT INSERT ON [dbo].[LShipmentAddressType] TO [BDKProgramyZewnetrzne]
GO
GRANT SELECT ON [dbo].[LShipmentAddressType] TO [BDKProgramyZewnetrzne]
GO
GRANT UPDATE ON [dbo].[LShipmentAddressType] TO [BDKProgramyZewnetrzne]
GO
CREATE TABLE [dbo].[LShipmentParameter] (
	[ID]							[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]							[uniqueidentifier]	 NOT NULL,
	[REPLID]						[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[ShipmentParameterGroupId]		[bigint]			 NOT NULL,
	[Name]							[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]					[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[IsRequired]					[bit]				 NOT NULL,
	[DataType]						[varchar](20)		 COLLATE Polish_CI_AS NOT NULL,
	[DefaultValue]					[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[TemplateCode]					[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[ParameterOrder]				[int]				 NOT NULL,
	[IsReadOnly]					[bit]				 NOT NULL,
	[ParameterPack]					[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[CreatedOn]						[datetime]			 NULL,
	[CreatedBy]						[bigint]			 NULL,
	[ModifiedOn]					[datetime]			 NULL,
	[ModifiedBy]					[bigint]			 NULL,
	[SecR]							[bigint]			 NOT NULL,
	[SecW]							[bigint]			 NOT NULL,
	[SecD]							[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LShipmentParameter] ADD CONSTRAINT [DF_LShipmentParameter_Guid] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LShipmentParameter] ADD CONSTRAINT [DF_LShipmentParameter_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LShipmentParameter] ADD CONSTRAINT [DF_LShipmentParameter_Name] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LShipmentParameter] ADD CONSTRAINT [DF_LShipmentParameter_Description] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LShipmentParameter] ADD CONSTRAINT [DF_LShipmentParameter_IsRequired] DEFAULT (0)FOR [IsRequired]
GO
ALTER TABLE [dbo].[LShipmentParameter] ADD CONSTRAINT [DF_LShipmentParameter_DataType] DEFAULT ('')FOR [DataType]
GO
ALTER TABLE [dbo].[LShipmentParameter] ADD CONSTRAINT [DF_LShipmentParameter_Index] DEFAULT (0)FOR [ParameterOrder]
GO
ALTER TABLE [dbo].[LShipmentParameter] ADD CONSTRAINT [DF_LShipmentParameter_IsreadOnly] DEFAULT (0)FOR [IsReadOnly]
GO
ALTER TABLE [dbo].[LShipmentParameter] ADD CONSTRAINT [DF_LShipmentParameter_ParamGroup] DEFAULT ('')FOR [ParameterPack]
GO
ALTER TABLE [dbo].[LShipmentParameter] ADD CONSTRAINT [DF_LShipmentParameter_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LShipmentParameter] ADD CONSTRAINT [DF_LShipmentParameter_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LShipmentParameter] ADD CONSTRAINT [DF_LShipmentParameter_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1414412954] ON [dbo].[LShipmentParameter]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LShipmentParameter] ADD CONSTRAINT [PK_LShipmentParameter] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[LShipmentParameter] WITH NOCHECK ADD CONSTRAINT [FK__LShipmentParameter_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LShipmentParameter] WITH NOCHECK ADD CONSTRAINT [FK__LShipmentParameter_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LShipmentParameterGroup] (
	[ID]							[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]							[uniqueidentifier]	 NOT NULL,
	[REPLID]						[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[Name]							[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[IsActive]						[bit]				 NOT NULL,
	[SenderCode]					[varchar](20)		 COLLATE Polish_CI_AS NOT NULL,
	[FirstFreePackageNumber]		[bigint]			 NOT NULL,
	[LastAvailablePackageNumber]	[bigint]			 NOT NULL,
	[SenderAddressID]				[bigint]			 NULL,
	[TemplatePath]					[varchar](200)		 COLLATE Polish_CI_AS NOT NULL,
	[FirstFreeReportNumber]			[bigint]			 NOT NULL,
	[TemplateReportPath]			[varchar](200)		 COLLATE Polish_CI_AS NOT NULL,
	[SendReportToEmail]				[varchar](200)		 COLLATE Polish_CI_AS NOT NULL,
	[PathToSaveReport]				[varchar](200)		 COLLATE Polish_CI_AS NOT NULL,
	[WebCheckingAddress]			[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[CreatedOn]						[datetime]			 NULL,
	[CreatedBy]						[bigint]			 NULL,
	[ModifiedOn]					[datetime]			 NULL,
	[ModifiedBy]					[bigint]			 NULL,
	[SecR]							[bigint]			 NOT NULL,
	[SecW]							[bigint]			 NOT NULL,
	[SecD]							[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LShipmentParameterGroup] ADD CONSTRAINT [DF_LShipmentParameterGroup_Guid] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LShipmentParameterGroup] ADD CONSTRAINT [DF_LShipmentParameterGroup_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LShipmentParameterGroup] ADD CONSTRAINT [DF_LShipmentParameterGroup_Name] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LShipmentParameterGroup] ADD CONSTRAINT [DF_LShipmentParameterGroup_IsActive] DEFAULT (1)FOR [IsActive]
GO
ALTER TABLE [dbo].[LShipmentParameterGroup] ADD CONSTRAINT [DF_LShipmentParameterGroup_SenderCode] DEFAULT ('')FOR [SenderCode]
GO
ALTER TABLE [dbo].[LShipmentParameterGroup] ADD CONSTRAINT [DF_LShipmentParameterGroup_CurrentNum] DEFAULT (0)FOR [FirstFreePackageNumber]
GO
ALTER TABLE [dbo].[LShipmentParameterGroup] ADD CONSTRAINT [DF_LShipmentParameterGroup_LastNum] DEFAULT (0)FOR [LastAvailablePackageNumber]
GO
ALTER TABLE [dbo].[LShipmentParameterGroup] ADD CONSTRAINT [DF_LShipmentParameterGroup_TemplatePath] DEFAULT ('')FOR [TemplatePath]
GO
ALTER TABLE [dbo].[LShipmentParameterGroup] ADD CONSTRAINT [DF_LShipmentParameterGroup_FirstFreeReportNumber] DEFAULT (0)FOR [FirstFreeReportNumber]
GO
ALTER TABLE [dbo].[LShipmentParameterGroup] ADD CONSTRAINT [DF_LShipmentParameterGroup_TemplateReportPath] DEFAULT ('')FOR [TemplateReportPath]
GO
ALTER TABLE [dbo].[LShipmentParameterGroup] ADD CONSTRAINT [DF_LShipmentParameterGroup_SendReportToEmail] DEFAULT ('')FOR [SendReportToEmail]
GO
ALTER TABLE [dbo].[LShipmentParameterGroup] ADD CONSTRAINT [DF_LShipmentParameterGroup_PathToSaveReport] DEFAULT ('')FOR [PathToSaveReport]
GO
ALTER TABLE [dbo].[LShipmentParameterGroup] ADD CONSTRAINT [DF_LShipmentParameterGroup_WebCheckingAddress] DEFAULT ('')FOR [WebCheckingAddress]
GO
ALTER TABLE [dbo].[LShipmentParameterGroup] ADD CONSTRAINT [DF_LShipmentParameterGroup_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LShipmentParameterGroup] ADD CONSTRAINT [DF_LShipmentParameterGroup_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LShipmentParameterGroup] ADD CONSTRAINT [DF_LShipmentParameterGroup_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1590413581] ON [dbo].[LShipmentParameterGroup]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LShipmentParameterGroup] ADD CONSTRAINT [PK_LShipmentParameterGroup] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[LShipmentParameterGroup] WITH NOCHECK ADD CONSTRAINT [FK__LShipmentParameterGroup_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LShipmentParameterGroup] WITH NOCHECK ADD CONSTRAINT [FK__LShipmentParameterGroup_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[OShipmentAddress] (
	[ID]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[Street]				[varchar](200)		 COLLATE Polish_CI_AS NULL,
	[HouseNr]				[varchar](10)		 COLLATE Polish_CI_AS NULL,
	[AppartmentNr]			[varchar](10)		 COLLATE Polish_CI_AS NULL,
	[PostalCode]			[varchar](10)		 COLLATE Polish_CI_AS NULL,
	[City]					[varchar](50)		 COLLATE Polish_CI_AS NULL,
	[Country]				[varchar](50)		 COLLATE Polish_CI_AS NULL,
	[PostOfficeBox]			[varchar](30)		 COLLATE Polish_CI_AS NULL,
	[PostOfficeCity]		[varchar](50)		 COLLATE Polish_CI_AS NULL,
	[PersonFirstname]		[varchar](100)		 COLLATE Polish_CI_AS NULL,
	[PersonSurname]			[varchar](100)		 COLLATE Polish_CI_AS NULL,
	[PersonPhone]			[varchar](50)		 COLLATE Polish_CI_AS NULL,
	[CompanyDerivedName]	[varchar](2000)		 COLLATE Polish_CI_AS NULL,
	[CompanyClientNr]		[varchar](50)		 COLLATE Polish_CI_AS NULL,
	[CreatedOn]				[datetime]			 NOT NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OShipmentAddress] ADD CONSTRAINT [DF_OShipmentAddress_Guid] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OShipmentAddress] ADD CONSTRAINT [DF_OShipmentAddress_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OShipmentAddress] ADD CONSTRAINT [DF_OShipmentAddress_Street] DEFAULT ('')FOR [Street]
GO
ALTER TABLE [dbo].[OShipmentAddress] ADD CONSTRAINT [DF_OShipmentAddress_HouseNr] DEFAULT ('')FOR [HouseNr]
GO
ALTER TABLE [dbo].[OShipmentAddress] ADD CONSTRAINT [DF_OShipmentAddress_AppartmentNr] DEFAULT ('')FOR [AppartmentNr]
GO
ALTER TABLE [dbo].[OShipmentAddress] ADD CONSTRAINT [DF_OShipmentAddress_PostalCode] DEFAULT ('')FOR [PostalCode]
GO
ALTER TABLE [dbo].[OShipmentAddress] ADD CONSTRAINT [DF_OShipmentAddress_City] DEFAULT ('')FOR [City]
GO
ALTER TABLE [dbo].[OShipmentAddress] ADD CONSTRAINT [DF_OShipmentAddress_Country] DEFAULT ('')FOR [Country]
GO
ALTER TABLE [dbo].[OShipmentAddress] ADD CONSTRAINT [DF_OShipmentAddress_PostOfficeBox] DEFAULT ('')FOR [PostOfficeBox]
GO
ALTER TABLE [dbo].[OShipmentAddress] ADD CONSTRAINT [DF_OShipmentAddress_PostOfficeCity] DEFAULT ('')FOR [PostOfficeCity]
GO
ALTER TABLE [dbo].[OShipmentAddress] ADD CONSTRAINT [DF_OShipmentAddress_PersonFirstname] DEFAULT ('')FOR [PersonFirstname]
GO
ALTER TABLE [dbo].[OShipmentAddress] ADD CONSTRAINT [DF_OShipmentAddress_PersonSurname] DEFAULT ('')FOR [PersonSurname]
GO
ALTER TABLE [dbo].[OShipmentAddress] ADD CONSTRAINT [DF_OShipmentAddress_PersonPhone] DEFAULT ('')FOR [PersonPhone]
GO
ALTER TABLE [dbo].[OShipmentAddress] ADD CONSTRAINT [DF_OShipmentAddress_CompanyName] DEFAULT ('')FOR [CompanyDerivedName]
GO
ALTER TABLE [dbo].[OShipmentAddress] ADD CONSTRAINT [DF_OShipmentAddress_CompanyClientNr] DEFAULT ('')FOR [CompanyClientNr]
GO
ALTER TABLE [dbo].[OShipmentAddress] ADD CONSTRAINT [DF_OShipmentAddress_CreatedOn] DEFAULT (getdate())FOR [CreatedOn]
GO
ALTER TABLE [dbo].[OShipmentAddress] ADD CONSTRAINT [DF_OShipmentAddress_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OShipmentAddress] ADD CONSTRAINT [DF_OShipmentAddress_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OShipmentAddress] ADD CONSTRAINT [DF_OShipmentAddress_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1798414322] ON [dbo].[OShipmentAddress]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OShipmentAddress] ADD CONSTRAINT [PK_OShipmentAddress] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[OShipmentAddress] WITH NOCHECK ADD CONSTRAINT [FK__OShipmentAddress_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OShipmentAddress] WITH NOCHECK ADD CONSTRAINT [FK__OShipmentAddress_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT DELETE ON [dbo].[OShipmentAddress] TO [BDKProgramyZewnetrzne]
GO
GRANT INSERT ON [dbo].[OShipmentAddress] TO [BDKProgramyZewnetrzne]
GO
GRANT SELECT ON [dbo].[OShipmentAddress] TO [BDKProgramyZewnetrzne]
GO
GRANT UPDATE ON [dbo].[OShipmentAddress] TO [BDKProgramyZewnetrzne]
GO
ALTER TABLE [dbo].[LShipmentParameterGroup] WITH NOCHECK ADD CONSTRAINT [FK_LShipmentParameterGroup_OShipmentAddress] FOREIGN KEY ([SenderAddressID]) REFERENCES [dbo].[OShipmentAddress] ([ID]) NOT FOR REPLICATION
GO
GRANT DELETE ON [dbo].[LShipmentParameterGroup] TO [BDKProgramyZewnetrzne]
GO
GRANT INSERT ON [dbo].[LShipmentParameterGroup] TO [BDKProgramyZewnetrzne]
GO
GRANT SELECT ON [dbo].[LShipmentParameterGroup] TO [BDKProgramyZewnetrzne]
GO
GRANT UPDATE ON [dbo].[LShipmentParameterGroup] TO [BDKProgramyZewnetrzne]
GO
ALTER TABLE [dbo].[LShipmentParameter] WITH NOCHECK ADD CONSTRAINT [FK_LShipmentParameter_LShipmentParameterGroup] FOREIGN KEY ([ShipmentParameterGroupId]) REFERENCES [dbo].[LShipmentParameterGroup] ([ID]) NOT FOR REPLICATION
GO
GRANT DELETE ON [dbo].[LShipmentParameter] TO [BDKProgramyZewnetrzne]
GO
GRANT INSERT ON [dbo].[LShipmentParameter] TO [BDKProgramyZewnetrzne]
GO
GRANT SELECT ON [dbo].[LShipmentParameter] TO [BDKProgramyZewnetrzne]
GO
GRANT UPDATE ON [dbo].[LShipmentParameter] TO [BDKProgramyZewnetrzne]
GO
CREATE TABLE [dbo].[LShipmentParameterAnswer] (
	[ID]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NOT NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[ShipmentParameterID]		[bigint]			 NOT NULL,
	[Name]						[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]				[varchar](150)		 COLLATE Polish_CI_AS NOT NULL,
	[Answer]					[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[AnswerOrder]				[int]				 NOT NULL,
	[CreatedOn]					[datetime]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LShipmentParameterAnswer] ADD CONSTRAINT [DF_LShipmentParameterAnswer_Guid] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LShipmentParameterAnswer] ADD CONSTRAINT [DF_LShipmentParameterAnswer_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LShipmentParameterAnswer] ADD CONSTRAINT [DF_LShipmentParameterAnswer_Description] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LShipmentParameterAnswer] ADD CONSTRAINT [DF_LShipmentParameterAnswer_AnswerOrder] DEFAULT (0)FOR [AnswerOrder]
GO
ALTER TABLE [dbo].[LShipmentParameterAnswer] ADD CONSTRAINT [DF_LShipmentParameterAnswer_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LShipmentParameterAnswer] ADD CONSTRAINT [DF_LShipmentParameterAnswer_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LShipmentParameterAnswer] ADD CONSTRAINT [DF_LShipmentParameterAnswer_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2134415519] ON [dbo].[LShipmentParameterAnswer]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LShipmentParameterAnswer] ADD CONSTRAINT [PK_LShipmentParameterAnswer] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[LShipmentParameterAnswer] WITH NOCHECK ADD CONSTRAINT [FK__LShipmentParameterAnswer_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LShipmentParameterAnswer] WITH NOCHECK ADD CONSTRAINT [FK__LShipmentParameterAnswer_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LShipmentParameterAnswer] WITH NOCHECK ADD CONSTRAINT [FK_LShipmentParameterAnswer_LShipmentParameter] FOREIGN KEY ([ShipmentParameterID]) REFERENCES [dbo].[LShipmentParameter] ([ID]) NOT FOR REPLICATION
GO
GRANT DELETE ON [dbo].[LShipmentParameterAnswer] TO [BDKProgramyZewnetrzne]
GO
GRANT INSERT ON [dbo].[LShipmentParameterAnswer] TO [BDKProgramyZewnetrzne]
GO
GRANT SELECT ON [dbo].[LShipmentParameterAnswer] TO [BDKProgramyZewnetrzne]
GO
GRANT UPDATE ON [dbo].[LShipmentParameterAnswer] TO [BDKProgramyZewnetrzne]
GO
CREATE TABLE [dbo].[LShipmentShipmentCode] (
	[ID]							[bigint]			 NOT NULL,
	[GUID]							[uniqueidentifier]	 NOT NULL,
	[REPLID]						[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[ShipmentParameterGroupId]		[bigint]			 NOT NULL,
	[PostalCode]					[varchar](6)		 COLLATE Polish_CI_AS NOT NULL,
	[miasto]						[varchar](30)		 COLLATE Polish_CI_AS NULL,
	[strefa]						[smallint]			 NULL,
	[ulica_lub_woj]					[varchar](40)		 COLLATE Polish_CI_AS NULL,
	[stacja_odbioru]				[varchar](4)		 COLLATE Polish_CI_AS NULL,
	[powiat]						[varchar](40)		 COLLATE Polish_CI_AS NULL,
	[woj]							[varchar](50)		 COLLATE Polish_CI_AS NULL,
	[status]						[bit]				 NOT NULL,
	[Uwagi]							[varchar](30)		 COLLATE Polish_CI_AS NULL,
	[CreatedOn]						[datetime]			 NULL,
	[CreatedBy]						[bigint]			 NULL,
	[ModifiedOn]					[datetime]			 NULL,
	[ModifiedBy]					[bigint]			 NULL,
	[SecR]							[bigint]			 NOT NULL,
	[SecW]							[bigint]			 NOT NULL,
	[SecD]							[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LShipmentShipmentCode] ADD CONSTRAINT [MSmerge_default_constraint_for_rowguidcol_of_98932270] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LShipmentShipmentCode] ADD CONSTRAINT [DF_LShipmentShipmentCode_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LShipmentShipmentCode] ADD CONSTRAINT [DF_LShipmentShipmentCode_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LShipmentShipmentCode] ADD CONSTRAINT [DF_LShipmentShipmentCode_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_98932270] ON [dbo].[LShipmentShipmentCode]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LShipmentShipmentCode] ADD CONSTRAINT [PK_LShipmentShipmentCode] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[LShipmentShipmentCode] WITH NOCHECK ADD CONSTRAINT [FK__LShipmentShipmentCode_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LShipmentShipmentCode] WITH NOCHECK ADD CONSTRAINT [FK__LShipmentShipmentCode_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LShipmentShipmentCode] WITH NOCHECK ADD CONSTRAINT [FK_LShipmentShipmentCode_LShipmentParameterGroup] FOREIGN KEY ([ShipmentParameterGroupId]) REFERENCES [dbo].[LShipmentParameterGroup] ([ID]) NOT FOR REPLICATION
GO
GRANT DELETE ON [dbo].[LShipmentShipmentCode] TO [BDKProgramyZewnetrzne]
GO
GRANT INSERT ON [dbo].[LShipmentShipmentCode] TO [BDKProgramyZewnetrzne]
GO
GRANT SELECT ON [dbo].[LShipmentShipmentCode] TO [BDKProgramyZewnetrzne]
GO
GRANT UPDATE ON [dbo].[LShipmentShipmentCode] TO [BDKProgramyZewnetrzne]
GO
CREATE TABLE [dbo].[LShipmentStatus] (
	[ID]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[GUID]			[uniqueidentifier]	 NOT NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[Name]			[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[CreatedOn]		[datetime]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LShipmentStatus] ADD CONSTRAINT [DF_LShipmentStatus_GUID] DEFAULT (newid())FOR [GUID]
GO
ALTER TABLE [dbo].[LShipmentStatus] ADD CONSTRAINT [DF_LShipmentStatus_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LShipmentStatus] ADD CONSTRAINT [DF_LShipmentStatus_Name] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LShipmentStatus] ADD CONSTRAINT [DF_LShipmentStatus_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LShipmentStatus] ADD CONSTRAINT [DF_LShipmentStatus_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LShipmentStatus] ADD CONSTRAINT [DF_LShipmentStatus_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_130932384] ON [dbo].[LShipmentStatus]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LShipmentStatus] ADD CONSTRAINT [PK_LShipmentStatus] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[LShipmentStatus] WITH NOCHECK ADD CONSTRAINT [FK__LShipmentStatus_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LShipmentStatus] WITH NOCHECK ADD CONSTRAINT [FK__LShipmentStatus_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT DELETE ON [dbo].[LShipmentStatus] TO [BDKProgramyZewnetrzne]
GO
GRANT INSERT ON [dbo].[LShipmentStatus] TO [BDKProgramyZewnetrzne]
GO
GRANT SELECT ON [dbo].[LShipmentStatus] TO [BDKProgramyZewnetrzne]
GO
GRANT UPDATE ON [dbo].[LShipmentStatus] TO [BDKProgramyZewnetrzne]
GO
CREATE TABLE [dbo].[LSupportIssueResolution] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NULL,
	[Name]				[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LSupportIssueResolution] ADD CONSTRAINT [DF__LSupportIs__Guid__01DFC956] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LSupportIssueResolution] ADD CONSTRAINT [DF__LSupportIssueResolution__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LSupportIssueResolution] ADD CONSTRAINT [DF__LSupportIssueResolution__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LSupportIssueResolution] ADD CONSTRAINT [DF_LSupportIssueResolution_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LSupportIssueResolution] ADD CONSTRAINT [DF_LSupportIssueResolution_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LSupportIssueResolution] ADD CONSTRAINT [DF_LSupportIssueResolution_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LSupportIssueResolution] ADD CONSTRAINT [DF_LSupportIssueResolution_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1003150619] ON [dbo].[LSupportIssueResolution]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LSupportIssueResolution] ADD CONSTRAINT [PK__LSupportIssueRes__00EBA51D] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LSupportIssueResolution] WITH NOCHECK ADD CONSTRAINT [FK__LSupportIssueResolution__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LSupportIssueResolution] WITH NOCHECK ADD CONSTRAINT [FK__LSupportIssueResolution__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[LSupportIssueResolution] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[LSupportIssueRole] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NULL,
	[Name]				[varchar](30)		 COLLATE Polish_CI_AS NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LSupportIssueRole] ADD CONSTRAINT [DF__LSupportIs__Guid__28A490BC] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LSupportIssueRole] ADD CONSTRAINT [DF__LSupportIssueRole__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LSupportIssueRole] ADD CONSTRAINT [DF__LSupportIssueRole__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LSupportIssueRole] ADD CONSTRAINT [DF_LSupportIssueRole_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LSupportIssueRole] ADD CONSTRAINT [DF_LSupportIssueRole_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LSupportIssueRole] ADD CONSTRAINT [DF_LSupportIssueRole_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LSupportIssueRole] ADD CONSTRAINT [DF_LSupportIssueRole_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1115151018] ON [dbo].[LSupportIssueRole]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LSupportIssueRole] ADD CONSTRAINT [PK__LSupportIssueRol__27B06C83] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[LSupportIssueRole] WITH NOCHECK ADD CONSTRAINT [FK__LSupportIssueRole__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LSupportIssueRole] WITH NOCHECK ADD CONSTRAINT [FK__LSupportIssueRole__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[LSupportIssueRole] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[LSupportIssueStatus] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NULL,
	[Name]				[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[IsFinal]			[bit]				 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LSupportIssueStatus] ADD CONSTRAINT [DF__LSupportIs__Guid__7F035CAB] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LSupportIssueStatus] ADD CONSTRAINT [DF__LSupportIssueStatus__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LSupportIssueStatus] ADD CONSTRAINT [DF__LSupportIssueStatus__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LSupportIssueStatus] ADD CONSTRAINT [DF__LSupportIssueStatus__IsFinal__DefaultValue] DEFAULT (0)FOR [IsFinal]
GO
ALTER TABLE [dbo].[LSupportIssueStatus] ADD CONSTRAINT [DF_LSupportIssueStatus_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LSupportIssueStatus] ADD CONSTRAINT [DF_LSupportIssueStatus_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LSupportIssueStatus] ADD CONSTRAINT [DF_LSupportIssueStatus_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LSupportIssueStatus] ADD CONSTRAINT [DF_LSupportIssueStatus_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1227151417] ON [dbo].[LSupportIssueStatus]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LSupportIssueStatus] ADD CONSTRAINT [PK__LSupportIssueSta__7E0F3872] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LSupportIssueStatus] WITH NOCHECK ADD CONSTRAINT [FK__LSupportIssueStatus__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LSupportIssueStatus] WITH NOCHECK ADD CONSTRAINT [FK__LSupportIssueStatus__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[LSupportIssueStatus] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[LSupportQuestion] (
	[ID]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NULL,
	[Content]		[varchar](900)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LSupportQuestion] ADD CONSTRAINT [DF__LSupportQu__Guid__177A04BA] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LSupportQuestion] ADD CONSTRAINT [DF__LSupportQuestion__Content__DefaultValue] DEFAULT ('')FOR [Content]
GO
ALTER TABLE [dbo].[LSupportQuestion] ADD CONSTRAINT [DF_LSupportQuestion_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LSupportQuestion] ADD CONSTRAINT [DF_LSupportQuestion_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LSupportQuestion] ADD CONSTRAINT [DF_LSupportQuestion_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LSupportQuestion] ADD CONSTRAINT [DF_LSupportQuestion_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_271340031] ON [dbo].[LSupportQuestion]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LSupportQuestion] ADD CONSTRAINT [PK__LSupportQuestion__1685E081] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[LSupportQuestion] ADD CONSTRAINT [uq_Content] UNIQUE NONCLUSTERED ([Content])
GO
ALTER TABLE [dbo].[LSupportQuestion] WITH NOCHECK ADD CONSTRAINT [FK__LSupportQuestion__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LSupportQuestion] WITH NOCHECK ADD CONSTRAINT [FK__LSupportQuestion__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LTag] (
	[Id]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NULL,
	[Name]			[varchar](200)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LTag] ADD CONSTRAINT [DF__LTag__Guid__6B5169B9] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LTag] ADD CONSTRAINT [DF__LTag__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LTag] ADD CONSTRAINT [DF_LTag_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LTag] ADD CONSTRAINT [DF_LTag_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LTag] ADD CONSTRAINT [DF_LTag_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LTag] ADD CONSTRAINT [DF_LTag_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1467152272] ON [dbo].[LTag]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LTag] ADD CONSTRAINT [PK__LTag__6A5D4580] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LTag] WITH NOCHECK ADD CONSTRAINT [FK__LTag__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LTag] WITH NOCHECK ADD CONSTRAINT [FK__LTag__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[LTemplateFormat] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NULL,
	[Name]				[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LTemplateFormat] ADD CONSTRAINT [DF__LMailType__Guid__48082D7C] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[LTemplateFormat] ADD CONSTRAINT [DF__LMailType__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[LTemplateFormat] ADD CONSTRAINT [DF__LMailType__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[LTemplateFormat] ADD CONSTRAINT [DF_LTemplateFormat_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[LTemplateFormat] ADD CONSTRAINT [DF_LTemplateFormat_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[LTemplateFormat] ADD CONSTRAINT [DF_LTemplateFormat_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[LTemplateFormat] ADD CONSTRAINT [DF_LTemplateFormat_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1691153070] ON [dbo].[LTemplateFormat]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LTemplateFormat] ADD CONSTRAINT [PK__LMailType__47140943] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[LTemplateFormat] WITH NOCHECK ADD CONSTRAINT [FK__LTemplateFormat__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[LTemplateFormat] WITH NOCHECK ADD CONSTRAINT [FK__LTemplateFormat__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[OAddress] (
	[ID]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[Street]				[varchar](200)		 COLLATE Polish_CI_AS NOT NULL,
	[HouseNr]				[varchar](10)		 COLLATE Polish_CI_AS NOT NULL,
	[AppartmentNr]			[varchar](10)		 COLLATE Polish_CI_AS NOT NULL,
	[PostalCode]			[varchar](10)		 COLLATE Polish_CI_AS NOT NULL,
	[CityID]				[bigint]			 NULL,
	[CountryID]				[bigint]			 NULL,
	[TypeID]				[bigint]			 NULL,
	[PostOfficeBox]			[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[PostOfficeId]			[bigint]			 NULL,
	[Longitude]				[real]				 NOT NULL,
	[Latitude]				[real]				 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[BDK1Address]			[text]				 COLLATE Polish_CI_AS NULL,
	[FormattedAddress]		[varchar](1000)		 COLLATE Polish_CI_AS NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL,
	[DoNotUse]				[bit]				 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OAddress] ADD CONSTRAINT [DF__OAddress__GuidID__0CF1894F] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OAddress] ADD CONSTRAINT [DF__OAddress__Street__DefaultValue] DEFAULT ('')FOR [Street]
GO
ALTER TABLE [dbo].[OAddress] ADD CONSTRAINT [DF__OAddress__HouseNr__DefaultValue] DEFAULT ('')FOR [HouseNr]
GO
ALTER TABLE [dbo].[OAddress] ADD CONSTRAINT [DF__OAddress__AppartmentNr__DefaultValue] DEFAULT ('')FOR [AppartmentNr]
GO
ALTER TABLE [dbo].[OAddress] ADD CONSTRAINT [DF__OAddress__PostalCode__DefaultValue] DEFAULT ('')FOR [PostalCode]
GO
ALTER TABLE [dbo].[OAddress] ADD CONSTRAINT [DF__OAddress__PostOfficeBox__DefaultValue] DEFAULT ('')FOR [PostOfficeBox]
GO
ALTER TABLE [dbo].[OAddress] ADD CONSTRAINT [DF__OAddress__Longitude__DefaultValue] DEFAULT (0)FOR [Longitude]
GO
ALTER TABLE [dbo].[OAddress] ADD CONSTRAINT [DF__OAddress__Latitude__DefaultValue] DEFAULT (0)FOR [Latitude]
GO
ALTER TABLE [dbo].[OAddress] ADD CONSTRAINT [DF_OAddress_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OAddress] ADD CONSTRAINT [DF_OAddress_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OAddress] ADD CONSTRAINT [DF_OAddress_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OAddress] ADD CONSTRAINT [DF_OAddress_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
ALTER TABLE [dbo].[OAddress] ADD CONSTRAINT [DF_OAddress_DoNotUse_DefaultValue] DEFAULT (0)FOR [DoNotUse]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1803153469] ON [dbo].[OAddress]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OAddress] ADD CONSTRAINT [PK__OAddress__0BFD6516] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[OAddress] WITH NOCHECK ADD CONSTRAINT [FK_OAddress_LAddressType] FOREIGN KEY ([TypeID]) REFERENCES [dbo].[LAddressType] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OAddress] WITH NOCHECK ADD CONSTRAINT [FK_OAddress_LCity] FOREIGN KEY ([CityID]) REFERENCES [dbo].[LCity] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OAddress] WITH NOCHECK ADD CONSTRAINT [FK_OAddress_LCity_PostOffice] FOREIGN KEY ([PostOfficeId]) REFERENCES [dbo].[LCity] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OAddress] WITH NOCHECK ADD CONSTRAINT [FK_OAddress_LCountry] FOREIGN KEY ([CountryID]) REFERENCES [dbo].[LCountry] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[OAddress] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[OADUser] (
	[ID]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NULL,
	[Name]			[varchar](100)		 COLLATE Polish_CI_AS NULL,
	[DomainID]		[bigint]			 NOT NULL,
	[IsActive]		[bit]				 NOT NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[CreatedOn]		[datetime]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OADUser] ADD CONSTRAINT [DF__OADUser__GuidID__2978B964] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OADUser] ADD CONSTRAINT [DF__OADUser__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[OADUser] ADD CONSTRAINT [DF_OADUser_IsActive] DEFAULT (1)FOR [IsActive]
GO
ALTER TABLE [dbo].[OADUser] ADD CONSTRAINT [DF_OADUser_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OADUser] ADD CONSTRAINT [DF_OADUser_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OADUser] ADD CONSTRAINT [DF_OADUser_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OADUser] ADD CONSTRAINT [DF_OADUser_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2043154324] ON [dbo].[OADUser]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OADUser] ADD CONSTRAINT [PK__OADUser__2884952B] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[OADUser] WITH NOCHECK ADD CONSTRAINT [FK__OADUser__DomainID] FOREIGN KEY ([DomainID]) REFERENCES [dbo].[LADDomain] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OADUser] WITH NOCHECK ADD CONSTRAINT [FK__OADUser_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OADUser] WITH NOCHECK ADD CONSTRAINT [FK__OADUser_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[OArticle] (
	[ID]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NULL,
	[Title]			[varchar](2000)		 COLLATE Polish_CI_AS NOT NULL,
	[Content]		[text]				 COLLATE Polish_CI_AS NULL,
	[TypeID]		[bigint]			 NULL,
	[StatusID]		[bigint]			 NULL,
	[Rating]		[int]				 NULL,
	[CreatedOn]		[datetime]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[LanguageId]	[bigint]			 NOT NULL,
	[ValidTill]		[datetime]			 NULL,
	[ReviewOn]		[datetime]			 NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL,
	[IsText]		[bit]				 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OArticle] ADD CONSTRAINT [DF__OArticle__GuidID__6C1AA569] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OArticle] ADD CONSTRAINT [DF__OArticle__Title__DefaultValue] DEFAULT ('')FOR [Title]
GO
ALTER TABLE [dbo].[OArticle] ADD CONSTRAINT [DF__OArticle__Rating__DefaultValue] DEFAULT (0)FOR [Rating]
GO
ALTER TABLE [dbo].[OArticle] ADD CONSTRAINT [DF__OArticle__ValidTill__DefaultValue] DEFAULT (getdate())FOR [ValidTill]
GO
ALTER TABLE [dbo].[OArticle] ADD CONSTRAINT [DF__OArticle__ReviewOn__DefaultValue] DEFAULT (getdate())FOR [ReviewOn]
GO
ALTER TABLE [dbo].[OArticle] ADD CONSTRAINT [DF_OArticle_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OArticle] ADD CONSTRAINT [DF_OArticle_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OArticle] ADD CONSTRAINT [DF_OArticle_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OArticle] ADD CONSTRAINT [DF_OArticle_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
ALTER TABLE [dbo].[OArticle] ADD CONSTRAINT [DF_OArticle_IsText_DefaultValue] DEFAULT (0)FOR [IsText]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2139154666] ON [dbo].[OArticle]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OArticle] ADD CONSTRAINT [PK__OArticle__6B268130] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[OArticle] WITH NOCHECK ADD CONSTRAINT [FK__OArticle__LanguageId] FOREIGN KEY ([LanguageId]) REFERENCES [dbo].[LLanguage] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OArticle] WITH NOCHECK ADD CONSTRAINT [FK__OArticle__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OArticle] WITH NOCHECK ADD CONSTRAINT [FK__OArticle__StatusID] FOREIGN KEY ([StatusID]) REFERENCES [dbo].[LArticleStatus] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OArticle] WITH NOCHECK ADD CONSTRAINT [FK__OArticle__TypeID] FOREIGN KEY ([TypeID]) REFERENCES [dbo].[LArticleType] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[OArticle] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[OCommunication] (
	[ID]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[GUID]			[uniqueidentifier]	 NULL,
	[Value]			[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[TypeID]		[bigint]			 NOT NULL,
	[CreatedOn]		[datetime]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[REPLID]		[uniqueidentifier]	 NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OCommunication] ADD CONSTRAINT [DF__OCommunica__GUID__0CCB969A] DEFAULT (newid())FOR [GUID]
GO
ALTER TABLE [dbo].[OCommunication] ADD CONSTRAINT [DF__OCommunic__REPLI__0DBFBAD3] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OCommunication] ADD CONSTRAINT [DF_OCommunication_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OCommunication] ADD CONSTRAINT [DF_OCommunication_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OCommunication] ADD CONSTRAINT [DF_OCommunication_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_182668840] ON [dbo].[OCommunication]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OCommunication] ADD CONSTRAINT [PK__OCommunication__0BD77261] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[OCommunication] WITH NOCHECK ADD CONSTRAINT [FK_OCommunication_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OCommunication] WITH NOCHECK ADD CONSTRAINT [FK_OCommunication_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OCommunication] WITH NOCHECK ADD CONSTRAINT [FK_OCommunication_TypeID] FOREIGN KEY ([TypeID]) REFERENCES [dbo].[LCommunicationType] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[OCompany] (
	[ID]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NULL,
	[Name]					[varchar](150)		 COLLATE Polish_CI_AS NULL,
	[NamePrefixId]			[bigint]			 NULL,
	[NameSuffixId]			[bigint]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[Description]			[text]				 COLLATE Polish_CI_AS NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[DerivedFullName]		[varchar](2000)		 COLLATE Polish_CI_AS NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OCompany] ADD CONSTRAINT [DF__OCompany__GuidID__5B5A2DBB] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OCompany] ADD CONSTRAINT [DF__OCompany__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[OCompany] ADD CONSTRAINT [DF_OCompany_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OCompany] ADD CONSTRAINT [DF_OCompany_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OCompany] ADD CONSTRAINT [DF_OCompany_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OCompany] ADD CONSTRAINT [DF_OCompany_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE NONCLUSTERED INDEX [_dta_index_OCompany_38_645577338__K1] ON [dbo].[OCompany]([ID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_OCompany_38_645577338__K1_K2_K3] ON [dbo].[OCompany]([ID], [Guid], [Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_OCompany_38_645577338__K1_K2_K5_K4_K3] ON [dbo].[OCompany]([ID], [Guid], [NameSuffixId], [NamePrefixId], [Name]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_OCompany_38_645577338__K2_K1_K3_K5_K4] ON [dbo].[OCompany]([Guid], [ID], [Name], [NameSuffixId], [NamePrefixId]) ON [PRIMARY]
GO
CREATE STATISTICS [_dta_stat_645577338_3_1] ON [dbo].[OCompany]([Name], [ID]) 

GO
CREATE UNIQUE NONCLUSTERED INDEX [index_645577338] ON [dbo].[OCompany]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OCompany] ADD CONSTRAINT [PK__OCompany__5A660982] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[OCompany] WITH NOCHECK ADD CONSTRAINT [FK_OCompany_LCompanyNamePrefix] FOREIGN KEY ([NamePrefixId]) REFERENCES [dbo].[LCompanyNamePrefix] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OCompany] WITH NOCHECK ADD CONSTRAINT [FK_OCompany_LCompanyNameSuffix] FOREIGN KEY ([NameSuffixId]) REFERENCES [dbo].[LCompanyNameSuffix] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OCompany] WITH NOCHECK ADD CONSTRAINT [FK_OCompany_OUser_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OCompany] WITH NOCHECK ADD CONSTRAINT [FK_OCompany_OUser_ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[OCompany] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[OCost] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[Date]				[datetime]			 NOT NULL,
	[UnitsValue]		[money]				 NULL,
	[ReferenceValue]	[money]				 NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[CostCategoryId]	[bigint]			 NOT NULL,
	[CostTypeId]		[bigint]			 NOT NULL,
	[CostUnitId]		[bigint]			 NOT NULL,
	[IsDebit]			[bit]				 NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OCost] ADD CONSTRAINT [DF__OCost__Guid__41FE42EF] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OCost] ADD CONSTRAINT [DF__OCost__Date__DefaultValue] DEFAULT (getdate())FOR [Date]
GO
ALTER TABLE [dbo].[OCost] ADD CONSTRAINT [DF__OCost__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[OCost] ADD CONSTRAINT [DF__OCost__IsDebit__DefaultValue] DEFAULT (0)FOR [IsDebit]
GO
ALTER TABLE [dbo].[OCost] ADD CONSTRAINT [DF__OCost__REPLID__4A9388F0] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OCost] ADD CONSTRAINT [DF_OCost_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OCost] ADD CONSTRAINT [DF_OCost_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OCost] ADD CONSTRAINT [DF_OCost_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1075182205] ON [dbo].[OCost]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OCost] ADD CONSTRAINT [PK__OCost__410A1EB6] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[OCost] WITH NOCHECK ADD CONSTRAINT [FK__OCost__CostCategoryId] FOREIGN KEY ([CostCategoryId]) REFERENCES [dbo].[LCostCategory] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OCost] WITH NOCHECK ADD CONSTRAINT [FK__OCost__CostTypeId] FOREIGN KEY ([CostTypeId]) REFERENCES [dbo].[LCostType] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OCost] WITH NOCHECK ADD CONSTRAINT [FK__OCost__CostUnitId] FOREIGN KEY ([CostUnitId]) REFERENCES [dbo].[LCostUnit] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OCost] WITH NOCHECK ADD CONSTRAINT [FK__OCost__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OCost] WITH NOCHECK ADD CONSTRAINT [FK__OCost__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[ODatabaseLog] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[OperationId]		[bigint]			 NOT NULL,
	[SourceTable]		[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[ObjectId]			[bigint]			 NOT NULL,
	[ServerId]			[bigint]			 NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[CreatedOn]			[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [SECONDARY]
GO
ALTER TABLE [dbo].[ODatabaseLog] ADD CONSTRAINT [DF__ODatabaseL__Guid__5C842775] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[ODatabaseLog] ADD CONSTRAINT [DF__ODatabaseLog__TableName__DefaultValue] DEFAULT ('')FOR [SourceTable]
GO
ALTER TABLE [dbo].[ODatabaseLog] ADD CONSTRAINT [DF__ODatabaseLog__ObjectId__DefaultValue] DEFAULT (0)FOR [ObjectId]
GO
ALTER TABLE [dbo].[ODatabaseLog] ADD CONSTRAINT [DF_ODatabaseLog_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[ODatabaseLog] ADD CONSTRAINT [DF_ODatabaseLog_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[ODatabaseLog] ADD CONSTRAINT [DF_ODatabaseLog_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[ODatabaseLog] ADD CONSTRAINT [DF_ODatabaseLog_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_167671645] ON [dbo].[ODatabaseLog]([REPLID]) ON [SECONDARY]
GO
CREATE NONCLUSTERED INDEX [IX_ODatabaseLog_ServerIDCreatedOn] ON [dbo].[ODatabaseLog]([ServerId], [CreatedOn]) ON [SECONDARY]
GO
ALTER TABLE [dbo].[ODatabaseLog] ADD CONSTRAINT [PK_ODatabaseLog] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[ODatabaseLog] WITH NOCHECK ADD CONSTRAINT [FK__ODatabaseLog__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[ODatabaseLog] WITH NOCHECK ADD CONSTRAINT [FK__ODatabaseLog__OperationId] FOREIGN KEY ([OperationId]) REFERENCES [dbo].[LDatabaseLogOperation] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[ODatabaseLog] WITH NOCHECK ADD CONSTRAINT [FK__ODatabaseLog__ServerId] FOREIGN KEY ([ServerId]) REFERENCES [dbo].[LDatabaseServer] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[ODatabaseLog] WITH NOCHECK ADD CONSTRAINT [FK__ODatabaseLog_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT INSERT ON [dbo].[ODatabaseLog] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[ODatabaseLogStatus] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[SourceServerId]		[bigint]			 NOT NULL,
	[ProcessingServerId]	[bigint]			 NOT NULL,
	[ObjectDate]			[datetime]			 NOT NULL,
	[ProcessingDate]		[datetime]			 NOT NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[CreatedOn]				[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ODatabaseLogStatus] ADD CONSTRAINT [DF__ODatabaseL__Guid__58B39691] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[ODatabaseLogStatus] ADD CONSTRAINT [DF__ODatabaseLogStatus__ObjectDate__DefaultValue] DEFAULT (getdate())FOR [ObjectDate]
GO
ALTER TABLE [dbo].[ODatabaseLogStatus] ADD CONSTRAINT [DF__ODatabaseLogStatus__ProcessingDate__DefaultValue] DEFAULT (getdate())FOR [ProcessingDate]
GO
ALTER TABLE [dbo].[ODatabaseLogStatus] ADD CONSTRAINT [DF_ODatabaseLogStatus_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[ODatabaseLogStatus] ADD CONSTRAINT [DF_ODatabaseLogStatus_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[ODatabaseLogStatus] ADD CONSTRAINT [DF_ODatabaseLogStatus_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[ODatabaseLogStatus] ADD CONSTRAINT [DF_ODatabaseLogStatus_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_295672101] ON [dbo].[ODatabaseLogStatus]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ODatabaseLogStatus] ADD CONSTRAINT [PK__ODatabaseLogStat__57BF7258] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[ODatabaseLogStatus] WITH NOCHECK ADD CONSTRAINT [FK__ODatabaseLogStatus__ProcessingServerId] FOREIGN KEY ([ProcessingServerId]) REFERENCES [dbo].[LDatabaseServer] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[ODatabaseLogStatus] WITH NOCHECK ADD CONSTRAINT [FK__ODatabaseLogStatus__SourceServerId] FOREIGN KEY ([SourceServerId]) REFERENCES [dbo].[LDatabaseServer] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[ODatabaseLogStatus] WITH NOCHECK ADD CONSTRAINT [FK__ODatabaseLogStatus_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[ODatabaseLogStatus] WITH NOCHECK ADD CONSTRAINT [FK__ODatabaseLogStatus_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[ODesign] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[Name]				[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[Content]			[text]				 COLLATE Polish_CI_AS NOT NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ODesign] ADD CONSTRAINT [DF_ODesign_GuidID] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[ODesign] ADD CONSTRAINT [DF_ODesign_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[ODesign] ADD CONSTRAINT [DF_ODesign_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[ODesign] ADD CONSTRAINT [DF_ODesign_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[ODesign] ADD CONSTRAINT [DF_ODesign_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_59068638] ON [dbo].[ODesign]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ODesign] ADD CONSTRAINT [PK_ODesign] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[ODesign] WITH NOCHECK ADD CONSTRAINT [FK__ODesign_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[ODesign] WITH NOCHECK ADD CONSTRAINT [FK_ODesign_ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[OEmail] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[Email]				[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[EmailStatus]		[int]				 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[Index]				[int]				 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[BDK1Email]			[text]				 COLLATE Polish_CI_AS NULL,
	[__Note]			[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL,
	[DoNotUse]			[bit]				 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OEmail] ADD CONSTRAINT [DF__OEmail__GuidID__340B5670] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OEmail] ADD CONSTRAINT [DF__OEmail__Email__DefaultValue] DEFAULT ('')FOR [Email]
GO
ALTER TABLE [dbo].[OEmail] ADD CONSTRAINT [DF__OEmail__EmailStatus__DefaultValue] DEFAULT (0)FOR [EmailStatus]
GO
ALTER TABLE [dbo].[OEmail] ADD CONSTRAINT [DF_OEmail_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OEmail] ADD CONSTRAINT [DF__OEmail__Note__DefaultValue] DEFAULT ('')FOR [__Note]
GO
ALTER TABLE [dbo].[OEmail] ADD CONSTRAINT [DF__OEmail__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[OEmail] ADD CONSTRAINT [DF_OEmail_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OEmail] ADD CONSTRAINT [DF_OEmail_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OEmail] ADD CONSTRAINT [DF_OEmail_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
ALTER TABLE [dbo].[OEmail] ADD CONSTRAINT [DF_EOEmail_DoNotUse_DefaultValue] DEFAULT (0)FOR [DoNotUse]
GO
CREATE NONCLUSTERED INDEX [_dta_index_OEmail_38_1605841033__K1_K3] ON [dbo].[OEmail]([ID], [Email]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_503672842] ON [dbo].[OEmail]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OEmail] ADD CONSTRAINT [PK__OEmail__33173237] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[OEmail] WITH NOCHECK ADD CONSTRAINT [FK__OEmail__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OEmail] WITH NOCHECK ADD CONSTRAINT [FK__OEmail__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[OEmail] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[OEvent] (
	[ID]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NULL,
	[AllDayEvent]			[bit]				 NOT NULL,
	[DateEnd]				[datetime]			 NOT NULL,
	[DateStart]				[datetime]			 NOT NULL,
	[Description]			[varchar](2000)		 COLLATE Polish_CI_AS NOT NULL,
	[Recurrence]			[int]				 NOT NULL,
	[Reminder]				[bit]				 NOT NULL,
	[RemindOn]				[datetime]			 NOT NULL,
	[Subject]				[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[IsTask]				[bit]				 NOT NULL,
	[EventTypeId]			[bigint]			 NULL,
	[StatusId]				[bigint]			 NULL,
	[StageId]				[bigint]			 NULL,
	[CategoryId]			[bigint]			 NULL,
	[RecurrenceInterval]	[datetime]			 NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL,
	[Progress]				[smallint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OEvent] ADD CONSTRAINT [DF__OEvent__GuidID__2BEB11BB] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OEvent] ADD CONSTRAINT [DF__OEvent__AllDayEvent__DefaultValue] DEFAULT (0)FOR [AllDayEvent]
GO
ALTER TABLE [dbo].[OEvent] ADD CONSTRAINT [DF__OEvent__DateEnd__DefaultValue] DEFAULT (getdate())FOR [DateEnd]
GO
ALTER TABLE [dbo].[OEvent] ADD CONSTRAINT [DF__OEvent__DateStart__DefaultValue] DEFAULT (getdate())FOR [DateStart]
GO
ALTER TABLE [dbo].[OEvent] ADD CONSTRAINT [DF__OEvent__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[OEvent] ADD CONSTRAINT [DF__OEvent__Recurrence__DefaultValue] DEFAULT (0)FOR [Recurrence]
GO
ALTER TABLE [dbo].[OEvent] ADD CONSTRAINT [DF__OEvent__Reminder__DefaultValue] DEFAULT (0)FOR [Reminder]
GO
ALTER TABLE [dbo].[OEvent] ADD CONSTRAINT [DF__OEvent__RemindOn__DefaultValue] DEFAULT (getdate())FOR [RemindOn]
GO
ALTER TABLE [dbo].[OEvent] ADD CONSTRAINT [DF__OEvent__Subject__DefaultValue] DEFAULT ('')FOR [Subject]
GO
ALTER TABLE [dbo].[OEvent] ADD CONSTRAINT [DF_OEvent_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OEvent] ADD CONSTRAINT [DF__OEvent__IsTask__DefaultValue] DEFAULT (0)FOR [IsTask]
GO
ALTER TABLE [dbo].[OEvent] ADD CONSTRAINT [DF_OEvent_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OEvent] ADD CONSTRAINT [DF_OEvent_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OEvent] ADD CONSTRAINT [DF_OEvent_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
ALTER TABLE [dbo].[OEvent] ADD CONSTRAINT [DF_OEvent_Progress_DefaultValue] DEFAULT (0)FOR [Progress]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1047674780] ON [dbo].[OEvent]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OEvent] ADD CONSTRAINT [PK__OEvent__2AF6ED82] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[OEvent] WITH NOCHECK ADD CONSTRAINT [FK__OEvent__CategoryId] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[TEventCategory] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OEvent] WITH NOCHECK ADD CONSTRAINT [FK__OEvent__StageId] FOREIGN KEY ([StageId]) REFERENCES [dbo].[LEventStage] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OEvent] WITH NOCHECK ADD CONSTRAINT [FK__OEvent__StatusId] FOREIGN KEY ([StatusId]) REFERENCES [dbo].[LEventStatus] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[OExternalSupportIssue] (
	[ID]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NULL,
	[Name]			[varchar](200)		 COLLATE Polish_CI_AS NULL,
	[Code]			[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[TypeID]		[bigint]			 NOT NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OExternalSupportIssue] ADD CONSTRAINT [DF__OExternalS__Guid__5ECB9743] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OExternalSupportIssue] ADD CONSTRAINT [DF__OExternalSupportIssue__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[OExternalSupportIssue] ADD CONSTRAINT [DF__OExternalSupportIssue__Code__DefaultValue] DEFAULT ('')FOR [Code]
GO
ALTER TABLE [dbo].[OExternalSupportIssue] ADD CONSTRAINT [DF_OExternalSupportIssue_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OExternalSupportIssue] ADD CONSTRAINT [DF_OExternalSupportIssue_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OExternalSupportIssue] ADD CONSTRAINT [DF_OExternalSupportIssue_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OExternalSupportIssue] ADD CONSTRAINT [DF_OExternalSupportIssue_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1367675920] ON [dbo].[OExternalSupportIssue]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OExternalSupportIssue] ADD CONSTRAINT [PK__OExternalSupport__5DD7730A] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[OExternalSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK__OExternalSupportIssue__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OExternalSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK__OExternalSupportIssue__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OExternalSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK__OExternalSupportIssue__TypeID] FOREIGN KEY ([TypeID]) REFERENCES [dbo].[LExternalSupportType] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[OFile] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[Name]				[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[Content]			[image]				 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[Path]				[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[Extension]			[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[Size]				[int]				 NOT NULL,
	[DateCreated]		[datetime]			 NOT NULL,
	[DateModified]		[datetime]			 NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[FolderID]			[bigint]			 NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OFile] ADD CONSTRAINT [DF__OFile__Guid__28063D95] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OFile] ADD CONSTRAINT [DF__OFile__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[OFile] ADD CONSTRAINT [DF_OFile_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OFile] ADD CONSTRAINT [DF__OFile__Path__DefaultValue] DEFAULT ('')FOR [Path]
GO
ALTER TABLE [dbo].[OFile] ADD CONSTRAINT [DF__OFile__Extension__DefaultValue] DEFAULT ('')FOR [Extension]
GO
ALTER TABLE [dbo].[OFile] ADD CONSTRAINT [DF__OFile__Size__DefaultValue] DEFAULT (0)FOR [Size]
GO
ALTER TABLE [dbo].[OFile] ADD CONSTRAINT [DF__OFile__DateCreated__DefaultValue] DEFAULT (getdate())FOR [DateCreated]
GO
ALTER TABLE [dbo].[OFile] ADD CONSTRAINT [DF__OFile__DateModified__DefaultValue] DEFAULT (getdate())FOR [DateModified]
GO
ALTER TABLE [dbo].[OFile] ADD CONSTRAINT [DF__OFile__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[OFile] ADD CONSTRAINT [DF_OFile_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OFile] ADD CONSTRAINT [DF_OFile_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OFile] ADD CONSTRAINT [DF_OFile_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1495676376] ON [dbo].[OFile]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OFile] ADD CONSTRAINT [PK__OFile__2712195C] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[OFile] WITH NOCHECK ADD CONSTRAINT [FK__OFile__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OFile] WITH NOCHECK ADD CONSTRAINT [FK__OFile__FolderId] FOREIGN KEY ([FolderID]) REFERENCES [dbo].[LFolder] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OFile] WITH NOCHECK ADD CONSTRAINT [FK__OFile__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[OGraphic] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NULL,
	[Name]				[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]		[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[Size]				[int]				 NOT NULL,
	[FolderID]			[bigint]			 NULL,
	[Path]				[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[Picture]			[image]				 NULL,
	[Thumbnail]			[image]				 NULL,
	[TypeID]			[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [SECONDARY]
GO
ALTER TABLE [dbo].[OGraphic] ADD CONSTRAINT [DF__OGraphic__GuidID__0229E219] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OGraphic] ADD CONSTRAINT [DF__OGraphic__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[OGraphic] ADD CONSTRAINT [DF__OGraphic__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[OGraphic] ADD CONSTRAINT [DF__OGraphic__Size__DefaultValue] DEFAULT (0)FOR [Size]
GO
ALTER TABLE [dbo].[OGraphic] ADD CONSTRAINT [DF__OGraphic__Path__DefaultValue] DEFAULT ('')FOR [Path]
GO
ALTER TABLE [dbo].[OGraphic] ADD CONSTRAINT [DF_OGraphic_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OGraphic] ADD CONSTRAINT [DF_OGraphic_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OGraphic] ADD CONSTRAINT [DF_OGraphic_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OGraphic] ADD CONSTRAINT [DF_OGraphic_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [MSmerge_index_1256258730] ON [dbo].[OGraphic]([REPLID]) ON [SECONDARY]
GO
ALTER TABLE [dbo].[OGraphic] ADD CONSTRAINT [PK__OGraphic__0135BDE0] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[OGraphic] WITH NOCHECK ADD CONSTRAINT [FK__OGraphic__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OGraphic] WITH NOCHECK ADD CONSTRAINT [FK__OGraphic__FolderID] FOREIGN KEY ([FolderID]) REFERENCES [dbo].[LFolder] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OGraphic] WITH NOCHECK ADD CONSTRAINT [FK__OGraphic__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OGraphic] WITH NOCHECK ADD CONSTRAINT [FK__OGraphic__TypeID] FOREIGN KEY ([TypeID]) REFERENCES [dbo].[LGraphicType] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[OLicenseLog] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[State]				[text]				 COLLATE Polish_CI_AS NULL,
	[Token]				[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[UsersCount]		[int]				 NOT NULL,
	[ServerId]			[bigint]			 NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL,
	[IncidentGuid]		[uniqueidentifier]	 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OLicenseLog] ADD CONSTRAINT [DF__OLicenseLo__Guid__0B43A040] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OLicenseLog] ADD CONSTRAINT [DF__OLicenseLog__Token__DefaultValue] DEFAULT ('')FOR [Token]
GO
ALTER TABLE [dbo].[OLicenseLog] ADD CONSTRAINT [DF__OLicenseLog__UsersCount__DefaultValue] DEFAULT (0)FOR [UsersCount]
GO
ALTER TABLE [dbo].[OLicenseLog] ADD CONSTRAINT [DF_OLicenseLog_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OLicenseLog] ADD CONSTRAINT [DF_OLicenseLog_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OLicenseLog] ADD CONSTRAINT [DF_OLicenseLog_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OLicenseLog] ADD CONSTRAINT [DF_OLicenseLog_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
ALTER TABLE [dbo].[OLicenseLog] ADD CONSTRAINT [DF_OLicenseLog_IncidentGuid_DefaultValue] DEFAULT ('{00000000-0000-0000-0000-000000000000}')FOR [IncidentGuid]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_156981198] ON [dbo].[OLicenseLog]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OLicenseLog] ADD CONSTRAINT [PK__OLicenseLog__0A4F7C07] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[OLicenseLog] WITH NOCHECK ADD CONSTRAINT [FK__OLicenseLog__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OLicenseLog] WITH NOCHECK ADD CONSTRAINT [FK__OLicenseLog__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OLicenseLog] WITH NOCHECK ADD CONSTRAINT [FK__OLicenseLog__ServerId] FOREIGN KEY ([ServerId]) REFERENCES [dbo].[LDatabaseServer] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[OLink] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[FolderID]			[bigint]			 NULL,
	[Path]				[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[Extension]			[varchar](30)		 COLLATE Polish_CI_AS NULL,
	[Size]				[int]				 NULL,
	[DateCreated]		[datetime]			 NULL,
	[DateModified]		[datetime]			 NULL,
	[Description]		[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[LinkCategoryId]	[bigint]			 NULL,
	[Exists]			[bit]				 NOT NULL,
	[ExistsDate]		[datetime]			 NULL,
	[LanguageId]		[bigint]			 NULL,
	[IsTemplate]		[bit]				 NOT NULL,
	[NameTemplateId]	[bigint]			 NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OLink] ADD CONSTRAINT [DF__OLink__GuidID__6AF17706] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OLink] ADD CONSTRAINT [DF__OLink__Path__DefaultValue] DEFAULT ('')FOR [Path]
GO
ALTER TABLE [dbo].[OLink] ADD CONSTRAINT [DF__OLink__Extension__DefaultValue] DEFAULT ('')FOR [Extension]
GO
ALTER TABLE [dbo].[OLink] ADD CONSTRAINT [DF__OLink__Size__DefaultValue] DEFAULT (0)FOR [Size]
GO
ALTER TABLE [dbo].[OLink] ADD CONSTRAINT [DF__OLink__DateCreated__DefaultValue] DEFAULT (getdate())FOR [DateCreated]
GO
ALTER TABLE [dbo].[OLink] ADD CONSTRAINT [DF__OLink__DateModified__DefaultValue] DEFAULT (getdate())FOR [DateModified]
GO
ALTER TABLE [dbo].[OLink] ADD CONSTRAINT [DF__OLink__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[OLink] ADD CONSTRAINT [DF_OLink_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OLink] ADD CONSTRAINT [DF__OLink__Exists__DefaultValue] DEFAULT (0)FOR [Exists]
GO
ALTER TABLE [dbo].[OLink] ADD CONSTRAINT [DF__OLink__IsTemplate__DefaultValue] DEFAULT (0)FOR [IsTemplate]
GO
ALTER TABLE [dbo].[OLink] ADD CONSTRAINT [DF_OLink_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OLink] ADD CONSTRAINT [DF_OLink_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OLink] ADD CONSTRAINT [DF_OLink_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE NONCLUSTERED INDEX [_dta_index_OLink_38_2119678599__K1] ON [dbo].[OLink]([ID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2119678599] ON [dbo].[OLink]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OLink] ADD CONSTRAINT [PK__OFile__69FD52CD] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[OLink] WITH NOCHECK ADD CONSTRAINT [FK__OLink__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[TLinkCategory] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[Path]				[varchar](39)		 COLLATE Polish_CI_AS NOT NULL,
	[Parent]			[varchar](36)		 COLLATE Polish_CI_AS NULL,
	[Name]				[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[FileNameFormat]	[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[CreatedOn]			[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TLinkCategory] ADD CONSTRAINT [DF__TLinkCateg__Guid__7022A27C] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[TLinkCategory] ADD CONSTRAINT [DF__TLinkCategory__Path__DefaultValue] DEFAULT ('')FOR [Path]
GO
ALTER TABLE [dbo].[TLinkCategory] ADD CONSTRAINT [DF__TLinkCategory__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[TLinkCategory] ADD CONSTRAINT [DF__TLinkCategory__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[TLinkCategory] ADD CONSTRAINT [DF__TLinkCategory__FileNameFormat__DefaultValue] DEFAULT ('')FOR [FileNameFormat]
GO
ALTER TABLE [dbo].[TLinkCategory] ADD CONSTRAINT [DF_TLinkCategory_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[TLinkCategory] ADD CONSTRAINT [DF_TLinkCategory_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[TLinkCategory] ADD CONSTRAINT [DF_TLinkCategory_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[TLinkCategory] ADD CONSTRAINT [DF_TLinkCategory_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_843410324] ON [dbo].[TLinkCategory]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TLinkCategory] ADD CONSTRAINT [PK__TLinkCategory__6F2E7E43] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[TLinkCategory] WITH NOCHECK ADD CONSTRAINT [FK__TLinkCategory_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[TLinkCategory] WITH NOCHECK ADD CONSTRAINT [FK__TLinkCategory_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[TLinkCategory] TO [RaportyWEB]
GO
ALTER TABLE [dbo].[OLink] WITH NOCHECK ADD CONSTRAINT [FK__OLink__LinkCategoryId] FOREIGN KEY ([LinkCategoryId]) REFERENCES [dbo].[TLinkCategory] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OLink] WITH NOCHECK ADD CONSTRAINT [FK__OLink__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OLink] WITH NOCHECK ADD CONSTRAINT [FK__OLink__NameTemplateId] FOREIGN KEY ([NameTemplateId]) REFERENCES [dbo].[LTemplate] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OLink] WITH NOCHECK ADD CONSTRAINT [FK_OLink_LFolder] FOREIGN KEY ([FolderID]) REFERENCES [dbo].[LFolder] ([ID]) NOT FOR REPLICATION
GO
GRANT INSERT ON [dbo].[OLink] TO [RaportyWEB]
GO
GRANT SELECT ON [dbo].[OLink] TO [RaportyWEB]
GO
GRANT UPDATE ON [dbo].[OLink] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[OLoyaltyCard] (
	[Id]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[ValidTill]		[datetime]			 NOT NULL,
	[Number]		[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[Note]			[text]				 COLLATE Polish_CI_AS NULL,
	[TypeId]		[bigint]			 NOT NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OLoyaltyCard] ADD CONSTRAINT [DF__OLoyaltyCa__Guid__7D501E63] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OLoyaltyCard] ADD CONSTRAINT [DF__OLoyaltyCard__ValidTill__DefaultValue] DEFAULT (getdate())FOR [ValidTill]
GO
ALTER TABLE [dbo].[OLoyaltyCard] ADD CONSTRAINT [DF__OLoyaltyCard__Number__DefaultValue] DEFAULT ('')FOR [Number]
GO
ALTER TABLE [dbo].[OLoyaltyCard] ADD CONSTRAINT [DF_OLoyaltyCard_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OLoyaltyCard] ADD CONSTRAINT [DF_OLoyaltyCard_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OLoyaltyCard] ADD CONSTRAINT [DF_OLoyaltyCard_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OLoyaltyCard] ADD CONSTRAINT [DF_OLoyaltyCard_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_164195635] ON [dbo].[OLoyaltyCard]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OLoyaltyCard] ADD CONSTRAINT [PK__OLoyaltyCard__7C5BFA2A] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[OLoyaltyCard] ADD CONSTRAINT [uq_Number] UNIQUE NONCLUSTERED ([Number])
GO
ALTER TABLE [dbo].[OLoyaltyCard] WITH NOCHECK ADD CONSTRAINT [FK__OLoyaltyCard__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OLoyaltyCard] WITH NOCHECK ADD CONSTRAINT [FK__OLoyaltyCard__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OLoyaltyCard] WITH NOCHECK ADD CONSTRAINT [FK__OLoyaltyCard__TypeId] FOREIGN KEY ([TypeId]) REFERENCES [dbo].[LLoyaltyCardType] ([Id]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[OLoyaltyCard] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[OMailing] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[Name]				[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[Priority]			[smallint]			 NOT NULL,
	[TemplateId]		[bigint]			 NOT NULL,
	[SenderId]			[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[Content]			[text]				 COLLATE Polish_CI_AS NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OMailing] ADD CONSTRAINT [DF__OMailing__Guid__53B9D74A] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OMailing] ADD CONSTRAINT [DF__OMailing__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[OMailing] ADD CONSTRAINT [DF__OMailing__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[OMailing] ADD CONSTRAINT [DF__OMailing__Priority__DefaultValue] DEFAULT (0)FOR [Priority]
GO
ALTER TABLE [dbo].[OMailing] ADD CONSTRAINT [DF_OMailing_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OMailing] ADD CONSTRAINT [DF_OMailing_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OMailing] ADD CONSTRAINT [DF_OMailing_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OMailing] ADD CONSTRAINT [DF_OMailing_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_308196148] ON [dbo].[OMailing]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OMailing] ADD CONSTRAINT [PK__OMailing__52C5B311] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[OMailing] WITH NOCHECK ADD CONSTRAINT [FK__OMailing__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OMailing] WITH NOCHECK ADD CONSTRAINT [FK__OMailing__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OMailing] WITH NOCHECK ADD CONSTRAINT [FK__OMailing__SenderId] FOREIGN KEY ([SenderId]) REFERENCES [dbo].[LMailingSender] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OMailing] WITH NOCHECK ADD CONSTRAINT [FK__OMailing__TemplateId] FOREIGN KEY ([TemplateId]) REFERENCES [dbo].[LTemplate] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[OMergedObject] (
	[Id]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NOT NULL,
	[RootID]		[varchar](80)		 COLLATE Polish_CI_AS NOT NULL,
	[MyId]			[varchar](140)		 COLLATE Polish_CI_AS NULL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL,
	[CreatedBy]		[bigint]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OMergedObject] ADD CONSTRAINT [DF__OMergedObj__Guid__3A97B683] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OMergedObject] ADD CONSTRAINT [DF_OMergedObject_RootID_DefaultValue] DEFAULT ('')FOR [RootID]
GO
ALTER TABLE [dbo].[OMergedObject] ADD CONSTRAINT [DF_OSecurityDefault_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OMergedObject] ADD CONSTRAINT [DF_OSecurityDefault_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OMergedObject] ADD CONSTRAINT [DF_OSecurityDefault_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
ALTER TABLE [dbo].[OMergedObject] ADD CONSTRAINT [DF_OMergedObject_REPLID] DEFAULT (newid())FOR [REPLID]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_951021073] ON [dbo].[OMergedObject]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OMergedObject] ADD CONSTRAINT [PK__OMergedObject__39A3924A] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[OMergedObject] WITH NOCHECK ADD CONSTRAINT [FK_OMergedObject_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OMergedObject] WITH NOCHECK ADD CONSTRAINT [FK_OMergedObject_ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[ONote] (
	[ID]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NULL,
	[Content]		[text]				 COLLATE Polish_CI_AS NULL,
	[Date]			[datetime]			 NOT NULL,
	[Summary]		[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[CategoryID]	[bigint]			 NOT NULL,
	[ModifiedOn]	[datetime]			 NOT NULL,
	[CreatedOn]		[datetime]			 NOT NULL,
	[ModifiedBy]	[bigint]			 NOT NULL,
	[CreatedBy]		[bigint]			 NOT NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[IsText]		[bit]				 NOT NULL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ONote] ADD CONSTRAINT [DF__ONote__GuidID__1F853AD6] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[ONote] ADD CONSTRAINT [DF__ONote__Date__DefaultValue] DEFAULT (getdate())FOR [Date]
GO
ALTER TABLE [dbo].[ONote] ADD CONSTRAINT [DF__ONote__Summary__DefaultValue] DEFAULT ('')FOR [Summary]
GO
ALTER TABLE [dbo].[ONote] ADD CONSTRAINT [DF_ONote_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[ONote] ADD CONSTRAINT [DF__ONote__IsText__DefaultValue] DEFAULT (0)FOR [IsText]
GO
ALTER TABLE [dbo].[ONote] ADD CONSTRAINT [DF_ONote_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[ONote] ADD CONSTRAINT [DF_ONote_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[ONote] ADD CONSTRAINT [DF_ONote_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_468196718] ON [dbo].[ONote]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ONote] ADD CONSTRAINT [PK__ONote__1E91169D] PRIMARY KEY CLUSTERED ([ID])
GO
CREATE TABLE [dbo].[TNoteCategory] (
	[ID]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NULL,
	[Path]					[varchar](39)		 COLLATE Polish_CI_AS NOT NULL,
	[Parent]				[varchar](36)		 COLLATE Polish_CI_AS NULL,
	[Code]					[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[BackgroundColor]		[int]				 NOT NULL,
	[LetterColor]			[int]				 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[EditUsingDesign]		[bit]				 NOT NULL,
	[DesignId]				[bigint]			 NULL,
	[IsReadOnly]			[bit]				 NOT NULL,
	[ForbidAdding]			[bit]				 NOT NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TNoteCategory] ADD CONSTRAINT [DF__TNoteCateg__Guid__4575D994] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[TNoteCategory] ADD CONSTRAINT [DF__TNoteCategories__Path__DefaultValue] DEFAULT ('')FOR [Path]
GO
ALTER TABLE [dbo].[TNoteCategory] ADD CONSTRAINT [DF__TNoteCategory__Code__DefaultValue] DEFAULT ('')FOR [Code]
GO
ALTER TABLE [dbo].[TNoteCategory] ADD CONSTRAINT [DF__TNoteCategory__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[TNoteCategory] ADD CONSTRAINT [DF__TNoteCategory__BackgroundColor__DefaultValue] DEFAULT (0)FOR [BackgroundColor]
GO
ALTER TABLE [dbo].[TNoteCategory] ADD CONSTRAINT [DF__TNoteCategory__LetterColor__DefaultValue] DEFAULT (0)FOR [LetterColor]
GO
ALTER TABLE [dbo].[TNoteCategory] ADD CONSTRAINT [DF_TNoteCategory_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[TNoteCategory] ADD CONSTRAINT [DF__TNoteCategory__EditUsingDesign__DefaultValue] DEFAULT (0)FOR [EditUsingDesign]
GO
ALTER TABLE [dbo].[TNoteCategory] ADD CONSTRAINT [DF__TNoteCategory__IsReadOnly__DefaultValue] DEFAULT (0)FOR [IsReadOnly]
GO
ALTER TABLE [dbo].[TNoteCategory] ADD CONSTRAINT [DF__TNoteCategory__ForbidAdding__DefaultValue] DEFAULT (0)FOR [ForbidAdding]
GO
ALTER TABLE [dbo].[TNoteCategory] ADD CONSTRAINT [DF_TNoteCategory_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[TNoteCategory] ADD CONSTRAINT [DF_TNoteCategory_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[TNoteCategory] ADD CONSTRAINT [DF_TNoteCategory_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_548197003] ON [dbo].[TNoteCategory]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TNoteCategory] ADD CONSTRAINT [PK__TNoteCategories__4481B55B] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[TNoteCategory] ADD CONSTRAINT [uq_Code] UNIQUE NONCLUSTERED ([Code])
GO
ALTER TABLE [dbo].[TNoteCategory] WITH NOCHECK ADD CONSTRAINT [FK__TNoteCategory__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[TNoteCategory] WITH NOCHECK ADD CONSTRAINT [FK__TNoteCategory__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[TNoteCategory] TO [RaportyWEB]
GO
ALTER TABLE [dbo].[ONote] WITH NOCHECK ADD CONSTRAINT [FK__ONote__CategoryID] FOREIGN KEY ([CategoryID]) REFERENCES [dbo].[TNoteCategory] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[ONote] WITH NOCHECK ADD CONSTRAINT [FK__ONote__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[ONote] WITH NOCHECK ADD CONSTRAINT [FK__ONote__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT INSERT ON [dbo].[ONote] TO [RaportyWEB]
GO
GRANT SELECT ON [dbo].[ONote] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[OObjectTag] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ObjectId]				[bigint]			 NOT NULL,
	[ObjectCode]			[varchar](50)		 COLLATE Polish_CI_AS NULL,
	[Name]					[varchar](200)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]			[varchar](500)		 COLLATE Polish_CI_AS NULL,
	[TagId]					[bigint]			 NOT NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[ConfigurationId]		[bigint]			 NULL,
	[Parameters]			[varchar](2000)		 COLLATE Polish_CI_AS NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OObjectTag] ADD CONSTRAINT [DF__OObjectTag__Guid__668CB49C] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OObjectTag] ADD CONSTRAINT [DF__OObjectTag__ObjectId__DefaultValue] DEFAULT (0)FOR [ObjectId]
GO
ALTER TABLE [dbo].[OObjectTag] ADD CONSTRAINT [DF__OObjectTag__ObjectCode__DefaultValue] DEFAULT ('')FOR [ObjectCode]
GO
ALTER TABLE [dbo].[OObjectTag] ADD CONSTRAINT [DF__OObjectTag__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[OObjectTag] ADD CONSTRAINT [DF__OObjectTag__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[OObjectTag] ADD CONSTRAINT [DF_OObjectTag_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OObjectTag] ADD CONSTRAINT [DF__OObjectTag__Parameters__DefaultValue] DEFAULT ('')FOR [Parameters]
GO
ALTER TABLE [dbo].[OObjectTag] ADD CONSTRAINT [DF_OObjectTag_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OObjectTag] ADD CONSTRAINT [DF_OObjectTag_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OObjectTag] ADD CONSTRAINT [DF_OObjectTag_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_772197801] ON [dbo].[OObjectTag]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OObjectTag] ADD CONSTRAINT [PK__OObjectTag__65989063] PRIMARY KEY CLUSTERED ([Id])
GO
CREATE TABLE [dbo].[TConfiguration] (
	[Id]							[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]							[uniqueidentifier]	 NOT NULL,
	[Path]							[varchar](54)		 COLLATE Polish_CI_AS NOT NULL,
	[Parent]						[varchar](36)		 COLLATE Polish_CI_AS NULL,
	[Name]							[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[UserCompanyPersonId]			[bigint]			 NULL,
	[CompanyId]						[bigint]			 NULL,
	[Value]							[image]				 NULL,
	[ApplicationWorkMode]			[smallint]			 NOT NULL,
	[ApplicationDeploymentMode]		[smallint]			 NOT NULL,
	[SerializationLabel]			[varchar](100)		 COLLATE Polish_CI_AS NULL,
	[CreatedOn]						[datetime]			 NULL,
	[ModifiedOn]					[datetime]			 NULL,
	[CreatedBy]						[bigint]			 NULL,
	[ModifiedBy]					[bigint]			 NULL,
	[REPLID]						[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]							[bigint]			 NOT NULL,
	[SecW]							[bigint]			 NOT NULL,
	[SecD]							[bigint]			 NOT NULL
) ON [SECONDARY]
GO
ALTER TABLE [dbo].[TConfiguration] ADD CONSTRAINT [DF__TConfigura__Guid__012B9C3F] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[TConfiguration] ADD CONSTRAINT [DF__TConfiguration__Path__DefaultValue] DEFAULT ('')FOR [Path]
GO
ALTER TABLE [dbo].[TConfiguration] ADD CONSTRAINT [DF__TConfiguration__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[TConfiguration] ADD CONSTRAINT [DF__TConfiguration__UserCompanyPersonId__DefaultValue] DEFAULT (0)FOR [UserCompanyPersonId]
GO
ALTER TABLE [dbo].[TConfiguration] ADD CONSTRAINT [DF__TConfiguration__CompanyId__DefaultValue] DEFAULT (0)FOR [CompanyId]
GO
ALTER TABLE [dbo].[TConfiguration] ADD CONSTRAINT [DF__TConfiguration__ApplicationWorkMode__DefaultValue] DEFAULT (0)FOR [ApplicationWorkMode]
GO
ALTER TABLE [dbo].[TConfiguration] ADD CONSTRAINT [DF__TConfiguration__ApplicationDeploymentMode__DefaultValue] DEFAULT (0)FOR [ApplicationDeploymentMode]
GO
ALTER TABLE [dbo].[TConfiguration] ADD CONSTRAINT [DF__TConfiguration__SerializationLabel__DefaultValue] DEFAULT ('')FOR [SerializationLabel]
GO
ALTER TABLE [dbo].[TConfiguration] ADD CONSTRAINT [DF_TConfiguration_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[TConfiguration] ADD CONSTRAINT [DF_TConfiguration_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[TConfiguration] ADD CONSTRAINT [DF_TConfiguration_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[TConfiguration] ADD CONSTRAINT [DF_TConfiguration_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1570820658] ON [dbo].[TConfiguration]([REPLID]) ON [SECONDARY]
GO
ALTER TABLE [dbo].[TConfiguration] ADD CONSTRAINT [PK__TConfiguration__00377806] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[OObjectTag] WITH NOCHECK ADD CONSTRAINT [FK__OObjectTag__ConfigurationIdId] FOREIGN KEY ([ConfigurationId]) REFERENCES [dbo].[TConfiguration] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OObjectTag] WITH NOCHECK ADD CONSTRAINT [FK__OObjectTag__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OObjectTag] WITH NOCHECK ADD CONSTRAINT [FK__OObjectTag__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OObjectTag] WITH NOCHECK ADD CONSTRAINT [FK__OObjectTag__TagId] FOREIGN KEY ([TagId]) REFERENCES [dbo].[LTag] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[OPerson] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NULL,
	[FirstName]			[varchar](100)		 COLLATE Polish_CI_AS NULL,
	[Surname]			[varchar](100)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[Description]		[text]				 COLLATE Polish_CI_AS NULL,
	[TitleId]			[bigint]			 NULL,
	[Gender]			[smallint]			 NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OPerson] ADD CONSTRAINT [DF__OPerson__GuidID__5695789E] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OPerson] ADD CONSTRAINT [DF__OPerson__FirstName__DefaultValue] DEFAULT ('')FOR [FirstName]
GO
ALTER TABLE [dbo].[OPerson] ADD CONSTRAINT [DF__OPerson__Surname__DefaultValue] DEFAULT ('')FOR [Surname]
GO
ALTER TABLE [dbo].[OPerson] ADD CONSTRAINT [DF__OPerson__Gender__DefaultValue] DEFAULT (0)FOR [Gender]
GO
ALTER TABLE [dbo].[OPerson] ADD CONSTRAINT [DF_OPerson_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OPerson] ADD CONSTRAINT [DF_OPerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OPerson] ADD CONSTRAINT [DF_OPerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OPerson] ADD CONSTRAINT [DF_OPerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE NONCLUSTERED INDEX [_dta_index_OPerson_38_932198371__K1_K2_K4_K3] ON [dbo].[OPerson]([ID], [Guid], [Surname], [FirstName]) ON [PRIMARY]
GO
CREATE STATISTICS [_dta_stat_932198371_2_4_3] ON [dbo].[OPerson]([Guid], [Surname], [FirstName], [ID]) 

GO
CREATE UNIQUE NONCLUSTERED INDEX [index_932198371] ON [dbo].[OPerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OPerson] ADD CONSTRAINT [PK__OPerson__55A15465] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[OPerson] WITH NOCHECK ADD CONSTRAINT [FK__OPerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OPerson] WITH NOCHECK ADD CONSTRAINT [FK__OPerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OPerson] WITH NOCHECK ADD CONSTRAINT [FK__OPerson__TitleId] FOREIGN KEY ([TitleId]) REFERENCES [dbo].[LPersonTitle] ([Id]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[OPerson] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[OPhone] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NULL,
	[CountryID]			[bigint]			 NOT NULL,
	[AreaCode]			[varchar](5)		 COLLATE Polish_CI_AS NOT NULL,
	[Number]			[varchar](20)		 COLLATE Polish_CI_AS NOT NULL,
	[InternalNumber]	[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[PhoneTypeID]		[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[Index]				[int]				 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[__Description]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[BDK1PhoneType]		[varchar](100)		 COLLATE Polish_CI_AS NULL,
	[BDK1Phone]			[text]				 COLLATE Polish_CI_AS NULL,
	[FormattedPhone]	[varchar](100)		 COLLATE Polish_CI_AS NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL,
	[DoNotUse]			[bit]				 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OPhone] ADD CONSTRAINT [DF__OPhone__GuidID__2667428F] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OPhone] ADD CONSTRAINT [DF__OPhone__AreaCode__DefaultValue] DEFAULT ('')FOR [AreaCode]
GO
ALTER TABLE [dbo].[OPhone] ADD CONSTRAINT [DF__OPhone__Number__DefaultValue] DEFAULT ('')FOR [Number]
GO
ALTER TABLE [dbo].[OPhone] ADD CONSTRAINT [DF__OPhone__InternalNumber__DefaultValue] DEFAULT ('')FOR [InternalNumber]
GO
ALTER TABLE [dbo].[OPhone] ADD CONSTRAINT [DF_OPhone_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OPhone] ADD CONSTRAINT [DF__OPhone__Description__DefaultValue] DEFAULT ('')FOR [__Description]
GO
ALTER TABLE [dbo].[OPhone] ADD CONSTRAINT [DF_OPhone_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OPhone] ADD CONSTRAINT [DF_OPhone_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OPhone] ADD CONSTRAINT [DF_OPhone_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
ALTER TABLE [dbo].[OPhone] ADD CONSTRAINT [DF_OPhone_DoNotUse_DefaultValue] DEFAULT (0)FOR [DoNotUse]
GO
CREATE STATISTICS [_dta_stat_1861841945_1_7] ON [dbo].[OPhone]([ID], [PhoneTypeID]) 

GO
CREATE STATISTICS [_dta_stat_1861841945_7_3] ON [dbo].[OPhone]([PhoneTypeID], [CountryID], [ID]) 

GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1076198884] ON [dbo].[OPhone]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OPhone] ADD CONSTRAINT [PK__OPhone__25731E56] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[OPhone] WITH NOCHECK ADD CONSTRAINT [FK_OPhone_LCountry] FOREIGN KEY ([CountryID]) REFERENCES [dbo].[LCountry] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OPhone] WITH NOCHECK ADD CONSTRAINT [FK_OPhone_LPhoneType] FOREIGN KEY ([PhoneTypeID]) REFERENCES [dbo].[LPhoneType] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[OPhone] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[OPhoneLog] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[CalledNr]			[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[CallingNr]			[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[AlertingNr]		[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[AnsweringNr]		[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[EndDate]			[datetime]			 NOT NULL,
	[IsInternal]		[bit]				 NOT NULL,
	[DebugInfo]			[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[ModifiedOn]		[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [SECONDARY]
GO
ALTER TABLE [dbo].[OPhoneLog] ADD CONSTRAINT [DF__OPhoneLog__Guid__1A2DEAE1] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OPhoneLog] ADD CONSTRAINT [DF__OPhoneLog__CalledNr__DefaultValue] DEFAULT ('')FOR [CalledNr]
GO
ALTER TABLE [dbo].[OPhoneLog] ADD CONSTRAINT [DF__OPhoneLog__CallingNr__DefaultValue] DEFAULT ('')FOR [CallingNr]
GO
ALTER TABLE [dbo].[OPhoneLog] ADD CONSTRAINT [DF__OPhoneLog__AlertingNr__DefaultValue] DEFAULT ('')FOR [AlertingNr]
GO
ALTER TABLE [dbo].[OPhoneLog] ADD CONSTRAINT [DF__OPhoneLog__AnsweringNr__DefaultValue] DEFAULT ('')FOR [AnsweringNr]
GO
ALTER TABLE [dbo].[OPhoneLog] ADD CONSTRAINT [DF__OPhoneLog__EndDate__DefaultValue] DEFAULT (getdate())FOR [EndDate]
GO
ALTER TABLE [dbo].[OPhoneLog] ADD CONSTRAINT [DF__OPhoneLog__IsInternal__DefaultValue] DEFAULT (0)FOR [IsInternal]
GO
ALTER TABLE [dbo].[OPhoneLog] ADD CONSTRAINT [DF__OPhoneLog__DebugInfo__DefaultValue] DEFAULT ('')FOR [DebugInfo]
GO
ALTER TABLE [dbo].[OPhoneLog] ADD CONSTRAINT [DF_OPhoneLog_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OPhoneLog] ADD CONSTRAINT [DF_OPhoneLog_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OPhoneLog] ADD CONSTRAINT [DF_OPhoneLog_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OPhoneLog] ADD CONSTRAINT [DF_OPhoneLog_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1671937278] ON [dbo].[OPhoneLog]([REPLID]) ON [SECONDARY]
GO
ALTER TABLE [dbo].[OPhoneLog] ADD CONSTRAINT [PK_OPhoneLog] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[OPhoneLog] WITH NOCHECK ADD CONSTRAINT [FK__OPhoneLog__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OPhoneLog] WITH NOCHECK ADD CONSTRAINT [FK__OPhoneLog_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[OProjectItem] (
	[Id]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NOT NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[CreatedOn]					[datetime]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[Code]						[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[Name]						[varchar](200)		 COLLATE Polish_CI_AS NULL,
	[Description]				[text]				 COLLATE Polish_CI_AS NULL,
	[StatusId]					[bigint]			 NOT NULL,
	[DateTypeId]				[bigint]			 NOT NULL,
	[EstimatedStartDate]		[datetime]			 NULL,
	[EstimatedEndDate]			[datetime]			 NULL,
	[ComputedStartDate]			[datetime]			 NULL,
	[ComputedEndDate]			[datetime]			 NULL,
	[ActualStartDate]			[datetime]			 NULL,
	[ActualEndDate]				[datetime]			 NULL,
	[Deadline]					[datetime]			 NULL,
	[EstimatedCost]				[money]				 NULL,
	[ActualCost]				[money]				 NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[IsTemplate]				[smallint]			 NOT NULL,
	[DerivedFullName]			[varchar](2000)		 COLLATE Polish_CI_AS NULL,
	[IsProject]					[bit]				 NOT NULL,
	[DerivedActualCost]			[money]				 NULL,
	[DerivedEstimatedCost]		[money]				 NULL,
	[ActiveSubProjectId]		[bigint]			 NOT NULL,
	[EstimatedIncome]			[money]				 NULL,
	[ActualIncome]				[money]				 NULL,
	[DerivedActualIncome]		[money]				 NULL,
	[DerivedEstimatedIncome]	[money]				 NULL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OProjectItem] ADD CONSTRAINT [DF__OProjectIt__Guid__4A3B5A08] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OProjectItem] ADD CONSTRAINT [DF__OProjectItem__Code__DefaultValue] DEFAULT ('')FOR [Code]
GO
ALTER TABLE [dbo].[OProjectItem] ADD CONSTRAINT [DF__OProjectItem__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[OProjectItem] ADD CONSTRAINT [DF__OProjectItem__EstimatedStartDate__DefaultValue] DEFAULT (getdate())FOR [EstimatedStartDate]
GO
ALTER TABLE [dbo].[OProjectItem] ADD CONSTRAINT [DF__OProjectItem__EstimatedEndDate__DefaultValue] DEFAULT (getdate())FOR [EstimatedEndDate]
GO
ALTER TABLE [dbo].[OProjectItem] ADD CONSTRAINT [DF__OProjectItem__ComputedStartDate__DefaultValue] DEFAULT (getdate())FOR [ComputedStartDate]
GO
ALTER TABLE [dbo].[OProjectItem] ADD CONSTRAINT [DF__OProjectItem__ComputedEndDate__DefaultValue] DEFAULT (getdate())FOR [ComputedEndDate]
GO
ALTER TABLE [dbo].[OProjectItem] ADD CONSTRAINT [DF__OProjectItem__ActualStartDate__DefaultValue] DEFAULT (getdate())FOR [ActualStartDate]
GO
ALTER TABLE [dbo].[OProjectItem] ADD CONSTRAINT [DF__OProjectItem__ActualEndDate__DefaultValue] DEFAULT (getdate())FOR [ActualEndDate]
GO
ALTER TABLE [dbo].[OProjectItem] ADD CONSTRAINT [DF__OProjectItem__Deadline__DefaultValue] DEFAULT (getdate())FOR [Deadline]
GO
ALTER TABLE [dbo].[OProjectItem] ADD CONSTRAINT [DF_OProjectItem_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OProjectItem] ADD CONSTRAINT [DF__OProjectI__IsTem__51E79A92] DEFAULT (0)FOR [IsTemplate]
GO
ALTER TABLE [dbo].[OProjectItem] ADD CONSTRAINT [DF__OProjectItem__IsProject__DefaultValue] DEFAULT (0)FOR [IsProject]
GO
ALTER TABLE [dbo].[OProjectItem] ADD CONSTRAINT [DF__OProjectItem__ActiveSubProjectId__DefaultValue] DEFAULT (0)FOR [ActiveSubProjectId]
GO
ALTER TABLE [dbo].[OProjectItem] ADD CONSTRAINT [DF_OProjectItem_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OProjectItem] ADD CONSTRAINT [DF_OProjectItem_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OProjectItem] ADD CONSTRAINT [DF_OProjectItem_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1380199967] ON [dbo].[OProjectItem]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OProjectItem] ADD CONSTRAINT [PK__OProjectItem__494735CF] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[OProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__OProjectItem__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__OProjectItem__DateTypeId] FOREIGN KEY ([DateTypeId]) REFERENCES [dbo].[LProjectItemDateType] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__OProjectItem__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__OProjectItem__StatusId] FOREIGN KEY ([StatusId]) REFERENCES [dbo].[LProjectItemStatus] ([Id]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[OProjectItem] TO [formularze2]
GO
CREATE TABLE [dbo].[OResource] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[Name]					[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[Code]					[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]			[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[StatusId]				[bigint]			 NULL,
	[Symbol]				[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[DerivedFullName]		[varchar](2000)		 COLLATE Polish_CI_AS NOT NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OResource] ADD CONSTRAINT [DF__OResource__Guid__16926427] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OResource] ADD CONSTRAINT [DF__OResource__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[OResource] ADD CONSTRAINT [DF_OResource_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OResource] ADD CONSTRAINT [DF__OResource__Code__DefaultValue] DEFAULT ('')FOR [Code]
GO
ALTER TABLE [dbo].[OResource] ADD CONSTRAINT [DF__OResource__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[OResource] ADD CONSTRAINT [DF__OResource__Symbol__DefaultValue] DEFAULT ('')FOR [Symbol]
GO
ALTER TABLE [dbo].[OResource] ADD CONSTRAINT [DF__OResource__DerivedFullName__DefaultValue] DEFAULT ('')FOR [DerivedFullName]
GO
ALTER TABLE [dbo].[OResource] ADD CONSTRAINT [DF_OResource_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OResource] ADD CONSTRAINT [DF_OResource_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OResource] ADD CONSTRAINT [DF_OResource_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_388456708] ON [dbo].[OResource]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OResource] ADD CONSTRAINT [PK__OResource__159E3FEE] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[OResource] WITH NOCHECK ADD CONSTRAINT [FK__OResource__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OResource] WITH NOCHECK ADD CONSTRAINT [FK__OResource__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OResource] WITH NOCHECK ADD CONSTRAINT [FK__OResource__Statu__6FC0E322] FOREIGN KEY ([StatusId]) REFERENCES [dbo].[LResourceStatus] ([Id]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[OResource] TO [RaportyWEBZewn]
GO
CREATE TABLE [dbo].[OSale] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[Description]		[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OSale] ADD CONSTRAINT [DF__OSale__Guid__3D0BA9B7] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OSale] ADD CONSTRAINT [DF__OSale__REPLID__3FE81662] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OSale] ADD CONSTRAINT [DF__OSale__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[OSale] ADD CONSTRAINT [DF_OSale_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OSale] ADD CONSTRAINT [DF_OSale_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OSale] ADD CONSTRAINT [DF_OSale_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_992174405] ON [dbo].[OSale]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OSale] ADD CONSTRAINT [PK__OSale__3C17857E] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[OSale] WITH NOCHECK ADD CONSTRAINT [FK__OSale__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OSale] WITH NOCHECK ADD CONSTRAINT [FK__OSale__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[OSecurityDefault] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[Type]					[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[Property]				[varchar](100)		 COLLATE Polish_CI_AS NULL,
	[Value]					[varchar](100)		 COLLATE Polish_CI_AS NULL,
	[EvaluationAction]		[varchar](3000)		 COLLATE Polish_CI_AS NULL,
	[Category]				[smallint]			 NOT NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[CreatedOn]				[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL,
	[DefaultSecR]			[bigint]			 NOT NULL,
	[DefaultSecW]			[bigint]			 NOT NULL,
	[DefaultSecD]			[bigint]			 NOT NULL,
	[RequiredSecC]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OSecurityDefault] ADD CONSTRAINT [DF__OSecurityD__Guid__432CFC84] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OSecurityDefault] ADD CONSTRAINT [DF_OSecurityDefault_Type_DefaultValue] DEFAULT ('')FOR [Type]
GO
ALTER TABLE [dbo].[OSecurityDefault] ADD CONSTRAINT [DF_OSecurityDefault_Category_DefaultValue] DEFAULT (0)FOR [Category]
GO
ALTER TABLE [dbo].[OSecurityDefault] ADD CONSTRAINT [DF_OSecurityDefault_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OSecurityDefault] ADD CONSTRAINT [DF__OSecurityDefault_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OSecurityDefault] ADD CONSTRAINT [DF__OSecurityDefault_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OSecurityDefault] ADD CONSTRAINT [DF__OSecurityDefault_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
ALTER TABLE [dbo].[OSecurityDefault] ADD CONSTRAINT [DF_OSecurityDefault_DefaultSecR_DefaultValue] DEFAULT (0)FOR [DefaultSecR]
GO
ALTER TABLE [dbo].[OSecurityDefault] ADD CONSTRAINT [DF_OSecurityDefault_DefaultSecW_DefaultValue] DEFAULT (0)FOR [DefaultSecW]
GO
ALTER TABLE [dbo].[OSecurityDefault] ADD CONSTRAINT [DF_OSecurityDefault_DefaultSecD_DefaultValue] DEFAULT (0)FOR [DefaultSecD]
GO
ALTER TABLE [dbo].[OSecurityDefault] ADD CONSTRAINT [DF_OSecurityDefault_RequiredSecC_DefaultValue] DEFAULT (0)FOR [RequiredSecC]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1095021586] ON [dbo].[OSecurityDefault]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OSecurityDefault] ADD CONSTRAINT [PK__OSecurityDefault__4238D84B] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[OSecurityDefault] WITH NOCHECK ADD CONSTRAINT [FK__OSecurityDefault_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OSecurityDefault] WITH NOCHECK ADD CONSTRAINT [FK__OSecurityDefault_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[OServerTask] (
	[Id]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NOT NULL,
	[CreatedOn]					[datetime]			 NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[Name]						[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]				[varchar](500)		 COLLATE Polish_CI_AS NULL,
	[Action]					[text]				 COLLATE Polish_CI_AS NULL,
	[LastExecutionDate]			[datetime]			 NULL,
	[LastExecutionServerId]		[bigint]			 NULL,
	[Enabled]					[bit]				 NOT NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OServerTask] ADD CONSTRAINT [DF__OServerTas__Guid__67FA6403] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OServerTask] ADD CONSTRAINT [DF__OServerTask__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[OServerTask] ADD CONSTRAINT [DF__OServerTask__Enabled__DefaultValue] DEFAULT (0)FOR [Enabled]
GO
ALTER TABLE [dbo].[OServerTask] ADD CONSTRAINT [DF_OServerTask_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OServerTask] ADD CONSTRAINT [DF_OServerTask_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OServerTask] ADD CONSTRAINT [DF_OServerTask_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OServerTask] ADD CONSTRAINT [DF_OServerTask_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1712462737] ON [dbo].[OServerTask]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OServerTask] ADD CONSTRAINT [PK__OServerTask__67063FCA] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[OServerTask] WITH NOCHECK ADD CONSTRAINT [FK__OServerTask__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OServerTask] WITH NOCHECK ADD CONSTRAINT [FK__OServerTask__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[OShipment] (
	[ID]							[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]							[uniqueidentifier]	 NOT NULL,
	[REPLID]						[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[CreationDate]					[datetime]			 NOT NULL,
	[IsSent]						[bit]				 NOT NULL,
	[PackageNr]						[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[ParentPackageNr]				[varchar](50)		 COLLATE Polish_CI_AS NULL,
	[InGroupNumber]					[int]				 NOT NULL,
	[InGroupCount]					[int]				 NOT NULL,
	[ShipmentParameterGroupID]		[bigint]			 NOT NULL,
	[Content]						[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[UserComment]					[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[AssuranceValue]				[money]				 NOT NULL,
	[CashOnDelivery]				[money]				 NOT NULL,
	[Weight]						[decimal](18, 4)	 NOT NULL,
	[ShipmentStatusID]				[bigint]			 NOT NULL,
	[CreatedOn]						[datetime]			 NULL,
	[CreatedBy]						[bigint]			 NULL,
	[ModifiedOn]					[datetime]			 NULL,
	[ModifiedBy]					[bigint]			 NULL,
	[SecR]							[bigint]			 NOT NULL,
	[SecW]							[bigint]			 NOT NULL,
	[SecD]							[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OShipment] ADD CONSTRAINT [DF_OShipment_Guid] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OShipment] ADD CONSTRAINT [DF_OShipment_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OShipment] ADD CONSTRAINT [DF_OShipment_CreationDate] DEFAULT (getdate())FOR [CreationDate]
GO
ALTER TABLE [dbo].[OShipment] ADD CONSTRAINT [DF_OShipment_IsSend] DEFAULT (0)FOR [IsSent]
GO
ALTER TABLE [dbo].[OShipment] ADD CONSTRAINT [DF_OShipment_InGroupNumber] DEFAULT (0)FOR [InGroupNumber]
GO
ALTER TABLE [dbo].[OShipment] ADD CONSTRAINT [DF_OShipment_IsInGroup] DEFAULT (0)FOR [InGroupCount]
GO
ALTER TABLE [dbo].[OShipment] ADD CONSTRAINT [DF_OShipment_Content] DEFAULT ('')FOR [Content]
GO
ALTER TABLE [dbo].[OShipment] ADD CONSTRAINT [DF_OShipment_UserComment] DEFAULT ('')FOR [UserComment]
GO
ALTER TABLE [dbo].[OShipment] ADD CONSTRAINT [DF_OShipment_PackageValue] DEFAULT (0)FOR [AssuranceValue]
GO
ALTER TABLE [dbo].[OShipment] ADD CONSTRAINT [DF_OShipment_CashOnDelivery] DEFAULT (0)FOR [CashOnDelivery]
GO
ALTER TABLE [dbo].[OShipment] ADD CONSTRAINT [DF_OShipment_Weight] DEFAULT (0)FOR [Weight]
GO
ALTER TABLE [dbo].[OShipment] ADD CONSTRAINT [DF_OShipment_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OShipment] ADD CONSTRAINT [DF_OShipment_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OShipment] ADD CONSTRAINT [DF_OShipment_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_210932669] ON [dbo].[OShipment]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OShipment] ADD CONSTRAINT [PK_OShipment] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[OShipment] WITH NOCHECK ADD CONSTRAINT [FK__OShipment_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OShipment] WITH NOCHECK ADD CONSTRAINT [FK__OShipment_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT DELETE ON [dbo].[OShipment] TO [BDKProgramyZewnetrzne]
GO
GRANT INSERT ON [dbo].[OShipment] TO [BDKProgramyZewnetrzne]
GO
GRANT SELECT ON [dbo].[OShipment] TO [BDKProgramyZewnetrzne]
GO
GRANT UPDATE ON [dbo].[OShipment] TO [BDKProgramyZewnetrzne]
GO
CREATE TABLE [dbo].[OShipmentReport] (
	[ID]							[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[GUID]							[uniqueidentifier]	 NOT NULL,
	[REPLID]						[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[Name]							[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[ReportNumber]					[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[ShipmentParameterGroupID]		[bigint]			 NOT NULL,
	[CreationDate]					[datetime]			 NOT NULL,
	[IsSent]						[bit]				 NOT NULL,
	[CreatedOn]						[datetime]			 NULL,
	[CreatedBy]						[bigint]			 NULL,
	[ModifiedOn]					[datetime]			 NULL,
	[ModifiedBy]					[bigint]			 NULL,
	[SecR]							[bigint]			 NOT NULL,
	[SecW]							[bigint]			 NOT NULL,
	[SecD]							[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OShipmentReport] ADD CONSTRAINT [DF_OShipmentReport_GUID] DEFAULT (newid())FOR [GUID]
GO
ALTER TABLE [dbo].[OShipmentReport] ADD CONSTRAINT [DF_OShipmentReport_ROWGUID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OShipmentReport] ADD CONSTRAINT [DF_OShipmentReport_SendDate] DEFAULT (getdate())FOR [CreationDate]
GO
ALTER TABLE [dbo].[OShipmentReport] ADD CONSTRAINT [DF_OShipmentReport_IsSent] DEFAULT (0)FOR [IsSent]
GO
ALTER TABLE [dbo].[OShipmentReport] ADD CONSTRAINT [DF_OShipmentReport_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OShipmentReport] ADD CONSTRAINT [DF_OShipmentReport_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OShipmentReport] ADD CONSTRAINT [DF_OShipmentReport_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_418933410] ON [dbo].[OShipmentReport]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OShipmentReport] ADD CONSTRAINT [PK_OShipmentReport] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[OShipmentReport] WITH NOCHECK ADD CONSTRAINT [FK__OShipmentReport_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OShipmentReport] WITH NOCHECK ADD CONSTRAINT [FK__OShipmentReport_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OShipmentReport] WITH NOCHECK ADD CONSTRAINT [FK_OShipmentReport_LShipmentParameterGroup] FOREIGN KEY ([ShipmentParameterGroupID]) REFERENCES [dbo].[LShipmentParameterGroup] ([ID]) NOT FOR REPLICATION
GO
GRANT DELETE ON [dbo].[OShipmentReport] TO [BDKProgramyZewnetrzne]
GO
GRANT INSERT ON [dbo].[OShipmentReport] TO [BDKProgramyZewnetrzne]
GO
GRANT SELECT ON [dbo].[OShipmentReport] TO [BDKProgramyZewnetrzne]
GO
GRANT UPDATE ON [dbo].[OShipmentReport] TO [BDKProgramyZewnetrzne]
GO
CREATE TABLE [dbo].[OSmsLog] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[DestinationNr]		[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[Message]			[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[IsPrivate]			[bit]				 NOT NULL,
	[SendingDate]		[datetime]			 NOT NULL,
	[ProcessingDate]	[datetime]			 NOT NULL,
	[PreviousSmsId]		[bigint]			 NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OSmsLog] ADD CONSTRAINT [DF__OSmsLog__Guid__0FB05C6E] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OSmsLog] ADD CONSTRAINT [DF__OSmsLog__DestinationNr__DefaultValue] DEFAULT ('')FOR [DestinationNr]
GO
ALTER TABLE [dbo].[OSmsLog] ADD CONSTRAINT [DF__OSmsLog__Message__DefaultValue] DEFAULT ('')FOR [Message]
GO
ALTER TABLE [dbo].[OSmsLog] ADD CONSTRAINT [DF__OSmsLog__IsPrivate__DefaultValue] DEFAULT (0)FOR [IsPrivate]
GO
ALTER TABLE [dbo].[OSmsLog] ADD CONSTRAINT [DF__OSmsLog__SendingDate__DefaultValue] DEFAULT (getdate())FOR [SendingDate]
GO
ALTER TABLE [dbo].[OSmsLog] ADD CONSTRAINT [DF__OSmsLog__ProcessingDate__DefaultValue] DEFAULT (getdate())FOR [ProcessingDate]
GO
ALTER TABLE [dbo].[OSmsLog] ADD CONSTRAINT [DF__OSmsLog__PreviousSmsId__DefaultValue] DEFAULT (0)FOR [PreviousSmsId]
GO
ALTER TABLE [dbo].[OSmsLog] ADD CONSTRAINT [DF_OSmsLog_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OSmsLog] ADD CONSTRAINT [DF_OSmsLog_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OSmsLog] ADD CONSTRAINT [DF_OSmsLog_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OSmsLog] ADD CONSTRAINT [DF_OSmsLog_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1479936594] ON [dbo].[OSmsLog]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OSmsLog] ADD CONSTRAINT [PK__OSmsLog__0EBC3835] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[OSmsLog] WITH NOCHECK ADD CONSTRAINT [FK__OSmsLog__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OSmsLog] WITH NOCHECK ADD CONSTRAINT [FK__OSmsLog__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[OSupportIssue] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NULL,
	[ModifiedOn]		[datetime]			 NOT NULL,
	[CreatedOn]			[datetime]			 NOT NULL,
	[ModifiedBy]		[bigint]			 NOT NULL,
	[CreatedBy]			[bigint]			 NOT NULL,
	[Description]		[text]				 COLLATE Polish_CI_AS NOT NULL,
	[StatusId]			[bigint]			 NOT NULL,
	[ResolutionId]		[bigint]			 NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[PriorityId]		[bigint]			 NULL,
	[Code]				[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[StartDate]			[datetime]			 NULL,
	[EndDate]			[datetime]			 NULL,
	[StatusEndDate]		[datetime]			 NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OSupportIssue] ADD CONSTRAINT [DF__OSupportIs__Guid__0FD8E2F2] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OSupportIssue] ADD CONSTRAINT [DF_OSupportIssue_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OSupportIssue] ADD CONSTRAINT [DF__OSupportIssue__Code__DefaultValue] DEFAULT ('')FOR [Code]
GO
ALTER TABLE [dbo].[OSupportIssue] ADD CONSTRAINT [DF_OSupportIssue_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OSupportIssue] ADD CONSTRAINT [DF_OSupportIssue_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OSupportIssue] ADD CONSTRAINT [DF_OSupportIssue_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1668200993] ON [dbo].[OSupportIssue]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OSupportIssue] ADD CONSTRAINT [PK__OSupportIssue__0EE4BEB9] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[OSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK__OSupportIssue__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK__OSupportIssue__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK__OSupportIssue__ResolutionId] FOREIGN KEY ([ResolutionId]) REFERENCES [dbo].[LSupportIssueResolution] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK__OSupportIssue__StatusId] FOREIGN KEY ([StatusId]) REFERENCES [dbo].[LSupportIssueStatus] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK_OSupportIssue_PriorityId] FOREIGN KEY ([PriorityId]) REFERENCES [dbo].[LsupportIssuePriority] ([ID]) NOT FOR REPLICATION
GO
GRANT INSERT ON [dbo].[OSupportIssue] TO [RaportyWEB]
GO
GRANT SELECT ON [dbo].[OSupportIssue] TO [RaportyWEB]
GO
GRANT UPDATE ON [dbo].[OSupportIssue] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[OSystemConfiguration] (
	[Id]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NOT NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[Key]			[varchar](150)		 COLLATE Polish_CI_AS NOT NULL,
	[Value]			[text]				 COLLATE Polish_CI_AS NULL,
	[ServerId]		[bigint]			 NOT NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OSystemConfiguration] ADD CONSTRAINT [DF__OSystemCon__Guid__03A27E78] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[OSystemConfiguration] ADD CONSTRAINT [DF__OSystemConfiguration__Key__DefaultValue] DEFAULT ('')FOR [Key]
GO
ALTER TABLE [dbo].[OSystemConfiguration] ADD CONSTRAINT [DF_OSystemConfiguration_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[OSystemConfiguration] ADD CONSTRAINT [DF_OSystemConfiguration_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[OSystemConfiguration] ADD CONSTRAINT [DF_OSystemConfiguration_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[OSystemConfiguration] ADD CONSTRAINT [DF_OSystemConfiguration_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_28980742] ON [dbo].[OSystemConfiguration]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OSystemConfiguration] ADD CONSTRAINT [PK__OSystemConfigura__02AE5A3F] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[OSystemConfiguration] WITH NOCHECK ADD CONSTRAINT [FK__OSystemConfiguration__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OSystemConfiguration] WITH NOCHECK ADD CONSTRAINT [FK__OSystemConfiguration__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[OSystemConfiguration] WITH NOCHECK ADD CONSTRAINT [FK__OSystemConfiguration__ServerId] FOREIGN KEY ([ServerId]) REFERENCES [dbo].[LDatabaseServer] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RAddressCompany] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1AddressID]		[bigint]			 NOT NULL,
	[R2CompanyID]		[bigint]			 NOT NULL,
	[TypeID]			[bigint]			 NOT NULL,
	[Description]		[varchar](1000)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[IsDefault]			[bit]				 NOT NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RAddressCompany] ADD CONSTRAINT [DF__RAddressC__GuidI__23D4EEA7] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RAddressCompany] ADD CONSTRAINT [DF__RAddressCompany__Comment__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RAddressCompany] ADD CONSTRAINT [DF_RAddressCompany_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RAddressCompany] ADD CONSTRAINT [DF__RAddressCompany__IsDefault__DefaultValue] DEFAULT (0)FOR [IsDefault]
GO
ALTER TABLE [dbo].[RAddressCompany] ADD CONSTRAINT [DF_RAddressCompany_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RAddressCompany] ADD CONSTRAINT [DF_RAddressCompany_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RAddressCompany] ADD CONSTRAINT [DF_RAddressCompany_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE NONCLUSTERED INDEX [_dta_index_RAddressCompany_38_1780201392__K4_K3_K12] ON [dbo].[RAddressCompany]([R2CompanyID], [R1AddressID], [IsDefault]) ON [PRIMARY]
GO
CREATE STATISTICS [_dta_stat_1780201392_12_3_4] ON [dbo].[RAddressCompany]([IsDefault], [R1AddressID], [R2CompanyID], [ID]) 

GO
CREATE STATISTICS [_dta_stat_1780201392_12_4] ON [dbo].[RAddressCompany]([IsDefault], [R2CompanyID], [ID]) 

GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1780201392] ON [dbo].[RAddressCompany]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RAddressCompany] ADD CONSTRAINT [PK__RAddressCompany__22E0CA6E] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RAddressCompany] WITH NOCHECK ADD CONSTRAINT [FK__RAddressCompany__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RAddressCompany] WITH NOCHECK ADD CONSTRAINT [FK__RAddressCompany__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RAddressCompany] WITH NOCHECK ADD CONSTRAINT [FK__RAddressCompany__R1AddressID] FOREIGN KEY ([R1AddressID]) REFERENCES [dbo].[OAddress] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RAddressCompany] WITH NOCHECK ADD CONSTRAINT [FK__RAddressCompany__R2CompanyID] FOREIGN KEY ([R2CompanyID]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RAddressCompany] WITH NOCHECK ADD CONSTRAINT [FK__RAddressCompany__TypeID] FOREIGN KEY ([TypeID]) REFERENCES [dbo].[LAddressType] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RAddressCompany] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RAddressCompanyPerson] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1AddressId]			[bigint]			 NOT NULL,
	[R2CompanyPersonId]		[bigint]			 NOT NULL,
	[TypeId]				[bigint]			 NOT NULL,
	[Description]			[varchar](1000)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[IsDefault]				[bit]				 NOT NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RAddressCompanyPerson] ADD CONSTRAINT [DF__RAddressCo__Guid__75EEF3BD] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RAddressCompanyPerson] ADD CONSTRAINT [DF__RAddressCompanyPerson__Comment__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RAddressCompanyPerson] ADD CONSTRAINT [DF_RAddressCompanyPerson_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RAddressCompanyPerson] ADD CONSTRAINT [DF__RAddressCompanyPerson__IsDefault__DefaultValue] DEFAULT (0)FOR [IsDefault]
GO
ALTER TABLE [dbo].[RAddressCompanyPerson] ADD CONSTRAINT [DF_RAddressCompanyPerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RAddressCompanyPerson] ADD CONSTRAINT [DF_RAddressCompanyPerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RAddressCompanyPerson] ADD CONSTRAINT [DF_RAddressCompanyPerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1924201905] ON [dbo].[RAddressCompanyPerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RAddressCompanyPerson] ADD CONSTRAINT [PK__RAddressCompanyP__74FACF84] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RAddressCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RAddressCompanyPerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RAddressCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RAddressCompanyPerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RAddressCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RAddressCompanyPerson__R1AddressId] FOREIGN KEY ([R1AddressId]) REFERENCES [dbo].[OAddress] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RCompanyPerson] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1CompanyID]		[bigint]			 NOT NULL,
	[R2PersonID]		[bigint]			 NOT NULL,
	[PositionID]		[bigint]			 NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[StatusID]			[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[IsDefault]			[bit]				 NOT NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCompanyPerson] ADD CONSTRAINT [DF__RCompanyP__GuidI__236ADA53] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RCompanyPerson] ADD CONSTRAINT [DF__RCompanyPerson__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RCompanyPerson] ADD CONSTRAINT [DF_RCompanyPerson_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RCompanyPerson] ADD CONSTRAINT [DF__RCompanyPerson__IsDefault__DefaultValue] DEFAULT (0)FOR [IsDefault]
GO
ALTER TABLE [dbo].[RCompanyPerson] ADD CONSTRAINT [DF_RCompanyPerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RCompanyPerson] ADD CONSTRAINT [DF_RCompanyPerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RCompanyPerson] ADD CONSTRAINT [DF_RCompanyPerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE NONCLUSTERED INDEX [_dta_index_RCompanyPerson_38_1508460698__K1_K3] ON [dbo].[RCompanyPerson]([ID], [R1CompanyID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_RCompanyPerson_38_1508460698__K1_K4] ON [dbo].[RCompanyPerson]([ID], [R2PersonID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1269579561] ON [dbo].[RCompanyPerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCompanyPerson] ADD CONSTRAINT [PK__RCompanyPerson__2276B61A] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK_RCompanyPerson_LOccupationStatus] FOREIGN KEY ([StatusID]) REFERENCES [dbo].[LOccupationStatus] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK_RCompanyPerson_OCompany] FOREIGN KEY ([R1CompanyID]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK_RCompanyPerson_OPerson] FOREIGN KEY ([R2PersonID]) REFERENCES [dbo].[OPerson] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK_RCompanyPerson_OUser] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK_RCompanyPerson_OUser1] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[TPersonPosition] (
	[ID]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NULL,
	[Path]					[varchar](39)		 COLLATE Polish_CI_AS NOT NULL,
	[Parent]				[varchar](36)		 COLLATE Polish_CI_AS NULL,
	[Name]					[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]			[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[AlternativeName]		[varchar](2000)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TPersonPosition] ADD CONSTRAINT [DF__TPersonPos__Guid__5C593EEC] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[TPersonPosition] ADD CONSTRAINT [DF__TPersonPosition__Path__DefaultValue] DEFAULT ('')FOR [Path]
GO
ALTER TABLE [dbo].[TPersonPosition] ADD CONSTRAINT [DF__TPersonPosition__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[TPersonPosition] ADD CONSTRAINT [DF__TPersonPosition__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[TPersonPosition] ADD CONSTRAINT [DF__TPersonPosition__AlternativeName__DefaultValue] DEFAULT ('')FOR [AlternativeName]
GO
ALTER TABLE [dbo].[TPersonPosition] ADD CONSTRAINT [DF_TPersonPosition_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[TPersonPosition] ADD CONSTRAINT [DF_TPersonPosition_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[TPersonPosition] ADD CONSTRAINT [DF_TPersonPosition_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[TPersonPosition] ADD CONSTRAINT [DF_TPersonPosition_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1730821228] ON [dbo].[TPersonPosition]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TPersonPosition] ADD CONSTRAINT [PK__TPersonPosition__5B651AB3] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[TPersonPosition] WITH NOCHECK ADD CONSTRAINT [FK__TPersonPosition__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[TPersonPosition] WITH NOCHECK ADD CONSTRAINT [FK__TPersonPosition__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK_RCompanyPerson_TPersonPosition] FOREIGN KEY ([PositionID]) REFERENCES [dbo].[TPersonPosition] ([ID]) NOT FOR REPLICATION
GO
GRANT INSERT ON [dbo].[RCompanyPerson] TO [RaportyWEB]
GO
GRANT SELECT ON [dbo].[RCompanyPerson] TO [RaportyWEB]
GO
ALTER TABLE [dbo].[RAddressCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RAddressCompanyPerson__R2CompanyPersonId] FOREIGN KEY ([R2CompanyPersonId]) REFERENCES [dbo].[RCompanyPerson] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RAddressCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RAddressCompanyPerson__TypeId] FOREIGN KEY ([TypeId]) REFERENCES [dbo].[LAddressType] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RAddressCompanyPerson] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RAddressPerson] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1AddressID]		[bigint]			 NOT NULL,
	[R2PersonID]		[bigint]			 NOT NULL,
	[TypeID]			[bigint]			 NOT NULL,
	[Description]		[varchar](1000)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[IsDefault]			[bit]				 NOT NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RAddressPerson] ADD CONSTRAINT [DF__RAddressP__GuidI__17E4190E] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RAddressPerson] ADD CONSTRAINT [DF__RAddressPerson__Comment__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RAddressPerson] ADD CONSTRAINT [DF_RAddressPerson_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RAddressPerson] ADD CONSTRAINT [DF__RAddressPerson__IsDefault__DefaultValue] DEFAULT (0)FOR [IsDefault]
GO
ALTER TABLE [dbo].[RAddressPerson] ADD CONSTRAINT [DF_RAddressPerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RAddressPerson] ADD CONSTRAINT [DF_RAddressPerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RAddressPerson] ADD CONSTRAINT [DF_RAddressPerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2068202418] ON [dbo].[RAddressPerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RAddressPerson] ADD CONSTRAINT [PK__RAddressPerson__16EFF4D5] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RAddressPerson] WITH NOCHECK ADD CONSTRAINT [FK__RAddressPerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RAddressPerson] WITH NOCHECK ADD CONSTRAINT [FK__RAddressPerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RAddressPerson] WITH NOCHECK ADD CONSTRAINT [FK__RAddressPerson__R1AddressID] FOREIGN KEY ([R1AddressID]) REFERENCES [dbo].[OAddress] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RAddressPerson] WITH NOCHECK ADD CONSTRAINT [FK__RAddressPerson__R2PersonID] FOREIGN KEY ([R2PersonID]) REFERENCES [dbo].[OPerson] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RAddressPerson] WITH NOCHECK ADD CONSTRAINT [FK__RAddressPerson__TypeID] FOREIGN KEY ([TypeID]) REFERENCES [dbo].[LAddressType] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RAddressResource] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1AddressId]		[bigint]			 NOT NULL,
	[R2ResourceId]		[bigint]			 NOT NULL,
	[Description]		[varchar](3000)		 COLLATE Polish_CI_AS NOT NULL,
	[TypeId]			[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[IsDefault]			[bit]				 NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RAddressResource] ADD CONSTRAINT [DF__RAddressRe__Guid__24E0837E] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RAddressResource] ADD CONSTRAINT [DF__RAddressResource__Comment__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RAddressResource] ADD CONSTRAINT [DF__RAddressResource__IsDefault__DefaultValue] DEFAULT (0)FOR [IsDefault]
GO
ALTER TABLE [dbo].[RAddressResource] ADD CONSTRAINT [DF_RAddressResource_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RAddressResource] ADD CONSTRAINT [DF_RAddressResource_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RAddressResource] ADD CONSTRAINT [DF_RAddressResource_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RAddressResource] ADD CONSTRAINT [DF_RAddressResource_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_886515183] ON [dbo].[RAddressResource]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RAddressResource] ADD CONSTRAINT [PK__RAddressResource__23EC5F45] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RAddressResource] WITH NOCHECK ADD CONSTRAINT [FK__RAddressResource__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RAddressResource] WITH NOCHECK ADD CONSTRAINT [FK__RAddressResource__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RAddressResource] WITH NOCHECK ADD CONSTRAINT [FK__RAddressResource__R1AddressId] FOREIGN KEY ([R1AddressId]) REFERENCES [dbo].[OAddress] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RAddressResource] WITH NOCHECK ADD CONSTRAINT [FK__RAddressResource__R2ResourceId] FOREIGN KEY ([R2ResourceId]) REFERENCES [dbo].[OResource] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RAddressResource] WITH NOCHECK ADD CONSTRAINT [FK__RAddressResource__TypeId] FOREIGN KEY ([TypeId]) REFERENCES [dbo].[LAddressResourceType] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RAddressShipmentAddress] (
	[ID]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[GUID]						[uniqueidentifier]	 NOT NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[R1AddressID]				[bigint]			 NOT NULL,
	[R2ShipmentAddressID]		[bigint]			 NOT NULL,
	[CreatedOn]					[datetime]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RAddressShipmentAddress] ADD CONSTRAINT [DF_RAddressShipmentAddress_GUID] DEFAULT (newid())FOR [GUID]
GO
ALTER TABLE [dbo].[RAddressShipmentAddress] ADD CONSTRAINT [DF_RAddressShipmentAddress_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RAddressShipmentAddress] ADD CONSTRAINT [DF_RAddressShipmentAddress_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RAddressShipmentAddress] ADD CONSTRAINT [DF_RAddressShipmentAddress_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RAddressShipmentAddress] ADD CONSTRAINT [DF_RAddressShipmentAddress_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_530933809] ON [dbo].[RAddressShipmentAddress]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RAddressShipmentAddress] ADD CONSTRAINT [PK_RAddressShipmentAddress] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RAddressShipmentAddress] WITH NOCHECK ADD CONSTRAINT [FK__RAddressShipmentAddress_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RAddressShipmentAddress] WITH NOCHECK ADD CONSTRAINT [FK__RAddressShipmentAddress_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RAddressShipmentAddress] WITH NOCHECK ADD CONSTRAINT [FK_RAddressShipmentAddress_OAddress] FOREIGN KEY ([R1AddressID]) REFERENCES [dbo].[OAddress] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RAddressShipmentAddress] WITH NOCHECK ADD CONSTRAINT [FK_RAddressShipmentAddress_OShipmentAddress] FOREIGN KEY ([R2ShipmentAddressID]) REFERENCES [dbo].[OShipmentAddress] ([ID]) NOT FOR REPLICATION
GO
GRANT DELETE ON [dbo].[RAddressShipmentAddress] TO [BDKProgramyZewnetrzne]
GO
GRANT INSERT ON [dbo].[RAddressShipmentAddress] TO [BDKProgramyZewnetrzne]
GO
GRANT SELECT ON [dbo].[RAddressShipmentAddress] TO [BDKProgramyZewnetrzne]
GO
GRANT UPDATE ON [dbo].[RAddressShipmentAddress] TO [BDKProgramyZewnetrzne]
GO
CREATE TABLE [dbo].[RArticleArticle] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1ArticleID]		[bigint]			 NOT NULL,
	[R2ArticleID]		[bigint]			 NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RArticleArticle] ADD CONSTRAINT [DF__RArticleA__GuidI__4461B9CA] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RArticleArticle] ADD CONSTRAINT [DF__RArticleArticle__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RArticleArticle] ADD CONSTRAINT [DF_RArticleArticle_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RArticleArticle] ADD CONSTRAINT [DF_RArticleArticle_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RArticleArticle] ADD CONSTRAINT [DF_RArticleArticle_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RArticleArticle] ADD CONSTRAINT [DF_RArticleArticle_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_64719283] ON [dbo].[RArticleArticle]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RArticleArticle] ADD CONSTRAINT [PK__RArticleArticle__436D9591] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RArticleArticle] WITH NOCHECK ADD CONSTRAINT [FK__RArticleArticle__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RArticleArticle] WITH NOCHECK ADD CONSTRAINT [FK__RArticleArticle__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RArticleArticle] WITH NOCHECK ADD CONSTRAINT [FK__RArticleArticle__R1ArticleID] FOREIGN KEY ([R1ArticleID]) REFERENCES [dbo].[OArticle] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RArticleArticle] WITH NOCHECK ADD CONSTRAINT [FK__RArticleArticle__R2ArticleID] FOREIGN KEY ([R2ArticleID]) REFERENCES [dbo].[OArticle] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RArticleCompany] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1ArticleId]		[bigint]			 NOT NULL,
	[R2CompanyId]		[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RArticleCompany] ADD CONSTRAINT [DF__RArticleCo__Guid__47F4B591] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RArticleCompany] ADD CONSTRAINT [DF_RArticleCompany_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RArticleCompany] ADD CONSTRAINT [DF_RArticleCompany_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RArticleCompany] ADD CONSTRAINT [DF_RArticleCompany_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RArticleCompany] ADD CONSTRAINT [DF_RArticleCompany_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1863937962] ON [dbo].[RArticleCompany]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RArticleCompany] ADD CONSTRAINT [PK__RArticleCompany__47009158] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RArticleCompany] WITH NOCHECK ADD CONSTRAINT [FK__RArticleCompany__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RArticleCompany] WITH NOCHECK ADD CONSTRAINT [FK__RArticleCompany__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RArticleCompany] WITH NOCHECK ADD CONSTRAINT [FK__RArticleCompany__R1ArticleId] FOREIGN KEY ([R1ArticleId]) REFERENCES [dbo].[OArticle] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RArticleCompany] WITH NOCHECK ADD CONSTRAINT [FK__RArticleCompany__R2CompanyId] FOREIGN KEY ([R2CompanyId]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RArticleCompanyPerson] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1ArticleId]			[bigint]			 NOT NULL,
	[R2CompanyPersonId]		[bigint]			 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RArticleCompanyPerson] ADD CONSTRAINT [DF__RArticleCo__Guid__4147B802] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RArticleCompanyPerson] ADD CONSTRAINT [DF_RArticleCompanyPerson_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RArticleCompanyPerson] ADD CONSTRAINT [DF_RArticleCompanyPerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RArticleCompanyPerson] ADD CONSTRAINT [DF_RArticleCompanyPerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RArticleCompanyPerson] ADD CONSTRAINT [DF_RArticleCompanyPerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_84455625] ON [dbo].[RArticleCompanyPerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RArticleCompanyPerson] ADD CONSTRAINT [PK__RArticleCompanyP__405393C9] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RArticleCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RArticleCompanyPerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RArticleCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RArticleCompanyPerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RArticleCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RArticleCompanyPerson__R1ArticleId] FOREIGN KEY ([R1ArticleId]) REFERENCES [dbo].[OArticle] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RArticleCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RArticleCompanyPerson__R2CompanyPersonId] FOREIGN KEY ([R2CompanyPersonId]) REFERENCES [dbo].[RCompanyPerson] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RArticleLink] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1ArticleID]		[bigint]			 NOT NULL,
	[R2LinkID]			[bigint]			 NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RArticleLink] ADD CONSTRAINT [DF__RArticleF__GuidI__7E044B7A] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RArticleLink] ADD CONSTRAINT [DF__RArticleFile__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RArticleLink] ADD CONSTRAINT [DF_RArticleLink_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RArticleLink] ADD CONSTRAINT [DF_RArticleLink_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RArticleLink] ADD CONSTRAINT [DF_RArticleLink_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RArticleLink] ADD CONSTRAINT [DF_RArticleLink_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_192719739] ON [dbo].[RArticleLink]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RArticleLink] ADD CONSTRAINT [PK__RArticleFile__7D102741] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RArticleLink] WITH NOCHECK ADD CONSTRAINT [FK__RArticleFile__R1ArticleID] FOREIGN KEY ([R1ArticleID]) REFERENCES [dbo].[OArticle] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RArticleLink] WITH NOCHECK ADD CONSTRAINT [FK__RArticleFile__R2FileID] FOREIGN KEY ([R2LinkID]) REFERENCES [dbo].[OLink] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RArticleLink] WITH NOCHECK ADD CONSTRAINT [FK__RArticleLink__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RArticleLink] WITH NOCHECK ADD CONSTRAINT [FK__RArticleLink__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RArticleLink] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RArticlePerson] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1ArticleID]		[bigint]			 NOT NULL,
	[R2PersonID]		[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RArticlePerson] ADD CONSTRAINT [DF__RArticleP__GuidI__4A1A9320] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RArticlePerson] ADD CONSTRAINT [DF_RArticlePerson_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RArticlePerson] ADD CONSTRAINT [DF_RArticlePerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RArticlePerson] ADD CONSTRAINT [DF_RArticlePerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RArticlePerson] ADD CONSTRAINT [DF_RArticlePerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_320720195] ON [dbo].[RArticlePerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RArticlePerson] ADD CONSTRAINT [PK__RArticlePerson__49266EE7] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RArticlePerson] WITH NOCHECK ADD CONSTRAINT [FK__RArticlePerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RArticlePerson] WITH NOCHECK ADD CONSTRAINT [FK__RArticlePerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RArticlePerson] WITH NOCHECK ADD CONSTRAINT [FK__RArticlePerson__R1ArticleID] FOREIGN KEY ([R1ArticleID]) REFERENCES [dbo].[OArticle] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RArticlePerson] WITH NOCHECK ADD CONSTRAINT [FK__RArticlePerson__R2PersonID] FOREIGN KEY ([R2PersonID]) REFERENCES [dbo].[OPerson] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RArticleProduct] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1ArticleID]		[bigint]			 NOT NULL,
	[R2ProductID]		[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RArticleProduct] ADD CONSTRAINT [DF__RArticlePr__Guid__353F71CB] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RArticleProduct] ADD CONSTRAINT [DF_RArticleProduct_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RArticleProduct] ADD CONSTRAINT [DF_RArticleProduct_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RArticleProduct] ADD CONSTRAINT [DF_RArticleProduct_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RArticleProduct] ADD CONSTRAINT [DF_RArticleProduct_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_432720594] ON [dbo].[RArticleProduct]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RArticleProduct] ADD CONSTRAINT [PK__RArticleProduct__344B4D92] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RArticleProduct] WITH NOCHECK ADD CONSTRAINT [FK__RArticleProduct__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RArticleProduct] WITH NOCHECK ADD CONSTRAINT [FK__RArticleProduct__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RArticleProduct] WITH NOCHECK ADD CONSTRAINT [FK__RArticleProduct__R1ArticleID] FOREIGN KEY ([R1ArticleID]) REFERENCES [dbo].[OArticle] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RArticleProduct] WITH NOCHECK ADD CONSTRAINT [FK__RArticleProduct__R2ProductID] FOREIGN KEY ([R2ProductID]) REFERENCES [dbo].[OProduct] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RArticleProduct] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RArticleProductHierarchy] (
	[ID]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NOT NULL,
	[R1ArticleID]				[bigint]			 NOT NULL,
	[R2ProductHierarchyID]		[bigint]			 NOT NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[CreatedOn]					[datetime]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RArticleProductHierarchy] ADD CONSTRAINT [DF__RArticlePr__Guid__3A0426E8] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RArticleProductHierarchy] ADD CONSTRAINT [DF_RArticleProductHierarchy_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RArticleProductHierarchy] ADD CONSTRAINT [DF_RArticleProductHierarchy_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RArticleProductHierarchy] ADD CONSTRAINT [DF_RArticleProductHierarchy_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RArticleProductHierarchy] ADD CONSTRAINT [DF_RArticleProductHierarchy_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_544720993] ON [dbo].[RArticleProductHierarchy]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RArticleProductHierarchy] ADD CONSTRAINT [PK__RArticleProductH__391002AF] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RArticleProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__RArticleProductHierarchy__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RArticleProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__RArticleProductHierarchy__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RArticleProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__RArticleProductHierarchy__R1ArticleID] FOREIGN KEY ([R1ArticleID]) REFERENCES [dbo].[OArticle] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RArticleProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__RArticleProductHierarchy__R2ProductHierarchyID] FOREIGN KEY ([R2ProductHierarchyID]) REFERENCES [dbo].[TProductHierarchy] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RArticleProductHierarchy] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RCommunicationCompany] (
	[ID]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[GUID]					[uniqueidentifier]	 NULL,
	[R1CommunicationID]		[bigint]			 NOT NULL,
	[R2CompanyID]			[bigint]			 NOT NULL,
	[Description]			[varchar](1000)		 COLLATE Polish_CI_AS NULL,
	[IsDefault]				[bit]				 NOT NULL,
	[CreatedOn]				[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCommunicationCompany] ADD CONSTRAINT [DF__RCommunica__GUID__24A3202B] DEFAULT (newid())FOR [GUID]
GO
ALTER TABLE [dbo].[RCommunicationCompany] ADD CONSTRAINT [DF__RCommunic__IsDef__25974464] DEFAULT (0)FOR [IsDefault]
GO
ALTER TABLE [dbo].[RCommunicationCompany] ADD CONSTRAINT [DF__RCommunic__REPLI__268B689D] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RCommunicationCompany] ADD CONSTRAINT [DF_RCommunicationCompany_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RCommunicationCompany] ADD CONSTRAINT [DF_RCommunicationCompany_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RCommunicationCompany] ADD CONSTRAINT [DF_RCommunicationCompany_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_582670265] ON [dbo].[RCommunicationCompany]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCommunicationCompany] ADD CONSTRAINT [PK__RCommunicationCo__23AEFBF2] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RCommunicationCompany] WITH NOCHECK ADD CONSTRAINT [FK_RCommunicationCompany_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCommunicationCompany] WITH NOCHECK ADD CONSTRAINT [FK_RCommunicationCompany_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCommunicationCompany] WITH NOCHECK ADD CONSTRAINT [FK_RCommunicationCompany_R1CommunicationID] FOREIGN KEY ([R1CommunicationID]) REFERENCES [dbo].[OCommunication] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCommunicationCompany] WITH NOCHECK ADD CONSTRAINT [FK_RCommunicationCompany_R2CompanyID] FOREIGN KEY ([R2CompanyID]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RCommunicationCompanyPerson] (
	[ID]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[GUID]					[uniqueidentifier]	 NULL,
	[R1CommunicationID]		[bigint]			 NOT NULL,
	[R2CompanyPersonID]		[bigint]			 NOT NULL,
	[Description]			[varchar](1000)		 COLLATE Polish_CI_AS NULL,
	[IsDefault]				[bit]				 NOT NULL,
	[CreatedOn]				[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCommunicationCompanyPerson] ADD CONSTRAINT [DF__RCommunica__GUID__1C0DDA2A] DEFAULT (newid())FOR [GUID]
GO
ALTER TABLE [dbo].[RCommunicationCompanyPerson] ADD CONSTRAINT [DF__RCommunic__IsDef__1D01FE63] DEFAULT (0)FOR [IsDefault]
GO
ALTER TABLE [dbo].[RCommunicationCompanyPerson] ADD CONSTRAINT [DF__RCommunic__REPLI__1DF6229C] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RCommunicationCompanyPerson] ADD CONSTRAINT [DF_RCommunicationCompanyPerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RCommunicationCompanyPerson] ADD CONSTRAINT [DF_RCommunicationCompanyPerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RCommunicationCompanyPerson] ADD CONSTRAINT [DF_RCommunicationCompanyPerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_438669752] ON [dbo].[RCommunicationCompanyPerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCommunicationCompanyPerson] ADD CONSTRAINT [PK__RCommunicationCo__1B19B5F1] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RCommunicationCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK_RCommunicationCompanyPerson_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCommunicationCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK_RCommunicationCompanyPerson_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCommunicationCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK_RCommunicationCompanyPerson_R1CommunicationID] FOREIGN KEY ([R1CommunicationID]) REFERENCES [dbo].[OCommunication] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCommunicationCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK_RCommunicationCompanyPerson_R2CompanyPersonID] FOREIGN KEY ([R2CompanyPersonID]) REFERENCES [dbo].[RCompanyPerson] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RCommunicationPerson] (
	[ID]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[GUID]					[uniqueidentifier]	 NULL,
	[R1CommunicationID]		[bigint]			 NOT NULL,
	[R2PersonID]			[bigint]			 NOT NULL,
	[Description]			[varchar](1000)		 COLLATE Polish_CI_AS NULL,
	[IsDefault]				[bit]				 NOT NULL,
	[CreatedOn]				[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCommunicationPerson] ADD CONSTRAINT [DF__RCommunica__GUID__13789429] DEFAULT (newid())FOR [GUID]
GO
ALTER TABLE [dbo].[RCommunicationPerson] ADD CONSTRAINT [DF__RCommunic__IsDef__146CB862] DEFAULT (0)FOR [IsDefault]
GO
ALTER TABLE [dbo].[RCommunicationPerson] ADD CONSTRAINT [DF__RCommunic__REPLI__1560DC9B] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RCommunicationPerson] ADD CONSTRAINT [DF_RCommunicationPerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RCommunicationPerson] ADD CONSTRAINT [DF_RCommunicationPerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RCommunicationPerson] ADD CONSTRAINT [DF_RCommunicationPerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_294669239] ON [dbo].[RCommunicationPerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCommunicationPerson] ADD CONSTRAINT [PK__RCommunicationPe__12846FF0] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RCommunicationPerson] WITH NOCHECK ADD CONSTRAINT [FK_RCommunicationPerson_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCommunicationPerson] WITH NOCHECK ADD CONSTRAINT [FK_RCommunicationPerson_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCommunicationPerson] WITH NOCHECK ADD CONSTRAINT [FK_RCommunicationPerson_R1CommunicationID] FOREIGN KEY ([R1CommunicationID]) REFERENCES [dbo].[OCommunication] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCommunicationPerson] WITH NOCHECK ADD CONSTRAINT [FK_RCommunicationPerson_R2PersonID] FOREIGN KEY ([R2PersonID]) REFERENCES [dbo].[OPerson] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RCompanyBusinessActivity] (
	[Id]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NOT NULL,
	[R1CompanyId]				[bigint]			 NOT NULL,
	[R2BusinessActivityId]		[bigint]			 NOT NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[CreatedOn]					[datetime]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCompanyBusinessActivity] ADD CONSTRAINT [DF__RCompanyBu__Guid__10A2E9F9] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RCompanyBusinessActivity] ADD CONSTRAINT [DF_RCompanyBusinessActivity_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RCompanyBusinessActivity] ADD CONSTRAINT [DF_RCompanyBusinessActivity_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RCompanyBusinessActivity] ADD CONSTRAINT [DF_RCompanyBusinessActivity_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RCompanyBusinessActivity] ADD CONSTRAINT [DF_RCompanyBusinessActivity_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_768721791] ON [dbo].[RCompanyBusinessActivity]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCompanyBusinessActivity] ADD CONSTRAINT [PK__RCompanyBusiness__0FAEC5C0] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RCompanyBusinessActivity] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyBusinessActivity__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyBusinessActivity] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyBusinessActivity__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyBusinessActivity] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyBusinessActivity__R1CompanyId] FOREIGN KEY ([R1CompanyId]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[TBusinessActivity] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[Path]				[varchar](109)		 COLLATE Polish_CI_AS NOT NULL,
	[Parent]			[varchar](36)		 COLLATE Polish_CI_AS NULL,
	[Code]				[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[Name]				[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[Description]		[varchar](2000)		 COLLATE Polish_CI_AS NOT NULL,
	[Keywords]			[varchar](3000)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBusinessActivity] ADD CONSTRAINT [DF__TBusinessA__Guid__0901C831] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[TBusinessActivity] ADD CONSTRAINT [DF__TBusinessActivity__Path__DefaultValue] DEFAULT ('')FOR [Path]
GO
ALTER TABLE [dbo].[TBusinessActivity] ADD CONSTRAINT [DF__TBusinessActivity__Code__DefaultValue] DEFAULT ('')FOR [Code]
GO
ALTER TABLE [dbo].[TBusinessActivity] ADD CONSTRAINT [DF__TBusinessActivity__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[TBusinessActivity] ADD CONSTRAINT [DF__TBusinessActivity__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[TBusinessActivity] ADD CONSTRAINT [DF__TBusinessActivity__Keywords__DefaultValue] DEFAULT ('')FOR [Keywords]
GO
ALTER TABLE [dbo].[TBusinessActivity] ADD CONSTRAINT [DF_TBusinessActivity_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[TBusinessActivity] ADD CONSTRAINT [DF_TBusinessActivity_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[TBusinessActivity] ADD CONSTRAINT [DF_TBusinessActivity_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[TBusinessActivity] ADD CONSTRAINT [DF_TBusinessActivity_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_864722133] ON [dbo].[TBusinessActivity]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBusinessActivity] ADD CONSTRAINT [PK__TBusinessActivit__080DA3F8] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[TBusinessActivity] WITH NOCHECK ADD CONSTRAINT [FK__TBusinessActivity__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[TBusinessActivity] WITH NOCHECK ADD CONSTRAINT [FK__TBusinessActivity__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[TBusinessActivity] TO [RaportyWEB]
GO
ALTER TABLE [dbo].[RCompanyBusinessActivity] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyBusinessActivity__R2BusinessActivityId] FOREIGN KEY ([R2BusinessActivityId]) REFERENCES [dbo].[TBusinessActivity] ([Id]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RCompanyBusinessActivity] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RCompanyCompany] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1CompanyId]		[bigint]			 NOT NULL,
	[R2CompanyId]		[bigint]			 NOT NULL,
	[TypeId]			[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCompanyCompany] ADD CONSTRAINT [DF__RCompanyCo__Guid__6A7D4111] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RCompanyCompany] ADD CONSTRAINT [DF_RCompanyCompany_TypeId] DEFAULT (1)FOR [TypeId]
GO
ALTER TABLE [dbo].[RCompanyCompany] ADD CONSTRAINT [DF_RCompanyCompany_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RCompanyCompany] ADD CONSTRAINT [DF_RCompanyCompany_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RCompanyCompany] ADD CONSTRAINT [DF_RCompanyCompany_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RCompanyCompany] ADD CONSTRAINT [DF_RCompanyCompany_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1040722760] ON [dbo].[RCompanyCompany]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCompanyCompany] ADD CONSTRAINT [PK__RCompanyCompany__69891CD8] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RCompanyCompany] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyCompany__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyCompany] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyCompany__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyCompany] WITH NOCHECK ADD CONSTRAINT [FK_RCompanyCompany_OCompany_R1] FOREIGN KEY ([R1CompanyId]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyCompany] WITH NOCHECK ADD CONSTRAINT [FK_RCompanyCompany_OCompany_R2] FOREIGN KEY ([R2CompanyId]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RCompanyFolder] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1CompanyId]		[bigint]			 NOT NULL,
	[R2CompanyId]		[bigint]			 NOT NULL,
	[Path]				[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[CreatedOn]			[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCompanyFolder] ADD CONSTRAINT [DF__RCompanyFo__Guid__6A69C926] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RCompanyFolder] ADD CONSTRAINT [DF__RCompanyFolder__Path__DefaultValue] DEFAULT ('')FOR [Path]
GO
ALTER TABLE [dbo].[RCompanyFolder] ADD CONSTRAINT [DF_RCompanyFolder_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RCompanyFolder] ADD CONSTRAINT [DF_RCompanyFolder_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RCompanyFolder] ADD CONSTRAINT [DF_RCompanyFolder_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RCompanyFolder] ADD CONSTRAINT [DF_RCompanyFolder_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2119938874] ON [dbo].[RCompanyFolder]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCompanyFolder] ADD CONSTRAINT [PK__RCompanyFolder__6975A4ED] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RCompanyFolder] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyFolder__R1CompanyId] FOREIGN KEY ([R1CompanyId]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyFolder] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyFolder__R2CompanyId] FOREIGN KEY ([R2CompanyId]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyFolder] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyFolder_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyFolder] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyFolder_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RCompanyGraphic] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1CompanyID]		[bigint]			 NOT NULL,
	[R2GraphicID]		[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCompanyGraphic] ADD CONSTRAINT [DF__RCompanyGr__Guid__40B12477] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RCompanyGraphic] ADD CONSTRAINT [DF_RCompanyGraphic_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RCompanyGraphic] ADD CONSTRAINT [DF_RCompanyGraphic_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RCompanyGraphic] ADD CONSTRAINT [DF_RCompanyGraphic_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RCompanyGraphic] ADD CONSTRAINT [DF_RCompanyGraphic_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1136723102] ON [dbo].[RCompanyGraphic]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCompanyGraphic] ADD CONSTRAINT [PK__RCompanyGraphic__3FBD003E] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RCompanyGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyGraphic__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyGraphic__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyGraphic__R1CompanyID] FOREIGN KEY ([R1CompanyID]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyGraphic__R2GraphicID] FOREIGN KEY ([R2GraphicID]) REFERENCES [dbo].[OGraphic] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RCompanyLink] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1CompanyId]		[bigint]			 NOT NULL,
	[R2LinkId]			[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCompanyLink] ADD CONSTRAINT [DF__RCompanyLi__Guid__4C42D2B4] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RCompanyLink] ADD CONSTRAINT [DF_RCompanyLink_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RCompanyLink] ADD CONSTRAINT [DF_RCompanyLink_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RCompanyLink] ADD CONSTRAINT [DF_RCompanyLink_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RCompanyLink] ADD CONSTRAINT [DF_RCompanyLink_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE NONCLUSTERED INDEX [_dta_index_RCompanyLink_38_1248723501__K3_K4] ON [dbo].[RCompanyLink]([R1CompanyId], [R2LinkId]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1248723501] ON [dbo].[RCompanyLink]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCompanyLink] ADD CONSTRAINT [PK__RCompanyLink__4B4EAE7B] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RCompanyLink] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyLink__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyLink] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyLink__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyLink] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyLink__R1CompanyId] FOREIGN KEY ([R1CompanyId]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyLink] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyLink__R2LinkId] FOREIGN KEY ([R2LinkId]) REFERENCES [dbo].[OLink] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RCompanyLink] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RCompanyPersonSale] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1CompanyPersonId]		[bigint]			 NOT NULL,
	[R2SaleId]				[bigint]			 NOT NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCompanyPersonSale] ADD CONSTRAINT [DF__RCompanyPe__Guid__42C4830D] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RCompanyPersonSale] ADD CONSTRAINT [DF__RCompanyP__REPLI__4789382A] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RCompanyPersonSale] ADD CONSTRAINT [DF_RCompanyPersonSale_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RCompanyPersonSale] ADD CONSTRAINT [DF_RCompanyPersonSale_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RCompanyPersonSale] ADD CONSTRAINT [DF_RCompanyPersonSale_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1088174747] ON [dbo].[RCompanyPersonSale]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCompanyPersonSale] ADD CONSTRAINT [PK__RCompanyPersonSa__41D05ED4] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RCompanyPersonSale] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyPersonSale__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyPersonSale] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyPersonSale__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyPersonSale] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyPersonSale__R1CompanyPersonId] FOREIGN KEY ([R1CompanyPersonId]) REFERENCES [dbo].[RCompanyPerson] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyPersonSale] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyPersonSale__R2SaleId] FOREIGN KEY ([R2SaleId]) REFERENCES [dbo].[OSale] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RCompanyRootFolder] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1CompanyId]		[bigint]			 NOT NULL,
	[R2FolderId]		[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[TypeId]			[bigint]			 NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCompanyRootFolder] ADD CONSTRAINT [DF__RCompanyRo__Guid__63BCCB97] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RCompanyRootFolder] ADD CONSTRAINT [DF_RCompanyRootFolder_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RCompanyRootFolder] ADD CONSTRAINT [DF_RCompanyRootFolder_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RCompanyRootFolder] ADD CONSTRAINT [DF_RCompanyRootFolder_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RCompanyRootFolder] ADD CONSTRAINT [DF_RCompanyRootFolder_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1991938418] ON [dbo].[RCompanyRootFolder]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCompanyRootFolder] ADD CONSTRAINT [PK__RCompanyRootFold__62C8A75E] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RCompanyRootFolder] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyRootFolder__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyRootFolder] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyRootFolder__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyRootFolder] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyRootFolder__R1CompanyId] FOREIGN KEY ([R1CompanyId]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyRootFolder] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyRootFolder__R2FolderId] FOREIGN KEY ([R2FolderId]) REFERENCES [dbo].[LFolder] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyRootFolder] WITH NOCHECK ADD CONSTRAINT [FK_RCompanyRootFolder_LFolderType] FOREIGN KEY ([TypeId]) REFERENCES [dbo].[LFolderType] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RCompanySale] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1CompanyId]		[bigint]			 NOT NULL,
	[R2SaleId]			[bigint]			 NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCompanySale] ADD CONSTRAINT [DF__RCompanySa__Guid__4A65A4D5] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RCompanySale] ADD CONSTRAINT [DF__RCompanyS__REPLI__4F2A59F2] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RCompanySale] ADD CONSTRAINT [DF_RCompanySale_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RCompanySale] ADD CONSTRAINT [DF_RCompanySale_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RCompanySale] ADD CONSTRAINT [DF_RCompanySale_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1216175203] ON [dbo].[RCompanySale]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCompanySale] ADD CONSTRAINT [PK__RCompanySale__4971809C] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RCompanySale] WITH NOCHECK ADD CONSTRAINT [FK__RCompanySale__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanySale] WITH NOCHECK ADD CONSTRAINT [FK__RCompanySale__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanySale] WITH NOCHECK ADD CONSTRAINT [FK__RCompanySale__R1CompanyId] FOREIGN KEY ([R1CompanyId]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanySale] WITH NOCHECK ADD CONSTRAINT [FK__RCompanySale__R2SaleId] FOREIGN KEY ([R2SaleId]) REFERENCES [dbo].[OSale] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RCompanyShipmentAddress] (
	[ID]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[GUID]						[uniqueidentifier]	 NOT NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[R1CompanyID]				[bigint]			 NOT NULL,
	[R2ShipmentAddressID]		[bigint]			 NOT NULL,
	[CreatedOn]					[datetime]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCompanyShipmentAddress] ADD CONSTRAINT [DF_RCompanyShipmentAddress_GUID] DEFAULT (newid())FOR [GUID]
GO
ALTER TABLE [dbo].[RCompanyShipmentAddress] ADD CONSTRAINT [DF_RCompanyShipmentAddress_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RCompanyShipmentAddress] ADD CONSTRAINT [DF_RCompanyShipmentAddress_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RCompanyShipmentAddress] ADD CONSTRAINT [DF_RCompanyShipmentAddress_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RCompanyShipmentAddress] ADD CONSTRAINT [DF_RCompanyShipmentAddress_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_610934094] ON [dbo].[RCompanyShipmentAddress]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCompanyShipmentAddress] ADD CONSTRAINT [PK_RCompanyShipmentAddress] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RCompanyShipmentAddress] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyShipmentAddress_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyShipmentAddress] WITH NOCHECK ADD CONSTRAINT [FK__RCompanyShipmentAddress_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyShipmentAddress] WITH NOCHECK ADD CONSTRAINT [FK_RCompanyShipmentAddress_OCompany1] FOREIGN KEY ([R1CompanyID]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCompanyShipmentAddress] WITH NOCHECK ADD CONSTRAINT [FK_RCompanyShipmentAddress_OShipmentAddress] FOREIGN KEY ([R2ShipmentAddressID]) REFERENCES [dbo].[OShipmentAddress] ([ID]) NOT FOR REPLICATION
GO
GRANT DELETE ON [dbo].[RCompanyShipmentAddress] TO [BDKProgramyZewnetrzne]
GO
GRANT INSERT ON [dbo].[RCompanyShipmentAddress] TO [BDKProgramyZewnetrzne]
GO
GRANT SELECT ON [dbo].[RCompanyShipmentAddress] TO [BDKProgramyZewnetrzne]
GO
GRANT UPDATE ON [dbo].[RCompanyShipmentAddress] TO [BDKProgramyZewnetrzne]
GO
CREATE TABLE [dbo].[RCountryLanguage] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1CountryId]		[bigint]			 NOT NULL,
	[R2LanguageId]		[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCountryLanguage] ADD CONSTRAINT [DF__RCountryLa__Guid__7391A9FF] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RCountryLanguage] ADD CONSTRAINT [DF_RCountryLanguage_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RCountryLanguage] ADD CONSTRAINT [DF_RCountryLanguage_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RCountryLanguage] ADD CONSTRAINT [DF_RCountryLanguage_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RCountryLanguage] ADD CONSTRAINT [DF_RCountryLanguage_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1616724812] ON [dbo].[RCountryLanguage]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RCountryLanguage] ADD CONSTRAINT [PK__RCountryLanguage__729D85C6] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RCountryLanguage] WITH NOCHECK ADD CONSTRAINT [FK__RCountryLanguage__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCountryLanguage] WITH NOCHECK ADD CONSTRAINT [FK__RCountryLanguage__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCountryLanguage] WITH NOCHECK ADD CONSTRAINT [FK__RCountryLanguage__R1CountryId] FOREIGN KEY ([R1CountryId]) REFERENCES [dbo].[LCountry] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RCountryLanguage] WITH NOCHECK ADD CONSTRAINT [FK__RCountryLanguage__R2LanguageId] FOREIGN KEY ([R2LanguageId]) REFERENCES [dbo].[LLanguage] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[REmailCompany] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1EmailID]			[bigint]			 NOT NULL,
	[R2CompanyID]		[bigint]			 NOT NULL,
	[TypeId]			[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[IsDefault]			[bit]				 NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REmailCompany] ADD CONSTRAINT [DF__REmailCom__GuidI__3D94C0AA] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[REmailCompany] ADD CONSTRAINT [DF_REmailCompany_TypeId] DEFAULT (1)FOR [TypeId]
GO
ALTER TABLE [dbo].[REmailCompany] ADD CONSTRAINT [DF_REmailCompany_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[REmailCompany] ADD CONSTRAINT [DF__REmailCompany__IsDefault__DefaultValue] DEFAULT (0)FOR [IsDefault]
GO
ALTER TABLE [dbo].[REmailCompany] ADD CONSTRAINT [DF__REmailCompany__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[REmailCompany] ADD CONSTRAINT [DF_REmailCompany_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[REmailCompany] ADD CONSTRAINT [DF_REmailCompany_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[REmailCompany] ADD CONSTRAINT [DF_REmailCompany_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE NONCLUSTERED INDEX [_dta_index_REmailCompany_38_1728725211__K4_K3] ON [dbo].[REmailCompany]([R2CompanyID], [R1EmailID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1728725211] ON [dbo].[REmailCompany]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REmailCompany] ADD CONSTRAINT [PK__REmailCompany__3CA09C71] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[REmailCompany] WITH NOCHECK ADD CONSTRAINT [FK__REmailCompany__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REmailCompany] WITH NOCHECK ADD CONSTRAINT [FK__REmailCompany__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REmailCompany] WITH NOCHECK ADD CONSTRAINT [FK__REmailCompany__R1EmailID] FOREIGN KEY ([R1EmailID]) REFERENCES [dbo].[OEmail] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REmailCompany] WITH NOCHECK ADD CONSTRAINT [FK__REmailCompany__R2CompanyID] FOREIGN KEY ([R2CompanyID]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REmailCompany] WITH NOCHECK ADD CONSTRAINT [FK__REmailCompany__TypeId] FOREIGN KEY ([TypeId]) REFERENCES [dbo].[LEmailType] ([Id]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[REmailCompany] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[REmailCompanyPerson] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1EmailId]				[bigint]			 NOT NULL,
	[R2CompanyPersonId]		[bigint]			 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[TypeId]				[bigint]			 NOT NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[IsDefault]				[bit]				 NOT NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REmailCompanyPerson] ADD CONSTRAINT [DF__REmailComp__Guid__2930374F] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[REmailCompanyPerson] ADD CONSTRAINT [DF_REmailCompanyPerson_TypeId] DEFAULT (1)FOR [TypeId]
GO
ALTER TABLE [dbo].[REmailCompanyPerson] ADD CONSTRAINT [DF_REmailCompanyPerson_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[REmailCompanyPerson] ADD CONSTRAINT [DF__REmailCompanyPerson__IsDefault__DefaultValue] DEFAULT (0)FOR [IsDefault]
GO
ALTER TABLE [dbo].[REmailCompanyPerson] ADD CONSTRAINT [DF__REmailCompanyPerson__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[REmailCompanyPerson] ADD CONSTRAINT [DF_REmailCompanyPerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[REmailCompanyPerson] ADD CONSTRAINT [DF_REmailCompanyPerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[REmailCompanyPerson] ADD CONSTRAINT [DF_REmailCompanyPerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1872725724] ON [dbo].[REmailCompanyPerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REmailCompanyPerson] ADD CONSTRAINT [PK__REmailCompanyPer__283C1316] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[REmailCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__REmailCompanyPerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REmailCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__REmailCompanyPerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REmailCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__REmailCompanyPerson__R1EmailId] FOREIGN KEY ([R1EmailId]) REFERENCES [dbo].[OEmail] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REmailCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__REmailCompanyPerson__R2CompanyPersonId] FOREIGN KEY ([R2CompanyPersonId]) REFERENCES [dbo].[RCompanyPerson] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REmailCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__REmailCompanyPerson__TypeId] FOREIGN KEY ([TypeId]) REFERENCES [dbo].[LEmailType] ([Id]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[REmailCompanyPerson] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[REmailPerson] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1EmailID]			[bigint]			 NOT NULL,
	[R2PersonID]		[bigint]			 NOT NULL,
	[TypeId]			[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[IsDefault]			[bit]				 NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REmailPerson] ADD CONSTRAINT [DF__REmailPer__GuidI__38D00B8D] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[REmailPerson] ADD CONSTRAINT [DF_REmailPerson_TypeId] DEFAULT (1)FOR [TypeId]
GO
ALTER TABLE [dbo].[REmailPerson] ADD CONSTRAINT [DF_REmailPerson_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[REmailPerson] ADD CONSTRAINT [DF__REmailPerson__IsDefault__DefaultValue] DEFAULT (0)FOR [IsDefault]
GO
ALTER TABLE [dbo].[REmailPerson] ADD CONSTRAINT [DF__REmailPerson__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[REmailPerson] ADD CONSTRAINT [DF_REmailPerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[REmailPerson] ADD CONSTRAINT [DF_REmailPerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[REmailPerson] ADD CONSTRAINT [DF_REmailPerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE NONCLUSTERED INDEX [_dta_index_REmailPerson_38_2016726237__K4_K3] ON [dbo].[REmailPerson]([R2PersonID], [R1EmailID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2016726237] ON [dbo].[REmailPerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REmailPerson] ADD CONSTRAINT [PK__REmailPerson__37DBE754] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[REmailPerson] WITH NOCHECK ADD CONSTRAINT [FK__REmailPerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REmailPerson] WITH NOCHECK ADD CONSTRAINT [FK__REmailPerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REmailPerson] WITH NOCHECK ADD CONSTRAINT [FK__REmailPerson__R1EmailID] FOREIGN KEY ([R1EmailID]) REFERENCES [dbo].[OEmail] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REmailPerson] WITH NOCHECK ADD CONSTRAINT [FK__REmailPerson__R2PersonID] FOREIGN KEY ([R2PersonID]) REFERENCES [dbo].[OPerson] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REmailPerson] WITH NOCHECK ADD CONSTRAINT [FK__REmailPerson__TypeId] FOREIGN KEY ([TypeId]) REFERENCES [dbo].[LEmailType] ([Id]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[REmailPerson] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[REventArticle] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1EventId]			[bigint]			 NOT NULL,
	[R2ArticleId]		[bigint]			 NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventArticle] ADD CONSTRAINT [DF_REventArticle_Guid] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[REventArticle] ADD CONSTRAINT [DF_REventArticle_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[REventArticle] ADD CONSTRAINT [DF_REventArticle_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[REventArticle] ADD CONSTRAINT [DF_REventArticle_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[REventArticle] ADD CONSTRAINT [DF_REventArticle_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_401826381] ON [dbo].[REventArticle]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventArticle] ADD CONSTRAINT [PK_REventArticle] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[REventArticle] WITH NOCHECK ADD CONSTRAINT [FK_REventArticle_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventArticle] WITH NOCHECK ADD CONSTRAINT [FK_REventArticle_ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventArticle] WITH NOCHECK ADD CONSTRAINT [FK_REventArticle_R2ArticleId] FOREIGN KEY ([R2ArticleId]) REFERENCES [dbo].[OArticle] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[REventCategoryCompany] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1EventCategoryId]		[bigint]			 NOT NULL,
	[R2CompanyId]			[bigint]			 NOT NULL,
	[RoleId]				[bigint]			 NULL,
	[StageId]				[bigint]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventCategoryCompany] ADD CONSTRAINT [DF__REventCate__Guid__4D6FF59B] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[REventCategoryCompany] ADD CONSTRAINT [DF__REventCat__REPLI__541CF32A] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[REventCategoryCompany] ADD CONSTRAINT [DF_REventCategoryCompany_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[REventCategoryCompany] ADD CONSTRAINT [DF_REventCategoryCompany_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[REventCategoryCompany] ADD CONSTRAINT [DF_REventCategoryCompany_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1267182889] ON [dbo].[REventCategoryCompany]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventCategoryCompany] ADD CONSTRAINT [PK__REventCategoryCo__4C7BD162] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[REventCategoryCompany] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryCompany__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryCompany] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryCompany__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryCompany] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryCompany__R1EventCategoryId] FOREIGN KEY ([R1EventCategoryId]) REFERENCES [dbo].[TEventCategory] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryCompany] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryCompany__R2CompanyId] FOREIGN KEY ([R2CompanyId]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryCompany] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryCompany__RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[LEventRole] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryCompany] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryCompany__StageId] FOREIGN KEY ([StageId]) REFERENCES [dbo].[LEventStage] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[REventCategoryCompanyPerson] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1EventCategoryId]		[bigint]			 NOT NULL,
	[R2CompanyPersonId]		[bigint]			 NOT NULL,
	[RoleId]				[bigint]			 NULL,
	[StageId]				[bigint]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventCategoryCompanyPerson] ADD CONSTRAINT [DF__REventCate__Guid__56F95FD5] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[REventCategoryCompanyPerson] ADD CONSTRAINT [DF__REventCat__REPLI__5DA65D64] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[REventCategoryCompanyPerson] ADD CONSTRAINT [DF_REventCategoryCompanyPerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[REventCategoryCompanyPerson] ADD CONSTRAINT [DF_REventCategoryCompanyPerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[REventCategoryCompanyPerson] ADD CONSTRAINT [DF_REventCategoryCompanyPerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1427183459] ON [dbo].[REventCategoryCompanyPerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventCategoryCompanyPerson] ADD CONSTRAINT [PK__REventCategoryCo__56053B9C] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[REventCategoryCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryCompanyPerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryCompanyPerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryCompanyPerson__R1EventCategoryId] FOREIGN KEY ([R1EventCategoryId]) REFERENCES [dbo].[TEventCategory] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryCompanyPerson__R2CompanyPersonId] FOREIGN KEY ([R2CompanyPersonId]) REFERENCES [dbo].[RCompanyPerson] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryCompanyPerson__RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[LEventRole] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryCompanyPerson__StageId] FOREIGN KEY ([StageId]) REFERENCES [dbo].[LEventStage] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[REventCategoryEventStage] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1EventCategoryId]		[bigint]			 NOT NULL,
	[R2EventStageId]		[bigint]			 NOT NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventCategoryEventStage] ADD CONSTRAINT [DF__REventCate__Guid__6ED5AD70] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[REventCategoryEventStage] ADD CONSTRAINT [DF__REventCat__REPLI__739A628D] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[REventCategoryEventStage] ADD CONSTRAINT [DF_REventCategoryEventStage_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[REventCategoryEventStage] ADD CONSTRAINT [DF_REventCategoryEventStage_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[REventCategoryEventStage] ADD CONSTRAINT [DF_REventCategoryEventStage_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1827497214] ON [dbo].[REventCategoryEventStage]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventCategoryEventStage] ADD CONSTRAINT [PK__REventCategoryEv__6DE18937] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[REventCategoryEventStage] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryEventStage__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryEventStage] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryEventStage__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryEventStage] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryEventStage__R1EventCategoryId] FOREIGN KEY ([R1EventCategoryId]) REFERENCES [dbo].[TEventCategory] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryEventStage] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryEventStage__R2EventStageId] FOREIGN KEY ([R2EventStageId]) REFERENCES [dbo].[LEventStage] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[REventCategoryPerson] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1EventCategoryId]		[bigint]			 NOT NULL,
	[R2PersonId]			[bigint]			 NOT NULL,
	[RoleId]				[bigint]			 NULL,
	[StageId]				[bigint]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventCategoryPerson] ADD CONSTRAINT [DF__REventCate__Guid__6082CA0F] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[REventCategoryPerson] ADD CONSTRAINT [DF__REventCat__REPLI__672FC79E] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[REventCategoryPerson] ADD CONSTRAINT [DF_REventCategoryPerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[REventCategoryPerson] ADD CONSTRAINT [DF_REventCategoryPerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[REventCategoryPerson] ADD CONSTRAINT [DF_REventCategoryPerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1587184029] ON [dbo].[REventCategoryPerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventCategoryPerson] ADD CONSTRAINT [PK__REventCategoryPe__5F8EA5D6] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[REventCategoryPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryPerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryPerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryPerson__R1EventCategoryId] FOREIGN KEY ([R1EventCategoryId]) REFERENCES [dbo].[TEventCategory] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryPerson__R2PersonId] FOREIGN KEY ([R2PersonId]) REFERENCES [dbo].[OPerson] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryPerson__RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[LEventRole] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryPerson__StageId] FOREIGN KEY ([StageId]) REFERENCES [dbo].[LEventStage] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[REventCategoryResource] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1EventCategoryId]		[bigint]			 NOT NULL,
	[R2ResourceId]			[bigint]			 NOT NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[StageId]				[bigint]			 NULL,
	[RoleId]				[bigint]			 NOT NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventCategoryResource] ADD CONSTRAINT [DF__REventCate__Guid__7F0C1539] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[REventCategoryResource] ADD CONSTRAINT [DF__REventCat__REPLI__05B912C8] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[REventCategoryResource] ADD CONSTRAINT [DF_REventCategoryResource_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[REventCategoryResource] ADD CONSTRAINT [DF_REventCategoryResource_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[REventCategoryResource] ADD CONSTRAINT [DF_REventCategoryResource_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2099498183] ON [dbo].[REventCategoryResource]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventCategoryResource] ADD CONSTRAINT [PK__REventCategoryRe__7E17F100] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[REventCategoryResource] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryResource__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryResource] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryResource__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryResource] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryResource__R1EventCategoryId] FOREIGN KEY ([R1EventCategoryId]) REFERENCES [dbo].[TEventCategory] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryResource] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryResource__R2ResourceId] FOREIGN KEY ([R2ResourceId]) REFERENCES [dbo].[OResource] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryResource] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryResource__RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[LEventRole] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCategoryResource] WITH NOCHECK ADD CONSTRAINT [FK__REventCategoryResource__StageId] FOREIGN KEY ([StageId]) REFERENCES [dbo].[LEventStage] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[REventCompany] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1EventID]			[bigint]			 NOT NULL,
	[R2CompanyID]		[bigint]			 NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[RoleId]			[bigint]			 NULL,
	[StageId]			[bigint]			 NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL,
	[Blocking]			[bit]				 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventCompany] ADD CONSTRAINT [DF__REventCom__GuidI__338C3383] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[REventCompany] ADD CONSTRAINT [DF__REventCompany__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[REventCompany] ADD CONSTRAINT [DF_REventCompany_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[REventCompany] ADD CONSTRAINT [DF_REventCompany_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[REventCompany] ADD CONSTRAINT [DF_REventCompany_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[REventCompany] ADD CONSTRAINT [DF_REventCompany_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
ALTER TABLE [dbo].[REventCompany] ADD CONSTRAINT [DF_REventCompany_Blocking_DefaultValue] DEFAULT (0)FOR [Blocking]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_13243102] ON [dbo].[REventCompany]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventCompany] ADD CONSTRAINT [PK__REventCompany__32980F4A] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[REventCompany] WITH NOCHECK ADD CONSTRAINT [FK__REventCompany__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCompany] WITH NOCHECK ADD CONSTRAINT [FK__REventCompany__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCompany] WITH NOCHECK ADD CONSTRAINT [FK__REventCompany__R1EventID] FOREIGN KEY ([R1EventID]) REFERENCES [dbo].[OEvent] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCompany] WITH NOCHECK ADD CONSTRAINT [FK__REventCompany__R2CompanyID] FOREIGN KEY ([R2CompanyID]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCompany] WITH NOCHECK ADD CONSTRAINT [FK__REventCompany__RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[LEventRole] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCompany] WITH NOCHECK ADD CONSTRAINT [FK__REventCompany__StageId] FOREIGN KEY ([StageId]) REFERENCES [dbo].[LEventStage] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[REventCompanyPerson] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1EventId]				[bigint]			 NOT NULL,
	[R2CompanyPersonId]		[bigint]			 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[RoleId]				[bigint]			 NULL,
	[StageId]				[bigint]			 NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL,
	[Blocking]				[bit]				 NOT NULL,
	[Reminder]				[bit]				 NOT NULL,
	[ReminderDelay]			[int]				 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventCompanyPerson] ADD CONSTRAINT [DF__REventComp__Guid__5DE3F6B0] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[REventCompanyPerson] ADD CONSTRAINT [DF__REventCompanyPerson__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[REventCompanyPerson] ADD CONSTRAINT [DF_REventCompanyPerson_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[REventCompanyPerson] ADD CONSTRAINT [DF_REventCompanyPerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[REventCompanyPerson] ADD CONSTRAINT [DF_REventCompanyPerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[REventCompanyPerson] ADD CONSTRAINT [DF_REventCompanyPerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
ALTER TABLE [dbo].[REventCompanyPerson] ADD CONSTRAINT [DF_REventCompanyPerson_Blocking_DefaultValue] DEFAULT (0)FOR [Blocking]
GO
ALTER TABLE [dbo].[REventCompanyPerson] ADD CONSTRAINT [DF_REventCompanyPerson_Reminder_DefaultValue] DEFAULT (0)FOR [Reminder]
GO
ALTER TABLE [dbo].[REventCompanyPerson] ADD CONSTRAINT [DF_REventCompanyPerson_ReminderDelay_DefaultValue] DEFAULT (0)FOR [ReminderDelay]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1335936081] ON [dbo].[REventCompanyPerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventCompanyPerson] ADD CONSTRAINT [PK__REventCompanyPer__5CEFD277] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[REventCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventCompanyPerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventCompanyPerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventCompanyPerson__R1EventId] FOREIGN KEY ([R1EventId]) REFERENCES [dbo].[OEvent] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventCompanyPerson__R2CompanyPersonId] FOREIGN KEY ([R2CompanyPersonId]) REFERENCES [dbo].[RCompanyPerson] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventCompanyPerson__RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[LEventRole] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventCompanyPerson__StageId] FOREIGN KEY ([StageId]) REFERENCES [dbo].[LEventStage] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[REventEvent] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1EventId]			[bigint]			 NOT NULL,
	[R2EventId]			[bigint]			 NOT NULL,
	[StageId]			[bigint]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventEvent] ADD CONSTRAINT [DF__REventEven__Guid__0F3DB8F8] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[REventEvent] ADD CONSTRAINT [DF__REventEvent__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[REventEvent] ADD CONSTRAINT [DF__REventEve__REPLI__15EAB687] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[REventEvent] ADD CONSTRAINT [DF_REventEvent_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[REventEvent] ADD CONSTRAINT [DF_REventEvent_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[REventEvent] ADD CONSTRAINT [DF_REventEvent_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_223703174] ON [dbo].[REventEvent]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventEvent] ADD CONSTRAINT [PK__REventEvent__0E4994BF] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[REventEvent] WITH NOCHECK ADD CONSTRAINT [FK__REventEvent__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventEvent] WITH NOCHECK ADD CONSTRAINT [FK__REventEvent__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventEvent] WITH NOCHECK ADD CONSTRAINT [FK__REventEvent__R1EventId] FOREIGN KEY ([R1EventId]) REFERENCES [dbo].[OEvent] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventEvent] WITH NOCHECK ADD CONSTRAINT [FK__REventEvent__R2EventId] FOREIGN KEY ([R2EventId]) REFERENCES [dbo].[OEvent] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventEvent] WITH NOCHECK ADD CONSTRAINT [FK__REventEvent__StageId] FOREIGN KEY ([StageId]) REFERENCES [dbo].[LEventStage] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[REventFlag] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1EventId]			[bigint]			 NOT NULL,
	[R2FlagId]			[bigint]			 NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventFlag] ADD CONSTRAINT [DF_REventFlag_Guid] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[REventFlag] ADD CONSTRAINT [DF_REventFlag_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[REventFlag] ADD CONSTRAINT [DF_REventFlag_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[REventFlag] ADD CONSTRAINT [DF_REventFlag_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[REventFlag] ADD CONSTRAINT [DF_REventFlag_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_529826837] ON [dbo].[REventFlag]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventFlag] ADD CONSTRAINT [PK_REventFlag] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[REventFlag] WITH NOCHECK ADD CONSTRAINT [FK_REventFlag_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventFlag] WITH NOCHECK ADD CONSTRAINT [FK_REventFlag_ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventFlag] WITH NOCHECK ADD CONSTRAINT [FK_REventFlag_R2FlagId] FOREIGN KEY ([R2FlagId]) REFERENCES [dbo].[OFlag] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[REventLink] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1EventId]			[bigint]			 NOT NULL,
	[R2LinkId]			[bigint]			 NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[StageId]			[bigint]			 NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventLink] ADD CONSTRAINT [DF_REventLink_Guid] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[REventLink] ADD CONSTRAINT [DF_REventLink_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[REventLink] ADD CONSTRAINT [DF_REventLink_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[REventLink] ADD CONSTRAINT [DF_REventLink_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[REventLink] ADD CONSTRAINT [DF_REventLink_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_273825925] ON [dbo].[REventLink]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventLink] ADD CONSTRAINT [PK_REventLink] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[REventLink] WITH NOCHECK ADD CONSTRAINT [FK__REventLink__StageId] FOREIGN KEY ([StageId]) REFERENCES [dbo].[LEventStage] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventLink] WITH NOCHECK ADD CONSTRAINT [FK_REventLink_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventLink] WITH NOCHECK ADD CONSTRAINT [FK_REventLink_ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventLink] WITH NOCHECK ADD CONSTRAINT [FK_REventLink_R2LinkId] FOREIGN KEY ([R2LinkId]) REFERENCES [dbo].[OLink] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[REventLoyaltyCard] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1EventId]				[bigint]			 NOT NULL,
	[R2LoyaltyCardId]		[bigint]			 NOT NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventLoyaltyCard] ADD CONSTRAINT [DF_REventLoyaltyCard_Guid] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[REventLoyaltyCard] ADD CONSTRAINT [DF_REventLoyaltyCard_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[REventLoyaltyCard] ADD CONSTRAINT [DF_REventLoyaltyCard_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[REventLoyaltyCard] ADD CONSTRAINT [DF_REventLoyaltyCard_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[REventLoyaltyCard] ADD CONSTRAINT [DF_REventLoyaltyCard_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_145825469] ON [dbo].[REventLoyaltyCard]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventLoyaltyCard] ADD CONSTRAINT [PK_REventLoyaltyCard] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[REventLoyaltyCard] WITH NOCHECK ADD CONSTRAINT [FK_REventLoyaltyCard_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventLoyaltyCard] WITH NOCHECK ADD CONSTRAINT [FK_REventLoyaltyCard_ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventLoyaltyCard] WITH NOCHECK ADD CONSTRAINT [FK_REventLoyaltyCard_R2LoyaltyCardId] FOREIGN KEY ([R2LoyaltyCardId]) REFERENCES [dbo].[OLoyaltyCard] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[REventNote] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1EventId]			[bigint]			 NOT NULL,
	[R2NoteId]			[bigint]			 NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[StageId]			[bigint]			 NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventNote] ADD CONSTRAINT [DF__REventNote__Guid__09F78318] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[REventNote] ADD CONSTRAINT [DF__REventNote__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[REventNote] ADD CONSTRAINT [DF_REventNote_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[REventNote] ADD CONSTRAINT [DF_REventNote_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[REventNote] ADD CONSTRAINT [DF_REventNote_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[REventNote] ADD CONSTRAINT [DF_REventNote_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1191935568] ON [dbo].[REventNote]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventNote] ADD CONSTRAINT [PK__REventNote__09035EDF] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[REventNote] WITH NOCHECK ADD CONSTRAINT [FK__REventNote__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventNote] WITH NOCHECK ADD CONSTRAINT [FK__REventNote__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventNote] WITH NOCHECK ADD CONSTRAINT [FK__REventNote__R1EventId] FOREIGN KEY ([R1EventId]) REFERENCES [dbo].[OEvent] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventNote] WITH NOCHECK ADD CONSTRAINT [FK__REventNote__R2NoteId] FOREIGN KEY ([R2NoteId]) REFERENCES [dbo].[ONote] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventNote] WITH NOCHECK ADD CONSTRAINT [FK__REventNote__StageId] FOREIGN KEY ([StageId]) REFERENCES [dbo].[LEventStage] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[REventPerson] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1EventID]			[bigint]			 NOT NULL,
	[R2PersonID]		[bigint]			 NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[RoleId]			[bigint]			 NULL,
	[StageId]			[bigint]			 NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL,
	[Blocking]			[bit]				 NOT NULL,
	[Reminder]			[bit]				 NOT NULL,
	[ReminderDelay]		[int]				 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventPerson] ADD CONSTRAINT [DF__REventPer__GuidI__2EC77E66] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[REventPerson] ADD CONSTRAINT [DF__REventPerson__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[REventPerson] ADD CONSTRAINT [DF_REventPerson_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[REventPerson] ADD CONSTRAINT [DF_REventPerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[REventPerson] ADD CONSTRAINT [DF_REventPerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[REventPerson] ADD CONSTRAINT [DF_REventPerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
ALTER TABLE [dbo].[REventPerson] ADD CONSTRAINT [DF_REventPerson_Blocking_DefaultValue] DEFAULT (0)FOR [Blocking]
GO
ALTER TABLE [dbo].[REventPerson] ADD CONSTRAINT [DF_REventPerson_Reminder_DefaultValue] DEFAULT (0)FOR [Reminder]
GO
ALTER TABLE [dbo].[REventPerson] ADD CONSTRAINT [DF_REventPerson_ReminderDelay_DefaultValue] DEFAULT (0)FOR [ReminderDelay]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_141243558] ON [dbo].[REventPerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventPerson] ADD CONSTRAINT [PK__REventPerson__2DD35A2D] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[REventPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventPerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventPerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventPerson__R1EventID] FOREIGN KEY ([R1EventID]) REFERENCES [dbo].[OEvent] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventPerson__R2PersonID] FOREIGN KEY ([R2PersonID]) REFERENCES [dbo].[OPerson] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventPerson__RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[LEventRole] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventPerson] WITH NOCHECK ADD CONSTRAINT [FK__REventPerson__StageId] FOREIGN KEY ([StageId]) REFERENCES [dbo].[LEventStage] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[REventProduct] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1EventId]			[bigint]			 NOT NULL,
	[R2ProductId]		[bigint]			 NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[StageId]			[bigint]			 NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventProduct] ADD CONSTRAINT [DF_REventProduct_Guid] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[REventProduct] ADD CONSTRAINT [DF_REventProduct_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[REventProduct] ADD CONSTRAINT [DF_REventProduct_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[REventProduct] ADD CONSTRAINT [DF_REventProduct_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[REventProduct] ADD CONSTRAINT [DF_REventProduct_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1909307749] ON [dbo].[REventProduct]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventProduct] ADD CONSTRAINT [PK_REventProduct] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[REventProduct] WITH NOCHECK ADD CONSTRAINT [FK__REventProduct__StageId] FOREIGN KEY ([StageId]) REFERENCES [dbo].[LEventStage] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventProduct] WITH NOCHECK ADD CONSTRAINT [FK_REventProduct_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventProduct] WITH NOCHECK ADD CONSTRAINT [FK_REventProduct_ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventProduct] WITH NOCHECK ADD CONSTRAINT [FK_REventProduct_R2ProductId] FOREIGN KEY ([R2ProductId]) REFERENCES [dbo].[OProduct] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[REventProductHierarchy] (
	[Id]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NOT NULL,
	[R1EventId]					[bigint]			 NOT NULL,
	[R2ProductHierarchyId]		[bigint]			 NOT NULL,
	[Description]				[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[CreatedOn]					[datetime]			 NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[StageId]					[bigint]			 NULL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventProductHierarchy] ADD CONSTRAINT [DF_REventProductHierarchy_Guid] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[REventProductHierarchy] ADD CONSTRAINT [DF_REventProductHierarchy_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[REventProductHierarchy] ADD CONSTRAINT [DF_REventProductHierarchy_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[REventProductHierarchy] ADD CONSTRAINT [DF_REventProductHierarchy_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[REventProductHierarchy] ADD CONSTRAINT [DF_REventProductHierarchy_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2037308205] ON [dbo].[REventProductHierarchy]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventProductHierarchy] ADD CONSTRAINT [PK_REventProductHierarchy] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[REventProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__REventProductHierarchy__StageId] FOREIGN KEY ([StageId]) REFERENCES [dbo].[LEventStage] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK_REventProductHierarchy_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK_REventProductHierarchy_ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK_REventProductHierarchy_R2ProductHierarchyId] FOREIGN KEY ([R2ProductHierarchyId]) REFERENCES [dbo].[TProductHierarchy] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[REventProjectItem] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1EventId]				[bigint]			 NOT NULL,
	[R2ProjectItemId]		[bigint]			 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[StageId]				[bigint]			 NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventProjectItem] ADD CONSTRAINT [DF__REventProj__Guid__2C4C9B1C] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[REventProjectItem] ADD CONSTRAINT [DF__REventProjectItem__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[REventProjectItem] ADD CONSTRAINT [DF_REventProjectItem_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[REventProjectItem] ADD CONSTRAINT [DF_REventProjectItem_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[REventProjectItem] ADD CONSTRAINT [DF_REventProjectItem_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[REventProjectItem] ADD CONSTRAINT [DF_REventProjectItem_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1047935055] ON [dbo].[REventProjectItem]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventProjectItem] ADD CONSTRAINT [PK__REventProjectIte__2B5876E3] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[REventProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__REventProjectItem__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__REventProjectItem__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__REventProjectItem__R1EventId] FOREIGN KEY ([R1EventId]) REFERENCES [dbo].[OEvent] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__REventProjectItem__R2ProjectItemId] FOREIGN KEY ([R2ProjectItemId]) REFERENCES [dbo].[OProjectItem] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__REventProjectItem__StageId] FOREIGN KEY ([StageId]) REFERENCES [dbo].[LEventStage] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[REventResource] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1EventId]			[bigint]			 NOT NULL,
	[R2ResourceId]		[bigint]			 NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[StageId]			[bigint]			 NULL,
	[Quantity]			[real]				 NOT NULL,
	[RoleId]			[bigint]			 NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL,
	[Blocking]			[bit]				 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventResource] ADD CONSTRAINT [DF__REventReso__Guid__2433E00A] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[REventResource] ADD CONSTRAINT [DF__REventResource__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[REventResource] ADD CONSTRAINT [DF_REventResource_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[REventResource] ADD CONSTRAINT [DF__REventResource__Quantity__DefaultValue] DEFAULT (0)FOR [Quantity]
GO
ALTER TABLE [dbo].[REventResource] ADD CONSTRAINT [DF_REventResource_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[REventResource] ADD CONSTRAINT [DF_REventResource_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[REventResource] ADD CONSTRAINT [DF_REventResource_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
ALTER TABLE [dbo].[REventResource] ADD CONSTRAINT [DF_REventResource_Blocking_DefaultValue] DEFAULT (0)FOR [Blocking]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1615383057] ON [dbo].[REventResource]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventResource] ADD CONSTRAINT [PK__REventResource__233FBBD1] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[REventResource] WITH NOCHECK ADD CONSTRAINT [FK__REventResource__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventResource] WITH NOCHECK ADD CONSTRAINT [FK__REventResource__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventResource] WITH NOCHECK ADD CONSTRAINT [FK__REventResource__R1EventId] FOREIGN KEY ([R1EventId]) REFERENCES [dbo].[OEvent] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventResource] WITH NOCHECK ADD CONSTRAINT [FK__REventResource__R2ResourceId] FOREIGN KEY ([R2ResourceId]) REFERENCES [dbo].[OResource] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventResource] WITH NOCHECK ADD CONSTRAINT [FK__REventResource__RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[LEventRole] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventResource] WITH NOCHECK ADD CONSTRAINT [FK__REventResource__StageId] FOREIGN KEY ([StageId]) REFERENCES [dbo].[LEventStage] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[REventSupportIssue] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1EventId]				[bigint]			 NOT NULL,
	[R2SupportIssueId]		[bigint]			 NOT NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[StageId]				[bigint]			 NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventSupportIssue] ADD CONSTRAINT [DF_REventSupportIssue_Guid] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[REventSupportIssue] ADD CONSTRAINT [DF_REventSupportIssue_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[REventSupportIssue] ADD CONSTRAINT [DF_REventSupportIssue_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[REventSupportIssue] ADD CONSTRAINT [DF_REventSupportIssue_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[REventSupportIssue] ADD CONSTRAINT [DF_REventSupportIssue_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_17825013] ON [dbo].[REventSupportIssue]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REventSupportIssue] ADD CONSTRAINT [PK_REventSupportIssue] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[REventSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK__REventSupportIssue__StageId] FOREIGN KEY ([StageId]) REFERENCES [dbo].[LEventStage] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK_REventSupportIssue_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK_REventSupportIssue_ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[REventSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK_REventSupportIssue_R2SupportIssueId] FOREIGN KEY ([R2SupportIssueId]) REFERENCES [dbo].[OSupportIssue] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RFlagArticle] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1FlagId]			[bigint]			 NOT NULL,
	[R2ArticleId]		[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagArticle] ADD CONSTRAINT [DF__RFlagArtic__Guid__01AA259F] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagArticle] ADD CONSTRAINT [DF_RFlagArticle_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagArticle] ADD CONSTRAINT [DF_RFlagArticle_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagArticle] ADD CONSTRAINT [DF_RFlagArticle_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagArticle] ADD CONSTRAINT [DF_RFlagArticle_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_291753088] ON [dbo].[RFlagArticle]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagArticle] ADD CONSTRAINT [PK__RFlagArticle__00B60166] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RFlagArticle] WITH NOCHECK ADD CONSTRAINT [FK__RFlagArticle__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagArticle] WITH NOCHECK ADD CONSTRAINT [FK__RFlagArticle__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagArticle] WITH NOCHECK ADD CONSTRAINT [FK__RFlagArticle__R1FlagId] FOREIGN KEY ([R1FlagId]) REFERENCES [dbo].[OFlag] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagArticle] WITH NOCHECK ADD CONSTRAINT [FK__RFlagArticle__R2ArticleId] FOREIGN KEY ([R2ArticleId]) REFERENCES [dbo].[OArticle] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RFlagArticle] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RFlagCompany] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1FlagID]			[bigint]			 NOT NULL,
	[R2CompanyID]		[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagCompany] ADD CONSTRAINT [DF__RFlagCompa__Guid__1650D657] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagCompany] ADD CONSTRAINT [DF_RFlagCompany_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagCompany] ADD CONSTRAINT [DF_RFlagCompany_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagCompany] ADD CONSTRAINT [DF_RFlagCompany_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagCompany] ADD CONSTRAINT [DF_RFlagCompany_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_381244413] ON [dbo].[RFlagCompany]([REPLID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_RFlagCompany_CompanyID_FlagID_ID] ON [dbo].[RFlagCompany]([R2CompanyID], [R1FlagID], [ID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_RFlagCompany_FlagID_CompanyID_ID] ON [dbo].[RFlagCompany]([R1FlagID], [R2CompanyID], [ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagCompany] ADD CONSTRAINT [PK__RFlagCompany__155CB21E] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RFlagCompany] WITH NOCHECK ADD CONSTRAINT [FK__RFlagCompany__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagCompany] WITH NOCHECK ADD CONSTRAINT [FK__RFlagCompany__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagCompany] WITH NOCHECK ADD CONSTRAINT [FK__RFlagCompany__R1FlagID] FOREIGN KEY ([R1FlagID]) REFERENCES [dbo].[OFlag] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagCompany] WITH NOCHECK ADD CONSTRAINT [FK__RFlagCompany__R2CompanyID] FOREIGN KEY ([R2CompanyID]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RFlagCompany] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RFlagCompanyPerson] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1FlagId]				[bigint]			 NOT NULL,
	[R2CompanyPersonId]		[bigint]			 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagCompanyPerson] ADD CONSTRAINT [DF__RFlagCompa__Guid__43D94093] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagCompanyPerson] ADD CONSTRAINT [DF_RFlagCompanyPerson_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagCompanyPerson] ADD CONSTRAINT [DF_RFlagCompanyPerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagCompanyPerson] ADD CONSTRAINT [DF_RFlagCompanyPerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagCompanyPerson] ADD CONSTRAINT [DF_RFlagCompanyPerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_493244812] ON [dbo].[RFlagCompanyPerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagCompanyPerson] ADD CONSTRAINT [PK__RFlagCompanyPers__42E51C5A] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RFlagCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RFlagCompanyPerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RFlagCompanyPerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RFlagCompanyPerson__R1FlagId] FOREIGN KEY ([R1FlagId]) REFERENCES [dbo].[OFlag] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RFlagCompanyPerson__R2CompanyPersonId] FOREIGN KEY ([R2CompanyPersonId]) REFERENCES [dbo].[RCompanyPerson] ([ID]) NOT FOR REPLICATION
GO
GRANT INSERT ON [dbo].[RFlagCompanyPerson] TO [RaportyWEB]
GO
GRANT SELECT ON [dbo].[RFlagCompanyPerson] TO [RaportyWEB]
GO
GRANT UPDATE ON [dbo].[RFlagCompanyPerson] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RFlagEvent] (
	[Id]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NOT NULL,
	[R1FlagId]		[bigint]			 NOT NULL,
	[R2EventId]		[bigint]			 NOT NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagEvent] ADD CONSTRAINT [DF__RFlagEvent__Guid__2CD541EE] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagEvent] ADD CONSTRAINT [DF__RFlagEven__REPLI__3199F70B] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagEvent] ADD CONSTRAINT [DF_RFlagEvent_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagEvent] ADD CONSTRAINT [DF_RFlagEvent_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagEvent] ADD CONSTRAINT [DF_RFlagEvent_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_720173436] ON [dbo].[RFlagEvent]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagEvent] ADD CONSTRAINT [PK__RFlagEvent__2BE11DB5] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RFlagEvent] WITH NOCHECK ADD CONSTRAINT [FK__RFlagEvent__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagEvent] WITH NOCHECK ADD CONSTRAINT [FK__RFlagEvent__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagEvent] WITH NOCHECK ADD CONSTRAINT [FK__RFlagEvent__R1FlagId] FOREIGN KEY ([R1FlagId]) REFERENCES [dbo].[OFlag] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagEvent] WITH NOCHECK ADD CONSTRAINT [FK__RFlagEvent__R2EventId] FOREIGN KEY ([R2EventId]) REFERENCES [dbo].[OEvent] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RFlagLink] (
	[Id]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NOT NULL,
	[R1FlagId]		[bigint]			 NOT NULL,
	[R2LinkId]		[bigint]			 NOT NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[CreatedOn]		[datetime]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagLink] ADD CONSTRAINT [DF__RFlagLink__Guid__517E1FCB] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagLink] ADD CONSTRAINT [DF_RFlagLink_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagLink] ADD CONSTRAINT [DF_RFlagLink_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagLink] ADD CONSTRAINT [DF_RFlagLink_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagLink] ADD CONSTRAINT [DF_RFlagLink_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_951934713] ON [dbo].[RFlagLink]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagLink] ADD CONSTRAINT [PK__RFlagLink__5089FB92] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RFlagLink] WITH NOCHECK ADD CONSTRAINT [FK__RFlagLink__R1FlagId] FOREIGN KEY ([R1FlagId]) REFERENCES [dbo].[OFlag] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagLink] WITH NOCHECK ADD CONSTRAINT [FK__RFlagLink__R2LinkId] FOREIGN KEY ([R2LinkId]) REFERENCES [dbo].[OLink] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagLink] WITH NOCHECK ADD CONSTRAINT [FK__RFlagLink_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagLink] WITH NOCHECK ADD CONSTRAINT [FK__RFlagLink_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT INSERT ON [dbo].[RFlagLink] TO [RaportyWEB]
GO
GRANT SELECT ON [dbo].[RFlagLink] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RFlagNote] (
	[Id]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NOT NULL,
	[R1FlagId]		[bigint]			 NOT NULL,
	[R2NoteId]		[bigint]			 NOT NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagNote] ADD CONSTRAINT [DF__RFlagNote__Guid__358B213C] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagNote] ADD CONSTRAINT [DF_RFlagNote_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagNote] ADD CONSTRAINT [DF_RFlagNote_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagNote] ADD CONSTRAINT [DF_RFlagNote_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagNote] ADD CONSTRAINT [DF_RFlagNote_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_605245211] ON [dbo].[RFlagNote]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagNote] ADD CONSTRAINT [PK__RFlagNote__3496FD03] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RFlagNote] WITH NOCHECK ADD CONSTRAINT [FK__RFlagNote__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagNote] WITH NOCHECK ADD CONSTRAINT [FK__RFlagNote__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagNote] WITH NOCHECK ADD CONSTRAINT [FK__RFlagNote__R1FlagId] FOREIGN KEY ([R1FlagId]) REFERENCES [dbo].[OFlag] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagNote] WITH NOCHECK ADD CONSTRAINT [FK__RFlagNote__R2NoteId] FOREIGN KEY ([R2NoteId]) REFERENCES [dbo].[ONote] ([ID]) NOT FOR REPLICATION
GO
GRANT INSERT ON [dbo].[RFlagNote] TO [RaportyWEB]
GO
GRANT SELECT ON [dbo].[RFlagNote] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RFlagPerson] (
	[ID]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NOT NULL,
	[R1FlagID]		[bigint]			 NOT NULL,
	[R2PersonID]	[bigint]			 NOT NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagPerson] ADD CONSTRAINT [DF__RFlagPerso__Guid__118C213A] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagPerson] ADD CONSTRAINT [DF_RFlagPerson_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagPerson] ADD CONSTRAINT [DF_RFlagPerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagPerson] ADD CONSTRAINT [DF_RFlagPerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagPerson] ADD CONSTRAINT [DF_RFlagPerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_717245610] ON [dbo].[RFlagPerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagPerson] ADD CONSTRAINT [PK__RFlagPerson__1097FD01] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RFlagPerson] WITH NOCHECK ADD CONSTRAINT [FK__RFlagPerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagPerson] WITH NOCHECK ADD CONSTRAINT [FK__RFlagPerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagPerson] WITH NOCHECK ADD CONSTRAINT [FK__RFlagPerson__R1FlagID] FOREIGN KEY ([R1FlagID]) REFERENCES [dbo].[OFlag] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagPerson] WITH NOCHECK ADD CONSTRAINT [FK__RFlagPerson__R2PersonID] FOREIGN KEY ([R2PersonID]) REFERENCES [dbo].[OPerson] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RFlagProductHierarchy] (
	[Id]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NOT NULL,
	[R1FlagId]					[bigint]			 NOT NULL,
	[R2ProductHierarchyId]		[bigint]			 NOT NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[CreatedOn]					[datetime]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagProductHierarchy] ADD CONSTRAINT [DF__RFlagProdu__Guid__650DE6F1] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagProductHierarchy] ADD CONSTRAINT [DF_RFlagProductHierarchy_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagProductHierarchy] ADD CONSTRAINT [DF_RFlagProductHierarchy_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagProductHierarchy] ADD CONSTRAINT [DF_RFlagProductHierarchy_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagProductHierarchy] ADD CONSTRAINT [DF_RFlagProductHierarchy_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_579754114] ON [dbo].[RFlagProductHierarchy]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagProductHierarchy] ADD CONSTRAINT [PK__RFlagProductHier__6419C2B8] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RFlagProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__RFlagProductHierarchy__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__RFlagProductHierarchy__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__RFlagProductHierarchy__R1FlagId] FOREIGN KEY ([R1FlagId]) REFERENCES [dbo].[OFlag] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__RFlagProductHierarchy__R2ProductHierarchyId] FOREIGN KEY ([R2ProductHierarchyId]) REFERENCES [dbo].[TProductHierarchy] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RFlagProductHierarchy] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RFlagProjectItem] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1FlagId]				[bigint]			 NOT NULL,
	[R2ProjectItemId]		[bigint]			 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagProjectItem] ADD CONSTRAINT [DF__RFlagProje__Guid__3F148B76] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagProjectItem] ADD CONSTRAINT [DF_RFlagProjectItem_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagProjectItem] ADD CONSTRAINT [DF_RFlagProjectItem_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagProjectItem] ADD CONSTRAINT [DF_RFlagProjectItem_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagProjectItem] ADD CONSTRAINT [DF_RFlagProjectItem_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_829246009] ON [dbo].[RFlagProjectItem]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagProjectItem] ADD CONSTRAINT [PK__RFlagProjectItem__3E20673D] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RFlagProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__RFlagProjectItem__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__RFlagProjectItem__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__RFlagProjectItem__R1FlagId] FOREIGN KEY ([R1FlagId]) REFERENCES [dbo].[OFlag] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__RFlagProjectItem__R2ProjectItemId] FOREIGN KEY ([R2ProjectItemId]) REFERENCES [dbo].[OProjectItem] ([Id]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RFlagProjectItem] TO [formularze2]
GO
CREATE TABLE [dbo].[RFlagQuestionArticleAnswer] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1FlagQuestionId]		[bigint]			 NOT NULL,
	[R2FlagArticleId]		[bigint]			 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[Answer]				[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[AnswerId]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionArticleAnswer] ADD CONSTRAINT [DF__RFlagQuest__Guid__066EDABC] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagQuestionArticleAnswer] ADD CONSTRAINT [DF__RFlagQuestionArticleAnswer__Answer__DefaultValue] DEFAULT ('')FOR [Answer]
GO
ALTER TABLE [dbo].[RFlagQuestionArticleAnswer] ADD CONSTRAINT [DF_RFlagQuestionArticleAnswer_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagQuestionArticleAnswer] ADD CONSTRAINT [DF_RFlagQuestionArticleAnswer_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagQuestionArticleAnswer] ADD CONSTRAINT [DF_RFlagQuestionArticleAnswer_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagQuestionArticleAnswer] ADD CONSTRAINT [DF_RFlagQuestionArticleAnswer_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1959235026] ON [dbo].[RFlagQuestionArticleAnswer]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionArticleAnswer] ADD CONSTRAINT [PK__RFlagQuestionArt__057AB683] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RFlagQuestionArticleAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionArticleAnswer__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionArticleAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionArticleAnswer__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionArticleAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionArticleAnswer__R1FlagQuestionId] FOREIGN KEY ([R1FlagQuestionId]) REFERENCES [dbo].[LFlagQuestion] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionArticleAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionArticleAnswer__R2FlagArticleId] FOREIGN KEY ([R2FlagArticleId]) REFERENCES [dbo].[RFlagArticle] ([Id]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RFlagQuestionArticleAnswer] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RFlagQuestionCompanyAnswer] (
	[ID]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1FlagQuestionID]		[bigint]			 NOT NULL,
	[R2FlagCompanyID]		[bigint]			 NOT NULL,
	[Answer]				[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[AnswerID]				[bigint]			 NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionCompanyAnswer] ADD CONSTRAINT [DF__RFlagQuest__Guid__3010A85A] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagQuestionCompanyAnswer] ADD CONSTRAINT [DF__RFlagQuestionCompanyAnswer__Answer__DefaultValue] DEFAULT ('')FOR [Answer]
GO
ALTER TABLE [dbo].[RFlagQuestionCompanyAnswer] ADD CONSTRAINT [DF_RFlagQuestionCompanyAnswer_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagQuestionCompanyAnswer] ADD CONSTRAINT [DF_RFlagQuestionCompanyAnswer_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagQuestionCompanyAnswer] ADD CONSTRAINT [DF_RFlagQuestionCompanyAnswer_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagQuestionCompanyAnswer] ADD CONSTRAINT [DF_RFlagQuestionCompanyAnswer_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_941246408] ON [dbo].[RFlagQuestionCompanyAnswer]([REPLID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_RFlagQuestionCompanyAnswerXXX] ON [dbo].[RFlagQuestionCompanyAnswer]([R1FlagQuestionID], [R2FlagCompanyID], [ID]) WITH PAD_INDEX, FILLFACTOR = 80 ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TEST1] ON [dbo].[RFlagQuestionCompanyAnswer]([R2FlagCompanyID], [R1FlagQuestionID]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Test3] ON [dbo].[RFlagQuestionCompanyAnswer]([R2FlagCompanyID], [R1FlagQuestionID], [ID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionCompanyAnswer] ADD CONSTRAINT [PK__RFlagQuestionCom__2F1C8421] PRIMARY KEY CLUSTERED ([ID])
GO
CREATE NONCLUSTERED INDEX [test2] ON [dbo].[RFlagQuestionCompanyAnswer]([R1FlagQuestionID], [R2FlagCompanyID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionCompanyAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionCompanyAnswer__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionCompanyAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionCompanyAnswer__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionCompanyAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionCompanyAnswer__R1FlagQuestionID] FOREIGN KEY ([R1FlagQuestionID]) REFERENCES [dbo].[LFlagQuestion] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionCompanyAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionCompanyAnswer__R2FlagCompanyID] FOREIGN KEY ([R2FlagCompanyID]) REFERENCES [dbo].[RFlagCompany] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RFlagQuestionCompanyAnswer] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RFlagQuestionCompanyPersonAnswer] (
	[Id]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NOT NULL,
	[R1FlagQuestionId]			[bigint]			 NOT NULL,
	[R2FlagCompanyPersonId]		[bigint]			 NOT NULL,
	[Answer]					[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[CreatedOn]					[datetime]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[AnswerID]					[bigint]			 NULL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionCompanyPersonAnswer] ADD CONSTRAINT [DF__RFlagQuest__Guid__489DF5B0] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagQuestionCompanyPersonAnswer] ADD CONSTRAINT [DF__RFlagQuestionCompanyPersonAnswer__Answer__DefaultValue] DEFAULT ('')FOR [Answer]
GO
ALTER TABLE [dbo].[RFlagQuestionCompanyPersonAnswer] ADD CONSTRAINT [DF_RFlagQuestionCompanyPersonAnswer_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagQuestionCompanyPersonAnswer] ADD CONSTRAINT [DF_RFlagQuestionCompanyPersonAnswer_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagQuestionCompanyPersonAnswer] ADD CONSTRAINT [DF_RFlagQuestionCompanyPersonAnswer_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagQuestionCompanyPersonAnswer] ADD CONSTRAINT [DF_RFlagQuestionCompanyPersonAnswer_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1069246864] ON [dbo].[RFlagQuestionCompanyPersonAnswer]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionCompanyPersonAnswer] ADD CONSTRAINT [PK__RFlagQuestionCom__47A9D177] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RFlagQuestionCompanyPersonAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionCompanyPersonAnswer__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionCompanyPersonAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionCompanyPersonAnswer__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionCompanyPersonAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionCompanyPersonAnswer__R1FlagQuestionId] FOREIGN KEY ([R1FlagQuestionId]) REFERENCES [dbo].[LFlagQuestion] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionCompanyPersonAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionCompanyPersonAnswer__R2FlagCompanyPersonId] FOREIGN KEY ([R2FlagCompanyPersonId]) REFERENCES [dbo].[RFlagCompanyPerson] ([Id]) NOT FOR REPLICATION
GO
GRANT INSERT ON [dbo].[RFlagQuestionCompanyPersonAnswer] TO [RaportyWEB]
GO
GRANT SELECT ON [dbo].[RFlagQuestionCompanyPersonAnswer] TO [RaportyWEB]
GO
GRANT UPDATE ON [dbo].[RFlagQuestionCompanyPersonAnswer] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RFlagQuestionEventAnswer] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1FlagQuestionId]		[bigint]			 NOT NULL,
	[R2FlagEventId]			[bigint]			 NOT NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[Answer]				[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionEventAnswer] ADD CONSTRAINT [DF__RFlagQuest__Guid__347663B6] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagQuestionEventAnswer] ADD CONSTRAINT [DF__RFlagQuestionEventAnswer__Answer__DefaultValue] DEFAULT ('')FOR [Answer]
GO
ALTER TABLE [dbo].[RFlagQuestionEventAnswer] ADD CONSTRAINT [DF__RFlagQues__REPLI__3A2F3D0C] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagQuestionEventAnswer] ADD CONSTRAINT [DF_RFlagQuestionEventAnswer_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagQuestionEventAnswer] ADD CONSTRAINT [DF_RFlagQuestionEventAnswer_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagQuestionEventAnswer] ADD CONSTRAINT [DF_RFlagQuestionEventAnswer_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_848173892] ON [dbo].[RFlagQuestionEventAnswer]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionEventAnswer] ADD CONSTRAINT [PK__RFlagQuestionEve__33823F7D] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RFlagQuestionEventAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionEventAnswer__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionEventAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionEventAnswer__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionEventAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionEventAnswer__R1FlagQuestionId] FOREIGN KEY ([R1FlagQuestionId]) REFERENCES [dbo].[LFlagQuestion] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionEventAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionEventAnswer__R2FlagEventId] FOREIGN KEY ([R2FlagEventId]) REFERENCES [dbo].[RFlagEvent] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RFlagQuestionFlag] (
	[ID]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1FlagQuestionID]		[bigint]			 NOT NULL,
	[R2FlagID]				[bigint]			 NOT NULL,
	[IsActive]				[bit]				 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionFlag] ADD CONSTRAINT [DF__RFlagQuest__Guid__2B4BF33D] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagQuestionFlag] ADD CONSTRAINT [DF__RFlagQuestionFlag__IsActive__DefaultValue] DEFAULT (0)FOR [IsActive]
GO
ALTER TABLE [dbo].[RFlagQuestionFlag] ADD CONSTRAINT [DF_RFlagQuestionFlag_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagQuestionFlag] ADD CONSTRAINT [DF_RFlagQuestionFlag_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagQuestionFlag] ADD CONSTRAINT [DF_RFlagQuestionFlag_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagQuestionFlag] ADD CONSTRAINT [DF_RFlagQuestionFlag_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1197247320] ON [dbo].[RFlagQuestionFlag]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionFlag] ADD CONSTRAINT [PK__RFlagQuestionFla__2A57CF04] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RFlagQuestionFlag] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionFlag__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionFlag] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionFlag__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionFlag] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionFlag__R1FlagQuestionID] FOREIGN KEY ([R1FlagQuestionID]) REFERENCES [dbo].[LFlagQuestion] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionFlag] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionFlag__R2FlagID] FOREIGN KEY ([R2FlagID]) REFERENCES [dbo].[OFlag] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RFlagQuestionLinkAnswer] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1FlagQuestionId]		[bigint]			 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[Answer]				[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[AnswerID]				[bigint]			 NULL,
	[R2FlagLinkId]			[bigint]			 NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionLinkAnswer] ADD CONSTRAINT [DF__RFlagQuest__Guid__5642D4E8] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagQuestionLinkAnswer] ADD CONSTRAINT [DF__RFlagQuestionLinkAnswer__Answer__DefaultValue] DEFAULT ('')FOR [Answer]
GO
ALTER TABLE [dbo].[RFlagQuestionLinkAnswer] ADD CONSTRAINT [DF_RFlagQuestionLinkAnswer_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagQuestionLinkAnswer] ADD CONSTRAINT [DF_RFlagQuestionLinkAnswer_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagQuestionLinkAnswer] ADD CONSTRAINT [DF_RFlagQuestionLinkAnswer_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagQuestionLinkAnswer] ADD CONSTRAINT [DF_RFlagQuestionLinkAnswer_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_55931521] ON [dbo].[RFlagQuestionLinkAnswer]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionLinkAnswer] ADD CONSTRAINT [PK__RFlagQuestionLin__554EB0AF] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RFlagQuestionLinkAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionLinkAnswer__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionLinkAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionLinkAnswer__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionLinkAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionLinkAnswer__R1FlagQuestionId] FOREIGN KEY ([R1FlagQuestionId]) REFERENCES [dbo].[LFlagQuestion] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionLinkAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionLinkAnswer__R2FlagLinkId] FOREIGN KEY ([R2FlagLinkId]) REFERENCES [dbo].[RFlagLink] ([Id]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RFlagQuestionLinkAnswer] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RFlagQuestionNoteAnswer] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1FlagQuestionId]		[bigint]			 NOT NULL,
	[R2FlagNoteId]			[bigint]			 NOT NULL,
	[Answer]				[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[AnswerID]				[bigint]			 NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionNoteAnswer] ADD CONSTRAINT [DF__RFlagQuest__Guid__56EC1507] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagQuestionNoteAnswer] ADD CONSTRAINT [DF__RFlagQuestionNoteAnswer__Answer__DefaultValue] DEFAULT ('')FOR [Answer]
GO
ALTER TABLE [dbo].[RFlagQuestionNoteAnswer] ADD CONSTRAINT [DF_RFlagQuestionNoteAnswer_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagQuestionNoteAnswer] ADD CONSTRAINT [DF_RFlagQuestionNoteAnswer_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagQuestionNoteAnswer] ADD CONSTRAINT [DF_RFlagQuestionNoteAnswer_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagQuestionNoteAnswer] ADD CONSTRAINT [DF_RFlagQuestionNoteAnswer_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1325247776] ON [dbo].[RFlagQuestionNoteAnswer]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionNoteAnswer] ADD CONSTRAINT [PK__RFlagQuestionNot__55F7F0CE] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RFlagQuestionNoteAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionNoteAnswer__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionNoteAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionNoteAnswer__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionNoteAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionNoteAnswer__R1FlagQuestionId] FOREIGN KEY ([R1FlagQuestionId]) REFERENCES [dbo].[LFlagQuestion] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionNoteAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionNoteAnswer__R2FlagNoteId] FOREIGN KEY ([R2FlagNoteId]) REFERENCES [dbo].[RFlagNote] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RFlagQuestionPersonAnswer] (
	[ID]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1FlagQuestionID]		[bigint]			 NOT NULL,
	[R2FlagPersonID]		[bigint]			 NOT NULL,
	[Answer]				[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[AnswerID]				[bigint]			 NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionPersonAnswer] ADD CONSTRAINT [DF__RFlagQuest__Guid__34D55D77] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagQuestionPersonAnswer] ADD CONSTRAINT [DF__RFlagQuestionPersonAnswer__Answer__DefaultValue] DEFAULT ('')FOR [Answer]
GO
ALTER TABLE [dbo].[RFlagQuestionPersonAnswer] ADD CONSTRAINT [DF_RFlagQuestionPersonAnswer_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagQuestionPersonAnswer] ADD CONSTRAINT [DF_RFlagQuestionPersonAnswer_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagQuestionPersonAnswer] ADD CONSTRAINT [DF_RFlagQuestionPersonAnswer_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagQuestionPersonAnswer] ADD CONSTRAINT [DF_RFlagQuestionPersonAnswer_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1453248232] ON [dbo].[RFlagQuestionPersonAnswer]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionPersonAnswer] ADD CONSTRAINT [PK__RFlagQuestionPer__33E1393E] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RFlagQuestionPersonAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionPersonAnswer__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionPersonAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionPersonAnswer__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionPersonAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionPersonAnswer__R1FlagQuestionID] FOREIGN KEY ([R1FlagQuestionID]) REFERENCES [dbo].[LFlagQuestion] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionPersonAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionPersonAnswer__R2FlagPersonID] FOREIGN KEY ([R2FlagPersonID]) REFERENCES [dbo].[RFlagPerson] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RFlagQuestionProductHierarchyAnswer] (
	[Id]							[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]							[uniqueidentifier]	 NOT NULL,
	[R1FlagQuestionId]				[bigint]			 NOT NULL,
	[R2FlagProductHierarchyId]		[bigint]			 NOT NULL,
	[Answer]						[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]					[datetime]			 NULL,
	[CreatedOn]						[datetime]			 NULL,
	[ModifiedBy]					[bigint]			 NULL,
	[CreatedBy]						[bigint]			 NULL,
	[AnswerId]						[bigint]			 NULL,
	[REPLID]						[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]							[bigint]			 NOT NULL,
	[SecW]							[bigint]			 NOT NULL,
	[SecD]							[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionProductHierarchyAnswer] ADD CONSTRAINT [DF__RFlagQuest__Guid__74502A81] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagQuestionProductHierarchyAnswer] ADD CONSTRAINT [DF__RFlagQuestionProductHierarchyAnswer__Answer__DefaultValue] DEFAULT ('')FOR [Answer]
GO
ALTER TABLE [dbo].[RFlagQuestionProductHierarchyAnswer] ADD CONSTRAINT [DF_RFlagQuestionProductHierarchyAnswer_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagQuestionProductHierarchyAnswer] ADD CONSTRAINT [DF_RFlagQuestionProductHierarchyAnswer_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagQuestionProductHierarchyAnswer] ADD CONSTRAINT [DF_RFlagQuestionProductHierarchyAnswer_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagQuestionProductHierarchyAnswer] ADD CONSTRAINT [DF_RFlagQuestionProductHierarchyAnswer_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1671234000] ON [dbo].[RFlagQuestionProductHierarchyAnswer]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionProductHierarchyAnswer] ADD CONSTRAINT [PK__RFlagQuestionPro__735C0648] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RFlagQuestionProductHierarchyAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionProductHierarchyAnswer__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionProductHierarchyAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionProductHierarchyAnswer__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionProductHierarchyAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionProductHierarchyAnswer__R1FlagQuestionId] FOREIGN KEY ([R1FlagQuestionId]) REFERENCES [dbo].[LFlagQuestion] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionProductHierarchyAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionProductHierarchyAnswer__R2FlagProductHierarchyId] FOREIGN KEY ([R2FlagProductHierarchyId]) REFERENCES [dbo].[RFlagProductHierarchy] ([Id]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RFlagQuestionProductHierarchyAnswer] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RFlagQuestionProjectItemAnswer] (
	[Id]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NOT NULL,
	[R1FlagQuestionId]			[bigint]			 NULL,
	[R2FlagProjectItemId]		[bigint]			 NULL,
	[Answer]					[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[CreatedOn]					[datetime]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[AnswerID]					[bigint]			 NULL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionProjectItemAnswer] ADD CONSTRAINT [DF__RFlagQuest__Guid__4D62AACD] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagQuestionProjectItemAnswer] ADD CONSTRAINT [DF__RFlagQuestionProjectItemAnswer__Answer__DefaultValue] DEFAULT ('')FOR [Answer]
GO
ALTER TABLE [dbo].[RFlagQuestionProjectItemAnswer] ADD CONSTRAINT [DF_RFlagQuestionProjectItemAnswer_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagQuestionProjectItemAnswer] ADD CONSTRAINT [DF_RFlagQuestionProjectItemAnswer_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagQuestionProjectItemAnswer] ADD CONSTRAINT [DF_RFlagQuestionProjectItemAnswer_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagQuestionProjectItemAnswer] ADD CONSTRAINT [DF_RFlagQuestionProjectItemAnswer_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1581248688] ON [dbo].[RFlagQuestionProjectItemAnswer]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionProjectItemAnswer] ADD CONSTRAINT [PK__RFlagQuestionPro__4C6E8694] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RFlagQuestionProjectItemAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionProjectItemAnswer__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionProjectItemAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionProjectItemAnswer__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionProjectItemAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionProjectItemAnswer__R1FlagQuestionId] FOREIGN KEY ([R1FlagQuestionId]) REFERENCES [dbo].[LFlagQuestion] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionProjectItemAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionProjectItemAnswer__R2FlagProjectItemId] FOREIGN KEY ([R2FlagProjectItemId]) REFERENCES [dbo].[RFlagProjectItem] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RFlagQuestionResourceAnswer] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1FlagQuestionId]		[bigint]			 NOT NULL,
	[R2FlagResourceId]		[bigint]			 NOT NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[Answer]				[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionResourceAnswer] ADD CONSTRAINT [DF__RFlagQuest__Guid__3972ECC5] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagQuestionResourceAnswer] ADD CONSTRAINT [DF__RFlagQuestionResourceAnswer__Answer__DefaultValue] DEFAULT ('')FOR [Answer]
GO
ALTER TABLE [dbo].[RFlagQuestionResourceAnswer] ADD CONSTRAINT [DF_RFlagQuestionResourceAnswer_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagQuestionResourceAnswer] ADD CONSTRAINT [DF_RFlagQuestionResourceAnswer_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagQuestionResourceAnswer] ADD CONSTRAINT [DF_RFlagQuestionResourceAnswer_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagQuestionResourceAnswer] ADD CONSTRAINT [DF_RFlagQuestionResourceAnswer_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1091833485] ON [dbo].[RFlagQuestionResourceAnswer]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionResourceAnswer] ADD CONSTRAINT [PK__RFlagQuestionRes__387EC88C] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RFlagQuestionResourceAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionResourceAnswer__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionResourceAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionResourceAnswer__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionResourceAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionResourceAnswer__R1FlagQuestionId] FOREIGN KEY ([R1FlagQuestionId]) REFERENCES [dbo].[LFlagQuestion] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RFlagResource] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1FlagId]			[bigint]			 NOT NULL,
	[R2ResourceId]		[bigint]			 NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagResource] ADD CONSTRAINT [DF__RFlagResou__Guid__284860C3] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagResource] ADD CONSTRAINT [DF_RFlagResource_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagResource] ADD CONSTRAINT [DF_RFlagResource_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagResource] ADD CONSTRAINT [DF_RFlagResource_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagResource] ADD CONSTRAINT [DF_RFlagResource_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1219833941] ON [dbo].[RFlagResource]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagResource] ADD CONSTRAINT [PK__RFlagResource__27543C8A] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RFlagResource] WITH NOCHECK ADD CONSTRAINT [FK__RFlagResource__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagResource] WITH NOCHECK ADD CONSTRAINT [FK__RFlagResource__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagResource] WITH NOCHECK ADD CONSTRAINT [FK__RFlagResource__R1FlagId] FOREIGN KEY ([R1FlagId]) REFERENCES [dbo].[OFlag] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagResource] WITH NOCHECK ADD CONSTRAINT [FK__RFlagResource__R2ResourceId] FOREIGN KEY ([R2ResourceId]) REFERENCES [dbo].[OResource] ([Id]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RFlagResource] TO [RaportyWEBZewn]
GO
ALTER TABLE [dbo].[RFlagQuestionResourceAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionResourceAnswer__R2FlagResourceId] FOREIGN KEY ([R2FlagResourceId]) REFERENCES [dbo].[RFlagResource] ([Id]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RFlagQuestionResourceAnswer] TO [RaportyWEBZewn]
GO
CREATE TABLE [dbo].[RFlagQuestionSaleAnswer] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1FlagQuestionId]		[bigint]			 NOT NULL,
	[R2FlagSaleId]			[bigint]			 NOT NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[Answer]				[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionSaleAnswer] ADD CONSTRAINT [DF__RFlagQuest__Guid__68EA2BF5] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagQuestionSaleAnswer] ADD CONSTRAINT [DF__RFlagQuestionSaleAnswer__Answer__DefaultValue] DEFAULT ('')FOR [Answer]
GO
ALTER TABLE [dbo].[RFlagQuestionSaleAnswer] ADD CONSTRAINT [DF__RFlagQues__REPLI__6EA3054B] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagQuestionSaleAnswer] ADD CONSTRAINT [DF_RFlagQuestionSaleAnswer_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagQuestionSaleAnswer] ADD CONSTRAINT [DF_RFlagQuestionSaleAnswer_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagQuestionSaleAnswer] ADD CONSTRAINT [DF_RFlagQuestionSaleAnswer_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1728177027] ON [dbo].[RFlagQuestionSaleAnswer]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionSaleAnswer] ADD CONSTRAINT [PK__RFlagQuestionSal__67F607BC] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RFlagQuestionSaleAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionSaleAnswer__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionSaleAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionSaleAnswer__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionSaleAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionSaleAnswer__R1FlagQuestionId] FOREIGN KEY ([R1FlagQuestionId]) REFERENCES [dbo].[LFlagQuestion] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RFlagSale] (
	[Id]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NOT NULL,
	[R1FlagId]		[bigint]			 NOT NULL,
	[R2SaleId]		[bigint]			 NOT NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagSale] ADD CONSTRAINT [DF__RFlagSale__Guid__61490A2D] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagSale] ADD CONSTRAINT [DF__RFlagSale__REPLI__660DBF4A] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagSale] ADD CONSTRAINT [DF_RFlagSale_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagSale] ADD CONSTRAINT [DF_RFlagSale_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagSale] ADD CONSTRAINT [DF_RFlagSale_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1600176571] ON [dbo].[RFlagSale]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagSale] ADD CONSTRAINT [PK__RFlagSale__6054E5F4] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RFlagSale] WITH NOCHECK ADD CONSTRAINT [FK__RFlagSale__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagSale] WITH NOCHECK ADD CONSTRAINT [FK__RFlagSale__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagSale] WITH NOCHECK ADD CONSTRAINT [FK__RFlagSale__R1FlagId] FOREIGN KEY ([R1FlagId]) REFERENCES [dbo].[OFlag] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagSale] WITH NOCHECK ADD CONSTRAINT [FK__RFlagSale__R2SaleId] FOREIGN KEY ([R2SaleId]) REFERENCES [dbo].[OSale] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionSaleAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionSaleAnswer__R2FlagSaleId] FOREIGN KEY ([R2FlagSaleId]) REFERENCES [dbo].[RFlagSale] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RFlagQuestionSupportIssueAnswer] (
	[Id]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NOT NULL,
	[R1FlagQuestionId]			[bigint]			 NOT NULL,
	[R2FlagSupportIssueId]		[bigint]			 NOT NULL,
	[Answer]					[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[CreatedOn]					[datetime]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[AnswerID]					[bigint]			 NULL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionSupportIssueAnswer] ADD CONSTRAINT [DF__RFlagQuest__Guid__52275FEA] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagQuestionSupportIssueAnswer] ADD CONSTRAINT [DF__RFlagQuestionSupportIssueAnswer__Answer__DefaultValue] DEFAULT ('')FOR [Answer]
GO
ALTER TABLE [dbo].[RFlagQuestionSupportIssueAnswer] ADD CONSTRAINT [DF_RFlagQuestionSupportIssueAnswer_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagQuestionSupportIssueAnswer] ADD CONSTRAINT [DF_RFlagQuestionSupportIssueAnswer_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagQuestionSupportIssueAnswer] ADD CONSTRAINT [DF_RFlagQuestionSupportIssueAnswer_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagQuestionSupportIssueAnswer] ADD CONSTRAINT [DF_RFlagQuestionSupportIssueAnswer_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1709249144] ON [dbo].[RFlagQuestionSupportIssueAnswer]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagQuestionSupportIssueAnswer] ADD CONSTRAINT [PK__RFlagQuestionSup__51333BB1] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RFlagQuestionSupportIssueAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionSupportIssueAnswer__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionSupportIssueAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionSupportIssueAnswer__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagQuestionSupportIssueAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionSupportIssueAnswer__R1FlagQuestionId] FOREIGN KEY ([R1FlagQuestionId]) REFERENCES [dbo].[LFlagQuestion] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RFlagSupportIssue] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1FlagId]				[bigint]			 NOT NULL,
	[R2SupportIssueId]		[bigint]			 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagSupportIssue] ADD CONSTRAINT [DF__RFlagSuppo__Guid__3A4FD659] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagSupportIssue] ADD CONSTRAINT [DF_RFlagSupportIssue_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagSupportIssue] ADD CONSTRAINT [DF_RFlagSupportIssue_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagSupportIssue] ADD CONSTRAINT [DF_RFlagSupportIssue_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagSupportIssue] ADD CONSTRAINT [DF_RFlagSupportIssue_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1821249543] ON [dbo].[RFlagSupportIssue]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagSupportIssue] ADD CONSTRAINT [PK__RFlagSupportIssu__395BB220] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RFlagSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK__RFlagSupportIssue__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK__RFlagSupportIssue__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK__RFlagSupportIssue__R1FlagId] FOREIGN KEY ([R1FlagId]) REFERENCES [dbo].[OFlag] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK__RFlagSupportIssue__R2SupportIssueId] FOREIGN KEY ([R2SupportIssueId]) REFERENCES [dbo].[OSupportIssue] ([ID]) NOT FOR REPLICATION
GO
GRANT INSERT ON [dbo].[RFlagSupportIssue] TO [RaportyWEB]
GO
GRANT SELECT ON [dbo].[RFlagSupportIssue] TO [RaportyWEB]
GO
ALTER TABLE [dbo].[RFlagQuestionSupportIssueAnswer] WITH NOCHECK ADD CONSTRAINT [FK__RFlagQuestionSupportIssueAnswer__R2FlagSupportIssueId] FOREIGN KEY ([R2FlagSupportIssueId]) REFERENCES [dbo].[RFlagSupportIssue] ([Id]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RFlagQuestionSupportIssueAnswer] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RFlagTypeFlag] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1FlagTypeID]		[bigint]			 NOT NULL,
	[R2FlagID]			[bigint]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagTypeFlag] ADD CONSTRAINT [DF__RFlagTypeF__Guid__6D19B69A] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RFlagTypeFlag] ADD CONSTRAINT [DF_RFlagTypeFlag_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RFlagTypeFlag] ADD CONSTRAINT [DF_RFlagTypeFlag_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RFlagTypeFlag] ADD CONSTRAINT [DF_RFlagTypeFlag_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RFlagTypeFlag] ADD CONSTRAINT [DF_RFlagTypeFlag_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1949249999] ON [dbo].[RFlagTypeFlag]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RFlagTypeFlag] ADD CONSTRAINT [PK__RFlagTypeFlag__6C259261] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RFlagTypeFlag] WITH NOCHECK ADD CONSTRAINT [FK__RFlagTypeFlag__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagTypeFlag] WITH NOCHECK ADD CONSTRAINT [FK__RFlagTypeFlag__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagTypeFlag] WITH NOCHECK ADD CONSTRAINT [FK__RFlagTypeFlag__R1FlagTypeID] FOREIGN KEY ([R1FlagTypeID]) REFERENCES [dbo].[LFlagType] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RFlagTypeFlag] WITH NOCHECK ADD CONSTRAINT [FK__RFlagTypeFlag__R2FlagID] FOREIGN KEY ([R2FlagID]) REFERENCES [dbo].[OFlag] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RLoyaltyCardCompany] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1LoyaltyCardId]		[bigint]			 NOT NULL,
	[R2CompanyId]			[bigint]			 NOT NULL,
	[TypeId]				[bigint]			 NOT NULL,
	[Password]				[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[Note]					[text]				 COLLATE Polish_CI_AS NULL,
	[Issued]				[bit]				 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RLoyaltyCardCompany] ADD CONSTRAINT [DF__RLoyaltyCa__Guid__04F1402B] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RLoyaltyCardCompany] ADD CONSTRAINT [DF__RLoyaltyCardCompany__Password__DefaultValue] DEFAULT ('')FOR [Password]
GO
ALTER TABLE [dbo].[RLoyaltyCardCompany] ADD CONSTRAINT [DF__RLoyaltyCardCompany__Issued__DefaultValue] DEFAULT (0)FOR [Issued]
GO
ALTER TABLE [dbo].[RLoyaltyCardCompany] ADD CONSTRAINT [DF_RLoyaltyCardCompany_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RLoyaltyCardCompany] ADD CONSTRAINT [DF_RLoyaltyCardCompany_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RLoyaltyCardCompany] ADD CONSTRAINT [DF_RLoyaltyCardCompany_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RLoyaltyCardCompany] ADD CONSTRAINT [DF_RLoyaltyCardCompany_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2061250398] ON [dbo].[RLoyaltyCardCompany]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RLoyaltyCardCompany] ADD CONSTRAINT [PK__RLoyaltyCardComp__03FD1BF2] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RLoyaltyCardCompany] WITH NOCHECK ADD CONSTRAINT [FK__RLoyaltyCardCompany__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RLoyaltyCardCompany] WITH NOCHECK ADD CONSTRAINT [FK__RLoyaltyCardCompany__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RLoyaltyCardCompany] WITH NOCHECK ADD CONSTRAINT [FK__RLoyaltyCardCompany__R1LoyaltyCardId] FOREIGN KEY ([R1LoyaltyCardId]) REFERENCES [dbo].[OLoyaltyCard] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RLoyaltyCardCompany] WITH NOCHECK ADD CONSTRAINT [FK__RLoyaltyCardCompany__R2CompanyId] FOREIGN KEY ([R2CompanyId]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RLoyaltyCardCompany] WITH NOCHECK ADD CONSTRAINT [FK__RLoyaltyCardCompany__TypeId] FOREIGN KEY ([TypeId]) REFERENCES [dbo].[LLoyaltyCardCompanyType] ([Id]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RLoyaltyCardCompany] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RLoyaltyCardProduct] (
	[ID]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[GUID]					[uniqueidentifier]	 NULL,
	[R1LoyaltyCardId]		[bigint]			 NOT NULL,
	[R2ProductId]			[bigint]			 NOT NULL,
	[SerialNumber]			[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[CreatedOn]				[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RLoyaltyCardProduct] ADD CONSTRAINT [DF__RLoyaltyCa__GUID__2D38662C] DEFAULT (newid())FOR [GUID]
GO
ALTER TABLE [dbo].[RLoyaltyCardProduct] ADD CONSTRAINT [DF__RLoyaltyC__REPLI__2E2C8A65] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RLoyaltyCardProduct] ADD CONSTRAINT [DF_RLoyaltyCardProduct_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RLoyaltyCardProduct] ADD CONSTRAINT [DF_RLoyaltyCardProduct_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RLoyaltyCardProduct] ADD CONSTRAINT [DF_RLoyaltyCardProduct_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_726670778] ON [dbo].[RLoyaltyCardProduct]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RLoyaltyCardProduct] ADD CONSTRAINT [PK__RLoyaltyCardProd__2C4441F3] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RLoyaltyCardProduct] WITH NOCHECK ADD CONSTRAINT [FK_RLoyaltyCardProduct_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RLoyaltyCardProduct] WITH NOCHECK ADD CONSTRAINT [FK_RLoyaltyCardProduct_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RLoyaltyCardProduct] WITH NOCHECK ADD CONSTRAINT [FK_RLoyaltyCardProduct_R1CommunicationID] FOREIGN KEY ([R1LoyaltyCardId]) REFERENCES [dbo].[OLoyaltyCard] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RLoyaltyCardProduct] WITH NOCHECK ADD CONSTRAINT [FK_RLoyaltyCardProduct_R2CompanyID] FOREIGN KEY ([R2ProductId]) REFERENCES [dbo].[OProduct] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RLoyaltyCardProduct] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RMailingListReceiver] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1MailingListId]		[bigint]			 NOT NULL,
	[R2EmailId]				[bigint]			 NOT NULL,
	[MailFormat]			[int]				 NOT NULL,
	[SubscriptionStatus]	[int]				 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RMailingListReceiver] ADD CONSTRAINT [DF__RMailingLi__Guid__1764F621] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RMailingListReceiver] ADD CONSTRAINT [DF__RMailingListReceiver__MailFormat__DefaultValue] DEFAULT (0)FOR [MailFormat]
GO
ALTER TABLE [dbo].[RMailingListReceiver] ADD CONSTRAINT [DF__RMailingListReceiver__SubscriptionStatus__DefaultValue] DEFAULT (0)FOR [SubscriptionStatus]
GO
ALTER TABLE [dbo].[RMailingListReceiver] ADD CONSTRAINT [DF_RMailingListReceiver_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RMailingListReceiver] ADD CONSTRAINT [DF_RMailingListReceiver_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RMailingListReceiver] ADD CONSTRAINT [DF_RMailingListReceiver_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RMailingListReceiver] ADD CONSTRAINT [DF_RMailingListReceiver_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_73767320] ON [dbo].[RMailingListReceiver]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RMailingListReceiver] ADD CONSTRAINT [PK__RMailingListRece__1670D1E8] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RMailingListReceiver] WITH NOCHECK ADD CONSTRAINT [FK__RMailingListReceiver__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RMailingListReceiver] WITH NOCHECK ADD CONSTRAINT [FK__RMailingListReceiver__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[TMailingList] (
	[Id]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NULL,
	[Path]			[varchar](17)		 COLLATE Polish_CI_AS NOT NULL,
	[Parent]		[varchar](36)		 COLLATE Polish_CI_AS NULL,
	[Name]			[varchar](100)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[IsTest]		[bit]				 NOT NULL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TMailingList] ADD CONSTRAINT [DF__TMailingLi__Guid__035DFD74] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[TMailingList] ADD CONSTRAINT [DF__TMailingList__Path__DefaultValue] DEFAULT ('')FOR [Path]
GO
ALTER TABLE [dbo].[TMailingList] ADD CONSTRAINT [DF__TMailingList__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[TMailingList] ADD CONSTRAINT [DF_TMailingList_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[TMailingList] ADD CONSTRAINT [DF__TMailingList__IsTest__DefaultValue] DEFAULT (0)FOR [IsTest]
GO
ALTER TABLE [dbo].[TMailingList] ADD CONSTRAINT [DF_TMailingList_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[TMailingList] ADD CONSTRAINT [DF_TMailingList_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[TMailingList] ADD CONSTRAINT [DF_TMailingList_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_185767719] ON [dbo].[TMailingList]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TMailingList] ADD CONSTRAINT [PK__TMailingList__0269D93B] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[TMailingList] WITH NOCHECK ADD CONSTRAINT [FK__TMailingList__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[TMailingList] WITH NOCHECK ADD CONSTRAINT [FK__TMailingList__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RMailingListReceiver] WITH NOCHECK ADD CONSTRAINT [FK__RMailingListReceiver__R1MailingListId] FOREIGN KEY ([R1MailingListId]) REFERENCES [dbo].[TMailingList] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RMailingListReceiver] WITH NOCHECK ADD CONSTRAINT [FK__RMailingListReceiver__R2EmailId] FOREIGN KEY ([R2EmailId]) REFERENCES [dbo].[OEmail] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RMailingListSendItem] (
	[Id]							[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]							[uniqueidentifier]	 NOT NULL,
	[R1MailingListReceiverId]		[bigint]			 NOT NULL,
	[R2MailingId]					[bigint]			 NOT NULL,
	[TemplateId]					[bigint]			 NOT NULL,
	[SendDate]						[datetime]			 NOT NULL,
	[SendAttempsCount]				[smallint]			 NOT NULL,
	[Subject]						[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[Body]							[text]				 COLLATE Polish_CI_AS NULL,
	[EncodingId]					[bigint]			 NOT NULL,
	[From]							[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[SenderId]						[bigint]			 NOT NULL,
	[ModifiedOn]					[datetime]			 NULL,
	[CreatedOn]						[datetime]			 NULL,
	[ModifiedBy]					[bigint]			 NULL,
	[CreatedBy]						[bigint]			 NULL,
	[Status]						[int]				 NOT NULL,
	[REPLID]						[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[HeaderId]						[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[To]							[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[ReceivedDate]					[datetime]			 NULL,
	[SecR]							[bigint]			 NOT NULL,
	[SecW]							[bigint]			 NOT NULL,
	[SecD]							[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RMailingListSendItem] ADD CONSTRAINT [DF__RMailingLi__Guid__62FC1ADA] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RMailingListSendItem] ADD CONSTRAINT [DF__RMailingListSendItem__SendDate__DefaultValue] DEFAULT (getdate())FOR [SendDate]
GO
ALTER TABLE [dbo].[RMailingListSendItem] ADD CONSTRAINT [DF__RMailingListSendItem__SendAttempsCount__DefaultValue] DEFAULT (0)FOR [SendAttempsCount]
GO
ALTER TABLE [dbo].[RMailingListSendItem] ADD CONSTRAINT [DF__RMailingListSendItem__Subject__DefaultValue] DEFAULT ('')FOR [Subject]
GO
ALTER TABLE [dbo].[RMailingListSendItem] ADD CONSTRAINT [DF__RMailingListSendItem__From__DefaultValue] DEFAULT ('')FOR [From]
GO
ALTER TABLE [dbo].[RMailingListSendItem] ADD CONSTRAINT [DF__RMailingListSendItem__Status__DefaultValue] DEFAULT (0)FOR [Status]
GO
ALTER TABLE [dbo].[RMailingListSendItem] ADD CONSTRAINT [DF_RMailingListSendItem_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RMailingListSendItem] ADD CONSTRAINT [DF__RMailingListSendItem__HeaderId__DefaultValue] DEFAULT ('')FOR [HeaderId]
GO
ALTER TABLE [dbo].[RMailingListSendItem] ADD CONSTRAINT [DF__RMailingListSendItem__To__DefaultValue] DEFAULT ('')FOR [To]
GO
ALTER TABLE [dbo].[RMailingListSendItem] ADD CONSTRAINT [DF__RMailingListSendItem__ReceivedDate__DefaultValue] DEFAULT (getdate())FOR [ReceivedDate]
GO
ALTER TABLE [dbo].[RMailingListSendItem] ADD CONSTRAINT [DF_RMailingListSendItem_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RMailingListSendItem] ADD CONSTRAINT [DF_RMailingListSendItem_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RMailingListSendItem] ADD CONSTRAINT [DF_RMailingListSendItem_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_329768232] ON [dbo].[RMailingListSendItem]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RMailingListSendItem] ADD CONSTRAINT [PK__RMailingListSend__6207F6A1] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RMailingListSendItem] WITH NOCHECK ADD CONSTRAINT [FK__RMailingListSendItem__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RMailingListSendItem] WITH NOCHECK ADD CONSTRAINT [FK__RMailingListSendItem__EncodingId] FOREIGN KEY ([EncodingId]) REFERENCES [dbo].[LEncoding] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RMailingListSendItem] WITH NOCHECK ADD CONSTRAINT [FK__RMailingListSendItem__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RMailingListSendItem] WITH NOCHECK ADD CONSTRAINT [FK__RMailingListSendItem__R1MailingListReceiverId] FOREIGN KEY ([R1MailingListReceiverId]) REFERENCES [dbo].[RMailingListReceiver] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RMailingListSendItem] WITH NOCHECK ADD CONSTRAINT [FK__RMailingListSendItem__R2MailingId] FOREIGN KEY ([R2MailingId]) REFERENCES [dbo].[OMailing] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RMailingListSendItem] WITH NOCHECK ADD CONSTRAINT [FK__RMailingListSendItem__SenderId] FOREIGN KEY ([SenderId]) REFERENCES [dbo].[LMailingSender] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RMailingListSendItem] WITH NOCHECK ADD CONSTRAINT [FK__RMailingListSendItem__TemplateId] FOREIGN KEY ([TemplateId]) REFERENCES [dbo].[LTemplate] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RMailingListSendItemLink] (
	[Id]							[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]							[uniqueidentifier]	 NOT NULL,
	[R1MailingListSendItemId]		[bigint]			 NOT NULL,
	[R2LinkId]						[bigint]			 NOT NULL,
	[Name]							[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]					[datetime]			 NULL,
	[CreatedOn]						[datetime]			 NULL,
	[ModifiedBy]					[bigint]			 NULL,
	[CreatedBy]						[bigint]			 NULL,
	[REPLID]						[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]							[bigint]			 NOT NULL,
	[SecW]							[bigint]			 NOT NULL,
	[SecD]							[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RMailingListSendItemLink] ADD CONSTRAINT [DF__RMailingLi__Guid__008C7DC1] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RMailingListSendItemLink] ADD CONSTRAINT [DF__RMailingListSendItemLink__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[RMailingListSendItemLink] ADD CONSTRAINT [DF_RMailingListSendItemLink_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RMailingListSendItemLink] ADD CONSTRAINT [DF_RMailingListSendItemLink_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RMailingListSendItemLink] ADD CONSTRAINT [DF_RMailingListSendItemLink_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RMailingListSendItemLink] ADD CONSTRAINT [DF_RMailingListSendItemLink_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_585769144] ON [dbo].[RMailingListSendItemLink]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RMailingListSendItemLink] ADD CONSTRAINT [PK__RMailingListSend__7F985988] PRIMARY KEY CLUSTERED ([Id])
GO
CREATE TABLE [dbo].[RMailingMailingList] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1MailingId]			[bigint]			 NOT NULL,
	[R2MailingListId]		[bigint]			 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RMailingMailingList] ADD CONSTRAINT [DF__RMailingMa__Guid__5E3765BD] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RMailingMailingList] ADD CONSTRAINT [DF_RMailingMailingList_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RMailingMailingList] ADD CONSTRAINT [DF_RMailingMailingList_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RMailingMailingList] ADD CONSTRAINT [DF_RMailingMailingList_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RMailingMailingList] ADD CONSTRAINT [DF_RMailingMailingList_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_729769657] ON [dbo].[RMailingMailingList]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RMailingMailingList] ADD CONSTRAINT [PK__RMailingMailingL__5D434184] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RMailingMailingList] WITH NOCHECK ADD CONSTRAINT [FK__RMailingMailingList__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RMailingMailingList] WITH NOCHECK ADD CONSTRAINT [FK__RMailingMailingList__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RMailingMailingList] WITH NOCHECK ADD CONSTRAINT [FK__RMailingMailingList__R1MailingId] FOREIGN KEY ([R1MailingId]) REFERENCES [dbo].[OMailing] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RMailingMailingList] WITH NOCHECK ADD CONSTRAINT [FK__RMailingMailingList__R2MailingListId] FOREIGN KEY ([R2MailingListId]) REFERENCES [dbo].[TMailingList] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RNoteArticle] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1NoteId]			[bigint]			 NOT NULL,
	[R2ArticleId]		[bigint]			 NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RNoteArticle] ADD CONSTRAINT [DF__RNoteArtic__Guid__717F71F6] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RNoteArticle] ADD CONSTRAINT [DF__RNoteArti__REPLI__76442713] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RNoteArticle] ADD CONSTRAINT [DF_RNoteArticle_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RNoteArticle] ADD CONSTRAINT [DF_RNoteArticle_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RNoteArticle] ADD CONSTRAINT [DF_RNoteArticle_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1872177540] ON [dbo].[RNoteArticle]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RNoteArticle] ADD CONSTRAINT [PK__RNoteArticle__708B4DBD] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RNoteArticle] WITH NOCHECK ADD CONSTRAINT [FK__RNoteArticle__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteArticle] WITH NOCHECK ADD CONSTRAINT [FK__RNoteArticle__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteArticle] WITH NOCHECK ADD CONSTRAINT [FK__RNoteArticle__R1NoteId] FOREIGN KEY ([R1NoteId]) REFERENCES [dbo].[ONote] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteArticle] WITH NOCHECK ADD CONSTRAINT [FK__RNoteArticle__R2ArticleId] FOREIGN KEY ([R2ArticleId]) REFERENCES [dbo].[OArticle] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RNoteCompany] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1NoteID]			[bigint]			 NOT NULL,
	[R2CompanyID]		[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RNoteCompany] ADD CONSTRAINT [DF__RNoteComp__GuidI__2261A781] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RNoteCompany] ADD CONSTRAINT [DF_RNoteCompany_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RNoteCompany] ADD CONSTRAINT [DF_RNoteCompany_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RNoteCompany] ADD CONSTRAINT [DF_RNoteCompany_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RNoteCompany] ADD CONSTRAINT [DF_RNoteCompany_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_841770056] ON [dbo].[RNoteCompany]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RNoteCompany] ADD CONSTRAINT [PK__RNoteCompany__216D8348] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RNoteCompany] WITH NOCHECK ADD CONSTRAINT [FK__RNoteCompany__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteCompany] WITH NOCHECK ADD CONSTRAINT [FK__RNoteCompany__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteCompany] WITH NOCHECK ADD CONSTRAINT [FK__RNoteCompany__R1NoteID] FOREIGN KEY ([R1NoteID]) REFERENCES [dbo].[ONote] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteCompany] WITH NOCHECK ADD CONSTRAINT [FK__RNoteCompany__R2CompanyID] FOREIGN KEY ([R2CompanyID]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RNoteCompany] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RNoteCompanyPerson] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1NoteId]				[bigint]			 NOT NULL,
	[R2CompanyPersonId]		[bigint]			 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RNoteCompanyPerson] ADD CONSTRAINT [DF__RNoteCompa__Guid__2DF4EC6C] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RNoteCompanyPerson] ADD CONSTRAINT [DF_RNoteCompanyPerson_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RNoteCompanyPerson] ADD CONSTRAINT [DF_RNoteCompanyPerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RNoteCompanyPerson] ADD CONSTRAINT [DF_RNoteCompanyPerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RNoteCompanyPerson] ADD CONSTRAINT [DF_RNoteCompanyPerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_953770455] ON [dbo].[RNoteCompanyPerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RNoteCompanyPerson] ADD CONSTRAINT [PK__RNoteCompanyPers__2D00C833] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RNoteCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RNoteCompanyPerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RNoteCompanyPerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RNoteCompanyPerson__R1NoteId] FOREIGN KEY ([R1NoteId]) REFERENCES [dbo].[ONote] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RNoteCompanyPerson__R2CompanyPersonId] FOREIGN KEY ([R2CompanyPersonId]) REFERENCES [dbo].[RCompanyPerson] ([ID]) NOT FOR REPLICATION
GO
GRANT INSERT ON [dbo].[RNoteCompanyPerson] TO [RaportyWEB]
GO
GRANT SELECT ON [dbo].[RNoteCompanyPerson] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RNoteLink] (
	[ID]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NOT NULL,
	[R1NoteID]		[bigint]			 NOT NULL,
	[R2LinkID]		[bigint]			 NOT NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RNoteLink] ADD CONSTRAINT [DF__RNoteLink__GuidI__5304DEDC] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RNoteLink] ADD CONSTRAINT [DF_RNoteLink_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RNoteLink] ADD CONSTRAINT [DF_RNoteLink_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RNoteLink] ADD CONSTRAINT [DF_RNoteLink_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RNoteLink] ADD CONSTRAINT [DF_RNoteLink_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1065770854] ON [dbo].[RNoteLink]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RNoteLink] ADD CONSTRAINT [PK__RNoteLink__5210BAA3] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RNoteLink] WITH NOCHECK ADD CONSTRAINT [FK__RNoteLink__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteLink] WITH NOCHECK ADD CONSTRAINT [FK__RNoteLink__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteLink] WITH NOCHECK ADD CONSTRAINT [FK__RNoteLink__R1NoteID] FOREIGN KEY ([R1NoteID]) REFERENCES [dbo].[ONote] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteLink] WITH NOCHECK ADD CONSTRAINT [FK__RNoteLink__R2LinkID] FOREIGN KEY ([R2LinkID]) REFERENCES [dbo].[OLink] ([ID]) NOT FOR REPLICATION
GO
GRANT INSERT ON [dbo].[RNoteLink] TO [RaportyWEB]
GO
GRANT SELECT ON [dbo].[RNoteLink] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RNotePerson] (
	[ID]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NOT NULL,
	[R1NoteID]		[bigint]			 NOT NULL,
	[R2PersonID]	[bigint]			 NOT NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RNotePerson] ADD CONSTRAINT [DF__RNotePers__GuidI__27265C9E] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RNotePerson] ADD CONSTRAINT [DF_RNotePerson_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RNotePerson] ADD CONSTRAINT [DF_RNotePerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RNotePerson] ADD CONSTRAINT [DF_RNotePerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RNotePerson] ADD CONSTRAINT [DF_RNotePerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1177771253] ON [dbo].[RNotePerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RNotePerson] ADD CONSTRAINT [PK__RNotePerson__26323865] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RNotePerson] WITH NOCHECK ADD CONSTRAINT [FK__RNotePerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNotePerson] WITH NOCHECK ADD CONSTRAINT [FK__RNotePerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNotePerson] WITH NOCHECK ADD CONSTRAINT [FK__RNotePerson__R1NoteID] FOREIGN KEY ([R1NoteID]) REFERENCES [dbo].[ONote] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNotePerson] WITH NOCHECK ADD CONSTRAINT [FK__RNotePerson__R2PersonID] FOREIGN KEY ([R2PersonID]) REFERENCES [dbo].[OPerson] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RNotePerson] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RNoteProduct] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1NoteId]			[bigint]			 NOT NULL,
	[R2ProductId]		[bigint]			 NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RNoteProduct] ADD CONSTRAINT [DF__RNoteProdu__Guid__792093BE] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RNoteProduct] ADD CONSTRAINT [DF__RNoteProd__REPLI__7DE548DB] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RNoteProduct] ADD CONSTRAINT [DF_RNoteProduct_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RNoteProduct] ADD CONSTRAINT [DF_RNoteProduct_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RNoteProduct] ADD CONSTRAINT [DF_RNoteProduct_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2000177996] ON [dbo].[RNoteProduct]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RNoteProduct] ADD CONSTRAINT [PK__RNoteProduct__782C6F85] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RNoteProduct] WITH NOCHECK ADD CONSTRAINT [FK__RNoteProduct__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteProduct] WITH NOCHECK ADD CONSTRAINT [FK__RNoteProduct__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteProduct] WITH NOCHECK ADD CONSTRAINT [FK__RNoteProduct__R1NoteId] FOREIGN KEY ([R1NoteId]) REFERENCES [dbo].[ONote] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteProduct] WITH NOCHECK ADD CONSTRAINT [FK__RNoteProduct__R2ProductId] FOREIGN KEY ([R2ProductId]) REFERENCES [dbo].[OProduct] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RNoteProductHierarchy] (
	[Id]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NOT NULL,
	[R1NoteId]					[bigint]			 NOT NULL,
	[R2ProductHierarchyId]		[bigint]			 NOT NULL,
	[CreatedOn]					[datetime]			 NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RNoteProductHierarchy] ADD CONSTRAINT [DF__RNoteProdu__Guid__00C1B586] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RNoteProductHierarchy] ADD CONSTRAINT [DF__RNoteProd__REPLI__05866AA3] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RNoteProductHierarchy] ADD CONSTRAINT [DF_RNoteProductHierarchy_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RNoteProductHierarchy] ADD CONSTRAINT [DF_RNoteProductHierarchy_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RNoteProductHierarchy] ADD CONSTRAINT [DF_RNoteProductHierarchy_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2128178452] ON [dbo].[RNoteProductHierarchy]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RNoteProductHierarchy] ADD CONSTRAINT [PK__RNoteProductHier__7FCD914D] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RNoteProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__RNoteProductHierarchy__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__RNoteProductHierarchy__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__RNoteProductHierarchy__R1NoteId] FOREIGN KEY ([R1NoteId]) REFERENCES [dbo].[ONote] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__RNoteProductHierarchy__R2ProductHierarchyId] FOREIGN KEY ([R2ProductHierarchyId]) REFERENCES [dbo].[TProductHierarchy] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RNoteProjectItem] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1NoteId]				[bigint]			 NOT NULL,
	[R2ProjectItemId]		[bigint]			 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RNoteProjectItem] ADD CONSTRAINT [DF__RNoteProje__Guid__22EC82BD] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RNoteProjectItem] ADD CONSTRAINT [DF_RNoteProjectItem_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RNoteProjectItem] ADD CONSTRAINT [DF_RNoteProjectItem_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RNoteProjectItem] ADD CONSTRAINT [DF_RNoteProjectItem_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RNoteProjectItem] ADD CONSTRAINT [DF_RNoteProjectItem_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1289771652] ON [dbo].[RNoteProjectItem]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RNoteProjectItem] ADD CONSTRAINT [PK__RNoteProjectItem__21F85E84] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RNoteProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__RNoteProjectItem__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__RNoteProjectItem__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__RNoteProjectItem__R1NoteId] FOREIGN KEY ([R1NoteId]) REFERENCES [dbo].[ONote] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__RNoteProjectItem__R2ProjectItemId] FOREIGN KEY ([R2ProjectItemId]) REFERENCES [dbo].[OProjectItem] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RNoteResource] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1NoteId]			[bigint]			 NOT NULL,
	[R2ResourceId]		[bigint]			 NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RNoteResource] ADD CONSTRAINT [DF__RNoteResou__Guid__2BD501D2] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RNoteResource] ADD CONSTRAINT [DF_RNoteResource_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RNoteResource] ADD CONSTRAINT [DF_RNoteResource_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RNoteResource] ADD CONSTRAINT [DF_RNoteResource_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RNoteResource] ADD CONSTRAINT [DF_RNoteResource_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1743383513] ON [dbo].[RNoteResource]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RNoteResource] ADD CONSTRAINT [PK__RNoteResource__2AE0DD99] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RNoteResource] WITH NOCHECK ADD CONSTRAINT [FK__RNoteResource__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteResource] WITH NOCHECK ADD CONSTRAINT [FK__RNoteResource__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteResource] WITH NOCHECK ADD CONSTRAINT [FK__RNoteResource__R1NoteId] FOREIGN KEY ([R1NoteId]) REFERENCES [dbo].[ONote] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteResource] WITH NOCHECK ADD CONSTRAINT [FK__RNoteResource__R2ResourceId] FOREIGN KEY ([R2ResourceId]) REFERENCES [dbo].[OResource] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RNoteSale] (
	[Id]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NOT NULL,
	[R1NoteId]		[bigint]			 NOT NULL,
	[R2SaleId]		[bigint]			 NOT NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RNoteSale] ADD CONSTRAINT [DF__RNoteSale__Guid__0862D74E] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RNoteSale] ADD CONSTRAINT [DF__RNoteSale__REPLI__0D278C6B] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RNoteSale] ADD CONSTRAINT [DF_RNoteSale_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RNoteSale] ADD CONSTRAINT [DF_RNoteSale_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RNoteSale] ADD CONSTRAINT [DF_RNoteSale_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_108695260] ON [dbo].[RNoteSale]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RNoteSale] ADD CONSTRAINT [PK__RNoteSale__076EB315] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RNoteSale] WITH NOCHECK ADD CONSTRAINT [FK__RNoteSale__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteSale] WITH NOCHECK ADD CONSTRAINT [FK__RNoteSale__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteSale] WITH NOCHECK ADD CONSTRAINT [FK__RNoteSale__R1NoteId] FOREIGN KEY ([R1NoteId]) REFERENCES [dbo].[ONote] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteSale] WITH NOCHECK ADD CONSTRAINT [FK__RNoteSale__R2SaleId] FOREIGN KEY ([R2SaleId]) REFERENCES [dbo].[OSale] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RNoteSupportIssue] (
	[ID]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1NoteID]				[bigint]			 NOT NULL,
	[R2SupportIssueID]		[bigint]			 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RNoteSupportIssue] ADD CONSTRAINT [DF__RNoteSuppo__Guid__73C6B429] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RNoteSupportIssue] ADD CONSTRAINT [DF_RNoteSupportIssue_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RNoteSupportIssue] ADD CONSTRAINT [DF_RNoteSupportIssue_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RNoteSupportIssue] ADD CONSTRAINT [DF_RNoteSupportIssue_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RNoteSupportIssue] ADD CONSTRAINT [DF_RNoteSupportIssue_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1401772051] ON [dbo].[RNoteSupportIssue]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RNoteSupportIssue] ADD CONSTRAINT [PK__RNoteSupportIssu__72D28FF0] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RNoteSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK__RNoteSupportIssue__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK__RNoteSupportIssue__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK__RNoteSupportIssue__R1NoteID] FOREIGN KEY ([R1NoteID]) REFERENCES [dbo].[ONote] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RNoteSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK__RNoteSupportIssue__R2SupportIssueID] FOREIGN KEY ([R2SupportIssueID]) REFERENCES [dbo].[OSupportIssue] ([ID]) NOT FOR REPLICATION
GO
GRANT INSERT ON [dbo].[RNoteSupportIssue] TO [RaportyWEB]
GO
GRANT SELECT ON [dbo].[RNoteSupportIssue] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RPersonGraphic] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1PersonID]		[bigint]			 NOT NULL,
	[R2GraphicID]		[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPersonGraphic] ADD CONSTRAINT [DF__RPersonGr__GuidI__10780170] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RPersonGraphic] ADD CONSTRAINT [DF_RPersonGraphic_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RPersonGraphic] ADD CONSTRAINT [DF_RPersonGraphic_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RPersonGraphic] ADD CONSTRAINT [DF_RPersonGraphic_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RPersonGraphic] ADD CONSTRAINT [DF_RPersonGraphic_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1513772450] ON [dbo].[RPersonGraphic]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPersonGraphic] ADD CONSTRAINT [PK__RPersonGraphic__0F83DD37] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RPersonGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RPersonGraphic__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPersonGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RPersonGraphic__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPersonGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RPersonGraphic__R1PersonID] FOREIGN KEY ([R1PersonID]) REFERENCES [dbo].[OPerson] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPersonGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RPersonGraphic__R2GraphicID] FOREIGN KEY ([R2GraphicID]) REFERENCES [dbo].[OGraphic] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RPersonRootFolder] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1CompanyId]		[bigint]			 NOT NULL,
	[R2FolderId]		[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPersonRootFolder] ADD CONSTRAINT [DF__RPersonRoo__Guid__1554272B] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RPersonRootFolder] ADD CONSTRAINT [DF_RPersonRootFolder_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RPersonRootFolder] ADD CONSTRAINT [DF_RPersonRootFolder_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RPersonRootFolder] ADD CONSTRAINT [DF_RPersonRootFolder_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RPersonRootFolder] ADD CONSTRAINT [DF_RPersonRootFolder_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_199932034] ON [dbo].[RPersonRootFolder]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPersonRootFolder] ADD CONSTRAINT [PK__RPersonRootFolde__146002F2] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RPersonRootFolder] WITH NOCHECK ADD CONSTRAINT [FK__RPersonRootFolder__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPersonRootFolder] WITH NOCHECK ADD CONSTRAINT [FK__RPersonRootFolder__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPersonRootFolder] WITH NOCHECK ADD CONSTRAINT [FK__RPersonRootFolder__R1CompanyId] FOREIGN KEY ([R1CompanyId]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPersonRootFolder] WITH NOCHECK ADD CONSTRAINT [FK__RPersonRootFolder__R2FolderId] FOREIGN KEY ([R2FolderId]) REFERENCES [dbo].[LFolder] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RPersonSale] (
	[Id]			[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]			[uniqueidentifier]	 NOT NULL,
	[R1PersonId]	[bigint]			 NOT NULL,
	[R2SaleId]		[bigint]			 NOT NULL,
	[CreatedOn]		[datetime]			 NULL,
	[ModifiedOn]	[datetime]			 NULL,
	[CreatedBy]		[bigint]			 NULL,
	[ModifiedBy]	[bigint]			 NULL,
	[REPLID]		[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]			[bigint]			 NOT NULL,
	[SecW]			[bigint]			 NOT NULL,
	[SecD]			[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPersonSale] ADD CONSTRAINT [DF__RPersonSal__Guid__5206C69D] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RPersonSale] ADD CONSTRAINT [DF__RPersonSa__REPLI__56CB7BBA] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RPersonSale] ADD CONSTRAINT [DF_RPersonSale_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RPersonSale] ADD CONSTRAINT [DF_RPersonSale_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RPersonSale] ADD CONSTRAINT [DF_RPersonSale_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1344175659] ON [dbo].[RPersonSale]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPersonSale] ADD CONSTRAINT [PK__RPersonSale__5112A264] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RPersonSale] WITH NOCHECK ADD CONSTRAINT [FK__RPersonSale__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPersonSale] WITH NOCHECK ADD CONSTRAINT [FK__RPersonSale__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPersonSale] WITH NOCHECK ADD CONSTRAINT [FK__RPersonSale__R1PersonId] FOREIGN KEY ([R1PersonId]) REFERENCES [dbo].[OPerson] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPersonSale] WITH NOCHECK ADD CONSTRAINT [FK__RPersonSale__R2SaleId] FOREIGN KEY ([R2SaleId]) REFERENCES [dbo].[OSale] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RPersonShipmentAddress] (
	[ID]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[GUID]						[uniqueidentifier]	 NOT NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[R1PersonID]				[bigint]			 NOT NULL,
	[R2ShipmentAddressID]		[bigint]			 NOT NULL,
	[CreatedOn]					[datetime]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPersonShipmentAddress] ADD CONSTRAINT [DF_RPersonShipmentAddress_GUID] DEFAULT (newid())FOR [GUID]
GO
ALTER TABLE [dbo].[RPersonShipmentAddress] ADD CONSTRAINT [DF_RPersonShipmentAddress_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RPersonShipmentAddress] ADD CONSTRAINT [DF_RPersonShipmentAddress_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RPersonShipmentAddress] ADD CONSTRAINT [DF_RPersonShipmentAddress_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RPersonShipmentAddress] ADD CONSTRAINT [DF_RPersonShipmentAddress_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_690934379] ON [dbo].[RPersonShipmentAddress]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPersonShipmentAddress] ADD CONSTRAINT [PK_RPersonShipmentAddress] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RPersonShipmentAddress] WITH NOCHECK ADD CONSTRAINT [FK__RPersonShipmentAddress_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPersonShipmentAddress] WITH NOCHECK ADD CONSTRAINT [FK__RPersonShipmentAddress_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPersonShipmentAddress] WITH NOCHECK ADD CONSTRAINT [FK_RPersonShipmentAddress_OPerson] FOREIGN KEY ([R1PersonID]) REFERENCES [dbo].[OPerson] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPersonShipmentAddress] WITH NOCHECK ADD CONSTRAINT [FK_RPersonShipmentAddress_OShipmentAddress] FOREIGN KEY ([R2ShipmentAddressID]) REFERENCES [dbo].[OShipmentAddress] ([ID]) NOT FOR REPLICATION
GO
GRANT DELETE ON [dbo].[RPersonShipmentAddress] TO [BDKProgramyZewnetrzne]
GO
GRANT INSERT ON [dbo].[RPersonShipmentAddress] TO [BDKProgramyZewnetrzne]
GO
GRANT SELECT ON [dbo].[RPersonShipmentAddress] TO [BDKProgramyZewnetrzne]
GO
GRANT UPDATE ON [dbo].[RPersonShipmentAddress] TO [BDKProgramyZewnetrzne]
GO
CREATE TABLE [dbo].[RPhoneCompany] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1PhoneID]			[bigint]			 NOT NULL,
	[R2CompanyID]		[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[IsDefault]			[bit]				 NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPhoneCompany] ADD CONSTRAINT [DF__RPhoneCom__GuidI__3A6E3B3C] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RPhoneCompany] ADD CONSTRAINT [DF_RPhoneCompany_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RPhoneCompany] ADD CONSTRAINT [DF__RPhoneCompany__IsDefault__DefaultValue] DEFAULT (0)FOR [IsDefault]
GO
ALTER TABLE [dbo].[RPhoneCompany] ADD CONSTRAINT [DF__RPhoneCompany__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RPhoneCompany] ADD CONSTRAINT [DF_RPhoneCompany_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RPhoneCompany] ADD CONSTRAINT [DF_RPhoneCompany_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RPhoneCompany] ADD CONSTRAINT [DF_RPhoneCompany_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1625772849] ON [dbo].[RPhoneCompany]([REPLID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [index_RPhoneCompany_K4_K10_K3] ON [dbo].[RPhoneCompany]([R2CompanyID], [IsDefault], [R1PhoneID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPhoneCompany] ADD CONSTRAINT [PK__RPhoneCompany__397A1703] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RPhoneCompany] WITH NOCHECK ADD CONSTRAINT [FK__RPhoneCompany__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPhoneCompany] WITH NOCHECK ADD CONSTRAINT [FK__RPhoneCompany__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPhoneCompany] WITH NOCHECK ADD CONSTRAINT [FK__RPhoneCompany__R1PhoneID] FOREIGN KEY ([R1PhoneID]) REFERENCES [dbo].[OPhone] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPhoneCompany] WITH NOCHECK ADD CONSTRAINT [FK__RPhoneCompany__R2CompanyID] FOREIGN KEY ([R2CompanyID]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RPhoneCompany] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RPhoneCompanyPerson] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1PhoneId]				[bigint]			 NOT NULL,
	[R2CompanyPersonId]		[bigint]			 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[IsDefault]				[bit]				 NOT NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPhoneCompanyPerson] ADD CONSTRAINT [DF__RPhoneComp__Guid__32B9A189] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RPhoneCompanyPerson] ADD CONSTRAINT [DF_RPhoneCompanyPerson_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RPhoneCompanyPerson] ADD CONSTRAINT [DF__RPhoneCompanyPerson__IsDefault__DefaultValue] DEFAULT (0)FOR [IsDefault]
GO
ALTER TABLE [dbo].[RPhoneCompanyPerson] ADD CONSTRAINT [DF__RPhoneCompanyPerson__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RPhoneCompanyPerson] ADD CONSTRAINT [DF_RPhoneCompanyPerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RPhoneCompanyPerson] ADD CONSTRAINT [DF_RPhoneCompanyPerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RPhoneCompanyPerson] ADD CONSTRAINT [DF_RPhoneCompanyPerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1737773248] ON [dbo].[RPhoneCompanyPerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPhoneCompanyPerson] ADD CONSTRAINT [PK__RPhoneCompanyPer__31C57D50] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RPhoneCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RPhoneCompanyPerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPhoneCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RPhoneCompanyPerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPhoneCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RPhoneCompanyPerson__R1PhoneId] FOREIGN KEY ([R1PhoneId]) REFERENCES [dbo].[OPhone] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPhoneCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RPhoneCompanyPerson__R2CompanyPersonId] FOREIGN KEY ([R2CompanyPersonId]) REFERENCES [dbo].[RCompanyPerson] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RPhoneCompanyPerson] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RPhonePerson] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1PhoneID]			[bigint]			 NOT NULL,
	[R2PersonID]		[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[IsDefault]			[bit]				 NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPhonePerson] ADD CONSTRAINT [DF__RPhonePer__GuidI__35A9861F] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RPhonePerson] ADD CONSTRAINT [DF_RPhonePerson_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RPhonePerson] ADD CONSTRAINT [DF__RPhonePerson__IsDefault__DefaultValue] DEFAULT (0)FOR [IsDefault]
GO
ALTER TABLE [dbo].[RPhonePerson] ADD CONSTRAINT [DF__RPhonePerson__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RPhonePerson] ADD CONSTRAINT [DF_RPhonePerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RPhonePerson] ADD CONSTRAINT [DF_RPhonePerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RPhonePerson] ADD CONSTRAINT [DF_RPhonePerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1849773647] ON [dbo].[RPhonePerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPhonePerson] ADD CONSTRAINT [PK__RPhonePerson__34B561E6] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RPhonePerson] WITH NOCHECK ADD CONSTRAINT [FK__RPhonePerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPhonePerson] WITH NOCHECK ADD CONSTRAINT [FK__RPhonePerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPhonePerson] WITH NOCHECK ADD CONSTRAINT [FK__RPhonePerson__R1PhoneID] FOREIGN KEY ([R1PhoneID]) REFERENCES [dbo].[OPhone] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPhonePerson] WITH NOCHECK ADD CONSTRAINT [FK__RPhonePerson__R2PersonID] FOREIGN KEY ([R2PersonID]) REFERENCES [dbo].[OPerson] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RPhonePerson] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RPhonePrefixCompany] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1PhonePrefixId]		[bigint]			 NOT NULL,
	[R2CompanyId]			[bigint]			 NOT NULL,
	[Prefix]				[varchar](30)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPhonePrefixCompany] ADD CONSTRAINT [DF__RPhonePref__Guid__01B5AC24] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RPhonePrefixCompany] ADD CONSTRAINT [DF__RPhonePrefixCompany__Prefix__DefaultValue] DEFAULT ('')FOR [Prefix]
GO
ALTER TABLE [dbo].[RPhonePrefixCompany] ADD CONSTRAINT [DF_RPhonePrefixCompany_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RPhonePrefixCompany] ADD CONSTRAINT [DF_RPhonePrefixCompany_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RPhonePrefixCompany] ADD CONSTRAINT [DF_RPhonePrefixCompany_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RPhonePrefixCompany] ADD CONSTRAINT [DF_RPhonePrefixCompany_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1961774046] ON [dbo].[RPhonePrefixCompany]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPhonePrefixCompany] ADD CONSTRAINT [PK__RPhonePrefixComp__00C187EB] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RPhonePrefixCompany] WITH NOCHECK ADD CONSTRAINT [FK__RPhonePrefixCompany__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPhonePrefixCompany] WITH NOCHECK ADD CONSTRAINT [FK__RPhonePrefixCompany__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPhonePrefixCompany] WITH NOCHECK ADD CONSTRAINT [FK__RPhonePrefixCompany__R1PhonePrefixId] FOREIGN KEY ([R1PhonePrefixId]) REFERENCES [dbo].[LPhonePrefix] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPhonePrefixCompany] WITH NOCHECK ADD CONSTRAINT [FK__RPhonePrefixCompany__R2CompanyId] FOREIGN KEY ([R2CompanyId]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RPhoneProviderCompany] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1PhoneProviderId]		[bigint]			 NOT NULL,
	[R2CompanyId]			[bigint]			 NOT NULL,
	[Prefix]				[varchar](50)		 COLLATE Polish_CI_AS NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPhoneProviderCompany] ADD CONSTRAINT [DF__RPhoneProv__Guid__067A6141] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RPhoneProviderCompany] ADD CONSTRAINT [DF__RPhoneProviderCompany__Prefix__DefaultValue] DEFAULT ('')FOR [Prefix]
GO
ALTER TABLE [dbo].[RPhoneProviderCompany] ADD CONSTRAINT [DF_RPhoneProviderCompany_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RPhoneProviderCompany] ADD CONSTRAINT [DF_RPhoneProviderCompany_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RPhoneProviderCompany] ADD CONSTRAINT [DF_RPhoneProviderCompany_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RPhoneProviderCompany] ADD CONSTRAINT [DF_RPhoneProviderCompany_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2089774502] ON [dbo].[RPhoneProviderCompany]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPhoneProviderCompany] ADD CONSTRAINT [PK__RPhoneProviderCo__05863D08] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RPhoneProviderCompany] WITH NOCHECK ADD CONSTRAINT [FK__RPhoneProviderCompany__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPhoneProviderCompany] WITH NOCHECK ADD CONSTRAINT [FK__RPhoneProviderCompany__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPhoneProviderCompany] WITH NOCHECK ADD CONSTRAINT [FK__RPhoneProviderCompany__R1PhoneProviderId] FOREIGN KEY ([R1PhoneProviderId]) REFERENCES [dbo].[LPhoneProvider] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPhoneProviderCompany] WITH NOCHECK ADD CONSTRAINT [FK__RPhoneProviderCompany__R2CompanyId] FOREIGN KEY ([R2CompanyId]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RPhoneTypeCompany] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1PhoneTypeId]		[bigint]			 NOT NULL,
	[R2CompanyId]		[bigint]			 NOT NULL,
	[NumberFormat]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPhoneTypeCompany] ADD CONSTRAINT [DF__RPhoneType__Guid__77381DB1] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RPhoneTypeCompany] ADD CONSTRAINT [DF__RPhoneTypeCompany__NumberFormat__DefaultValue] DEFAULT ('')FOR [NumberFormat]
GO
ALTER TABLE [dbo].[RPhoneTypeCompany] ADD CONSTRAINT [DF_RPhoneTypeCompany_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RPhoneTypeCompany] ADD CONSTRAINT [DF_RPhoneTypeCompany_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RPhoneTypeCompany] ADD CONSTRAINT [DF_RPhoneTypeCompany_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RPhoneTypeCompany] ADD CONSTRAINT [DF_RPhoneTypeCompany_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_70291310] ON [dbo].[RPhoneTypeCompany]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPhoneTypeCompany] ADD CONSTRAINT [PK__RPhoneTypeCompan__7643F978] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RPhoneTypeCompany] WITH NOCHECK ADD CONSTRAINT [FK__RPhoneTypeCompany__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPhoneTypeCompany] WITH NOCHECK ADD CONSTRAINT [FK__RPhoneTypeCompany__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPhoneTypeCompany] WITH NOCHECK ADD CONSTRAINT [FK__RPhoneTypeCompany__R1PhoneTypeId] FOREIGN KEY ([R1PhoneTypeId]) REFERENCES [dbo].[LPhoneType] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RPhoneTypeCompany] WITH NOCHECK ADD CONSTRAINT [FK__RPhoneTypeCompany__R2CompanyId] FOREIGN KEY ([R2CompanyId]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RProductGraphic] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1ProductId]		[bigint]			 NOT NULL,
	[R2GraphicId]		[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProductGraphic] ADD CONSTRAINT [DF__RProductGr__Guid__76390C80] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RProductGraphic] ADD CONSTRAINT [DF_RProductGraphic_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RProductGraphic] ADD CONSTRAINT [DF_RProductGraphic_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RProductGraphic] ADD CONSTRAINT [DF_RProductGraphic_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RProductGraphic] ADD CONSTRAINT [DF_RProductGraphic_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_198291766] ON [dbo].[RProductGraphic]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProductGraphic] ADD CONSTRAINT [PK__RProductGraphic__7544E847] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RProductGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RProductGraphic__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProductGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RProductGraphic__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProductGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RProductGraphic__R1ProductId] FOREIGN KEY ([R1ProductId]) REFERENCES [dbo].[OProduct] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProductGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RProductGraphic__R2GraphicId] FOREIGN KEY ([R2GraphicId]) REFERENCES [dbo].[OGraphic] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RProductHierarchyGraphic] (
	[Id]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NOT NULL,
	[R1ProductHierarchyId]		[bigint]			 NOT NULL,
	[R2GraphicId]				[bigint]			 NOT NULL,
	[CreatedOn]					[datetime]			 NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProductHierarchyGraphic] ADD CONSTRAINT [DF__RProductHi__Guid__2FE91AC8] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RProductHierarchyGraphic] ADD CONSTRAINT [DF__RProductH__REPLI__34ADCFE5] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RProductHierarchyGraphic] ADD CONSTRAINT [DF_RProductHierarchyGraphic_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RProductHierarchyGraphic] ADD CONSTRAINT [DF_RProductHierarchyGraphic_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RProductHierarchyGraphic] ADD CONSTRAINT [DF_RProductHierarchyGraphic_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1027806694] ON [dbo].[RProductHierarchyGraphic]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProductHierarchyGraphic] ADD CONSTRAINT [PK__RProductHierarch__2EF4F68F] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RProductHierarchyGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RProductHierarchyGraphic__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProductHierarchyGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RProductHierarchyGraphic__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProductHierarchyGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RProductHierarchyGraphic__R1ProductHierarchyId] FOREIGN KEY ([R1ProductHierarchyId]) REFERENCES [dbo].[TProductHierarchy] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProductHierarchyGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RProductHierarchyGraphic__R2GraphicId] FOREIGN KEY ([R2GraphicId]) REFERENCES [dbo].[OGraphic] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RProductHierarchyLink] (
	[Id]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NOT NULL,
	[R1ProductHierarchyId]		[bigint]			 NOT NULL,
	[R2LinkId]					[bigint]			 NOT NULL,
	[Page]						[int]				 NOT NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[CreatedOn]					[datetime]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProductHierarchyLink] ADD CONSTRAINT [DF__RProductHi__Guid__6677A603] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RProductHierarchyLink] ADD CONSTRAINT [DF__RProductHierarchyLink__Page__DefaultValue] DEFAULT (0)FOR [Page]
GO
ALTER TABLE [dbo].[RProductHierarchyLink] ADD CONSTRAINT [DF_RProductHierarchyLink_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RProductHierarchyLink] ADD CONSTRAINT [DF_RProductHierarchyLink_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RProductHierarchyLink] ADD CONSTRAINT [DF_RProductHierarchyLink_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RProductHierarchyLink] ADD CONSTRAINT [DF_RProductHierarchyLink_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_310292165] ON [dbo].[RProductHierarchyLink]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProductHierarchyLink] ADD CONSTRAINT [PK__RProductHierarch__658381CA] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RProductHierarchyLink] WITH NOCHECK ADD CONSTRAINT [FK__RProductHierarchyLink__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProductHierarchyLink] WITH NOCHECK ADD CONSTRAINT [FK__RProductHierarchyLink__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProductHierarchyLink] WITH NOCHECK ADD CONSTRAINT [FK__RProductHierarchyLink__R1ProductHierarchyId] FOREIGN KEY ([R1ProductHierarchyId]) REFERENCES [dbo].[TProductHierarchy] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProductHierarchyLink] WITH NOCHECK ADD CONSTRAINT [FK__RProductHierarchyLink__R2LinkId] FOREIGN KEY ([R2LinkId]) REFERENCES [dbo].[OLink] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RProductHierarchyLink] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RProductHierarchyProductHierarchy] (
	[Id]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NOT NULL,
	[R1ProductHierarchyId]		[bigint]			 NOT NULL,
	[R2ProductHierarchyId]		[bigint]			 NOT NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[CreatedOn]					[datetime]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProductHierarchyProductHierarchy] ADD CONSTRAINT [DF_RProductHierarchyProductHierarchy_Guid] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RProductHierarchyProductHierarchy] ADD CONSTRAINT [DF_RRProductHierarchyProductHierarchy_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RProductHierarchyProductHierarchy] ADD CONSTRAINT [DF_RProductHierarchyProductHierarchy_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RProductHierarchyProductHierarchy] ADD CONSTRAINT [DF_RProductHierarchyProductHierarchy_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RProductHierarchyProductHierarchy] ADD CONSTRAINT [DF_RProductHierarchyProductHierarchy_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2078551830] ON [dbo].[RProductHierarchyProductHierarchy]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProductHierarchyProductHierarchy] ADD CONSTRAINT [PK_RProductHierarchyProductHierarchy] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RProductHierarchyProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK_RProductHierarchyProductHierarchy_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProductHierarchyProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK_RProductHierarchyProductHierarchy_ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProductHierarchyProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK_RProductHierarchyProductHierarchy_R1ProductHierarchyId] FOREIGN KEY ([R1ProductHierarchyId]) REFERENCES [dbo].[TProductHierarchy] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProductHierarchyProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK_RProductHierarchyProductHierarchy_R2ProductHierarchyId] FOREIGN KEY ([R2ProductHierarchyId]) REFERENCES [dbo].[TProductHierarchy] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RProductHierarchyProductHierarchy] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RProductLink] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1ProductID]		[bigint]			 NOT NULL,
	[R2LinkID]			[bigint]			 NOT NULL,
	[Page]				[int]				 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProductLink] ADD CONSTRAINT [DF__RProductLi__Guid__7BD1EA45] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RProductLink] ADD CONSTRAINT [DF__RProductLink__Page__DefaultValue] DEFAULT (0)FOR [Page]
GO
ALTER TABLE [dbo].[RProductLink] ADD CONSTRAINT [DF_RProductLink_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RProductLink] ADD CONSTRAINT [DF_RProductLink_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RProductLink] ADD CONSTRAINT [DF_RProductLink_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RProductLink] ADD CONSTRAINT [DF_RProductLink_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_710293590] ON [dbo].[RProductLink]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProductLink] ADD CONSTRAINT [PK__RProductLink__7ADDC60C] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RProductLink] WITH NOCHECK ADD CONSTRAINT [FK__RProductLink__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProductLink] WITH NOCHECK ADD CONSTRAINT [FK__RProductLink__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProductLink] WITH NOCHECK ADD CONSTRAINT [FK__RProductLink__R1ProductID] FOREIGN KEY ([R1ProductID]) REFERENCES [dbo].[OProduct] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProductLink] WITH NOCHECK ADD CONSTRAINT [FK__RProductLink__R2LinkID] FOREIGN KEY ([R2LinkID]) REFERENCES [dbo].[OLink] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RProductLink] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RProductProduct] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1ProductId]		[bigint]			 NOT NULL,
	[R2ProductId]		[bigint]			 NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProductProduct] ADD CONSTRAINT [DF__RProductPr__Guid__1003F916] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RProductProduct] ADD CONSTRAINT [DF__RProductP__REPLI__14C8AE33] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RProductProduct] ADD CONSTRAINT [DF_RProductProduct_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RProductProduct] ADD CONSTRAINT [DF_RProductProduct_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RProductProduct] ADD CONSTRAINT [DF_RProductProduct_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_236695716] ON [dbo].[RProductProduct]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProductProduct] ADD CONSTRAINT [PK__RProductProduct__0F0FD4DD] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RProductProduct] WITH NOCHECK ADD CONSTRAINT [FK__RProductProduct__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProductProduct] WITH NOCHECK ADD CONSTRAINT [FK__RProductProduct__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProductProduct] WITH NOCHECK ADD CONSTRAINT [FK__RProductProduct__R1ProductId] FOREIGN KEY ([R1ProductId]) REFERENCES [dbo].[OProduct] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProductProduct] WITH NOCHECK ADD CONSTRAINT [FK__RProductProduct__R2ProductId] FOREIGN KEY ([R2ProductId]) REFERENCES [dbo].[OProduct] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RProductSale] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1ProductId]		[bigint]			 NOT NULL,
	[R2SaleId]			[bigint]			 NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProductSale] ADD CONSTRAINT [DF__RProductSa__Guid__59A7E865] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RProductSale] ADD CONSTRAINT [DF__RProductS__REPLI__5E6C9D82] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RProductSale] ADD CONSTRAINT [DF_RProductSale_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RProductSale] ADD CONSTRAINT [DF_RProductSale_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RProductSale] ADD CONSTRAINT [DF_RProductSale_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1472176115] ON [dbo].[RProductSale]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProductSale] ADD CONSTRAINT [PK__RProductSale__58B3C42C] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RProductSale] WITH NOCHECK ADD CONSTRAINT [FK__RProductSale__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProductSale] WITH NOCHECK ADD CONSTRAINT [FK__RProductSale__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProductSale] WITH NOCHECK ADD CONSTRAINT [FK__RProductSale__R1ProductId] FOREIGN KEY ([R1ProductId]) REFERENCES [dbo].[OProduct] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProductSale] WITH NOCHECK ADD CONSTRAINT [FK__RProductSale__R2SaleId] FOREIGN KEY ([R2SaleId]) REFERENCES [dbo].[OSale] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RProjectCategoryProjectItem] (
	[Id]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NOT NULL,
	[R1ProjectCategoryId]		[bigint]			 NOT NULL,
	[R2ProjectItemId]			[bigint]			 NOT NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[CreatedOn]					[datetime]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectCategoryProjectItem] ADD CONSTRAINT [DF__RProjectCa__Guid__0FD9AE49] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RProjectCategoryProjectItem] ADD CONSTRAINT [DF_RProjectCategoryProjectItem_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RProjectCategoryProjectItem] ADD CONSTRAINT [DF_RProjectCategoryProjectItem_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RProjectCategoryProjectItem] ADD CONSTRAINT [DF_RProjectCategoryProjectItem_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RProjectCategoryProjectItem] ADD CONSTRAINT [DF_RProjectCategoryProjectItem_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_854294103] ON [dbo].[RProjectCategoryProjectItem]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectCategoryProjectItem] ADD CONSTRAINT [PK__RProjectCategory__0EE58A10] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RProjectCategoryProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__RProjectCategoryProjectItem__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectCategoryProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__RProjectCategoryProjectItem__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[TProjectCategory] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[Path]				[varchar](109)		 COLLATE Polish_CI_AS NOT NULL,
	[Parent]			[varchar](36)		 COLLATE Polish_CI_AS NULL,
	[Name]				[varchar](100)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[Configuration]		[text]				 COLLATE Polish_CI_AS NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TProjectCategory] ADD CONSTRAINT [DF__TProjectCa__Guid__438E5C79] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[TProjectCategory] ADD CONSTRAINT [DF__TProjectCategory__Path__DefaultValue] DEFAULT ('')FOR [Path]
GO
ALTER TABLE [dbo].[TProjectCategory] ADD CONSTRAINT [DF__TProjectCategory__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[TProjectCategory] ADD CONSTRAINT [DF__TProjectCategory__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[TProjectCategory] ADD CONSTRAINT [DF_TProjectCategory_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[TProjectCategory] ADD CONSTRAINT [DF_TProjectCategory_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[TProjectCategory] ADD CONSTRAINT [DF_TProjectCategory_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[TProjectCategory] ADD CONSTRAINT [DF_TProjectCategory_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_934294388] ON [dbo].[TProjectCategory]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TProjectCategory] ADD CONSTRAINT [PK__TProjectCategory__429A3840] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[TProjectCategory] WITH NOCHECK ADD CONSTRAINT [FK__TProjectCategory__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[TProjectCategory] WITH NOCHECK ADD CONSTRAINT [FK__TProjectCategory__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectCategoryProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__RProjectCategoryProjectItem__R1ProjectCategoryId] FOREIGN KEY ([R1ProjectCategoryId]) REFERENCES [dbo].[TProjectCategory] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectCategoryProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__RProjectCategoryProjectItem__R2ProjectItemId] FOREIGN KEY ([R2ProjectItemId]) REFERENCES [dbo].[OProjectItem] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RProjectItemBonus] (
	[Id]							[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]							[uniqueidentifier]	 NOT NULL,
	[R1ProjectItemId]				[bigint]			 NOT NULL,
	[R2ProjectItemBonusTypeId]		[bigint]			 NOT NULL,
	[CreatedOn]						[datetime]			 NULL,
	[ModifiedOn]					[datetime]			 NULL,
	[CreatedBy]						[bigint]			 NULL,
	[ModifiedBy]					[bigint]			 NULL,
	[Value]							[real]				 NOT NULL,
	[ReferenceValue]				[money]				 NULL,
	[Description]					[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]						[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[ReductionRate]					[real]				 NOT NULL,
	[SecR]							[bigint]			 NOT NULL,
	[SecW]							[bigint]			 NOT NULL,
	[SecD]							[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemBonus] ADD CONSTRAINT [DF__RProjectIt__Guid__7C2AE484] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RProjectItemBonus] ADD CONSTRAINT [DF__RProjectItemBonus__Value__DefaultValue] DEFAULT (0)FOR [Value]
GO
ALTER TABLE [dbo].[RProjectItemBonus] ADD CONSTRAINT [DF__RProjectItemBonus__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RProjectItemBonus] ADD CONSTRAINT [DF__RProjectI__REPLI__02D7E213] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RProjectItemBonus] ADD CONSTRAINT [DF__RProjectItemBonus__ReductionRate__DefaultValue] DEFAULT (0)FOR [ReductionRate]
GO
ALTER TABLE [dbo].[RProjectItemBonus] ADD CONSTRAINT [DF_RProjectItemBonus_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RProjectItemBonus] ADD CONSTRAINT [DF_RProjectItemBonus_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RProjectItemBonus] ADD CONSTRAINT [DF_RProjectItemBonus_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2051185682] ON [dbo].[RProjectItemBonus]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemBonus] ADD CONSTRAINT [PK__RProjectItemBonu__7B36C04B] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RProjectItemBonus] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemBonus__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemBonus] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemBonus__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemBonus] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemBonus__R1ProjectItemId] FOREIGN KEY ([R1ProjectItemId]) REFERENCES [dbo].[OProjectItem] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemBonus] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemBonus__R2ProjectItemBonusTypeId] FOREIGN KEY ([R2ProjectItemBonusTypeId]) REFERENCES [dbo].[LProjectItemBonusType] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RProjectItemCompany] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1ProjectItemId]		[bigint]			 NOT NULL,
	[R2CompanyId]			[bigint]			 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[RoleId]				[bigint]			 NOT NULL,
	[R]						[smallint]			 NOT NULL,
	[A]						[smallint]			 NOT NULL,
	[E]						[smallint]			 NOT NULL,
	[W]						[smallint]			 NOT NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemCompany] ADD CONSTRAINT [DF__RProjectIt__Guid__33EDBCE4] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RProjectItemCompany] ADD CONSTRAINT [DF__RProjectItemCompany__R__DefaultValue] DEFAULT (0)FOR [R]
GO
ALTER TABLE [dbo].[RProjectItemCompany] ADD CONSTRAINT [DF__RProjectItemCompany__A__DefaultValue] DEFAULT (0)FOR [A]
GO
ALTER TABLE [dbo].[RProjectItemCompany] ADD CONSTRAINT [DF__RProjectItemCompany__E__DefaultValue] DEFAULT (0)FOR [E]
GO
ALTER TABLE [dbo].[RProjectItemCompany] ADD CONSTRAINT [DF__RProjectItemCompany__W__DefaultValue] DEFAULT (0)FOR [W]
GO
ALTER TABLE [dbo].[RProjectItemCompany] ADD CONSTRAINT [DF__RProjectItemCompany__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RProjectItemCompany] ADD CONSTRAINT [DF_RProjectItemCompany_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RProjectItemCompany] ADD CONSTRAINT [DF_RProjectItemCompany_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RProjectItemCompany] ADD CONSTRAINT [DF_RProjectItemCompany_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RProjectItemCompany] ADD CONSTRAINT [DF_RProjectItemCompany_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_439932889] ON [dbo].[RProjectItemCompany]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemCompany] ADD CONSTRAINT [PK__RProjectItemComp__32F998AB] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RProjectItemCompany] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemCompany__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemCompany] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemCompany__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemCompany] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemCompany__R1ProjectItemId] FOREIGN KEY ([R1ProjectItemId]) REFERENCES [dbo].[OProjectItem] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemCompany] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemCompany__R2CompanyId] FOREIGN KEY ([R2CompanyId]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemCompany] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemCompany__RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[LProjectItemRole] ([Id]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RProjectItemCompany] TO [formularze2]
GO
CREATE TABLE [dbo].[RProjectItemCompanyBonus] (
	[Id]							[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]							[uniqueidentifier]	 NOT NULL,
	[R1ProjectItemCompanyId]		[bigint]			 NOT NULL,
	[R2ProjectItemBonusTypeId]		[bigint]			 NOT NULL,
	[CreatedOn]						[datetime]			 NULL,
	[ModifiedOn]					[datetime]			 NULL,
	[CreatedBy]						[bigint]			 NULL,
	[ModifiedBy]					[bigint]			 NULL,
	[Value]							[real]				 NOT NULL,
	[Description]					[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[ReferenceValue]				[money]				 NULL,
	[REPLID]						[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]							[bigint]			 NOT NULL,
	[SecW]							[bigint]			 NOT NULL,
	[SecD]							[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemCompanyBonus] ADD CONSTRAINT [DF__RProjectIt__Guid__05B44EBE] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RProjectItemCompanyBonus] ADD CONSTRAINT [DF__RProjectItemCompanyBonus__Value__DefaultValue] DEFAULT (0)FOR [Value]
GO
ALTER TABLE [dbo].[RProjectItemCompanyBonus] ADD CONSTRAINT [DF__RProjectItemCompanyBonus__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RProjectItemCompanyBonus] ADD CONSTRAINT [DF__RProjectI__REPLI__0C614C4D] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RProjectItemCompanyBonus] ADD CONSTRAINT [DF_RProjectItemCompanyBonus_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RProjectItemCompanyBonus] ADD CONSTRAINT [DF_RProjectItemCompanyBonus_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RProjectItemCompanyBonus] ADD CONSTRAINT [DF_RProjectItemCompanyBonus_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_63702604] ON [dbo].[RProjectItemCompanyBonus]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemCompanyBonus] ADD CONSTRAINT [PK__RProjectItemComp__04C02A85] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RProjectItemCompanyBonus] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemCompanyBonus__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemCompanyBonus] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemCompanyBonus__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemCompanyBonus] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemCompanyBonus__R1ProjectItemCompanyId] FOREIGN KEY ([R1ProjectItemCompanyId]) REFERENCES [dbo].[RProjectItemCompany] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemCompanyBonus] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemCompanyBonus__R2ProjectItemBonusTypeId] FOREIGN KEY ([R2ProjectItemBonusTypeId]) REFERENCES [dbo].[LProjectItemBonusType] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RProjectItemCompanyPerson] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1ProjectItemId]		[bigint]			 NOT NULL,
	[R2CompanyPersonId]		[bigint]			 NOT NULL,
	[RoleId]				[bigint]			 NOT NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[R]						[smallint]			 NOT NULL,
	[A]						[smallint]			 NOT NULL,
	[E]						[smallint]			 NOT NULL,
	[W]						[smallint]			 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemCompanyPerson] ADD CONSTRAINT [DF__RProjectIt__Guid__1E27CDA0] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RProjectItemCompanyPerson] ADD CONSTRAINT [DF__RProjectItemCompanyPerson__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RProjectItemCompanyPerson] ADD CONSTRAINT [DF__RProjectItemCompanyPerson__R__DefaultValue] DEFAULT (0)FOR [R]
GO
ALTER TABLE [dbo].[RProjectItemCompanyPerson] ADD CONSTRAINT [DF__RProjectItemCompanyPerson__A__DefaultValue] DEFAULT (0)FOR [A]
GO
ALTER TABLE [dbo].[RProjectItemCompanyPerson] ADD CONSTRAINT [DF__RProjectItemCompanyPerson__E__DefaultValue] DEFAULT (0)FOR [E]
GO
ALTER TABLE [dbo].[RProjectItemCompanyPerson] ADD CONSTRAINT [DF__RProjectItemCompanyPerson__W__DefaultValue] DEFAULT (0)FOR [W]
GO
ALTER TABLE [dbo].[RProjectItemCompanyPerson] ADD CONSTRAINT [DF_RProjectItemCompanyPerson_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RProjectItemCompanyPerson] ADD CONSTRAINT [DF_RProjectItemCompanyPerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RProjectItemCompanyPerson] ADD CONSTRAINT [DF_RProjectItemCompanyPerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RProjectItemCompanyPerson] ADD CONSTRAINT [DF_RProjectItemCompanyPerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1094294958] ON [dbo].[RProjectItemCompanyPerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemCompanyPerson] ADD CONSTRAINT [PK__RProjectItemComp__1D33A967] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RProjectItemCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemCompanyPerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemCompanyPerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemCompanyPerson__R1ProjectItemId] FOREIGN KEY ([R1ProjectItemId]) REFERENCES [dbo].[OProjectItem] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemCompanyPerson__R2CompanyPersonId] FOREIGN KEY ([R2CompanyPersonId]) REFERENCES [dbo].[RCompanyPerson] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemCompanyPerson__RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[LProjectItemRole] ([Id]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RProjectItemCompanyPerson] TO [formularze2]
GO
CREATE TABLE [dbo].[RProjectItemCompanyPersonBonus] (
	[Id]								[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]								[uniqueidentifier]	 NOT NULL,
	[R1ProjectItemCompanyPersonId]		[bigint]			 NOT NULL,
	[R2ProjectItemBonusTypeId]			[bigint]			 NOT NULL,
	[CreatedOn]							[datetime]			 NULL,
	[ModifiedOn]						[datetime]			 NULL,
	[CreatedBy]							[bigint]			 NULL,
	[ModifiedBy]						[bigint]			 NULL,
	[Value]								[real]				 NOT NULL,
	[Description]						[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[ReferenceValue]					[money]				 NULL,
	[REPLID]							[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]								[bigint]			 NOT NULL,
	[SecW]								[bigint]			 NOT NULL,
	[SecD]								[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemCompanyPersonBonus] ADD CONSTRAINT [DF__RProjectIt__Guid__72A17A4A] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RProjectItemCompanyPersonBonus] ADD CONSTRAINT [DF__RProjectItemCompanyPersonBonus__Value__DefaultValue] DEFAULT (0)FOR [Value]
GO
ALTER TABLE [dbo].[RProjectItemCompanyPersonBonus] ADD CONSTRAINT [DF__RProjectItemCompanyPersonBonus__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RProjectItemCompanyPersonBonus] ADD CONSTRAINT [DF__RProjectI__REPLI__794E77D9] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RProjectItemCompanyPersonBonus] ADD CONSTRAINT [DF_RProjectItemCompanyPersonBonus_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RProjectItemCompanyPersonBonus] ADD CONSTRAINT [DF_RProjectItemCompanyPersonBonus_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RProjectItemCompanyPersonBonus] ADD CONSTRAINT [DF_RProjectItemCompanyPersonBonus_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1891185112] ON [dbo].[RProjectItemCompanyPersonBonus]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemCompanyPersonBonus] ADD CONSTRAINT [PK__RProjectItemComp__71AD5611] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RProjectItemCompanyPersonBonus] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemCompanyPersonBonus__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemCompanyPersonBonus] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemCompanyPersonBonus__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemCompanyPersonBonus] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemCompanyPersonBonus__R1ProjectItemCompanyPersonId] FOREIGN KEY ([R1ProjectItemCompanyPersonId]) REFERENCES [dbo].[RProjectItemCompanyPerson] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemCompanyPersonBonus] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemCompanyPersonBonus__R2ProjectItemBonusTypeId] FOREIGN KEY ([R2ProjectItemBonusTypeId]) REFERENCES [dbo].[LProjectItemBonusType] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RProjectItemCost] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1ProjectItemId]		[bigint]			 NOT NULL,
	[R2CostId]				[bigint]			 NOT NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemCost] ADD CONSTRAINT [DF__RProjectIt__Guid__6A0C3449] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RProjectItemCost] ADD CONSTRAINT [DF__RProjectItemCost__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RProjectItemCost] ADD CONSTRAINT [DF__RProjectI__REPLI__6FC50D9F] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RProjectItemCost] ADD CONSTRAINT [DF_RProjectItemCost_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RProjectItemCost] ADD CONSTRAINT [DF_RProjectItemCost_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RProjectItemCost] ADD CONSTRAINT [DF_RProjectItemCost_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1747184599] ON [dbo].[RProjectItemCost]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemCost] ADD CONSTRAINT [PK__RProjectItemCost__69181010] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RProjectItemCost] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemCost__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemCost] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemCost__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemCost] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemCost__R1ProjectItemId] FOREIGN KEY ([R1ProjectItemId]) REFERENCES [dbo].[OProjectItem] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemCost] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemCost__R2CostId] FOREIGN KEY ([R2CostId]) REFERENCES [dbo].[OCost] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RProjectItemGraphic] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1ProjectItemId]		[bigint]			 NOT NULL,
	[R2GraphicId]			[bigint]			 NOT NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemGraphic] ADD CONSTRAINT [DF__RProjectIt__Guid__378A3C90] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RProjectItemGraphic] ADD CONSTRAINT [DF__RProjectI__REPLI__3C4EF1AD] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RProjectItemGraphic] ADD CONSTRAINT [DF_RProjectItemGraphic_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RProjectItemGraphic] ADD CONSTRAINT [DF_RProjectItemGraphic_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RProjectItemGraphic] ADD CONSTRAINT [DF_RProjectItemGraphic_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1155807150] ON [dbo].[RProjectItemGraphic]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemGraphic] ADD CONSTRAINT [PK__RProjectItemGrap__36961857] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RProjectItemGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemGraphic__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemGraphic__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemGraphic__R1ProjectItemId] FOREIGN KEY ([R1ProjectItemId]) REFERENCES [dbo].[OProjectItem] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemGraphic__R2GraphicId] FOREIGN KEY ([R2GraphicId]) REFERENCES [dbo].[OGraphic] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RProjectItemLink] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1ProjectItemId]		[bigint]			 NOT NULL,
	[R2LinkId]				[bigint]			 NOT NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemLink] ADD CONSTRAINT [DF__RProjectIt__Guid__24AB7954] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RProjectItemLink] ADD CONSTRAINT [DF__RProjectItemLink__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RProjectItemLink] ADD CONSTRAINT [DF_RProjectItemLink_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RProjectItemLink] ADD CONSTRAINT [DF_RProjectItemLink_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RProjectItemLink] ADD CONSTRAINT [DF_RProjectItemLink_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RProjectItemLink] ADD CONSTRAINT [DF_RProjectItemLink_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2059414656] ON [dbo].[RProjectItemLink]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemLink] ADD CONSTRAINT [PK__RProjectItemLink__23B7551B] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RProjectItemLink] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemLink__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemLink] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemLink__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemLink] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemLink__R1ProjectItemId] FOREIGN KEY ([R1ProjectItemId]) REFERENCES [dbo].[OProjectItem] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemLink] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemLink__R2LinkId] FOREIGN KEY ([R2LinkId]) REFERENCES [dbo].[OLink] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RProjectItemPerson] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1ProjectItemId]		[bigint]			 NOT NULL,
	[R2PersonId]			[bigint]			 NOT NULL,
	[RoleId]				[bigint]			 NOT NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[R]						[smallint]			 NOT NULL,
	[A]						[smallint]			 NOT NULL,
	[E]						[smallint]			 NOT NULL,
	[W]						[smallint]			 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemPerson] ADD CONSTRAINT [DF__RProjectIt__Guid__19631883] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RProjectItemPerson] ADD CONSTRAINT [DF__RProjectItemPerson__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RProjectItemPerson] ADD CONSTRAINT [DF__RProjectItemPerson__R__DefaultValue] DEFAULT (0)FOR [R]
GO
ALTER TABLE [dbo].[RProjectItemPerson] ADD CONSTRAINT [DF__RProjectItemPerson__A__DefaultValue] DEFAULT (0)FOR [A]
GO
ALTER TABLE [dbo].[RProjectItemPerson] ADD CONSTRAINT [DF__RProjectItemPerson__E__DefaultValue] DEFAULT (0)FOR [E]
GO
ALTER TABLE [dbo].[RProjectItemPerson] ADD CONSTRAINT [DF__RProjectItemPerson__W__DefaultValue] DEFAULT (0)FOR [W]
GO
ALTER TABLE [dbo].[RProjectItemPerson] ADD CONSTRAINT [DF_RProjectItemPerson_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RProjectItemPerson] ADD CONSTRAINT [DF_RProjectItemPerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RProjectItemPerson] ADD CONSTRAINT [DF_RProjectItemPerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RProjectItemPerson] ADD CONSTRAINT [DF_RProjectItemPerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1302295699] ON [dbo].[RProjectItemPerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemPerson] ADD CONSTRAINT [PK__RProjectItemPers__186EF44A] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RProjectItemPerson] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemPerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemPerson] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemPerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemPerson] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemPerson__R1ProjectItemId] FOREIGN KEY ([R1ProjectItemId]) REFERENCES [dbo].[OProjectItem] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemPerson] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemPerson__R2PersonId] FOREIGN KEY ([R2PersonId]) REFERENCES [dbo].[OPerson] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemPerson] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemPerson__RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[LProjectItemRole] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RProjectItemProduct] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1ProjectItemId]		[bigint]			 NOT NULL,
	[R2ProductId]			[bigint]			 NOT NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[Value]					[money]				 NULL,
	[Quantity]				[int]				 NOT NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[CreatedOn]				[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemProduct] ADD CONSTRAINT [DF__RProjectIt__Guid__3086A6C7] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RProjectItemProduct] ADD CONSTRAINT [DF__RProjectItemProduct__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RProjectItemProduct] ADD CONSTRAINT [DF__RProjectItemProduct__Quantity__DefaultValue] DEFAULT (0)FOR [Quantity]
GO
ALTER TABLE [dbo].[RProjectItemProduct] ADD CONSTRAINT [DF_RProjectItemProduct_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RProjectItemProduct] ADD CONSTRAINT [DF_RProjectItemProduct_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RProjectItemProduct] ADD CONSTRAINT [DF_RProjectItemProduct_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RProjectItemProduct] ADD CONSTRAINT [DF_RProjectItemProduct_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1198132255] ON [dbo].[RProjectItemProduct]([Guid]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1393661004] ON [dbo].[RProjectItemProduct]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemProduct] ADD CONSTRAINT [PK__RProjectItemProd__2F92828E] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RProjectItemProduct] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemProduct_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemProduct] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemProduct_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RProjectItemProductHierarchy] (
	[Id]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NOT NULL,
	[R1ProjectItemId]			[bigint]			 NOT NULL,
	[R2ProductHierarchyId]		[bigint]			 NOT NULL,
	[Description]				[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[Value]						[money]				 NULL,
	[Quantity]					[int]				 NOT NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[CreatedOn]					[datetime]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemProductHierarchy] ADD CONSTRAINT [DF__RProjectIt__Guid__3733A456] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RProjectItemProductHierarchy] ADD CONSTRAINT [DF__RProjectItemProductHierarchy__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RProjectItemProductHierarchy] ADD CONSTRAINT [DF__RProjectItemProductHierarchy__Quantity__DefaultValue] DEFAULT (0)FOR [Quantity]
GO
ALTER TABLE [dbo].[RProjectItemProductHierarchy] ADD CONSTRAINT [DF_RProjectItemProductHierarchy_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RProjectItemProductHierarchy] ADD CONSTRAINT [DF_RProjectItemProductHierarchy_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RProjectItemProductHierarchy] ADD CONSTRAINT [DF_RProjectItemProductHierarchy_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RProjectItemProductHierarchy] ADD CONSTRAINT [DF_RProjectItemProductHierarchy_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1278132540] ON [dbo].[RProjectItemProductHierarchy]([Guid]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1313660719] ON [dbo].[RProjectItemProductHierarchy]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemProductHierarchy] ADD CONSTRAINT [PK__RProjectItemProd__363F801D] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RProjectItemProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemProductHierarchy_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemProductHierarchy_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RProjectItemProjectItem] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1ProjectItemId]		[bigint]			 NOT NULL,
	[R2ProjectItemId]		[bigint]			 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[Index]					[int]				 NOT NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemProjectItem] ADD CONSTRAINT [DF__RProjectIt__Guid__149E6366] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RProjectItemProjectItem] ADD CONSTRAINT [DF_RProjectItemProjectItem_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RProjectItemProjectItem] ADD CONSTRAINT [DF__RprojectI__Index__5333268B] DEFAULT (0)FOR [Index]
GO
ALTER TABLE [dbo].[RProjectItemProjectItem] ADD CONSTRAINT [DF_RProjectItemProjectItem_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RProjectItemProjectItem] ADD CONSTRAINT [DF_RProjectItemProjectItem_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RProjectItemProjectItem] ADD CONSTRAINT [DF_RProjectItemProjectItem_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1510296440] ON [dbo].[RProjectItemProjectItem]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemProjectItem] ADD CONSTRAINT [PK__RProjectItemProj__13AA3F2D] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RProjectItemProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemProjectItem__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemProjectItem__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemProjectItem__R1ProjectItemId] FOREIGN KEY ([R1ProjectItemId]) REFERENCES [dbo].[OProjectItem] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemProjectItem] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemProjectItem__R2ProjectItemId] FOREIGN KEY ([R2ProjectItemId]) REFERENCES [dbo].[OProjectItem] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RProjectItemResource] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1ProjectItemId]		[bigint]			 NOT NULL,
	[R2ResourceId]			[bigint]			 NOT NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemResource] ADD CONSTRAINT [DF__RProjectIt__Guid__727CBAAF] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RProjectItemResource] ADD CONSTRAINT [DF__RProjectItemResource__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RProjectItemResource] ADD CONSTRAINT [DF__RProjectI__REPLI__78359405] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RProjectItemResource] ADD CONSTRAINT [DF_RProjectItemResource_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RProjectItemResource] ADD CONSTRAINT [DF_RProjectItemResource_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RProjectItemResource] ADD CONSTRAINT [DF_RProjectItemResource_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1888776765] ON [dbo].[RProjectItemResource]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemResource] ADD CONSTRAINT [PK__RProjectItemReso__71889676] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RProjectItemResource] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemResource__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemResource] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemResource__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemResource] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemResource__R1ProjectItemId] FOREIGN KEY ([R1ProjectItemId]) REFERENCES [dbo].[OProjectItem] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemResource] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemResource__R2ResourceId] FOREIGN KEY ([R2ResourceId]) REFERENCES [dbo].[OResource] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RProjectItemSupportIssue] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1ProjectItemId]		[bigint]			 NOT NULL,
	[R2SupportIssueId]		[bigint]			 NOT NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[CreatedOn]				[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemSupportIssue] ADD CONSTRAINT [DF__RProjectIt__Guid__052812CD] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RProjectItemSupportIssue] ADD CONSTRAINT [DF_RProjectItemSupportIssue_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RProjectItemSupportIssue] ADD CONSTRAINT [DF__RProjectItemSupportIssue__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RProjectItemSupportIssue] ADD CONSTRAINT [DF_RProjectItemSupportIssue_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RProjectItemSupportIssue] ADD CONSTRAINT [DF_RProjectItemSupportIssue_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RProjectItemSupportIssue] ADD CONSTRAINT [DF_RProjectItemSupportIssue_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1575233658] ON [dbo].[RProjectItemSupportIssue]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RProjectItemSupportIssue] ADD CONSTRAINT [PK__RProjectItemSupp__0433EE94] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RProjectItemSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemSupportIssue__R1ProjectItemId] FOREIGN KEY ([R1ProjectItemId]) REFERENCES [dbo].[OProjectItem] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemSupportIssue__R2SupportIssueId] FOREIGN KEY ([R2SupportIssueId]) REFERENCES [dbo].[OSupportIssue] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemSupportIssue_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RProjectItemSupportIssue] WITH NOCHECK ADD CONSTRAINT [FK__RProjectItemSupportIssue_ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RResourceAddress] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1ResourceId]		[bigint]			 NOT NULL,
	[R2AddressId]		[bigint]			 NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[Description]		[varchar](1000)		 COLLATE Polish_CI_AS NOT NULL,
	[IsDefault]			[bit]				 NOT NULL,
	[TypeId]			[bigint]			 NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RResourceAddress] ADD CONSTRAINT [DF__RResourceA__Guid__7924F005] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RResourceAddress] ADD CONSTRAINT [DF__RResourceAddress__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RResourceAddress] ADD CONSTRAINT [DF__RResourceAddress__IsDefault__DefaultValue] DEFAULT (0)FOR [IsDefault]
GO
ALTER TABLE [dbo].[RResourceAddress] ADD CONSTRAINT [DF_RResourceAddress_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RResourceAddress] ADD CONSTRAINT [DF_RResourceAddress_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RResourceAddress] ADD CONSTRAINT [DF_RResourceAddress_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RResourceAddress] ADD CONSTRAINT [DF_RResourceAddress_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2000463763] ON [dbo].[RResourceAddress]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RResourceAddress] ADD CONSTRAINT [PK__RResourceAddress__7830CBCC] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RResourceAddress] WITH NOCHECK ADD CONSTRAINT [FK__RResourceAddress__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceAddress] WITH NOCHECK ADD CONSTRAINT [FK__RResourceAddress__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceAddress] WITH NOCHECK ADD CONSTRAINT [FK__RResourceAddress__R1ResourceId] FOREIGN KEY ([R1ResourceId]) REFERENCES [dbo].[OResource] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceAddress] WITH NOCHECK ADD CONSTRAINT [FK__RResourceAddress__R2AddressId] FOREIGN KEY ([R2AddressId]) REFERENCES [dbo].[OAddress] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceAddress] WITH NOCHECK ADD CONSTRAINT [FK__RResourceAddress__TypeId] FOREIGN KEY ([TypeId]) REFERENCES [dbo].[LAddressType] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RResourceArticle] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1ResourceId]		[bigint]			 NOT NULL,
	[R2ArticleId]		[bigint]			 NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RResourceArticle] ADD CONSTRAINT [DF__RResourceA__Guid__18C72332] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RResourceArticle] ADD CONSTRAINT [DF__RResource__REPLI__1D8BD84F] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RResourceArticle] ADD CONSTRAINT [DF_RResourceArticle_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RResourceArticle] ADD CONSTRAINT [DF_RResourceArticle_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RResourceArticle] ADD CONSTRAINT [DF_RResourceArticle_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_383703744] ON [dbo].[RResourceArticle]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RResourceArticle] ADD CONSTRAINT [PK__RResourceArticle__17D2FEF9] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RResourceArticle] WITH NOCHECK ADD CONSTRAINT [FK__RResourceArticle__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceArticle] WITH NOCHECK ADD CONSTRAINT [FK__RResourceArticle__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceArticle] WITH NOCHECK ADD CONSTRAINT [FK__RResourceArticle__R1ResourceId] FOREIGN KEY ([R1ResourceId]) REFERENCES [dbo].[OResource] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceArticle] WITH NOCHECK ADD CONSTRAINT [FK__RResourceArticle__R2ArticleId] FOREIGN KEY ([R2ArticleId]) REFERENCES [dbo].[OArticle] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RResourceCompany] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1ResourceId]		[bigint]			 NOT NULL,
	[R2CompanyId]		[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[RoleID]			[bigint]			 NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RResourceCompany] ADD CONSTRAINT [DF__RResourceC__Guid__4CEE74D8] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RResourceCompany] ADD CONSTRAINT [DF_RResourceCompany_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RResourceCompany] ADD CONSTRAINT [DF__RResourceCompany__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RResourceCompany] ADD CONSTRAINT [DF_RResourceCompany_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RResourceCompany] ADD CONSTRAINT [DF_RResourceCompany_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RResourceCompany] ADD CONSTRAINT [DF_RResourceCompany_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_769658781] ON [dbo].[RResourceCompany]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RResourceCompany] ADD CONSTRAINT [PK__RResourceCompany__4BFA509F] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RResourceCompany] WITH NOCHECK ADD CONSTRAINT [FK__RResourceCompany__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceCompany] WITH NOCHECK ADD CONSTRAINT [FK__RResourceCompany__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceCompany] WITH NOCHECK ADD CONSTRAINT [FK__RResourceCompany__R1ResourceId] FOREIGN KEY ([R1ResourceId]) REFERENCES [dbo].[OResource] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceCompany] WITH NOCHECK ADD CONSTRAINT [FK__RResourceCompany__R2CompanyId] FOREIGN KEY ([R2CompanyId]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceCompany] WITH NOCHECK ADD CONSTRAINT [FK__RResourceCompany__RoleId] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[LResourceRole] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RResourceCompanyPerson] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1ResourceId]			[bigint]			 NOT NULL,
	[R2CompanyPersonId]		[bigint]			 NOT NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[RoleID]				[bigint]			 NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RResourceCompanyPerson] ADD CONSTRAINT [DF__RResourceC__Guid__6A1DE3BC] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RResourceCompanyPerson] ADD CONSTRAINT [DF_RResourceCompanyPerson_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RResourceCompanyPerson] ADD CONSTRAINT [DF__RResourceCompanyPerson__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RResourceCompanyPerson] ADD CONSTRAINT [DF_RResourceCompanyPerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RResourceCompanyPerson] ADD CONSTRAINT [DF_RResourceCompanyPerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RResourceCompanyPerson] ADD CONSTRAINT [DF_RResourceCompanyPerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_292390494] ON [dbo].[RResourceCompanyPerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RResourceCompanyPerson] ADD CONSTRAINT [PK__RResourceCompany__6929BF83] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RResourceCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RResourceCompanyPerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RResourceCompanyPerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RResourceCompanyPerson__R1ResourceId] FOREIGN KEY ([R1ResourceId]) REFERENCES [dbo].[OResource] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RResourceCompanyPerson__R2CompanyPersonId] FOREIGN KEY ([R2CompanyPersonId]) REFERENCES [dbo].[RCompanyPerson] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RResourceCompanyPerson__RoleId] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[LResourceRole] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RResourceGraphic] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1ResourceId]		[bigint]			 NOT NULL,
	[R2GraphicId]		[bigint]			 NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RResourceGraphic] ADD CONSTRAINT [DF__RResourceG__Guid__3281FF61] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RResourceGraphic] ADD CONSTRAINT [DF_RResourceGraphic_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RResourceGraphic] ADD CONSTRAINT [DF_RResourceGraphic_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RResourceGraphic] ADD CONSTRAINT [DF_RResourceGraphic_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RResourceGraphic] ADD CONSTRAINT [DF_RResourceGraphic_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1855383912] ON [dbo].[RResourceGraphic]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RResourceGraphic] ADD CONSTRAINT [PK__RResourceGraphic__318DDB28] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RResourceGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RResourceGraphic__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RResourceGraphic__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RResourceGraphic__R1ResourceId] FOREIGN KEY ([R1ResourceId]) REFERENCES [dbo].[OResource] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceGraphic] WITH NOCHECK ADD CONSTRAINT [FK__RResourceGraphic__R2GraphicId] FOREIGN KEY ([R2GraphicId]) REFERENCES [dbo].[OGraphic] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RResourceHierarchyResource] (
	[Id]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NOT NULL,
	[R1ResourceHierarchyId]		[bigint]			 NOT NULL,
	[R2ResourceId]				[bigint]			 NOT NULL,
	[CreatedOn]					[datetime]			 NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RResourceHierarchyResource] ADD CONSTRAINT [DF__RResourceH__Guid__30DDA6C4] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RResourceHierarchyResource] ADD CONSTRAINT [DF_RResourceHierarchyResource_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RResourceHierarchyResource] ADD CONSTRAINT [DF_RResourceHierarchyResource_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RResourceHierarchyResource] ADD CONSTRAINT [DF_RResourceHierarchyResource_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RResourceHierarchyResource] ADD CONSTRAINT [DF_RResourceHierarchyResource_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1347834397] ON [dbo].[RResourceHierarchyResource]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RResourceHierarchyResource] ADD CONSTRAINT [PK__RResourceHierarc__2FE9828B] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RResourceHierarchyResource] WITH NOCHECK ADD CONSTRAINT [FK__RResourceHierarchyResource__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceHierarchyResource] WITH NOCHECK ADD CONSTRAINT [FK__RResourceHierarchyResource__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[TResourceHierarchy] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[Path]				[varchar](109)		 COLLATE Polish_CI_AS NOT NULL,
	[Parent]			[varchar](36)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[Name]				[varchar](200)		 COLLATE Polish_CI_AS NOT NULL,
	[Description]		[varchar](2000)		 COLLATE Polish_CI_AS NOT NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TResourceHierarchy] ADD CONSTRAINT [DF__TResourceH__Guid__1C4B3D7D] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[TResourceHierarchy] ADD CONSTRAINT [DF__TResourceHierarchy__Path__DefaultValue] DEFAULT ('')FOR [Path]
GO
ALTER TABLE [dbo].[TResourceHierarchy] ADD CONSTRAINT [DF_TResourceHierarchy_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[TResourceHierarchy] ADD CONSTRAINT [DF__TResourceHierarchy__Name__DefaultValue] DEFAULT ('')FOR [Name]
GO
ALTER TABLE [dbo].[TResourceHierarchy] ADD CONSTRAINT [DF__TResourceHierarchy__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[TResourceHierarchy] ADD CONSTRAINT [DF_TResourceHierarchy_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[TResourceHierarchy] ADD CONSTRAINT [DF_TResourceHierarchy_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[TResourceHierarchy] ADD CONSTRAINT [DF_TResourceHierarchy_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_715409868] ON [dbo].[TResourceHierarchy]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TResourceHierarchy] ADD CONSTRAINT [PK__TResourceHierarc__1B571944] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[TResourceHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__TResourceHierarchy__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[TResourceHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__TResourceHierarchy__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[TResourceHierarchy] TO [RaportyWEBZewn]
GO
ALTER TABLE [dbo].[RResourceHierarchyResource] WITH NOCHECK ADD CONSTRAINT [FK__RResourceHierarchyResource__R1ResourceHierarchyId] FOREIGN KEY ([R1ResourceHierarchyId]) REFERENCES [dbo].[TResourceHierarchy] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceHierarchyResource] WITH NOCHECK ADD CONSTRAINT [FK__RResourceHierarchyResource__R2ResourceId] FOREIGN KEY ([R2ResourceId]) REFERENCES [dbo].[OResource] ([Id]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RResourceHierarchyResource] TO [RaportyWEBZewn]
GO
CREATE TABLE [dbo].[RResourceLink] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1ResourceId]		[bigint]			 NOT NULL,
	[R2LinkId]			[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RResourceLink] ADD CONSTRAINT [DF__RResourceL__Guid__4829BFBB] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RResourceLink] ADD CONSTRAINT [DF_RResourceLink_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RResourceLink] ADD CONSTRAINT [DF__RResourceLink__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RResourceLink] ADD CONSTRAINT [DF_RResourceLink_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RResourceLink] ADD CONSTRAINT [DF_RResourceLink_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RResourceLink] ADD CONSTRAINT [DF_RResourceLink_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1509137413] ON [dbo].[RResourceLink]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RResourceLink] ADD CONSTRAINT [PK__RResourceLink__47359B82] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RResourceLink] WITH NOCHECK ADD CONSTRAINT [FK__RResourceLink__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceLink] WITH NOCHECK ADD CONSTRAINT [FK__RResourceLink__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceLink] WITH NOCHECK ADD CONSTRAINT [FK__RResourceLink__R1ResourceId] FOREIGN KEY ([R1ResourceId]) REFERENCES [dbo].[OResource] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceLink] WITH NOCHECK ADD CONSTRAINT [FK__RResourceLink__R2LinkId] FOREIGN KEY ([R2LinkId]) REFERENCES [dbo].[OLink] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RResourcePerson] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1ResourceId]		[bigint]			 NOT NULL,
	[R2PersonId]		[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[Description]		[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[RoleID]			[bigint]			 NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RResourcePerson] ADD CONSTRAINT [DF__RResourceP__Guid__43650A9E] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RResourcePerson] ADD CONSTRAINT [DF_RResourcePerson_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RResourcePerson] ADD CONSTRAINT [DF__RResourcePerson__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RResourcePerson] ADD CONSTRAINT [DF_RResourcePerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RResourcePerson] ADD CONSTRAINT [DF_RResourcePerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RResourcePerson] ADD CONSTRAINT [DF_RResourcePerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_549133993] ON [dbo].[RResourcePerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RResourcePerson] ADD CONSTRAINT [PK__RResourcePerson__4270E665] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RResourcePerson] WITH NOCHECK ADD CONSTRAINT [FK__RResourcePerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourcePerson] WITH NOCHECK ADD CONSTRAINT [FK__RResourcePerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourcePerson] WITH NOCHECK ADD CONSTRAINT [FK__RResourcePerson__R1ResourceId] FOREIGN KEY ([R1ResourceId]) REFERENCES [dbo].[OResource] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourcePerson] WITH NOCHECK ADD CONSTRAINT [FK__RResourcePerson__R2PersonId] FOREIGN KEY ([R2PersonId]) REFERENCES [dbo].[OPerson] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourcePerson] WITH NOCHECK ADD CONSTRAINT [FK__RResourcePerson__RoleId] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[LResourceRole] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RResourceResource] (
	[Id]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]				[uniqueidentifier]	 NOT NULL,
	[R1ResourceId]		[bigint]			 NOT NULL,
	[R2ResourceId]		[bigint]			 NOT NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[CreatedOn]			[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RResourceResource] ADD CONSTRAINT [DF__RResourceR__Guid__29A5389B] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RResourceResource] ADD CONSTRAINT [DF_RResourceResource_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RResourceResource] ADD CONSTRAINT [DF_RResourceResource_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RResourceResource] ADD CONSTRAINT [DF_RResourceResource_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RResourceResource] ADD CONSTRAINT [DF_RResourceResource_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_181132682] ON [dbo].[RResourceResource]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RResourceResource] ADD CONSTRAINT [PK__RResourceResourc__28B11462] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RResourceResource] WITH NOCHECK ADD CONSTRAINT [FK__RResourceResource__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceResource] WITH NOCHECK ADD CONSTRAINT [FK__RResourceResource__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceResource] WITH NOCHECK ADD CONSTRAINT [FK__RResourceResource__R1ResourceId] FOREIGN KEY ([R1ResourceId]) REFERENCES [dbo].[OResource] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceResource] WITH NOCHECK ADD CONSTRAINT [FK__RResourceResource__R2ResourceId] FOREIGN KEY ([R2ResourceId]) REFERENCES [dbo].[OResource] ([Id]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RResourceResource] TO [RaportyWEBZewn]
GO
CREATE TABLE [dbo].[RResourceResourceHierarchy] (
	[Id]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NOT NULL,
	[R1ResourceId]				[bigint]			 NOT NULL,
	[R2ResourceHierarchyId]		[bigint]			 NOT NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[CreatedOn]					[datetime]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RResourceResourceHierarchy] ADD CONSTRAINT [DF__RResourceR__Guid__332EA2D5] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RResourceResourceHierarchy] ADD CONSTRAINT [DF_RResourceResourceHierarchy_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RResourceResourceHierarchy] ADD CONSTRAINT [DF_RResourceResourceHierarchy_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RResourceResourceHierarchy] ADD CONSTRAINT [DF_RResourceResourceHierarchy_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RResourceResourceHierarchy] ADD CONSTRAINT [DF_RResourceResourceHierarchy_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1960615019] ON [dbo].[RResourceResourceHierarchy]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RResourceResourceHierarchy] ADD CONSTRAINT [PK__RResourceResourc__323A7E9C] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RResourceResourceHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__RResourceResourceHierarchy__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceResourceHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__RResourceResourceHierarchy__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceResourceHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__RResourceResourceHierarchy__R1ResourceId] FOREIGN KEY ([R1ResourceId]) REFERENCES [dbo].[OResource] ([Id]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RResourceResourceHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__RResourceResourceHierarchy__R2ResourceHierarchyId] FOREIGN KEY ([R2ResourceHierarchyId]) REFERENCES [dbo].[TResourceHierarchy] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RShipmentAddressShipment] (
	[ID]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NOT NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[R1ShipmentAddressID]		[bigint]			 NOT NULL,
	[R2ShipmentID]				[bigint]			 NOT NULL,
	[TypeID]					[bigint]			 NOT NULL,
	[CreatedOn]					[datetime]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RShipmentAddressShipment] ADD CONSTRAINT [DF_RShipmentAddressShipment_Guid] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RShipmentAddressShipment] ADD CONSTRAINT [DF_RShipmentAddressShipment_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RShipmentAddressShipment] ADD CONSTRAINT [DF_RShipmentAddressShipment_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RShipmentAddressShipment] ADD CONSTRAINT [DF_RShipmentAddressShipment_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RShipmentAddressShipment] ADD CONSTRAINT [DF_RShipmentAddressShipment_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_770934664] ON [dbo].[RShipmentAddressShipment]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RShipmentAddressShipment] ADD CONSTRAINT [PK_RShipmentAddressShipment] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RShipmentAddressShipment] WITH NOCHECK ADD CONSTRAINT [FK__RShipmentAddressShipment_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RShipmentAddressShipment] WITH NOCHECK ADD CONSTRAINT [FK__RShipmentAddressShipment_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RShipmentAddressShipment] WITH NOCHECK ADD CONSTRAINT [FK_RShipmentAddressShipment_LShipmentAddressType] FOREIGN KEY ([TypeID]) REFERENCES [dbo].[LShipmentAddressType] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RShipmentAddressShipment] WITH NOCHECK ADD CONSTRAINT [FK_RShipmentAddressShipment_OShipment] FOREIGN KEY ([R2ShipmentID]) REFERENCES [dbo].[OShipment] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RShipmentAddressShipment] WITH NOCHECK ADD CONSTRAINT [FK_RShipmentAddressShipment_OShipmentAddress] FOREIGN KEY ([R1ShipmentAddressID]) REFERENCES [dbo].[OShipmentAddress] ([ID]) NOT FOR REPLICATION
GO
GRANT DELETE ON [dbo].[RShipmentAddressShipment] TO [BDKProgramyZewnetrzne]
GO
GRANT INSERT ON [dbo].[RShipmentAddressShipment] TO [BDKProgramyZewnetrzne]
GO
GRANT SELECT ON [dbo].[RShipmentAddressShipment] TO [BDKProgramyZewnetrzne]
GO
GRANT UPDATE ON [dbo].[RShipmentAddressShipment] TO [BDKProgramyZewnetrzne]
GO
CREATE TABLE [dbo].[RShipmentParametersShipment] (
	[ID]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NOT NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[Answer]					[varchar](500)		 COLLATE Polish_CI_AS NULL,
	[R1ShipmentParameterID]		[bigint]			 NOT NULL,
	[R2ShipmentID]				[bigint]			 NOT NULL,
	[CreatedOn]					[datetime]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RShipmentParametersShipment] ADD CONSTRAINT [DF_RShipmentParametersShipment_Guid] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RShipmentParametersShipment] ADD CONSTRAINT [DF_RShipmentParametersShipment_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RShipmentParametersShipment] ADD CONSTRAINT [DF_RShipmentParametersShipment_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RShipmentParametersShipment] ADD CONSTRAINT [DF_RShipmentParametersShipment_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RShipmentParametersShipment] ADD CONSTRAINT [DF_RShipmentParametersShipment_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_882935063] ON [dbo].[RShipmentParametersShipment]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RShipmentParametersShipment] ADD CONSTRAINT [PK_RShipmentParametersShipment] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RShipmentParametersShipment] WITH NOCHECK ADD CONSTRAINT [FK__RShipmentParametersShipment_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RShipmentParametersShipment] WITH NOCHECK ADD CONSTRAINT [FK__RShipmentParametersShipment_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RShipmentParametersShipment] WITH NOCHECK ADD CONSTRAINT [FK_RShipmentParametersShipment_LShipmentParameter] FOREIGN KEY ([R1ShipmentParameterID]) REFERENCES [dbo].[LShipmentParameter] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RShipmentParametersShipment] WITH NOCHECK ADD CONSTRAINT [FK_RShipmentParametersShipment_OShipment] FOREIGN KEY ([R2ShipmentID]) REFERENCES [dbo].[OShipment] ([ID]) NOT FOR REPLICATION
GO
GRANT DELETE ON [dbo].[RShipmentParametersShipment] TO [BDKProgramyZewnetrzne]
GO
GRANT INSERT ON [dbo].[RShipmentParametersShipment] TO [BDKProgramyZewnetrzne]
GO
GRANT SELECT ON [dbo].[RShipmentParametersShipment] TO [BDKProgramyZewnetrzne]
GO
GRANT UPDATE ON [dbo].[RShipmentParametersShipment] TO [BDKProgramyZewnetrzne]
GO
CREATE TABLE [dbo].[RShipmentReportShipment] (
	[ID]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[GUID]					[uniqueidentifier]	 NOT NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[R1ShipmentReportID]	[bigint]			 NOT NULL,
	[R2ShipmentID]			[bigint]			 NOT NULL,
	[CreatedOn]				[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RShipmentReportShipment] ADD CONSTRAINT [DF_RShipmentReportShipment_GUID] DEFAULT (newid())FOR [GUID]
GO
ALTER TABLE [dbo].[RShipmentReportShipment] ADD CONSTRAINT [DF_RShipmentReportShipment_ROWGUID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RShipmentReportShipment] ADD CONSTRAINT [DF_RShipmentReportShipment_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RShipmentReportShipment] ADD CONSTRAINT [DF_RShipmentReportShipment_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RShipmentReportShipment] ADD CONSTRAINT [DF_RShipmentReportShipment_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_978935405] ON [dbo].[RShipmentReportShipment]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RShipmentReportShipment] ADD CONSTRAINT [PK_RShipmentReportShipment] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RShipmentReportShipment] WITH NOCHECK ADD CONSTRAINT [FK__RShipmentReportShipment_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RShipmentReportShipment] WITH NOCHECK ADD CONSTRAINT [FK__RShipmentReportShipment_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RShipmentReportShipment] WITH NOCHECK ADD CONSTRAINT [FK_RShipmentReportShipment_OShipment] FOREIGN KEY ([R2ShipmentID]) REFERENCES [dbo].[OShipment] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RShipmentReportShipment] WITH NOCHECK ADD CONSTRAINT [FK_RShipmentReportShipment_OShipmentReport] FOREIGN KEY ([R1ShipmentReportID]) REFERENCES [dbo].[OShipmentReport] ([ID]) NOT FOR REPLICATION
GO
GRANT DELETE ON [dbo].[RShipmentReportShipment] TO [BDKProgramyZewnetrzne]
GO
GRANT INSERT ON [dbo].[RShipmentReportShipment] TO [BDKProgramyZewnetrzne]
GO
GRANT SELECT ON [dbo].[RShipmentReportShipment] TO [BDKProgramyZewnetrzne]
GO
GRANT UPDATE ON [dbo].[RShipmentReportShipment] TO [BDKProgramyZewnetrzne]
GO
CREATE TABLE [dbo].[RShipmentShipment] (
	[ID]				[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[GUID]				[uniqueidentifier]	 NOT NULL,
	[REPLID]			[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[R1ShipmentID]		[bigint]			 NOT NULL,
	[R2ShipmentID]		[bigint]			 NOT NULL,
	[CreatedOn]			[datetime]			 NULL,
	[CreatedBy]			[bigint]			 NULL,
	[ModifiedOn]		[datetime]			 NULL,
	[ModifiedBy]		[bigint]			 NULL,
	[SecR]				[bigint]			 NOT NULL,
	[SecW]				[bigint]			 NOT NULL,
	[SecD]				[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RShipmentShipment] ADD CONSTRAINT [DF_RShipmentShipment_GUID] DEFAULT (newid())FOR [GUID]
GO
ALTER TABLE [dbo].[RShipmentShipment] ADD CONSTRAINT [DF_RShipmentShipment_ROWGUID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RShipmentShipment] ADD CONSTRAINT [DF_RShipmentShipment_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RShipmentShipment] ADD CONSTRAINT [DF_RShipmentShipment_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RShipmentShipment] ADD CONSTRAINT [DF_RShipmentShipment_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1074935747] ON [dbo].[RShipmentShipment]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RShipmentShipment] ADD CONSTRAINT [PK_RShipmentShipment] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RShipmentShipment] WITH NOCHECK ADD CONSTRAINT [FK__RShipmentShipment_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RShipmentShipment] WITH NOCHECK ADD CONSTRAINT [FK__RShipmentShipment_ModifiedOn] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RShipmentShipment] WITH NOCHECK ADD CONSTRAINT [FK_RShipmentShipment_OShipment] FOREIGN KEY ([R1ShipmentID]) REFERENCES [dbo].[OShipment] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RShipmentShipment] WITH NOCHECK ADD CONSTRAINT [FK_RShipmentShipment_OShipment1] FOREIGN KEY ([R2ShipmentID]) REFERENCES [dbo].[OShipment] ([ID]) NOT FOR REPLICATION
GO
GRANT DELETE ON [dbo].[RShipmentShipment] TO [BDKProgramyZewnetrzne]
GO
GRANT INSERT ON [dbo].[RShipmentShipment] TO [BDKProgramyZewnetrzne]
GO
GRANT SELECT ON [dbo].[RShipmentShipment] TO [BDKProgramyZewnetrzne]
GO
GRANT UPDATE ON [dbo].[RShipmentShipment] TO [BDKProgramyZewnetrzne]
GO
CREATE TABLE [dbo].[RSupportIssueArticle] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1SupportIssueId]		[bigint]			 NOT NULL,
	[R2ArticleId]			[bigint]			 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RSupportIssueArticle] ADD CONSTRAINT [DF__RSupportIs__Guid__1216311F] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RSupportIssueArticle] ADD CONSTRAINT [DF_RSupportIssueArticle_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RSupportIssueArticle] ADD CONSTRAINT [DF_RSupportIssueArticle_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RSupportIssueArticle] ADD CONSTRAINT [DF_RSupportIssueArticle_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RSupportIssueArticle] ADD CONSTRAINT [DF_RSupportIssueArticle_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1622296839] ON [dbo].[RSupportIssueArticle]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RSupportIssueArticle] ADD CONSTRAINT [PK__RSupportIssueArt__11220CE6] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RSupportIssueArticle] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueArticle__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueArticle] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueArticle__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueArticle] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueArticle__R1SupportIssueId] FOREIGN KEY ([R1SupportIssueId]) REFERENCES [dbo].[OSupportIssue] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueArticle] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueArticle__R2ArticleId] FOREIGN KEY ([R2ArticleId]) REFERENCES [dbo].[OArticle] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RSupportIssueCompany] (
	[ID]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1SupportIssueID]		[bigint]			 NOT NULL,
	[R2CompanyID]			[bigint]			 NOT NULL,
	[RoleID]				[bigint]			 NOT NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RSupportIssueCompany] ADD CONSTRAINT [DF__RSupportIs__Guid__23DFDB9F] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RSupportIssueCompany] ADD CONSTRAINT [DF__RSupportIssueCompany__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RSupportIssueCompany] ADD CONSTRAINT [DF_RSupportIssueCompany_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RSupportIssueCompany] ADD CONSTRAINT [DF_RSupportIssueCompany_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RSupportIssueCompany] ADD CONSTRAINT [DF_RSupportIssueCompany_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RSupportIssueCompany] ADD CONSTRAINT [DF_RSupportIssueCompany_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1734297238] ON [dbo].[RSupportIssueCompany]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RSupportIssueCompany] ADD CONSTRAINT [PK__RSupportIssueCom__22EBB766] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RSupportIssueCompany] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueCompany__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueCompany] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueCompany__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueCompany] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueCompany__R1SupportIssueID] FOREIGN KEY ([R1SupportIssueID]) REFERENCES [dbo].[OSupportIssue] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueCompany] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueCompany__R2CompanyID] FOREIGN KEY ([R2CompanyID]) REFERENCES [dbo].[OCompany] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueCompany] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueCompany__RoleID] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[LSupportIssueRole] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RSupportIssueCompany] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RSupportIssueCompanyPerson] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1SupportIssueId]		[bigint]			 NOT NULL,
	[R2CompanyPersonId]		[bigint]			 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[RoleId]				[bigint]			 NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RSupportIssueCompanyPerson] ADD CONSTRAINT [DF__RSupportIs__Guid__377E56A6] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RSupportIssueCompanyPerson] ADD CONSTRAINT [DF_RSupportIssueCompanyPerson_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RSupportIssueCompanyPerson] ADD CONSTRAINT [DF_RSupportIssueCompanyPerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RSupportIssueCompanyPerson] ADD CONSTRAINT [DF_RSupportIssueCompanyPerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RSupportIssueCompanyPerson] ADD CONSTRAINT [DF_RSupportIssueCompanyPerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1878297751] ON [dbo].[RSupportIssueCompanyPerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RSupportIssueCompanyPerson] ADD CONSTRAINT [PK__RSupportIssueCom__368A326D] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RSupportIssueCompanyPerson] WITH NOCHECK ADD CONSTRAINT [CK_RsupportIssueCompanyPerson_RoleId] CHECK NOT FOR REPLICATION (([RoleId] is not null))
GO
ALTER TABLE [dbo].[RSupportIssueCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueCompanyPerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueCompanyPerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueCompanyPerson__R1SupportIssueId] FOREIGN KEY ([R1SupportIssueId]) REFERENCES [dbo].[OSupportIssue] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueCompanyPerson__R2CompanyPersonId] FOREIGN KEY ([R2CompanyPersonId]) REFERENCES [dbo].[RCompanyPerson] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueCompanyPerson] WITH NOCHECK ADD CONSTRAINT [FK_RsupportIssueCompanyPerson_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[LSupportIssueRole] ([ID]) NOT FOR REPLICATION
GO
GRANT INSERT ON [dbo].[RSupportIssueCompanyPerson] TO [RaportyWEB]
GO
GRANT SELECT ON [dbo].[RSupportIssueCompanyPerson] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RSupportIssueCost] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1SupportIssueId]		[bigint]			 NOT NULL,
	[R2CostId]				[bigint]			 NOT NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RSupportIssueCost] ADD CONSTRAINT [DF__RSupportIs__Guid__7676CF38] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RSupportIssueCost] ADD CONSTRAINT [DF__RSupportIssueCost__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RSupportIssueCost] ADD CONSTRAINT [DF__RSupportI__REPLI__7C2FA88E] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RSupportIssueCost] ADD CONSTRAINT [DF_RSupportIssueCost_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RSupportIssueCost] ADD CONSTRAINT [DF_RSupportIssueCost_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RSupportIssueCost] ADD CONSTRAINT [DF_RSupportIssueCost_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1955497670] ON [dbo].[RSupportIssueCost]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RSupportIssueCost] ADD CONSTRAINT [PK__RSupportIssueCos__7582AAFF] PRIMARY KEY CLUSTERED ([Id])
GO
ALTER TABLE [dbo].[RSupportIssueCost] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueCost__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueCost] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueCost__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueCost] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueCost__R1SupportIssueId] FOREIGN KEY ([R1SupportIssueId]) REFERENCES [dbo].[OSupportIssue] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueCost] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueCost__R2CostId] FOREIGN KEY ([R2CostId]) REFERENCES [dbo].[OCost] ([Id]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RSupportIssueExternalIssue] (
	[ID]							[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]							[uniqueidentifier]	 NOT NULL,
	[R1SupportIssueID]				[bigint]			 NOT NULL,
	[R2ExternalSupportIssueID]		[bigint]			 NOT NULL,
	[ModifiedOn]					[datetime]			 NULL,
	[CreatedOn]						[datetime]			 NULL,
	[ModifiedBy]					[bigint]			 NULL,
	[CreatedBy]						[bigint]			 NULL,
	[REPLID]						[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]							[bigint]			 NOT NULL,
	[SecW]							[bigint]			 NOT NULL,
	[SecD]							[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RSupportIssueExternalIssue] ADD CONSTRAINT [DF__RSupportIs__Guid__657894D2] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RSupportIssueExternalIssue] ADD CONSTRAINT [DF_RSupportIssueExternalIssue_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RSupportIssueExternalIssue] ADD CONSTRAINT [DF_RSupportIssueExternalIssue_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RSupportIssueExternalIssue] ADD CONSTRAINT [DF_RSupportIssueExternalIssue_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RSupportIssueExternalIssue] ADD CONSTRAINT [DF_RSupportIssueExternalIssue_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_1990298150] ON [dbo].[RSupportIssueExternalIssue]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RSupportIssueExternalIssue] ADD CONSTRAINT [PK__RSupportIssueExt__64847099] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RSupportIssueExternalIssue] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueExternal__R1SupportIssueID] FOREIGN KEY ([R1SupportIssueID]) REFERENCES [dbo].[OSupportIssue] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueExternalIssue] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueExternal__R2ExternalSupportIssueID] FOREIGN KEY ([R2ExternalSupportIssueID]) REFERENCES [dbo].[OExternalSupportIssue] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueExternalIssue] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueExternalIssue__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueExternalIssue] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueExternalIssue__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
CREATE TABLE [dbo].[RSupportIssueLink] (
	[ID]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1SupportIssueId]		[bigint]			 NOT NULL,
	[R2LinkId]				[bigint]			 NOT NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RSupportIssueLink] ADD CONSTRAINT [DF__RSupportIs__Guid__5359E497] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RSupportIssueLink] ADD CONSTRAINT [DF__RSupportIssueLink__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RSupportIssueLink] ADD CONSTRAINT [DF_RSupportIssueLink_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RSupportIssueLink] ADD CONSTRAINT [DF_RSupportIssueLink_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RSupportIssueLink] ADD CONSTRAINT [DF_RSupportIssueLink_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RSupportIssueLink] ADD CONSTRAINT [DF_RSupportIssueLink_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_2102298549] ON [dbo].[RSupportIssueLink]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RSupportIssueLink] ADD CONSTRAINT [PK__RSupportIssueLin__5265C05E] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RSupportIssueLink] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueLink__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueLink] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueLink__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueLink] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueLink__R1SupportIssueID] FOREIGN KEY ([R1SupportIssueId]) REFERENCES [dbo].[OSupportIssue] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueLink] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueLink__R2LinkID] FOREIGN KEY ([R2LinkId]) REFERENCES [dbo].[OLink] ([ID]) NOT FOR REPLICATION
GO
GRANT INSERT ON [dbo].[RSupportIssueLink] TO [RaportyWEB]
GO
GRANT SELECT ON [dbo].[RSupportIssueLink] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RSupportIssuePerson] (
	[ID]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1SupportIssueID]		[bigint]			 NOT NULL,
	[R2PersonID]			[bigint]			 NOT NULL,
	[RoleID]				[bigint]			 NOT NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RSupportIssuePerson] ADD CONSTRAINT [DF__RSupportIs__Guid__1F1B2682] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RSupportIssuePerson] ADD CONSTRAINT [DF__RSupportIssuePerson__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RSupportIssuePerson] ADD CONSTRAINT [DF_RSupportIssuePerson_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RSupportIssuePerson] ADD CONSTRAINT [DF_RSupportIssuePerson_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RSupportIssuePerson] ADD CONSTRAINT [DF_RSupportIssuePerson_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RSupportIssuePerson] ADD CONSTRAINT [DF_RSupportIssuePerson_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_82815357] ON [dbo].[RSupportIssuePerson]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RSupportIssuePerson] ADD CONSTRAINT [PK__RSupportIssuePer__1E270249] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RSupportIssuePerson] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssuePerson__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssuePerson] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssuePerson__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssuePerson] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssuePerson__R1SupportIssueID] FOREIGN KEY ([R1SupportIssueID]) REFERENCES [dbo].[OSupportIssue] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssuePerson] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssuePerson__R2PersonID] FOREIGN KEY ([R2PersonID]) REFERENCES [dbo].[OPerson] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssuePerson] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssuePerson__RoleID] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[LSupportIssueRole] ([ID]) NOT FOR REPLICATION
GO
GRANT SELECT ON [dbo].[RSupportIssuePerson] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RSupportIssueProduct] (
	[ID]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1SupportIssueID]		[bigint]			 NOT NULL,
	[R2ProductID]			[bigint]			 NOT NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedOn]				[datetime]			 NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RSupportIssueProduct] ADD CONSTRAINT [DF__RSupportIs__Guid__12B54F9D] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RSupportIssueProduct] ADD CONSTRAINT [DF__RSupportIssueProduct__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RSupportIssueProduct] ADD CONSTRAINT [DF_RSupportIssueProduct_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RSupportIssueProduct] ADD CONSTRAINT [DF_RSupportIssueProduct_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RSupportIssueProduct] ADD CONSTRAINT [DF_RSupportIssueProduct_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RSupportIssueProduct] ADD CONSTRAINT [DF_RSupportIssueProduct_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_226815870] ON [dbo].[RSupportIssueProduct]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RSupportIssueProduct] ADD CONSTRAINT [PK__RSupportIssuePro__11C12B64] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RSupportIssueProduct] WITH NOCHECK ADD CONSTRAINT [FK_RSupportIssueProduct_OProduct] FOREIGN KEY ([R2ProductID]) REFERENCES [dbo].[OProduct] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueProduct] WITH NOCHECK ADD CONSTRAINT [FK_RSupportIssueProduct_OSupportIssue] FOREIGN KEY ([R1SupportIssueID]) REFERENCES [dbo].[OSupportIssue] ([ID]) NOT FOR REPLICATION
GO
GRANT INSERT ON [dbo].[RSupportIssueProduct] TO [RaportyWEB]
GO
GRANT SELECT ON [dbo].[RSupportIssueProduct] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RSupportIssueProductHierarchy] (
	[ID]						[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]						[uniqueidentifier]	 NOT NULL,
	[R1SupportIssueID]			[bigint]			 NOT NULL,
	[R2ProductHierarchyID]		[bigint]			 NOT NULL,
	[ModifiedBy]				[bigint]			 NULL,
	[CreatedBy]					[bigint]			 NULL,
	[Description]				[varchar](300)		 COLLATE Polish_CI_AS NULL,
	[ModifiedOn]				[datetime]			 NULL,
	[CreatedOn]					[datetime]			 NULL,
	[REPLID]					[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]						[bigint]			 NOT NULL,
	[SecW]						[bigint]			 NOT NULL,
	[SecD]						[bigint]			 NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RSupportIssueProductHierarchy] ADD CONSTRAINT [DF__RSupportIs__Guid__3139D6BD] DEFAULT (newid())FOR [Guid]
GO
ALTER TABLE [dbo].[RSupportIssueProductHierarchy] ADD CONSTRAINT [DF__RSupportIssueProductHierarchy__Description__DefaultValue] DEFAULT ('')FOR [Description]
GO
ALTER TABLE [dbo].[RSupportIssueProductHierarchy] ADD CONSTRAINT [DF_RSupportIssueProductHierarchy_REPLID] DEFAULT (newid())FOR [REPLID]
GO
ALTER TABLE [dbo].[RSupportIssueProductHierarchy] ADD CONSTRAINT [DF_RSupportIssueProductHierarchy_SecR_DefaultValue] DEFAULT (0)FOR [SecR]
GO
ALTER TABLE [dbo].[RSupportIssueProductHierarchy] ADD CONSTRAINT [DF_RSupportIssueProductHierarchy_SecW_DefaultValue] DEFAULT (0)FOR [SecW]
GO
ALTER TABLE [dbo].[RSupportIssueProductHierarchy] ADD CONSTRAINT [DF_RSupportIssueProductHierarchy_SecD_DefaultValue] DEFAULT (0)FOR [SecD]
GO
CREATE UNIQUE NONCLUSTERED INDEX [index_322816212] ON [dbo].[RSupportIssueProductHierarchy]([REPLID]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RSupportIssueProductHierarchy] ADD CONSTRAINT [PK__RSupportIssuePro__3045B284] PRIMARY KEY CLUSTERED ([ID])
GO
ALTER TABLE [dbo].[RSupportIssueProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueProductHierarchy__CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueProductHierarchy__ModifiedBy] FOREIGN KEY ([ModifiedBy]) REFERENCES [dbo].[OUser] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueProductHierarchy__R1SupportIssueID] FOREIGN KEY ([R1SupportIssueID]) REFERENCES [dbo].[OSupportIssue] ([ID]) NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[RSupportIssueProductHierarchy] WITH NOCHECK ADD CONSTRAINT [FK__RSupportIssueProductHierarchy__R2ProductHierarchyID] FOREIGN KEY ([R2ProductHierarchyID]) REFERENCES [dbo].[TProductHierarchy] ([ID]) NOT FOR REPLICATION
GO
GRANT INSERT ON [dbo].[RSupportIssueProductHierarchy] TO [RaportyWEB]
GO
GRANT SELECT ON [dbo].[RSupportIssueProductHierarchy] TO [RaportyWEB]
GO
CREATE TABLE [dbo].[RSupportIssueResource] (
	[Id]					[bigint]			 IDENTITY(3, 10) NOT FOR REPLICATION NOT NULL,
	[Guid]					[uniqueidentifier]	 NOT NULL,
	[R1SupportIssueId]		[bigint]			 NOT NULL,
	[R2ResourceId]			[bigint]			 NOT NULL,
	[CreatedOn]				[datetime]			 NULL,
	[ModifiedOn]			[datetime]			 NULL,
	[CreatedBy]				[bigint]			 NULL,
	[ModifiedBy]			[bigint]			 NULL,
	[Description]			[varchar](300)		 COLLATE Polish_CI_AS NOT NULL,
	[REPLID]				[uniqueidentifier]	 NOT NULL ROWGUIDCOL,
	[SecR]					[bigint]			 NOT NULL,
	[SecW]					[bigint]			 NOT NULL,
	[SecD]					[bigint]			 NOT NULL
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\ANNAS].[vEtykietyMCH]
AS
SELECT DISTINCT C1.DerivedFullName AS Odbiorca,

(SELECT TOP 1
(CASE
  WHEN A1.PostOfficeID IS NULL THEN
             A1.Street + ' ' + A1.HouseNr + (CASE A1.AppartmentNr WHEN '' THEN '' ELSE '/' + A1.AppartmentNr END) + CHAR(13) + CHAR(10) +
            (CASE WHEN A1.PostOfficeBox IS NOT NULL AND A1.PostOfficeBox <> '' THEN 'skr. poczt. ' + A1.PostOfficeBox + CHAR(13) + CHAR(10) ELSE '' END)  +
            A1.PostalCode +  (CASE WHEN Ci1.Name IS NOT NULL THEN ' ' + Ci1.Name ELSE '' END) +
            (CASE WHEN (Co1.ID <> 270) THEN CHAR(13) + CHAR(10) +  Co1.Name ELSE '' END)
  ELSE
    (CASE 
      WHEN A1.Street = '' THEN 
        (CASE 
          WHEN Ci1.ID = Ci2.ID THEN
            (CASE 
              WHEN A1.HouseNr <> '' THEN Ci1.Name + ' ' + A1.HouseNr + (CASE A1.AppartmentNr WHEN '' THEN '' ELSE '/' + A1.AppartmentNr END) + CHAR(13) + CHAR(10)
            END)
          ELSE Ci1.Name + ' ' + A1.HouseNr + (CASE A1.AppartmentNr WHEN '' THEN '' ELSE '/' + A1.AppartmentNr END) + CHAR(13) + CHAR(10)
        END)
      ELSE 
        (CASE 
          WHEN Ci1.Name = A1.Street THEN A1.Street + ' ' + A1.HouseNr + (CASE A1.AppartmentNr WHEN '' THEN '' ELSE '/' + A1.AppartmentNr END) + CHAR(13) + CHAR(10)
          ELSE 
            (CASE
              WHEN Ci1.ID = Ci2.ID THEN A1.Street + ' ' + A1.HouseNr + (CASE A1.AppartmentNr WHEN '' THEN '' ELSE '/' + A1.AppartmentNr END) + CHAR(13) + CHAR(10)
              ELSE Ci1.Name + ', ' + A1.Street + ' ' + A1.HouseNr + (CASE A1.AppartmentNr WHEN '' THEN '' ELSE '/' + A1.AppartmentNr END) + CHAR(13) + CHAR(10)
            END)
        END)
    END) +
           (CASE WHEN A1.PostOfficeBox IS NOT NULL AND A1.PostOfficeBox <> '' THEN 'skr. poczt. ' + A1.PostOfficeBox + CHAR(13) + CHAR(10) ELSE '' END)  +
            A1.PostalCode +  ' ' + Ci2.Name +
            (CASE WHEN (Co1.ID <> 270) THEN CHAR(13) + CHAR(10) +  Co1.Name ELSE '' END)
END)

FROM OAddress AS A1 INNER JOIN
           RAddressCompany AS AC1 ON (AC1.R1AddressID = A1.ID AND AC1.TypeID = 2 AND AC1.R2CompanyID = C1.ID AND AC1.IsDefault = 1) LEFT JOIN
           LCity AS Ci1 ON Ci1.ID = A1.CityID LEFT JOIN
           LCity AS Ci2 ON Ci2.ID = A1.PostOfficeID LEFT JOIN
           LCountry AS Co1 ON Co1.ID = A1.CountryID
) AS Adres,

/*                          (SELECT     TOP 1 A1.Street + ' ' + A1.HouseNr + CASE A1.AppartmentNr WHEN '' THEN '' ELSE '/' + A1.AppartmentNr END + CHAR(13) + CHAR(10) 
                                                   + (CASE WHEN A1.PostOfficeBox IS NOT NULL AND A1.PostOfficeBox <> '' THEN 'skr. poczt. ' + A1.PostOfficeBox + CHAR(13) + CHAR(10) 
                                                   ELSE '' END) + A1.PostalCode + (CASE WHEN Ci1.Name IS NOT NULL THEN ' ' + Ci1.Name ELSE '' END) + (CASE WHEN (Co1.ID <> 270) 
                                                   THEN CHAR(13) + CHAR(10) + Co1.Name ELSE '' END) AS Expr1
                            FROM          dbo.OAddress AS A1 INNER JOIN
                                                   dbo.RAddressCompany AS AC1 ON AC1.R1AddressID = A1.ID LEFT OUTER JOIN
                                                   dbo.LCity AS Ci1 ON Ci1.ID = A1.CityID LEFT OUTER JOIN
                                                   dbo.LCountry AS Co1 ON Co1.ID = A1.CountryID
                            WHERE      (AC1.TypeID = 2) AND (AC1.R2CompanyID = C1.ID) AND (AC1.IsDefault = 1)) AS Adres, */

'' AS NazwaFirmy, '' AS NazwaDzialu
FROM         dbo.OFlag AS F1 INNER JOIN
                      dbo.RFlagCompany AS FC ON FC.R1FlagID = F1.ID INNER JOIN
                      dbo.RFlagTypeFlag AS FTF1 ON FTF1.R2FlagID = F1.ID INNER JOIN
                      dbo.OCompany AS C1 ON C1.ID = FC.R2CompanyID INNER JOIN
                      dbo.OObjectTag AS OT ON OT.ObjectId = F1.ID
WHERE     (FTF1.R1FlagTypeID = 1) AND (OT.TagId = 23 OR
                      OT.TagId = 33) AND (OT.ObjectCode = 'OFlag') AND (OT.CreatedBy = 191)
UNION ALL
SELECT DISTINCT (CASE WHEN PT1.Name IS NOT NULL THEN PT1.Name + ' ' ELSE '' END) + P1.FirstName + ' ' + P1.Surname AS Odbiorca,
 
(SELECT TOP 1
(CASE
  WHEN A1.PostOfficeID IS NULL THEN
             A1.Street + ' ' + A1.HouseNr + (CASE A1.AppartmentNr WHEN '' THEN '' ELSE '/' + A1.AppartmentNr END) + CHAR(13) + CHAR(10) +
            (CASE WHEN A1.PostOfficeBox IS NOT NULL AND A1.PostOfficeBox <> '' THEN 'skr. poczt. ' + A1.PostOfficeBox + CHAR(13) + CHAR(10) ELSE '' END)  +
            A1.PostalCode +  (CASE WHEN Ci1.Name IS NOT NULL THEN ' ' + Ci1.Name ELSE '' END) +
            (CASE WHEN (Co1.ID <> 270) THEN CHAR(13) + CHAR(10) +  Co1.Name ELSE '' END)
  ELSE
    (CASE 
      WHEN A1.Street = '' THEN 
        (CASE 
          WHEN Ci1.ID = Ci2.ID THEN
            (CASE 
              WHEN A1.HouseNr <> '' THEN Ci1.Name + ' ' + A1.HouseNr + (CASE A1.AppartmentNr WHEN '' THEN '' ELSE '/' + A1.AppartmentNr END) + CHAR(13) + CHAR(10)
            END)
          ELSE Ci1.Name + ' ' + A1.HouseNr + (CASE A1.AppartmentNr WHEN '' THEN '' ELSE '/' + A1.AppartmentNr END) + CHAR(13) + CHAR(10)
        END)
      ELSE 
        (CASE 
          WHEN Ci1.Name = A1.Street THEN A1.Street + ' ' + A1.HouseNr + (CASE A1.AppartmentNr WHEN '' THEN '' ELSE '/' + A1.AppartmentNr END) + CHAR(13) + CHAR(10)
          ELSE 
            (CASE
              WHEN Ci1.ID = Ci2.ID THEN A1.Street + ' ' + A1.HouseNr + (CASE A1.AppartmentNr WHEN '' THEN '' ELSE '/' + A1.AppartmentNr END) + CHAR(13) + CHAR(10)
              ELSE Ci1.Name + ', ' + A1.Street + ' ' + A1.HouseNr + (CASE A1.AppartmentNr WHEN '' THEN '' ELSE '/' + A1.AppartmentNr END) + CHAR(13) + CHAR(10)
            END)
        END)
    END) +
           (CASE WHEN A1.PostOfficeBox IS NOT NULL AND A1.PostOfficeBox <> '' THEN 'skr. poczt. ' + A1.PostOfficeBox + CHAR(13) + CHAR(10) ELSE '' END)  +
            A1.PostalCode +  ' ' + Ci2.Name +
            (CASE WHEN (Co1.ID <> 270) THEN CHAR(13) + CHAR(10) +  Co1.Name ELSE '' END)
END)

FROM OAddress AS A1 INNER JOIN
           RAddressPerson AS AC1 ON (AC1.R1AddressID = A1.ID AND AC1.TypeID = 2 AND AC1.R2PersonID = P1.ID AND AC1.IsDefault = 1) LEFT JOIN
           LCity AS Ci1 ON Ci1.ID = A1.CityID LEFT JOIN
           LCity AS Ci2 ON Ci2.ID = A1.PostOfficeID LEFT JOIN
           LCountry AS Co1 ON Co1.ID = A1.CountryID
) AS Adres,

/*                         (SELECT     TOP 1 A1.Street + ' ' + A1.HouseNr + CASE A1.AppartmentNr WHEN '' THEN '' ELSE '/' + A1.AppartmentNr END + CHAR(13) + CHAR(10) 
                                                   + (CASE WHEN A1.PostOfficeBox IS NOT NULL AND A1.PostOfficeBox <> '' THEN 'skr. poczt. ' + A1.PostOfficeBox + CHAR(13) + CHAR(10) 
                                                   ELSE '' END) + A1.PostalCode + (CASE WHEN Ci1.Name IS NOT NULL THEN ' ' + Ci1.Name ELSE '' END) + (CASE WHEN (Co1.ID <> 270) 
                                                   THEN CHAR(13) + CHAR(10) + Co1.Name ELSE '' END) AS Expr1
                            FROM          dbo.OAddress AS A1 INNER JOIN
                                                   dbo.RAddressPerson AS AC1 ON AC1.R1AddressID = A1.ID LEFT OUTER JOIN
                                                   dbo.LCity AS Ci1 ON Ci1.ID = A1.CityID LEFT OUTER JOIN
                                                   dbo.LCountry AS Co1 ON Co1.ID = A1.CountryID
                            WHERE      (AC1.TypeID = 2) AND (AC1.R2PersonID = P1.ID) AND (AC1.IsDefault = 1)) AS Adres, */ 

'' AS NazwaFirmy, '' AS NazwaDzialu
FROM         dbo.OFlag AS F1 INNER JOIN
                      dbo.RFlagPerson AS FP ON FP.R1FlagID = F1.ID INNER JOIN
                      dbo.RFlagTypeFlag AS FTF1 ON FTF1.R2FlagID = F1.ID INNER JOIN
                      dbo.OPerson AS P1 ON P1.ID = FP.R2PersonID LEFT OUTER JOIN
                      dbo.LPersonTitle AS PT1 ON PT1.Id = P1.TitleId INNER JOIN
                      dbo.OObjectTag AS OT ON OT.ObjectId = F1.ID
WHERE     (FTF1.R1FlagTypeID = 2) AND (OT.TagId = 23 OR
                      OT.TagId = 33) AND (OT.ObjectCode = 'OFlag') AND (OT.CreatedBy = 191)
UNION ALL
SELECT DISTINCT (CASE WHEN PT1.Name IS NOT NULL THEN PT1.Name + ' ' ELSE '' END) + P1.FirstName + ' ' + P1.Surname AS Odbiorca,

(SELECT TOP 1
(CASE
  WHEN A1.PostOfficeID IS NULL THEN
             A1.Street + ' ' + A1.HouseNr + (CASE A1.AppartmentNr WHEN '' THEN '' ELSE '/' + A1.AppartmentNr END) + CHAR(13) + CHAR(10) +
            (CASE WHEN A1.PostOfficeBox IS NOT NULL AND A1.PostOfficeBox <> '' THEN 'skr. poczt. ' + A1.PostOfficeBox + CHAR(13) + CHAR(10) ELSE '' END)  +
            A1.PostalCode +  (CASE WHEN Ci1.Name IS NOT NULL THEN ' ' + Ci1.Name ELSE '' END) +
            (CASE WHEN (Co1.ID <> 270) THEN CHAR(13) + CHAR(10) +  Co1.Name ELSE '' END)
  ELSE
    (CASE 
      WHEN A1.Street = '' THEN 
        (CASE 
          WHEN Ci1.ID = Ci2.ID THEN
            (CASE 
              WHEN A1.HouseNr <> '' THEN Ci1.Name + ' ' + A1.HouseNr + (CASE A1.AppartmentNr WHEN '' THEN '' ELSE '/' + A1.AppartmentNr END) + CHAR(13) + CHAR(10)
            END)
          ELSE Ci1.Name + ' ' + A1.HouseNr + (CASE A1.AppartmentNr WHEN '' THEN '' ELSE '/' + A1.AppartmentNr END) + CHAR(13) + CHAR(10)
        END)
      ELSE 
        (CASE 
          WHEN Ci1.Name = A1.Street THEN A1.Street + ' ' + A1.HouseNr + (CASE A1.AppartmentNr WHEN '' THEN '' ELSE '/' + A1.AppartmentNr END) + CHAR(13) + CHAR(10)
          ELSE 
            (CASE
              WHEN Ci1.ID = Ci2.ID THEN A1.Street + ' ' + A1.HouseNr + (CASE A1.AppartmentNr WHEN '' THEN '' ELSE '/' + A1.AppartmentNr END) + CHAR(13) + CHAR(10)
              ELSE Ci1.Name + ', ' + A1.Street + ' ' + A1.HouseNr + (CASE A1.AppartmentNr WHEN '' THEN '' ELSE '/' + A1.AppartmentNr END) + CHAR(13) + CHAR(10)
            END)
        END)
    END) +
           (CASE WHEN A1.PostOfficeBox IS NOT NULL AND A1.PostOfficeBox <> '' THEN 'skr. poczt. ' + A1.PostOfficeBox + CHAR(13) + CHAR(10) ELSE '' END)  +
            A1.PostalCode +  ' ' + Ci2.Name +
            (CASE WHEN (Co1.ID <> 270) THEN CHAR(13) + CHAR(10) +  Co1.Name ELSE '' END)
END)

FROM OAddress AS A1 INNER JOIN
           RAddressCompany AS AC1 ON (AC1.R1AddressID = A1.ID AND AC1.TypeID = 2 AND AC1.R2CompanyID = C.ID AND AC1.IsDefault = 1) LEFT JOIN
           LCity AS Ci1 ON Ci1.ID = A1.CityID LEFT JOIN
           LCity AS Ci2 ON Ci2.ID = A1.PostOfficeID LEFT JOIN
           LCountry AS Co1 ON Co1.ID = A1.CountryID
) AS Adres,

/*                          (SELECT     TOP 1 A1.Street + ' ' + A1.HouseNr + CASE A1.AppartmentNr WHEN '' THEN '' ELSE '/' + A1.AppartmentNr END + CHAR(13) + CHAR(10) 
                                                   + (CASE WHEN A1.PostOfficeBox IS NOT NULL AND A1.PostOfficeBox <> '' THEN 'skr. poczt. ' + A1.PostOfficeBox + CHAR(13) + CHAR(10) 
                                                   ELSE '' END) + A1.PostalCode + (CASE WHEN Ci1.Name IS NOT NULL THEN ' ' + Ci1.Name ELSE '' END) + (CASE WHEN (Co1.ID <> 270) 
                                                   THEN CHAR(13) + CHAR(10) + Co1.Name ELSE '' END) AS Expr1
                            FROM          dbo.OAddress AS A1 INNER JOIN
                                                   dbo.RAddressCompany AS AC1 ON AC1.R1AddressID = A1.ID LEFT OUTER JOIN
                                                   dbo.LCity AS Ci1 ON Ci1.ID = A1.CityID LEFT OUTER JOIN
                                                   dbo.LCountry AS Co1 ON Co1.ID = A1.CountryID
                            WHERE      (AC1.TypeID = 2) AND (AC1.R2CompanyID = C.ID) AND (AC1.IsDefault = 1)) AS Adres, */ 

C.DerivedFullName, '' AS NazwaDzialu
FROM         dbo.OFlag AS F1 INNER JOIN
                      dbo.RFlagCompanyPerson AS FCP1 ON FCP1.R1FlagId = F1.ID INNER JOIN
                      dbo.RCompanyPerson AS CP1 ON CP1.ID = FCP1.R2CompanyPersonId INNER JOIN
                      dbo.RFlagTypeFlag AS FTF1 ON FTF1.R2FlagID = F1.ID INNER JOIN
                      dbo.OPerson AS P1 ON CP1.R2PersonID = P1.ID INNER JOIN
                      dbo.OCompany AS C ON C.ID = CP1.R1CompanyID LEFT OUTER JOIN
                      dbo.LPersonTitle AS PT1 ON PT1.Id = P1.TitleId INNER JOIN
                      dbo.OObjectTag AS OT ON OT.ObjectId = F1.ID
WHERE     (FTF1.R1FlagTypeID = 7) AND (OT.TagId = 23 OR
                      OT.TagId = 33) AND (OT.ObjectCode = 'OFlag') AND (OT.CreatedBy = 191)
GO
GRANT SELECT ON [ASTOR\ANNAS].[vEtykietyMCH] TO [BDKProgramyZewnetrzne]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\ANNAS].[vFirmsEKD]
AS
SELECT     C.ID, LEFT(BA.Code, 2) AS EKD
FROM         dbo.OCompany AS C INNER JOIN
                      dbo.RCompanyBusinessActivity AS CBA ON CBA.R1CompanyId = C.ID INNER JOIN
                      dbo.TBusinessActivity AS BA ON BA.Id = CBA.R2BusinessActivityId AND LEN(BA.Code) >= 2
UNION
SELECT     C.ID, LEFT(BA.Code, 3) AS EKD
FROM         dbo.OCompany AS C INNER JOIN
                      dbo.RCompanyBusinessActivity AS CBA ON CBA.R1CompanyId = C.ID INNER JOIN
                      dbo.TBusinessActivity AS BA ON BA.Id = CBA.R2BusinessActivityId AND LEN(BA.Code) >= 3
UNION
SELECT     C.ID, LEFT(BA.Code, 4) AS EKD
FROM         dbo.OCompany AS C INNER JOIN
                      dbo.RCompanyBusinessActivity AS CBA ON CBA.R1CompanyId = C.ID INNER JOIN
                      dbo.TBusinessActivity AS BA ON BA.Id = CBA.R2BusinessActivityId AND LEN(BA.Code) >= 4
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\ANNAS].[vFlagsFirms]
AS
SELECT     FC.Guid AS ID, F.Guid AS FlagID, C.Guid AS FirmID, C.Description AS Info, FC.ModifiedOn
FROM         dbo.RFlagCompany AS FC INNER JOIN
                      dbo.OFlag AS F ON F.ID = FC.R1FlagID INNER JOIN
                      dbo.OCompany AS C ON C.ID = FC.R2CompanyID
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\ANNAS].[vFlagsGroups]
AS
SELECT     TOP 100 PERCENT Guid AS ID, Name, '1' AS [Index]
FROM         dbo.TFlagHierarchy
ORDER BY Name
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\ANNAS].[vFlagsPersons]
AS
SELECT     FCP.Guid AS ID, F.Guid AS FlagID, P.Guid AS PersonID, P.Description AS Info, FCP.ModifiedOn
FROM         dbo.RFlagCompanyPerson AS FCP INNER JOIN
                      dbo.OFlag AS F ON F.ID = FCP.R1FlagId INNER JOIN
                      dbo.RCompanyPerson AS CP ON CP.ID = FCP.R2CompanyPersonId INNER JOIN
                      dbo.OPerson AS P ON P.ID = CP.R2PersonID
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\ANNAS].[View_1]
AS
SELECT     Id, Code, Name
FROM         dbo.OProjectItem AS P
WHERE     (Id NOT IN
                          (SELECT     R2ProjectItemId
                            FROM          dbo.RProjectItemProjectItem))
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\ANNAS].[viewFlags2007]
AS
SELECT     F.ID AS FlagID, F.Guid AS FlagGUID, F.CreatedOn, U.Guid AS UserGUID, U.Nickname AS CreatedBy, FH.Name AS GroupName, F.Name AS FlagName, 
                      F.Description, FT.Guid AS FlagTypeGUID, FT.Description AS FlagType, FT.ID AS FlagTypeID, C.ID AS ObjectID, 
                      C.DerivedFullName AS ObjectName
FROM         dbo.OFlag AS F INNER JOIN
                      dbo.RFlagTypeFlag AS FTF ON FTF.R2FlagID = F.ID AND FTF.R1FlagTypeID = 1 INNER JOIN
                      dbo.LFlagType AS FT ON FT.ID = FTF.R1FlagTypeID INNER JOIN
                      dbo.TFlagHierarchy AS FH ON FH.ID = F.GroupId INNER JOIN
                      dbo.OUser AS U ON U.ID = F.CreatedBy INNER JOIN
                      dbo.RFlagCompany AS FC ON FC.R1FlagID = F.ID INNER JOIN
                      dbo.OCompany AS C ON C.ID = FC.R2CompanyID
WHERE     (YEAR(F.CreatedOn) = 2007)
UNION ALL
SELECT     F.ID AS FlagID, F.Guid AS FlagGUID, F.CreatedOn, U.Guid AS UserGUID, U.Nickname AS CreatedBy, FH.Name AS GroupName, F.Name AS FlagName, 
                      F.Description, FT.Guid AS FlagTypeGUID, FT.Description AS FlagType, FT.ID AS FlagTypeID, CP.ID AS ObjectID, 
                      P.Surname + ' ' + P.FirstName + ', ' + C.DerivedFullName AS ObjectName
FROM         dbo.OFlag AS F INNER JOIN
                      dbo.RFlagTypeFlag AS FTF ON FTF.R2FlagID = F.ID AND FTF.R1FlagTypeID = 7 INNER JOIN
                      dbo.LFlagType AS FT ON FT.ID = FTF.R1FlagTypeID INNER JOIN
                      dbo.TFlagHierarchy AS FH ON FH.ID = F.GroupId INNER JOIN
                      dbo.OUser AS U ON U.ID = F.CreatedBy INNER JOIN
                      dbo.RFlagCompanyPerson AS FCP ON FCP.R1FlagId = F.ID INNER JOIN
                      dbo.RCompanyPerson AS CP ON CP.ID = FCP.R2CompanyPersonId INNER JOIN
                      dbo.OCompany AS C ON C.ID = CP.R1CompanyID INNER JOIN
                      dbo.OPerson AS P ON P.ID = CP.R2PersonID
WHERE     (YEAR(F.CreatedOn) = 2007)
UNION ALL
SELECT     F.ID AS FlagID, F.Guid AS FlagGUID, F.CreatedOn, U.Guid AS UserGUID, U.Nickname AS CreatedBy, FH.Name AS GroupName, F.Name AS FlagName, 
                      F.Description, FT.Guid AS FlagTypeGUID, FT.Description AS FlagType, FT.ID AS FlagTypeID, P.ID AS ObjectID, 
                      P.Surname + ' ' + P.FirstName AS ObjectName
FROM         dbo.OFlag AS F INNER JOIN
                      dbo.RFlagTypeFlag AS FTF ON FTF.R2FlagID = F.ID AND FTF.R1FlagTypeID = 2 INNER JOIN
                      dbo.LFlagType AS FT ON FT.ID = FTF.R1FlagTypeID INNER JOIN
                      dbo.TFlagHierarchy AS FH ON FH.ID = F.GroupId INNER JOIN
                      dbo.OUser AS U ON U.ID = F.CreatedBy INNER JOIN
                      dbo.RFlagPerson AS FP ON FP.R1FlagID = F.ID INNER JOIN
                      dbo.OPerson AS P ON P.ID = FP.R2PersonID
WHERE     (YEAR(F.CreatedOn) = 2007)
UNION ALL
SELECT     F.ID AS FlagID, F.Guid AS FlagGUID, F.CreatedOn, U.Guid AS UserGUID, U.Nickname AS CreatedBy, FH.Name AS GroupName, F.Name AS FlagName, 
                      F.Description, FT.Guid AS FlagTypeGUID, FT.Description AS FlagType, FT.ID AS FlagTypeID, N.ID AS ObjectID, N.Summary AS ObjectName
FROM         dbo.OFlag AS F INNER JOIN
                      dbo.RFlagTypeFlag AS FTF ON FTF.R2FlagID = F.ID AND FTF.R1FlagTypeID = 4 INNER JOIN
                      dbo.LFlagType AS FT ON FT.ID = FTF.R1FlagTypeID INNER JOIN
                      dbo.TFlagHierarchy AS FH ON FH.ID = F.GroupId INNER JOIN
                      dbo.OUser AS U ON U.ID = F.CreatedBy INNER JOIN
                      dbo.RFlagNote AS FN ON FN.R1FlagId = F.ID INNER JOIN
                      dbo.ONote AS N ON N.ID = FN.R2NoteId
WHERE     (YEAR(F.CreatedOn) = 2007)
UNION ALL
SELECT     F.ID AS FlagID, F.Guid AS FlagGUID, F.CreatedOn, U.Guid AS UserGUID, U.Nickname AS CreatedBy, FH.Name AS GroupName, F.Name AS FlagName, 
                      F.Description, FT.Guid AS FlagTypeGUID, FT.Description AS FlagType, FT.ID AS FlagTypeID, SI.ID AS ObjectID, SI.Description AS ObjectName
FROM         dbo.OFlag AS F INNER JOIN
                      dbo.RFlagTypeFlag AS FTF ON FTF.R2FlagID = F.ID AND FTF.R1FlagTypeID = 5 INNER JOIN
                      dbo.LFlagType AS FT ON FT.ID = FTF.R1FlagTypeID INNER JOIN
                      dbo.TFlagHierarchy AS FH ON FH.ID = F.GroupId INNER JOIN
                      dbo.OUser AS U ON U.ID = F.CreatedBy INNER JOIN
                      dbo.RFlagSupportIssue AS FSI ON FSI.R1FlagId = F.ID INNER JOIN
                      dbo.OSupportIssue AS SI ON SI.ID = FSI.R2SupportIssueId
WHERE     (YEAR(F.CreatedOn) = 2007)
UNION ALL
SELECT     F.ID AS FlagID, F.Guid AS FlagGUID, F.CreatedOn, U.Guid AS UserGUID, U.Nickname AS CreatedBy, FH.Name AS GroupName, F.Name AS FlagName, 
                      F.Description, FT.Guid AS FlagTypeGUID, FT.Description AS FlagType, FT.ID AS FlagTypeID, PRI.Id AS ObjectID, PRI.Name AS ObjectName
FROM         dbo.OFlag AS F INNER JOIN
                      dbo.RFlagTypeFlag AS FTF ON FTF.R2FlagID = F.ID AND FTF.R1FlagTypeID = 6 INNER JOIN
                      dbo.LFlagType AS FT ON FT.ID = FTF.R1FlagTypeID INNER JOIN
                      dbo.TFlagHierarchy AS FH ON FH.ID = F.GroupId INNER JOIN
                      dbo.OUser AS U ON U.ID = F.CreatedBy INNER JOIN
                      dbo.RFlagProjectItem AS FPI ON FPI.R1FlagId = F.ID INNER JOIN
                      dbo.OProjectItem AS PRI ON PRI.Id = FPI.R2ProjectItemId
WHERE     (YEAR(F.CreatedOn) = 2007)
UNION ALL
SELECT     F.ID AS FlagID, F.Guid AS FlagGUID, F.CreatedOn, U.Guid AS UserGUID, U.Nickname AS CreatedBy, FH.Name AS GroupName, F.Name AS FlagName, 
                      F.Description, FT.Guid AS FlagTypeGUID, FT.Description AS FlagType, FT.ID AS FlagTypeID, PA.ID AS ObjectID, PA.Title AS ObjectName
FROM         dbo.OFlag AS F INNER JOIN
                      dbo.RFlagTypeFlag AS FTF ON FTF.R2FlagID = F.ID AND FTF.R1FlagTypeID = 23 INNER JOIN
                      dbo.LFlagType AS FT ON FT.ID = FTF.R1FlagTypeID INNER JOIN
                      dbo.TFlagHierarchy AS FH ON FH.ID = F.GroupId INNER JOIN
                      dbo.OUser AS U ON U.ID = F.CreatedBy INNER JOIN
                      dbo.RFlagArticle AS FA ON FA.R1FlagId = F.ID INNER JOIN
                      dbo.OArticle AS PA ON PA.ID = FA.R2ArticleId
WHERE     (YEAR(F.CreatedOn) = 2007)
UNION ALL
SELECT     F.ID AS FlagID, F.Guid AS FlagGUID, F.CreatedOn, U.Guid AS UserGUID, U.Nickname AS CreatedBy, FH.Name AS GroupName, F.Name AS FlagName, 
                      F.Description, FT.Guid AS FlagTypeGUID, FT.Description AS FlagType, FT.ID AS FlagTypeID, P.ID AS ObjectID, P.Code AS ObjectName
FROM         dbo.OFlag AS F INNER JOIN
                      dbo.RFlagTypeFlag AS FTF ON FTF.R2FlagID = F.ID AND FTF.R1FlagTypeID = 33 INNER JOIN
                      dbo.LFlagType AS FT ON FT.ID = FTF.R1FlagTypeID INNER JOIN
                      dbo.TFlagHierarchy AS FH ON FH.ID = F.GroupId INNER JOIN
                      dbo.OUser AS U ON U.ID = F.CreatedBy INNER JOIN
                      dbo.RFlagProduct AS FP ON FP.R1FlagId = F.ID INNER JOIN
                      dbo.OProduct AS P ON P.ID = FP.R2ProductId
WHERE     (YEAR(F.CreatedOn) = 2007)
UNION ALL
SELECT     F.ID AS FlagID, F.Guid AS FlagGUID, F.CreatedOn, U.Guid AS UserGUID, U.Nickname AS CreatedBy, FH.Name AS GroupName, F.Name AS FlagName, 
                      F.Description, FT.Guid AS FlagTypeGUID, FT.Description AS FlagType, FT.ID AS FlagTypeID, PH.ID AS ObjectID, PH.Name AS ObjectName
FROM         dbo.OFlag AS F INNER JOIN
                      dbo.RFlagTypeFlag AS FTF ON FTF.R2FlagID = F.ID AND FTF.R1FlagTypeID = 43 INNER JOIN
                      dbo.LFlagType AS FT ON FT.ID = FTF.R1FlagTypeID INNER JOIN
                      dbo.TFlagHierarchy AS FH ON FH.ID = F.GroupId INNER JOIN
                      dbo.OUser AS U ON U.ID = F.CreatedBy INNER JOIN
                      dbo.RFlagProductHierarchy AS FPH ON FPH.R1FlagId = F.ID INNER JOIN
                      dbo.TProductHierarchy AS PH ON PH.ID = FPH.R2ProductHierarchyId
WHERE     (YEAR(F.CreatedOn) = 2007)
UNION ALL
SELECT     F.ID AS FlagID, F.Guid AS FlagGUID, F.CreatedOn, U.Guid AS UserGUID, U.Nickname AS CreatedBy, FH.Name AS GroupName, F.Name AS FlagName, 
                      F.Description, FT.Guid AS FlagTypeGUID, FT.Description AS FlagType, FT.ID AS FlagTypeID, L.ID AS ObjectID, L.Path AS ObjectName
FROM         dbo.OFlag AS F INNER JOIN
                      dbo.RFlagTypeFlag AS FTF ON FTF.R2FlagID = F.ID AND FTF.R1FlagTypeID = 43 INNER JOIN
                      dbo.LFlagType AS FT ON FT.ID = FTF.R1FlagTypeID INNER JOIN
                      dbo.TFlagHierarchy AS FH ON FH.ID = F.GroupId INNER JOIN
                      dbo.OUser AS U ON U.ID = F.CreatedBy INNER JOIN
                      dbo.RFlagLink AS FL ON FL.R1FlagId = F.ID INNER JOIN
                      dbo.OLink AS L ON L.ID = FL.R2LinkId
WHERE     (YEAR(F.CreatedOn) = 2007)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\ANNAS].[viewFlags2008]
AS
SELECT     F.ID AS FlagID, F.Guid AS FlagGUID, F.CreatedOn, U.Guid AS UserGUID, U.Nickname AS CreatedBy, FH.Name AS GroupName, F.Name AS FlagName, 
                      F.Description, FT.Guid AS FlagTypeGUID, FT.Description AS FlagType, FT.ID AS FlagTypeID, C.ID AS ObjectID, 
                      C.DerivedFullName AS ObjectName
FROM         dbo.OFlag AS F INNER JOIN
                      dbo.RFlagTypeFlag AS FTF ON FTF.R2FlagID = F.ID AND FTF.R1FlagTypeID = 1 INNER JOIN
                      dbo.LFlagType AS FT ON FT.ID = FTF.R1FlagTypeID INNER JOIN
                      dbo.TFlagHierarchy AS FH ON FH.ID = F.GroupId INNER JOIN
                      dbo.OUser AS U ON U.ID = F.CreatedBy INNER JOIN
                      dbo.RFlagCompany AS FC ON FC.R1FlagID = F.ID INNER JOIN
                      dbo.OCompany AS C ON C.ID = FC.R2CompanyID
WHERE     (YEAR(F.CreatedOn) = 2008) AND (F.ID <> 1673) AND (F.ID <> 1342) AND (F.ID <> 1346) AND (F.ID <> 1344) AND (F.ID <> 1473) AND (F.ID <> 1343)
UNION ALL
SELECT     F.ID AS FlagID, F.Guid AS FlagGUID, F.CreatedOn, U.Guid AS UserGUID, U.Nickname AS CreatedBy, FH.Name AS GroupName, F.Name AS FlagName, 
                      F.Description, FT.Guid AS FlagTypeGUID, FT.Description AS FlagType, FT.ID AS FlagTypeID, CP.ID AS ObjectID, 
                      P.Surname + ' ' + P.FirstName + ', ' + C.DerivedFullName AS ObjectName
FROM         dbo.OFlag AS F INNER JOIN
                      dbo.RFlagTypeFlag AS FTF ON FTF.R2FlagID = F.ID AND FTF.R1FlagTypeID = 7 INNER JOIN
                      dbo.LFlagType AS FT ON FT.ID = FTF.R1FlagTypeID INNER JOIN
                      dbo.TFlagHierarchy AS FH ON FH.ID = F.GroupId INNER JOIN
                      dbo.OUser AS U ON U.ID = F.CreatedBy INNER JOIN
                      dbo.RFlagCompanyPerson AS FCP ON FCP.R1FlagId = F.ID INNER JOIN
                      dbo.RCompanyPerson AS CP ON CP.ID = FCP.R2CompanyPersonId INNER JOIN
                      dbo.OCompany AS C ON C.ID = CP.R1CompanyID INNER JOIN
                      dbo.OPerson AS P ON P.ID = CP.R2PersonID
WHERE     (YEAR(F.CreatedOn) = 2008) AND (F.ID <> 1673) AND (F.ID <> 1342) AND (F.ID <> 1346) AND (F.ID <> 1344) AND (F.ID <> 1473) AND (F.ID <> 1343)
UNION ALL
SELECT     F.ID AS FlagID, F.Guid AS FlagGUID, F.CreatedOn, U.Guid AS UserGUID, U.Nickname AS CreatedBy, FH.Name AS GroupName, F.Name AS FlagName, 
                      F.Description, FT.Guid AS FlagTypeGUID, FT.Description AS FlagType, FT.ID AS FlagTypeID, P.ID AS ObjectID, 
                      P.Surname + ' ' + P.FirstName AS ObjectName
FROM         dbo.OFlag AS F INNER JOIN
                      dbo.RFlagTypeFlag AS FTF ON FTF.R2FlagID = F.ID AND FTF.R1FlagTypeID = 2 INNER JOIN
                      dbo.LFlagType AS FT ON FT.ID = FTF.R1FlagTypeID INNER JOIN
                      dbo.TFlagHierarchy AS FH ON FH.ID = F.GroupId INNER JOIN
                      dbo.OUser AS U ON U.ID = F.CreatedBy INNER JOIN
                      dbo.RFlagPerson AS FP ON FP.R1FlagID = F.ID INNER JOIN
                      dbo.OPerson AS P ON P.ID = FP.R2PersonID
WHERE     (YEAR(F.CreatedOn) = 2008) AND (F.ID <> 1673) AND (F.ID <> 1342) AND (F.ID <> 1346) AND (F.ID <> 1344) AND (F.ID <> 1473) AND (F.ID <> 1343)
UNION ALL
SELECT     F.ID AS FlagID, F.Guid AS FlagGUID, F.CreatedOn, U.Guid AS UserGUID, U.Nickname AS CreatedBy, FH.Name AS GroupName, F.Name AS FlagName, 
                      F.Description, FT.Guid AS FlagTypeGUID, FT.Description AS FlagType, FT.ID AS FlagTypeID, N.ID AS ObjectID, N.Summary AS ObjectName
FROM         dbo.OFlag AS F INNER JOIN
                      dbo.RFlagTypeFlag AS FTF ON FTF.R2FlagID = F.ID AND FTF.R1FlagTypeID = 4 INNER JOIN
                      dbo.LFlagType AS FT ON FT.ID = FTF.R1FlagTypeID INNER JOIN
                      dbo.TFlagHierarchy AS FH ON FH.ID = F.GroupId INNER JOIN
                      dbo.OUser AS U ON U.ID = F.CreatedBy INNER JOIN
                      dbo.RFlagNote AS FN ON FN.R1FlagId = F.ID INNER JOIN
                      dbo.ONote AS N ON N.ID = FN.R2NoteId
WHERE     (YEAR(F.CreatedOn) = 2008) AND (F.ID <> 1673) AND (F.ID <> 1342) AND (F.ID <> 1346) AND (F.ID <> 1344) AND (F.ID <> 1473) AND (F.ID <> 1343)
UNION ALL
SELECT     F.ID AS FlagID, F.Guid AS FlagGUID, F.CreatedOn, U.Guid AS UserGUID, U.Nickname AS CreatedBy, FH.Name AS GroupName, F.Name AS FlagName, 
                      F.Description, FT.Guid AS FlagTypeGUID, FT.Description AS FlagType, FT.ID AS FlagTypeID, SI.ID AS ObjectID, SI.Description AS ObjectName
FROM         dbo.OFlag AS F INNER JOIN
                      dbo.RFlagTypeFlag AS FTF ON FTF.R2FlagID = F.ID AND FTF.R1FlagTypeID = 5 INNER JOIN
                      dbo.LFlagType AS FT ON FT.ID = FTF.R1FlagTypeID INNER JOIN
                      dbo.TFlagHierarchy AS FH ON FH.ID = F.GroupId INNER JOIN
                      dbo.OUser AS U ON U.ID = F.CreatedBy INNER JOIN
                      dbo.RFlagSupportIssue AS FSI ON FSI.R1FlagId = F.ID INNER JOIN
                      dbo.OSupportIssue AS SI ON SI.ID = FSI.R2SupportIssueId
WHERE     (YEAR(F.CreatedOn) = 2008) AND (F.ID <> 1673) AND (F.ID <> 1342) AND (F.ID <> 1346) AND (F.ID <> 1344) AND (F.ID <> 1473) AND (F.ID <> 1343)
UNION ALL
SELECT     F.ID AS FlagID, F.Guid AS FlagGUID, F.CreatedOn, U.Guid AS UserGUID, U.Nickname AS CreatedBy, FH.Name AS GroupName, F.Name AS FlagName, 
                      F.Description, FT.Guid AS FlagTypeGUID, FT.Description AS FlagType, FT.ID AS FlagTypeID, PRI.Id AS ObjectID, PRI.Name AS ObjectName
FROM         dbo.OFlag AS F INNER JOIN
                      dbo.RFlagTypeFlag AS FTF ON FTF.R2FlagID = F.ID AND FTF.R1FlagTypeID = 6 INNER JOIN
                      dbo.LFlagType AS FT ON FT.ID = FTF.R1FlagTypeID INNER JOIN
                      dbo.TFlagHierarchy AS FH ON FH.ID = F.GroupId INNER JOIN
                      dbo.OUser AS U ON U.ID = F.CreatedBy INNER JOIN
                      dbo.RFlagProjectItem AS FPI ON FPI.R1FlagId = F.ID INNER JOIN
                      dbo.OProjectItem AS PRI ON PRI.Id = FPI.R2ProjectItemId
WHERE     (YEAR(F.CreatedOn) = 2008) AND (F.ID <> 1673) AND (F.ID <> 1342) AND (F.ID <> 1346) AND (F.ID <> 1344) AND (F.ID <> 1473) AND (F.ID <> 1343)
UNION ALL
SELECT     F.ID AS FlagID, F.Guid AS FlagGUID, F.CreatedOn, U.Guid AS UserGUID, U.Nickname AS CreatedBy, FH.Name AS GroupName, F.Name AS FlagName, 
                      F.Description, FT.Guid AS FlagTypeGUID, FT.Description AS FlagType, FT.ID AS FlagTypeID, PA.ID AS ObjectID, PA.Title AS ObjectName
FROM         dbo.OFlag AS F INNER JOIN
                      dbo.RFlagTypeFlag AS FTF ON FTF.R2FlagID = F.ID AND FTF.R1FlagTypeID = 23 INNER JOIN
                      dbo.LFlagType AS FT ON FT.ID = FTF.R1FlagTypeID INNER JOIN
                      dbo.TFlagHierarchy AS FH ON FH.ID = F.GroupId INNER JOIN
                      dbo.OUser AS U ON U.ID = F.CreatedBy INNER JOIN
                      dbo.RFlagArticle AS FA ON FA.R1FlagId = F.ID INNER JOIN
                      dbo.OArticle AS PA ON PA.ID = FA.R2ArticleId
WHERE     (YEAR(F.CreatedOn) = 2008) AND (F.ID <> 1673) AND (F.ID <> 1342) AND (F.ID <> 1346) AND (F.ID <> 1344) AND (F.ID <> 1473) AND (F.ID <> 1343)
UNION ALL
SELECT     F.ID AS FlagID, F.Guid AS FlagGUID, F.CreatedOn, U.Guid AS UserGUID, U.Nickname AS CreatedBy, FH.Name AS GroupName, F.Name AS FlagName, 
                      F.Description, FT.Guid AS FlagTypeGUID, FT.Description AS FlagType, FT.ID AS FlagTypeID, P.ID AS ObjectID, P.Code AS ObjectName
FROM         dbo.OFlag AS F INNER JOIN
                      dbo.RFlagTypeFlag AS FTF ON FTF.R2FlagID = F.ID AND FTF.R1FlagTypeID = 33 INNER JOIN
                      dbo.LFlagType AS FT ON FT.ID = FTF.R1FlagTypeID INNER JOIN
                      dbo.TFlagHierarchy AS FH ON FH.ID = F.GroupId INNER JOIN
                      dbo.OUser AS U ON U.ID = F.CreatedBy INNER JOIN
                      dbo.RFlagProduct AS FP ON FP.R1FlagId = F.ID INNER JOIN
                      dbo.OProduct AS P ON P.ID = FP.R2ProductId
WHERE     (YEAR(F.CreatedOn) = 2008) AND (F.ID <> 1673) AND (F.ID <> 1342) AND (F.ID <> 1346) AND (F.ID <> 1344) AND (F.ID <> 1473) AND (F.ID <> 1343)
UNION ALL
SELECT     F.ID AS FlagID, F.Guid AS FlagGUID, F.CreatedOn, U.Guid AS UserGUID, U.Nickname AS CreatedBy, FH.Name AS GroupName, F.Name AS FlagName, 
                      F.Description, FT.Guid AS FlagTypeGUID, FT.Description AS FlagType, FT.ID AS FlagTypeID, PH.ID AS ObjectID, PH.Name AS ObjectName
FROM         dbo.OFlag AS F INNER JOIN
                      dbo.RFlagTypeFlag AS FTF ON FTF.R2FlagID = F.ID AND FTF.R1FlagTypeID = 43 INNER JOIN
                      dbo.LFlagType AS FT ON FT.ID = FTF.R1FlagTypeID INNER JOIN
                      dbo.TFlagHierarchy AS FH ON FH.ID = F.GroupId INNER JOIN
                      dbo.OUser AS U ON U.ID = F.CreatedBy INNER JOIN
                      dbo.RFlagProductHierarchy AS FPH ON FPH.R1FlagId = F.ID INNER JOIN
                      dbo.TProductHierarchy AS PH ON PH.ID = FPH.R2ProductHierarchyId
WHERE     (YEAR(F.CreatedOn) = 2008) AND (F.ID <> 1673) AND (F.ID <> 1342) AND (F.ID <> 1346) AND (F.ID <> 1344) AND (F.ID <> 1473) AND (F.ID <> 1343)
UNION ALL
SELECT     F.ID AS FlagID, F.Guid AS FlagGUID, F.CreatedOn, U.Guid AS UserGUID, U.Nickname AS CreatedBy, FH.Name AS GroupName, F.Name AS FlagName, 
                      F.Description, FT.Guid AS FlagTypeGUID, FT.Description AS FlagType, FT.ID AS FlagTypeID, L.ID AS ObjectID, L.Path AS ObjectName
FROM         dbo.OFlag AS F INNER JOIN
                      dbo.RFlagTypeFlag AS FTF ON FTF.R2FlagID = F.ID AND FTF.R1FlagTypeID = 43 INNER JOIN
                      dbo.LFlagType AS FT ON FT.ID = FTF.R1FlagTypeID INNER JOIN
                      dbo.TFlagHierarchy AS FH ON FH.ID = F.GroupId INNER JOIN
                      dbo.OUser AS U ON U.ID = F.CreatedBy INNER JOIN
                      dbo.RFlagLink AS FL ON FL.R1FlagId = F.ID INNER JOIN
                      dbo.OLink AS L ON L.ID = FL.R2LinkId
WHERE     (YEAR(F.CreatedOn) = 2008) AND (F.ID <> 1673) AND (F.ID <> 1342) AND (F.ID <> 1346) AND (F.ID <> 1344) AND (F.ID <> 1473) AND (F.ID <> 1343)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\ANNAS].[viewFlags2009]
AS
SELECT     F.ID AS FlagID, F.Guid AS FlagGUID, F.CreatedOn, U.Guid AS UserGUID, U.Nickname AS CreatedBy, FH.Name AS GroupName, F.Name AS FlagName, 
                      F.Description, FT.Guid AS FlagTypeGUID, FT.Description AS FlagType, FT.ID AS FlagTypeID, C.ID AS ObjectID, 
                      C.DerivedFullName AS ObjectName
FROM         dbo.OFlag AS F INNER JOIN
                      dbo.RFlagTypeFlag AS FTF ON FTF.R2FlagID = F.ID AND FTF.R1FlagTypeID = 1 INNER JOIN
                      dbo.LFlagType AS FT ON FT.ID = FTF.R1FlagTypeID INNER JOIN
                      dbo.TFlagHierarchy AS FH ON FH.ID = F.GroupId INNER JOIN
                      dbo.OUser AS U ON U.ID = F.CreatedBy INNER JOIN
                      dbo.RFlagCompany AS FC ON FC.R1FlagID = F.ID INNER JOIN
                      dbo.OCompany AS C ON C.ID = FC.R2CompanyID
WHERE     (YEAR(F.CreatedOn) = 2009)
UNION ALL
SELECT     F.ID AS FlagID, F.Guid AS FlagGUID, F.CreatedOn, U.Guid AS UserGUID, U.Nickname AS CreatedBy, FH.Name AS GroupName, F.Name AS FlagName, 
                      F.Description, FT.Guid AS FlagTypeGUID, FT.Description AS FlagType, FT.ID AS FlagTypeID, L.ID AS ObjectID, L.Path AS ObjectName
FROM         dbo.OFlag AS F INNER JOIN
                      dbo.RFlagTypeFlag AS FTF ON FTF.R2FlagID = F.ID AND FTF.R1FlagTypeID = 43 INNER JOIN
                      dbo.LFlagType AS FT ON FT.ID = FTF.R1FlagTypeID INNER JOIN
                      dbo.TFlagHierarchy AS FH ON FH.ID = F.GroupId INNER JOIN
                      dbo.OUser AS U ON U.ID = F.CreatedBy INNER JOIN
                      dbo.RFlagLink AS FL ON FL.R1FlagId = F.ID INNER JOIN
                      dbo.OLink AS L ON L.ID = FL.R2LinkId
WHERE     (YEAR(F.CreatedOn) = 2009)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [ASTOR\ANNAS].[ProductHierarchyParent]
(
	
	@ProductHierarchyID bigint
)
RETURNS bigint
AS
BEGIN

declare @x bigint; 
set @x = @ProductHierarchyID;


declare @xPrevParent varchar(36);
declare @xCurrParent varchar(36);
select TOP 1 @xCurrParent = Parent FROM TProductHierarchy WHERE ID = @x;

WHILE (ISNULL((@xCurrParent),'') <> '') AND ISNULL(@xPrevParent,'') <> ISNULL(@xCurrParent,'')
BEGIN
    SELECT TOP 1 @xPrevParent = @xCurrParent, @x=PH2.ID, @xCurrParent = ph2.Parent FROM TProductHierarchy as PH1 INNER JOIN TProductHierarchy as PH2 on cast(PH2.GUID as varchar(36))= PH1.Parent WHERE PH1.ID = @x;
END

RETURN @x
END
GO
GRANT EXECUTE ON [ASTOR\ANNAS].[ProductHierarchyParent] TO [BDKProgramyZewnetrzne]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [ASTOR\ANNAS].[ProjectsParent_Stage] (@ProjectID bigint)
RETURNS bigint
AS
BEGIN

declare @x bigint;
set @x = @ProjectID;

WHILE @x IN (SELECT R2ProjectItemID FROM RProjectItemProjectItem) 
  BEGIN
    set @x = (SELECT R1ProjectItemID FROM RProjectItemProjectItem WHERE R2ProjectItemID = @x)
  END

RETURN @x


END

/*


ALTER FUNCTION [ASTOR\ANNAS].[ProjectsParent_Stage] (@ProjectID bigint )
RETURNS bigint
AS
BEGIN
-- chinska podr?bka
declare @ParentID bigint;
select TOP 1 @ParentID = R1ProjectItemID FROM RProjectItemProjectItem WHERE R2ProjectItemID=@ProjectID;
WHILE @ParentID = 0
	select TOP 1 @ParentID = ISNULL(R1ProjectItemID,0) FROM RProjectItemProjectItem WHERE R2ProjectItemID=@ParentID;
RETURN ISNULL(@ParentID,@ProjectID)




ALTER FUNCTION [ASTOR\ANNAS].[ProjectsParent_Stage] 
(
	@ProjectID bigint
)
RETURNS bigint
AS
BEGIN

declare @x bigint;
set @x = @ProjectID;

WHILE @x IN (SELECT R2ProjectItemID FROM RProjectItemProjectItem) 
  BEGIN
    set @x = (SELECT R1ProjectItemID FROM RProjectItemProjectItem WHERE R2ProjectItemID = @x)
  END

RETURN @x
*/
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\ANNAS].[viewProjects_Stage5]
AS
SELECT     P.Id AS ProjectID, P.Guid AS ProjectGUID, P.CreatedOn, U1.Nickname AS CreatedBy, P.Code AS ProjectCode, P.Name AS ProjectName, 
          E.Name AS ProjectStage, P.EstimatedCost, PR.Code AS ProductCode, PR.Name AS ProductName, TGT.dostawca as ProductVendor, PIP.Quantity AS ProductQuantity, 
          PIP.Value AS ProductValuePLN, '' AS ProductHierarchyName, NULL AS ProductHierarchyValuePLN, CAST(PIP.Value * 60 / 100 /
              (SELECT   Wartosc
                FROM          MegaEnova.dbo.A_CACHE_Raport_ASTOR_KPI
                WHERE      (Parametr = 'K' + TGT.USD_DEM COLLATE polish_ci_as)) AS Money) AS ValueForeignCurrency, TGT.USD_DEM AS ForeignCurrency, 
          P.EstimatedEndDate AS ProjectEstimatedEndDate, (CASE WHEN TGT.USD_DEM = 'EUR' THEN DATEADD(d, 60, P.EstimatedEndDate) 
          WHEN TGT.USD_DEM = 'USD' THEN DATEADD(d, 44, P.EstimatedEndDate) ELSE NULL END) AS EstimatedDate, 
          YEAR((CASE WHEN TGT.USD_DEM = 'EUR' THEN DATEADD(d, 60, P.EstimatedEndDate) WHEN TGT.USD_DEM = 'USD' THEN DATEADD(d, 44, 
          P.EstimatedEndDate) ELSE NULL END)) AS EstimatedYear, MONTH((CASE WHEN TGT.USD_DEM = 'EUR' THEN DATEADD(d, 60, P.EstimatedEndDate) 
          WHEN TGT.USD_DEM = 'USD' THEN DATEADD(d, 44, P.EstimatedEndDate) ELSE NULL END)) AS EstimatedMonth, NULL AS EstimatedHalfMonth, 
          '=HIPER??CZE("bdkv2:ASTOR.Projects.ProjectItem.Details(' + LTRIM(STR(P.Id)) + ')","??cze BDK2")' AS LinkToProject,
		  month(P.EstimatedEndDate) as ProjectEstimatedEndDateMonth,
		  year(P.EstimatedEndDate) as ProjectEstimatedEndDateYear
FROM         dbo.RProjectItemProjectItem AS PP INNER JOIN
          dbo.OProjectItem AS E ON E.Id = PP.R2ProjectItemId AND ((E.Name LIKE 'M5%') or (E.Name LIKE 'M4%')) AND E.StatusId = 2 AND E.Id NOT IN
              (SELECT     PIPI.R1ProjectItemId
                FROM          dbo.RProjectItemProjectItem AS PIPI INNER JOIN
                                       dbo.OProjectItem AS PI1 ON PI1.Id = PIPI.R2ProjectItemId AND PI1.StatusId = 2) INNER JOIN
          dbo.OProjectItem AS P ON P.Id = [ASTOR\ANNAS].ProjectsParent_Stage(PP.R2ProjectItemId) INNER JOIN
          dbo.OUser AS U1 ON U1.ID = P.CreatedBy LEFT OUTER JOIN
          dbo.RProjectItemProduct AS PIP INNER JOIN
          dbo.OProduct AS PR ON PR.ID = PIP.R2ProductId INNER JOIN
          BDK.dbo.TabTowar?w AS TT ON TT.NrKatalogowy COLLATE Polish_CI_AS = PR.Code INNER JOIN
          BDK.dbo.TabGrupTow AS TGT ON TGT.GrupaTow = TT.GrupaTow ON PIP.R1ProjectItemId = P.Id
UNION ALL
SELECT     P.ID AS ProjectID, P.GUID AS ProjectGUID, P.CreatedOn, U1.Nickname AS CreatedBy, P.Code AS ProjectCode, P.Name AS ProjectName, 
          E.Name AS ProjectStage, P.EstimatedCost, '' AS ProductCode, '' AS ProductName, '' AS ProductVendor, 0 AS ProductQuantity, NULL AS ProductValuePLN, 
          PRH.Name AS ProductHierarchyName, PIPH.Value AS ProductHierarchyValuePLN, CAST(PIPH.Value * 60 / 100 /
              (SELECT TOP 1    Wartosc
                FROM          MegaEnova.dbo.A_CACHE_Raport_ASTOR_KPI
                WHERE      (Parametr = 'K' + FQPHA.Answer)) AS Money) AS ValueForeignCurrency, FQPHA.Answer COLLATE Polish_CI_AS AS ForeignCurrency, 
          P.EstimatedEndDate AS ProjectEstimatedEndDate, (CASE WHEN FQPHA.Answer COLLATE Polish_CI_AS = 'EUR' THEN DATEADD(d, 60, 
          P.EstimatedEndDate) WHEN FQPHA.Answer COLLATE Polish_CI_AS = 'USD' THEN DATEADD(d, 44, P.EstimatedEndDate) ELSE NULL END) 
          AS EstimatedDate, YEAR((CASE WHEN FQPHA.Answer COLLATE Polish_CI_AS = 'EUR' THEN DATEADD(d, 60, P.EstimatedEndDate) 
          WHEN FQPHA.Answer COLLATE Polish_CI_AS = 'USD' THEN DATEADD(d, 44, P.EstimatedEndDate) ELSE NULL END)) AS EstimatedYear, 
          MONTH((CASE WHEN FQPHA.Answer COLLATE Polish_CI_AS = 'EUR' THEN DATEADD(d, 60, P.EstimatedEndDate) 
          WHEN FQPHA.Answer COLLATE Polish_CI_AS = 'USD' THEN DATEADD(d, 44, P.EstimatedEndDate) ELSE NULL END)) AS EstimatedMonth, NULL 
          AS EstimatedHalfMonth, '=HIPER??CZE("bdkv2:ASTOR.Projects.ProjectItem.Details(' + ltrim(str(P.ID)) + ')","??cze BDK2")' AS LinkToProject,
		  month(P.EstimatedEndDate) as ProjectEstimatedEndDateMonth,
		  year(P.EstimatedEndDate) as ProjectEstimatedEndDateYear
FROM         RProjectItemProjectItem AS PP INNER JOIN
          OProjectItem AS E ON (E.ID = PP.R2ProjectItemID AND ((E.Name LIKE 'M5%') or (E.Name LIKE 'M4%')) AND E.StatusID = 2 AND E.ID NOT IN
              (SELECT     R1ProjectItemID
                FROM          RProjectItemProjectItem AS PIPI INNER JOIN
                                       OProjectItem AS PI1 ON PI1.ID = R2ProjectItemID AND PI1.StatusID = 2)) INNER JOIN
          OProjectItem AS P ON P.ID = [ASTOR\ANNAS].ProjectsParent_Stage(PP.R2ProjectItemID) INNER JOIN
          OUser AS U1 ON U1.ID = P.CreatedBy INNER JOIN
          RProjectItemProductHierarchy AS PIPH ON PIPH.R1ProjectItemId = P.ID INNER JOIN
          TProductHierarchy AS PRH ON PRH.ID = PIPH.R2ProductHierarchyId INNER JOIN
          TProductHierarchy AS PRH_P ON PRH_P.ID = [ASTOR\ANNAS].ProductHierarchyParent(PRH.ID) LEFT JOIN
          (RFlagProductHierarchy AS FPH INNER JOIN
          RFlagQuestionProductHierarchyAnswer AS FQPHA ON (FQPHA.R2FlagProductHierarchyID = FPH.ID AND FQPHA.R1FlagQuestionID = 167033)) ON 
          FPH.R2ProductHierarchyID = PRH_P.ID
GO
GRANT SELECT ON [ASTOR\ANNAS].[viewProjects_Stage5] TO [ASTOR\Baza nbdk viewers]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\ANNAS].[vNote]
AS
SELECT     C.DerivedFullName AS FirmName, PT.Name AS Prefix, P.FirstName, P.Surname AS LastName, N.Content AS Contact, RIGHT(CONVERT(varchar(8000), 
                      N.Content), 10) AS Dyplom, N.CategoryID, N.Date AS ContactDate
FROM         dbo.ONote AS N INNER JOIN
                      dbo.RNoteCompanyPerson AS NCP ON NCP.R1NoteId = N.ID INNER JOIN
                      dbo.RCompanyPerson AS CP ON CP.ID = NCP.R2CompanyPersonId INNER JOIN
                      dbo.OCompany AS C ON C.ID = CP.R1CompanyID INNER JOIN
                      dbo.OPerson AS P ON P.ID = CP.R2PersonID LEFT OUTER JOIN
                      dbo.LPersonTitle AS PT ON PT.Id = P.TitleId
UNION ALL
SELECT     '' AS FirmName, PT.Name AS Prefix, P.FirstName, P.Surname AS LastName, N.Content AS Contact, RIGHT(CONVERT(varchar(8000), N.Content), 10) 
                      AS Dyplom, N.CategoryID, N.Date AS ContactDate
FROM         dbo.ONote AS N INNER JOIN
                      dbo.RNotePerson AS NP ON NP.R1NoteID = N.ID INNER JOIN
                      dbo.OPerson AS P ON P.ID = NP.R2PersonID LEFT OUTER JOIN
                      dbo.LPersonTitle AS PT ON PT.Id = P.TitleId
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\ANNAS].[vSupportIssue]
AS
SELECT     SI.ID, SI.Guid, SI.ModifiedOn, SI.CreatedOn, U1.Nickname, U2.Nickname AS Expr1, SI.Description, SIS.Name AS Status, SIS.IsFinal AS IsFinalStatus, 
                      SIR.Name AS Resolution
FROM         dbo.OSupportIssue AS SI INNER JOIN
                      dbo.LSupportIssueResolution AS SIR ON SIR.Id = SI.ResolutionId INNER JOIN
                      dbo.LSupportIssueStatus AS SIS ON SIS.Id = SI.StatusId LEFT OUTER JOIN
                      dbo.OUser AS U1 ON U1.ID = SI.ModifiedBy LEFT OUTER JOIN
                      dbo.OUser AS U2 ON U2.ID = SI.CreatedBy
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\JAROSLAWG].[JG_WWSR_Firm]
AS
SELECT     TOP 100 PERCENT dbo.OSupportIssue.ID AS SRID, dbo.OSupportIssue.CreatedOn, dbo.OUser.Nickname, dbo.OCompany.Name AS FirmName, 
                      dbo.OSupportIssue.Description, dbo.LSupportIssueStatus.Name AS SRStatus, dbo.LSupportIssueResolution.Name AS SRResolution, 
                      dbo.OSupportIssue.ModifiedOn, dbo.RSupportIssueCompany.R2CompanyID
FROM         dbo.OUser INNER JOIN
                      dbo.OSupportIssue INNER JOIN
                      dbo.LSupportIssueStatus ON dbo.OSupportIssue.StatusId = dbo.LSupportIssueStatus.Id INNER JOIN
                      dbo.LSupportIssueResolution ON dbo.OSupportIssue.ResolutionId = dbo.LSupportIssueResolution.Id ON 
                      dbo.OUser.ID = dbo.OSupportIssue.ModifiedBy LEFT OUTER JOIN
                      dbo.OCompany LEFT OUTER JOIN
                      dbo.RSupportIssueCompany ON dbo.OCompany.ID = dbo.RSupportIssueCompany.R2CompanyID ON 
                      dbo.OSupportIssue.ID = dbo.RSupportIssueCompany.R1SupportIssueID
WHERE     (dbo.OCompany.Name NOT LIKE '%ASTOR%')
ORDER BY dbo.OSupportIssue.ID DESC
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[viewProjects]
AS
SELECT     P1.Id AS ProjectID, P1.Guid AS ProjectGUID, P1.CreatedOn, US.Nickname AS CreatedBy, P1.Code AS ProjectCode, P1.Name AS ProjectName, 
                      PS.Name AS ProjectStatus, P1.EstimatedEndDate, YEAR(P1.EstimatedEndDate) AS Year, MONTH(P1.EstimatedEndDate) AS Month, P1.EstimatedCost, 
                      P2.Code AS Progress, P2.Name AS ProjectStage, (P1.EstimatedCost * CASE P2.Code WHEN '' THEN 0 ELSE CASE ISNUMERIC(LEFT(P2.Code, LEN(P2.Code) - 1)) 
                      WHEN 1 THEN (CAST(LEFT(P2.Code, LEN(P2.Code) - 1) AS int)) ELSE 0 END END) / 100 AS Weighted, 
                      PER.Surname + ' ' + PER.FirstName AS ProjectManager, CP.ID AS ProjectManagerID, (CASE WHEN (U._MiejsceBazy = 'STA' OR
                      U._MiejsceBazy = 'POZ') THEN 'ZCH' ELSE U._MiejsceBazy END) AS Base, ISNULL(CUS.DerivedFullName, ISNULL(CPIN.DerivedFullName, 
                      ISNULL(CIN.DerivedFullName, CGW.DerivedFullName))) AS Company, ISNULL(PIRUS.Name, ISNULL(PIRPIN.Name, ISNULL(PIRIN.Name, 
                      PIRGW.Name))) AS Role, (CASE WHEN CUS.ID IS NOT NULL THEN
                          (SELECT     TOP 1 FQCA.Answer
                            FROM          RFlagCompany FC INNER JOIN
                                                   RFlagQuestionCompanyAnswer FQCA ON FQCA.R2FlagCompanyID = FC.ID
                            WHERE      FC.R1FlagID = 1344 AND FC.R2CompanyID = CUS.ID AND FQCA.R1FlagQuestionID = 166433) WHEN CPIN.ID IS NOT NULL THEN
                          (SELECT     TOP 1 FQCA.Answer
                            FROM          RFlagCompany FC INNER JOIN
                                                   RFlagQuestionCompanyAnswer FQCA ON FQCA.R2FlagCompanyID = FC.ID
                            WHERE      FC.R1FlagID = 1344 AND FC.R2CompanyID = CPIN.ID AND FQCA.R1FlagQuestionID = 166433) WHEN CIN.ID IS NOT NULL THEN
                          (SELECT     TOP 1 FQCA.Answer
                            FROM          RFlagCompany FC INNER JOIN
                                                   RFlagQuestionCompanyAnswer FQCA ON FQCA.R2FlagCompanyID = FC.ID
                            WHERE      FC.R1FlagID = 1344 AND FC.R2CompanyID = CIN.ID AND FQCA.R1FlagQuestionID = 166433) WHEN CGW.ID IS NOT NULL THEN
                          (SELECT     TOP 1 FQCA.Answer
                            FROM          RFlagCompany FC INNER JOIN
                                                   RFlagQuestionCompanyAnswer FQCA ON FQCA.R2FlagCompanyID = FC.ID
                            WHERE      FC.R1FlagID = 1344 AND FC.R2CompanyID = CGW.ID AND FQCA.R1FlagQuestionID = 166433) END) AS Client, 
                      '=HIPER??CZE("bdkv2:ASTOR.Projects.ProjectItem.Details(' + ltrim(str(P1.ID)) + ')","??cze BDK2")' AS Hiperlink,
                          (SELECT     TOP 1 LQ.Content
                            FROM          RFlagProjectItem AS fpi LEFT OUTER JOIN
                                                   RFlagQuestionProjectItemAnswer AS FPIA ON fpi.Id = FPIA.R2FlagProjectItemId AND p1.Id = fpi.R2ProjectItemId AND 
                                                   fpi.R1FlagId = 1983 INNER JOIN
                                                   LFlagQuestion AS LQ ON FPIA.R1FlagQuestionId = LQ.ID
                            WHERE      FPIA.Answer = 'True') AS IndustrySector,
                          (SELECT     TOP 1 fpa1.answer
                            FROM          rflagprojectitem fp1 LEFT JOIN
                                                   rflagquestionprojectitemanswer fpa1 ON fp1.id = fpa1.r2flagprojectitemid AND fpa1.r1flagquestionid = 168403
                            WHERE      fp1.r2projectitemid = p1.id AND fp1.r1flagid = 2263) AS Segment, P1.EstimatedStartDate, YEAR(P1.EstimatedStartDate) AS StartYear, 
                      MONTH(P1.EstimatedStartDate) AS StartMonth
FROM         dbo.OProjectItem AS P1 INNER JOIN
                      dbo.RProjectCategoryProjectItem AS PT1 ON P1.Id = PT1.R2ProjectItemId INNER JOIN
                      dbo.LProjectItemStatus AS PS ON PS.Id = P1.StatusId INNER JOIN
                      dbo.RProjectItemProjectItem AS PP INNER JOIN
                      dbo.OProjectItem AS P2 ON P2.Id = PP.R2ProjectItemId AND P2.StatusId = 2 AND pp.R2ProjectItemId NOT IN
                          (SELECT     pp2.r1projectitemid
                            FROM          rprojectitemprojectitem pp2 INNER JOIN
                                                   oprojectitem p22 ON p22.id = pp2.r2projectitemid
                            WHERE      p22.name LIKE 'm5a%' AND p22.statusid = 2) ON P1.Id = PP.R1ProjectItemId LEFT OUTER JOIN
                      dbo.RProjectItemCompanyPerson AS PCP INNER JOIN
                      dbo.RCompanyPerson AS CP ON CP.ID = PCP.R2CompanyPersonId AND PCP.RoleId = 1 INNER JOIN
                      dbo.OPerson AS PER ON PER.ID = CP.R2PersonID ON PCP.R1ProjectItemId = P1.Id LEFT OUTER JOIN
                      dbo.RUserCompanyPerson AS UCP INNER JOIN
                      dbo.OUser AS U ON U.ID = UCP.R1UserID ON UCP.R2CompanyPersonID = CP.ID LEFT OUTER JOIN
                      dbo.OUser AS US ON US.ID = P1.CreatedBy LEFT JOIN
                      (RProjectItemCompany PCUS INNER JOIN
                      OCompany CUS ON CUS.ID = PCUS.R2CompanyID AND PCUS.RoleID = 54 INNER JOIN
                      LProjectItemRole PIRUS ON PIRUS.ID = PCUS.RoleID) ON PCUS.ID =
                          (SELECT     TOP 1 ID
                            FROM          RProjectItemCompany
                            WHERE      R1ProjectItemID = P1.ID) LEFT JOIN
                      (RProjectItemCompany PCPIN INNER JOIN
                      OCompany CPIN ON CPIN.ID = PCPIN.R2CompanyID AND PCPIN.RoleID = 24 INNER JOIN
                      LProjectItemRole PIRPIN ON PIRPIN.ID = PCPIN.RoleID) ON PCPIN.ID =
                          (SELECT     TOP 1 ID
                            FROM          RProjectItemCompany
                            WHERE      R1ProjectItemID = P1.ID) LEFT JOIN
                      (RProjectItemCompany PCIN INNER JOIN
                      OCompany CIN ON CIN.ID = PCIN.R2CompanyID AND PCIN.RoleID = 173 INNER JOIN
                      LProjectItemRole PIRIN ON PIRIN.ID = PCIN.RoleID) ON PCIN.ID =
                          (SELECT     TOP 1 ID
                            FROM          RProjectItemCompany
                            WHERE      R1ProjectItemID = P1.ID) LEFT JOIN
                      (RProjectItemCompany PCGW INNER JOIN
                      OCompany CGW ON CGW.ID = PCGW.R2CompanyID AND PCGW.RoleID = 133 INNER JOIN
                      LProjectItemRole PIRGW ON PIRGW.ID = PCGW.RoleID) ON PCGW.ID =
                          (SELECT     TOP 1 ID
                            FROM          RProjectItemCompany
                            WHERE      R1ProjectItemID = P1.ID)
WHERE     p2.name NOT LIKE 'm5a%' AND PT1.R1ProjectCategoryId <> 63
/* tu s? tylko projekty z etapami m5a, a sa to tylko projekty astorowe */ UNION
SELECT     p1.Id AS ProjectID, P1.Guid AS ProjectGUID, P1.CreatedOn, US.Nickname AS CreatedBy, P1.Code AS ProjectCode, P1.Name AS ProjectName, 
                      PS.Name AS ProjectStatus, P1.EstimatedEndDate, YEAR(P1.EstimatedEndDate) AS Year, MONTH(P1.EstimatedEndDate) AS Month, P1.EstimatedCost, 
                      P3.Code AS Progress, P3.Name AS ProjectStage, (P1.EstimatedCost * (CAST(LEFT(P3.Code, LEN(P3.Code) - 1) AS int))) / 100 AS Weighted, 
                      PER.Surname + ' ' + PER.FirstName AS ProjectManager, CP.ID AS ProjectManagerID, (CASE WHEN (U._MiejsceBazy = 'STA' OR
                      U._MiejsceBazy = 'POZ') THEN 'ZCH' ELSE U._MiejsceBazy END) AS Base, ISNULL(CUS.DerivedFullName, ISNULL(CPIN.DerivedFullName, 
                      ISNULL(CIN.DerivedFullName, CGW.DerivedFullName))) AS Company, ISNULL(PIRUS.Name, ISNULL(PIRPIN.Name, ISNULL(PIRIN.Name, 
                      PIRGW.Name))) AS Role, (CASE WHEN CUS.ID IS NOT NULL THEN
                          (SELECT     TOP 1 FQCA.Answer
                            FROM          RFlagCompany FC INNER JOIN
                                                   RFlagQuestionCompanyAnswer FQCA ON FQCA.R2FlagCompanyID = FC.ID
                            WHERE      FC.R1FlagID = 1344 AND FC.R2CompanyID = CUS.ID AND FQCA.R1FlagQuestionID = 166433) WHEN CPIN.ID IS NOT NULL THEN
                          (SELECT     TOP 1 FQCA.Answer
                            FROM          RFlagCompany FC INNER JOIN
                                                   RFlagQuestionCompanyAnswer FQCA ON FQCA.R2FlagCompanyID = FC.ID
                            WHERE      FC.R1FlagID = 1344 AND FC.R2CompanyID = CPIN.ID AND FQCA.R1FlagQuestionID = 166433) WHEN CIN.ID IS NOT NULL THEN
                          (SELECT     TOP 1 FQCA.Answer
                            FROM          RFlagCompany FC INNER JOIN
                                                   RFlagQuestionCompanyAnswer FQCA ON FQCA.R2FlagCompanyID = FC.ID
                            WHERE      FC.R1FlagID = 1344 AND FC.R2CompanyID = CIN.ID AND FQCA.R1FlagQuestionID = 166433) WHEN CGW.ID IS NOT NULL THEN
                          (SELECT     TOP 1 FQCA.Answer
                            FROM          RFlagCompany FC INNER JOIN
                                                   RFlagQuestionCompanyAnswer FQCA ON FQCA.R2FlagCompanyID = FC.ID
                            WHERE      FC.R1FlagID = 1344 AND FC.R2CompanyID = CGW.ID AND FQCA.R1FlagQuestionID = 166433) END) AS Client, 
                      '=HIPER??CZE("bdkv2:ASTOR.Projects.ProjectItem.Details(' + ltrim(str(P1.ID)) + ')","??cze BDK2")' AS Hiperlink,
                          (SELECT     TOP 1 LQ.Content
                            FROM          RFlagProjectItem AS fpi LEFT OUTER JOIN
                                                   RFlagQuestionProjectItemAnswer AS FPIA ON fpi.Id = FPIA.R2FlagProjectItemId AND p1.Id = fpi.R2ProjectItemId AND 
                                                   fpi.R1FlagId = 1983 INNER JOIN
                                                   LFlagQuestion AS LQ ON FPIA.R1FlagQuestionId = LQ.ID
                            WHERE      FPIA.Answer = 'True') AS IndustrySector,
                          (SELECT     TOP 1 fpa1.answer
                            FROM          rflagprojectitem fp1 LEFT JOIN
                                                   rflagquestionprojectitemanswer fpa1 ON fp1.id = fpa1.r2flagprojectitemid AND fpa1.r1flagquestionid = 168403
                            WHERE      fp1.r2projectitemid = p1.id AND fp1.r1flagid = 2263) AS Segment, P1.EstimatedStartDate, YEAR(P1.EstimatedStartDate) AS StartYear, 
                      MONTH(P1.EstimatedStartDate) AS StartMonth
FROM         oprojectitem p3 INNER JOIN
                      rprojectitemprojectitem pp3 ON p3.id = pp3.R2ProjectItemid INNER JOIN
                      rprojectitemprojectitem pp2 ON pp3.R1ProjectItemid = pp2.R2ProjectItemid INNER JOIN
                      oprojectitem p1 ON pp2.r1projectitemid = p1.id INNER JOIN
                      LProjectItemStatus AS PS ON PS.Id = P1.StatusId INNER JOIN
                      RProjectItemCompanyPerson AS PCP INNER JOIN
                      RCompanyPerson AS CP ON CP.ID = PCP.R2CompanyPersonId AND PCP.RoleId = 1 INNER JOIN
                      OPerson AS PER ON PER.ID = CP.R2PersonID ON PCP.R1ProjectItemId = P1.Id LEFT JOIN
                      dbo.RUserCompanyPerson AS UCP INNER JOIN
                      dbo.OUser AS U ON U.ID = UCP.R1UserID ON UCP.R2CompanyPersonID = CP.ID LEFT JOIN
                      dbo.OUser AS US ON US.ID = P1.CreatedBy LEFT JOIN
                      (RProjectItemCompany PCUS INNER JOIN
                      OCompany CUS ON CUS.ID = PCUS.R2CompanyID AND PCUS.RoleID = 54 INNER JOIN
                      LProjectItemRole PIRUS ON PIRUS.ID = PCUS.RoleID) ON PCUS.ID =
                          (SELECT     TOP 1 ID
                            FROM          RProjectItemCompany
                            WHERE      R1ProjectItemID = P1.ID) LEFT JOIN
                      (RProjectItemCompany PCPIN INNER JOIN
                      OCompany CPIN ON CPIN.ID = PCPIN.R2CompanyID AND PCPIN.RoleID = 24 INNER JOIN
                      LProjectItemRole PIRPIN ON PIRPIN.ID = PCPIN.RoleID) ON PCPIN.ID =
                          (SELECT     TOP 1 ID
                            FROM          RProjectItemCompany
                            WHERE      R1ProjectItemID = P1.ID) LEFT JOIN
                      (RProjectItemCompany PCIN INNER JOIN
                      OCompany CIN ON CIN.ID = PCIN.R2CompanyID AND PCIN.RoleID = 173 INNER JOIN
                      LProjectItemRole PIRIN ON PIRIN.ID = PCIN.RoleID) ON PCIN.ID =
                          (SELECT     TOP 1 ID
                            FROM          RProjectItemCompany
                            WHERE      R1ProjectItemID = P1.ID) LEFT JOIN
                      (RProjectItemCompany PCGW INNER JOIN
                      OCompany CGW ON CGW.ID = PCGW.R2CompanyID AND PCGW.RoleID = 133 INNER JOIN
                      LProjectItemRole PIRGW ON PIRGW.ID = PCGW.RoleID) ON PCGW.ID =
                          (SELECT     TOP 1 ID
                            FROM          RProjectItemCompany
                            WHERE      R1ProjectItemID = P1.ID)
WHERE     p3.name LIKE 'm5a%' AND p3.statusid = 2
/* projekty PROFESAL odrzucamy*/ UNION
SELECT     P1.Id AS ProjectID, P1.Guid AS ProjectGUID, P1.CreatedOn, US.Nickname AS CreatedBy, P1.Code AS ProjectCode, P1.Name AS ProjectName, 
                      PS.Name AS ProjectStatus, P1.EstimatedEndDate, YEAR(P1.EstimatedEndDate) AS Year, MONTH(P1.EstimatedEndDate) AS Month, 
                      ISNULL(P1.EstimatedCost, 0) AS EstimatedCost, '?' AS Progress, '?' AS ProjectStage, 0.00 AS Weighted, 
                      PER.Surname + ' ' + PER.FirstName AS ProjectManager, CP.ID AS ProjectManagerID, (CASE WHEN (U._MiejsceBazy = 'STA' OR
                      U._MiejsceBazy = 'POZ') THEN 'ZCH' ELSE U._MiejsceBazy END) AS Base, ISNULL(CUS.DerivedFullName, ISNULL(CPIN.DerivedFullName, 
                      ISNULL(CIN.DerivedFullName, CGW.DerivedFullName))) AS Company, ISNULL(PIRUS.Name, ISNULL(PIRPIN.Name, ISNULL(PIRIN.Name, 
                      PIRGW.Name))) AS Role, (CASE WHEN CUS.ID IS NOT NULL THEN
                          (SELECT     TOP 1 FQCA.Answer
                            FROM          RFlagCompany FC INNER JOIN
                                                   RFlagQuestionCompanyAnswer FQCA ON FQCA.R2FlagCompanyID = FC.ID
                            WHERE      FC.R1FlagID = 1344 AND FC.R2CompanyID = CUS.ID AND FQCA.R1FlagQuestionID = 166433) WHEN CPIN.ID IS NOT NULL THEN
                          (SELECT     TOP 1 FQCA.Answer
                            FROM          RFlagCompany FC INNER JOIN
                                                   RFlagQuestionCompanyAnswer FQCA ON FQCA.R2FlagCompanyID = FC.ID
                            WHERE      FC.R1FlagID = 1344 AND FC.R2CompanyID = CPIN.ID AND FQCA.R1FlagQuestionID = 166433) WHEN CIN.ID IS NOT NULL THEN
                          (SELECT     TOP 1 FQCA.Answer
                            FROM          RFlagCompany FC INNER JOIN
                                                   RFlagQuestionCompanyAnswer FQCA ON FQCA.R2FlagCompanyID = FC.ID
                            WHERE      FC.R1FlagID = 1344 AND FC.R2CompanyID = CIN.ID AND FQCA.R1FlagQuestionID = 166433) WHEN CGW.ID IS NOT NULL THEN
                          (SELECT     TOP 1 FQCA.Answer
                            FROM          RFlagCompany FC INNER JOIN
                                                   RFlagQuestionCompanyAnswer FQCA ON FQCA.R2FlagCompanyID = FC.ID
                            WHERE      FC.R1FlagID = 1344 AND FC.R2CompanyID = CGW.ID AND FQCA.R1FlagQuestionID = 166433) END) AS Client, 
                      '=HIPER??CZE("bdkv2:ASTOR.Projects.ProjectItem.Details(' + ltrim(str(P1.ID)) + ')","??cze BDK2")' AS Hiperlink, '?' AS IndustrySector, '?' AS Segment, 
                      P1.EstimatedStartDate, YEAR(P1.EstimatedStartDate) AS StartYear, MONTH(P1.EstimatedStartDate) AS StartMonth
FROM         dbo.OProjectItem AS P1 INNER JOIN
                      dbo.RProjectCategoryProjectItem AS PT1 ON P1.Id = PT1.R2ProjectItemId INNER JOIN
                      dbo.LProjectItemStatus AS PS ON PS.Id = P1.StatusId LEFT OUTER JOIN
                      dbo.RProjectItemCompanyPerson AS PCP INNER JOIN
                      dbo.RCompanyPerson AS CP ON CP.ID = PCP.R2CompanyPersonId AND PCP.RoleId = 1 INNER JOIN
                      dbo.OPerson AS PER ON PER.ID = CP.R2PersonID ON PCP.R1ProjectItemId = P1.Id LEFT OUTER JOIN
                      dbo.RUserCompanyPerson AS UCP INNER JOIN
                      dbo.OUser AS U ON U.ID = UCP.R1UserID ON UCP.R2CompanyPersonID = CP.ID LEFT OUTER JOIN
                      dbo.OUser AS US ON US.ID = P1.CreatedBy LEFT JOIN
                      (RProjectItemCompany PCUS INNER JOIN
                      OCompany CUS ON CUS.ID = PCUS.R2CompanyID AND PCUS.RoleID = 54 INNER JOIN
                      LProjectItemRole PIRUS ON PIRUS.ID = PCUS.RoleID) ON PCUS.ID =
                          (SELECT     TOP 1 ID
                            FROM          RProjectItemCompany
                            WHERE      R1ProjectItemID = P1.ID) LEFT JOIN
                      (RProjectItemCompany PCPIN INNER JOIN
                      OCompany CPIN ON CPIN.ID = PCPIN.R2CompanyID AND PCPIN.RoleID = 24 INNER JOIN
                      LProjectItemRole PIRPIN ON PIRPIN.ID = PCPIN.RoleID) ON PCPIN.ID =
                          (SELECT     TOP 1 ID
                            FROM          RProjectItemCompany
                            WHERE      R1ProjectItemID = P1.ID) LEFT JOIN
                      (RProjectItemCompany PCIN INNER JOIN
                      OCompany CIN ON CIN.ID = PCIN.R2CompanyID AND PCIN.RoleID = 173 INNER JOIN
                      LProjectItemRole PIRIN ON PIRIN.ID = PCIN.RoleID) ON PCIN.ID =
                          (SELECT     TOP 1 ID
                            FROM          RProjectItemCompany
                            WHERE      R1ProjectItemID = P1.ID) LEFT JOIN
                      (RProjectItemCompany PCGW INNER JOIN
                      OCompany CGW ON CGW.ID = PCGW.R2CompanyID AND PCGW.RoleID = 133 INNER JOIN
                      LProjectItemRole PIRGW ON PIRGW.ID = PCGW.RoleID) ON PCGW.ID =
                          (SELECT     TOP 1 ID
                            FROM          RProjectItemCompany
                            WHERE      R1ProjectItemID = P1.ID)
WHERE     (P1.Id NOT IN
                          (SELECT     PIPI.R1ProjectItemId
                            FROM          dbo.RProjectItemProjectItem AS PIPI INNER JOIN
                                                   dbo.OProjectItem AS PIT ON PIT.Id = PIPI.R2ProjectItemId
                            WHERE      (PIT.StatusId = 2) OR
                                                   (PIT.StatusId = 2))) AND (P1.Id NOT IN
                          (SELECT     R2ProjectItemId
                            FROM          dbo.RProjectItemProjectItem)) AND PT1.R1ProjectCategoryId <> 63
GO
GRANT SELECT ON [dbo].[viewProjects] TO [BDKProgramyZewnetrzne]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\JAROSLAWG].[ProjektyMES_gen]
AS
SELECT     ProjectID, CreatedOn, CreatedBy, ProjectCode, ProjectName, ProjectStatus, CONVERT(datetime, CONVERT(varchar, EstimatedEndDate, 101)) 
                      AS 'EstimatedEndDate', EstimatedCost, Progress, ProjectStage, Weighted, ProjectManager, ProjectManagerID, Base, ProjectGUID, Year, Month, 
                      Hiperlink
FROM         dbo.viewProjects AS viewProjects
WHERE     (ProjectName LIKE '%@MES@%')
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[viewProjectsWithFirmsAndPersons]
AS
SELECT     PR.Id AS ProjectID, PR.Guid AS ProjectGUID, PR.Code AS ProjectCode, PR.Name AS ProjectName, PR.CreatedOn, U.Nickname AS CreatedBy, 
                      PR.Description AS ProjectDescription, PS.Name AS ProjectStatus, PR.EstimatedEndDate, PR.EstimatedCost, PR2.Name AS ProjectStage, 
                      C.ID AS FirmID, C.Guid AS FirmGUID, C.DerivedFullName AS FirmName, P.ID AS PersonID, P.Guid AS PersonGUID, 
                      P.Surname + ' ' + P.FirstName AS PersonName, PRR.Name AS Role, PRCP.Description AS RoleDescription, PRCP.R, PRCP.A, PRCP.E, PRCP.W, 
                      'CompanyPerson' AS ConnectionType
FROM         dbo.OProjectItem AS PR INNER JOIN
                     dbo.RProjectCategoryProjectItem as PT1 ON PR.Id = PT1.R2ProjectItemId INNER JOIN
                      dbo.LProjectItemStatus AS PS ON PS.Id = PR.StatusId INNER JOIN
                      dbo.RProjectItemCompanyPerson AS PRCP ON PRCP.R1ProjectItemId = PR.Id INNER JOIN
                      dbo.LProjectItemRole AS PRR ON PRR.Id = PRCP.RoleId INNER JOIN
                      dbo.RCompanyPerson AS CP ON CP.ID = PRCP.R2CompanyPersonId INNER JOIN
                      dbo.OCompany AS C ON C.ID = CP.R1CompanyID INNER JOIN
                      dbo.OPerson AS P ON P.ID = CP.R2PersonID LEFT OUTER JOIN
                      dbo.RProjectItemProjectItem AS PRPR INNER JOIN
                      dbo.OProjectItem AS PR2 ON PR2.Id = PRPR.R2ProjectItemId AND PR2.StatusId = 2 ON PR.Id = PRPR.R1ProjectItemId LEFT OUTER JOIN
                      dbo.OUser AS U ON U.ID = PR.CreatedBy
WHERE     (PR.Id NOT IN
                          (SELECT     R2ProjectItemId
                            FROM          dbo.RProjectItemProjectItem)) and PT1.R1ProjectCategoryId<>63 -- projekty PROFESAL odrzucamy
UNION ALL
SELECT     PR.Id AS ProjectID, PR.Guid AS ProjectGUID, PR.Code AS ProjectCode, PR.Name AS ProjectName, PR.CreatedOn, U.Nickname AS CreatedBy, 
                      PR.Description AS ProjectDescription, PS.Name AS ProjectStatus, PR.EstimatedEndDate, PR.EstimatedCost, PR2.Name AS ProjectStage, 
                      C.ID AS FirmID, C.Guid AS FirmGUID, C.DerivedFullName AS FirmName, NULL AS PersonID, NULL AS PersonGUID, '' AS PersonName, 
                      PRR.Name AS Role, PRC.Description AS RoleDescription, PRC.R, PRC.A, PRC.E, PRC.W, 'Company' AS ConnectionType
FROM         dbo.OProjectItem AS PR INNER JOIN
                  dbo.RProjectCategoryProjectItem as PT1 ON PR.Id = PT1.R2ProjectItemId INNER JOIN
                      dbo.LProjectItemStatus AS PS ON PS.Id = PR.StatusId INNER JOIN
                      dbo.RProjectItemCompany AS PRC ON PRC.R1ProjectItemId = PR.Id INNER JOIN
                      dbo.LProjectItemRole AS PRR ON PRR.Id = PRC.RoleId INNER JOIN
                      dbo.OCompany AS C ON C.ID = PRC.R2CompanyId LEFT OUTER JOIN
                      dbo.RProjectItemProjectItem AS PRPR INNER JOIN
                      dbo.OProjectItem AS PR2 ON PR2.Id = PRPR.R2ProjectItemId AND PR2.StatusId = 2 ON PR.Id = PRPR.R1ProjectItemId LEFT OUTER JOIN
                      dbo.OUser AS U ON U.ID = PR.CreatedBy
WHERE     (PR.Id NOT IN
                          (SELECT     R2ProjectItemId
                            FROM          dbo.RProjectItemProjectItem AS RProjectItemProjectItem_1)) and PT1.R1ProjectCategoryId<>63 -- projekty PROFESAL odrzucamy
GO
GRANT SELECT ON [dbo].[viewProjectsWithFirmsAndPersons] TO [BDKProgramyZewnetrzne]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\JAROSLAWG].[ProjektyMES_int]
AS
SELECT     A.ProjectID, A.ProjectGUID, A.CreatedOn, A.CreatedBy, A.ProjectCode, A.ProjectName, A.ProjectStatus, A.EstimatedEndDate, A.Year, A.Month, 
                      A.EstimatedCost, A.Progress, A.ProjectStage, A.Weighted, A.ProjectManager, A.ProjectManagerID, A.Base, A.Hiperlink, B.FirmName AS RoleFirmName, 
                      B.PersonName AS RolePersonName, B.Role, B.ConnectionType
FROM         dbo.viewProjects AS A LEFT OUTER JOIN
                      dbo.viewProjectsWithFirmsAndPersons AS B ON B.ProjectID = A.ProjectID AND B.Role IN ('Integrator', 'Preferowany integrator')
WHERE     (A.ProjectName LIKE '%@MES@%')
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\MARCINWO].[CompanyClientOf]
AS
SELECT     OC1.ID, OC1.Guid, OC1.DerivedFullName, RFCA1.Answer, OC2.ID AS ParentId, OC2.DerivedFullName AS ParentName, RFCA2.Answer AS ParentAnswer, 
                      OC2.Guid AS ParentGuid, OC3.ID AS PPId, OC3.Guid AS PPGuid, OC3.DerivedFullName AS PPName, RFCA3.Answer AS PPAnswer, OC4.ID AS PPPId, 
                      OC4.Guid AS PPPGuid, OC4.DerivedFullName AS PPPName, RFCA4.Answer AS PPPAnswer, CASE WHEN (RFCA1.Answer IS NOT NULL AND 
                      RFCA1.Answer <> '[nie okre?lony]') THEN RFCA1.Answer ELSE CASE WHEN (RFCA2.Answer IS NOT NULL AND RFCA2.Answer <> '[nie okre?lony]') 
                      THEN RFCA2.Answer ELSE CASE WHEN (RFCA3.Answer IS NOT NULL AND RFCA3.Answer <> '[nie okre?lony]') 
                      THEN RFCA3.Answer ELSE CASE WHEN (RFCA4.Answer IS NOT NULL AND RFCA4.Answer <> '[nie okre?lony]') 
                      THEN RFCA4.Answer ELSE '5 poziom zagniezdzenia' END END END END AS DerivedAnswer
FROM         dbo.OCompany AS OC1 LEFT OUTER JOIN
                      dbo.RCompanyCompany AS RCC1 ON RCC1.R2CompanyId = OC1.ID LEFT OUTER JOIN
                      dbo.OCompany AS OC2 ON RCC1.R1CompanyId = OC2.ID LEFT OUTER JOIN
                      dbo.RFlagCompany AS RFC1 ON OC1.ID = RFC1.R2CompanyID AND RFC1.R1FlagID = 1344 LEFT OUTER JOIN
                      dbo.RFlagQuestionCompanyAnswer AS RFCA1 ON RFC1.ID = RFCA1.R2FlagCompanyID AND RFCA1.R1FlagQuestionID = 166433 LEFT OUTER JOIN
                      dbo.RFlagCompany AS RFC2 ON OC2.ID = RFC2.R2CompanyID AND RFC2.R1FlagID = 1344 LEFT OUTER JOIN
                      dbo.RFlagQuestionCompanyAnswer AS RFCA2 ON RFC2.ID = RFCA2.R2FlagCompanyID AND RFCA2.R1FlagQuestionID = 166433 LEFT OUTER JOIN
                      dbo.RCompanyCompany AS RCC2 ON OC2.ID = RCC2.R2CompanyId LEFT OUTER JOIN
                      dbo.OCompany AS OC3 ON RCC2.R1CompanyId = OC3.ID LEFT OUTER JOIN
                      dbo.RFlagCompany AS RFC3 ON OC3.ID = RFC3.R2CompanyID AND RFC3.R1FlagID = 1344 LEFT OUTER JOIN
                      dbo.RFlagQuestionCompanyAnswer AS RFCA3 ON RFC3.ID = RFCA3.R2FlagCompanyID AND RFCA3.R1FlagQuestionID = 166433 LEFT OUTER JOIN
                      dbo.RCompanyCompany AS RCC3 ON OC3.ID = RCC3.R2CompanyId LEFT OUTER JOIN
                      dbo.OCompany AS OC4 ON RCC3.R1CompanyId = OC4.ID LEFT OUTER JOIN
                      dbo.RFlagCompany AS RFC4 ON OC4.ID = RFC4.R2CompanyID AND RFC4.R1FlagID = 1344 LEFT OUTER JOIN
                      dbo.RFlagQuestionCompanyAnswer AS RFCA4 ON RFC4.ID = RFCA4.R2FlagCompanyID AND RFCA4.R1FlagQuestionID = 166433
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\MARCINWO].[CompanyClientType]
AS
SELECT     OC1.ID, OC1.Guid, OC1.DerivedFullName, RFCA1.Answer, OC2.ID AS ParentId, OC2.DerivedFullName AS ParentName, RFCA2.Answer AS ParentAnswer, 
                      OC2.Guid AS ParentGuid, OC3.ID AS PPId, OC3.Guid AS PPGuid, OC3.DerivedFullName AS PPName, RFCA3.Answer AS PPAnswer, OC4.ID AS PPPId, 
                      OC4.Guid AS PPPGuid, OC4.DerivedFullName AS PPPName, RFCA4.Answer AS PPPAnswer, CASE WHEN (RFCA1.Answer IS NOT NULL AND 
                      RFCA1.Answer <> '[nie okre?lony]') THEN RFCA1.Answer ELSE CASE WHEN (RFCA2.Answer IS NOT NULL AND RFCA2.Answer <> '[nie okre?lony]') 
                      THEN RFCA2.Answer ELSE CASE WHEN (RFCA3.Answer IS NOT NULL AND RFCA3.Answer <> '[nie okre?lony]') 
                      THEN RFCA3.Answer ELSE CASE WHEN (RFCA4.Answer IS NOT NULL AND RFCA4.Answer <> '[nie okre?lony]') 
                      THEN RFCA4.Answer ELSE '5 poziom zagniezdzenia' END END END END AS DerivedAnswer
FROM         dbo.OCompany AS OC1 LEFT OUTER JOIN
                      dbo.RCompanyCompany AS RCC1 ON RCC1.R2CompanyId = OC1.ID LEFT OUTER JOIN
                      dbo.OCompany AS OC2 ON RCC1.R1CompanyId = OC2.ID LEFT OUTER JOIN
                      dbo.RFlagCompany AS RFC1 ON OC1.ID = RFC1.R2CompanyID AND RFC1.R1FlagID = 1344 LEFT OUTER JOIN
                      dbo.RFlagQuestionCompanyAnswer AS RFCA1 ON RFC1.ID = RFCA1.R2FlagCompanyID AND RFCA1.R1FlagQuestionID = 166434 LEFT OUTER JOIN
                      dbo.RFlagCompany AS RFC2 ON OC2.ID = RFC2.R2CompanyID AND RFC2.R1FlagID = 1344 LEFT OUTER JOIN
                      dbo.RFlagQuestionCompanyAnswer AS RFCA2 ON RFC2.ID = RFCA2.R2FlagCompanyID AND RFCA2.R1FlagQuestionID = 166434 LEFT OUTER JOIN
                      dbo.RCompanyCompany AS RCC2 ON OC2.ID = RCC2.R2CompanyId LEFT OUTER JOIN
                      dbo.OCompany AS OC3 ON RCC2.R1CompanyId = OC3.ID LEFT OUTER JOIN
                      dbo.RFlagCompany AS RFC3 ON OC3.ID = RFC3.R2CompanyID AND RFC3.R1FlagID = 1344 LEFT OUTER JOIN
                      dbo.RFlagQuestionCompanyAnswer AS RFCA3 ON RFC3.ID = RFCA3.R2FlagCompanyID AND RFCA3.R1FlagQuestionID = 166434 LEFT OUTER JOIN
                      dbo.RCompanyCompany AS RCC3 ON OC3.ID = RCC3.R2CompanyId LEFT OUTER JOIN
                      dbo.OCompany AS OC4 ON RCC3.R1CompanyId = OC4.ID LEFT OUTER JOIN
                      dbo.RFlagCompany AS RFC4 ON OC4.ID = RFC4.R2CompanyID AND RFC4.R1FlagID = 1344 LEFT OUTER JOIN
                      dbo.RFlagQuestionCompanyAnswer AS RFCA4 ON RFC4.ID = RFCA4.R2FlagCompanyID AND RFCA4.R1FlagQuestionID = 166434
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\MARCINWO].[CompanyKSAFlag]
AS
SELECT     OC.ID AS CompanyID, OC.Guid AS CompanyGuid, OC.DerivedFullName AS CompanyFullName, RFQCA_KSA.Answer AS CSNumber, 
                      CT.Answer AS ClientTypeRaw, CT.DerivedAnswer AS ClientDerivedTypeRaw, 
                      CASE WHEN CT.DerivedAnswer LIKE '%end user%' THEN 'End User' WHEN CT.DerivedAnswer LIKE '%edukacja%' THEN 'Edukacja' WHEN CT.DerivedAnswer
                       IS NULL THEN 'SPRAWDZIC' ELSE 'Integrator' END AS ClientType
FROM         dbo.OCompany AS OC INNER JOIN
                      dbo.RFlagCompany AS RFC_KSA ON OC.ID = RFC_KSA.R2CompanyID AND RFC_KSA.R1FlagID = 866 LEFT OUTER JOIN
                      dbo.RFlagQuestionCompanyAnswer AS RFQCA_KSA ON RFC_KSA.ID = RFQCA_KSA.R2FlagCompanyID AND 
                      RFQCA_KSA.R1FlagQuestionID = 166248 INNER JOIN
                      [ASTOR\MARCINWO].CompanyClientType AS CT ON OC.ID = CT.ID
WHERE     (OC.ID <> 1179)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\MARCINWO].[CompanyPersonKSAFlag]
AS
SELECT     RCP.ID AS CompanyPersonID, OP.FirstName, OP.Surname, LOS.Name AS WorkingStatus, RCP.IsDefault AS IsDefaultCompany, RCP.R1CompanyID, 
                      RCP.R2PersonID, OP.Guid AS PersonGuid
FROM         dbo.RCompanyPerson AS RCP INNER JOIN
                      dbo.OPerson AS OP ON RCP.R2PersonID = OP.ID LEFT OUTER JOIN
                      dbo.LOccupationStatus AS LOS ON RCP.StatusID = LOS.ID INNER JOIN
                      dbo.RFlagCompanyPerson AS RFCP ON RCP.ID = RFCP.R2CompanyPersonId
WHERE     (RFCP.R1FlagId = 1299)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\MARCINWO].[CompanyPersonKSAKontaktFlag]
AS
SELECT     RCP.ID AS RCompanyPersonID, RFQCP.Answer AS KSAW_Kontakt, RCP.R1CompanyID, RCP.R2PersonID
FROM         dbo.RCompanyPerson AS RCP LEFT OUTER JOIN
                      dbo.RFlagCompanyPerson AS RFCP ON RCP.ID = RFCP.R2CompanyPersonId AND RFCP.R1FlagId = 1299 LEFT OUTER JOIN
                      dbo.RFlagQuestionCompanyPersonAnswer AS RFQCP ON RFCP.R1FlagId = RFQCP.R2FlagCompanyPersonId
WHERE     (RFQCP.Answer = '1')
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[TabCen]  AS 
SELECT     IDCennika, NrKatalogowy, OpisEN, OpisPL, OpisOfertowa, IDPodgrupyCennika, IndeksPozycjiCennika, RodzajWydruku, Aktywny, Waluta, 
                      CenaDostawcy, MnoznikA, AddA, MnoznikB, AddB, CenaA, CenaB, KursPrzelicz, ShiftA_PLN, ShiftB_PLN, CenaA_PLN, CenaB_PLN, GrupaTowINFO, 
                      IsChanged, CenaTransferowaDostawcy, Towar
FROM         BDK.dbo.TabCen
GO
GRANT DELETE ON [dbo].[TabCen] TO [BDKProgramyZewnetrzne]
GO
GRANT INSERT ON [dbo].[TabCen] TO [BDKProgramyZewnetrzne]
GO
GRANT SELECT ON [dbo].[TabCen] TO [BDKProgramyZewnetrzne]
GO
GRANT UPDATE ON [dbo].[TabCen] TO [BDKProgramyZewnetrzne]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[TabTowar?w]
as
SELECT     NrKatalogowy, IleFPP, IleWypo?yczonych, IleWys?anych, IleWys?anychWZestawach, IleNZWysPewn, IleNZWysNiePewn, 
                      IleNZNieWysPewn, IleNZNieWysNiePewn, GrupaTow, Zestaw, Zmie?NaZestaw, WymaganyEndUser, CzasDostawy, MagazynHi, MagazynLo, 
                      MagazynLoLo, CenaZakupuFPP, WalutaZakupuFPP, MaskaSerii, Software, TypTowaru, OpisGrupyTowaruNaFakturze, IDZestawuParam, 
                      IleNaGwarancji, StawkaVATID, OstatniaModyfikacja, GwarancjaCzas, BlokadaZamawiania, ID
FROM         BDK.dbo.TabTowar?w
GO
GRANT DELETE ON [dbo].[TabTowar?w] TO [BDKProgramyZewnetrzne]
GO
GRANT INSERT ON [dbo].[TabTowar?w] TO [BDKProgramyZewnetrzne]
GO
GRANT SELECT ON [dbo].[TabTowar?w] TO [BDKProgramyZewnetrzne]
GO
GRANT UPDATE ON [dbo].[TabTowar?w] TO [BDKProgramyZewnetrzne]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\MARCINWO].[ConsignRenewalTabTowarow]
AS
SELECT     tt.NrKatalogowy, tt.GrupaTow, tc.OpisEN AS OpisTowaruOrg, tc.OpisPL AS OpisTowaruPL
FROM         dbo.TabTowar?w AS tt INNER JOIN
                      dbo.TabCen AS tc ON tc.IDCennika = 1 AND tc.Towar = tt.ID
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\MARCINWO].[ConsignRenewalTrace]
AS
SELECT     [ASTOR\ANNAS].CS.firmId, [ASTOR\ANNAS].MWo_CS_Lic_Renewal.CompanyName, [ASTOR\ANNAS].CS.whoinastor, dbo.TNoteCategory.Code, 
                      dbo.ONote.Content, dbo.ONote.CreatedOn, dbo.ONote.CategoryId,
				cast(
				case
					when dbo.ONote.CategoryId = 108 then 0 -- Info
					when dbo.ONote.CategoryId = 112 then 1 -- ProForma
					when dbo.ONote.CategoryId = 111 then 2 -- Zastanawia si?
					when dbo.ONote.CategoryId = 105 then 3 -- Zam?wienie ustnie
					when dbo.ONote.CategoryId = 109 then 4 -- Odmowa klienta
					when dbo.ONote.CategoryId = 119 then 5 -- Inne
					when dbo.ONote.CategoryId = 113 then 6 -- Zam pisemne
					when dbo.ONote.CategoryId = 116 then 7 -- Addendum
					when dbo.ONote.CategoryId = 117 then 8 -- Faktura
					when dbo.ONote.CategoryId = 110 then 9 -- Zap?acono
					when dbo.ONote.CategoryId = 106 then 10 -- Zam?wiono w WW
					when dbo.ONote.CategoryId = 114 then 11 -- WW przed?u?y?o
					when dbo.ONote.CategoryId = 107 then 90 -- WW Dobra licencja
					when dbo.ONote.CategoryId = 115 then 12 -- Licencja wys?ana do klienta
					when dbo.ONote.CategoryId = 118 then 13 -- Zwr?ci? licencje
					else 99
				end as decimal) as ListOrder
					
FROM         dbo.ONote INNER JOIN
                      dbo.TNoteCategory ON dbo.ONote.CategoryID = dbo.TNoteCategory.ID INNER JOIN
                      dbo.RNoteCompanyPerson ON dbo.ONote.ID = dbo.RNoteCompanyPerson.R1NoteId INNER JOIN
                      dbo.RCompanyPerson ON dbo.RNoteCompanyPerson.R2CompanyPersonId = dbo.RCompanyPerson.ID INNER JOIN
                      dbo.OPerson ON dbo.RCompanyPerson.R2PersonID = dbo.OPerson.ID INNER JOIN
                      [ASTOR\ANNAS].MWo_CS_Lic_Renewal ON dbo.RCompanyPerson.R1CompanyID = [ASTOR\ANNAS].MWo_CS_Lic_Renewal.CompanyID INNER JOIN
                      [ASTOR\ANNAS].CS ON [ASTOR\ANNAS].MWo_CS_Lic_Renewal.CompanyID = [ASTOR\ANNAS].CS.firmId
WHERE     (dbo.ONote.CategoryID >= 105) AND (dbo.ONote.CategoryID <= 119)
UNION ALL
SELECT     CS_1.firmId, MWo_CS_Lic_Renewal_1.CompanyName, CS_1.whoinastor, TNoteCategory_1.Code, ONote_1.Content, ONote_1.CreatedOn, 
                      ONote_1.CategoryId,
                      				cast(
                      				case
					when ONote_1.CategoryId = 108 then 0 -- Info
					when ONote_1.CategoryId = 112 then 1 -- ProForma
					when ONote_1.CategoryId = 111 then 2 -- Zastanawia si?
					when ONote_1.CategoryId = 105 then 3 -- Zam?wienie ustnie
					when ONote_1.CategoryId = 109 then 4 -- Odmowa klienta
					when ONote_1.CategoryId = 119 then 5 -- Inne
					when ONote_1.CategoryId = 113 then 6 -- Zam pisemne
					when ONote_1.CategoryId = 116 then 7 -- Addendum
					when ONote_1.CategoryId = 117 then 8 -- Faktura
					when ONote_1.CategoryId = 110 then 9 -- Zap?acono
					when ONote_1.CategoryId = 106 then 10 -- Zam?wiono w WW
					when ONote_1.CategoryId = 114 then 11 -- WW przed?u?y?o
					when ONote_1.CategoryId = 107 then 90 -- WW Dobra licencja
					when ONote_1.CategoryId = 115 then 12 -- Licencja wys?ana do klienta
					when ONote_1.CategoryId = 118 then 13 -- Zwr?ci? licencje
					else 99
				end  as decimal) as ListOrder
                      
FROM         dbo.RNoteCompany INNER JOIN
                      dbo.ONote AS ONote_1 INNER JOIN
                      dbo.TNoteCategory AS TNoteCategory_1 ON ONote_1.CategoryID = TNoteCategory_1.ID ON dbo.RNoteCompany.R1NoteID = ONote_1.ID INNER JOIN
                      [ASTOR\ANNAS].CS AS CS_1 INNER JOIN
                      [ASTOR\ANNAS].MWo_CS_Lic_Renewal AS MWo_CS_Lic_Renewal_1 ON CS_1.firmId = MWo_CS_Lic_Renewal_1.CompanyID ON 
                      dbo.RNoteCompany.R2CompanyID = MWo_CS_Lic_Renewal_1.CompanyID
WHERE     (ONote_1.CategoryID >= 105) AND (ONote_1.CategoryID <= 119)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[Licencje]
AS
SELECT     NumerLicencji, IDFirmy, IDUzytkownika, IDInstalacji, IDIntegratora, NumerLicencjiLiczba, NumerKlucza, OpisLicencji, PlikLicencyjny, 
                      PlikLicencyjnyOLE, Data, NumerLicencjiNast, CSCD, CSCDKoniec, LicencjaEndUser, SprzedaneAstor, rowguid, BoundleLicenseNumber, partnumber, 
                      licenceversion, IsActive, LicencjeTypID, CSNumber
FROM         BDK.dbo.Licencje
GO
GRANT DELETE ON [dbo].[Licencje] TO [BDKProgramyZewnetrzne]
GO
GRANT INSERT ON [dbo].[Licencje] TO [BDKProgramyZewnetrzne]
GO
GRANT SELECT ON [dbo].[Licencje] TO [BDKProgramyZewnetrzne]
GO
GRANT UPDATE ON [dbo].[Licencje] TO [BDKProgramyZewnetrzne]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\MARCINWO].[KSA_Koniec_RepGen]
AS
SELECT     CKSA.CompanyFullName, CONVERT(varchar(10), L.CSCDKoniec, 120) AS KSAKoniec, COUNT(L.NumerLicencji) AS IloscLicencji, CKSA.ClientType, 
                      CClientOf.Answer AS ClientOf, CAST(L.CSCDKoniec - GETDATE() AS decimal) AS DniDoKonca, 
                      CASE WHEN CClientOf.answer LIKE '%Po?udnie%' THEN 'wwkatowice@astor.com.pl; wwwroclaw@astor.com.pl; kww@astor.com.pl' WHEN CClientOf.answer
                       LIKE '%gda?sk%' THEN 'wwgdansk@astor.com.pl' WHEN CClientOf.answer LIKE '%zach?d%' THEN 'wwzachod@astor.com.pl' WHEN CClientOf.answer
                       LIKE '%wroc?aw%' THEN 'wwwroclaw@astor.com.pl' WHEN CClientOf.answer LIKE '%warszawa%' THEN 'wwwarszawa@astor.com.pl' ELSE 'kww@astor.com.pl'
                       END + '; mw3@astor.com.pl' AS email
FROM         dbo.Licencje AS L INNER JOIN
                      [ASTOR\MARCINWO].CompanyKSAFlag AS CKSA ON L.IDFirmy = CKSA.CompanyGuid INNER JOIN
                      [ASTOR\MARCINWO].CompanyClientOf AS CClientOf ON L.IDFirmy = CClientOf.Guid
WHERE     (L.IsActive = 1) AND (L.NumerLicencjiNast IS NULL) AND (L.LicencjeTypID = 'b8e678d1-419f-435e-8466-165d7a8ade9a') AND (L.CSCD = 1) AND 
                      (L.CSCDKoniec < DATEADD(day, 60, GETDATE())) AND (CKSA.ClientType <> 'edukacja')
GROUP BY CKSA.CompanyFullName, CONVERT(varchar(10), L.CSCDKoniec, 120), CKSA.ClientType, CClientOf.Answer, CAST(L.CSCDKoniec - GETDATE() 
                      AS decimal)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\MARCINWO].[SRAstorSRTime]
AS
SELECT      OSI.ID, CAST((CASE WHEN RFQSIA.Answer IS NULL THEN 0 ELSE RFQSIA.Answer END) AS decimal) AS SRTime, 
                      dbo.OPerson.FirstName, dbo.OPerson.Surname, OSI.CreatedOn, OC.Name, CASE WHEN ((RCC.TypeID IS NULL AND OC.Name = 'Astor') OR
                      RCC.TypeId = 3) THEN 'ASTOR Centrala' WHEN RCC.TypeID = 5 THEN OC.Name END AS Oddzial, dbo.OUser.Nickname AS CreatedBy, 
                      RCP.ID AS RCPID
FROM         dbo.RSupportIssueCompanyPerson AS RSICP INNER JOIN
                      dbo.LSupportIssueRole AS LSIR ON RSICP.RoleId = LSIR.ID INNER JOIN
                      dbo.RCompanyPerson AS RCP ON RSICP.R2CompanyPersonId = RCP.ID INNER JOIN
                      dbo.OCompany AS OC ON OC.ID = RCP.R1CompanyID INNER JOIN
                      dbo.OPerson ON RCP.R2PersonID = dbo.OPerson.ID INNER JOIN
                      dbo.OSupportIssue AS OSI ON RSICP.R1SupportIssueId = OSI.ID INNER JOIN
                      dbo.OUser ON OSI.CreatedBy = dbo.OUser.ID LEFT OUTER JOIN
                      dbo.RFlagQuestionSupportIssueAnswer AS RFQSIA INNER JOIN
                      dbo.RFlagSupportIssue AS RFSI ON RFQSIA.R2FlagSupportIssueId = RFSI.Id ON RFQSIA.R1FlagQuestionId = 166813 AND 
                      OSI.ID = RFSI.R2SupportIssueId AND RFSI.R1FlagId = 1853 LEFT OUTER JOIN
                      dbo.OCompany AS OC1 INNER JOIN
                      dbo.RCompanyCompany AS RCC ON OC1.ID = RCC.R1CompanyId ON OC.ID = RCC.R2CompanyId
WHERE     (LSIR.ID = 8)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\MARCINWO].[SRAstorStaff]
AS
SELECT     Initials, Name, Email, PersonID, 
                      CASE WHEN Name = 'Artur Talaga' THEN 'Oprogramowanie' WHEN Name = 'Tomasz Micha?ek' THEN 'Roboty Przemys?owe' WHEN Name IN ('Pawe? Kubas',
                       '?ukasz M?ka') THEN 'Hardware' ELSE NazwaDzialu END AS Dzial
FROM         BDK.dbo.AstorStaff
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\MARCINWO].[SRFlagQA]
AS
SELECT     dbo.OSupportIssue.ID, dbo.OSupportIssue.Guid, dbo.OSupportIssue.ModifiedOn, dbo.OSupportIssue.CreatedOn, dbo.OSupportIssue.ModifiedBy, 
                      dbo.OSupportIssue.CreatedBy, CAST(dbo.OSupportIssue.Description AS nvarchar(300)) AS Description, dbo.OSupportIssue.StatusId, 
                      dbo.OSupportIssue.ResolutionId, dbo.OSupportIssue.REPLID, dbo.OSupportIssue.PriorityId, CAST(FQA1.Answer AS decimal) AS SRTime, 
                      CASE WHEN FQA2.Answer IS NULL THEN 'False' ELSE FQA2.Answer END AS KSASupport, CASE WHEN FQA3.Answer IS NULL 
                      THEN 'False' ELSE FQA3.Answer END AS PaidSupport
FROM         dbo.OSupportIssue LEFT OUTER JOIN
                      dbo.RFlagSupportIssue ON dbo.OSupportIssue.ID = dbo.RFlagSupportIssue.R2SupportIssueId AND 
                      dbo.RFlagSupportIssue.R1FlagId = 1853 LEFT OUTER JOIN
                      dbo.RFlagQuestionSupportIssueAnswer AS FQA1 ON dbo.RFlagSupportIssue.Id = FQA1.R2FlagSupportIssueId AND 
                      FQA1.R1FlagQuestionId = 166813 LEFT OUTER JOIN
                      dbo.RFlagQuestionSupportIssueAnswer AS FQA2 ON dbo.RFlagSupportIssue.Id = FQA2.R2FlagSupportIssueId AND 
                      FQA2.R1FlagQuestionId = 167813 LEFT OUTER JOIN
                      dbo.RFlagQuestionSupportIssueAnswer AS FQA3 ON dbo.RFlagSupportIssue.Id = FQA3.R2FlagSupportIssueId AND FQA3.R1FlagQuestionId = 167803exec sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'CList', 'COLUMN', N'IsOrdered'
GO
exec sp_addextendedproperty N'MS_Description', N'Czy wpis jest aktywny', 'SCHEMA', N'dbo', 'TABLE', N'EXT_LogChanges', 'COLUMN', N'Aktywny'
GO
exec sp_addextendedproperty N'MS_Description', N'1-Insert, 2 - Delete, 0 - Change', 'SCHEMA', N'dbo', 'TABLE', N'EXT_LogChanges', 'COLUMN', N'LogType'
GO
exec sp_addextendedproperty N'MS_Description', N'Pole w tabeli', 'SCHEMA', N'dbo', 'TABLE', N'EXT_LogChanges', 'COLUMN', N'Pole'
GO
exec sp_addextendedproperty N'MS_Description', N'Nazwa tabeli', 'SCHEMA', N'dbo', 'TABLE', N'EXT_LogChanges', 'COLUMN', N'Tabela'
GO
exec sp_addextendedproperty N'MS_Description', N'Wartosc poprzednia', 'SCHEMA', N'dbo', 'TABLE', N'EXT_LogChanges', 'COLUMN', N'ValuePrev'
GO
exec sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[20] 4[42] 2[11] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "CS_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 193
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'ASTOR\ANNAS', 'VIEW', N'CS'
GO
exec sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'ASTOR\ANNAS', 'VIEW', N'CS'
GO
exec sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[18] 4[21] 2[26] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[23] 4[34] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1[75] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 3
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "C"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 115
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FC1"
            Begin Extent = 
               Top = 6
               Left = 236
               Bottom = 115
               Right = 387
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FC2"
            Begin Extent = 
               Top = 6
               Left = 425
               Bottom = 115
               Right = 576
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FC3"
            Begin Extent = 
               Top = 6
               Left = 614
               Bottom = 115
               Right = 765
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FC4"
            Begin Extent = 
               Top = 120
               Left = 866
               Bottom = 228
               Right = 1017
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FC5"
            Begin Extent = 
               Top = 234
               Left = 38
               Bottom = 342
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FCA1"
            Begin Extent = 
               Top = 6
               Left = 803
               Bottom = 115
               Right = 972
            End
            DisplayFlags = 280
            T', 'SCHEMA', N'ASTOR\ANNAS', 'VIEW', N'MWo_CS_Lic_Renewal'
GO
exec sp_addextendedproperty N'MS_DiagramPane2', N'opColumn = 0
         End
         Begin Table = "FCA2"
            Begin Extent = 
               Top = 120
               Left = 38
               Bottom = 229
               Right = 207
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FCA3"
            Begin Extent = 
               Top = 120
               Left = 245
               Bottom = 229
               Right = 414
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FCA4"
            Begin Extent = 
               Top = 120
               Left = 452
               Bottom = 229
               Right = 621
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FCA5"
            Begin Extent = 
               Top = 120
               Left = 659
               Bottom = 229
               Right = 828
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FCA6"
            Begin Extent = 
               Top = 228
               Left = 866
               Bottom = 336
               Right = 1035
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FCA7"
            Begin Extent = 
               Top = 234
               Left = 227
               Bottom = 342
               Right = 396
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 13
         Width = 284
         Width = 1500
         Width = 1500
         Width = 4545
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1965
         Width = 2775
         Width = 1500
         Width = 1920
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4860
         Alias = 2190
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 5280
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'ASTOR\ANNAS', 'VIEW', N'MWo_CS_Lic_Renewal'
GO
exec sp_addextendedproperty N'MS_DiagramPaneCount', 2, 'SCHEMA', N'ASTOR\ANNAS', 'VIEW', N'MWo_CS_Lic_Renewal'
GO
exec sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "P"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 115
               Right = 214
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 27
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'ASTOR\ANNAS', 'VIEW', N'TEST_PRJ_Projekty'
GO
exec sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'ASTOR\ANNAS', 'VIEW', N'TEST_PRJ_Projekty'
GO
exec sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[53] 4[10] 2[14] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "OUser (dbo)"
            Begin Extent = 
               Top = 0
               Left = 754
               Bottom = 115
               Right = 906
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OSupportIssue (dbo)"
            Begin Extent = 
               Top = 32
               Left = 515
               Bottom = 269
               Right = 667
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LSupportIssueStatus (dbo)"
            Begin Extent = 
               Top = 247
               Left = 220
               Bottom = 362
               Right = 372
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "LSupportIssueResolution (dbo)"
            Begin Extent = 
               Top = 288
               Left = 455
               Bottom = 403
               Right = 607
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OCompany (dbo)"
            Begin Extent = 
               Top = 3
               Left = 13
               Bottom = 323
               Right = 175
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "RSupportIssueCompany (dbo)"
            Begin Extent = 
               Top = 0
               Left = 220
               Bottom = 248
               Right = 389
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidth', 'SCHEMA', N'ASTOR\JAROSLAWG', 'VIEW', N'JG_WWSR_Firm'
GO
exec sp_addextendedproperty N'MS_DiagramPaneCount', 2, 'SCHEMA', N'ASTOR\JAROSLAWG', 'VIEW', N'JG_WWSR_Firm'
GO
exec sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[3] 4[19] 2[55] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 27
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'viewProjects'
GO
exec sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'dbo', 'VIEW', N'viewProjects'
GO
exec sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[12] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "viewProjects"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'ASTOR\JAROSLAWG', 'VIEW', N'ProjektyMES_gen'
GO
exec sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'ASTOR\JAROSLAWG', 'VIEW', N'ProjektyMES_gen'
GO
exec sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 3
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'viewProjectsWithFirmsAndPersons'
GO
exec sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'dbo', 'VIEW', N'viewProjectsWithFirmsAndPersons'
GO
exec sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[24] 4[43] 2[15] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 143
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 6
               Left = 244
               Bottom = 143
               Right = 412
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 23
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'ASTOR\JAROSLAWG', 'VIEW', N'ProjektyMES_int'
GO
exec sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'ASTOR\JAROSLAWG', 'VIEW', N'ProjektyMES_int'
GO
exec sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[17] 4[61] 2[6] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4[60] 2) )"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2) )"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "OC1"
            Begin Extent = 
               Top = 11
               Left = 18
               Bottom = 249
               Right = 164
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RCC1"
            Begin Extent = 
               Top = 189
               Left = 184
               Bottom = 406
               Right = 335
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "OC2"
            Begin Extent = 
               Top = 124
               Left = 232
               Bottom = 366
               Right = 392
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "RFC1"
            Begin Extent = 
               Top = 318
               Left = 68
               Bottom = 426
               Right = 219
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "RFCA1"
            Begin Extent = 
               Top = 268
               Left = 154
               Bottom = 445
               Right = 323
            End
            DisplayFlags = 344
            TopColumn = 3
         End
         Begin Table = "RFC2"
            Begin Extent = 
               Top = 47
               Left = 597
               Bottom = 155
               Right = 748
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "RFCA2"
            Begin Extent = 
               Top = 17
               Left = 767
               Bottom = 198
               Right = 936
            End
            DisplayFlags = 344
            TopCol', 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'CompanyClientOf'
GO
exec sp_addextendedproperty N'MS_DiagramPane2', N'umn = 0
         End
         Begin Table = "RCC2"
            Begin Extent = 
               Top = 335
               Left = 398
               Bottom = 443
               Right = 549
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "OC3"
            Begin Extent = 
               Top = 258
               Left = 451
               Bottom = 427
               Right = 611
            End
            DisplayFlags = 344
            TopColumn = 4
         End
         Begin Table = "RFC3"
            Begin Extent = 
               Top = 176
               Left = 504
               Bottom = 284
               Right = 655
            End
            DisplayFlags = 344
            TopColumn = 3
         End
         Begin Table = "RFCA3"
            Begin Extent = 
               Top = 110
               Left = 557
               Bottom = 269
               Right = 726
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "RCC3"
            Begin Extent = 
               Top = 226
               Left = 662
               Bottom = 334
               Right = 813
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "OC4"
            Begin Extent = 
               Top = 229
               Left = 863
               Bottom = 337
               Right = 1023
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "RFC4"
            Begin Extent = 
               Top = 102
               Left = 893
               Bottom = 210
               Right = 1044
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "RFCA4"
            Begin Extent = 
               Top = 60
               Left = 1075
               Bottom = 168
               Right = 1244
            End
            DisplayFlags = 344
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 18
         Width = 284
         Width = 1785
         Width = 1740
         Width = 6750
         Width = 3480
         Width = 1530
         Width = 7620
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1515
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 6090
         Alias = 1425
         Table = 2625
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'CompanyClientOf'
GO
exec sp_addextendedproperty N'MS_DiagramPaneCount', 2, 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'CompanyClientOf'
GO
exec sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[52] 4[17] 2[13] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "OC1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RCC1"
            Begin Extent = 
               Top = 6
               Left = 236
               Bottom = 114
               Right = 387
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OC2"
            Begin Extent = 
               Top = 6
               Left = 425
               Bottom = 114
               Right = 585
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RFC1"
            Begin Extent = 
               Top = 6
               Left = 623
               Bottom = 114
               Right = 774
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RFCA1"
            Begin Extent = 
               Top = 6
               Left = 812
               Bottom = 114
               Right = 981
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RFC2"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RFCA2"
            Begin Extent = 
               Top = 114
               Left = 227
               Bottom = 222
               Right = 396
            End
            DisplayFlags = 280
            TopColumn = 0', 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'CompanyClientType'
GO
exec sp_addextendedproperty N'MS_DiagramPane2', N'
         End
         Begin Table = "RCC2"
            Begin Extent = 
               Top = 114
               Left = 434
               Bottom = 222
               Right = 585
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OC3"
            Begin Extent = 
               Top = 114
               Left = 623
               Bottom = 222
               Right = 783
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RFC3"
            Begin Extent = 
               Top = 114
               Left = 821
               Bottom = 222
               Right = 972
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RFCA3"
            Begin Extent = 
               Top = 222
               Left = 38
               Bottom = 330
               Right = 207
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RCC3"
            Begin Extent = 
               Top = 222
               Left = 245
               Bottom = 330
               Right = 396
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OC4"
            Begin Extent = 
               Top = 222
               Left = 434
               Bottom = 330
               Right = 594
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RFC4"
            Begin Extent = 
               Top = 222
               Left = 632
               Bottom = 330
               Right = 783
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RFCA4"
            Begin Extent = 
               Top = 222
               Left = 821
               Bottom = 330
               Right = 990
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 18
         Width = 284
         Width = 1500
         Width = 1500
         Width = 3810
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1875
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'CompanyClientType'
GO
exec sp_addextendedproperty N'MS_DiagramPaneCount', 2, 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'CompanyClientType'
GO
exec sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[44] 4[23] 2[11] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "OC"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 282
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RFC_KSA"
            Begin Extent = 
               Top = 44
               Left = 466
               Bottom = 137
               Right = 657
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RFQCA_KSA"
            Begin Extent = 
               Top = 22
               Left = 738
               Bottom = 180
               Right = 907
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "CT"
            Begin Extent = 
               Top = 132
               Left = 235
               Bottom = 290
               Right = 395
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1320
         Width = 1320
         Width = 6990
         Width = 1500
         Width = 3540
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 6915
         Alias = 1770
         Table = 1905
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 2370
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
', 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'CompanyKSAFlag'
GO
exec sp_addextendedproperty N'MS_DiagramPane2', N'End
', 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'CompanyKSAFlag'
GO
exec sp_addextendedproperty N'MS_DiagramPaneCount', 2, 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'CompanyKSAFlag'
GO
exec sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[45] 4[27] 2[7] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "RCP"
            Begin Extent = 
               Top = 11
               Left = 17
               Bottom = 293
               Right = 192
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OP"
            Begin Extent = 
               Top = 95
               Left = 232
               Bottom = 214
               Right = 383
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "LOS"
            Begin Extent = 
               Top = 179
               Left = 222
               Bottom = 253
               Right = 383
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "RFCP"
            Begin Extent = 
               Top = 2
               Left = 415
               Bottom = 202
               Right = 596
            End
            DisplayFlags = 344
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 14
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2280
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 13', 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'CompanyPersonKSAFlag'
GO
exec sp_addextendedproperty N'MS_DiagramPane2', N'50
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'CompanyPersonKSAFlag'
GO
exec sp_addextendedproperty N'MS_DiagramPaneCount', 2, 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'CompanyPersonKSAFlag'
GO
exec sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[33] 4[26] 2[22] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "RCP"
            Begin Extent = 
               Top = 20
               Left = 69
               Bottom = 189
               Right = 220
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RFCP"
            Begin Extent = 
               Top = 44
               Left = 354
               Bottom = 152
               Right = 535
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RFQCP"
            Begin Extent = 
               Top = 11
               Left = 642
               Bottom = 183
               Right = 843
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2670
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'CompanyPersonKSAKontaktFlag'
GO
exec sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'CompanyPersonKSAKontaktFlag'
GO
exec sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[23] 4[47] 2[12] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1 [56] 4 [18] 2))"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TabCen (BDK.dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 251
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      RowHeights = 220
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'TabCen'
GO
exec sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'dbo', 'VIEW', N'TabCen'
GO
exec sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1 [56] 4 [18] 2))"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TabTowar?w_1"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 135
               Right = 298
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'TabTowar?w'
GO
exec sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'dbo', 'VIEW', N'TabTowar?w'
GO
exec sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tt"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 272
               Right = 259
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tc"
            Begin Extent = 
               Top = 18
               Left = 367
               Bottom = 278
               Right = 580
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2970
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 2805
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'ConsignRenewalTabTowarow'
GO
exec sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'ConsignRenewalTabTowarow'
GO
exec sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[27] 2[18] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 3
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 2790
         Width = 2280
         Width = 2550
         Width = 1755
         Width = 2265
         Width = 1500
         Width = 1950
         Width = 1500
         Width = 1740
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1770
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 2430
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'ConsignRenewalTrace'
GO
exec sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'ConsignRenewalTrace'
GO
exec sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1 [56] 4 [18] 2))"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Licencje (BDK.dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 259
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 10
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      RowHeights = 220
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'Licencje'
GO
exec sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'dbo', 'VIEW', N'Licencje'
GO
exec sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[28] 4[23] 2[36] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "L"
            Begin Extent = 
               Top = 6
               Left = 22
               Bottom = 282
               Right = 214
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CKSA"
            Begin Extent = 
               Top = 9
               Left = 269
               Bottom = 196
               Right = 448
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CClientOf"
            Begin Extent = 
               Top = 31
               Left = 499
               Bottom = 219
               Right = 659
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 3720
         Width = 1440
         Width = 1215
         Width = 2175
         Width = 2055
         Width = 1020
         Width = 3960
         Width = 2700
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 4950
         Alias = 1710
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 2880
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'KSA_Koniec_RepGen'
GO
exec sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'KSA_Koniec_RepGen'
GO
exec sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[49] 4[21] 2[7] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[34] 4[31] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[49] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[50] 3) )"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 1
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "RSICP"
            Begin Extent = 
               Top = 132
               Left = 285
               Bottom = 255
               Right = 549
            End
            DisplayFlags = 344
            TopColumn = 2
         End
         Begin Table = "LSIR"
            Begin Extent = 
               Top = 178
               Left = 17
               Bottom = 368
               Right = 233
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RCP"
            Begin Extent = 
               Top = 213
               Left = 414
               Bottom = 339
               Right = 565
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OC"
            Begin Extent = 
               Top = 29
               Left = 717
               Bottom = 237
               Right = 877
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "OPerson (dbo)"
            Begin Extent = 
               Top = 260
               Left = 757
               Bottom = 368
               Right = 908
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OSI"
            Begin Extent = 
               Top = 18
               Left = 15
               Bottom = 162
               Right = 250
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OUser (dbo)"
            Begin Extent = 
               Top = 168
               Left = 351
               Bottom = 276
               Right = 553
            End
            DisplayFlags = 344
       ', 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'SRAstorSRTime'
GO
exec sp_addextendedproperty N'MS_DiagramPane2', N'     TopColumn = 0
         End
         Begin Table = "RFQSIA"
            Begin Extent = 
               Top = 69
               Left = 478
               Bottom = 236
               Right = 665
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "RFSI"
            Begin Extent = 
               Top = 28
               Left = 298
               Bottom = 136
               Right = 465
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "OC1"
            Begin Extent = 
               Top = 202
               Left = 1024
               Bottom = 310
               Right = 1184
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "RCC"
            Begin Extent = 
               Top = 20
               Left = 941
               Bottom = 128
               Right = 1092
            End
            DisplayFlags = 280
            TopColumn = 5
         End
      End
   End
   Begin SQLPane = 
      PaneHidden = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 825
         Width = 1245
         Width = 1140
         Width = 1755
         Width = 1665
         Width = 1740
         Width = 1935
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 5625
         Alias = 900
         Table = 2370
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 2715
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'SRAstorSRTime'
GO
exec sp_addextendedproperty N'MS_DiagramPaneCount', 2, 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'SRAstorSRTime'
GO
exec sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[36] 4[18] 2[24] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AstorStaff (BDK.dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 275
               Right = 223
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 21
         Width = 284
         Width = 2070
         Width = 2100
         Width = 1980
         Width = 2910
         Width = 2415
         Width = 690
         Width = 795
         Width = 1500
         Width = 1500
         Width = 2415
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1860
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'SRAstorStaff'
GO
exec sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'ASTOR\MARCINWO', 'VIEW', N'SRAstorStaff'
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\MARCINWO].[SRClientOf]
AS
SELECT     [ASTOR\MARCINWO].SRFlagQA.ID, [ASTOR\MARCINWO].SRFlagQA.CreatedOn, [ASTOR\MARCINWO].CompanyClientOf.DerivedFullName, 
                      CASE WHEN companyclientof.answer = '[nie okre?lony]' THEN companyclientof.parentanswer ELSE companyclientof.answer END AS ClientOf, 
                      [ASTOR\MARCINWO].SRAstorStaff.Dzial, [ASTOR\MARCINWO].SRFlagQA.SRTime, [ASTOR\MARCINWO].SRFlagQA.KSASupport, 
                      [ASTOR\MARCINWO].SRFlagQA.PaidSupport, OPResolver.FirstName, OPResolver.Surname, CASE WHEN ((RCC.TypeID IS NULL AND 
                      ocresolver.Name = 'Astor') OR
                      RCC.TypeId = 3) THEN 'ASTOR Centrala' WHEN RCC.TypeID = 5 THEN OCresolver.Name END AS AstorBranch
FROM         [ASTOR\MARCINWO].SRFlagQA LEFT OUTER JOIN
                      dbo.RSupportIssueCompanyPerson AS RSICPRegister ON [ASTOR\MARCINWO].SRFlagQA.ID = RSICPRegister.R1SupportIssueId INNER JOIN
                      dbo.RCompanyPerson ON RSICPRegister.R2CompanyPersonId = dbo.RCompanyPerson.ID INNER JOIN
                      [ASTOR\MARCINWO].CompanyClientOf ON dbo.RCompanyPerson.R1CompanyID = [ASTOR\MARCINWO].CompanyClientOf.ID INNER JOIN
                      dbo.OUser ON [ASTOR\MARCINWO].SRFlagQA.CreatedBy = dbo.OUser.ID INNER JOIN
                      [ASTOR\MARCINWO].SRAstorStaff ON dbo.OUser.Nickname = [ASTOR\MARCINWO].SRAstorStaff.Initials COLLATE Polish_CI_AS INNER JOIN
                      dbo.RSupportIssueCompanyPerson AS RSICPResolver ON RSICPRegister.R1SupportIssueId = RSICPResolver.R1SupportIssueId INNER JOIN
                      dbo.RCompanyPerson AS RCPResolver ON RSICPResolver.R2CompanyPersonId = RCPResolver.ID INNER JOIN
                      dbo.OPerson AS OPResolver ON RCPResolver.R2PersonID = OPResolver.ID INNER JOIN
                      dbo.OCompany AS OCResolver ON RCPResolver.R1CompanyID = OCResolver.ID LEFT OUTER JOIN
                      dbo.RCompanyCompany AS RCC ON OCResolver.ID = RCC.R2CompanyId
WHERE     (RSICPRegister.RoleId = 5) AND (NOT ([ASTOR\MARCINWO].CompanyClientOf.DerivedFullName LIKE '%astor%')) AND (RSICPResolver.RoleId = 8) AND 
                      (OCResolver.DerivedFullName LIKE '%astor%')
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ASTOR\MARCINWO].[SRLastClosedSRs]
AS
SELECT     [ASTOR\MARCINWO].SRFlagQA.ID, [ASTOR\MARCINWO].SRFlagQA.Description, [ASTOR\MARCINWO].SRFlagQA.CreatedOn, dbo.OPerson.FirstName, 
                      dbo.OPerson.Surname, [ASTOR\MARCINWO].SRAstorStaff.Dzial, HSupportIssue.ClosedOn, [ASTOR\MARCINWO].SRFlagQA.SRTime, 
                      [ASTOR\MARCINWO].SRFlagQA.KSASupport, [ASTOR\MARCINWO].SRFlagQA.PaidSupport, [ASTOR\MARCINWO].SRAstorStaff.Initials, 
                      dbo.RSupportIssueArticle.R2ArticleId AS KBId
FROM         [ASTOR\MARCINWO].SRFlagQA LEFT OUTER JOIN
                      dbo.RSupportIssueCompanyPerson ON [ASTOR\MARCINWO].SRFlagQA.ID = dbo.RSupportIssueCompanyPerson.R1SupportIssueId INNER JOIN
                      dbo.RCompanyPerson ON dbo.RSupportIssueCompanyPerson.R2CompanyPersonId = dbo.RCompanyPerson.ID INNER JOIN
                      dbo.OPerson ON dbo.RCompanyPerson.R2PersonID = dbo.OPerson.ID INNER JOIN
                      [ASTOR\MARCINWO].SRAstorStaff ON dbo.OPerson.Guid = [ASTOR\MARCINWO].SRAstorStaff.PersonID LEFT OUTER JOIN
                          (SELECT     HOSI1.OriginalId AS ID, MAX(HOSI1.CompletedOn) AS ClosedOn
                            FROM          dbo.HOSupportIssue AS HOSI1 INNER JOIN
                                                   dbo.LSupportIssueStatus AS LSIStat1 ON HOSI1.StatusId = LSIStat1.Id
                            WHERE      (LSIStat1.IsFinal = 1)
                            GROUP BY HOSI1.OriginalId) AS HSupportIssue ON [ASTOR\MARCINWO].SRFlagQA.ID = HSupportIssue.ID LEFT OUTER JOIN
                      dbo.RSupportIssueArticle ON [ASTOR\MARCINWO].SRFlagQA.ID = dbo.RSupportIssueArticle.R1SupportIssueId
WHERE     (dbo.RSupportIssueCompanyPerson.RoleId = 8)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[MSmerge_del_sp_0563489776F54D95088C28474D1D4D57]
(
    @rowstobedeleted int, 
    @partition_id int = NULL  ,
    @rowguid1 uniqueidentifier = NULL,
    @metadata_type1 tinyint = NULL,
    @generation1 bigint = NULL,
    @lineage_old1 varbinary(311) = NULL,
    @lineage_new1 varbinary(311) = NULL,
    @rowguid2 uniqueidentifier = NULL,
    @metadata_type2 tinyint = NULL,
    @generation2 bigint = NULL,
    @lineage_old2 varbinary(311) = NULL,
    @lineage_new2 varbinary(311) = NULL,
    @rowguid3 uniqueidentifier = NULL,
    @metadata_type3 tinyint = NULL,
    @generation3 bigint = NULL,
    @lineage_old3 varbinary(311) = NULL,
    @lineage_new3 varbinary(311) = NULL,
    @rowguid4 uniqueidentifier = NULL,
    @metadata_type4 tinyint = NULL,
    @generation4 bigint = NULL,
    @lineage_old4 varbinary(311) = NULL,
    @lineage_new4 varbinary(311) = NULL,
    @rowguid5 uniqueidentifier = NULL,
    @metadata_type5 tinyint = NULL,
    @generation5 bigint = NULL,
    @lineage_old5 varbinary(311) = NULL,
    @lineage_new5 varbinary(311) = NULL,
    @rowguid6 uniqueidentifier = NULL,
    @metadata_type6 tinyint = NULL,
    @generation6 bigint = NULL,
    @lineage_old6 varbinary(311) = NULL,
    @lineage_new6 varbinary(311) = NULL,
    @rowguid7 uniqueidentifier = NULL,
    @metadata_type7 tinyint = NULL,
    @generation7 bigint = NULL,
    @lineage_old7 varbinary(311) = NULL,
    @lineage_new7 varbinary(311) = NULL,
    @rowguid8 uniqueidentifier = NULL,
    @metadata_type8 tinyint = NULL,
    @generation8 bigint = NULL,
    @lineage_old8 varbinary(311) = NULL,
    @lineage_new8 varbinary(311) = NULL,
    @rowguid9 uniqueidentifier = NULL,
    @metadata_type9 tinyint = NULL,
    @generation9 bigint = NULL,
    @lineage_old9 varbinary(311) = NULL,
    @lineage_new9 varbinary(311) = NULL,
    @rowguid10 uniqueidentifier = NULL,
    @metadata_type10 tinyint = NULL,
    @generation10 bigint = NULL,
    @lineage_old10 varbinary(311) = NULL,
    @lineage_new10 varbinary(311) = NULL ,
    @rowguid11 uniqueidentifier = NULL,
    @metadata_type11 tinyint = NULL,
    @generation11 bigint = NULL,
    @lineage_old11 varbinary(311) = NULL,
    @lineage_new11 varbinary(311) = NULL,
    @rowguid12 uniqueidentifier = NULL,
    @metadata_type12 tinyint = NULL,
    @generation12 bigint = NULL,
    @lineage_old12 varbinary(311) = NULL,
    @lineage_new12 varbinary(311) = NULL,
    @rowguid13 uniqueidentifier = NULL,
    @metadata_type13 tinyint = NULL,
    @generation13 bigint = NULL,
    @lineage_old13 varbinary(311) = NULL,
    @lineage_new13 varbinary(311) = NULL,
    @rowguid14 uniqueidentifier = NULL,
    @metadata_type14 tinyint = NULL,
    @generation14 bigint = NULL,
    @lineage_old14 varbinary(311) = NULL,
    @lineage_new14 varbinary(311) = NULL,
    @rowguid15 uniqueidentifier = NULL,
    @metadata_type15 tinyint = NULL,
    @generation15 bigint = NULL,
    @lineage_old15 varbinary(311) = NULL,
    @lineage_new15 varbinary(311) = NULL,
    @rowguid16 uniqueidentifier = NULL,
    @metadata_type16 tinyint = NULL,
    @generation16 bigint = NULL,
    @lineage_old16 varbinary(311) = NULL,
    @lineage_new16 varbinary(311) = NULL,
    @rowguid17 uniqueidentifier = NULL,
    @metadata_type17 tinyint = NULL,
    @generation17 bigint = NULL,
    @lineage_old17 varbinary(311) = NULL,
    @lineage_new17 varbinary(311) = NULL,
    @rowguid18 uniqueidentifier = NULL,
    @metadata_type18 tinyint = NULL,
    @generation18 bigint = NULL,
    @lineage_old18 varbinary(311) = NULL,
    @lineage_new18 varbinary(311) = NULL,
    @rowguid19 uniqueidentifier = NULL,
    @metadata_type19 tinyint = NULL,
    @generation19 bigint = NULL,
    @lineage_old19 varbinary(311) = NULL,
    @lineage_new19 varbinary(311) = NULL,
    @rowguid20 uniqueidentifier = NULL,
    @metadata_type20 tinyint = NULL,
    @generation20 bigint = NULL,
    @lineage_old20 varbinary(311) = NULL,
    @lineage_new20 varbinary(311) = NULL ,
    @rowguid21 uniqueidentifier = NULL,
    @metadata_type21 tinyint = NULL,
    @generation21 bigint = NULL,
    @lineage_old21 varbinary(311) = NULL,
    @lineage_new21 varbinary(311) = NULL,
    @rowguid22 uniqueidentifier = NULL,
    @metadata_type22 tinyint = NULL,
    @generation22 bigint = NULL,
    @lineage_old22 varbinary(311) = NULL,
    @lineage_new22 varbinary(311) = NULL,
    @rowguid23 uniqueidentifier = NULL,
    @metadata_type23 tinyint = NULL,
    @generation23 bigint = NULL,
    @lineage_old23 varbinary(311) = NULL,
    @lineage_new23 varbinary(311) = NULL,
    @rowguid24 uniqueidentifier = NULL,
    @metadata_type24 tinyint = NULL,
    @generation24 bigint = NULL,
    @lineage_old24 varbinary(311) = NULL,
    @lineage_new24 varbinary(311) = NULL,
    @rowguid25 uniqueidentifier = NULL,
    @metadata_type25 tinyint = NULL,
    @generation25 bigint = NULL,
    @lineage_old25 varbinary(311) = NULL,
    @lineage_new25 varbinary(311) = NULL,
    @rowguid26 uniqueidentifier = NULL,
    @metadata_type26 tinyint = NULL,
    @generation26 bigint = NULL,
    @lineage_old26 varbinary(311) = NULL,
    @lineage_new26 varbinary(311) = NULL,
    @rowguid27 uniqueidentifier = NULL,
    @metadata_type27 tinyint = NULL,
    @generation27 bigint = NULL,
    @lineage_old27 varbinary(311) = NULL,
    @lineage_new27 varbinary(311) = NULL,
    @rowguid28 uniqueidentifier = NULL,
    @metadata_type28 tinyint = NULL,
    @generation28 bigint = NULL,
    @lineage_old28 varbinary(311) = NULL,
    @lineage_new28 varbinary(311) = NULL,
    @rowguid29 uniqueidentifier = NULL,
    @metadata_type29 tinyint = NULL,
    @generation29 bigint = NULL,
    @lineage_old29 varbinary(311) = NULL,
    @lineage_new29 varbinary(311) = NULL,
    @rowguid30 uniqueidentifier = NULL,
    @metadata_type30 tinyint = NULL,
    @generation30 bigint = NULL,
    @lineage_old30 varbinary(311) = NULL,
    @lineage_new30 varbinary(311) = NULL ,
    @rowguid31 uniqueidentifier = NULL,
    @metadata_type31 tinyint = NULL,
    @generation31 bigint = NULL,
    @lineage_old31 varbinary(311) = NULL,
    @lineage_new31 varbinary(311) = NULL,
    @rowguid32 uniqueidentifier = NULL,
    @metadata_type32 tinyint = NULL,
    @generation32 bigint = NULL,
    @lineage_old32 varbinary(311) = NULL,
    @lineage_new32 varbinary(311) = NULL,
    @rowguid33 uniqueidentifier = NULL,
    @metadata_type33 tinyint = NULL,
    @generation33 bigint = NULL,
    @lineage_old33 varbinary(311) = NULL,
    @lineage_new33 varbinary(311) = NULL,
    @rowguid34 uniqueidentifier = NULL,
    @metadata_type34 tinyint = NULL,
    @generation34 bigint = NULL,
    @lineage_old34 varbinary(311) = NULL,
    @lineage_new34 varbinary(311) = NULL,
    @rowguid35 uniqueidentifier = NULL,
    @metadata_type35 tinyint = NULL,
    @generation35 bigint = NULL,
    @lineage_old35 varbinary(311) = NULL,
    @lineage_new35 varbinary(311) = NULL,
    @rowguid36 uniqueidentifier = NULL,
    @metadata_type36 tinyint = NULL,
    @generation36 bigint = NULL,
    @lineage_old36 varbinary(311) = NULL,
    @lineage_new36 varbinary(311) = NULL,
    @rowguid37 uniqueidentifier = NULL,
    @metadata_type37 tinyint = NULL,
    @generation37 bigint = NULL,
    @lineage_old37 varbinary(311) = NULL,
    @lineage_new37 varbinary(311) = NULL,
    @rowguid38 uniqueidentifier = NULL,
    @metadata_type38 tinyint = NULL,
    @generation38 bigint = NULL,
    @lineage_old38 varbinary(311) = NULL,
    @lineage_new38 varbinary(311) = NULL,
    @rowguid39 uniqueidentifier = NULL,
    @metadata_type39 tinyint = NULL,
    @generation39 bigint = NULL,
    @lineage_old39 varbinary(311) = NULL,
    @lineage_new39 varbinary(311) = NULL,
    @rowguid40 uniqueidentifier = NULL,
    @metadata_type40 tinyint = NULL,
    @generation40 bigint = NULL,
    @lineage_old40 varbinary(311) = NULL,
    @lineage_new40 varbinary(311) = NULL ,
    @rowguid41 uniqueidentifier = NULL,
    @metadata_type41 tinyint = NULL,
    @generation41 bigint = NULL,
    @lineage_old41 varbinary(311) = NULL,
    @lineage_new41 varbinary(311) = NULL,
    @rowguid42 uniqueidentifier = NULL,
    @metadata_type42 tinyint = NULL,
    @generation42 bigint = NULL,
    @lineage_old42 varbinary(311) = NULL,
    @lineage_new42 varbinary(311) = NULL,
    @rowguid43 uniqueidentifier = NULL,
    @metadata_type43 tinyint = NULL,
    @generation43 bigint = NULL,
    @lineage_old43 varbinary(311) = NULL,
    @lineage_new43 varbinary(311) = NULL,
    @rowguid44 uniqueidentifier = NULL,
    @metadata_type44 tinyint = NULL,
    @generation44 bigint = NULL,
    @lineage_old44 varbinary(311) = NULL,
    @lineage_new44 varbinary(311) = NULL,
    @rowguid45 uniqueidentifier = NULL,
    @metadata_type45 tinyint = NULL,
    @generation45 bigint = NULL,
    @lineage_old45 varbinary(311) = NULL,
    @lineage_new45 varbinary(311) = NULL,
    @rowguid46 uniqueidentifier = NULL,
    @metadata_type46 tinyint = NULL,
    @generation46 bigint = NULL,
    @lineage_old46 varbinary(311) = NULL,
    @lineage_new46 varbinary(311) = NULL,
    @rowguid47 uniqueidentifier = NULL,
    @metadata_type47 tinyint = NULL,
    @generation47 bigint = NULL,
    @lineage_old47 varbinary(311) = NULL,
    @lineage_new47 varbinary(311) = NULL,
    @rowguid48 uniqueidentifier = NULL,
    @metadata_type48 tinyint = NULL,
    @generation48 bigint = NULL,
    @lineage_old48 varbinary(311) = NULL,
    @lineage_new48 varbinary(311) = NULL,
    @rowguid49 uniqueidentifier = NULL,
    @metadata_type49 tinyint = NULL,
    @generation49 bigint = NULL,
    @lineage_old49 varbinary(311) = NULL,
    @lineage_new49 varbinary(311) = NULL,
    @rowguid50 uniqueidentifier = NULL,
    @metadata_type50 tinyint = NULL,
    @generation50 bigint = NULL,
    @lineage_old50 varbinary(311) = NULL,
    @lineage_new50 varbinary(311) = NULL ,
    @rowguid51 uniqueidentifier = NULL,
    @metadata_type51 tinyint = NULL,
    @generation51 bigint = NULL,
    @lineage_old51 varbinary(311) = NULL,
    @lineage_new51 varbinary(311) = NULL,
    @rowguid52 uniqueidentifier = NULL,
    @metadata_type52 tinyint = NULL,
    @generation52 bigint = NULL,
    @lineage_old52 varbinary(311) = NULL,
    @lineage_new52 varbinary(311) = NULL,
    @rowguid53 uniqueidentifier = NULL,
    @metadata_type53 tinyint = NULL,
    @generation53 bigint = NULL,
    @lineage_old53 varbinary(311) = NULL,
    @lineage_new53 varbinary(311) = NULL,
    @rowguid54 uniqueidentifier = NULL,
    @metadata_type54 tinyint = NULL,
    @generation54 bigint = NULL,
    @lineage_old54 varbinary(311) = NULL,
    @lineage_new54 varbinary(311) = NULL,
    @rowguid55 uniqueidentifier = NULL,
    @metadata_type55 tinyint = NULL,
    @generation55 bigint = NULL,
    @lineage_old55 varbinary(311) = NULL,
    @lineage_new55 varbinary(311) = NULL,
    @rowguid56 uniqueidentifier = NULL,
    @metadata_type56 tinyint = NULL,
    @generation56 bigint = NULL,
    @lineage_old56 varbinary(311) = NULL,
    @lineage_new56 varbinary(311) = NULL,
    @rowguid57 uniqueidentifier = NULL,
    @metadata_type57 tinyint = NULL,
    @generation57 bigint = NULL,
    @lineage_old57 varbinary(311) = NULL,
    @lineage_new57 varbinary(311) = NULL,
    @rowguid58 uniqueidentifier = NULL,
    @metadata_type58 tinyint = NULL,
    @generation58 bigint = NULL,
    @lineage_old58 varbinary(311) = NULL,
    @lineage_new58 varbinary(311) = NULL,
    @rowguid59 uniqueidentifier = NULL,
    @metadata_type59 tinyint = NULL,
    @generation59 bigint = NULL,
    @lineage_old59 varbinary(311) = NULL,
    @lineage_new59 varbinary(311) = NULL,
    @rowguid60 uniqueidentifier = NULL,
    @metadata_type60 tinyint = NULL,
    @generation60 bigint = NULL,
    @lineage_old60 varbinary(311) = NULL,
    @lineage_new60 varbinary(311) = NULL ,
    @rowguid61 uniqueidentifier = NULL,
    @metadata_type61 tinyint = NULL,
    @generation61 bigint = NULL,
    @lineage_old61 varbinary(311) = NULL,
    @lineage_new61 varbinary(311) = NULL,
    @rowguid62 uniqueidentifier = NULL,
    @metadata_type62 tinyint = NULL,
    @generation62 bigint = NULL,
    @lineage_old62 varbinary(311) = NULL,
    @lineage_new62 varbinary(311) = NULL,
    @rowguid63 uniqueidentifier = NULL,
    @metadata_type63 tinyint = NULL,
    @generation63 bigint = NULL,
    @lineage_old63 varbinary(311) = NULL,
    @lineage_new63 varbinary(311) = NULL,
    @rowguid64 uniqueidentifier = NULL,
    @metadata_type64 tinyint = NULL,
    @generation64 bigint = NULL,
    @lineage_old64 varbinary(311) = NULL,
    @lineage_new64 varbinary(311) = NULL,
    @rowguid65 uniqueidentifier = NULL,
    @metadata_type65 tinyint = NULL,
    @generation65 bigint = NULL,
    @lineage_old65 varbinary(311) = NULL,
    @lineage_new65 varbinary(311) = NULL,
    @rowguid66 uniqueidentifier = NULL,
    @metadata_type66 tinyint = NULL,
    @generation66 bigint = NULL,
    @lineage_old66 varbinary(311) = NULL,
    @lineage_new66 varbinary(311) = NULL,
    @rowguid67 uniqueidentifier = NULL,
    @metadata_type67 tinyint = NULL,
    @generation67 bigint = NULL,
    @lineage_old67 varbinary(311) = NULL,
    @lineage_new67 varbinary(311) = NULL,
    @rowguid68 uniqueidentifier = NULL,
    @metadata_type68 tinyint = NULL,
    @generation68 bigint = NULL,
    @lineage_old68 varbinary(311) = NULL,
    @lineage_new68 varbinary(311) = NULL,
    @rowguid69 uniqueidentifier = NULL,
    @metadata_type69 tinyint = NULL,
    @generation69 bigint = NULL,
    @lineage_old69 varbinary(311) = NULL,
    @lineage_new69 varbinary(311) = NULL,
    @rowguid70 uniqueidentifier = NULL,
    @metadata_type70 tinyint = NULL,
    @generation70 bigint = NULL,
    @lineage_old70 varbinary(311) = NULL,
    @lineage_new70 varbinary(311) = NULL ,
    @rowguid71 uniqueidentifier = NULL,
    @metadata_type71 tinyint = NULL,
    @generation71 bigint = NULL,
    @lineage_old71 varbinary(311) = NULL,
    @lineage_new71 varbinary(311) = NULL,
    @rowguid72 uniqueidentifier = NULL,
    @metadata_type72 tinyint = NULL,
    @generation72 bigint = NULL,
    @lineage_old72 varbinary(311) = NULL,
    @lineage_new72 varbinary(311) = NULL,
    @rowguid73 uniqueidentifier = NULL,
    @metadata_type73 tinyint = NULL,
    @generation73 bigint = NULL,
    @lineage_old73 varbinary(311) = NULL,
    @lineage_new73 varbinary(311) = NULL,
    @rowguid74 uniqueidentifier = NULL,
    @metadata_type74 tinyint = NULL,
    @generation74 bigint = NULL,
    @lineage_old74 varbinary(311) = NULL,
    @lineage_new74 varbinary(311) = NULL,
    @rowguid75 uniqueidentifier = NULL,
    @metadata_type75 tinyint = NULL,
    @generation75 bigint = NULL,
    @lineage_old75 varbinary(311) = NULL,
    @lineage_new75 varbinary(311) = NULL,
    @rowguid76 uniqueidentifier = NULL,
    @metadata_type76 tinyint = NULL,
    @generation76 bigint = NULL,
    @lineage_old76 varbinary(311) = NULL,
    @lineage_new76 varbinary(311) = NULL,
    @rowguid77 uniqueidentifier = NULL,
    @metadata_type77 tinyint = NULL,
    @generation77 bigint = NULL,
    @lineage_old77 varbinary(311) = NULL,
    @lineage_new77 varbinary(311) = NULL,
    @rowguid78 uniqueidentifier = NULL,
    @metadata_type78 tinyint = NULL,
    @generation78 bigint = NULL,
    @lineage_old78 varbinary(311) = NULL,
    @lineage_new78 varbinary(311) = NULL,
    @rowguid79 uniqueidentifier = NULL,
    @metadata_type79 tinyint = NULL,
    @generation79 bigint = NULL,
    @lineage_old79 varbinary(311) = NULL,
    @lineage_new79 varbinary(311) = NULL,
    @rowguid80 uniqueidentifier = NULL,
    @metadata_type80 tinyint = NULL,
    @generation80 bigint = NULL,
    @lineage_old80 varbinary(311) = NULL,
    @lineage_new80 varbinary(311) = NULL ,
    @rowguid81 uniqueidentifier = NULL,
    @metadata_type81 tinyint = NULL,
    @generation81 bigint = NULL,
    @lineage_old81 varbinary(311) = NULL,
    @lineage_new81 varbinary(311) = NULL,
    @rowguid82 uniqueidentifier = NULL,
    @metadata_type82 tinyint = NULL,
    @generation82 bigint = NULL,
    @lineage_old82 varbinary(311) = NULL,
    @lineage_new82 varbinary(311) = NULL,
    @rowguid83 uniqueidentifier = NULL,
    @metadata_type83 tinyint = NULL,
    @generation83 bigint = NULL,
    @lineage_old83 varbinary(311) = NULL,
    @lineage_new83 varbinary(311) = NULL,
    @rowguid84 uniqueidentifier = NULL,
    @metadata_type84 tinyint = NULL,
    @generation84 bigint = NULL,
    @lineage_old84 varbinary(311) = NULL,
    @lineage_new84 varbinary(311) = NULL,
    @rowguid85 uniqueidentifier = NULL,
    @metadata_type85 tinyint = NULL,
    @generation85 bigint = NULL,
    @lineage_old85 varbinary(311) = NULL,
    @lineage_new85 varbinary(311) = NULL,
    @rowguid86 uniqueidentifier = NULL,
    @metadata_type86 tinyint = NULL,
    @generation86 bigint = NULL,
    @lineage_old86 varbinary(311) = NULL,
    @lineage_new86 varbinary(311) = NULL,
    @rowguid87 uniqueidentifier = NULL,
    @metadata_type87 tinyint = NULL,
    @generation87 bigint = NULL,
    @lineage_old87 varbinary(311) = NULL,
    @lineage_new87 varbinary(311) = NULL,
    @rowguid88 uniqueidentifier = NULL,
    @metadata_type88 tinyint = NULL,
    @generation88 bigint = NULL,
    @lineage_old88 varbinary(311) = NULL,
    @lineage_new88 varbinary(311) = NULL,
    @rowguid89 uniqueidentifier = NULL,
    @metadata_type89 tinyint = NULL,
    @generation89 bigint = NULL,
    @lineage_old89 varbinary(311) = NULL,
    @lineage_new89 varbinary(311) = NULL,
    @rowguid90 uniqueidentifier = NULL,
    @metadata_type90 tinyint = NULL,
    @generation90 bigint = NULL,
    @lineage_old90 varbinary(311) = NULL,
    @lineage_new90 varbinary(311) = NULL ,
    @rowguid91 uniqueidentifier = NULL,
    @metadata_type91 tinyint = NULL,
    @generation91 bigint = NULL,
    @lineage_old91 varbinary(311) = NULL,
    @lineage_new91 varbinary(311) = NULL,
    @rowguid92 uniqueidentifier = NULL,
    @metadata_type92 tinyint = NULL,
    @generation92 bigint = NULL,
    @lineage_old92 varbinary(311) = NULL,
    @lineage_new92 varbinary(311) = NULL,
    @rowguid93 uniqueidentifier = NULL,
    @metadata_type93 tinyint = NULL,
    @generation93 bigint = NULL,
    @lineage_old93 varbinary(311) = NULL,
    @lineage_new93 varbinary(311) = NULL,
    @rowguid94 uniqueidentifier = NULL,
    @metadata_type94 tinyint = NULL,
    @generation94 bigint = NULL,
    @lineage_old94 varbinary(311) = NULL,
    @lineage_new94 varbinary(311) = NULL,
    @rowguid95 uniqueidentifier = NULL,
    @metadata_type95 tinyint = NULL,
    @generation95 bigint = NULL,
    @lineage_old95 varbinary(311) = NULL,
    @lineage_new95 varbinary(311) = NULL,
    @rowguid96 uniqueidentifier = NULL,
    @metadata_type96 tinyint = NULL,
    @generation96 bigint = NULL,
    @lineage_old96 varbinary(311) = NULL,
    @lineage_new96 varbinary(311) = NULL,
    @rowguid97 uniqueidentifier = NULL,
    @metadata_type97 tinyint = NULL,
    @generation97 bigint = NULL,
    @lineage_old97 varbinary(311) = NULL,
    @lineage_new97 varbinary(311) = NULL,
    @rowguid98 uniqueidentifier = NULL,
    @metadata_type98 tinyint = NULL,
    @generation98 bigint = NULL,
    @lineage_old98 varbinary(311) = NULL,
    @lineage_new98 varbinary(311) = NULL,
    @rowguid99 uniqueidentifier = NULL,
    @metadata_type99 tinyint = NULL,
    @generation99 bigint = NULL,
    @lineage_old99 varbinary(311) = NULL,
    @lineage_new99 varbinary(311) = NULL,
    @rowguid100 uniqueidentifier = NULL,
    @metadata_type100 tinyint = NULL,
    @generation100 bigint = NULL,
    @lineage_old100 varbinary(311) = NULL,
    @lineage_new100 varbinary(311) = NULL 
)
as
begin
 
    -- this proc returns 0 to indicate error and 1 to indicate success
    declare @retcode    int
    set nocount on
    declare @rows_deleted int
    declare @rows_remaining int
    declare @error int
    declare @tomb_rows_updated int
    declare @publication_number smallint
    declare @rows_in_syncview int
        
    if ({ fn ISPALUSER('088C2847-4D1D-4D57-8FED-3D0B087A6766') } <> 1)
    begin       
        RAISERROR (14126, 11, -1)
        return 0
    end
    
    select @publication_number = 1

    if @rowstobedeleted is NULL or @rowstobedeleted <= 0
        return 0

    begin tran
    save tran batchdeleteproc
 
    delete [dbo].[ODesign] with (rowlock)
    from 
    ( 
    select @rowguid1 as rowguid, @metadata_type1 as metadata_type, @lineage_old1 as lineage_old, @lineage_new1 as lineage_new, @generation1 as generation  union all 
    select @rowguid2 as rowguid, @metadata_type2 as metadata_type, @lineage_old2 as lineage_old, @lineage_new2 as lineage_new, @generation2 as generation  union all 
    select @rowguid3 as rowguid, @metadata_type3 as metadata_type, @lineage_old3 as lineage_old, @lineage_new3 as lineage_new, @generation3 as generation  union all 
    select @rowguid4 as rowguid, @metadata_type4 as metadata_type, @lineage_old4 as lineage_old, @lineage_new4 as lineage_new, @generation4 as generation  union all 
    select @rowguid5 as rowguid, @metadata_type5 as metadata_type, @lineage_old5 as lineage_old, @lineage_new5 as lineage_new, @generation5 as generation  union all 
    select @rowguid6 as rowguid, @metadata_type6 as metadata_type, @lineage_old6 as lineage_old, @lineage_new6 as lineage_new, @generation6 as generation  union all 
    select @rowguid7 as rowguid, @metadata_type7 as metadata_type, @lineage_old7 as lineage_old, @lineage_new7 as lineage_new, @generation7 as generation  union all 
    select @rowguid8 as rowguid, @metadata_type8 as metadata_type, @lineage_old8 as lineage_old, @lineage_new8 as lineage_new, @generation8 as generation  union all 
    select @rowguid9 as rowguid, @metadata_type9 as metadata_type, @lineage_old9 as lineage_old, @lineage_new9 as lineage_new, @generation9 as generation  union all 
    select @rowguid10 as rowguid, @metadata_type10 as metadata_type, @lineage_old10 as lineage_old, @lineage_new10 as lineage_new, @generation10 as generation   union all 
    select @rowguid11 as rowguid, @metadata_type11 as metadata_type, @lineage_old11 as lineage_old, @lineage_new11 as lineage_new, @generation11 as generation  union all 
    select @rowguid12 as rowguid, @metadata_type12 as metadata_type, @lineage_old12 as lineage_old, @lineage_new12 as lineage_new, @generation12 as generation  union all 
    select @rowguid13 as rowguid, @metadata_type13 as metadata_type, @lineage_old13 as lineage_old, @lineage_new13 as lineage_new, @generation13 as generation  union all 
    select @rowguid14 as rowguid, @metadata_type14 as metadata_type, @lineage_old14 as lineage_old, @lineage_new14 as lineage_new, @generation14 as generation  union all 
    select @rowguid15 as rowguid, @metadata_type15 as metadata_type, @lineage_old15 as lineage_old, @lineage_new15 as lineage_new, @generation15 as generation  union all 
    select @rowguid16 as rowguid, @metadata_type16 as metadata_type, @lineage_old16 as lineage_old, @lineage_new16 as lineage_new, @generation16 as generation  union all 
    select @rowguid17 as rowguid, @metadata_type17 as metadata_type, @lineage_old17 as lineage_old, @lineage_new17 as lineage_new, @generation17 as generation  union all 
    select @rowguid18 as rowguid, @metadata_type18 as metadata_type, @lineage_old18 as lineage_old, @lineage_new18 as lineage_new, @generation18 as generation  union all 
    select @rowguid19 as rowguid, @metadata_type19 as metadata_type, @lineage_old19 as lineage_old, @lineage_new19 as lineage_new, @generation19 as generation  union all 
    select @rowguid20 as rowguid, @metadata_type20 as metadata_type, @lineage_old20 as lineage_old, @lineage_new20 as lineage_new, @generation20 as generation   union all 
    select @rowguid21 as rowguid, @metadata_type21 as metadata_type, @lineage_old21 as lineage_old, @lineage_new21 as lineage_new, @generation21 as generation  union all 
    select @rowguid22 as rowguid, @metadata_type22 as metadata_type, @lineage_old22 as lineage_old, @lineage_new22 as lineage_new, @generation22 as generation  union all 
    select @rowguid23 as rowguid, @metadata_type23 as metadata_type, @lineage_old23 as lineage_old, @lineage_new23 as lineage_new, @generation23 as generation  union all 
    select @rowguid24 as rowguid, @metadata_type24 as metadata_type, @lineage_old24 as lineage_old, @lineage_new24 as lineage_new, @generation24 as generation  union all 
    select @rowguid25 as rowguid, @metadata_type25 as metadata_type, @lineage_old25 as lineage_old, @lineage_new25 as lineage_new, @generation25 as generation  union all 
    select @rowguid26 as rowguid, @metadata_type26 as metadata_type, @lineage_old26 as lineage_old, @lineage_new26 as lineage_new, @generation26 as generation  union all 
    select @rowguid27 as rowguid, @metadata_type27 as metadata_type, @lineage_old27 as lineage_old, @lineage_new27 as lineage_new, @generation27 as generation  union all 
    select @rowguid28 as rowguid, @metadata_type28 as metadata_type, @lineage_old28 as lineage_old, @lineage_new28 as lineage_new, @generation28 as generation  union all 
    select @rowguid29 as rowguid, @metadata_type29 as metadata_type, @lineage_old29 as lineage_old, @lineage_new29 as lineage_new, @generation29 as generation  union all 
    select @rowguid30 as rowguid, @metadata_type30 as metadata_type, @lineage_old30 as lineage_old, @lineage_new30 as lineage_new, @generation30 as generation   union all 
    select @rowguid31 as rowguid, @metadata_type31 as metadata_type, @lineage_old31 as lineage_old, @lineage_new31 as lineage_new, @generation31 as generation  union all 
    select @rowguid32 as rowguid, @metadata_type32 as metadata_type, @lineage_old32 as lineage_old, @lineage_new32 as lineage_new, @generation32 as generation  union all 
    select @rowguid33 as rowguid, @metadata_type33 as metadata_type, @lineage_old33 as lineage_old, @lineage_new33 as lineage_new, @generation33 as generation  union all 
    select @rowguid34 as rowguid, @metadata_type34 as metadata_type, @lineage_old34 as lineage_old, @lineage_new34 as lineage_new, @generation34 as generation  union all 
    select @rowguid35 as rowguid, @metadata_type35 as metadata_type, @lineage_old35 as lineage_old, @lineage_new35 as lineage_new, @generation35 as generation  union all 
    select @rowguid36 as rowguid, @metadata_type36 as metadata_type, @lineage_old36 as lineage_old, @lineage_new36 as lineage_new, @generation36 as generation  union all 
    select @rowguid37 as rowguid, @metadata_type37 as metadata_type, @lineage_old37 as lineage_old, @lineage_new37 as lineage_new, @generation37 as generation  union all 
    select @rowguid38 as rowguid, @metadata_type38 as metadata_type, @lineage_old38 as lineage_old, @lineage_new38 as lineage_new, @generation38 as generation  union all 
    select @rowguid39 as rowguid, @metadata_type39 as metadata_type, @lineage_old39 as lineage_old, @lineage_new39 as lineage_new, @generation39 as generation  union all 
    select @rowguid40 as rowguid, @metadata_type40 as metadata_type, @lineage_old40 as lineage_old, @lineage_new40 as lineage_new, @generation40 as generation   union all 
    select @rowguid41 as rowguid, @metadata_type41 as metadata_type, @lineage_old41 as lineage_old, @lineage_new41 as lineage_new, @generation41 as generation  union all 
    select @rowguid42 as rowguid, @metadata_type42 as metadata_type, @lineage_old42 as lineage_old, @lineage_new42 as lineage_new, @generation42 as generation  union all 
    select @rowguid43 as rowguid, @metadata_type43 as metadata_type, @lineage_old43 as lineage_old, @lineage_new43 as lineage_new, @generation43 as generation  union all 
    select @rowguid44 as rowguid, @metadata_type44 as metadata_type, @lineage_old44 as lineage_old, @lineage_new44 as lineage_new, @generation44 as generation  union all 
    select @rowguid45 as rowguid, @metadata_type45 as metadata_type, @lineage_old45 as lineage_old, @lineage_new45 as lineage_new, @generation45 as generation  union all 
    select @rowguid46 as rowguid, @metadata_type46 as metadata_type, @lineage_old46 as lineage_old, @lineage_new46 as lineage_new, @generation46 as generation  union all 
    select @rowguid47 as rowguid, @metadata_type47 as metadata_type, @lineage_old47 as lineage_old, @lineage_new47 as lineage_new, @generation47 as generation  union all 
    select @rowguid48 as rowguid, @metadata_type48 as metadata_type, @lineage_old48 as lineage_old, @lineage_new48 as lineage_new, @generation48 as generation  union all 
    select @rowguid49 as rowguid, @metadata_type49 as metadata_type, @lineage_old49 as lineage_old, @lineage_new49 as lineage_new, @generation49 as generation  union all 
    select @rowguid50 as rowguid, @metadata_type50 as metadata_type, @lineage_old50 as lineage_old, @lineage_new50 as lineage_new, @generation50 as generation   union all 
    select @rowguid51 as rowguid, @metadata_type51 as metadata_type, @lineage_old51 as lineage_old, @lineage_new51 as lineage_new, @generation51 as generation  union all 
    select @rowguid52 as rowguid, @metadata_type52 as metadata_type, @lineage_old52 as lineage_old, @lineage_new52 as lineage_new, @generation52 as generation  union all 
    select @rowguid53 as rowguid, @metadata_type53 as metadata_type, @lineage_old53 as lineage_old, @lineage_new53 as lineage_new, @generation53 as generation  union all 
    select @rowguid54 as rowguid, @metadata_type54 as metadata_type, @lineage_old54 as lineage_old, @lineage_new54 as lineage_new, @generation54 as generation  union all 
    select @rowguid55 as rowguid, @metadata_type55 as metadata_type, @lineage_old55 as lineage_old, @lineage_new55 as lineage_new, @generation55 as generation  union all 
    select @rowguid56 as rowguid, @metadata_type56 as metadata_type, @lineage_old56 as lineage_old, @lineage_new56 as lineage_new, @generation56 as generation  union all 
    select @rowguid57 as rowguid, @metadata_type57 as metadata_type, @lineage_old57 as lineage_old, @lineage_new57 as lineage_new, @generation57 as generation  union all 
    select @rowguid58 as rowguid, @metadata_type58 as metadata_type, @lineage_old58 as lineage_old, @lineage_new58 as lineage_new, @generation58 as generation  union all 
    select @rowguid59 as rowguid, @metadata_type59 as metadata_type, @lineage_old59 as lineage_old, @lineage_new59 as lineage_new, @generation59 as generation  union all 
    select @rowguid60 as rowguid, @metadata_type60 as metadata_type, @lineage_old60 as lineage_old, @lineage_new60 as lineage_new, @generation60 as generation   union all 
    select @rowguid61 as rowguid, @metadata_type61 as metadata_type, @lineage_old61 as lineage_old, @lineage_new61 as lineage_new, @generation61 as generation  union all 
    select @rowguid62 as rowguid, @metadata_type62 as metadata_type, @lineage_old62 as lineage_old, @lineage_new62 as lineage_new, @generation62 as generation  union all 
    select @rowguid63 as rowguid, @metadata_type63 as metadata_type, @lineage_old63 as lineage_old, @lineage_new63 as lineage_new, @generation63 as generation  union all 
    select @rowguid64 as rowguid, @metadata_type64 as metadata_type, @lineage_old64 as lineage_old, @lineage_new64 as lineage_new, @generation64 as generation  union all 
    select @rowguid65 as rowguid, @metadata_type65 as metadata_type, @lineage_old65 as lineage_old, @lineage_new65 as lineage_new, @generation65 as generation  union all 
    select @rowguid66 as rowguid, @metadata_type66 as metadata_type, @lineage_old66 as lineage_old, @lineage_new66 as lineage_new, @generation66 as generation  union all 
    select @rowguid67 as rowguid, @metadata_type67 as metadata_type, @lineage_old67 as lineage_old, @lineage_new67 as lineage_new, @generation67 as generation  union all 
    select @rowguid68 as rowguid, @metadata_type68 as metadata_type, @lineage_old68 as lineage_old, @lineage_new68 as lineage_new, @generation68 as generation  union all 
    select @rowguid69 as rowguid, @metadata_type69 as metadata_type, @lineage_old69 as lineage_old, @lineage_new69 as lineage_new, @generation69 as generation  union all 
    select @rowguid70 as rowguid, @metadata_type70 as metadata_type, @lineage_old70 as lineage_old, @lineage_new70 as lineage_new, @generation70 as generation   union all 
    select @rowguid71 as rowguid, @metadata_type71 as metadata_type, @lineage_old71 as lineage_old, @lineage_new71 as lineage_new, @generation71 as generation  union all 
    select @rowguid72 as rowguid, @metadata_type72 as metadata_type, @lineage_old72 as lineage_old, @lineage_new72 as lineage_new, @generation72 as generation  union all 
    select @rowguid73 as rowguid, @metadata_type73 as metadata_type, @lineage_old73 as lineage_old, @lineage_new73 as lineage_new, @generation73 as generation  union all 
    select @rowguid74 as rowguid, @metadata_type74 as metadata_type, @lineage_old74 as lineage_old, @lineage_new74 as lineage_new, @generation74 as generation  union all 
    select @rowguid75 as rowguid, @metadata_type75 as metadata_type, @lineage_old75 as lineage_old, @lineage_new75 as lineage_new, @generation75 as generation  union all 
    select @rowguid76 as rowguid, @metadata_type76 as metadata_type, @lineage_old76 as lineage_old, @lineage_new76 as lineage_new, @generation76 as generation  union all 
    select @rowguid77 as rowguid, @metadata_type77 as metadata_type, @lineage_old77 as lineage_old, @lineage_new77 as lineage_new, @generation77 as generation  union all 
    select @rowguid78 as rowguid, @metadata_type78 as metadata_type, @lineage_old78 as lineage_old, @lineage_new78 as lineage_new, @generation78 as generation  union all 
    select @rowguid79 as rowguid, @metadata_type79 as metadata_type, @lineage_old79 as lineage_old, @lineage_new79 as lineage_new, @generation79 as generation  union all 
    select @rowguid80 as rowguid, @metadata_type80 as metadata_type, @lineage_old80 as lineage_old, @lineage_new80 as lineage_new, @generation80 as generation   union all 
    select @rowguid81 as rowguid, @metadata_type81 as metadata_type, @lineage_old81 as lineage_old, @lineage_new81 as lineage_new, @generation81 as generation  union all 
    select @rowguid82 as rowguid, @metadata_type82 as metadata_type, @lineage_old82 as lineage_old, @lineage_new82 as lineage_new, @generation82 as generation  union all 
    select @rowguid83 as rowguid, @metadata_type83 as metadata_type, @lineage_old83 as lineage_old, @lineage_new83 as lineage_new, @generation83 as generation  union all 
    select @rowguid84 as rowguid, @metadata_type84 as metadata_type, @lineage_old84 as lineage_old, @lineage_new84 as lineage_new, @generation84 as generation  union all 
    select @rowguid85 as rowguid, @metadata_type85 as metadata_type, @lineage_old85 as lineage_old, @lineage_new85 as lineage_new, @generation85 as generation  union all 
    select @rowguid86 as rowguid, @metadata_type86 as metadata_type, @lineage_old86 as lineage_old, @lineage_new86 as lineage_new, @generation86 as generation  union all 
    select @rowguid87 as rowguid, @metadata_type87 as metadata_type, @lineage_old87 as lineage_old, @lineage_new87 as lineage_new, @generation87 as generation  union all 
    select @rowguid88 as rowguid, @metadata_type88 as metadata_type, @lineage_old88 as lineage_old, @lineage_new88 as lineage_new, @generation88 as generation  union all 
    select @rowguid89 as rowguid, @metadata_type89 as metadata_type, @lineage_old89 as lineage_old, @lineage_new89 as lineage_new, @generation89 as generation  union all 
    select @rowguid90 as rowguid, @metadata_type90 as metadata_type, @lineage_old90 as lineage_old, @lineage_new90 as lineage_new, @generation90 as generation   union all 
    select @rowguid91 as rowguid, @metadata_type91 as metadata_type, @lineage_old91 as lineage_old, @lineage_new91 as lineage_new, @generation91 as generation  union all 
    select @rowguid92 as rowguid, @metadata_type92 as metadata_type, @lineage_old92 as lineage_old, @lineage_new92 as lineage_new, @generation92 as generation  union all 
    select @rowguid93 as rowguid, @metadata_type93 as metadata_type, @lineage_old93 as lineage_old, @lineage_new93 as lineage_new, @generation93 as generation  union all 
    select @rowguid94 as rowguid, @metadata_type94 as metadata_type, @lineage_old94 as lineage_old, @lineage_new94 as lineage_new, @generation94 as generation  union all 
    select @rowguid95 as rowguid, @metadata_type95 as metadata_type, @lineage_old95 as lineage_old, @lineage_new95 as lineage_new, @generation95 as generation  union all 
    select @rowguid96 as rowguid, @metadata_type96 as metadata_type, @lineage_old96 as lineage_old, @lineage_new96 as lineage_new, @generation96 as generation  union all 
    select @rowguid97 as rowguid, @metadata_type97 as metadata_type, @lineage_old97 as lineage_old, @lineage_new97 as lineage_new, @generation97 as generation  union all 
    select @rowguid98 as rowguid, @metadata_type98 as metadata_type, @lineage_old98 as lineage_old, @lineage_new98 as lineage_new, @generation98 as generation  union all 
    select @rowguid99 as rowguid, @metadata_type99 as metadata_type, @lineage_old99 as lineage_old, @lineage_new99 as lineage_new, @generation99 as generation  union all 
    select @rowguid100 as rowguid, @metadata_type100 as metadata_type, @lineage_old100 as lineage_old, @lineage_new100 as lineage_new, @generation100 as generation  ) as rows
    inner join [dbo].[ODesign] t with (rowlock) on rows.rowguid = t.[REPLID] and rows.rowguid is not NULL 
    left outer join dbo.MSmerge_contents cont with (rowlock) 
    on rows.rowguid = cont.rowguid and cont.tablenick = 11696062 
    and rows.rowguid is not NULL
    where ((rows.metadata_type = 3 and cont.rowguid is NULL) or
           ((rows.metadata_type = 5 or  rows.metadata_type = 6) and (cont.rowguid is NULL or cont.lineage = rows.lineage_old)) or
           (cont.rowguid is not NULL and cont.lineage = rows.lineage_old))
           and rows.rowguid is not NULL  
    select @rows_deleted = @@rowcount, @error = @@error
    if @error<>0
        goto Failure
    if @rows_deleted > @rowstobedeleted
    begin
        -- this is just not possible
        raiserror(20684, 16, -1, '[dbo].[ODesign]')
        goto Failure
    end
    if @rows_deleted <> @rowstobedeleted
    begin 
        -- we will now check if any of the rows we wanted to delete were not deleted. If the rows were not deleted
        -- by the previous delete because it was already deleted, we will still assume that this is a success
        select @rows_remaining = count(*) from 
        (  
         select @rowguid1 as rowguid union all 
         select @rowguid2 as rowguid union all 
         select @rowguid3 as rowguid union all 
         select @rowguid4 as rowguid union all 
         select @rowguid5 as rowguid union all 
         select @rowguid6 as rowguid union all 
         select @rowguid7 as rowguid union all 
         select @rowguid8 as rowguid union all 
         select @rowguid9 as rowguid union all 
         select @rowguid10 as rowguid union all 
         select @rowguid11 as rowguid union all 
         select @rowguid12 as rowguid union all 
         select @rowguid13 as rowguid union all 
         select @rowguid14 as rowguid union all 
         select @rowguid15 as rowguid union all 
         select @rowguid16 as rowguid union all 
         select @rowguid17 as rowguid union all 
         select @rowguid18 as rowguid union all 
         select @rowguid19 as rowguid union all 
         select @rowguid20 as rowguid union all 
         select @rowguid21 as rowguid union all 
         select @rowguid22 as rowguid union all 
         select @rowguid23 as rowguid union all 
         select @rowguid24 as rowguid union all 
         select @rowguid25 as rowguid union all 
         select @rowguid26 as rowguid union all 
         select @rowguid27 as rowguid union all 
         select @rowguid28 as rowguid union all 
         select @rowguid29 as rowguid union all 
         select @rowguid30 as rowguid union all 
         select @rowguid31 as rowguid union all 
         select @rowguid32 as rowguid union all 
         select @rowguid33 as rowguid union all 
         select @rowguid34 as rowguid union all 
         select @rowguid35 as rowguid union all 
         select @rowguid36 as rowguid union all 
         select @rowguid37 as rowguid union all 
         select @rowguid38 as rowguid union all 
         select @rowguid39 as rowguid union all 
         select @rowguid40 as rowguid union all 
         select @rowguid41 as rowguid union all 
         select @rowguid42 as rowguid union all 
         select @rowguid43 as rowguid union all 
         select @rowguid44 as rowguid union all 
         select @rowguid45 as rowguid union all 
         select @rowguid46 as rowguid union all 
         select @rowguid47 as rowguid union all 
         select @rowguid48 as rowguid union all 
         select @rowguid49 as rowguid union all 
         select @rowguid50 as rowguid union all 
         select @rowguid51 as rowguid union all 
         select @rowguid52 as rowguid union all 
         select @rowguid53 as rowguid union all 
         select @rowguid54 as rowguid union all 
         select @rowguid55 as rowguid union all 
         select @rowguid56 as rowguid union all 
         select @rowguid57 as rowguid union all 
         select @rowguid58 as rowguid union all 
         select @rowguid59 as rowguid union all 
         select @rowguid60 as rowguid union all 
         select @rowguid61 as rowguid union all 
         select @rowguid62 as rowguid union all 
         select @rowguid63 as rowguid union all 
         select @rowguid64 as rowguid union all 
         select @rowguid65 as rowguid union all 
         select @rowguid66 as rowguid union all 
         select @rowguid67 as rowguid union all 
         select @rowguid68 as rowguid union all 
         select @rowguid69 as rowguid union all 
         select @rowguid70 as rowguid union all 
         select @rowguid71 as rowguid union all 
         select @rowguid72 as rowguid union all 
         select @rowguid73 as rowguid union all 
         select @rowguid74 as rowguid union all 
         select @rowguid75 as rowguid union all 
         select @rowguid76 as rowguid union all 
         select @rowguid77 as rowguid union all 
         select @rowguid78 as rowguid union all 
         select @rowguid79 as rowguid union all 
         select @rowguid80 as rowguid union all 
         select @rowguid81 as rowguid union all 
         select @rowguid82 as rowguid union all 
         select @rowguid83 as rowguid union all 
         select @rowguid84 as rowguid union all 
         select @rowguid85 as rowguid union all 
         select @rowguid86 as rowguid union all 
         select @rowguid87 as rowguid union all 
         select @rowguid88 as rowguid union all 
         select @rowguid89 as rowguid union all 
         select @rowguid90 as rowguid union all 
         select @rowguid91 as rowguid union all 
         select @rowguid92 as rowguid union all 
         select @rowguid93 as rowguid union all 
         select @rowguid94 as rowguid union all 
         select @rowguid95 as rowguid union all 
         select @rowguid96 as rowguid union all 
         select @rowguid97 as rowguid union all 
         select @rowguid98 as rowguid union all 
         select @rowguid99 as rowguid union all 
         select @rowguid100 as rowguid 
        ) as rows
        inner join [dbo].[ODesign] t with (rowlock) 
        on t.[REPLID] = rows.rowguid
        and rows.rowguid is not NULL
        
        if @@error <> 0
            goto Failure
        
        if @rows_remaining <> 0
        begin
            -- failed deleting one or more rows. Could be because of metadata mismatch
            --raiserror(20682, 10, -1, @rows_remaining, '[dbo].[ODesign]')
            goto Failure
        end        
    end 
    -- if we get here it means that all the rows that we intend to delete were either deleted by us
    -- or they were already deleted by someone else and do not exist in the user table
    -- we insert a tombstone entry for the rows we have deleted and delete the contents rows if exists

    -- if the rows were previously deleted we still want to update the metadatatype, generation and lineage
    -- in MSmerge_tombstone. We could find rows in the following update also if the trigger got called by
    -- the user table delete and it inserted the rows into tombstone (it would have inserted with type 1)
    update dbo.MSmerge_tombstone with (rowlock)
        set type = case when (rows.metadata_type=5 or rows.metadata_type=6) then rows.metadata_type else 1 end,
            generation = rows.generation,
            lineage = rows.lineage_new
    from 
    ( 
    select @rowguid1 as rowguid, @metadata_type1 as metadata_type, @lineage_old1 as lineage_old, @lineage_new1 as lineage_new, @generation1 as generation  union all 
    select @rowguid2 as rowguid, @metadata_type2 as metadata_type, @lineage_old2 as lineage_old, @lineage_new2 as lineage_new, @generation2 as generation  union all 
    select @rowguid3 as rowguid, @metadata_type3 as metadata_type, @lineage_old3 as lineage_old, @lineage_new3 as lineage_new, @generation3 as generation  union all 
    select @rowguid4 as rowguid, @metadata_type4 as metadata_type, @lineage_old4 as lineage_old, @lineage_new4 as lineage_new, @generation4 as generation  union all 
    select @rowguid5 as rowguid, @metadata_type5 as metadata_type, @lineage_old5 as lineage_old, @lineage_new5 as lineage_new, @generation5 as generation  union all 
    select @rowguid6 as rowguid, @metadata_type6 as metadata_type, @lineage_old6 as lineage_old, @lineage_new6 as lineage_new, @generation6 as generation  union all 
    select @rowguid7 as rowguid, @metadata_type7 as metadata_type, @lineage_old7 as lineage_old, @lineage_new7 as lineage_new, @generation7 as generation  union all 
    select @rowguid8 as rowguid, @metadata_type8 as metadata_type, @lineage_old8 as lineage_old, @lineage_new8 as lineage_new, @generation8 as generation  union all 
    select @rowguid9 as rowguid, @metadata_type9 as metadata_type, @lineage_old9 as lineage_old, @lineage_new9 as lineage_new, @generation9 as generation  union all 
    select @rowguid10 as rowguid, @metadata_type10 as metadata_type, @lineage_old10 as lineage_old, @lineage_new10 as lineage_new, @generation10 as generation   union all 
    select @rowguid11 as rowguid, @metadata_type11 as metadata_type, @lineage_old11 as lineage_old, @lineage_new11 as lineage_new, @generation11 as generation  union all 
    select @rowguid12 as rowguid, @metadata_type12 as metadata_type, @lineage_old12 as lineage_old, @lineage_new12 as lineage_new, @generation12 as generation  union all 
    select @rowguid13 as rowguid, @metadata_type13 as metadata_type, @lineage_old13 as lineage_old, @lineage_new13 as lineage_new, @generation13 as generation  union all 
    select @rowguid14 as rowguid, @metadata_type14 as metadata_type, @lineage_old14 as lineage_old, @lineage_new14 as lineage_new, @generation14 as generation  union all 
    select @rowguid15 as rowguid, @metadata_type15 as metadata_type, @lineage_old15 as lineage_old, @lineage_new15 as lineage_new, @generation15 as generation  union all 
    select @rowguid16 as rowguid, @metadata_type16 as metadata_type, @lineage_old16 as lineage_old, @lineage_new16 as lineage_new, @generation16 as generation  union all 
    select @rowguid17 as rowguid, @metadata_type17 as metadata_type, @lineage_old17 as lineage_old, @lineage_new17 as lineage_new, @generation17 as generation  union all 
    select @rowguid18 as rowguid, @metadata_type18 as metadata_type, @lineage_old18 as lineage_old, @lineage_new18 as lineage_new, @generation18 as generation  union all 
    select @rowguid19 as rowguid, @metadata_type19 as metadata_type, @lineage_old19 as lineage_old, @lineage_new19 as lineage_new, @generation19 as generation  union all 
    select @rowguid20 as rowguid, @metadata_type20 as metadata_type, @lineage_old20 as lineage_old, @lineage_new20 as lineage_new, @generation20 as generation   union all 
    select @rowguid21 as rowguid, @metadata_type21 as metadata_type, @lineage_old21 as lineage_old, @lineage_new21 as lineage_new, @generation21 as generation  union all 
    select @rowguid22 as rowguid, @metadata_type22 as metadata_type, @lineage_old22 as lineage_old, @lineage_new22 as lineage_new, @generation22 as generation  union all 
    select @rowguid23 as rowguid, @metadata_type23 as metadata_type, @lineage_old23 as lineage_old, @lineage_new23 as lineage_new, @generation23 as generation  union all 
    select @rowguid24 as rowguid, @metadata_type24 as metadata_type, @lineage_old24 as lineage_old, @lineage_new24 as lineage_new, @generation24 as generation  union all 
    select @rowguid25 as rowguid, @metadata_type25 as metadata_type, @lineage_old25 as lineage_old, @lineage_new25 as lineage_new, @generation25 as generation  union all 
    select @rowguid26 as rowguid, @metadata_type26 as metadata_type, @lineage_old26 as lineage_old, @lineage_new26 as lineage_new, @generation26 as generation  union all 
    select @rowguid27 as rowguid, @metadata_type27 as metadata_type, @lineage_old27 as lineage_old, @lineage_new27 as lineage_new, @generation27 as generation  union all 
    select @rowguid28 as rowguid, @metadata_type28 as metadata_type, @lineage_old28 as lineage_old, @lineage_new28 as lineage_new, @generation28 as generation  union all 
    select @rowguid29 as rowguid, @metadata_type29 as metadata_type, @lineage_old29 as lineage_old, @lineage_new29 as lineage_new, @generation29 as generation  union all 
    select @rowguid30 as rowguid, @metadata_type30 as metadata_type, @lineage_old30 as lineage_old, @lineage_new30 as lineage_new, @generation30 as generation   union all 
    select @rowguid31 as rowguid, @metadata_type31 as metadata_type, @lineage_old31 as lineage_old, @lineage_new31 as lineage_new, @generation31 as generation  union all 
    select @rowguid32 as rowguid, @metadata_type32 as metadata_type, @lineage_old32 as lineage_old, @lineage_new32 as lineage_new, @generation32 as generation  union all 
    select @rowguid33 as rowguid, @metadata_type33 as metadata_type, @lineage_old33 as lineage_old, @lineage_new33 as lineage_new, @generation33 as generation  union all 
    select @rowguid34 as rowguid, @metadata_type34 as metadata_type, @lineage_old34 as lineage_old, @lineage_new34 as lineage_new, @generation34 as generation  union all 
    select @rowguid35 as rowguid, @metadata_type35 as metadata_type, @lineage_old35 as lineage_old, @lineage_new35 as lineage_new, @generation35 as generation  union all 
    select @rowguid36 as rowguid, @metadata_type36 as metadata_type, @lineage_old36 as lineage_old, @lineage_new36 as lineage_new, @generation36 as generation  union all 
    select @rowguid37 as rowguid, @metadata_type37 as metadata_type, @lineage_old37 as lineage_old, @lineage_new37 as lineage_new, @generation37 as generation  union all 
    select @rowguid38 as rowguid, @metadata_type38 as metadata_type, @lineage_old38 as lineage_old, @lineage_new38 as lineage_new, @generation38 as generation  union all 
    select @rowguid39 as rowguid, @metadata_type39 as metadata_type, @lineage_old39 as lineage_old, @lineage_new39 as lineage_new, @generation39 as generation  union all 
    select @rowguid40 as rowguid, @metadata_type40 as metadata_type, @lineage_old40 as lineage_old, @lineage_new40 as lineage_new, @generation40 as generation   union all 
    select @rowguid41 as rowguid, @metadata_type41 as metadata_type, @lineage_old41 as lineage_old, @lineage_new41 as lineage_new, @generation41 as generation  union all 
    select @rowguid42 as rowguid, @metadata_type42 as metadata_type, @lineage_old42 as lineage_old, @lineage_new42 as lineage_new, @generation42 as generation  union all 
    select @rowguid43 as rowguid, @metadata_type43 as metadata_type, @lineage_old43 as lineage_old, @lineage_new43 as lineage_new, @generation43 as generation  union all 
    select @rowguid44 as rowguid, @metadata_type44 as metadata_type, @lineage_old44 as lineage_old, @lineage_new44 as lineage_new, @generation44 as generation  union all 
    select @rowguid45 as rowguid, @metadata_type45 as metadata_type, @lineage_old45 as lineage_old, @lineage_new45 as lineage_new, @generation45 as generation  union all 
    select @rowguid46 as rowguid, @metadata_type46 as metadata_type, @lineage_old46 as lineage_old, @lineage_new46 as lineage_new, @generation46 as generation  union all 
    select @rowguid47 as rowguid, @metadata_type47 as metadata_type, @lineage_old47 as lineage_old, @lineage_new47 as lineage_new, @generation47 as generation  union all 
    select @rowguid48 as rowguid, @metadata_type48 as metadata_type, @lineage_old48 as lineage_old, @lineage_new48 as lineage_new, @generation48 as generation  union all 
    select @rowguid49 as rowguid, @metadata_type49 as metadata_type, @lineage_old49 as lineage_old, @lineage_new49 as lineage_new, @generation49 as generation  union all 
    select @rowguid50 as rowguid, @metadata_type50 as metadata_type, @lineage_old50 as lineage_old, @lineage_new50 as lineage_new, @generation50 as generation   union all 
    select @rowguid51 as rowguid, @metadata_type51 as metadata_type, @lineage_old51 as lineage_old, @lineage_new51 as lineage_new, @generation51 as generation  union all 
    select @rowguid52 as rowguid, @metadata_type52 as metadata_type, @lineage_old52 as lineage_old, @lineage_new52 as lineage_new, @generation52 as generation  union all 
    select @rowguid53 as rowguid, @metadata_type53 as metadata_type, @lineage_old53 as lineage_old, @lineage_new53 as lineage_new, @generation53 as generation  union all 
    select @rowguid54 as rowguid, @metadata_type54 as metadata_type, @lineage_old54 as lineage_old, @lineage_new54 as lineage_new, @generation54 as generation  union all 
    select @rowguid55 as rowguid, @metadata_type55 as metadata_type, @lineage_old55 as lineage_old, @lineage_new55 as lineage_new, @generation55 as generation  union all 
    select @rowguid56 as rowguid, @metadata_type56 as metadata_type, @lineage_old56 as lineage_old, @lineage_new56 as lineage_new, @generation56 as generation  union all 
    select @rowguid57 as rowguid, @metadata_type57 as metadata_type, @lineage_old57 as lineage_old, @lineage_new57 as lineage_new, @generation57 as generation  union all 
    select @rowguid58 as rowguid, @metadata_type58 as metadata_type, @lineage_old58 as lineage_old, @lineage_new58 as lineage_new, @generation58 as generation  union all 
    select @rowguid59 as rowguid, @metadata_type59 as metadata_type, @lineage_old59 as lineage_old, @lineage_new59 as lineage_new, @generation59 as generation  union all 
    select @rowguid60 as rowguid, @metadata_type60 as metadata_type, @lineage_old60 as lineage_old, @lineage_new60 as lineage_new, @generation60 as generation   union all 
    select @rowguid61 as rowguid, @metadata_type61 as metadata_type, @lineage_old61 as lineage_old, @lineage_new61 as lineage_new, @generation61 as generation  union all 
    select @rowguid62 as rowguid, @metadata_type62 as metadata_type, @lineage_old62 as lineage_old, @lineage_new62 as lineage_new, @generation62 as generation  union all 
    select @rowguid63 as rowguid, @metadata_type63 as metadata_type, @lineage_old63 as lineage_old, @lineage_new63 as lineage_new, @generation63 as generation  union all 
    select @rowguid64 as rowguid, @metadata_type64 as metadata_type, @lineage_old64 as lineage_old, @lineage_new64 as lineage_new, @generation64 as generation  union all 
    select @rowguid65 as rowguid, @metadata_type65 as metadata_type, @lineage_old65 as lineage_old, @lineage_new65 as lineage_new, @generation65 as generation  union all 
    select @rowguid66 as rowguid, @metadata_type66 as metadata_type, @lineage_old66 as lineage_old, @lineage_new66 as lineage_new, @generation66 as generation  union all 
    select @rowguid67 as rowguid, @metadata_type67 as metadata_type, @lineage_old67 as lineage_old, @lineage_new67 as lineage_new, @generation67 as generation  union all 
    select @rowguid68 as rowguid, @metadata_type68 as metadata_type, @lineage_old68 as lineage_old, @lineage_new68 as lineage_new, @generation68 as generation  union all 
    select @rowguid69 as rowguid, @metadata_type69 as metadata_type, @lineage_old69 as lineage_old, @lineage_new69 as lineage_new, @generation69 as generation  union all 
    select @rowguid70 as rowguid, @metadata_type70 as metadata_type, @lineage_old70 as lineage_old, @lineage_new70 as lineage_new, @generation70 as generation   union all 
    select @rowguid71 as rowguid, @metadata_type71 as metadata_type, @lineage_old71 as lineage_old, @lineage_new71 as lineage_new, @generation71 as generation  union all 
    select @rowguid72 as rowguid, @metadata_type72 as metadata_type, @lineage_old72 as lineage_old, @lineage_new72 as lineage_new, @generation72 as generation  union all 
    select @rowguid73 as rowguid, @metadata_type73 as metadata_type, @lineage_old73 as lineage_old, @lineage_new73 as lineage_new, @generation73 as generation  union all 
    select @rowguid74 as rowguid, @metadata_type74 as metadata_type, @lineage_old74 as lineage_old, @lineage_new74 as lineage_new, @generation74 as generation  union all 
    select @rowguid75 as rowguid, @metadata_type75 as metadata_type, @lineage_old75 as lineage_old, @lineage_new75 as lineage_new, @generation75 as generation  union all 
    select @rowguid76 as rowguid, @metadata_type76 as metadata_type, @lineage_old76 as lineage_old, @lineage_new76 as lineage_new, @generation76 as generation  union all 
    select @rowguid77 as rowguid, @metadata_type77 as metadata_type, @lineage_old77 as lineage_old, @lineage_new77 as lineage_new, @generation77 as generation  union all 
    select @rowguid78 as rowguid, @metadata_type78 as metadata_type, @lineage_old78 as lineage_old, @lineage_new78 as lineage_new, @generation78 as generation  union all 
    select @rowguid79 as rowguid, @metadata_type79 as metadata_type, @lineage_old79 as lineage_old, @lineage_new79 as lineage_new, @generation79 as generation  union all 
    select @rowguid80 as rowguid, @metadata_type80 as metadata_type, @lineage_old80 as lineage_old, @lineage_new80 as lineage_new, @generation80 as generation   union all 
    select @rowguid81 as rowguid, @metadata_type81 as metadata_type, @lineage_old81 as lineage_old, @lineage_new81 as lineage_new, @generation81 as generation  union all 
    select @rowguid82 as rowguid, @metadata_type82 as metadata_type, @lineage_old82 as lineage_old, @lineage_new82 as lineage_new, @generation82 as generation  union all 
    select @rowguid83 as rowguid, @metadata_type83 as metadata_type, @lineage_old83 as lineage_old, @lineage_new83 as lineage_new, @generation83 as generation  union all 
    select @rowguid84 as rowguid, @metadata_type84 as metadata_type, @lineage_old84 as lineage_old, @lineage_new84 as lineage_new, @generation84 as generation  union all 
    select @rowguid85 as rowguid, @metadata_type85 as metadata_type, @lineage_old85 as lineage_old, @lineage_new85 as lineage_new, @generation85 as generation  union all 
    select @rowguid86 as rowguid, @metadata_type86 as metadata_type, @lineage_old86 as lineage_old, @lineage_new86 as lineage_new, @generation86 as generation  union all 
    select @rowguid87 as rowguid, @metadata_type87 as metadata_type, @lineage_old87 as lineage_old, @lineage_new87 as lineage_new, @generation87 as generation  union all 
    select @rowguid88 as rowguid, @metadata_type88 as metadata_type, @lineage_old88 as lineage_old, @lineage_new88 as lineage_new, @generation88 as generation  union all 
    select @rowguid89 as rowguid, @metadata_type89 as metadata_type, @lineage_old89 as lineage_old, @lineage_new89 as lineage_new, @generation89 as generation  union all 
    select @rowguid90 as rowguid, @metadata_type90 as metadata_type, @lineage_old90 as lineage_old, @lineage_new90 as lineage_new, @generation90 as generation   union all 
    select @rowguid91 as rowguid, @metadata_type91 as metadata_type, @lineage_old91 as lineage_old, @lineage_new91 as lineage_new, @generation91 as generation  union all 
    select @rowguid92 as rowguid, @metadata_type92 as metadata_type, @lineage_old92 as lineage_old, @lineage_new92 as lineage_new, @generation92 as generation  union all 
    select @rowguid93 as rowguid, @metadata_type93 as metadata_type, @lineage_old93 as lineage_old, @lineage_new93 as lineage_new, @generation93 as generation  union all 
    select @rowguid94 as rowguid, @metadata_type94 as metadata_type, @lineage_old94 as lineage_old, @lineage_new94 as lineage_new, @generation94 as generation  union all 
    select @rowguid95 as rowguid, @metadata_type95 as metadata_type, @lineage_old95 as lineage_old, @lineage_new95 as lineage_new, @generation95 as generation  union all 
    select @rowguid96 as rowguid, @metadata_type96 as metadata_type, @lineage_old96 as lineage_old, @lineage_new96 as lineage_new, @generation96 as generation  union all 
    select @rowguid97 as rowguid, @metadata_type97 as metadata_type, @lineage_old97 as lineage_old, @lineage_new97 as lineage_new, @generation97 as generation  union all 
    select @rowguid98 as rowguid, @metadata_type98 as metadata_type, @lineage_old98 as lineage_old, @lineage_new98 as lineage_new, @generation98 as generation  union all 
    select @rowguid99 as rowguid, @metadata_type99 as metadata_type, @lineage_old99 as lineage_old, @lineage_new99 as lineage_new, @generation99 as generation  union all 
    select @rowguid100 as rowguid, @metadata_type100 as metadata_type, @lineage_old100 as lineage_old, @lineage_new100 as lineage_new, @generation100 as generation  
    ) as rows
    inner join dbo.MSmerge_tombstone tomb with (rowlock) 
    on tomb.rowguid = rows.rowguid and tomb.tablenick = 11696062
    and rows.rowguid is not null
    and rows.lineage_new is not NULL
    option (force order, loop join)
    select @tomb_rows_updated = @@rowcount, @error = @@error
    if @error<>0
        goto Failure 
        -- the trigger would have inserted a row in past partition mapping for the currently deleted
        -- row. We need to update that row with the current generation if it exists
        update dbo.MSmerge_past_partition_mappings with (rowlock)
        set generation = rows.generation
    from
    ( 
    select @rowguid1 as rowguid, @metadata_type1 as metadata_type, @lineage_old1 as lineage_old, @lineage_new1 as lineage_new, @generation1 as generation  union all 
    select @rowguid2 as rowguid, @metadata_type2 as metadata_type, @lineage_old2 as lineage_old, @lineage_new2 as lineage_new, @generation2 as generation  union all 
    select @rowguid3 as rowguid, @metadata_type3 as metadata_type, @lineage_old3 as lineage_old, @lineage_new3 as lineage_new, @generation3 as generation  union all 
    select @rowguid4 as rowguid, @metadata_type4 as metadata_type, @lineage_old4 as lineage_old, @lineage_new4 as lineage_new, @generation4 as generation  union all 
    select @rowguid5 as rowguid, @metadata_type5 as metadata_type, @lineage_old5 as lineage_old, @lineage_new5 as lineage_new, @generation5 as generation  union all 
    select @rowguid6 as rowguid, @metadata_type6 as metadata_type, @lineage_old6 as lineage_old, @lineage_new6 as lineage_new, @generation6 as generation  union all 
    select @rowguid7 as rowguid, @metadata_type7 as metadata_type, @lineage_old7 as lineage_old, @lineage_new7 as lineage_new, @generation7 as generation  union all 
    select @rowguid8 as rowguid, @metadata_type8 as metadata_type, @lineage_old8 as lineage_old, @lineage_new8 as lineage_new, @generation8 as generation  union all 
    select @rowguid9 as rowguid, @metadata_type9 as metadata_type, @lineage_old9 as lineage_old, @lineage_new9 as lineage_new, @generation9 as generation  union all 
    select @rowguid10 as rowguid, @metadata_type10 as metadata_type, @lineage_old10 as lineage_old, @lineage_new10 as lineage_new, @generation10 as generation   union all 
    select @rowguid11 as rowguid, @metadata_type11 as metadata_type, @lineage_old11 as lineage_old, @lineage_new11 as lineage_new, @generation11 as generation  union all 
    select @rowguid12 as rowguid, @metadata_type12 as metadata_type, @lineage_old12 as lineage_old, @lineage_new12 as lineage_new, @generation12 as generation  union all 
    select @rowguid13 as rowguid, @metadata_type13 as metadata_type, @lineage_old13 as lineage_old, @lineage_new13 as lineage_new, @generation13 as generation  union all 
    select @rowguid14 as rowguid, @metadata_type14 as metadata_type, @lineage_old14 as lineage_old, @lineage_new14 as lineage_new, @generation14 as generation  union all 
    select @rowguid15 as rowguid, @metadata_type15 as metadata_type, @lineage_old15 as lineage_old, @lineage_new15 as lineage_new, @generation15 as generation  union all 
    select @rowguid16 as rowguid, @metadata_type16 as metadata_type, @lineage_old16 as lineage_old, @lineage_new16 as lineage_new, @generation16 as generation  union all 
    select @rowguid17 as rowguid, @metadata_type17 as metadata_type, @lineage_old17 as lineage_old, @lineage_new17 as lineage_new, @generation17 as generation  union all 
    select @rowguid18 as rowguid, @metadata_type18 as metadata_type, @lineage_old18 as lineage_old, @lineage_new18 as lineage_new, @generation18 as generation  union all 
    select @rowguid19 as rowguid, @metadata_type19 as metadata_type, @lineage_old19 as lineage_old, @lineage_new19 as lineage_new, @generation19 as generation  union all 
    select @rowguid20 as rowguid, @metadata_type20 as metadata_type, @lineage_old20 as lineage_old, @lineage_new20 as lineage_new, @generation20 as generation   union all 
    select @rowguid21 as rowguid, @metadata_type21 as metadata_type, @lineage_old21 as lineage_old, @lineage_new21 as lineage_new, @generation21 as generation  union all 
    select @rowguid22 as rowguid, @metadata_type22 as metadata_type, @lineage_old22 as lineage_old, @lineage_new22 as lineage_new, @generation22 as generation  union all 
    select @rowguid23 as rowguid, @metadata_type23 as metadata_type, @lineage_old23 as lineage_old, @lineage_new23 as lineage_new, @generation23 as generation  union all 
    select @rowguid24 as rowguid, @metadata_type24 as metadata_type, @lineage_old24 as lineage_old, @lineage_new24 as lineage_new, @generation24 as generation  union all 
    select @rowguid25 as rowguid, @metadata_type25 as metadata_type, @lineage_old25 as lineage_old, @lineage_new25 as lineage_new, @generation25 as generation  union all 
    select @rowguid26 as rowguid, @metadata_type26 as metadata_type, @lineage_old26 as lineage_old, @lineage_new26 as lineage_new, @generation26 as generation  union all 
    select @rowguid27 as rowguid, @metadata_type27 as metadata_type, @lineage_old27 as lineage_old, @lineage_new27 as lineage_new, @generation27 as generation  union all 
    select @rowguid28 as rowguid, @metadata_type28 as metadata_type, @lineage_old28 as lineage_old, @lineage_new28 as lineage_new, @generation28 as generation  union all 
    select @rowguid29 as rowguid, @metadata_type29 as metadata_type, @lineage_old29 as lineage_old, @lineage_new29 as lineage_new, @generation29 as generation  union all 
    select @rowguid30 as rowguid, @metadata_type30 as metadata_type, @lineage_old30 as lineage_old, @lineage_new30 as lineage_new, @generation30 as generation   union all 
    select @rowguid31 as rowguid, @metadata_type31 as metadata_type, @lineage_old31 as lineage_old, @lineage_new31 as lineage_new, @generation31 as generation  union all 
    select @rowguid32 as rowguid, @metadata_type32 as metadata_type, @lineage_old32 as lineage_old, @lineage_new32 as lineage_new, @generation32 as generation  union all 
    select @rowguid33 as rowguid, @metadata_type33 as metadata_type, @lineage_old33 as lineage_old, @lineage_new33 as lineage_new, @generation33 as generation  union all 
    select @rowguid34 as rowguid, @metadata_type34 as metadata_type, @lineage_old34 as lineage_old, @lineage_new34 as lineage_new, @generation34 as generation  union all 
    select @rowguid35 as rowguid, @metadata_type35 as metadata_type, @lineage_old35 as lineage_old, @lineage_new35 as lineage_new, @generation35 as generation  union all 
    select @rowguid36 as rowguid, @metadata_type36 as metadata_type, @lineage_old36 as lineage_old, @lineage_new36 as lineage_new, @generation36 as generation  union all 
    select @rowguid37 as rowguid, @metadata_type37 as metadata_type, @lineage_old37 as lineage_old, @lineage_new37 as lineage_new, @generation37 as generation  union all 
    select @rowguid38 as rowguid, @metadata_type38 as metadata_type, @lineage_old38 as lineage_old, @lineage_new38 as lineage_new, @generation38 as generation  union all 
    select @rowguid39 as rowguid, @metadata_type39 as metadata_type, @lineage_old39 as lineage_old, @lineage_new39 as lineage_new, @generation39 as generation  union all 
    select @rowguid40 as rowguid, @metadata_type40 as metadata_type, @lineage_old40 as lineage_old, @lineage_new40 as lineage_new, @generation40 as generation   union all 
    select @rowguid41 as rowguid, @metadata_type41 as metadata_type, @lineage_old41 as lineage_old, @lineage_new41 as lineage_new, @generation41 as generation  union all 
    select @rowguid42 as rowguid, @metadata_type42 as metadata_type, @lineage_old42 as lineage_old, @lineage_new42 as lineage_new, @generation42 as generation  union all 
    select @rowguid43 as rowguid, @metadata_type43 as metadata_type, @lineage_old43 as lineage_old, @lineage_new43 as lineage_new, @generation43 as generation  union all 
    select @rowguid44 as rowguid, @metadata_type44 as metadata_type, @lineage_old44 as lineage_old, @lineage_new44 as lineage_new, @generation44 as generation  union all 
    select @rowguid45 as rowguid, @metadata_type45 as metadata_type, @lineage_old45 as lineage_old, @lineage_new45 as lineage_new, @generation45 as generation  union all 
    select @rowguid46 as rowguid, @metadata_type46 as metadata_type, @lineage_old46 as lineage_old, @lineage_new46 as lineage_new, @generation46 as generation  union all 
    select @rowguid47 as rowguid, @metadata_type47 as metadata_type, @lineage_old47 as lineage_old, @lineage_new47 as lineage_new, @generation47 as generation  union all 
    select @rowguid48 as rowguid, @metadata_type48 as metadata_type, @lineage_old48 as lineage_old, @lineage_new48 as lineage_new, @generation48 as generation  union all 
    select @rowguid49 as rowguid, @metadata_type49 as metadata_type, @lineage_old49 as lineage_old, @lineage_new49 as lineage_new, @generation49 as generation  union all 
    select @rowguid50 as rowguid, @metadata_type50 as metadata_type, @lineage_old50 as lineage_old, @lineage_new50 as lineage_new, @generation50 as generation   union all 
    select @rowguid51 as rowguid, @metadata_type51 as metadata_type, @lineage_old51 as lineage_old, @lineage_new51 as lineage_new, @generation51 as generation  union all 
    select @rowguid52 as rowguid, @metadata_type52 as metadata_type, @lineage_old52 as lineage_old, @lineage_new52 as lineage_new, @generation52 as generation  union all 
    select @rowguid53 as rowguid, @metadata_type53 as metadata_type, @lineage_old53 as lineage_old, @lineage_new53 as lineage_new, @generation53 as generation  union all 
    select @rowguid54 as rowguid, @metadata_type54 as metadata_type, @lineage_old54 as lineage_old, @lineage_new54 as lineage_new, @generation54 as generation  union all 
    select @rowguid55 as rowguid, @metadata_type55 as metadata_type, @lineage_old55 as lineage_old, @lineage_new55 as lineage_new, @generation55 as generation  union all 
    select @rowguid56 as rowguid, @metadata_type56 as metadata_type, @lineage_old56 as lineage_old, @lineage_new56 as lineage_new, @generation56 as generation  union all 
    select @rowguid57 as rowguid, @metadata_type57 as metadata_type, @lineage_old57 as lineage_old, @lineage_new57 as lineage_new, @generation57 as generation  union all 
    select @rowguid58 as rowguid, @metadata_type58 as metadata_type, @lineage_old58 as lineage_old, @lineage_new58 as lineage_new, @generation58 as generation  union all 
    select @rowguid59 as rowguid, @metadata_type59 as metadata_type, @lineage_old59 as lineage_old, @lineage_new59 as lineage_new, @generation59 as generation  union all 
    select @rowguid60 as rowguid, @metadata_type60 as metadata_type, @lineage_old60 as lineage_old, @lineage_new60 as lineage_new, @generation60 as generation   union all 
    select @rowguid61 as rowguid, @metadata_type61 as metadata_type, @lineage_old61 as lineage_old, @lineage_new61 as lineage_new, @generation61 as generation  union all 
    select @rowguid62 as rowguid, @metadata_type62 as metadata_type, @lineage_old62 as lineage_old, @lineage_new62 as lineage_new, @generation62 as generation  union all 
    select @rowguid63 as rowguid, @metadata_type63 as metadata_type, @lineage_old63 as lineage_old, @lineage_new63 as lineage_new, @generation63 as generation  union all 
    select @rowguid64 as rowguid, @metadata_type64 as metadata_type, @lineage_old64 as lineage_old, @lineage_new64 as lineage_new, @generation64 as generation  union all 
    select @rowguid65 as rowguid, @metadata_type65 as metadata_type, @lineage_old65 as lineage_old, @lineage_new65 as lineage_new, @generation65 as generation  union all 
    select @rowguid66 as rowguid, @metadata_type66 as metadata_type, @lineage_old66 as lineage_old, @lineage_new66 as lineage_new, @generation66 as generation  union all 
    select @rowguid67 as rowguid, @metadata_type67 as metadata_type, @lineage_old67 as lineage_old, @lineage_new67 as lineage_new, @generation67 as generation  union all 
    select @rowguid68 as rowguid, @metadata_type68 as metadata_type, @lineage_old68 as lineage_old, @lineage_new68 as lineage_new, @generation68 as generation  union all 
    select @rowguid69 as rowguid, @metadata_type69 as metadata_type, @lineage_old69 as lineage_old, @lineage_new69 as lineage_new, @generation69 as generation  union all 
    select @rowguid70 as rowguid, @metadata_type70 as metadata_type, @lineage_old70 as lineage_old, @lineage_new70 as lineage_new, @generation70 as generation   union all 
    select @rowguid71 as rowguid, @metadata_type71 as metadata_type, @lineage_old71 as lineage_old, @lineage_new71 as lineage_new, @generation71 as generation  union all 
    select @rowguid72 as rowguid, @metadata_type72 as metadata_type, @lineage_old72 as lineage_old, @lineage_new72 as lineage_new, @generation72 as generation  union all 
    select @rowguid73 as rowguid, @metadata_type73 as metadata_type, @lineage_old73 as lineage_old, @lineage_new73 as lineage_new, @generation73 as generation  union all 
    select @rowguid74 as rowguid, @metadata_type74 as metadata_type, @lineage_old74 as lineage_old, @lineage_new74 as lineage_new, @generation74 as generation  union all 
    select @rowguid75 as rowguid, @metadata_type75 as metadata_type, @lineage_old75 as lineage_old, @lineage_new75 as lineage_new, @generation75 as generation  union all 
    select @rowguid76 as rowguid, @metadata_type76 as metadata_type, @lineage_old76 as lineage_old, @lineage_new76 as lineage_new, @generation76 as generation  union all 
    select @rowguid77 as rowguid, @metadata_type77 as metadata_type, @lineage_old77 as lineage_old, @lineage_new77 as lineage_new, @generation77 as generation  union all 
    select @rowguid78 as rowguid, @metadata_type78 as metadata_type, @lineage_old78 as lineage_old, @lineage_new78 as lineage_new, @generation78 as generation  union all 
    select @rowguid79 as rowguid, @metadata_type79 as metadata_type, @lineage_old79 as lineage_old, @lineage_new79 as lineage_new, @generation79 as generation  union all 
    select @rowguid80 as rowguid, @metadata_type80 as metadata_type, @lineage_old80 as lineage_old, @lineage_new80 as lineage_new, @generation80 as generation   union all 
    select @rowguid81 as rowguid, @metadata_type81 as metadata_type, @lineage_old81 as lineage_old, @lineage_new81 as lineage_new, @generation81 as generation  union all 
    select @rowguid82 as rowguid, @metadata_type82 as metadata_type, @lineage_old82 as lineage_old, @lineage_new82 as lineage_new, @generation82 as generation  union all 
    select @rowguid83 as rowguid, @metadata_type83 as metadata_type, @lineage_old83 as lineage_old, @lineage_new83 as lineage_new, @generation83 as generation  union all 
    select @rowguid84 as rowguid, @metadata_type84 as metadata_type, @lineage_old84 as lineage_old, @lineage_new84 as lineage_new, @generation84 as generation  union all 
    select @rowguid85 as rowguid, @metadata_type85 as metadata_type, @lineage_old85 as lineage_old, @lineage_new85 as lineage_new, @generation85 as generation  union all 
    select @rowguid86 as rowguid, @metadata_type86 as metadata_type, @lineage_old86 as lineage_old, @lineage_new86 as lineage_new, @generation86 as generation  union all 
    select @rowguid87 as rowguid, @metadata_type87 as metadata_type, @lineage_old87 as lineage_old, @lineage_new87 as lineage_new, @generation87 as generation  union all 
    select @rowguid88 as rowguid, @metadata_type88 as metadata_type, @lineage_old88 as lineage_old, @lineage_new88 as lineage_new, @generation88 as generation  union all 
    select @rowguid89 as rowguid, @metadata_type89 as metadata_type, @lineage_old89 as lineage_old, @lineage_new89 as lineage_new, @generation89 as generation  union all 
    select @rowguid90 as rowguid, @metadata_type90 as metadata_type, @lineage_old90 as lineage_old, @lineage_new90 as lineage_new, @generation90 as generation   union all 
    select @rowguid91 as rowguid, @metadata_type91 as metadata_type, @lineage_old91 as lineage_old, @lineage_new91 as lineage_new, @generation91 as generation  union all 
    select @rowguid92 as rowguid, @metadata_type92 as metadata_type, @lineage_old92 as lineage_old, @lineage_new92 as lineage_new, @generation92 as generation  union all 
    select @rowguid93 as rowguid, @metadata_type93 as metadata_type, @lineage_old93 as lineage_old, @lineage_new93 as lineage_new, @generation93 as generation  union all 
    select @rowguid94 as rowguid, @metadata_type94 as metadata_type, @lineage_old94 as lineage_old, @lineage_new94 as lineage_new, @generation94 as generation  union all 
    select @rowguid95 as rowguid, @metadata_type95 as metadata_type, @lineage_old95 as lineage_old, @lineage_new95 as lineage_new, @generation95 as generation  union all 
    select @rowguid96 as rowguid, @metadata_type96 as metadata_type, @lineage_old96 as lineage_old, @lineage_new96 as lineage_new, @generation96 as generation  union all 
    select @rowguid97 as rowguid, @metadata_type97 as metadata_type, @lineage_old97 as lineage_old, @lineage_new97 as lineage_new, @generation97 as generation  union all 
    select @rowguid98 as rowguid, @metadata_type98 as metadata_type, @lineage_old98 as lineage_old, @lineage_new98 as lineage_new, @generation98 as generation  union all 
    select @rowguid99 as rowguid, @metadata_type99 as metadata_type, @lineage_old99 as lineage_old, @lineage_new99 as lineage_new, @generation99 as generation  union all 
    select @rowguid100 as rowguid, @metadata_type100 as metadata_type, @lineage_old100 as lineage_old, @lineage_new100 as lineage_new, @generation100 as generation  
        ) as rows
        inner join dbo.MSmerge_past_partition_mappings ppm with (rowlock) 
        on ppm.rowguid = rows.rowguid and ppm.tablenick = 11696062 
        and ppm.generation = 0
        and rows.rowguid is not NULL
        and rows.lineage_new is not null
        option (force order, loop join)
        if @error<>0
                goto Failure 
    if @tomb_rows_updated <> @rowstobedeleted
    begin
        -- now insert rows that are not in tombstone
        insert into dbo.MSmerge_tombstone with (rowlock)
            (rowguid, tablenick, type, generation, lineage)
        select rows.rowguid, 11696062, 
               case when (rows.metadata_type=5 or rows.metadata_type=6) then rows.metadata_type else 1 end, 
               rows.generation, rows.lineage_new
        from 
        ( 
    select @rowguid1 as rowguid, @metadata_type1 as metadata_type, @lineage_old1 as lineage_old, @lineage_new1 as lineage_new, @generation1 as generation  union all 
    select @rowguid2 as rowguid, @metadata_type2 as metadata_type, @lineage_old2 as lineage_old, @lineage_new2 as lineage_new, @generation2 as generation  union all 
    select @rowguid3 as rowguid, @metadata_type3 as metadata_type, @lineage_old3 as lineage_old, @lineage_new3 as lineage_new, @generation3 as generation  union all 
    select @rowguid4 as rowguid, @metadata_type4 as metadata_type, @lineage_old4 as lineage_old, @lineage_new4 as lineage_new, @generation4 as generation  union all 
    select @rowguid5 as rowguid, @metadata_type5 as metadata_type, @lineage_old5 as lineage_old, @lineage_new5 as lineage_new, @generation5 as generation  union all 
    select @rowguid6 as rowguid, @metadata_type6 as metadata_type, @lineage_old6 as lineage_old, @lineage_new6 as lineage_new, @generation6 as generation  union all 
    select @rowguid7 as rowguid, @metadata_type7 as metadata_type, @lineage_old7 as lineage_old, @lineage_new7 as lineage_new, @generation7 as generation  union all 
    select @rowguid8 as rowguid, @metadata_type8 as metadata_type, @lineage_old8 as lineage_old, @lineage_new8 as lineage_new, @generation8 as generation  union all 
    select @rowguid9 as rowguid, @metadata_type9 as metadata_type, @lineage_old9 as lineage_old, @lineage_new9 as lineage_new, @generation9 as generation  union all 
    select @rowguid10 as rowguid, @metadata_type10 as metadata_type, @lineage_old10 as lineage_old, @lineage_new10 as lineage_new, @generation10 as generation   union all 
    select @rowguid11 as rowguid, @metadata_type11 as metadata_type, @lineage_old11 as lineage_old, @lineage_new11 as lineage_new, @generation11 as generation  union all 
    select @rowguid12 as rowguid, @metadata_type12 as metadata_type, @lineage_old12 as lineage_old, @lineage_new12 as lineage_new, @generation12 as generation  union all 
    select @rowguid13 as rowguid, @metadata_type13 as metadata_type, @lineage_old13 as lineage_old, @lineage_new13 as lineage_new, @generation13 as generation  union all 
    select @rowguid14 as rowguid, @metadata_type14 as metadata_type, @lineage_old14 as lineage_old, @lineage_new14 as lineage_new, @generation14 as generation  union all 
    select @rowguid15 as rowguid, @metadata_type15 as metadata_type, @lineage_old15 as lineage_old, @lineage_new15 as lineage_new, @generation15 as generation  union all 
    select @rowguid16 as rowguid, @metadata_type16 as metadata_type, @lineage_old16 as lineage_old, @lineage_new16 as lineage_new, @generation16 as generation  union all 
    select @rowguid17 as rowguid, @metadata_type17 as metadata_type, @lineage_old17 as lineage_old, @lineage_new17 as lineage_new, @generation17 as generation  union all 
    select @rowguid18 as rowguid, @metadata_type18 as metadata_type, @lineage_old18 as lineage_old, @lineage_new18 as lineage_new, @generation18 as generation  union all 
    select @rowguid19 as rowguid, @metadata_type19 as metadata_type, @lineage_old19 as lineage_old, @lineage_new19 as lineage_new, @generation19 as generation  union all 
    select @rowguid20 as rowguid, @metadata_type20 as metadata_type, @lineage_old20 as lineage_old, @lineage_new20 as lineage_new, @generation20 as generation   union all 
    select @rowguid21 as rowguid, @metadata_type21 as metadata_type, @lineage_old21 as lineage_old, @lineage_new21 as lineage_new, @generation21 as generation  union all 
    select @rowguid22 as rowguid, @metadata_type22 as metadata_type, @lineage_old22 as lineage_old, @lineage_new22 as lineage_new, @generation22 as generation  union all 
    select @rowguid23 as rowguid, @metadata_type23 as metadata_type, @lineage_old23 as lineage_old, @lineage_new23 as lineage_new, @generation23 as generation  union all 
    select @rowguid24 as rowguid, @metadata_type24 as metadata_type, @lineage_old24 as lineage_old, @lineage_new24 as lineage_new, @generation24 as generation  union all 
    select @rowguid25 as rowguid, @metadata_type25 as metadata_type, @lineage_old25 as lineage_old, @lineage_new25 as lineage_new, @generation25 as generation  union all 
    select @rowguid26 as rowguid, @metadata_type26 as metadata_type, @lineage_old26 as lineage_old, @lineage_new26 as lineage_new, @generation26 as generation  union all 
    select @rowguid27 as rowguid, @metadata_type27 as metadata_type, @lineage_old27 as lineage_old, @lineage_new27 as lineage_new, @generation27 as generation  union all 
    select @rowguid28 as rowguid, @metadata_type28 as metadata_type, @lineage_old28 as lineage_old, @lineage_new28 as lineage_new, @generation28 as generation  union all 
    select @rowguid29 as rowguid, @metadata_type29 as metadata_type, @lineage_old29 as lineage_old, @lineage_new29 as lineage_new, @generation29 as generation  union all 
    select @rowguid30 as rowguid, @metadata_type30 as metadata_type, @lineage_old30 as lineage_old, @lineage_new30 as lineage_new, @generation30 as generation   union all 
    select @rowguid31 as rowguid, @metadata_type31 as metadata_type, @lineage_old31 as lineage_old, @lineage_new31 as lineage_new, @generation31 as generation  union all 
    select @rowguid32 as rowguid, @metadata_type32 as metadata_type, @lineage_old32 as lineage_old, @lineage_new32 as lineage_new, @generation32 as generation  union all 
    select @rowguid33 as rowguid, @metadata_type33 as metadata_type, @lineage_old33 as lineage_old, @lineage_new33 as lineage_new, @generation33 as generation  union all 
    select @rowguid34 as rowguid, @metadata_type34 as metadata_type, @lineage_old34 as lineage_old, @lineage_new34 as lineage_new, @generation34 as generation  union all 
    select @rowguid35 as rowguid, @metadata_type35 as metadata_type, @lineage_old35 as lineage_old, @lineage_new35 as lineage_new, @generation35 as generation  union all 
    select @rowguid36 as rowguid, @metadata_type36 as metadata_type, @lineage_old36 as lineage_old, @lineage_new36 as lineage_new, @generation36 as generation  union all 
    select @rowguid37 as rowguid, @metadata_type37 as metadata_type, @lineage_old37 as lineage_old, @lineage_new37 as lineage_new, @generation37 as generation  union all 
    select @rowguid38 as rowguid, @metadata_type38 as metadata_type, @lineage_old38 as lineage_old, @lineage_new38 as lineage_new, @generation38 as generation  union all 
    select @rowguid39 as rowguid, @metadata_type39 as metadata_type, @lineage_old39 as lineage_old, @lineage_new39 as lineage_new, @generation39 as generation  union all 
    select @rowguid40 as rowguid, @metadata_type40 as metadata_type, @lineage_old40 as lineage_old, @lineage_new40 as lineage_new, @generation40 as generation   union all 
    select @rowguid41 as rowguid, @metadata_type41 as metadata_type, @lineage_old41 as lineage_old, @lineage_new41 as lineage_new, @generation41 as generation  union all 
    select @rowguid42 as rowguid, @metadata_type42 as metadata_type, @lineage_old42 as lineage_old, @lineage_new42 as lineage_new, @generation42 as generation  union all 
    select @rowguid43 as rowguid, @metadata_type43 as metadata_type, @lineage_old43 as lineage_old, @lineage_new43 as lineage_new, @generation43 as generation  union all 
    select @rowguid44 as rowguid, @metadata_type44 as metadata_type, @lineage_old44 as lineage_old, @lineage_new44 as lineage_new, @generation44 as generation  union all 
    select @rowguid45 as rowguid, @metadata_type45 as metadata_type, @lineage_old45 as lineage_old, @lineage_new45 as lineage_new, @generation45 as generation  union all 
    select @rowguid46 as rowguid, @metadata_type46 as metadata_type, @lineage_old46 as lineage_old, @lineage_new46 as lineage_new, @generation46 as generation  union all 
    select @rowguid47 as rowguid, @metadata_type47 as metadata_type, @lineage_old47 as lineage_old, @lineage_new47 as lineage_new, @generation47 as generation  union all 
    select @rowguid48 as rowguid, @metadata_type48 as metadata_type, @lineage_old48 as lineage_old, @lineage_new48 as lineage_new, @generation48 as generation  union all 
    select @rowguid49 as rowguid, @metadata_type49 as metadata_type, @lineage_old49 as lineage_old, @lineage_new49 as lineage_new, @generation49 as generation  union all 
    select @rowguid50 as rowguid, @metadata_type50 as metadata_type, @lineage_old50 as lineage_old, @lineage_new50 as lineage_new, @generation50 as generation   union all 
    select @rowguid51 as rowguid, @metadata_type51 as metadata_type, @lineage_old51 as lineage_old, @lineage_new51 as lineage_new, @generation51 as generation  union all 
    select @rowguid52 as rowguid, @metadata_type52 as metadata_type, @lineage_old52 as lineage_old, @lineage_new52 as lineage_new, @generation52 as generation  union all 
    select @rowguid53 as rowguid, @metadata_type53 as metadata_type, @lineage_old53 as lineage_old, @lineage_new53 as lineage_new, @generation53 as generation  union all 
    select @rowguid54 as rowguid, @metadata_type54 as metadata_type, @lineage_old54 as lineage_old, @lineage_new54 as lineage_new, @generation54 as generation  union all 
    select @rowguid55 as rowguid, @metadata_type55 as metadata_type, @lineage_old55 as lineage_old, @lineage_new55 as lineage_new, @generation55 as generation  union all 
    select @rowguid56 as rowguid, @metadata_type56 as metadata_type, @lineage_old56 as lineage_old, @lineage_new56 as lineage_new, @generation56 as generation  union all 
    select @rowguid57 as rowguid, @metadata_type57 as metadata_type, @lineage_old57 as lineage_old, @lineage_new57 as lineage_new, @generation57 as generation  union all 
    select @rowguid58 as rowguid, @metadata_type58 as metadata_type, @lineage_old58 as lineage_old, @lineage_new58 as lineage_new, @generation58 as generation  union all 
    select @rowguid59 as rowguid, @metadata_type59 as metadata_type, @lineage_old59 as lineage_old, @lineage_new59 as lineage_new, @generation59 as generation  union all 
    select @rowguid60 as rowguid, @metadata_type60 as metadata_type, @lineage_old60 as lineage_old, @lineage_new60 as lineage_new, @generation60 as generation   union all 
    select @rowguid61 as rowguid, @metadata_type61 as metadata_type, @lineage_old61 as lineage_old, @lineage_new61 as lineage_new, @generation61 as generation  union all 
    select @rowguid62 as rowguid, @metadata_type62 as metadata_type, @lineage_old62 as lineage_old, @lineage_new62 as lineage_new, @generation62 as generation  union all 
    select @rowguid63 as rowguid, @metadata_type63 as metadata_type, @lineage_old63 as lineage_old, @lineage_new63 as lineage_new, @generation63 as generation  union all 
    select @rowguid64 as rowguid, @metadata_type64 as metadata_type, @lineage_old64 as lineage_old, @lineage_new64 as lineage_new, @generation64 as generation  union all 
    select @rowguid65 as rowguid, @metadata_type65 as metadata_type, @lineage_old65 as lineage_old, @lineage_new65 as lineage_new, @generation65 as generation  union all 
    select @rowguid66 as rowguid, @metadata_type66 as metadata_type, @lineage_old66 as lineage_old, @lineage_new66 as lineage_new, @generation66 as generation  union all 
    select @rowguid67 as rowguid, @metadata_type67 as metadata_type, @lineage_old67 as lineage_old, @lineage_new67 as lineage_new, @generation67 as generation  union all 
    select @rowguid68 as rowguid, @metadata_type68 as metadata_type, @lineage_old68 as lineage_old, @lineage_new68 as lineage_new, @generation68 as generation  union all 
    select @rowguid69 as rowguid, @metadata_type69 as metadata_type, @lineage_old69 as lineage_old, @lineage_new69 as lineage_new, @generation69 as generation  union all 
    select @rowguid70 as rowguid, @metadata_type70 as metadata_type, @lineage_old70 as lineage_old, @lineage_new70 as lineage_new, @generation70 as generation   union all 
    select @rowguid71 as rowguid, @metadata_type71 as metadata_type, @lineage_old71 as lineage_old, @lineage_new71 as lineage_new, @generation71 as generation  union all 
    select @rowguid72 as rowguid, @metadata_type72 as metadata_type, @lineage_old72 as lineage_old, @lineage_new72 as lineage_new, @generation72 as generation  union all 
    select @rowguid73 as rowguid, @metadata_type73 as metadata_type, @lineage_old73 as lineage_old, @lineage_new73 as lineage_new, @generation73 as generation  union all 
    select @rowguid74 as rowguid, @metadata_type74 as metadata_type, @lineage_old74 as lineage_old, @lineage_new74 as lineage_new, @generation74 as generation  union all 
    select @rowguid75 as rowguid, @metadata_type75 as metadata_type, @lineage_old75 as lineage_old, @lineage_new75 as lineage_new, @generation75 as generation  union all 
    select @rowguid76 as rowguid, @metadata_type76 as metadata_type, @lineage_old76 as lineage_old, @lineage_new76 as lineage_new, @generation76 as generation  union all 
    select @rowguid77 as rowguid, @metadata_type77 as metadata_type, @lineage_old77 as lineage_old, @lineage_new77 as lineage_new, @generation77 as generation  union all 
    select @rowguid78 as rowguid, @metadata_type78 as metadata_type, @lineage_old78 as lineage_old, @lineage_new78 as lineage_new, @generation78 as generation  union all 
    select @rowguid79 as rowguid, @metadata_type79 as metadata_type, @lineage_old79 as lineage_old, @lineage_new79 as lineage_new, @generation79 as generation  union all 
    select @rowguid80 as rowguid, @metadata_type80 as metadata_type, @lineage_old80 as lineage_old, @lineage_new80 as lineage_new, @generation80 as generation   union all 
    select @rowguid81 as rowguid, @metadata_type81 as metadata_type, @lineage_old81 as lineage_old, @lineage_new81 as lineage_new, @generation81 as generation  union all 
    select @rowguid82 as rowguid, @metadata_type82 as metadata_type, @lineage_old82 as lineage_old, @lineage_new82 as lineage_new, @generation82 as generation  union all 
    select @rowguid83 as rowguid, @metadata_type83 as metadata_type, @lineage_old83 as lineage_old, @lineage_new83 as lineage_new, @generation83 as generation  union all 
    select @rowguid84 as rowguid, @metadata_type84 as metadata_type, @lineage_old84 as lineage_old, @lineage_new84 as lineage_new, @generation84 as generation  union all 
    select @rowguid85 as rowguid, @metadata_type85 as metadata_type, @lineage_old85 as lineage_old, @lineage_new85 as lineage_new, @generation85 as generation  union all 
    select @rowguid86 as rowguid, @metadata_type86 as metadata_type, @lineage_old86 as lineage_old, @lineage_new86 as lineage_new, @generation86 as generation  union all 
    select @rowguid87 as rowguid, @metadata_type87 as metadata_type, @lineage_old87 as lineage_old, @lineage_new87 as lineage_new, @generation87 as generation  union all 
    select @rowguid88 as rowguid, @metadata_type88 as metadata_type, @lineage_old88 as lineage_old, @lineage_new88 as lineage_new, @generation88 as generation  union all 
    select @rowguid89 as rowguid, @metadata_type89 as metadata_type, @lineage_old89 as lineage_old, @lineage_new89 as lineage_new, @generation89 as generation  union all 
    select @rowguid90 as rowguid, @metadata_type90 as metadata_type, @lineage_old90 as lineage_old, @lineage_new90 as lineage_new, @generation90 as generation   union all 
    select @rowguid91 as rowguid, @metadata_type91 as metadata_type, @lineage_old91 as lineage_old, @lineage_new91 as lineage_new, @generation91 as generation  union all 
    select @rowguid92 as rowguid, @metadata_type92 as metadata_type, @lineage_old92 as lineage_old, @lineage_new92 as lineage_new, @generation92 as generation  union all 
    select @rowguid93 as rowguid, @metadata_type93 as metadata_type, @lineage_old93 as lineage_old, @lineage_new93 as lineage_new, @generation93 as generation  union all 
    select @rowguid94 as rowguid, @metadata_type94 as metadata_type, @lineage_old94 as lineage_old, @lineage_new94 as lineage_new, @generation94 as generation  union all 
    select @rowguid95 as rowguid, @metadata_type95 as metadata_type, @lineage_old95 as lineage_old, @lineage_new95 as lineage_new, @generation95 as generation  union all 
    select @rowguid96 as rowguid, @metadata_type96 as metadata_type, @lineage_old96 as lineage_old, @lineage_new96 as lineage_new, @generation96 as generation  union all 
    select @rowguid97 as rowguid, @metadata_type97 as metadata_type, @lineage_old97 as lineage_old, @lineage_new97 as lineage_new, @generation97 as generation  union all 
    select @rowguid98 as rowguid, @metadata_type98 as metadata_type, @lineage_old98 as lineage_old, @lineage_new98 as lineage_new, @generation98 as generation  union all 
    select @rowguid99 as rowguid, @metadata_type99 as metadata_type, @lineage_old99 as lineage_old, @lineage_new99 as lineage_new, @generation99 as generation  union all 
    select @rowguid100 as rowguid, @metadata_type100 as metadata_type, @lineage_old100 as lineage_old, @lineage_new100 as lineage_new, @generation100 as generation  
        ) as rows
        left outer join dbo.MSmerge_tombstone tomb with (rowlock) 
        on tomb.rowguid = rows.rowguid 
        and tomb.tablenick = 11696062
        and rows.rowguid is not NULL and rows.lineage_new is not null
        where tomb.rowguid is NULL 
        and rows.rowguid is not NULL and rows.lineage_new is not null
        
        if @@error<>0
            goto Failure 
        -- now delete the contents rows
        delete dbo.MSmerge_contents with (rowlock)
        from 
        ( 
         select @rowguid1 as rowguid union all 
         select @rowguid2 as rowguid union all 
         select @rowguid3 as rowguid union all 
         select @rowguid4 as rowguid union all 
         select @rowguid5 as rowguid union all 
         select @rowguid6 as rowguid union all 
         select @rowguid7 as rowguid union all 
         select @rowguid8 as rowguid union all 
         select @rowguid9 as rowguid union all 
         select @rowguid10 as rowguid union all 
         select @rowguid11 as rowguid union all 
         select @rowguid12 as rowguid union all 
         select @rowguid13 as rowguid union all 
         select @rowguid14 as rowguid union all 
         select @rowguid15 as rowguid union all 
         select @rowguid16 as rowguid union all 
         select @rowguid17 as rowguid union all 
         select @rowguid18 as rowguid union all 
         select @rowguid19 as rowguid union all 
         select @rowguid20 as rowguid union all 
         select @rowguid21 as rowguid union all 
         select @rowguid22 as rowguid union all 
         select @rowguid23 as rowguid union all 
         select @rowguid24 as rowguid union all 
         select @rowguid25 as rowguid union all 
         select @rowguid26 as rowguid union all 
         select @rowguid27 as rowguid union all 
         select @rowguid28 as rowguid union all 
         select @rowguid29 as rowguid union all 
         select @rowguid30 as rowguid union all 
         select @rowguid31 as rowguid union all 
         select @rowguid32 as rowguid union all 
         select @rowguid33 as rowguid union all 
         select @rowguid34 as rowguid union all 
         select @rowguid35 as rowguid union all 
         select @rowguid36 as rowguid union all 
         select @rowguid37 as rowguid union all 
         select @rowguid38 as rowguid union all 
         select @rowguid39 as rowguid union all 
         select @rowguid40 as rowguid union all 
         select @rowguid41 as rowguid union all 
         select @rowguid42 as rowguid union all 
         select @rowguid43 as rowguid union all 
         select @rowguid44 as rowguid union all 
         select @rowguid45 as rowguid union all 
         select @rowguid46 as rowguid union all 
         select @rowguid47 as rowguid union all 
         select @rowguid48 as rowguid union all 
         select @rowguid49 as rowguid union all 
         select @rowguid50 as rowguid union all 
         select @rowguid51 as rowguid union all 
         select @rowguid52 as rowguid union all 
         select @rowguid53 as rowguid union all 
         select @rowguid54 as rowguid union all 
         select @rowguid55 as rowguid union all 
         select @rowguid56 as rowguid union all 
         select @rowguid57 as rowguid union all 
         select @rowguid58 as rowguid union all 
         select @rowguid59 as rowguid union all 
         select @rowguid60 as rowguid union all 
         select @rowguid61 as rowguid union all 
         select @rowguid62 as rowguid union all 
         select @rowguid63 as rowguid union all 
         select @rowguid64 as rowguid union all 
         select @rowguid65 as rowguid union all 
         select @rowguid66 as rowguid union all 
         select @rowguid67 as rowguid union all 
         select @rowguid68 as rowguid union all 
         select @rowguid69 as rowguid union all 
         select @rowguid70 as rowguid union all 
         select @rowguid71 as rowguid union all 
         select @rowguid72 as rowguid union all 
         select @rowguid73 as rowguid union all 
         select @rowguid74 as rowguid union all 
         select @rowguid75 as rowguid union all 
         select @rowguid76 as rowguid union all 
         select @rowguid77 as rowguid union all 
         select @rowguid78 as rowguid union all 
         select @rowguid79 as rowguid union all 
         select @rowguid80 as rowguid union all 
         select @rowguid81 as rowguid union all 
         select @rowguid82 as rowguid union all 
         select @rowguid83 as rowguid union all 
         select @rowguid84 as rowguid union all 
         select @rowguid85 as rowguid union all 
         select @rowguid86 as rowguid union all 
         select @rowguid87 as rowguid union all 
         select @rowguid88 as rowguid union all 
         select @rowguid89 as rowguid union all 
         select @rowguid90 as rowguid union all 
         select @rowguid91 as rowguid union all 
         select @rowguid92 as rowguid union all 
         select @rowguid93 as rowguid union all 
         select @rowguid94 as rowguid union all 
         select @rowguid95 as rowguid union all 
         select @rowguid96 as rowguid union all 
         select @rowguid97 as rowguid union all 
         select @rowguid98 as rowguid union all 
         select @rowguid99 as rowguid union all 
         select @rowguid100 as rowguid 
        ) as rows, dbo.MSmerge_contents cont with (rowlock)
        where cont.rowguid = rows.rowguid and cont.tablenick = 11696062
            and rows.rowguid is not NULL
        option (force order, loop join)
        if @@error<>0 
            goto Failure
    end 
    exec @retcode = sys.sp_MSdeletemetadataactionrequest '088C2847-4D1D-4D57-8FED-3D0B087A6766', 11696062, 
        @rowguid1, 
        @rowguid2, 
        @rowguid3, 
        @rowguid4, 
        @rowguid5, 
        @rowguid6, 
        @rowguid7, 
        @rowguid8, 
        @rowguid9, 
        @rowguid10, 
        @rowguid11, 
        @rowguid12, 
        @rowguid13, 
        @rowguid14, 
        @rowguid15, 
        @rowguid16, 
        @rowguid17, 
        @rowguid18, 
        @rowguid19, 
        @rowguid20, 
        @rowguid21, 
        @rowguid22, 
        @rowguid23, 
        @rowguid24, 
        @rowguid25, 
        @rowguid26, 
        @rowguid27, 
        @rowguid28, 
        @rowguid29, 
        @rowguid30, 
        @rowguid31, 
        @rowguid32, 
        @rowguid33, 
        @rowguid34, 
        @rowguid35, 
        @rowguid36, 
        @rowguid37, 
        @rowguid38, 
        @rowguid39, 
        @rowguid40, 
        @rowguid41, 
        @rowguid42, 
        @rowguid43, 
        @rowguid44, 
        @rowguid45, 
        @rowguid46, 
        @rowguid47, 
        @rowguid48, 
        @rowguid49, 
        @rowguid50, 
        @rowguid51, 
        @rowguid52, 
        @rowguid53, 
        @rowguid54, 
        @rowguid55, 
        @rowguid56, 
        @rowguid57, 
        @rowguid58, 
        @rowguid59, 
        @rowguid60, 
        @rowguid61, 
        @rowguid62, 
        @rowguid63, 
        @rowguid64, 
        @rowguid65, 
        @rowguid66, 
        @rowguid67, 
        @rowguid68, 
        @rowguid69, 
        @rowguid70, 
        @rowguid71, 
        @rowguid72, 
        @rowguid73, 
        @rowguid74, 
        @rowguid75, 
        @rowguid76, 
        @rowguid77, 
        @rowguid78, 
        @rowguid79, 
        @rowguid80, 
        @rowguid81, 
        @rowguid82, 
        @rowguid83, 
        @rowguid84, 
        @rowguid85, 
        @rowguid86, 
        @rowguid87, 
        @rowguid88, 
        @rowguid89, 
        @rowguid90, 
        @rowguid91, 
        @rowguid92, 
        @rowguid93, 
        @rowguid94, 
        @rowguid95, 
        @rowguid96, 
        @rowguid97, 
        @rowguid98, 
        @rowguid99, 
        @rowguid100
    if @retcode<>0 or @@error<>0
        goto Failure
 
    commit tran
    return 1

Failure:
    rollback tran batchdeleteproc
    commit tran
    return 0
end
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[MSmerge_del_sp_05810E0E817C42B9088C28474D1D4D57]
(
    @rowstobedeleted int, 
    @partition_id int = NULL  ,
    @rowguid1 uniqueidentifier = NULL,
    @metadata_type1 tinyint = NULL,
    @generation1 bigint = NULL,
    @lineage_old1 varbinary(311) = NULL,
    @lineage_new1 varbinary(311) = NULL,
    @rowguid2 uniqueidentifier = NULL,
    @metadata_type2 tinyint = NULL,
    @generation2 bigint = NULL,
    @lineage_old2 varbinary(311) = NULL,
    @lineage_new2 varbinary(311) = NULL,
    @rowguid3 uniqueidentifier = NULL,
    @metadata_type3 tinyint = NULL,
    @generation3 bigint = NULL,
    @lineage_old3 varbinary(311) = NULL,
    @lineage_new3 varbinary(311) = NULL,
    @rowguid4 uniqueidentifier = NULL,
    @metadata_type4 tinyint = NULL,
    @generation4 bigint = NULL,
    @lineage_old4 varbinary(311) = NULL,
    @lineage_new4 varbinary(311) = NULL,
    @rowguid5 uniqueidentifier = NULL,
    @metadata_type5 tinyint = NULL,
    @generation5 bigint = NULL,
    @lineage_old5 varbinary(311) = NULL,
    @lineage_new5 varbinary(311) = NULL,
    @rowguid6 uniqueidentifier = NULL,
    @metadata_type6 tinyint = NULL,
    @generation6 bigint = NULL,
    @lineage_old6 varbinary(311) = NULL,
    @lineage_new6 varbinary(311) = NULL,
    @rowguid7 uniqueidentifier = NULL,
    @metadata_type7 tinyint = NULL,
    @generation7 bigint = NULL,
    @lineage_old7 varbinary(311) = NULL,
    @lineage_new7 varbinary(311) = NULL,
    @rowguid8 uniqueidentifier = NULL,
    @metadata_type8 tinyint = NULL,
    @generation8 bigint = NULL,
    @lineage_old8 varbinary(311) = NULL,
    @lineage_new8 varbinary(311) = NULL,
    @rowguid9 uniqueidentifier = NULL,
    @metadata_type9 tinyint = NULL,
    @generation9 bigint = NULL,
    @lineage_old9 varbinary(311) = NULL,
    @lineage_new9 varbinary(311) = NULL,
    @rowguid10 uniqueidentifier = NULL,
    @metadata_type10 tinyint = NULL,
    @generation10 bigint = NULL,
    @lineage_old10 varbinary(311) = NULL,
    @lineage_new10 varbinary(311) = NULL ,
    @rowguid11 uniqueidentifier = NULL,
    @metadata_type11 tinyint = NULL,
    @generation11 bigint = NULL,
    @lineage_old11 varbinary(311) = NULL,
    @lineage_new11 varbinary(311) = NULL,
    @rowguid12 uniqueidentifier = NULL,
    @metadata_type12 tinyint = NULL,
    @generation12 bigint = NULL,
    @lineage_old12 varbinary(311) = NULL,
    @lineage_new12 varbinary(311) = NULL,
    @rowguid13 uniqueidentifier = NULL,
    @metadata_type13 tinyint = NULL,
    @generation13 bigint = NULL,
    @lineage_old13 varbinary(311) = NULL,
    @lineage_new13 varbinary(311) = NULL,
    @rowguid14 uniqueidentifier = NULL,
    @metadata_type14 tinyint = NULL,
    @generation14 bigint = NULL,
    @lineage_old14 varbinary(311) = NULL,
    @lineage_new14 varbinary(311) = NULL,
    @rowguid15 uniqueidentifier = NULL,
    @metadata_type15 tinyint = NULL,
    @generation15 bigint = NULL,
    @lineage_old15 varbinary(311) = NULL,
    @lineage_new15 varbinary(311) = NULL,
    @rowguid16 uniqueidentifier = NULL,
    @metadata_type16 tinyint = NULL,
    @generation16 bigint = NULL,
    @lineage_old16 varbinary(311) = NULL,
    @lineage_new16 varbinary(311) = NULL,
    @rowguid17 uniqueidentifier = NULL,
    @metadata_type17 tinyint = NULL,
    @generation17 bigint = NULL,
    @lineage_old17 varbinary(311) = NULL,
    @lineage_new17 varbinary(311) = NULL,
    @rowguid18 uniqueidentifier = NULL,
    @metadata_type18 tinyint = NULL,
    @generation18 bigint = NULL,
    @lineage_old18 varbinary(311) = NULL,
    @lineage_new18 varbinary(311) = NULL,
    @rowguid19 uniqueidentifier = NULL,
    @metadata_type19 tinyint = NULL,
    @generation19 bigint = NULL,
    @lineage_old19 varbinary(311) = NULL,
    @lineage_new19 varbinary(311) = NULL,
    @rowguid20 uniqueidentifier = NULL,
    @metadata_type20 tinyint = NULL,
    @generation20 bigint = NULL,
    @lineage_old20 varbinary(311) = NULL,
    @lineage_new20 varbinary(311) = NULL ,
    @rowguid21 uniqueidentifier = NULL,
    @metadata_type21 tinyint = NULL,
    @generation21 bigint = NULL,
    @lineage_old21 varbinary(311) = NULL,
    @lineage_new21 varbinary(311) = NULL,
    @rowguid22 uniqueidentifier = NULL,
    @metadata_type22 tinyint = NULL,
    @generation22 bigint = NULL,
    @lineage_old22 varbinary(311) = NULL,
    @lineage_new22 varbinary(311) = NULL,
    @rowguid23 uniqueidentifier = NULL,
    @metadata_type23 tinyint = NULL,
    @generation23 bigint = NULL,
    @lineage_old23 varbinary(311) = NULL,
    @lineage_new23 varbinary(311) = NULL,
    @rowguid24 uniqueidentifier = NULL,
    @metadata_type24 tinyint = NULL,
    @generation24 bigint = NULL,
    @lineage_old24 varbinary(311) = NULL,
    @lineage_new24 varbinary(311) = NULL,
    @rowguid25 uniqueidentifier = NULL,
    @metadata_type25 tinyint = NULL,
    @generation25 bigint = NULL,
    @lineage_old25 varbinary(311) = NULL,
    @lineage_new25 varbinary(311) = NULL,
    @rowguid26 uniqueidentifier = NULL,
    @metadata_type26 tinyint = NULL,
    @generation26 bigint = NULL,
    @lineage_old26 varbinary(311) = NULL,
    @lineage_new26 varbinary(311) = NULL,
    @rowguid27 uniqueidentifier = NULL,
    @metadata_type27 tinyint = NULL,
    @generation27 bigint = NULL,
    @lineage_old27 varbinary(311) = NULL,
    @lineage_new27 varbinary(311) = NULL,
    @rowguid28 uniqueidentifier = NULL,
    @metadata_type28 tinyint = NULL,
    @generation28 bigint = NULL,
    @lineage_old28 varbinary(311) = NULL,
    @lineage_new28 varbinary(311) = NULL,
    @rowguid29 uniqueidentifier = NULL,
    @metadata_type29 tinyint = NULL,
    @generation29 bigint = NULL,
    @lineage_old29 varbinary(311) = NULL,
    @lineage_new29 varbinary(311) = NULL,
    @rowguid30 uniqueidentifier = NULL,
    @metadata_type30 tinyint = NULL,
    @generation30 bigint = NULL,
    @lineage_old30 varbinary(311) = NULL,
    @lineage_new30 varbinary(311) = NULL ,
    @rowguid31 uniqueidentifier = NULL,
    @metadata_type31 tinyint = NULL,
    @generation31 bigint = NULL,
    @lineage_old31 varbinary(311) = NULL,
    @lineage_new31 varbinary(311) = NULL,
    @rowguid32 uniqueidentifier = NULL,
    @metadata_type32 tinyint = NULL,
    @generation32 bigint = NULL,
    @lineage_old32 varbinary(311) = NULL,
    @lineage_new32 varbinary(311) = NULL,
    @rowguid33 uniqueidentifier = NULL,
    @metadata_type33 tinyint = NULL,
    @generation33 bigint = NULL,
    @lineage_old33 varbinary(311) = NULL,
    @lineage_new33 varbinary(311) = NULL,
    @rowguid34 uniqueidentifier = NULL,
    @metadata_type34 tinyint = NULL,
    @generation34 bigint = NULL,
    @lineage_old34 varbinary(311) = NULL,
    @lineage_new34 varbinary(311) = NULL,
    @rowguid35 uniqueidentifier = NULL,
    @metadata_type35 tinyint = NULL,
    @generation35 bigint = NULL,
    @lineage_old35 varbinary(311) = NULL,
    @lineage_new35 varbinary(311) = NULL,
    @rowguid36 uniqueidentifier = NULL,
    @metadata_type36 tinyint = NULL,
    @generation36 bigint = NULL,
    @lineage_old36 varbinary(311) = NULL,
    @lineage_new36 varbinary(311) = NULL,
    @rowguid37 uniqueidentifier = NULL,
    @metadata_type37 tinyint = NULL,
    @generation37 bigint = NULL,
    @lineage_old37 varbinary(311) = NULL,
    @lineage_new37 varbinary(311) = NULL,
    @rowguid38 uniqueidentifier = NULL,
    @metadata_type38 tinyint = NULL,
    @generation38 bigint = NULL,
    @lineage_old38 varbinary(311) = NULL,
    @lineage_new38 varbinary(311) = NULL,
    @rowguid39 uniqueidentifier = NULL,
    @metadata_type39 tinyint = NULL,
    @generation39 bigint = NULL,
    @lineage_old39 varbinary(311) = NULL,
    @lineage_new39 varbinary(311) = NULL,
    @rowguid40 uniqueidentifier = NULL,
    @metadata_type40 tinyint = NULL,
    @generation40 bigint = NULL,
    @lineage_old40 varbinary(311) = NULL,
    @lineage_new40 varbinary(311) = NULL ,
    @rowguid41 uniqueidentifier = NULL,
    @metadata_type41 tinyint = NULL,
    @generation41 bigint = NULL,
    @lineage_old41 varbinary(311) = NULL,
    @lineage_new41 varbinary(311) = NULL,
    @rowguid42 uniqueidentifier = NULL,
    @metadata_type42 tinyint = NULL,
    @generation42 bigint = NULL,
    @lineage_old42 varbinary(311) = NULL,
    @lineage_new42 varbinary(311) = NULL,
    @rowguid43 uniqueidentifier = NULL,
    @metadata_type43 tinyint = NULL,
    @generation43 bigint = NULL,
    @lineage_old43 varbinary(311) = NULL,
    @lineage_new43 varbinary(311) = NULL,
    @rowguid44 uniqueidentifier = NULL,
    @metadata_type44 tinyint = NULL,
    @generation44 bigint = NULL,
    @lineage_old44 varbinary(311) = NULL,
    @lineage_new44 varbinary(311) = NULL,
    @rowguid45 uniqueidentifier = NULL,
    @metadata_type45 tinyint = NULL,
    @generation45 bigint = NULL,
    @lineage_old45 varbinary(311) = NULL,
    @lineage_new45 varbinary(311) = NULL,
    @rowguid46 uniqueidentifier = NULL,
    @metadata_type46 tinyint = NULL,
    @generation46 bigint = NULL,
    @lineage_old46 varbinary(311) = NULL,
    @lineage_new46 varbinary(311) = NULL,
    @rowguid47 uniqueidentifier = NULL,
    @metadata_type47 tinyint = NULL,
    @generation47 bigint = NULL,
    @lineage_old47 varbinary(311) = NULL,
    @lineage_new47 varbinary(311) = NULL,
    @rowguid48 uniqueidentifier = NULL,
    @metadata_type48 tinyint = NULL,
    @generation48 bigint = NULL,
    @lineage_old48 varbinary(311) = NULL,
    @lineage_new48 varbinary(311) = NULL,
    @rowguid49 uniqueidentifier = NULL,
    @metadata_type49 tinyint = NULL,
    @generation49 bigint = NULL,
    @lineage_old49 varbinary(311) = NULL,
    @lineage_new49 varbinary(311) = NULL,
    @rowguid50 uniqueidentifier = NULL,
    @metadata_type50 tinyint = NULL,
    @generation50 bigint = NULL,
    @lineage_old50 varbinary(311) = NULL,
    @lineage_new50 varbinary(311) = NULL ,
    @rowguid51 uniqueidentifier = NULL,
    @metadata_type51 tinyint = NULL,
    @generation51 bigint = NULL,
    @lineage_old51 varbinary(311) = NULL,
    @lineage_new51 varbinary(311) = NULL,
    @rowguid52 uniqueidentifier = NULL,
    @metadata_type52 tinyint = NULL,
    @generation52 bigint = NULL,
    @lineage_old52 varbinary(311) = NULL,
    @lineage_new52 varbinary(311) = NULL,
    @rowguid53 uniqueidentifier = NULL,
    @metadata_type53 tinyint = NULL,
    @generation53 bigint = NULL,
    @lineage_old53 varbinary(311) = NULL,
    @lineage_new53 varbinary(311) = NULL,
    @rowguid54 uniqueidentifier = NULL,
    @metadata_type54 tinyint = NULL,
    @generation54 bigint = NULL,
    @lineage_old54 varbinary(311) = NULL,
    @lineage_new54 varbinary(311) = NULL,
    @rowguid55 uniqueidentifier = NULL,
    @metadata_type55 tinyint = NULL,
    @generation55 bigint = NULL,
    @lineage_old55 varbinary(311) = NULL,
    @lineage_new55 varbinary(311) = NULL,
    @rowguid56 uniqueidentifier = NULL,
    @metadata_type56 tinyint = NULL,
    @generation56 bigint = NULL,
    @lineage_old56 varbinary(311) = NULL,
    @lineage_new56 varbinary(311) = NULL,
    @rowguid57 uniqueidentifier = NULL,
    @metadata_type57 tinyint = NULL,
    @generation57 bigint = NULL,
    @lineage_old57 varbinary(311) = NULL,
    @lineage_new57 varbinary(311) = NULL,
    @rowguid58 uniqueidentifier = NULL,
    @metadata_type58 tinyint = NULL,
    @generation58 bigint = NULL,
    @lineage_old58 varbinary(311) = NULL,
    @lineage_new58 varbinary(311) = NULL,
    @rowguid59 uniqueidentifier = NULL,
    @metadata_type59 tinyint = NULL,
    @generation59 bigint = NULL,
    @lineage_old59 varbinary(311) = NULL,
    @lineage_new59 varbinary(311) = NULL,
    @rowguid60 uniqueidentifier = NULL,
    @metadata_type60 tinyint = NULL,
    @generation60 bigint = NULL,
    @lineage_old60 varbinary(311) = NULL,
    @lineage_new60 varbinary(311) = NULL ,
    @rowguid61 uniqueidentifier = NULL,
    @metadata_type61 tinyint = NULL,
    @generation61 bigint = NULL,
    @lineage_old61 varbinary(311) = NULL,
    @lineage_new61 varbinary(311) = NULL,
    @rowguid62 uniqueidentifier = NULL,
    @metadata_type62 tinyint = NULL,
    @generation62 bigint = NULL,
    @lineage_old62 varbinary(311) = NULL,
    @lineage_new62 varbinary(311) = NULL,
    @rowguid63 uniqueidentifier = NULL,
    @metadata_type63 tinyint = NULL,
    @generation63 bigint = NULL,
    @lineage_old63 varbinary(311) = NULL,
    @lineage_new63 varbinary(311) = NULL,
    @rowguid64 uniqueidentifier = NULL,
    @metadata_type64 tinyint = NULL,
    @generation64 bigint = NULL,
    @lineage_old64 varbinary(311) = NULL,
    @lineage_new64 varbinary(311) = NULL,
    @rowguid65 uniqueidentifier = NULL,
    @metadata_type65 tinyint = NULL,
    @generation65 bigint = NULL,
    @lineage_old65 varbinary(311) = NULL,
    @lineage_new65 varbinary(311) = NULL,
    @rowguid66 uniqueidentifier = NULL,
    @metadata_type66 tinyint = NULL,
    @generation66 bigint = NULL,
    @lineage_old66 varbinary(311) = NULL,
    @lineage_new66 varbinary(311) = NULL,
    @rowguid67 uniqueidentifier = NULL,
    @metadata_type67 tinyint = NULL,
    @generation67 bigint = NULL,
    @lineage_old67 varbinary(311) = NULL,
    @lineage_new67 varbinary(311) = NULL,
    @rowguid68 uniqueidentifier = NULL,
    @metadata_type68 tinyint = NULL,
    @generation68 bigint = NULL,
    @lineage_old68 varbinary(311) = NULL,
    @lineage_new68 varbinary(311) = NULL,
    @rowguid69 uniqueidentifier = NULL,
    @metadata_type69 tinyint = NULL,
    @generation69 bigint = NULL,
    @lineage_old69 varbinary(311) = NULL,
    @lineage_new69 varbinary(311) = NULL,
    @rowguid70 uniqueidentifier = NULL,
    @metadata_type70 tinyint = NULL,
    @generation70 bigint = NULL,
    @lineage_old70 varbinary(311) = NULL,
    @lineage_new70 varbinary(311) = NULL ,
    @rowguid71 uniqueidentifier = NULL,
    @metadata_type71 tinyint = NULL,
    @generation71 bigint = NULL,
    @lineage_old71 varbinary(311) = NULL,
    @lineage_new71 varbinary(311) = NULL,
    @rowguid72 uniqueidentifier = NULL,
    @metadata_type72 tinyint = NULL,
    @generation72 bigint = NULL,
    @lineage_old72 varbinary(311) = NULL,
    @lineage_new72 varbinary(311) = NULL,
    @rowguid73 uniqueidentifier = NULL,
    @metadata_type73 tinyint = NULL,
    @generation73 bigint = NULL,
    @lineage_old73 varbinary(311) = NULL,
    @lineage_new73 varbinary(311) = NULL,
    @rowguid74 uniqueidentifier = NULL,
    @metadata_type74 tinyint = NULL,
    @generation74 bigint = NULL,
    @lineage_old74 varbinary(311) = NULL,
    @lineage_new74 varbinary(311) = NULL,
    @rowguid75 uniqueidentifier = NULL,
    @metadata_type75 tinyint = NULL,
    @generation75 bigint = NULL,
    @lineage_old75 varbinary(311) = NULL,
    @lineage_new75 varbinary(311) = NULL,
    @rowguid76 uniqueidentifier = NULL,
    @metadata_type76 tinyint = NULL,
    @generation76 bigint = NULL,
    @lineage_old76 varbinary(311) = NULL,
    @lineage_new76 varbinary(311) = NULL,
    @rowguid77 uniqueidentifier = NULL,
    @metadata_type77 tinyint = NULL,
    @generation77 bigint = NULL,
    @lineage_old77 varbinary(311) = NULL,
    @lineage_new77 varbinary(311) = NULL,
    @rowguid78 uniqueidentifier = NULL,
    @metadata_type78 tinyint = NULL,
    @generation78 bigint = NULL,
    @lineage_old78 varbinary(311) = NULL,
    @lineage_new78 varbinary(311) = NULL,
    @rowguid79 uniqueidentifier = NULL,
    @metadata_type79 tinyint = NULL,
    @generation79 bigint = NULL,
    @lineage_old79 varbinary(311) = NULL,
    @lineage_new79 varbinary(311) = NULL,
    @rowguid80 uniqueidentifier = NULL,
    @metadata_type80 tinyint = NULL,
    @generation80 bigint = NULL,
    @lineage_old80 varbinary(311) = NULL,
    @lineage_new80 varbinary(311) = NULL ,
    @rowguid81 uniqueidentifier = NULL,
    @metadata_type81 tinyint = NULL,
    @generation81 bigint = NULL,
    @lineage_old81 varbinary(311) = NULL,
    @lineage_new81 varbinary(311) = NULL,
    @rowguid82 uniqueidentifier = NULL,
    @metadata_type82 tinyint = NULL,
    @generation82 bigint = NULL,
    @lineage_old82 varbinary(311) = NULL,
    @lineage_new82 varbinary(311) = NULL,
    @rowguid83 uniqueidentifier = NULL,
    @metadata_type83 tinyint = NULL,
    @generation83 bigint = NULL,
    @lineage_old83 varbinary(311) = NULL,
    @lineage_new83 varbinary(311) = NULL,
    @rowguid84 uniqueidentifier = NULL,
    @metadata_type84 tinyint = NULL,
    @generation84 bigint = NULL,
    @lineage_old84 varbinary(311) = NULL,
    @lineage_new84 varbinary(311) = NULL,
    @rowguid85 uniqueidentifier = NULL,
    @metadata_type85 tinyint = NULL,
    @generation85 bigint = NULL,
    @lineage_old85 varbinary(311) = NULL,
    @lineage_new85 varbinary(311) = NULL,
    @rowguid86 uniqueidentifier = NULL,
    @metadata_type86 tinyint = NULL,
    @generation86 bigint = NULL,
    @lineage_old86 varbinary(311) = NULL,
    @lineage_new86 varbinary(311) = NULL,
    @rowguid87 uniqueidentifier = NULL,
    @metadata_type87 tinyint = NULL,
    @generation87 bigint = NULL,
    @lineage_old87 varbinary(311) = NULL,
    @lineage_new87 varbinary(311) = NULL,
    @rowguid88 uniqueidentifier = NULL,
    @metadata_type88 tinyint = NULL,
    @generation88 bigint = NULL,
    @lineage_old88 varbinary(311) = NULL,
    @lineage_new88 varbinary(311) = NULL,
    @rowguid89 uniqueidentifier = NULL,
    @metadata_type89 tinyint = NULL,
    @generation89 bigint = NULL,
    @lineage_old89 varbinary(311) = NULL,
    @lineage_new89 varbinary(311) = NULL,
    @rowguid90 uniqueidentifier = NULL,
    @metadata_type90 tinyint = NULL,
    @generation90 bigint = NULL,
    @lineage_old90 varbinary(311) = NULL,
    @lineage_new90 varbinary(311) = NULL ,
    @rowguid91 uniqueidentifier = NULL,
    @metadata_type91 tinyint = NULL,
    @generation91 bigint = NULL,
    @lineage_old91 varbinary(311) = NULL,
    @lineage_new91 varbinary(311) = NULL,
    @rowguid92 uniqueidentifier = NULL,
    @metadata_type92 tinyint = NULL,
    @generation92 bigint = NULL,
    @lineage_old92 varbinary(311) = NULL,
    @lineage_new92 varbinary(311) = NULL,
    @rowguid93 uniqueidentifier = NULL,
    @metadata_type93 tinyint = NULL,
    @generation93 bigint = NULL,
    @lineage_old93 varbinary(311) = NULL,
    @lineage_new93 varbinary(311) = NULL,
    @rowguid94 uniqueidentifier = NULL,
    @metadata_type94 tinyint = NULL,
    @generation94 bigint = NULL,
    @lineage_old94 varbinary(311) = NULL,
    @lineage_new94 varbinary(311) = NULL,
    @rowguid95 uniqueidentifier = NULL,
    @metadata_type95 tinyint = NULL,
    @generation95 bigint = NULL,
    @lineage_old95 varbinary(311) = NULL,
    @lineage_new95 varbinary(311) = NULL,
    @rowguid96 uniqueidentifier = NULL,
    @metadata_type96 tinyint = NULL,
    @generation96 bigint = NULL,
    @lineage_old96 varbinary(311) = NULL,
    @lineage_new96 varbinary(311) = NULL,
    @rowguid97 uniqueidentifier = NULL,
    @metadata_type97 tinyint = NULL,
    @generation97 bigint = NULL,
    @lineage_old97 varbinary(311) = NULL,
    @lineage_new97 varbinary(311) = NULL,
    @rowguid98 uniqueidentifier = NULL,
    @metadata_type98 tinyint = NULL,
    @generation98 bigint = NULL,
    @lineage_old98 varbinary(311) = NULL,
    @lineage_new98 varbinary(311) = NULL,
    @rowguid99 uniqueidentifier = NULL,
    @metadata_type99 tinyint = NULL,
    @generation99 bigint = NULL,
    @lineage_old99 varbinary(311) = NULL,
    @lineage_new99 varbinary(311) = NULL,
    @rowguid100 uniqueidentifier = NULL,
    @metadata_type100 tinyint = NULL,
    @generation100 bigint = NULL,
    @lineage_old100 varbinary(311) = NULL,
    @lineage_new100 varbinary(311) = NULL 
)
as
begin
 
    -- this proc returns 0 to indicate error and 1 to indicate success
    declare @retcode    int
    set nocount on
    declare @rows_deleted int
    declare @rows_remaining int
    declare @error int
    declare @tomb_rows_updated int
    declare @publication_number smallint
    declare @rows_in_syncview int
        
    if ({ fn ISPALUSER('088C2847-4D1D-4D57-8FED-3D0B087A6766') } <> 1)
    begin       
        RAISERROR (14126, 11, -1)
        return 0
    end
    
    select @publication_number = 1

    if @rowstobedeleted is NULL or @rowstobedeleted <= 0
        return 0

    begin tran
    save tran batchdeleteproc
 
    delete [dbo].[OADUser] with (rowlock)
    from 
    ( 
    select @rowguid1 as rowguid, @metadata_type1 as metadata_type, @lineage_old1 as lineage_old, @lineage_new1 as lineage_new, @generation1 as generation  union all 
    select @rowguid2 as rowguid, @metadata_type2 as metadata_type, @lineage_old2 as lineage_old, @lineage_new2 as lineage_new, @generation2 as generation  union all 
    select @rowguid3 as rowguid, @metadata_type3 as metadata_type, @lineage_old3 as lineage_old, @lineage_new3 as lineage_new, @generation3 as generation  union all 
    select @rowguid4 as rowguid, @metadata_type4 as metadata_type, @lineage_old4 as lineage_old, @lineage_new4 as lineage_new, @generation4 as generation  union all 
    select @rowguid5 as rowguid, @metadata_type5 as metadata_type, @lineage_old5 as lineage_old, @lineage_new5 as lineage_new, @generation5 as generation  union all 
    select @rowguid6 as rowguid, @metadata_type6 as metadata_type, @lineage_old6 as lineage_old, @lineage_new6 as lineage_new, @generation6 as generation  union all 
    select @rowguid7 as rowguid, @metadata_type7 as metadata_type, @lineage_old7 as lineage_old, @lineage_new7 as lineage_new, @generation7 as generation  union all 
    select @rowguid8 as rowguid, @metadata_type8 as metadata_type, @lineage_old8 as lineage_old, @lineage_new8 as lineage_new, @generation8 as generation  union all 
    select @rowguid9 as rowguid, @metadata_type9 as metadata_type, @lineage_old9 as lineage_old, @lineage_new9 as lineage_new, @generation9 as generation  union all 
    select @rowguid10 as rowguid, @metadata_type10 as metadata_type, @lineage_old10 as lineage_old, @lineage_new10 as lineage_new, @generation10 as generation   union all 
    select @rowguid11 as rowguid, @metadata_type11 as metadata_type, @lineage_old11 as lineage_old, @lineage_new11 as lineage_new, @generation11 as generation  union all 
    select @rowguid12 as rowguid, @metadata_type12 as metadata_type, @lineage_old12 as lineage_old, @lineage_new12 as lineage_new, @generation12 as generation  union all 
    select @rowguid13 as rowguid, @metadata_type13 as metadata_type, @lineage_old13 as lineage_old, @lineage_new13 as lineage_new, @generation13 as generation  union all 
    select @rowguid14 as rowguid, @metadata_type14 as metadata_type, @lineage_old14 as lineage_old, @lineage_new14 as lineage_new, @generation14 as generation  union all 
    select @rowguid15 as rowguid, @metadata_type15 as metadata_type, @lineage_old15 as lineage_old, @lineage_new15 as lineage_new, @generation15 as generation  union all 
    select @rowguid16 as rowguid, @metadata_type16 as metadata_type, @lineage_old16 as lineage_old, @lineage_new16 as lineage_new, @generation16 as generation  union all 
    select @rowguid17 as rowguid, @metadata_type17 as metadata_type, @lineage_old17 as lineage_old, @lineage_new17 as lineage_new, @generation17 as generation  union all 
    select @rowguid18 as rowguid, @metadata_type18 as metadata_type, @lineage_old18 as lineage_old, @lineage_new18 as lineage_new, @generation18 as generation  union all 
    select @rowguid19 as rowguid, @metadata_type19 as metadata_type, @lineage_old19 as lineage_old, @lineage_new19 as lineage_new, @generation19 as generation  union all 
    select @rowguid20 as rowguid, @metadata_type20 as metadata_type, @lineage_old20 as lineage_old, @lineage_new20 as lineage_new, @generation20 as generation   union all 
    select @rowguid21 as rowguid, @metadata_type21 as metadata_type, @lineage_old21 as lineage_old, @lineage_new21 as lineage_new, @generation21 as generation  union all 
    select @rowguid22 as rowguid, @metadata_type22 as metadata_type, @lineage_old22 as lineage_old, @lineage_new22 as lineage_new, @generation22 as generation  union all 
    select @rowguid23 as rowguid, @metadata_type23 as metadata_type, @lineage_old23 as lineage_old, @lineage_new23 as lineage_new, @generation23 as generation  union all 
    select @rowguid24 as rowguid, @metadata_type24 as metadata_type, @lineage_old24 as lineage_old, @lineage_new24 as lineage_new, @generation24 as generation  union all 
    select @rowguid25 as rowguid, @metadata_type25 as metadata_type, @lineage_old25 as lineage_old, @lineage_new25 as lineage_new, @generation25 as generation  union all 
    select @rowguid26 as rowguid, @metadata_type26 as metadata_type, @lineage_old26 as lineage_old, @lineage_new26 as lineage_new, @generation26 as generation  union all 
    select @rowguid27 as rowguid, @metadata_type27 as metadata_type, @lineage_old27 as lineage_old, @lineage_new27 as lineage_new, @generation27 as generation  union all 
    select @rowguid28 as rowguid, @metadata_type28 as metadata_type, @lineage_old28 as lineage_old, @lineage_new28 as lineage_new, @generation28 as generation  union all 
    select @rowguid29 as rowguid, @metadata_type29 as metadata_type, @lineage_old29 as lineage_old, @lineage_new29 as lineage_new, @generation29 as generation  union all 
    select @rowguid30 as rowguid, @metadata_type30 as metadata_type, @lineage_old30 as lineage_old, @lineage_new30 as lineage_new, @generation30 as generation   union all 
    select @rowguid31 as rowguid, @metadata_type31 as metadata_type, @lineage_old31 as lineage_old, @lineage_new31 as lineage_new, @generation31 as generation  union all 
    select @rowguid32 as rowguid, @metadata_type32 as metadata_type, @lineage_old32 as lineage_old, @lineage_new32 as lineage_new, @generation32 as generation  union all 
    select @rowguid33 as rowguid, @metadata_type33 as metadata_type, @lineage_old33 as lineage_old, @lineage_new33 as lineage_new, @generation33 as generation  union all 
    select @rowguid34 as rowguid, @metadata_type34 as metadata_type, @lineage_old34 as lineage_old, @lineage_new34 as lineage_new, @generation34 as generation  union all 
    select @rowguid35 as rowguid, @metadata_type35 as metadata_type, @lineage_old35 as lineage_old, @lineage_new35 as lineage_new, @generation35 as generation  union all 
    select @rowguid36 as rowguid, @metadata_type36 as metadata_type, @lineage_old36 as lineage_old, @lineage_new36 as lineage_new, @generation36 as generation  union all 
    select @rowguid37 as rowguid, @metadata_type37 as metadata_type, @lineage_old37 as lineage_old, @lineage_new37 as lineage_new, @generation37 as generation  union all 
    select @rowguid38 as rowguid, @metadata_type38 as metadata_type, @lineage_old38 as lineage_old, @lineage_new38 as lineage_new, @generation38 as generation  union all 
    select @rowguid39 as rowguid, @metadata_type39 as metadata_type, @lineage_old39 as lineage_old, @lineage_new39 as lineage_new, @generation39 as generation  union all 
    select @rowguid40 as rowguid, @metadata_type40 as metadata_type, @lineage_old40 as lineage_old, @lineage_new40 as lineage_new, @generation40 as generation   union all 
    select @rowguid41 as rowguid, @metadata_type41 as metadata_type, @lineage_old41 as lineage_old, @lineage_new41 as lineage_new, @generation41 as generation  union all 
    select @rowguid42 as rowguid, @metadata_type42 as metadata_type, @lineage_old42 as lineage_old, @lineage_new42 as lineage_new, @generation42 as generation  union all 
    select @rowguid43 as rowguid, @metadata_type43 as metadata_type, @lineage_old43 as lineage_old, @lineage_new43 as lineage_new, @generation43 as generation  union all 
    select @rowguid44 as rowguid, @metadata_type44 as metadata_type, @lineage_old44 as lineage_old, @lineage_new44 as lineage_new, @generation44 as generation  union all 
    select @rowguid45 as rowguid, @metadata_type45 as metadata_type, @lineage_old45 as lineage_old, @lineage_new45 as lineage_new, @generation45 as generation  union all 
    select @rowguid46 as rowguid, @metadata_type46 as metadata_type, @lineage_old46 as lineage_old, @lineage_new46 as lineage_new, @generation46 as generation  union all 
    select @rowguid47 as rowguid, @metadata_type47 as metadata_type, @lineage_old47 as lineage_old, @lineage_new47 as lineage_new, @generation47 as generation  union all 
    select @rowguid48 as rowguid, @metadata_type48 as metadata_type, @lineage_old48 as lineage_old, @lineage_new48 as lineage_new, @generation48 as generation  union all 
    select @rowguid49 as rowguid, @metadata_type49 as metadata_type, @lineage_old49 as lineage_old, @lineage_new49 as lineage_new, @generation49 as generation  union all 
    select @rowguid50 as rowguid, @metadata_type50 as metadata_type, @lineage_old50 as lineage_old, @lineage_new50 as lineage_new, @generation50 as generation   union all 
    select @rowguid51 as rowguid, @metadata_type51 as metadata_type, @lineage_old51 as lineage_old, @lineage_new51 as lineage_new, @generation51 as generation  union all 
    select @rowguid52 as rowguid, @metadata_type52 as metadata_type, @lineage_old52 as lineage_old, @lineage_new52 as lineage_new, @generation52 as generation  union all 
    select @rowguid53 as rowguid, @metadata_type53 as metadata_type, @lineage_old53 as lineage_old, @lineage_new53 as lineage_new, @generation53 as generation  union all 
    select @rowguid54 as rowguid, @metadata_type54 as metadata_type, @lineage_old54 as lineage_old, @lineage_new54 as lineage_new, @generation54 as generation  union all 
    select @rowguid55 as rowguid, @metadata_type55 as metadata_type, @lineage_old55 as lineage_old, @lineage_new55 as lineage_new, @generation55 as generation  union all 
    select @rowguid56 as rowguid, @metadata_type56 as metadata_type, @lineage_old56 as lineage_old, @lineage_new56 as lineage_new, @generation56 as generation  union all 
    select @rowguid57 as rowguid, @metadata_type57 as metadata_type, @lineage_old57 as lineage_old, @lineage_new57 as lineage_new, @generation57 as generation  union all 
    select @rowguid58 as rowguid, @metadata_type58 as metadata_type, @lineage_old58 as lineage_old, @lineage_new58 as lineage_new, @generation58 as generation  union all 
    select @rowguid59 as rowguid, @metadata_type59 as metadata_type, @lineage_old59 as lineage_old, @lineage_new59 as lineage_new, @generation59 as generation  union all 
    select @rowguid60 as rowguid, @metadata_type60 as metadata_type, @lineage_old60 as lineage_old, @lineage_new60 as lineage_new, @generation60 as generation   union all 
    select @rowguid61 as rowguid, @metadata_type61 as metadata_type, @lineage_old61 as lineage_old, @lineage_new61 as lineage_new, @generation61 as generation  union all 
    select @rowguid62 as rowguid, @metadata_type62 as metadata_type, @lineage_old62 as lineage_old, @lineage_new62 as lineage_new, @generation62 as generation  union all 
    select @rowguid63 as rowguid, @metadata_type63 as metadata_type, @lineage_old63 as lineage_old, @lineage_new63 as lineage_new, @generation63 as generation  union all 
    select @rowguid64 as rowguid, @metadata_type64 as metadata_type, @lineage_old64 as lineage_old, @lineage_new64 as lineage_new, @generation64 as generation  union all 
    select @rowguid65 as rowguid, @metadata_type65 as metadata_type, @lineage_old65 as lineage_old, @lineage_new65 as lineage_new, @generation65 as generation  union all 
    select @rowguid66 as rowguid, @metadata_type66 as metadata_type, @lineage_old66 as lineage_old, @lineage_new66 as lineage_new, @generation66 as generation  union all 
    select @rowguid67 as rowguid, @metadata_type67 as metadata_type, @lineage_old67 as lineage_old, @lineage_new67 as lineage_new, @generation67 as generation  union all 
    select @rowguid68 as rowguid, @metadata_type68 as metadata_type, @lineage_old68 as lineage_old, @lineage_new68 as lineage_new, @generation68 as generation  union all 
    select @rowguid69 as rowguid, @metadata_type69 as metadata_type, @lineage_old69 as lineage_old, @lineage_new69 as lineage_new, @generation69 as generation  union all 
    select @rowguid70 as rowguid, @metadata_type70 as metadata_type, @lineage_old70 as lineage_old, @lineage_new70 as lineage_new, @generation70 as generation   union all 
    select @rowguid71 as rowguid, @metadata_type71 as metadata_type, @lineage_old71 as lineage_old, @lineage_new71 as lineage_new, @generation71 as generation  union all 
    select @rowguid72 as rowguid, @metadata_type72 as metadata_type, @lineage_old72 as lineage_old, @lineage_new72 as lineage_new, @generation72 as generation  union all 
    select @rowguid73 as rowguid, @metadata_type73 as metadata_type, @lineage_old73 as lineage_old, @lineage_new73 as lineage_new, @generation73 as generation  union all 
    select @rowguid74 as rowguid, @metadata_type74 as metadata_type, @lineage_old74 as lineage_old, @lineage_new74 as lineage_new, @generation74 as generation  union all 
    select @rowguid75 as rowguid, @metadata_type75 as metadata_type, @lineage_old75 as lineage_old, @lineage_new75 as lineage_new, @generation75 as generation  union all 
    select @rowguid76 as rowguid, @metadata_type76 as metadata_type, @lineage_old76 as lineage_old, @lineage_new76 as lineage_new, @generation76 as generation  union all 
    select @rowguid77 as rowguid, @metadata_type77 as metadata_type, @lineage_old77 as lineage_old, @lineage_new77 as lineage_new, @generation77 as generation  union all 
    select @rowguid78 as rowguid, @metadata_type78 as metadata_type, @lineage_old78 as lineage_old, @lineage_new78 as lineage_new, @generation78 as generation  union all 
    select @rowguid79 as rowguid, @metadata_type79 as metadata_type, @lineage_old79 as lineage_old, @lineage_new79 as lineage_new, @generation79 as generation  union all 
    select @rowguid80 as rowguid, @metadata_type80 as metadata_type, @lineage_old80 as lineage_old, @lineage_new80 as lineage_new, @generation80 as generation   union all 
    select @rowguid81 as rowguid, @metadata_type81 as metadata_type, @lineage_old81 as lineage_old, @lineage_new81 as lineage_new, @generation81 as generation  union all 
    select @rowguid82 as rowguid, @metadata_type82 as metadata_type, @lineage_old82 as lineage_old, @lineage_new82 as lineage_new, @generation82 as generation  union all 
    select @rowguid83 as rowguid, @metadata_type83 as metadata_type, @lineage_old83 as lineage_old, @lineage_new83 as lineage_new, @generation83 as generation  union all 
    select @rowguid84 as rowguid, @metadata_type84 as metadata_type, @lineage_old84 as lineage_old, @lineage_new84 as lineage_new, @generation84 as generation  union all 
    select @rowguid85 as rowguid, @metadata_type85 as metadata_type, @lineage_old85 as lineage_old, @lineage_new85 as lineage_new, @generation85 as generation  union all 
    select @rowguid86 as rowguid, @metadata_type86 as metadata_type, @lineage_old86 as lineage_old, @lineage_new86 as lineage_new, @generation86 as generation  union all 
    select @rowguid87 as rowguid, @metadata_type87 as metadata_type, @lineage_old87 as lineage_old, @lineage_new87 as lineage_new, @generation87 as generation  union all 
    select @rowguid88 as rowguid, @metadata_type88 as metadata_type, @lineage_old88 as lineage_old, @lineage_new88 as lineage_new, @generation88 as generation  union all 
    select @rowguid89 as rowguid, @metadata_type89 as metadata_type, @lineage_old89 as lineage_old, @lineage_new89 as lineage_new, @generation89 as generation  union all 
    select @rowguid90 as rowguid, @metadata_type90 as metadata_type, @lineage_old90 as lineage_old, @lineage_new90 as lineage_new, @generation90 as generation   union all 
    select @rowguid91 as rowguid, @metadata_type91 as metadata_type, @lineage_old91 as lineage_old, @lineage_new91 as lineage_new, @generation91 as generation  union all 
    select @rowguid92 as rowguid, @metadata_type92 as metadata_type, @lineage_old92 as lineage_old, @lineage_new92 as lineage_new, @generation92 as generation  union all 
    select @rowguid93 as rowguid, @metadata_type93 as metadata_type, @lineage_old93 as lineage_old, @lineage_new93 as lineage_new, @generation93 as generation  union all 
    select @rowguid94 as rowguid, @metadata_type94 as metadata_type, @lineage_old94 as lineage_old, @lineage_new94 as lineage_new, @generation94 as generation  union all 
    select @rowguid95 as rowguid, @metadata_type95 as metadata_type, @lineage_old95 as lineage_old, @lineage_new95 as lineage_new, @generation95 as generation  union all 
    select @rowguid96 as rowguid, @metadata_type96 as metadata_type, @lineage_old96 as lineage_old, @lineage_new96 as lineage_new, @generation96 as generation  union all 
    select @rowguid97 as rowguid, @metadata_type97 as metadata_type, @lineage_old97 as lineage_old, @lineage_new97 as lineage_new, @generation97 as generation  union all 
    select @rowguid98 as rowguid, @metadata_type98 as metadata_type, @lineage_old98 as lineage_old, @lineage_new98 as lineage_new, @generation98 as generation  union all 
    select @rowguid99 as rowguid, @metadata_type99 as metadata_type, @lineage_old99 as lineage_old, @lineage_new99 as lineage_new, @generation99 as generation  union all 
    select @rowguid100 as rowguid, @metadata_type100 as metadata_type, @lineage_old100 as lineage_old, @lineage_new100 as lineage_new, @generation100 as generation  ) as rows
    inner join [dbo].[OADUser] t with (rowlock) on rows.rowguid = t.[REPLID] and rows.rowguid is not NULL 
    left outer join dbo.MSmerge_contents cont with (rowlock) 
    on rows.rowguid = cont.rowguid and cont.tablenick = 21696010 
    and rows.rowguid is not NULL
    where ((rows.metadata_type = 3 and cont.rowguid is NULL) or
           ((rows.metadata_type = 5 or  rows.metadata_type = 6) and (cont.rowguid is NULL or cont.lineage = rows.lineage_old)) or
           (cont.rowguid is not NULL and cont.lineage = rows.lineage_old))
           and rows.rowguid is not NULL  
    select @rows_deleted = @@rowcount, @error = @@error
    if @error<>0
        goto Failure
    if @rows_deleted > @rowstobedeleted
    begin
        -- this is just not possible
        raiserror(20684, 16, -1, '[dbo].[OADUser]')
        goto Failure
    end
    if @rows_deleted <> @rowstobedeleted
    begin 
        -- we will now check if any of the rows we wanted to delete were not deleted. If the rows were not deleted
        -- by the previous delete because it was already deleted, we will still assume that this is a success
        select @rows_remaining = count(*) from 
        (  
         select @rowguid1 as rowguid union all 
         select @rowguid2 as rowguid union all 
         select @rowguid3 as rowguid union all 
         select @rowguid4 as rowguid union all 
         select @rowguid5 as rowguid union all 
         select @rowguid6 as rowguid union all 
         select @rowguid7 as rowguid union all 
         select @rowguid8 as rowguid union all 
         select @rowguid9 as rowguid union all 
         select @rowguid10 as rowguid union all 
         select @rowguid11 as rowguid union all 
         select @rowguid12 as rowguid union all 
         select @rowguid13 as rowguid union all 
         select @rowguid14 as rowguid union all 
         select @rowguid15 as rowguid union all 
         select @rowguid16 as rowguid union all 
         select @rowguid17 as rowguid union all 
         select @rowguid18 as rowguid union all 
         select @rowguid19 as rowguid union all 
         select @rowguid20 as rowguid union all 
         select @rowguid21 as rowguid union all 
         select @rowguid22 as rowguid union all 
         select @rowguid23 as rowguid union all 
         select @rowguid24 as rowguid union all 
         select @rowguid25 as rowguid union all 
         select @rowguid26 as rowguid union all 
         select @rowguid27 as rowguid union all 
         select @rowguid28 as rowguid union all 
         select @rowguid29 as rowguid union all 
         select @rowguid30 as rowguid union all 
         select @rowguid31 as rowguid union all 
         select @rowguid32 as rowguid union all 
         select @rowguid33 as rowguid union all 
         select @rowguid34 as rowguid union all 
         select @rowguid35 as rowguid union all 
         select @rowguid36 as rowguid union all 
         select @rowguid37 as rowguid union all 
         select @rowguid38 as rowguid union all 
         select @rowguid39 as rowguid union all 
         select @rowguid40 as rowguid union all 
         select @rowguid41 as rowguid union all 
         select @rowguid42 as rowguid union all 
         select @rowguid43 as rowguid union all 
         select @rowguid44 as rowguid union all 
         select @rowguid45 as rowguid union all 
         select @rowguid46 as rowguid union all 
         select @rowguid47 as rowguid union all 
         select @rowguid48 as rowguid union all 
         select @rowguid49 as rowguid union all 
         select @rowguid50 as rowguid union all 
         select @rowguid51 as rowguid union all 
         select @rowguid52 as rowguid union all 
         select @rowguid53 as rowguid union all 
         select @rowguid54 as rowguid union all 
         select @rowguid55 as rowguid union all 
         select @rowguid56 as rowguid union all 
         select @rowguid57 as rowguid union all 
         select @rowguid58 as rowguid union all 
         select @rowguid59 as rowguid union all 
         select @rowguid60 as rowguid union all 
         select @rowguid61 as rowguid union all 
         select @rowguid62 as rowguid union all 
         select @rowguid63 as rowguid union all 
         select @rowguid64 as rowguid union all 
         select @rowguid65 as rowguid union all 
         select @rowguid66 as rowguid union all 
         select @rowguid67 as rowguid union all 
         select @rowguid68 as rowguid union all 
         select @rowguid69 as rowguid union all 
         select @rowguid70 as rowguid union all 
         select @rowguid71 as rowguid union all 
         select @rowguid72 as rowguid union all 
         select @rowguid73 as rowguid union all 
         select @rowguid74 as rowguid union all 
         select @rowguid75 as rowguid union all 
         select @rowguid76 as rowguid union all 
         select @rowguid77 as rowguid union all 
         select @rowguid78 as rowguid union all 
         select @rowguid79 as rowguid union all 
         select @rowguid80 as rowguid union all 
         select @rowguid81 as rowguid union all 
         select @rowguid82 as rowguid union all 
         select @rowguid83 as rowguid union all 
         select @rowguid84 as rowguid union all 
         select @rowguid85 as rowguid union all 
         select @rowguid86 as rowguid union all 
         select @rowguid87 as rowguid union all 
         select @rowguid88 as rowguid union all 
         select @rowguid89 as rowguid union all 
         select @rowguid90 as rowguid union all 
         select @rowguid91 as rowguid union all 
         select @rowguid92 as rowguid union all 
         select @rowguid93 as rowguid union all 
         select @rowguid94 as rowguid union all 
         select @rowguid95 as rowguid union all 
         select @rowguid96 as rowguid union all 
         select @rowguid97 as rowguid union all 
         select @rowguid98 as rowguid union all 
         select @rowguid99 as rowguid union all 
         select @rowguid100 as rowguid 
        ) as rows
        inner join [dbo].[OADUser] t with (rowlock) 
        on t.[REPLID] = rows.rowguid
        and rows.rowguid is not NULL
        
        if @@error <> 0
            goto Failure
        
        if @rows_remaining <> 0
        begin
            -- failed deleting one or more rows. Could be because of metadata mismatch
            --raiserror(20682, 10, -1, @rows_remaining, '[dbo].[OADUser]')
            goto Failure
        end        
    end 
    -- if we get here it means that all the rows that we intend to delete were either deleted by us
    -- or they were already deleted by someone else and do not exist in the user table
    -- we insert a tombstone entry for the rows we have deleted and delete the contents rows if exists

    -- if the rows were previously deleted we still want to update the metadatatype, generation and lineage
    -- in MSmerge_tombstone. We could find rows in the following update also if the trigger got called by
    -- the user table delete and it inserted the rows into tombstone (it would have inserted with type 1)
    update dbo.MSmerge_tombstone with (rowlock)
        set type = case when (rows.metadata_type=5 or rows.metadata_type=6) then rows.metadata_type else 1 end,
            generation = rows.generation,
            lineage = rows.lineage_new
    from 
    ( 
    select @rowguid1 as rowguid, @metadata_type1 as metadata_type, @lineage_old1 as lineage_old, @lineage_new1 as lineage_new, @generation1 as generation  union all 
    select @rowguid2 as rowguid, @metadata_type2 as metadata_type, @lineage_old2 as lineage_old, @lineage_new2 as lineage_new, @generation2 as generation  union all 
    select @rowguid3 as rowguid, @metadata_type3 as metadata_type, @lineage_old3 as lineage_old, @lineage_new3 as lineage_new, @generation3 as generation  union all 
    select @rowguid4 as rowguid, @metadata_type4 as metadata_type, @lineage_old4 as lineage_old, @lineage_new4 as lineage_new, @generation4 as generation  union all 
    select @rowguid5 as rowguid, @metadata_type5 as metadata_type, @lineage_old5 as lineage_old, @lineage_new5 as lineage_new, @generation5 as generation  union all 
    select @rowguid6 as rowguid, @metadata_type6 as metadata_type, @lineage_old6 as lineage_old, @lineage_new6 as lineage_new, @generation6 as generation  union all 
    select @rowguid7 as rowguid, @metadata_type7 as metadata_type, @lineage_old7 as lineage_old, @lineage_new7 as lineage_new, @generation7 as generation  union all 
    select @rowguid8 as rowguid, @metadata_type8 as metadata_type, @lineage_old8 as lineage_old, @lineage_new8 as lineage_new, @generation8 as generation  union all 
    select @rowguid9 as rowguid, @metadata_type9 as metadata_type, @lineage_old9 as lineage_old, @lineage_new9 as lineage_new, @generation9 as generation  union all 
    select @rowguid10 as rowguid, @metadata_type10 as metadata_type, @lineage_old10 as lineage_old, @lineage_new10 as lineage_new, @generation10 as generation   union all 
    select @rowguid11 as rowguid, @metadata_type11 as metadata_type, @lineage_old11 as lineage_old, @lineage_new11 as lineage_new, @generation11 as generation  union all 
    select @rowguid12 as rowguid, @metadata_type12 as metadata_type, @lineage_old12 as lineage_old, @lineage_new12 as lineage_new, @generation12 as generation  union all 
    select @rowguid13 as rowguid, @metadata_type13 as metadata_type, @lineage_old13 as lineage_old, @lineage_new13 as lineage_new, @generation13 as generation  union all 
    select @rowguid14 as rowguid, @metadata_type14 as metadata_type, @lineage_old14 as lineage_old, @lineage_new14 as lineage_new, @generation14 as generation  union all 
    select @rowguid15 as rowguid, @metadata_type15 as metadata_type, @lineage_old15 as lineage_old, @lineage_new15 as lineage_new, @generation15 as generation  union all 
    select @rowguid16 as rowguid, @metadata_type16 as metadata_type, @lineage_old16 as lineage_old, @lineage_new16 as lineage_new, @generation16 as generation  union all 
    select @rowguid17 as rowguid, @metadata_type17 as metadata_type, @lineage_old17 as lineage_old, @lineage_new17 as lineage_new, @generation17 as generation  union all 
    select @rowguid18 as rowguid, @metadata_type18 as metadata_type, @lineage_old18 as lineage_old, @lineage_new18 as lineage_new, @generation18 as generation  union all 
    select @rowguid19 as rowguid, @metadata_type19 as metadata_type, @lineage_old19 as lineage_old, @lineage_new19 as lineage_new, @generation19 as generation  union all 
    select @rowguid20 as rowguid, @metadata_type20 as metadata_type, @lineage_old20 as lineage_old, @lineage_new20 as lineage_new, @generation20 as generation   union all 
    select @rowguid21 as rowguid, @metadata_type21 as metadata_type, @lineage_old21 as lineage_old, @lineage_new21 as lineage_new, @generation21 as generation  union all 
    select @rowguid22 as rowguid, @metadata_type22 as metadata_type, @lineage_old22 as lineage_old, @lineage_new22 as lineage_new, @generation22 as generation  union all 
    select @rowguid23 as rowguid, @metadata_type23 as metadata_type, @lineage_old23 as lineage_old, @lineage_new23 as lineage_new, @generation23 as generation  union all 
    select @rowguid24 as rowguid, @metadata_type24 as metadata_type, @lineage_old24 as lineage_old, @lineage_new24 as lineage_new, @generation24 as generation  union all 
    select @rowguid25 as rowguid, @metadata_type25 as metadata_type, @lineage_old25 as lineage_old, @lineage_new25 as lineage_new, @generation25 as generation  union all 
    select @rowguid26 as rowguid, @metadata_type26 as metadata_type, @lineage_old26 as lineage_old, @lineage_new26 as lineage_new, @generation26 as generation  union all 
    select @rowguid27 as rowguid, @metadata_type27 as metadata_type, @lineage_old27 as lineage_old, @lineage_new27 as lineage_new, @generation27 as generation  union all 
    select @rowguid28 as rowguid, @metadata_type28 as metadata_type, @lineage_old28 as lineage_old, @lineage_new28 as lineage_new, @generation28 as generation  union all 
    select @rowguid29 as rowguid, @metadata_type29 as metadata_type, @lineage_old29 as lineage_old, @lineage_new29 as lineage_new, @generation29 as generation  union all 
    select @rowguid30 as rowguid, @metadata_type30 as metadata_type, @lineage_old30 as lineage_old, @lineage_new30 as lineage_new, @generation30 as generation   union all 
    select @rowguid31 as rowguid, @metadata_type31 as metadata_type, @lineage_old31 as lineage_old, @lineage_new31 as lineage_new, @generation31 as generation  union all 
    select @rowguid32 as rowguid, @metadata_type32 as metadata_type, @lineage_old32 as lineage_old, @lineage_new32 as lineage_new, @generation32 as generation  union all 
    select @rowguid33 as rowguid, @metadata_type33 as metadata_type, @lineage_old33 as lineage_old, @lineage_new33 as lineage_new, @generation33 as generation  union all 
    select @rowguid34 as rowguid, @metadata_type34 as metadata_type, @lineage_old34 as lineage_old, @lineage_new34 as lineage_new, @generation34 as generation  union all 
    select @rowguid35 as rowguid, @metadata_type35 as metadata_type, @lineage_old35 as lineage_old, @lineage_new35 as lineage_new, @generation35 as generation  union all 
    select @rowguid36 as rowguid, @metadata_type36 as metadata_type, @lineage_old36 as lineage_old, @lineage_new36 as lineage_new, @generation36 as generation  union all 
    select @rowguid37 as rowguid, @metadata_type37 as metadata_type, @lineage_old37 as lineage_old, @lineage_new37 as lineage_new, @generation37 as generation  union all 
    select @rowguid38 as rowguid, @metadata_type38 as metadata_type, @lineage_old38 as lineage_old, @lineage_new38 as lineage_new, @generation38 as generation  union all 
    select @rowguid39 as rowguid, @metadata_type39 as metadata_type, @lineage_old39 as lineage_old, @lineage_new39 as lineage_new, @generation39 as generation  union all 
    select @rowguid40 as rowguid, @metadata_type40 as metadata_type, @lineage_old40 as lineage_old, @lineage_new40 as lineage_new, @generation40 as generation   union all 
    select @rowguid41 as rowguid, @metadata_type41 as metadata_type, @lineage_old41 as lineage_old, @lineage_new41 as lineage_new, @generation41 as generation  union all 
    select @rowguid42 as rowguid, @metadata_type42 as metadata_type, @lineage_old42 as lineage_old, @lineage_new42 as lineage_new, @generation42 as generation  union all 
    select @rowguid43 as rowguid, @metadata_type43 as metadata_type, @lineage_old43 as lineage_old, @lineage_new43 as lineage_new, @generation43 as generation  union all 
    select @rowguid44 as rowguid, @metadata_type44 as metadata_type, @lineage_old44 as lineage_old, @lineage_new44 as lineage_new, @generation44 as generation  union all 
    select @rowguid45 as rowguid, @metadata_type45 as metadata_type, @lineage_old45 as lineage_old, @lineage_new45 as lineage_new, @generation45 as generation  union all 
    select @rowguid46 as rowguid, @metadata_type46 as metadata_type, @lineage_old46 as lineage_old, @lineage_new46 as lineage_new, @generation46 as generation  union all 
    select @rowguid47 as rowguid, @metadata_type47 as metadata_type, @lineage_old47 as lineage_old, @lineage_new47 as lineage_new, @generation47 as generation  union all 
    select @rowguid48 as rowguid, @metadata_type48 as metadata_type, @lineage_old48 as lineage_old, @lineage_new48 as lineage_new, @generation48 as generation  union all 
    select @rowguid49 as rowguid, @metadata_type49 as metadata_type, @lineage_old49 as lineage_old, @lineage_new49 as lineage_new, @generation49 as generation  union all 
    select @rowguid50 as rowguid, @metadata_type50 as metadata_type, @lineage_old50 as lineage_old, @lineage_new50 as lineage_new, @generation50 as generation   union all 
    select @rowguid51 as rowguid, @metadata_type51 as metadata_type, @lineage_old51 as lineage_old, @lineage_new51 as lineage_new, @generation51 as generation  union all 
    select @rowguid52 as rowguid, @metadata_type52 as metadata_type, @lineage_old52 as lineage_old, @lineage_new52 as lineage_new, @generation52 as generation  union all 
    select @rowguid53 as rowguid, @metadata_type53 as metadata_type, @lineage_old53 as lineage_old, @lineage_new53 as lineage_new, @generation53 as generation  union all 
    select @rowguid54 as rowguid, @metadata_type54 as metadata_type, @lineage_old54 as lineage_old, @lineage_new54 as lineage_new, @generation54 as generation  union all 
    select @rowguid55 as rowguid, @metadata_type55 as metadata_type, @lineage_old55 as lineage_old, @lineage_new55 as lineage_new, @generation55 as generation  union all 
    select @rowguid56 as rowguid, @metadata_type56 as metadata_type, @lineage_old56 as lineage_old, @lineage_new56 as lineage_new, @generation56 as generation  union all 
    select @rowguid57 as rowguid, @metadata_type57 as metadata_type, @lineage_old57 as lineage_old, @lineage_new57 as lineage_new, @generation57 as generation  union all 
    select @rowguid58 as rowguid, @metadata_type58 as metadata_type, @lineage_old58 as lineage_old, @lineage_new58 as lineage_new, @generation58 as generation  union all 
    select @rowguid59 as rowguid, @metadata_type59 as metadata_type, @lineage_old59 as lineage_old, @lineage_new59 as lineage_new, @generation59 as generation  union all 
    select @rowguid60 as rowguid, @metadata_type60 as metadata_type, @lineage_old60 as lineage_old, @lineage_new60 as lineage_new, @generation60 as generation   union all 
    select @rowguid61 as rowguid, @metadata_type61 as metadata_type, @lineage_old61 as lineage_old, @lineage_new61 as lineage_new, @generation61 as generation  union all 
    select @rowguid62 as rowguid, @metadata_type62 as metadata_type, @lineage_old62 as lineage_old, @lineage_new62 as lineage_new, @generation62 as generation  union all 
    select @rowguid63 as rowguid, @metadata_type63 as metadata_type, @lineage_old63 as lineage_old, @lineage_new63 as lineage_new, @generation63 as generation  union all 
    select @rowguid64 as rowguid, @metadata_type64 as metadata_type, @lineage_old64 as lineage_old, @lineage_new64 as lineage_new, @generation64 as generation  union all 
    select @rowguid65 as rowguid, @metadata_type65 as metadata_type, @lineage_old65 as lineage_old, @lineage_new65 as lineage_new, @generation65 as generation  union all 
    select @rowguid66 as rowguid, @metadata_type66 as metadata_type, @lineage_old66 as lineage_old, @lineage_new66 as lineage_new, @generation66 as generation  union all 
    select @rowguid67 as rowguid, @metadata_type67 as metadata_type, @lineage_old67 as lineage_old, @lineage_new67 as lineage_new, @generation67 as generation  union all 
    select @rowguid68 as rowguid, @metadata_type68 as metadata_type, @lineage_old68 as lineage_old, @lineage_new68 as lineage_new, @generation68 as generation  union all 
    select @rowguid69 as rowguid, @metadata_type69 as metadata_type, @lineage_old69 as lineage_old, @lineage_new69 as lineage_new, @generation69 as generation  union all 
    select @rowguid70 as rowguid, @metadata_type70 as metadata_type, @lineage_old70 as lineage_old, @lineage_new70 as lineage_new, @generation70 as generation   union all 
    select @rowguid71 as rowguid, @metadata_type71 as metadata_type, @lineage_old71 as lineage_old, @lineage_new71 as lineage_new, @generation71 as generation  union all 
    select @rowguid72 as rowguid, @metadata_type72 as metadata_type, @lineage_old72 as lineage_old, @lineage_new72 as lineage_new, @generation72 as generation  union all 
    select @rowguid73 as rowguid, @metadata_type73 as metadata_type, @lineage_old73 as lineage_old, @lineage_new73 as lineage_new, @generation73 as generation  union all 
    select @rowguid74 as rowguid, @metadata_type74 as metadata_type, @lineage_old74 as lineage_old, @lineage_new74 as lineage_new, @generation74 as generation  union all 
    select @rowguid75 as rowguid, @metadata_type75 as metadata_type, @lineage_old75 as lineage_old, @lineage_new75 as lineage_new, @generation75 as generation  union all 
    select @rowguid76 as rowguid, @metadata_type76 as metadata_type, @lineage_old76 as lineage_old, @lineage_new76 as lineage_new, @generation76 as generation  union all 
    select @rowguid77 as rowguid, @metadata_type77 as metadata_type, @lineage_old77 as lineage_old, @lineage_new77 as lineage_new, @generation77 as generation  union all 
    select @rowguid78 as rowguid, @metadata_type78 as metadata_type, @lineage_old78 as lineage_old, @lineage_new78 as lineage_new, @generation78 as generation  union all 
    select @rowguid79 as rowguid, @metadata_type79 as metadata_type, @lineage_old79 as lineage_old, @lineage_new79 as lineage_new, @generation79 as generation  union all 
    select @rowguid80 as rowguid, @metadata_type80 as metadata_type, @lineage_old80 as lineage_old, @lineage_new80 as lineage_new, @generation80 as generation   union all 
    select @rowguid81 as rowguid, @metadata_type81 as metadata_type, @lineage_old81 as lineage_old, @lineage_new81 as lineage_new, @generation81 as generation  union all 
    select @rowguid82 as rowguid, @metadata_type82 as metadata_type, @lineage_old82 as lineage_old, @lineage_new82 as lineage_new, @generation82 as generation  union all 
    select @rowguid83 as rowguid, @metadata_type83 as metadata_type, @lineage_old83 as lineage_old, @lineage_new83 as lineage_new, @generation83 as generation  union all 
    select @rowguid84 as rowguid, @metadata_type84 as metadata_type, @lineage_old84 as lineage_old, @lineage_new84 as lineage_new, @generation84 as generation  union all 
    select @rowguid85 as rowguid, @metadata_type85 as metadata_type, @lineage_old85 as lineage_old, @lineage_new85 as lineage_new, @generation85 as generation  union all 
    select @rowguid86 as rowguid, @metadata_type86 as metadata_type, @lineage_old86 as lineage_old, @lineage_new86 as lineage_new, @generation86 as generation  union all 
    select @rowguid87 as rowguid, @metadata_type87 as metadata_type, @lineage_old87 as lineage_old, @lineage_new87 as lineage_new, @generation87 as generation  union all 
    select @rowguid88 as rowguid, @metadata_type88 as metadata_type, @lineage_old88 as lineage_old, @lineage_new88 as lineage_new, @generation88 as generation  union all 
    select @rowguid89 as rowguid, @metadata_type89 as metadata_type, @lineage_old89 as lineage_old, @lineage_new89 as lineage_new, @generation89 as generation  union all 
    select @rowguid90 as rowguid, @metadata_type90 as metadata_type, @lineage_old90 as lineage_old, @lineage_new90 as lineage_new, @generation90 as generation   union all 
    select @rowguid91 as rowguid, @metadata_type91 as metadata_type, @lineage_old91 as lineage_old, @lineage_new91 as lineage_new, @generation91 as generation  union all 
    select @rowguid92 as rowguid, @metadata_type92 as metadata_type, @lineage_old92 as lineage_old, @lineage_new92 as lineage_new, @generation92 as generation  union all 
    select @rowguid93 as rowguid, @metadata_type93 as metadata_type, @lineage_old93 as lineage_old, @lineage_new93 as lineage_new, @generation93 as generation  union all 
    select @rowguid94 as rowguid, @metadata_type94 as metadata_type, @lineage_old94 as lineage_old, @lineage_new94 as lineage_new, @generation94 as generation  union all 
    select @rowguid95 as rowguid, @metadata_type95 as metadata_type, @lineage_old95 as lineage_old, @lineage_new95 as lineage_new, @generation95 as generation  union all 
    select @rowguid96 as rowguid, @metadata_type96 as metadata_type, @lineage_old96 as lineage_old, @lineage_new96 as lineage_new, @generation96 as generation  union all 
    select @rowguid97 as rowguid, @metadata_type97 as metadata_type, @lineage_old97 as lineage_old, @lineage_new97 as lineage_new, @generation97 as generation  union all 
    select @rowguid98 as rowguid, @metadata_type98 as metadata_type, @lineage_old98 as lineage_old, @lineage_new98 as lineage_new, @generation98 as generation  union all 
    select @rowguid99 as rowguid, @metadata_type99 as metadata_type, @lineage_old99 as lineage_old, @lineage_new99 as lineage_new, @generation99 as generation  union all 
    select @rowguid100 as rowguid, @metadata_type100 as metadata_type, @lineage_old100 as lineage_old, @lineage_new100 as lineage_new, @generation100 as generation  
    ) as rows
    inner join dbo.MSmerge_tombstone tomb with (rowlock) 
    on tomb.rowguid = rows.rowguid and tomb.tablenick = 21696010
    and rows.rowguid is not null
    and rows.lineage_new is not NULL
    option (force order, loop join)
    select @tomb_rows_updated = @@rowcount, @error = @@error
    if @error<>0
        goto Failure 
        -- the trigger would have inserted a row in past partition mapping for the currently deleted
        -- row. We need to update that row with the current generation if it exists
        update dbo.MSmerge_past_partition_mappings with (rowlock)
        set generation = rows.generation
    from
    ( 
    select @rowguid1 as rowguid, @metadata_type1 as metadata_type, @lineage_old1 as lineage_old, @lineage_new1 as lineage_new, @generation1 as generation  union all 
    select @rowguid2 as rowguid, @metadata_type2 as metadata_type, @lineage_old2 as lineage_old, @lineage_new2 as lineage_new, @generation2 as generation  union all 
    select @rowguid3 as rowguid, @metadata_type3 as metadata_type, @lineage_old3 as lineage_old, @lineage_new3 as lineage_new, @generation3 as generation  union all 
    select @rowguid4 as rowguid, @metadata_type4 as metadata_type, @lineage_old4 as lineage_old, @lineage_new4 as lineage_new, @generation4 as generation  union all 
    select @rowguid5 as rowguid, @metadata_type5 as metadata_type, @lineage_old5 as lineage_old, @lineage_new5 as lineage_new, @generation5 as generation  union all 
    select @rowguid6 as rowguid, @metadata_type6 as metadata_type, @lineage_old6 as lineage_old, @lineage_new6 as lineage_new, @generation6 as generation  union all 
    select @rowguid7 as rowguid, @metadata_type7 as metadata_type, @lineage_old7 as lineage_old, @lineage_new7 as lineage_new, @generation7 as generation  union all 
    select @rowguid8 as rowguid, @metadata_type8 as metadata_type, @lineage_old8 as lineage_old, @lineage_new8 as lineage_new, @generation8 as generation  union all 
    select @rowguid9 as rowguid, @metadata_type9 as metadata_type, @lineage_old9 as lineage_old, @lineage_new9 as lineage_new, @generation9 as generation  union all 
    select @rowguid10 as rowguid, @metadata_type10 as metadata_type, @lineage_old10 as lineage_old, @lineage_new10 as lineage_new, @generation10 as generation   union all 
    select @rowguid11 as rowguid, @metadata_type11 as metadata_type, @lineage_old11 as lineage_old, @lineage_new11 as lineage_new, @generation11 as generation  union all 
    select @rowguid12 as rowguid, @metadata_type12 as metadata_type, @lineage_old12 as lineage_old, @lineage_new12 as lineage_new, @generation12 as generation  union all 
    select @rowguid13 as rowguid, @metadata_type13 as metadata_type, @lineage_old13 as lineage_old, @lineage_new13 as lineage_new, @generation13 as generation  union all 
    select @rowguid14 as rowguid, @metadata_type14 as metadata_type, @lineage_old14 as lineage_old, @lineage_new14 as lineage_new, @generation14 as generation  union all 
    select @rowguid15 as rowguid, @metadata_type15 as metadata_type, @lineage_old15 as lineage_old, @lineage_new15 as lineage_new, @generation15 as generation  union all 
    select @rowguid16 as rowguid, @metadata_type16 as metadata_type, @lineage_old16 as lineage_old, @lineage_new16 as lineage_new, @generation16 as generation  union all 
    select @rowguid17 as rowguid, @metadata_type17 as metadata_type, @lineage_old17 as lineage_old, @lineage_new17 as lineage_new, @generation17 as generation  union all 
    select @rowguid18 as rowguid, @metadata_type18 as metadata_type, @lineage_old18 as lineage_old, @lineage_new18 as lineage_new, @generation18 as generation  union all 
    select @rowguid19 as rowguid, @metadata_type19 as metadata_type, @lineage_old19 as lineage_old, @lineage_new19 as lineage_new, @generation19 as generation  union all 
    select @rowguid20 as rowguid, @metadata_type20 as metadata_type, @lineage_old20 as lineage_old, @lineage_new20 as lineage_new, @generation20 as generation   union all 
    select @rowguid21 as rowguid, @metadata_type21 as metadata_type, @lineage_old21 as lineage_old, @lineage_new21 as lineage_new, @generation21 as generation  union all 
    select @rowguid22 as rowguid, @metadata_type22 as metadata_type, @lineage_old22 as lineage_old, @lineage_new22 as lineage_new, @generation22 as generation  union all 
    select @rowguid23 as rowguid, @metadata_type23 as metadata_type, @lineage_old23 as lineage_old, @lineage_new23 as lineage_new, @generation23 as generation  union all 
    select @rowguid24 as rowguid, @metadata_type24 as metadata_type, @lineage_old24 as lineage_old, @lineage_new24 as lineage_new, @generation24 as generation  union all 
    select @rowguid25 as rowguid, @metadata_type25 as metadata_type, @lineage_old25 as lineage_old, @lineage_new25 as lineage_new, @generation25 as generation  union all 
    select @rowguid26 as rowguid, @metadata_type26 as metadata_type, @lineage_old26 as lineage_old, @lineage_new26 as lineage_new, @generation26 as generation  union all 
    select @rowguid27 as rowguid, @metadata_type27 as metadata_type, @lineage_old27 as lineage_old, @lineage_new27 as lineage_new, @generation27 as generation  union all 
    select @rowguid28 as rowguid, @metadata_type28 as metadata_type, @lineage_old28 as lineage_old, @lineage_new28 as lineage_new, @generation28 as generation  union all 
    select @rowguid29 as rowguid, @metadata_type29 as metadata_type, @lineage_old29 as lineage_old, @lineage_new29 as lineage_new, @generation29 as generation  union all 
    select @rowguid30 as rowguid, @metadata_type30 as metadata_type, @lineage_old30 as lineage_old, @lineage_new30 as lineage_new, @generation30 as generation   union all 
    select @rowguid31 as rowguid, @metadata_type31 as metadata_type, @lineage_old31 as lineage_old, @lineage_new31 as lineage_new, @generation31 as generation  union all 
    select @rowguid32 as rowguid, @metadata_type32 as metadata_type, @lineage_old32 as lineage_old, @lineage_new32 as lineage_new, @generation32 as generation  union all 
    select @rowguid33 as rowguid, @metadata_type33 as metadata_type, @lineage_old33 as lineage_old, @lineage_new33 as lineage_new, @generation33 as generation  union all 
    select @rowguid34 as rowguid, @metadata_type34 as metadata_type, @lineage_old34 as lineage_old, @lineage_new34 as lineage_new, @generation34 as generation  union all 
    select @rowguid35 as rowguid, @metadata_type35 as metadata_type, @lineage_old35 as lineage_old, @lineage_new35 as lineage_new, @generation35 as generation  union all 
    select @rowguid36 as rowguid, @metadata_type36 as metadata_type, @lineage_old36 as lineage_old, @lineage_new36 as lineage_new, @generation36 as generation  union all 
    select @rowguid37 as rowguid, @metadata_type37 as metadata_type, @lineage_old37 as lineage_old, @lineage_new37 as lineage_new, @generation37 as generation  union all 
    select @rowguid38 as rowguid, @metadata_type38 as metadata_type, @lineage_old38 as lineage_old, @lineage_new38 as lineage_new, @generation38 as generation  union all 
    select @rowguid39 as rowguid, @metadata_type39 as metadata_type, @lineage_old39 as lineage_old, @lineage_new39 as lineage_new, @generation39 as generation  union all 
    select @rowguid40 as rowguid, @metadata_type40 as metadata_type, @lineage_old40 as lineage_old, @lineage_new40 as lineage_new, @generation40 as generation   union all 
    select @rowguid41 as rowguid, @metadata_type41 as metadata_type, @lineage_old41 as lineage_old, @lineage_new41 as lineage_new, @generation41 as generation  union all 
    select @rowguid42 as rowguid, @metadata_type42 as metadata_type, @lineage_old42 as lineage_old, @lineage_new42 as lineage_new, @generation42 as generation  union all 
    select @rowguid43 as rowguid, @metadata_type43 as metadata_type, @lineage_old43 as lineage_old, @lineage_new43 as lineage_new, @generation43 as generation  union all 
    select @rowguid44 as rowguid, @metadata_type44 as metadata_type, @lineage_old44 as lineage_old, @lineage_new44 as lineage_new, @generation44 as generation  union all 
    select @rowguid45 as rowguid, @metadata_type45 as metadata_type, @lineage_old45 as lineage_old, @lineage_new45 as lineage_new, @generation45 as generation  union all 
    select @rowguid46 as rowguid, @metadata_type46 as metadata_type, @lineage_old46 as lineage_old, @lineage_new46 as lineage_new, @generation46 as generation  union all 
    select @rowguid47 as rowguid, @metadata_type47 as metadata_type, @lineage_old47 as lineage_old, @lineage_new47 as lineage_new, @generation47 as generation  union all 
    select @rowguid48 as rowguid, @metadata_type48 as metadata_type, @lineage_old48 as lineage_old, @lineage_new48 as lineage_new, @generation48 as generation  union all 
    select @rowguid49 as rowguid, @metadata_type49 as metadata_type, @lineage_old49 as lineage_old, @lineage_new49 as lineage_new, @generation49 as generation  union all 
    select @rowguid50 as rowguid, @metadata_type50 as metadata_type, @lineage_old50 as lineage_old, @lineage_new50 as lineage_new, @generation50 as generation   union all 
    select @rowguid51 as rowguid, @metadata_type51 as metadata_type, @lineage_old51 as lineage_old, @lineage_new51 as lineage_new, @generation51 as generation  union all 
    select @rowguid52 as rowguid, @metadata_type52 as metadata_type, @lineage_old52 as lineage_old, @lineage_new52 as lineage_new, @generation52 as generation  union all 
    select @rowguid53 as rowguid, @metadata_type53 as metadata_type, @lineage_old53 as lineage_old, @lineage_new53 as lineage_new, @generation53 as generation  union all 
    select @rowguid54 as rowguid, @metadata_type54 as metadata_type, @lineage_old54 as lineage_old, @lineage_new54 as lineage_new, @generation54 as generation  union all 
    select @rowguid55 as rowguid, @metadata_type55 as metadata_type, @lineage_old55 as lineage_old, @lineage_new55 as lineage_new, @generation55 as generation  union all 
    select @rowguid56 as rowguid, @metadata_type56 as metadata_type, @lineage_old56 as lineage_old, @lineage_new56 as lineage_new, @generation56 as generation  union all 
    select @rowguid57 as rowguid, @metadata_type57 as metadata_type, @lineage_old57 as lineage_old, @lineage_new57 as lineage_new, @generation57 as generation  union all 
    select @rowguid58 as rowguid, @metadata_type58 as metadata_type, @lineage_old58 as lineage_old, @lineage_new58 as lineage_new, @generation58 as generation  union all 
    select @rowguid59 as rowguid, @metadata_type59 as metadata_type, @lineage_old59 as lineage_old, @lineage_new59 as lineage_new, @generation59 as generation  union all 
    select @rowguid60 as rowguid, @metadata_type60 as metadata_type, @lineage_old60 as lineage_old, @lineage_new60 as lineage_new, @generation60 as generation   union all 
    select @rowguid61 as rowguid, @metadata_type61 as metadata_type, @lineage_old61 as lineage_old, @lineage_new61 as lineage_new, @generation61 as generation  union all 
    select @rowguid62 as rowguid, @metadata_type62 as metadata_type, @lineage_old62 as lineage_old, @lineage_new62 as lineage_new, @generation62 as generation  union all 
    select @rowguid63 as rowguid, @metadata_type63 as metadata_type, @lineage_old63 as lineage_old, @lineage_new63 as lineage_new, @generation63 as generation  union all 
    select @rowguid64 as rowguid, @metadata_type64 as metadata_type, @lineage_old64 as lineage_old, @lineage_new64 as lineage_new, @generation64 as generation  union all 
    select @rowguid65 as rowguid, @metadata_type65 as metadata_type, @lineage_old65 as lineage_old, @lineage_new65 as lineage_new, @generation65 as generation  union all 
    select @rowguid66 as rowguid, @metadata_type66 as metadata_type, @lineage_old66 as lineage_old, @lineage_new66 as lineage_new, @generation66 as generation  union all 
    select @rowguid67 as rowguid, @metadata_type67 as metadata_type, @lineage_old67 as lineage_old, @lineage_new67 as lineage_new, @generation67 as generation  union all 
    select @rowguid68 as rowguid, @metadata_type68 as metadata_type, @lineage_old68 as lineage_old, @lineage_new68 as lineage_new, @generation68 as generation  union all 
    select @rowguid69 as rowguid, @metadata_type69 as metadata_type, @lineage_old69 as lineage_old, @lineage_new69 as lineage_new, @generation69 as generation  union all 
    select @rowguid70 as rowguid, @metadata_type70 as metadata_type, @lineage_old70 as lineage_old, @lineage_new70 as lineage_new, @generation70 as generation   union all 
    select @rowguid71 as rowguid, @metadata_type71 as metadata_type, @lineage_old71 as lineage_old, @lineage_new71 as lineage_new, @generation71 as generation  union all 
    select @rowguid72 as rowguid, @metadata_type72 as metadata_type, @lineage_old72 as lineage_old, @lineage_new72 as lineage_new, @generation72 as generation  union all 
    select @rowguid73 as rowguid, @metadata_type73 as metadata_type, @lineage_old73 as lineage_old, @lineage_new73 as lineage_new, @generation73 as generation  union all 
    select @rowguid74 as rowguid, @metadata_type74 as metadata_type, @lineage_old74 as lineage_old, @lineage_new74 as lineage_new, @generation74 as generation  union all 
    select @rowguid75 as rowguid, @metadata_type75 as metadata_type, @lineage_old75 as lineage_old, @lineage_new75 as lineage_new, @generation75 as generation  union all 
    select @rowguid76 as rowguid, @metadata_type76 as metadata_type, @lineage_old76 as lineage_old, @lineage_new76 as lineage_new, @generation76 as generation  union all 
    select @rowguid77 as rowguid, @metadata_type77 as metadata_type, @lineage_old77 as lineage_old, @lineage_new77 as lineage_new, @generation77 as generation  union all 
    select @rowguid78 as rowguid, @metadata_type78 as metadata_type, @lineage_old78 as lineage_old, @lineage_new78 as lineage_new, @generation78 as generation  union all 
    select @rowguid79 as rowguid, @metadata_type79 as metadata_type, @lineage_old79 as lineage_old, @lineage_new79 as lineage_new, @generation79 as generation  union all 
    select @rowguid80 as rowguid, @metadata_type80 as metadata_type, @lineage_old80 as lineage_old, @lineage_new80 as lineage_new, @generation80 as generation   union all 
    select @rowguid81 as rowguid, @metadata_type81 as metadata_type, @lineage_old81 as lineage_old, @lineage_new81 as lineage_new, @generation81 as generation  union all 
    select @rowguid82 as rowguid, @metadata_type82 as metadata_type, @lineage_old82 as lineage_old, @lineage_new82 as lineage_new, @generation82 as generation  union all 
    select @rowguid83 as rowguid, @metadata_type83 as metadata_type, @lineage_old83 as lineage_old, @lineage_new83 as lineage_new, @generation83 as generation  union all 
    select @rowguid84 as rowguid, @metadata_type84 as metadata_type, @lineage_old84 as lineage_old, @lineage_new84 as lineage_new, @generation84 as generation  union all 
    select @rowguid85 as rowguid, @metadata_type85 as metadata_type, @lineage_old85 as lineage_old, @lineage_new85 as lineage_new, @generation85 as generation  union all 
    select @rowguid86 as rowguid, @metadata_type86 as metadata_type, @lineage_old86 as lineage_old, @lineage_new86 as lineage_new, @generation86 as generation  union all 
    select @rowguid87 as rowguid, @metadata_type87 as metadata_type, @lineage_old87 as lineage_old, @lineage_new87 as lineage_new, @generation87 as generation  union all 
    select @rowguid88 as rowguid, @metadata_type88 as metadata_type, @lineage_old88 as lineage_old, @lineage_new88 as lineage_new, @generation88 as generation  union all 
    select @rowguid89 as rowguid, @metadata_type89 as metadata_type, @lineage_old89 as lineage_old, @lineage_new89 as lineage_new, @generation89 as generation  union all 
    select @rowguid90 as rowguid, @metadata_type90 as metadata_type, @lineage_old90 as lineage_old, @lineage_new90 as lineage_new, @generation90 as generation   union all 
    select @rowguid91 as rowguid, @metadata_type91 as metadata_type, @lineage_old91 as lineage_old, @lineage_new91 as lineage_new, @generation91 as generation  union all 
    select @rowguid92 as rowguid, @metadata_type92 as metadata_type, @lineage_old92 as lineage_old, @lineage_new92 as lineage_new, @generation92 as generation  union all 
    select @rowguid93 as rowguid, @metadata_type93 as metadata_type, @lineage_old93 as lineage_old, @lineage_new93 as lineage_new, @generation93 as generation  union all 
    select @rowguid94 as rowguid, @metadata_type94 as metadata_type, @lineage_old94 as lineage_old, @lineage_new94 as lineage_new, @generation94 as generation  union all 
    select @rowguid95 as rowguid, @metadata_type95 as metadata_type, @lineage_old95 as lineage_old, @lineage_new95 as lineage_new, @generation95 as generation  union all 
    select @rowguid96 as rowguid, @metadata_type96 as metadata_type, @lineage_old96 as lineage_old, @lineage_new96 as lineage_new, @generation96 as generation  union all 
    select @rowguid97 as rowguid, @metadata_type97 as metadata_type, @lineage_old97 as lineage_old, @lineage_new97 as lineage_new, @generation97 as generation  union all 
    select @rowguid98 as rowguid, @metadata_type98 as metadata_type, @lineage_old98 as lineage_old, @lineage_new98 as lineage_new, @generation98 as generation  union all 
    select @rowguid99 as rowguid, @metadata_type99 as metadata_type, @lineage_old99 as lineage_old, @lineage_new99 as lineage_new, @generation99 as generation  union all 
    select @rowguid100 as rowguid, @metadata_type100 as metadata_type, @lineage_old100 as lineage_old, @lineage_new100 as lineage_new, @generation100 as generation  
        ) as rows
        inner join dbo.MSmerge_past_partition_mappings ppm with (rowlock) 
        on ppm.rowguid = rows.rowguid and ppm.tablenick = 21696010 
        and ppm.generation = 0
        and rows.rowguid is not NULL
        and rows.lineage_new is not null
        option (force order, loop join)
        if @error<>0
                goto Failure 
    if @tomb_rows_updated <> @rowstobedeleted
    begin
        -- now insert rows that are not in tombstone
        insert into dbo.MSmerge_tombstone with (rowlock)
            (rowguid, tablenick, type, generation, lineage)
        select rows.rowguid, 21696010, 
               case when (rows.metadata_type=5 or rows.metadata_type=6) then rows.metadata_type else 1 end, 
               rows.generation, rows.lineage_new
        from 
        ( 
    select @rowguid1 as rowguid, @metadata_type1 as metadata_type, @lineage_old1 as lineage_old, @lineage_new1 as lineage_new, @generation1 as generation  union all 
    select @rowguid2 as rowguid, @metadata_type2 as metadata_type, @lineage_old2 as lineage_old, @lineage_new2 as lineage_new, @generation2 as generation  union all 
    select @rowguid3 as rowguid, @metadata_type3 as metadata_type, @lineage_old3 as lineage_old, @lineage_new3 as lineage_new, @generation3 as generation  union all 
    select @rowguid4 as rowguid, @metadata_type4 as metadata_type, @lineage_old4 as lineage_old, @lineage_new4 as lineage_new, @generation4 as generation  union all 
    select @rowguid5 as rowguid, @metadata_type5 as metadata_type, @lineage_old5 as lineage_old, @lineage_new5 as lineage_new, @generation5 as generation  union all 
    select @rowguid6 as rowguid, @metadata_type6 as metadata_type, @lineage_old6 as lineage_old, @lineage_new6 as lineage_new, @generation6 as generation  union all 
    select @rowguid7 as rowguid, @metadata_type7 as metadata_type, @lineage_old7 as lineage_old, @lineage_new7 as lineage_new, @generation7 as generation  union all 
    select @rowguid8 as rowguid, @metadata_type8 as metadata_type, @lineage_old8 as lineage_old, @lineage_new8 as lineage_new, @generation8 as generation  union all 
    select @rowguid9 as rowguid, @metadata_type9 as metadata_type, @lineage_old9 as lineage_old, @lineage_new9 as lineage_new, @generation9 as generation  union all 
    select @rowguid10 as rowguid, @metadata_type10 as metadata_type, @lineage_old10 as lineage_old, @lineage_new10 as lineage_new, @generation10 as generation   union all 
    select @rowguid11 as rowguid, @metadata_type11 as metadata_type, @lineage_old11 as lineage_old, @lineage_new11 as lineage_new, @generation11 as generation  union all 
    select @rowguid12 as rowguid, @metadata_type12 as metadata_type, @lineage_old12 as lineage_old, @lineage_new12 as lineage_new, @generation12 as generation  union all 
    select @rowguid13 as rowguid, @metadata_type13 as metadata_type, @lineage_old13 as lineage_old, @lineage_new13 as lineage_new, @generation13 as generation  union all 
    select @rowguid14 as rowguid, @metadata_type14 as metadata_type, @lineage_old14 as lineage_old, @lineage_new14 as lineage_new, @generation14 as generation  union all 
    select @rowguid15 as rowguid, @metadata_type15 as metadata_type, @lineage_old15 as lineage_old, @lineage_new15 as lineage_new, @generation15 as generation  union all 
    select @rowguid16 as rowguid, @metadata_type16 as metadata_type, @lineage_old16 as lineage_old, @lineage_new16 as lineage_new, @generation16 as generation  union all 
    select @rowguid17 as rowguid, @metadata_type17 as metadata_type, @lineage_old17 as lineage_old, @lineage_new17 as lineage_new, @generation17 as generation  union all 
    select @rowguid18 as rowguid, @metadata_type18 as metadata_type, @lineage_old18 as lineage_old, @lineage_new18 as lineage_new, @generation18 as generation  union all 
    select @rowguid19 as rowguid, @metadata_type19 as metadata_type, @lineage_old19 as lineage_old, @lineage_new19 as lineage_new, @generation19 as generation  union all 
    select @rowguid20 as rowguid, @metadata_type20 as metadata_type, @lineage_old20 as lineage_old, @lineage_new20 as lineage_new, @generation20 as generation   union all 
    select @rowguid21 as rowguid, @metadata_type21 as metadata_type, @lineage_old21 as lineage_old, @lineage_new21 as lineage_new, @generation21 as generation  union all 
    select @rowguid22 as rowguid, @metadata_type22 as metadata_type, @lineage_old22 as lineage_old, @lineage_new22 as lineage_new, @generation22 as generation  union all 
    select @rowguid23 as rowguid, @metadata_type23 as metadata_type, @lineage_old23 as lineage_old, @lineage_new23 as lineage_new, @generation23 as generation  union all 
    select @rowguid24 as rowguid, @metadata_type24 as metadata_type, @lineage_old24 as lineage_old, @lineage_new24 as lineage_new, @generation24 as generation  union all 
    select @rowguid25 as rowguid, @metadata_type25 as metadata_type, @lineage_old25 as lineage_old, @lineage_new25 as lineage_new, @generation25 as generation  union all 
    select @rowguid26 as rowguid, @metadata_type26 as metadata_type, @lineage_old26 as lineage_old, @lineage_new26 as lineage_new, @generation26 as generation  union all 
    select @rowguid27 as rowguid, @metadata_type27 as metadata_type, @lineage_old27 as lineage_old, @lineage_new27 as lineage_new, @generation27 as generation  union all 
    select @rowguid28 as rowguid, @metadata_type28 as metadata_type, @lineage_old28 as lineage_old, @lineage_new28 as lineage_new, @generation28 as generation  union all 
    select @rowguid29 as rowguid, @metadata_type29 as metadata_type, @lineage_old29 as lineage_old, @lineage_new29 as lineage_new, @generation29 as generation  union all 
    select @rowguid30 as rowguid, @metadata_type30 as metadata_type, @lineage_old30 as lineage_old, @lineage_new30 as lineage_new, @generation30 as generation   union all 
    select @rowguid31 as rowguid, @metadata_type31 as metadata_type, @lineage_old31 as lineage_old, @lineage_new31 as lineage_new, @generation31 as generation  union all 
    select @rowguid32 as rowguid, @metadata_type32 as metadata_type, @lineage_old32 as lineage_old, @lineage_new32 as lineage_new, @generation32 as generation  union all 
    select @rowguid33 as rowguid, @metadata_type33 as metadata_type, @lineage_old33 as lineage_old, @lineage_new33 as lineage_new, @generation33 as generation  union all 
    select @rowguid34 as rowguid, @metadata_type34 as metadata_type, @lineage_old34 as lineage_old, @lineage_new34 as lineage_new, @generation34 as generation  union all 
    select @rowguid35 as rowguid, @metadata_type35 as metadata_type, @lineage_old35 as lineage_old, @lineage_new35 as lineage_new, @generation35 as generation  union all 
    select @rowguid36 as rowguid, @metadata_type36 as metadata_type, @lineage_old36 as lineage_old, @lineage_new36 as lineage_new, @generation36 as generation  union all 
    select @rowguid37 as rowguid, @metadata_type37 as metadata_type, @lineage_old37 as lineage_old, @lineage_new37 as lineage_new, @generation37 as generation  union all 
    select @rowguid38 as rowguid, @metadata_type38 as metadata_type, @lineage_old38 as lineage_old, @lineage_new38 as lineage_new, @generation38 as generation  union all 
    select @rowguid39 as rowguid, @metadata_type39 as metadata_type, @lineage_old39 as lineage_old, @lineage_new39 as lineage_new, @generation39 as generation  union all 
    select @rowguid40 as rowguid, @metadata_type40 as metadata_type, @lineage_old40 as lineage_old, @lineage_new40 as lineage_new, @generation40 as generation   union all 
    select @rowguid41 as rowguid, @metadata_type41 as metadata_type, @lineage_old41 as lineage_old, @lineage_new41 as lineage_new, @generation41 as generation  union all 
    select @rowguid42 as rowguid, @metadata_type42 as metadata_type, @lineage_old42 as lineage_old, @lineage_new42 as lineage_new, @generation42 as generation  union all 
    select @rowguid43 as rowguid, @metadata_type43 as metadata_type, @lineage_old43 as lineage_old, @lineage_new43 as lineage_new, @generation43 as generation  union all 
    select @rowguid44 as rowguid, @metadata_type44 as metadata_type, @lineage_old44 as lineage_old, @lineage_new44 as lineage_new, @generation44 as generation  union all 
    select @rowguid45 as rowguid, @metadata_type45 as metadata_type, @lineage_old45 as lineage_old, @lineage_new45 as lineage_new, @generation45 as generation  union all 
    select @rowguid46 as rowguid, @metadata_type46 as metadata_type, @lineage_old46 as lineage_old, @lineage_new46 as lineage_new, @generation46 as generation  union all 
    select @rowguid47 as rowguid, @metadata_type47 as metadata_type, @lineage_old47 as lineage_old, @lineage_new47 as lineage_new, @generation47 as generation  union all 
    select @rowguid48 as rowguid, @metadata_type48 as metadata_type, @lineage_old48 as lineage_old, @lineage_new48 as lineage_new, @generation48 as generation  union all 
    select @rowguid49 as rowguid, @metadata_type49 as metadata_type, @lineage_old49 as lineage_old, @lineage_new49 as lineage_new, @generation49 as generation  union all 
    select @rowguid50 as rowguid, @metadata_type50 as metadata_type, @lineage_old50 as lineage_old, @lineage_new50 as lineage_new, @generation50 as generation   union all 
    select @rowguid51 as rowguid, @metadata_type51 as metadata_type, @lineage_old51 as lineage_old, @lineage_new51 as lineage_new, @generation51 as generation  union all 
    select @rowguid52 as rowguid, @metadata_type52 as metadata_type, @lineage_old52 as lineage_old, @lineage_new52 as lineage_new, @generation52 as generation  union all 
    select @rowguid53 as rowguid, @metadata_type53 as metadata_type, @lineage_old53 as lineage_old, @lineage_new53 as lineage_new, @generation53 as generation  union all 
    select @rowguid54 as rowguid, @metadata_type54 as metadata_type, @lineage_old54 as lineage_old, @lineage_new54 as lineage_new, @generation54 as generation  union all 
    select @rowguid55 as rowguid, @metadata_type55 as metadata_type, @lineage_old55 as lineage_old, @lineage_new55 as lineage_new, @generation55 as generation  union all 
    select @rowguid56 as rowguid, @metadata_type56 as metadata_type, @lineage_old56 as lineage_old, @lineage_new56 as lineage_new, @generation56 as generation  union all 
    select @rowguid57 as rowguid, @metadata_type57 as metadata_type, @lineage_old57 as lineage_old, @lineage_new57 as lineage_new, @generation57 as generation  union all 
    select @rowguid58 as rowguid, @metadata_type58 as metadata_type, @lineage_old58 as lineage_old, @lineage_new58 as lineage_new, @generation58 as generation  union all 
    select @rowguid59 as rowguid, @metadata_type59 as metadata_type, @lineage_old59 as lineage_old, @lineage_new59 as lineage_new, @generation59 as generation  union all 
    select @rowguid60 as rowguid, @metadata_type60 as metadata_type, @lineage_old60 as lineage_old, @lineage_new60 as lineage_new, @generation60 as generation   union all 
    select @rowguid61 as rowguid, @metadata_type61 as metadata_type, @lineage_old61 as lineage_old, @lineage_new61 as lineage_new, @generation61 as generation  union all 
    select @rowguid62 as rowguid, @metadata_type62 as metadata_type, @lineage_old62 as lineage_old, @lineage_new62 as lineage_new, @generation62 as generation  union all 
    select @rowguid63 as rowguid, @metadata_type63 as metadata_type, @lineage_old63 as lineage_old, @lineage_new63 as lineage_new, @generation63 as generation  union all 
    select @rowguid64 as rowguid, @metadata_type64 as metadata_type, @lineage_old64 as lineage_old, @lineage_new64 as lineage_new, @generation64 as generation  union all 
    select @rowguid65 as rowguid, @metadata_type65 as metadata_type, @lineage_old65 as lineage_old, @lineage_new65 as lineage_new, @generation65 as generation  union all 
    select @rowguid66 as rowguid, @metadata_type66 as metadata_type, @lineage_old66 as lineage_old, @lineage_new66 as lineage_new, @generation66 as generation  union all 
    select @rowguid67 as rowguid, @metadata_type67 as metadata_type, @lineage_old67 as lineage_old, @lineage_new67 as lineage_new, @generation67 as generation  union all 
    select @rowguid68 as rowguid, @metadata_type68 as metadata_type, @lineage_old68 as lineage_old, @lineage_new68 as lineage_new, @generation68 as generation  union all 
    select @rowguid69 as rowguid, @metadata_type69 as metadata_type, @lineage_old69 as lineage_old, @lineage_new69 as lineage_new, @generation69 as generation  union all 
    select @rowguid70 as rowguid, @metadata_type70 as metadata_type, @lineage_old70 as lineage_old, @lineage_new70 as lineage_new, @generation70 as generation   union all 
    select @rowguid71 as rowguid, @metadata_type71 as metadata_type, @lineage_old71 as lineage_old, @lineage_new71 as lineage_new, @generation71 as generation  union all 
    select @rowguid72 as rowguid, @metadata_type72 as metadata_type, @lineage_old72 as lineage_old, @lineage_new72 as lineage_new, @generation72 as generation  union all 
    select @rowguid73 as rowguid, @metadata_type73 as metadata_type, @lineage_old73 as lineage_old, @lineage_new73 as lineage_new, @generation73 as generation  union all 
    select @rowguid74 as rowguid, @metadata_type74 as metadata_type, @lineage_old74 as lineage_old, @lineage_new74 as lineage_new, @generation74 as generation  union all 
    select @rowguid75 as rowguid, @metadata_type75 as metadata_type, @lineage_old75 as lineage_old, @lineage_new75 as lineage_new, @generation75 as generation  union all 
    select @rowguid76 as rowguid, @metadata_type76 as metadata_type, @lineage_old76 as lineage_old, @lineage_new76 as lineage_new, @generation76 as generation  union all 
    select @rowguid77 as rowguid, @metadata_type77 as metadata_type, @lineage_old77 as lineage_old, @lineage_new77 as lineage_new, @generation77 as generation  union all 
    select @rowguid78 as rowguid, @metadata_type78 as metadata_type, @lineage_old78 as lineage_old, @lineage_new78 as lineage_new, @generation78 as generation  union all 
    select @rowguid79 as rowguid, @metadata_type79 as metadata_type, @lineage_old79 as lineage_old, @lineage_new79 as lineage_new, @generation79 as generation  union all 
    select @rowguid80 as rowguid, @metadata_type80 as metadata_type, @lineage_old80 as lineage_old, @lineage_new80 as lineage_new, @generation80 as generation   union all 
    select @rowguid81 as rowguid, @metadata_type81 as metadata_type, @lineage_old81 as lineage_old, @lineage_new81 as lineage_new, @generation81 as generation  union all 
    select @rowguid82 as rowguid, @metadata_type82 as metadata_type, @lineage_old82 as lineage_old, @lineage_new82 as lineage_new, @generation82 as generation  union all 
    select @rowguid83 as rowguid, @metadata_type83 as metadata_type, @lineage_old83 as lineage_old, @lineage_new83 as lineage_new, @generation83 as generation  union all 
    select @rowguid84 as rowguid, @metadata_type84 as metadata_type, @lineage_old84 as lineage_old, @lineage_new84 as lineage_new, @generation84 as generation  union all 
    select @rowguid85 as rowguid, @metadata_type85 as metadata_type, @lineage_old85 as lineage_old, @lineage_new85 as lineage_new, @generation85 as generation  union all 
    select @rowguid86 as rowguid, @metadata_type86 as metadata_type, @lineage_old86 as lineage_old, @lineage_new86 as lineage_new, @generation86 as generation  union all 
    select @rowguid87 as rowguid, @metadata_type87 as metadata_type, @lineage_old87 as lineage_old, @lineage_new87 as lineage_new, @generation87 as generation  union all 
    select @rowguid88 as rowguid, @metadata_type88 as metadata_type, @lineage_old88 as lineage_old, @lineage_new88 as lineage_new, @generation88 as generation  union all 
    select @rowguid89 as rowguid, @metadata_type89 as metadata_type, @lineage_old89 as lineage_old, @lineage_new89 as lineage_new, @generation89 as generation  union all 
    select @rowguid90 as rowguid, @metadata_type90 as metadata_type, @lineage_old90 as lineage_old, @lineage_new90 as lineage_new, @generation90 as generation   union all 
    select @rowguid91 as rowguid, @metadata_type91 as metadata_type, @lineage_old91 as lineage_old, @lineage_new91 as lineage_new, @generation91 as generation  union all 
    select @rowguid92 as rowguid, @metadata_type92 as metadata_type, @lineage_old92 as lineage_old, @lineage_new92 as lineage_new, @generation92 as generation  union all 
    select @rowguid93 as rowguid, @metadata_type93 as metadata_type, @lineage_old93 as lineage_old, @lineage_new93 as lineage_new, @generation93 as generation  union all 
    select @rowguid94 as rowguid, @metadata_type94 as metadata_type, @lineage_old94 as lineage_old, @lineage_new94 as lineage_new, @generation94 as generation  union all 
    select @rowguid95 as rowguid, @metadata_type95 as metadata_type, @lineage_old95 as lineage_old, @lineage_new95 as lineage_new, @generation95 as generation  union all 
    select @rowguid96 as rowguid, @metadata_type96 as metadata_type, @lineage_old96 as lineage_old, @lineage_new96 as lineage_new, @generation96 as generation  union all 
    select @rowguid97 as rowguid, @metadata_type97 as metadata_type, @lineage_old97 as lineage_old, @lineage_new97 as lineage_new, @generation97 as generation  union all 
    select @rowguid98 as rowguid, @metadata_type98 as metadata_type, @lineage_old98 as lineage_old, @lineage_new98 as lineage_new, @generation98 as generation  union all 
    select @rowguid99 as rowguid, @metadata_type99 as metadata_type, @lineage_old99 as lineage_old, @lineage_new99 as lineage_new, @generation99 as generation  union all 
    select @rowguid100 as rowguid, @metadata_type100 as metadata_type, @lineage_old100 as lineage_old, @lineage_new100 as lineage_new, @generation100 as generation  
        ) as rows
        left outer join dbo.MSmerge_tombstone tomb with (rowlock) 
        on tomb.rowguid = rows.rowguid 
        and tomb.tablenick = 21696010
        and rows.rowguid is not NULL and rows.lineage_new is not null
        where tomb.rowguid is NULL 
        and rows.rowguid is not NULL and rows.lineage_new is not null
        
        if @@error<>0
            goto Failure 
        -- now delete the contents rows
        delete dbo.MSmerge_contents with (rowlock)
        from 
        ( 
         select @rowguid1 as rowguid union all 
         select @rowguid2 as rowguid union all 
         select @rowguid3 as rowguid union all 
         select @rowguid4 as rowguid union all 
         select @rowguid5 as rowguid union all 
         select @rowguid6 as rowguid union all 
         select @rowguid7 as rowguid union all 
         select @rowguid8 as rowguid union all 
         select @rowguid9 as rowguid union all 
         select @rowguid10 as rowguid union all 
         select @rowguid11 as rowguid union all 
         select @rowguid12 as rowguid union all 
         select @rowguid13 as rowguid union all 
         select @rowguid14 as rowguid union all 
         select @rowguid15 as rowguid union all 
         select @rowguid16 as rowguid union all 
         select @rowguid17 as rowguid union all 
         select @rowguid18 as rowguid union all 
         select @rowguid19 as rowguid union all 
         select @rowguid20 as rowguid union all 
         select @rowguid21 as rowguid union all 
         select @rowguid22 as rowguid union all 
         select @rowguid23 as rowguid union all 
         select @rowguid24 as rowguid union all 
         select @rowguid25 as rowguid union all 
         select @rowguid26 as rowguid union all 
         select @rowguid27 as rowguid union all 
         select @rowguid28 as rowguid union all 
         select @rowguid29 as rowguid union all 
         select @rowguid30 as rowguid union all 
         select @rowguid31 as rowguid union all 
         select @rowguid32 as rowguid union all 
         select @rowguid33 as rowguid union all 
         select @rowguid34 as rowguid union all 
         select @rowguid35 as rowguid union all 
         select @rowguid36 as rowguid union all 
         select @rowguid37 as rowguid union all 
         select @rowguid38 as rowguid union all 
         select @rowguid39 as rowguid union all 
         select @rowguid40 as rowguid union all 
         select @rowguid41 as rowguid union all 
         select @rowguid42 as rowguid union all 
         select @rowguid43 as rowguid union all 
         select @rowguid44 as rowguid union all 
         select @rowguid45 as rowguid union all 
         select @rowguid46 as rowguid union all 
         select @rowguid47 as rowguid union all 
         select @rowguid48 as rowguid union all 
         select @rowguid49 as rowguid union all 
         select @rowguid50 as rowguid union all 
         select @rowguid51 as rowguid union all 
         select @rowguid52 as rowguid union all 
         select @rowguid53 as rowguid union all 
         select @rowguid54 as rowguid union all 
         select @rowguid55 as rowguid union all 
         select @rowguid56 as rowguid union all 
         select @rowguid57 as rowguid union all 
         select @rowguid58 as rowguid union all 
         select @rowguid59 as rowguid union all 
         select @rowguid60 as rowguid union all 
         select @rowguid61 as rowguid union all 
         select @rowguid62 as rowguid union all 
         select @rowguid63 as rowguid union all 
         select @rowguid64 as rowguid union all 
         select @rowguid65 as rowguid union all 
         select @rowguid66 as rowguid union all 
         select @rowguid67 as rowguid union all 
         select @rowguid68 as rowguid union all 
         select @rowguid69 as rowguid union all 
         select @rowguid70 as rowguid union all 
         select @rowguid71 as rowguid union all 
         select @rowguid72 as rowguid union all 
         select @rowguid73 as rowguid union all 
         select @rowguid74 as rowguid union all 
         select @rowguid75 as rowguid union all 
         select @rowguid76 as rowguid union all 
         select @rowguid77 as rowguid union all 
         select @rowguid78 as rowguid union all 
         select @rowguid79 as rowguid union all 
         select @rowguid80 as rowguid union all 
         select @rowguid81 as rowguid union all 
         select @rowguid82 as rowguid union all 
         select @rowguid83 as rowguid union all 
         select @rowguid84 as rowguid union all 
         select @rowguid85 as rowguid union all 
         select @rowguid86 as rowguid union all 
         select @rowguid87 as rowguid union all 
         select @rowguid88 as rowguid union all 
         select @rowguid89 as rowguid union all 
         select @rowguid90 as rowguid union all 
         select @rowguid91 as rowguid union all 
         select @rowguid92 as rowguid union all 
         select @rowguid93 as rowguid union all 
         select @rowguid94 as rowguid union all 
         select @rowguid95 as rowguid union all 
         select @rowguid96 as rowguid union all 
         select @rowguid97 as rowguid union all 
         select @rowguid98 as rowguid union all 
         select @rowguid99 as rowguid union all 
         select @rowguid100 as rowguid 
        ) as rows, dbo.MSmerge_contents cont with (rowlock)
        where cont.rowguid = rows.rowguid and cont.tablenick = 21696010
            and rows.rowguid is not NULL
        option (force order, loop join)
        if @@error<>0 
            goto Failure
    end 
    exec @retcode = sys.sp_MSdeletemetadataactionrequest '088C2847-4D1D-4D57-8FED-3D0B087A6766', 21696010, 
        @rowguid1, 
        @rowguid2, 
        @rowguid3, 
        @rowguid4, 
        @rowguid5, 
        @rowguid6, 
        @rowguid7, 
        @rowguid8, 
        @rowguid9, 
        @rowguid10, 
        @rowguid11, 
        @rowguid12, 
        @rowguid13, 
        @rowguid14, 
        @rowguid15, 
        @rowguid16, 
        @rowguid17, 
        @rowguid18, 
        @rowguid19, 
        @rowguid20, 
        @rowguid21, 
        @rowguid22, 
        @rowguid23, 
        @rowguid24, 
        @rowguid25, 
        @rowguid26, 
        @rowguid27, 
        @rowguid28, 
        @rowguid29, 
        @rowguid30, 
        @rowguid31, 
        @rowguid32, 
        @rowguid33, 
        @rowguid34, 
        @rowguid35, 
        @rowguid36, 
        @rowguid37, 
        @rowguid38, 
        @rowguid39, 
        @rowguid40, 
        @rowguid41, 
        @rowguid42, 
        @rowguid43, 
        @rowguid44, 
        @rowguid45, 
        @rowguid46, 
        @rowguid47, 
        @rowguid48, 
        @rowguid49, 
        @rowguid50, 
        @rowguid51, 
        @rowguid52, 
        @rowguid53, 
        @rowguid54, 
        @rowguid55, 
        @rowguid56, 
        @rowguid57, 
        @rowguid58, 
        @rowguid59, 
        @rowguid60, 
        @rowguid61, 
        @rowguid62, 
        @rowguid63, 
        @rowguid64, 
        @rowguid65, 
        @rowguid66, 
        @rowguid67, 
        @rowguid68, 
        @rowguid69, 
        @rowguid70, 
        @rowguid71, 
        @rowguid72, 
        @rowguid73, 
        @rowguid74, 
        @rowguid75, 
        @rowguid76, 
        @rowguid77, 
        @rowguid78, 
        @rowguid79, 
        @rowguid80, 
        @rowguid81, 
        @rowguid82, 
        @rowguid83, 
        @rowguid84, 
        @rowguid85, 
        @rowguid86, 
        @rowguid87, 
        @rowguid88, 
        @rowguid89, 
        @rowguid90, 
        @rowguid91, 
        @rowguid92, 
        @rowguid93, 
        @rowguid94, 
        @rowguid95, 
        @rowguid96, 
        @rowguid97, 
        @rowguid98, 
        @rowguid99, 
        @rowguid100
    if @retcode<>0 or @@error<>0
        goto Failure
 
    commit tran
    return 1

Failure:
    rollback tran batchdeleteproc
    commit tran
    return 0
end
GO
