/****** Object:  StoredProcedure [dbo].[GetFailuresFromRawFile]    Script Date: 9/18/2017 3:24:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetFailuresFromRawFile]
(
			@OEMName				varchar(255) = NULL,	
			@ExecutionID			int = NULL,
			@WeekID					int = NULL,
			@DeletedComments		varchar(255) = NULL	
)
AS
BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;
select  'Primary Disk Total Capacity Fail,'+ [Primary Disk Total Capacity] as ColumnValue, count(*) as TotalCount from tbl_pfRawoem 
where WEEKID = @WeekID 
and  ExecutionID = @ExecutionID
and  [OEM Name] = @OEMName
and DeletedYN = 0
and [Primary Disk Total Capacity Validation Result] = 'Fail'
Group by [Primary Disk Total Capacity]
--UNION
--select  'Processor Model Fail,'+ [Processor Model] as ColumnValue, count(*) as TotalCount from tbl_pfRawoem 
--where WEEKID = @WeekID	
--and  ExecutionID = @ExecutionID
--and  [OEM Name] = @OEMName
--and DeletedYN = 0
--and [Processor Model Validation Result] = 'Fail'
--Group by [Processor Model]
UNION
select  'Total Physical RAM Fail,'+ [Total Physical RAM] as ColumnValue, count(*) as TotalCount from tbl_pfRawoem 
where WEEKID = @WeekID	 
and  ExecutionID = @ExecutionID
and  [OEM Name] = @OEMName
and DeletedYN = 0
and [Total Physical RAM Validation Result] = 'Fail'
Group by [Total Physical RAM]
UNION
select  'Primary Display Size Fail,'+ [Primary Display Size (Inch)] as ColumnValue, count(*) as TotalCount from tbl_pfRawoem 
where WEEKID = @WeekID	 
and  ExecutionID = @ExecutionID
and  [OEM Name] = @OEMName
and DeletedYN = 0
and [Display Size Validation Result] = 'Fail'
Group by [Primary Display Size (Inch)]
UNION
select  'Primary Disk Type Fail,'+ [Primary Disk Type] as ColumnValue, count(*) as TotalCount from tbl_pfRawoem 
where WEEKID = @WeekID	
and  ExecutionID = @ExecutionID 
and  [OEM Name] = @OEMName
and DeletedYN = 0
and [Primary Disk Type Validation Result] = 'Fail'
Group by [Primary Disk Type]
UNION
select  'Optical Disk Drive Type Fail,'+ [Optical Disk Drive Type] as ColumnValue, count(*) as TotalCount from tbl_pfRawoem 
where WEEKID = @WeekID	
and  ExecutionID = @ExecutionID 
and  [OEM Name] = @OEMName
and DeletedYN = 0
and [Optical Disk Drive Type Validation Result] = 'Fail'
Group by [Optical Disk Drive Type]
UNION
select  'Digitizer Support Fail,'+ [Digitizer Support] as ColumnValue, count(*) as TotalCount from tbl_pfRawoem 
where WEEKID = @WeekID	
and  ExecutionID = @ExecutionID 
and  [OEM Name] = @OEMName
and DeletedYN = 0
and [Digitizer Support Validation Result] = 'Fail'
Group by [Digitizer Support]
UNION
select  'High End Licensable (SKU) Validation Fail,'+ [High End Licensable (SKU) Validation] as ColumnValue, count(*) as TotalCount from tbl_pfRawoem 
where WEEKID = @WeekID	 
and  ExecutionID = @ExecutionID 
and  [OEM Name] = @OEMName
and DeletedYN = 0
and [High End Licensable (SKU) Validation] = 'Fail'
Group by [High End Licensable (SKU) Validation]
UNION
select 'OHR Only Fail' as ColumnValue, count(*) as TotalCount from tbl_PfRawOEM with(noLock)
	where  ExecutionId = @ExecutionID 
		   AND WeekID = @WeekID
		   AND [OEM Name] = @OEMName		   
		   AND DeletedYN = 0		   
		   AND [Processor Model Validation Result] <> 'Fail' 
		   AND [Total Physical RAM Validation Result] <> 'Fail' 
		   AND [Primary Disk Total Capacity Validation Result] <> 'Fail' 
		   AND [High End Licensable (SKU) Validation] <> 'Fail'
		 --AND [ScreenSizeDiagonal Validation Result] <> 'Fail'
		 --AND [ScreenResolutionDPI Validation Result] <> 'Fail'
		   AND [Display Size Validation Result] <> 'Fail'
		   AND [Display Resolution validation Result] <> 'Fail'	
		   AND [Primary Disk Type Validation Result] <> 'Fail'
		   AND [Optical Disk Drive Type Validation Result] <> 'Fail'
		   AND [Digitizer Support Validation Result] <> 'Fail'	
		   AND ([OHR Form Factor Sub Class Validation Result] = 'Fail'	
		   OR [OHR Form Factor Validation Result] = 'Fail'
		   OR [OHR Touch Validation Result] = 'Fail' 
		   OR [OHR Screen Size Validation Result] = 'Fail') 
END

GO
/****** Object:  StoredProcedure [dbo].[GetFolderLink]    Script Date: 9/18/2017 3:24:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Procedure [dbo].[GetFolderLink]
@SoldTo      NVARCHAR(100) NULL

AS
Begin

select top 1 LinkToReport from tbl_FolderMapping 
where SoldTo = @SoldTo

END
GO
/****** Object:  StoredProcedure [dbo].[GetHardwarePPTRules]    Script Date: 9/18/2017 3:24:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetHardwarePPTRules]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT distinct tbrm.RuleID, tbrm.RuleName, tbrm.OEMName FROM	tbl_BusinessRulesMaster tbrm 
											inner join tbl_Business_SubRules_Master tbsrm on tbrm.RuleID = tbsrm.RuleID 
									where tbrm.DeletedYN = 0
									and (tbrm.EndDate >= getdate() OR EndDate is Null)

END
GO
/****** Object:  StoredProcedure [dbo].[GetRawFileDetailsForNotifications]    Script Date: 9/18/2017 3:24:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetRawFileDetailsForNotifications]
		@ExecutionID		int			  =NULL,
		@OEMName			NVARCHAR(200) =NULL,
		@WeekID				int			  =NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	SELECT  top 1 [OEM Soldto #]+','+[Agreement#] from tbl_PFRawOEM WITH(NOLOCK) WHERE 
	--ExecutionID =@ExecutionID AND 
	[OEM Name] = @OEMName 
	AND WeekID=@WeekID
END
GO
/****** Object:  StoredProcedure [dbo].[InsertOEMData]    Script Date: 9/18/2017 3:24:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------------------------------------
--Stored Procedure for to insert data to MassCollabOEMContacts
--Created By- Gopal Krishna
--Updated date-14-09-2017
-----------------------------------------------------------
CREATE PROCEDURE [dbo].[InsertOEMData]
(
			@OEMsName			nvarchar(100),	
			@MLANumber			nvarchar(100),		
			@SoldTo			    nvarchar(100),	
			@SoldToLocation		nvarchar(100),
			@Vat                decimal         = Null,
			@OEMType            nvarchar(100),
			@ToAlias            nvarchar(100),
			@CCAlias            nvarchar(100),
			@CreatedBy			nvarchar(100),
			@Status             nvarchar(100)   = null output 	
)
AS
BEGIN
     -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;
	BEGIN
			IF EXISTS(select 1 from tbl_MassCollabOEMContacts where [OEMs on Mass Collab]=@OEMsName and [MLA Number]=@MLANumber and SoldTo=@SoldTo and SoldToLocation=@SoldToLocation and [VAT%]=@Vat  and DeletedYN=0)

			BEGIN

				set @Status =  'Record already exists'

				select @Status as Status1

			END

			ELSE

			BEGIN

				INSERT INTO dbo.[tbl_MassCollabOEMContacts] 

					([OEMs on Mass Collab],[MLA Number],SoldTo,SoldToLocation,[VAT%],OEMType,Toalias,CCalias,DeletedYN,CreatedOn,CreatedBy)

					 VALUES

					(@OEMsName,@MLANumber,@SoldTo,@SoldToLocation,@Vat,@OEMType,@ToAlias,@CCAlias,0,GETDATE(),@CreatedBy)

				set  @Status =  'OEM created successfully' 

				select @Status as Status1

			END

	END

END
GO
/****** Object:  StoredProcedure [dbo].[UpdateOEM]    Script Date: 9/18/2017 3:24:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------------------------------------
--Stored Procedure for to Update data in MassCollabOEMContacts
--Created By- Gopal Krishna
--Updated date-14-09-2017
-----------------------------------------------------------
CREATE PROCEDURE [dbo].[UpdateOEM]
(			
		@OEMID				int   = Null,
		@OEMsName			nvarchar(100),	
        @MLANumber			nvarchar(100),		
		@SoldTo			    nvarchar(100),	
		@SoldToLocation		nvarchar(100),
		@Vat                decimal        = Null,
		@OEMType            nvarchar(100),
		@ToAlias            nvarchar(100),
		@CCAlias            nvarchar(100),
		@LastUpdatedBy			nvarchar(100),
		@Status             nvarchar(100)   = null output 
)

AS

BEGIN

      -- SET NOCOUNT ON added to prevent extra result sets from

      -- interfering with SELECT statements.

      SET NOCOUNT ON;
		update [tbl_MassCollabOEMContacts]

						set [OEMs on Mass Collab]		=	@OEMsName,

							[MLA Number]				=	@MLANumber,

							SoldTo						=	@SoldTo,

							SoldToLocation				=   @SoldToLocation,

							[VAT%]						=	@Vat, 
							OEMType                     =   @OEMType,
							Toalias                     = @ToAlias,
							CCalias                     = @CCAlias,

							DeletedYN					=	0,

							LastUpdatedOn				=	Getdate(),

							LastUpdatedBy				=	@LastUpdatedBy

						where ID= @OEMID	

						set  @Status =  'OEM Updated Successfully' 

				select @Status as Status1

	

END

GO
/****** Object:  StoredProcedure [dbo].[usp_DisplayOEMMasterDetails]    Script Date: 9/18/2017 3:24:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------------------------------------
--Stored Procedure for to display MassCollabOEMContacts
--Created By- Gopal Krishna
--Updated date-14-09-2017
-----------------------------------------------------------
CREATE PROCEDURE [dbo].[usp_DisplayOEMMasterDetails]
AS
BEGIN
	Select	ID,
			[OEMs on Mass Collab],
			ISNULL([MLA Number],'') [MLA Number],
			ISNULL(SoldTo,'') SoldTo,
			ISNULL(SoldToLocation,'') SoldToLocation,
			ISNULL([VAT%],0) [VAT%] ,
			ISNULL(OEMType,'') OEMType,
			Toalias,
			ISNULL(CCalias,'') CCalias 
	from tbl_MassCollabOEMContacts where DeletedYN=0
END
GO
