/****** Object:  Table [dbo].[tbl_OEMWeeklySettings]    Script Date: 9/20/2017 5:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_OEMWeeklySettings](
	[TopNOEM] [int] NULL,
	[Weekday] [varchar](255) NULL,
	[CreatedBy] [varchar](255) NULL,
	[ModifiedBy] [varchar](255) NULL,
	[Active] [bit] NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Repricing OEM Eligibility] [int] NULL
)

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbl_OEMWeeklySettings] ON 

INSERT [dbo].[tbl_OEMWeeklySettings] ([TopNOEM], [Weekday], [CreatedBy], [ModifiedBy], [Active], [ID], [Repricing OEM Eligibility]) VALUES (20, N'Wednesday', N'v-gokadi', N'v-kipech', 0, 1, 14)
SET IDENTITY_INSERT [dbo].[tbl_OEMWeeklySettings] OFF
