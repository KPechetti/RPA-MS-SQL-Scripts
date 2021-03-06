/****** Object:  Table [dbo].[tbl_PFCompleteList]    Script Date: 9/11/2017 3:37:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_PFCompleteList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProcessorList] [nvarchar](250) NULL,
	[FormFactors] [nvarchar](100) NULL,
	[Platform] [nvarchar](100) NULL,
	[FullModel] [nvarchar](100) NULL,
	[Brand] [nvarchar](100) NULL,
	[ModelSeries] [nvarchar](100) NULL,
	[Model#] [nvarchar](100) NULL,
	[DeletedYN] [bit] NULL,
	[LastUpdatedOn] [datetime] NULL,
	[LastUpdatedBy] [nvarchar](100) NULL
)

GO
ALTER TABLE [dbo].[tbl_PFCompleteList] ADD  DEFAULT ((0)) FOR [DeletedYN]
GO
ALTER TABLE [dbo].[tbl_PFCompleteList] ADD  DEFAULT (getdate()) FOR [LastUpdatedOn]
GO
