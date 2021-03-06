/****** Object:  Table [dbo].[tbl_PFProcesorList]    Script Date: 9/11/2017 3:30:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_PFProcesorList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DeviceCategory] [nvarchar](250) NOT NULL,
	[DevelopedMarket(DM)] [nvarchar](100) NOT NULL,
	[EmergingMarket(DM)] [nvarchar](100) NOT NULL,
	[ODM] [nvarchar](100) NOT NULL,
	[DeletedYN] [bit] NULL,
	[LastUpdatedOn] [datetime] NULL,
	[LastUpdatedBy] [nvarchar](100) NULL,
	[RawFileDeviceCategory] [nvarchar](250) NULL
)

GO
SET IDENTITY_INSERT [dbo].[tbl_PFProcesorList] ON 

INSERT [dbo].[tbl_PFProcesorList] ([ID], [DeviceCategory], [DevelopedMarket(DM)], [EmergingMarket(DM)], [ODM], [DeletedYN], [LastUpdatedOn], [LastUpdatedBy], [RawFileDeviceCategory]) VALUES (1, N'WW Home Small Tablet', N'A', N'A', N'A', 0, CAST(0x0000A7E600784870 AS DateTime), N'V-VENNSU', N'Windows 10 Home Small Tablet | 2 in 1')
INSERT [dbo].[tbl_PFProcesorList] ([ID], [DeviceCategory], [DevelopedMarket(DM)], [EmergingMarket(DM)], [ODM], [DeletedYN], [LastUpdatedOn], [LastUpdatedBy], [RawFileDeviceCategory]) VALUES (2, N'WW Home for Stick PC', N'B', N'B', N'B', 0, CAST(0x0000A7E60079DC8E AS DateTime), N'V-VENNSU', N'Windows 10 Home PC on a Stick')
INSERT [dbo].[tbl_PFProcesorList] ([ID], [DeviceCategory], [DevelopedMarket(DM)], [EmergingMarket(DM)], [ODM], [DeletedYN], [LastUpdatedOn], [LastUpdatedBy], [RawFileDeviceCategory]) VALUES (3, N'WW Home Entry Notebook', N'C', N'C', N'C', 0, CAST(0x0000A7E60079DC8E AS DateTime), N'V-VENNSU', N'Windows 10 Home Entry Notebook')
INSERT [dbo].[tbl_PFProcesorList] ([ID], [DeviceCategory], [DevelopedMarket(DM)], [EmergingMarket(DM)], [ODM], [DeletedYN], [LastUpdatedOn], [LastUpdatedBy], [RawFileDeviceCategory]) VALUES (4, N'Home Value Notebook', N'C', N'C', N'n/a', 0, CAST(0x0000A7E60079DC8E AS DateTime), N'V-VENNSU', N'Windows 10 Home Value Notebook')
INSERT [dbo].[tbl_PFProcesorList] ([ID], [DeviceCategory], [DevelopedMarket(DM)], [EmergingMarket(DM)], [ODM], [DeletedYN], [LastUpdatedOn], [LastUpdatedBy], [RawFileDeviceCategory]) VALUES (5, N'Home Value Desktop / AiO', N'D', N'D', N'n/a', 0, CAST(0x0000A7E60079DC8E AS DateTime), N'V-VENNSU', N'Windows 10 Home Value Desktops | AiOs')
INSERT [dbo].[tbl_PFProcesorList] ([ID], [DeviceCategory], [DevelopedMarket(DM)], [EmergingMarket(DM)], [ODM], [DeletedYN], [LastUpdatedOn], [LastUpdatedBy], [RawFileDeviceCategory]) VALUES (6, N'WW Home Value 2 in 1', N'E', N'E', N'n/a', 0, CAST(0x0000A7E60079DC8E AS DateTime), N'V-VENNSU', N'Windows 10 Home Value Tablet | 2 in 1')
INSERT [dbo].[tbl_PFProcesorList] ([ID], [DeviceCategory], [DevelopedMarket(DM)], [EmergingMarket(DM)], [ODM], [DeletedYN], [LastUpdatedOn], [LastUpdatedBy], [RawFileDeviceCategory]) VALUES (7, N'WW Home Entry Desktop/AiO', N'F', N'F', N'F', 0, CAST(0x0000A7E60079DC8E AS DateTime), N'V-VENNSU', N'Windows 10 Home Entry Desktops | AiOs')
INSERT [dbo].[tbl_PFProcesorList] ([ID], [DeviceCategory], [DevelopedMarket(DM)], [EmergingMarket(DM)], [ODM], [DeletedYN], [LastUpdatedOn], [LastUpdatedBy], [RawFileDeviceCategory]) VALUES (8, N'WW Home High End', N'G', N'G', N'n/a', 0, CAST(0x0000A7E60079DC8E AS DateTime), N'V-VENNSU', N'')
INSERT [dbo].[tbl_PFProcesorList] ([ID], [DeviceCategory], [DevelopedMarket(DM)], [EmergingMarket(DM)], [ODM], [DeletedYN], [LastUpdatedOn], [LastUpdatedBy], [RawFileDeviceCategory]) VALUES (9, N'STF Entry Desktop/AiO', N'H', N'H', N'n/a', 0, CAST(0x0000A7E6007B721E AS DateTime), N'V-VENNSU', N'')
INSERT [dbo].[tbl_PFProcesorList] ([ID], [DeviceCategory], [DevelopedMarket(DM)], [EmergingMarket(DM)], [ODM], [DeletedYN], [LastUpdatedOn], [LastUpdatedBy], [RawFileDeviceCategory]) VALUES (10, N'STF Value 2 in 1', N'I', N'I', N'n/a', 0, CAST(0x0000A7E6007B721E AS DateTime), N'V-VENNSU', N'')
INSERT [dbo].[tbl_PFProcesorList] ([ID], [DeviceCategory], [DevelopedMarket(DM)], [EmergingMarket(DM)], [ODM], [DeletedYN], [LastUpdatedOn], [LastUpdatedBy], [RawFileDeviceCategory]) VALUES (11, N'STF Value Notebook', N'J', N'J', N'n/a', 0, CAST(0x0000A7E6007B721E AS DateTime), N'V-VENNSU', N'')
INSERT [dbo].[tbl_PFProcesorList] ([ID], [DeviceCategory], [DevelopedMarket(DM)], [EmergingMarket(DM)], [ODM], [DeletedYN], [LastUpdatedOn], [LastUpdatedBy], [RawFileDeviceCategory]) VALUES (12, N'STF Pro Tablet and Small Tablet', N'K', N'K', N'n/a', 0, CAST(0x0000A7E6007B721E AS DateTime), N'V-VENNSU', N'')
INSERT [dbo].[tbl_PFProcesorList] ([ID], [DeviceCategory], [DevelopedMarket(DM)], [EmergingMarket(DM)], [ODM], [DeletedYN], [LastUpdatedOn], [LastUpdatedBy], [RawFileDeviceCategory]) VALUES (13, N'STF High End', N'L', N'L', N'n/a', 0, CAST(0x0000A7E6007B721E AS DateTime), N'V-VENNSU', N'')
INSERT [dbo].[tbl_PFProcesorList] ([ID], [DeviceCategory], [DevelopedMarket(DM)], [EmergingMarket(DM)], [ODM], [DeletedYN], [LastUpdatedOn], [LastUpdatedBy], [RawFileDeviceCategory]) VALUES (14, N'WW Pro Small Tablet', N'M', N'M', N'M', 0, CAST(0x0000A7E6007B721E AS DateTime), N'V-VENNSU', N'Windows 10 Pro Small Tablet | 2 in 1')
INSERT [dbo].[tbl_PFProcesorList] ([ID], [DeviceCategory], [DevelopedMarket(DM)], [EmergingMarket(DM)], [ODM], [DeletedYN], [LastUpdatedOn], [LastUpdatedBy], [RawFileDeviceCategory]) VALUES (15, N'WW Pro Tablet & 2 in 1', N'M', N'M', N'M', 0, CAST(0x0000A7E6007B721E AS DateTime), N'V-VENNSU', N'Windows 10 Pro Tablet | 2 in 1')
INSERT [dbo].[tbl_PFProcesorList] ([ID], [DeviceCategory], [DevelopedMarket(DM)], [EmergingMarket(DM)], [ODM], [DeletedYN], [LastUpdatedOn], [LastUpdatedBy], [RawFileDeviceCategory]) VALUES (16, N'WW Pro Entry Notebook', N'N', N'N', N'N', 0, CAST(0x0000A7E6007B721E AS DateTime), N'V-VENNSU', N'')
INSERT [dbo].[tbl_PFProcesorList] ([ID], [DeviceCategory], [DevelopedMarket(DM)], [EmergingMarket(DM)], [ODM], [DeletedYN], [LastUpdatedOn], [LastUpdatedBy], [RawFileDeviceCategory]) VALUES (17, N'WW Pro Entry Desktop / AiO', N'O', N'O', N'O', 0, CAST(0x0000A7E6007B721E AS DateTime), N'V-VENNSU', N'Windows 10 Pro Entry Desktops | AiOs')
INSERT [dbo].[tbl_PFProcesorList] ([ID], [DeviceCategory], [DevelopedMarket(DM)], [EmergingMarket(DM)], [ODM], [DeletedYN], [LastUpdatedOn], [LastUpdatedBy], [RawFileDeviceCategory]) VALUES (18, N'WW Pro Entry Stick PC', N'P', N'P', N'P', 0, CAST(0x0000A7E6007B721E AS DateTime), N'V-VENNSU', N'')
SET IDENTITY_INSERT [dbo].[tbl_PFProcesorList] OFF
ALTER TABLE [dbo].[tbl_PFProcesorList] ADD  DEFAULT ((0)) FOR [DeletedYN]
GO
ALTER TABLE [dbo].[tbl_PFProcesorList] ADD  DEFAULT (getdate()) FOR [LastUpdatedOn]
GO
