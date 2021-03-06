/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.4001)
    Source Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/
USE [db]
GO
/****** Object:  Table [dbo].[delayTable]    Script Date: 29-10-2017 21:37:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[delayTable](
	[date] [nvarchar](85) NULL,
	[trainNo] [nvarchar](10) NULL,
	[station] [nvarchar](125) NULL,
	[ETA] [nvarchar](50) NULL,
	[delayArr] [int] NULL,
	[ETD] [nvarchar](50) NULL,
	[delayDep] [int] NULL
) ON [PRIMARY]
GO
