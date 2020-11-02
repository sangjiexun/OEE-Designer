-- SQL Server script file, schema version 4
-- set to your database name
USE [OEE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

/****** Plant Entity table ******/
IF OBJECT_ID('dbo.PLANT_ENTITY', 'U') IS NOT NULL 
  DROP TABLE dbo.PLANT_ENTITY
GO

CREATE TABLE [dbo].[PLANT_ENTITY](
	[ENT_KEY] [bigint] IDENTITY(1,1) NOT NULL,
	[VERSION] [int] NULL,
	[NAME] [nvarchar](64) NULL,
	[DESCRIPTION] [nvarchar](256) NULL,
	[PARENT_KEY] [bigint] NULL,
	[HIER_LEVEL] [nvarchar](16) NULL,
	[RETENTION] [bigint] NULL
	CONSTRAINT [PK_PLANT_ENTITY] PRIMARY KEY CLUSTERED 
(
	[ENT_KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_NAME] ON [dbo].[PLANT_ENTITY]
(
	[NAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Reason table ******/
IF OBJECT_ID('dbo.REASON', 'U') IS NOT NULL 
  DROP TABLE dbo.REASON
GO

CREATE TABLE [dbo].[REASON](
	[REASON_KEY] [bigint] IDENTITY(1,1) NOT NULL,
	[VERSION] [int] NULL,
	[NAME] [nvarchar](64) NULL,
	[DESCRIPTION] [nvarchar](128) NULL,
	[PARENT_KEY] [bigint] NULL,
	[LOSS] [nvarchar](32) NULL
	CONSTRAINT [PK_REASON] PRIMARY KEY CLUSTERED 
(
	[REASON_KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_NAME] ON [dbo].[REASON]
(
	[NAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Material table ******/
IF OBJECT_ID('dbo.MATERIAL', 'U') IS NOT NULL 
  DROP TABLE dbo.MATERIAL
GO

CREATE TABLE [dbo].[MATERIAL](
	[MAT_KEY] [bigint] IDENTITY(1,1) NOT NULL,
	[VERSION] [int] NULL,
	[NAME] [nvarchar](64) NULL,
	[DESCRIPTION] [nvarchar](128) NULL,
	[CATEGORY] [nvarchar](32) NULL
	CONSTRAINT [PK_MATERIAL] PRIMARY KEY CLUSTERED 
(
	[MAT_KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_NAME] ON [dbo].[MATERIAL]
(
	[NAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Equipment Material table ******/
IF OBJECT_ID('dbo.EQUIPMENT_MATERIAL', 'U') IS NOT NULL 
  DROP TABLE dbo.EQUIPMENT_MATERIAL
GO

CREATE TABLE [dbo].[EQUIPMENT_MATERIAL](
	[EM_KEY] [bigint] IDENTITY(1,1) NOT NULL,
	[MAT_KEY] [bigint] NULL,
	[EQ_KEY] [bigint] NULL,
	[OEE_TARGET] [float] NULL,
	[RUN_AMOUNT] [float] NULL,
	[RUN_UOM_KEY] [bigint] NULL,
	[REJECT_UOM_KEY] [bigint] NULL,
	[IS_DEFAULT] [smallint] NOT NULL
	CONSTRAINT [PK_EQ_MATL] PRIMARY KEY CLUSTERED 
(
	[EM_KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Data Source table ******/
IF OBJECT_ID('dbo.DATA_SOURCE', 'U') IS NOT NULL 
  DROP TABLE dbo.DATA_SOURCE
GO

CREATE TABLE [dbo].[DATA_SOURCE](
	[SOURCE_KEY] [bigint] IDENTITY(1,1) NOT NULL,
	[VERSION] [int] NOT NULL,
	[NAME] [nvarchar](64) NOT NULL,
	[DESCRIPTION] [nvarchar](128) NULL,
	[TYPE] [nvarchar](16) NOT NULL,
	[HOST] [nvarchar](128) NULL,
	[USER_NAME] [nvarchar](64) NULL,
	[PASSWORD] [nvarchar](64) NULL,
	[PORT] [int] NULL,
	[END_PATH] [nvarchar](128) NULL,
	[SEC_POLICY] [nvarchar](64) NULL,
	[MSG_MODE] [nvarchar](64) NULL,
	[KEYSTORE] [nvarchar](128) NULL,
	[KEYSTORE_PWD] [nvarchar](64) NULL
	CONSTRAINT [PK_SOURCE] PRIMARY KEY CLUSTERED 
(
	[SOURCE_KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_NAME] ON [dbo].[DATA_SOURCE]
(
	[NAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Event Resolver table ******/
IF OBJECT_ID('dbo.EVENT_RESOLVER', 'U') IS NOT NULL 
  DROP TABLE dbo.EVENT_RESOLVER
GO

CREATE TABLE [dbo].[EVENT_RESOLVER](
	[ER_KEY] [bigint] IDENTITY(1,1) NOT NULL,
	[ENT_KEY] [bigint] NULL,
	[SOURCE_ID] [nvarchar](128) NULL,
	[SCRIPT] [nvarchar](4000) NULL,
	[SOURCE_KEY] [bigint] NULL,
	[PERIOD] [int] NULL,
	[ER_TYPE] [nvarchar](16) NULL,
	[DATA_TYPE] [nvarchar](32) NULL,
	[COLLECT_KEY] [bigint] NULL
	CONSTRAINT [PK_RESOLVER] PRIMARY KEY CLUSTERED 
(
	[ER_KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_SOURCE_ID] ON [dbo].[EVENT_RESOLVER]
(
	[SOURCE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Unit of Measure table ******/
IF OBJECT_ID('dbo.UOM', 'U') IS NOT NULL 
  DROP TABLE dbo.UOM; 
GO

CREATE TABLE [dbo].[UOM](
	[UOM_KEY] [bigint] IDENTITY(1,1) NOT NULL,
	[VERSION] [int] NOT NULL,
	[NAME] [nvarchar](64) NULL,
	[SYMBOL] [nvarchar](16) NOT NULL,
	[DESCRIPTION] [nvarchar](512) NULL,
	[CATEGORY] [nvarchar](64) NULL,
	[UNIT_TYPE] [nvarchar](32) NULL,
	[UNIT] [nvarchar](32) NULL,
	[CONV_FACTOR] [float] NULL,
	[CONV_UOM_KEY] [bigint] NULL,
	[CONV_OFFSET] [float] NULL,
	[BRIDGE_FACTOR] [float] NULL,
	[BRIDGE_UOM_KEY] [bigint] NULL,
	[BRIDGE_OFFSET] [float] NULL,
	[UOM1_KEY] [bigint] NULL,
	[EXP1] [int] NULL,
	[UOM2_KEY] [bigint] NULL,
	[EXP2] [int] NULL
 CONSTRAINT [PK_UOM] PRIMARY KEY CLUSTERED 
(
	[UOM_KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_SYMBOL] UNIQUE NONCLUSTERED 
(
	[SYMBOL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** WORK_SCHEDULE table ******/
IF OBJECT_ID('dbo.WORK_SCHEDULE', 'U') IS NOT NULL 
  DROP TABLE dbo.WORK_SCHEDULE; 
GO

CREATE TABLE [dbo].[WORK_SCHEDULE](
	[WS_KEY] [bigint] IDENTITY(1,1) NOT NULL,
	[VERSION] [int] NULL,
	[NAME] [nvarchar](64) NULL,
	[DESCRIPTION] [nvarchar](512) NULL
	CONSTRAINT [PK_SCHEDULE] PRIMARY KEY CLUSTERED 
(
	[WS_KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_NAME] ON [dbo].[WORK_SCHEDULE]
(
	[NAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** SHIFT table ******/
IF OBJECT_ID('dbo.SHIFT', 'U') IS NOT NULL 
  DROP TABLE dbo.SHIFT; 
GO

CREATE TABLE [dbo].[SHIFT](
	[SHIFT_KEY] [bigint] IDENTITY(1,1) NOT NULL,
	[NAME] [nvarchar](64) NULL,
	[DESCRIPTION] [nvarchar](128) NULL,
	[START_TIME] [time](3) NULL,
	[DURATION] [bigint] NULL,
	[WS_KEY] [bigint] NULL
	CONSTRAINT [PK_SHIFT] PRIMARY KEY CLUSTERED 
(
	[SHIFT_KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_NAME] ON [dbo].[SHIFT]
(
	[NAME] ASC,
	[WS_KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** TEAM table ******/
IF OBJECT_ID('dbo.TEAM', 'U') IS NOT NULL 
  DROP TABLE dbo.TEAM; 
GO

CREATE TABLE [dbo].[TEAM](
	[TEAM_KEY] [bigint] IDENTITY(1,1) NOT NULL,
	[NAME] [nvarchar](64) NULL,
	[DESCRIPTION] [nvarchar](128) NULL,
	[WS_KEY] [bigint] NULL,
	[ROTATION_KEY] [bigint] NULL,
	[ROTATION_START] [date] NULL
	CONSTRAINT [PK_TEAM] PRIMARY KEY CLUSTERED 
(
	[TEAM_KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_NAME] ON [dbo].[TEAM]
(
	[NAME] ASC,
	[WS_KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** ROTATION table ******/
IF OBJECT_ID('dbo.ROTATION', 'U') IS NOT NULL 
  DROP TABLE dbo.ROTATION; 
GO

CREATE TABLE [dbo].[ROTATION](
	[ROTATION_KEY] [bigint] IDENTITY(1,1) NOT NULL,
	[NAME] [nvarchar](64) NULL,
	[DESCRIPTION] [nvarchar](128) NULL,
	[WS_KEY] [bigint] NULL,
	CONSTRAINT [PK_ROTATION] PRIMARY KEY CLUSTERED 
(
	[ROTATION_KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** ROTATION_SEGMENT table ******/
IF OBJECT_ID('dbo.ROTATION_SEGMENT', 'U') IS NOT NULL 
  DROP TABLE dbo.ROTATION_SEGMENT; 
GO

CREATE TABLE [dbo].[ROTATION_SEGMENT](
	[SEGMENT_KEY] [bigint] IDENTITY(1,1) NOT NULL,
	[ROTATION_KEY] [bigint] NULL,
	[SEQUENCE] [smallint] NULL,
	[SHIFT_KEY] [bigint] NULL,
	[DAYS_ON] [smallint] NULL,
	[DAYS_OFF] [smallint] NULL
	CONSTRAINT [PK_ROT_SEG] PRIMARY KEY CLUSTERED 
(
	[SEGMENT_KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** NON_WORKING_PERIOD table ******/
IF OBJECT_ID('dbo.NON_WORKING_PERIOD', 'U') IS NOT NULL 
  DROP TABLE dbo.NON_WORKING_PERIOD; 
GO

CREATE TABLE [dbo].[NON_WORKING_PERIOD](
	[PERIOD_KEY] [bigint] IDENTITY(1,1) NOT NULL,
	[NAME] [nvarchar](64) NULL,
	[DESCRIPTION] [nvarchar](128) NULL,
	[START_DATE_TIME] [datetime] NULL,
	[DURATION] [bigint] NULL,
	[WS_KEY] [bigint] NULL,
	[LOSS] [nvarchar](32) NULL
	CONSTRAINT [PK_NW_PERIOD] PRIMARY KEY CLUSTERED 
(
	[PERIOD_KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** COLLECTOR table ******/
IF OBJECT_ID('dbo.COLLECTOR', 'U') IS NOT NULL 
  DROP TABLE dbo.COLLECTOR 
GO

CREATE TABLE [dbo].[COLLECTOR](
	[COLLECT_KEY] [bigint] IDENTITY(1,1) NOT NULL,
	[VERSION] [int] NULL,
	[NAME] [nvarchar](64) NULL,
	[DESCRIPTION] [nvarchar](128) NULL,
	[STATE] [nvarchar](16) NULL,
	[HOST] [nvarchar](64) NULL,
	[BROKER_HOST] [nvarchar](64) NULL,
	[BROKER_PORT] [int] NULL,
	[BROKER_USER] [nvarchar](64) NULL,
	[BROKER_PWD] [nvarchar](64) NULL,
	[BROKER_TYPE] [nvarchar](16) NULL,
	[SOURCE_KEY] [bigint] NULL
	CONSTRAINT [PK_COLLECTOR] PRIMARY KEY CLUSTERED 
(
	[COLLECT_KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_NAME] ON [dbo].[COLLECTOR]
(
	[NAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** OEE_EVENT table ******/
IF OBJECT_ID('dbo.OEE_EVENT', 'U') IS NOT NULL 
  DROP TABLE dbo.OEE_EVENT 
GO

CREATE TABLE [dbo].[OEE_EVENT](
	[EVENT_KEY] [bigint] IDENTITY(1,1) NOT NULL,
	[ENT_KEY] [bigint] NOT NULL,
	[START_TIME] [datetime2](3) NOT NULL,
	[START_TIME_OFFSET] [int] NOT NULL,
	[END_TIME] [datetime2](3) NULL,
	[END_TIME_OFFSET] [int] NULL,
	[SHIFT_KEY] [bigint] NULL,
	[TEAM_KEY] [bigint] NULL,
	[REASON_KEY] [bigint] NULL,
	[DURATION] [bigint] NULL,
	[EVENT_TYPE] [nvarchar](16) NOT NULL,
	[AMOUNT] [float] NULL,
	[UOM_KEY] [bigint] NULL,
	[MATL_KEY] [bigint] NULL,
	[JOB] [nvarchar](64) NULL,
	[IN_VALUE] [nvarchar](64) NULL,
	[SOURCE_ID] [nvarchar](64) NULL,
	[COLLECTOR] [nvarchar](64) NULL,
	CONSTRAINT [PK_EVENT] PRIMARY KEY CLUSTERED 
(
	[EVENT_KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX [IDX_ENT_TYPE_START] ON [dbo].[OEE_EVENT]
(
	[ENT_KEY] ASC,
	[EVENT_TYPE] ASC,
	[START_TIME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

/****** Plant Entity Work Schedule table ******/
IF OBJECT_ID('dbo.ENTITY_SCHEDULE', 'U') IS NOT NULL 
  DROP TABLE dbo.ENTITY_SCHEDULE
GO

CREATE TABLE [dbo].[ENTITY_SCHEDULE](
	[ES_KEY] [bigint] IDENTITY(1,1) NOT NULL,
	[ENT_KEY] [bigint] NULL,
	[WS_KEY] [bigint] NULL,
	[START_DATE_TIME] [datetime] NULL,
	[END_DATE_TIME] [datetime] NULL
	CONSTRAINT [PK_ENT_WS] PRIMARY KEY CLUSTERED 
(
	[ES_KEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO






