/****** Object:  StoredProcedure [dbo].[CheckForProcessorList]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[CheckForProcessorList]
@sComments nvarchar(250) null
as
BEGIN

if (@sComments='GetListDate')
BEGIN
select top 1 LastUpdatedOn from tbl_pfcompletelist order by 1 desc
END

if (@sComments='TruncateList')
BEGIN
Truncate table tbl_pfcompletelist
END

END
GO
/****** Object:  StoredProcedure [dbo].[CountOfDeletedComments]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CountOfDeletedComments]
(
@ExecutionID int   =NULL,  
@WeekID nvarchar(100) = NULL,  
@OEMName nvarchar(500) = NULL,
@Comments nvarchar(500) = NULL  
)
As
Begin
if(@Comments = 'OHRNationalAcademic')
Begin
	select count(*) from tbl_PfRawOEM with(noLock)
	where  ExecutionId = @ExecutionID 
		   AND WeekID = @WeekID
		   AND [OEM Name] = @OEMName
		   AND DeletedComments = 'National Academic'
		   AND DeletedYN = 1		   
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
ELSE
BEGIN
	select count(*) from tbl_PfRawOEM with(noLock)
	where  ExecutionId = @ExecutionID 
		   AND WeekID = @WeekID
		   AND [OEM Name] = @OEMName
		   AND DeletedComments = @Comments
		   AND DeletedYN = 1
	END
END



	   







	

GO
/****** Object:  StoredProcedure [dbo].[DeleteGMContactDetails]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:			<Gopal Krishna k>
-- Create date:		<07-09-2017>
-- Description:		<This method is used to Delete GM Contact details into database>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteGMContactDetails]

(			

			@GMID				int   = Null	,

			@Status             varchar(100)    = null output 

			

)

AS

BEGIN

      -- SET NOCOUNT ON added to prevent extra result sets from

      -- interfering with SELECT statements.

      SET NOCOUNT ON;	 

	  update tbl_GMContactList

							set DeletedYN = 1,

								LastUpdatedOn = getdate() 

							where ID=@GMID 

							set  @Status =  'OEM Deleted Successfully' 

				select @Status as Status1

	

END

GO
/****** Object:  StoredProcedure [dbo].[EmptyCancelledFile]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[EmptyCancelledFile]
AS
BEGIN
 SELECT 	 
		   
		[Source]

		,[OEM Name] as 'Partner (Sold To)'

		,[OEM Soldto #] as 'Partner Number (Sold To)'

		,[Agreement#] as 'Agreement #'

		,[PKID]

		,[Licensable (SKU)] as 'Licensable Name'

		,[Licensable Part #] as 'Licensable Part Number'

		,[Device Category]

		,[Collection OS]

		,[Product Family] as 'Product Family Name'

		,[Market]

		,[Royalty]

		,[Fulfilment Date] as 'Fulfillment Date'

		,[CBR Submission Date] as 'Build Report Received Date'

		,[Processed Date] 

		,[Last Process Date] as 'Last Processed Date'

		,[Processor Model]

		,[Processor Model Validation Result]

		,[Total Physical RAM]

		,[Total Physical RAM Validation Result]

		,[Primary Disk Total Capacity]

		,[Primary Disk Total Capacity Validation Result]

		,[Internal Primary Display Size Physical Vertical (MM)] as 'Manufacturing Screen Size Physical Y (MM)'

		,[Internal Primary Display Size Physical Horizontal (MM)] as 'Manufacturing Screen Size Physical H (MM)'

		,[Primary Display Size (Inch)] as 'Manufacturing Screen Size (Inch)'

		,[Display Size Validation Result] as 'ScreenSizeDiagonal Validation Result'

		,[Internal Primary Display Resolution Vertical] as 'Display Resolution Vertical'

		,[Internal Primary Display Resolution Horizontal] as 'Display Resolution Horizontal'

		,[Display Resolution Validation Result] as 'ScreenResolutionDPI Validation Result'

		,[Primary Disk Type]

		,[Primary Disk Type Validation Result]

		,[Optical Disk Drive Type]

		,[Optical Disk Drive Type Validation Result]

		,[Digitizer Support] as 'Digitizer Support Name'

		,[Digitizer Support Validation Result]

		,[High End Licensable (SKU) Validation]

		,[OHR Form Factor]

		,[OHR Form Factor Validation Result]

		,[OHR Form Factor Sub Class]

		,[OHR Form Factor Sub Class Validation Result]

		,[Chassis Type Form Factor]

		,[Chassis Type Form Factor Sub Class]

		,[Chassis Type Validation Result]

		,[OHR Touch]

		,[OHR Touch Validation Result]

		,[OHR Screen Size]

		,[OHR Screen Size Validation Result]

		,[OHR Model Number] as 'OHR PC Model Number'

 FROM tbl_PFRawOEM WITH(NOLOCK) 
 where ID =1

END


GO
/****** Object:  StoredProcedure [dbo].[GetCommentsFromtbl_PFRepriceOEMs]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[GetCommentsFromtbl_PFRepriceOEMs]
	-- Add the parameters for the stored procedure here
	@WeekID    NVARCHAR(MAX),
	@OEMName   NVARCHAR(MAX),
	@ProcessExecutionID int
	
AS
BEGIN
SET NOCOUNT ON;
	select Comments 
	FROM  tbl_PFRepriceOEMs 
	WHERE  WeekID =@WeekID AND ReportID =@OEMName AND ProcessExecutionID = @ProcessExecutionID
END


GO
/****** Object:  StoredProcedure [dbo].[GetDeleteCommentsForRawFile]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EXEC [GetDeleteCommentsForRawFile] 1353,20170730,'ASUSTEK COMPUTER INC.'
CREATE PROCEDURE [dbo].[GetDeleteCommentsForRawFile]
@ExecutionID				INT			  = NULL,
@WeekID						INT			  = NULL,
@OEMName					NVARCHAR(200) = NULL
AS
BEGIN
SET NOCOUNT ON;
--Select * from tbl_PFRawOEM 
SELECT COUNT(*) as [Count],DeletedComments FROM tbl_PFRawOEM 
WHERE				ExecutionID = @ExecutionID		AND 
					WeekID		= @WeekID			AND 
					[OEM Name]	= @OEMName			AND 
					DeletedYN	= 1					--AND 
					--DeletedComments = 'Deleted based on HardwarePPT Rules'
GROUP BY DeletedComments
END
GO
/****** Object:  StoredProcedure [dbo].[GetFailuresFromRawFile]    Script Date: 9/11/2017 12:37:44 PM ******/
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

END

GO
/****** Object:  StoredProcedure [dbo].[GetNAORecordsFromRawFileForOEM]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:			<Kishore Kumar Pechetti>
-- Create date:		<08-07-2017>
-- Description:		< This method is used to get NAO deleted records for OEM>
-- exec GetNAORecordsFromRawFileForOEM 'ACER INDIA (PVT) LTD.',1523,20170827,'National Academic'
-- =============================================
CREATE PROCEDURE [dbo].[GetNAORecordsFromRawFileForOEM]
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
	  if(@DeletedComments = 'National Academic')
	  BEGIN
	     ( SELECT 	 

		[Source]

		,[OEM Name] as 'Partner (Sold To)'

		,[OEM Soldto #] as 'Partner Number (Sold To)'

		,[Agreement#] as 'Agreement #'

		,[PKID]

		,[Licensable (SKU)] as 'Licensable Name'

		,[Licensable Part #] as 'Licensable Part Number'

		,[Device Category]

		,[Collection OS]

		,[Product Family] as 'Product Family Name'

		,[Market]

		,[Royalty]

		,[Fulfilment Date] as 'Fulfillment Date'

		,[CBR Submission Date] as 'Build Report Received Date'

		,[Processed Date] 

		,[Last Process Date] as 'Last Processed Date'

		,[Processor Model]

		,[Processor Model Validation Result]

		,[Total Physical RAM]

		,[Total Physical RAM Validation Result]

		,[Primary Disk Total Capacity]

		,[Primary Disk Total Capacity Validation Result]

		,[Internal Primary Display Size Physical Vertical (MM)] as 'Manufacturing Screen Size Physical Y (MM)'

		,[Internal Primary Display Size Physical Horizontal (MM)] as 'Manufacturing Screen Size Physical H (MM)'

		,[Primary Display Size (Inch)] as 'Manufacturing Screen Size (Inch)'

		,[Display Size Validation Result] as 'ScreenSizeDiagonal Validation Result'

		,[Internal Primary Display Resolution Vertical] as 'Display Resolution Vertical'

		,[Internal Primary Display Resolution Horizontal] as 'Display Resolution Horizontal'

		,[Display Resolution Validation Result] as 'ScreenResolutionDPI Validation Result'

		,[Primary Disk Type]

		,[Primary Disk Type Validation Result]

		,[Optical Disk Drive Type]

		,[Optical Disk Drive Type Validation Result]

		,[Digitizer Support] as 'Digitizer Support Name'

		,[Digitizer Support Validation Result]

		,[High End Licensable (SKU) Validation]

		,[OHR Form Factor]

		,[OHR Form Factor Validation Result]

		,[OHR Form Factor Sub Class]

		,[OHR Form Factor Sub Class Validation Result]

		,[Chassis Type Form Factor]

		,[Chassis Type Form Factor Sub Class]

		,[Chassis Type Validation Result]

		,[OHR Touch]

		,[OHR Touch Validation Result]

		,[OHR Screen Size]

		,[OHR Screen Size Validation Result]

		,[OHR Model Number] as 'OHR PC Model Number'

 FROM tbl_PFRawOEM WITH(NOLOCK) 

 WHERE [OEM Name] = @OEMName 

 AND WeekID=@WeekID 

 AND ExecutionID=@ExecutionID 

 AND DeletedComments = @DeletedComments
 )
 Except(
	      SELECT 	 
		[Source]

		,[OEM Name] as 'Partner (Sold To)'

		,[OEM Soldto #] as 'Partner Number (Sold To)'

		,[Agreement#] as 'Agreement #'

		,[PKID]

		,[Licensable (SKU)] as 'Licensable Name'

		,[Licensable Part #] as 'Licensable Part Number'

		,[Device Category]

		,[Collection OS]

		,[Product Family] as 'Product Family Name'

		,[Market]

		,[Royalty]

		,[Fulfilment Date] as 'Fulfillment Date'

		,[CBR Submission Date] as 'Build Report Received Date'

		,[Processed Date] 

		,[Last Process Date] as 'Last Processed Date'

		,[Processor Model]

		,[Processor Model Validation Result]

		,[Total Physical RAM]

		,[Total Physical RAM Validation Result]

		,[Primary Disk Total Capacity]

		,[Primary Disk Total Capacity Validation Result]

		,[Internal Primary Display Size Physical Vertical (MM)] as 'Manufacturing Screen Size Physical Y (MM)'

		,[Internal Primary Display Size Physical Horizontal (MM)] as 'Manufacturing Screen Size Physical H (MM)'

		,[Primary Display Size (Inch)] as 'Manufacturing Screen Size (Inch)'

		,[Display Size Validation Result] as 'ScreenSizeDiagonal Validation Result'

		,[Internal Primary Display Resolution Vertical] as 'Display Resolution Vertical'

		,[Internal Primary Display Resolution Horizontal] as 'Display Resolution Horizontal'

		,[Display Resolution Validation Result] as 'ScreenResolutionDPI Validation Result'

		,[Primary Disk Type]

		,[Primary Disk Type Validation Result]

		,[Optical Disk Drive Type]

		,[Optical Disk Drive Type Validation Result]

		,[Digitizer Support] as 'Digitizer Support Name'

		,[Digitizer Support Validation Result]

		,[High End Licensable (SKU) Validation]

		,[OHR Form Factor]

		,[OHR Form Factor Validation Result]

		,[OHR Form Factor Sub Class]

		,[OHR Form Factor Sub Class Validation Result]

		,[Chassis Type Form Factor]

		,[Chassis Type Form Factor Sub Class]

		,[Chassis Type Validation Result]

		,[OHR Touch]

		,[OHR Touch Validation Result]

		,[OHR Screen Size]

		,[OHR Screen Size Validation Result]

		,[OHR Model Number] as 'OHR PC Model Number'

 FROM tbl_PFRawOEM WITH(NOLOCK) 
 WHERE [OEM Name] = @OEMName 
	AND WeekID=@WeekID 
	AND ExecutionID=@ExecutionID 
	AND [Processor Model Validation Result] <> 'Fail' 
	AND [Total Physical RAM Validation Result] <> 'Fail' 
	AND [Primary Disk Total Capacity Validation Result] <> 'Fail' 	
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
    AND DeletedComments = @DeletedComments 
 )
 ORDER BY PKID 
		END	
ELSE if(@DeletedComments = 'OHR Only Fail')
	BEGIN 
	 SELECT 
		[Source]

		,[OEM Name] as 'Partner (Sold To)'

		,[OEM Soldto #] as 'Partner Number (Sold To)'

		,[Agreement#] as 'Agreement #'

		,[PKID]

		,[Licensable (SKU)] as 'Licensable Name'

		,[Licensable Part #] as 'Licensable Part Number'

		,[Device Category]

		,[Collection OS]

		,[Product Family] as 'Product Family Name'

		,[Market]

		,[Royalty]

		,[Fulfilment Date] as 'Fulfillment Date'

		,[CBR Submission Date] as 'Build Report Received Date'

		,[Processed Date] 

		,[Last Process Date] as 'Last Processed Date'

		,[Processor Model]

		,[Processor Model Validation Result]

		,[Total Physical RAM]

		,[Total Physical RAM Validation Result]

		,[Primary Disk Total Capacity]

		,[Primary Disk Total Capacity Validation Result]

		,[Internal Primary Display Size Physical Vertical (MM)] as 'Manufacturing Screen Size Physical Y (MM)'

		,[Internal Primary Display Size Physical Horizontal (MM)] as 'Manufacturing Screen Size Physical H (MM)'

		,[Primary Display Size (Inch)] as 'Manufacturing Screen Size (Inch)'

		,[Display Size Validation Result] as 'ScreenSizeDiagonal Validation Result'

		,[Internal Primary Display Resolution Vertical] as 'Display Resolution Vertical'

		,[Internal Primary Display Resolution Horizontal] as 'Display Resolution Horizontal'

		,[Display Resolution Validation Result] as 'ScreenResolutionDPI Validation Result'

		,[Primary Disk Type]

		,[Primary Disk Type Validation Result]

		,[Optical Disk Drive Type]

		,[Optical Disk Drive Type Validation Result]

		,[Digitizer Support] as 'Digitizer Support Name'

		,[Digitizer Support Validation Result]

		,[High End Licensable (SKU) Validation]

		,[OHR Form Factor]

		,[OHR Form Factor Validation Result]

		,[OHR Form Factor Sub Class]

		,[OHR Form Factor Sub Class Validation Result]

		,[Chassis Type Form Factor]

		,[Chassis Type Form Factor Sub Class]

		,[Chassis Type Validation Result]

		,[OHR Touch]

		,[OHR Touch Validation Result]

		,[OHR Screen Size]

		,[OHR Screen Size Validation Result]

		,[OHR Model Number] as 'OHR PC Model Number'

 FROM tbl_PFRawOEM WITH(NOLOCK) 
 WHERE [OEM Name] = @OEMName 
 AND WeekID=@WeekID 
 AND ExecutionID=@ExecutionID 
 --AND DeletedComments = @DeletedComments
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
 ORDER BY PKID 
 END
 ELSE 
	BEGIN 
	 SELECT 
		[Source]

		,[OEM Name] as 'Partner (Sold To)'

		,[OEM Soldto #] as 'Partner Number (Sold To)'

		,[Agreement#] as 'Agreement #'

		,[PKID]

		,[Licensable (SKU)] as 'Licensable Name'

		,[Licensable Part #] as 'Licensable Part Number'

		,[Device Category]

		,[Collection OS]

		,[Product Family] as 'Product Family Name'

		,[Market]

		,[Royalty]

		,[Fulfilment Date] as 'Fulfillment Date'

		,[CBR Submission Date] as 'Build Report Received Date'

		,[Processed Date] 

		,[Last Process Date] as 'Last Processed Date'

		,[Processor Model]

		,[Processor Model Validation Result]

		,[Total Physical RAM]

		,[Total Physical RAM Validation Result]

		,[Primary Disk Total Capacity]

		,[Primary Disk Total Capacity Validation Result]

		,[Internal Primary Display Size Physical Vertical (MM)] as 'Manufacturing Screen Size Physical Y (MM)'

		,[Internal Primary Display Size Physical Horizontal (MM)] as 'Manufacturing Screen Size Physical H (MM)'

		,[Primary Display Size (Inch)] as 'Manufacturing Screen Size (Inch)'

		,[Display Size Validation Result] as 'ScreenSizeDiagonal Validation Result'

		,[Internal Primary Display Resolution Vertical] as 'Display Resolution Vertical'

		,[Internal Primary Display Resolution Horizontal] as 'Display Resolution Horizontal'

		,[Display Resolution Validation Result] as 'ScreenResolutionDPI Validation Result'

		,[Primary Disk Type]

		,[Primary Disk Type Validation Result]

		,[Optical Disk Drive Type]

		,[Optical Disk Drive Type Validation Result]

		,[Digitizer Support] as 'Digitizer Support Name'

		,[Digitizer Support Validation Result]

		,[High End Licensable (SKU) Validation]

		,[OHR Form Factor]

		,[OHR Form Factor Validation Result]

		,[OHR Form Factor Sub Class]

		,[OHR Form Factor Sub Class Validation Result]

		,[Chassis Type Form Factor]

		,[Chassis Type Form Factor Sub Class]

		,[Chassis Type Validation Result]

		,[OHR Touch]

		,[OHR Touch Validation Result]

		,[OHR Screen Size]

		,[OHR Screen Size Validation Result]

		,[OHR Model Number] as 'OHR PC Model Number'

 FROM tbl_PFRawOEM WITH(NOLOCK) 
 WHERE [OEM Name] = @OEMName 
 AND WeekID=@WeekID 
 AND ExecutionID=@ExecutionID 
 AND DeletedComments = @DeletedComments
 ORDER BY PKID 
 END
END

GO
/****** Object:  StoredProcedure [dbo].[GetOEMWeeklySettings]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:			<Gopal Krishna k>
-- Create date:		<04-09-2017>
-- Description:		<This method is used to GetOEMWeeklySetting details frrom database>
--
-- =============================================
CREATE PROC [dbo].[GetOEMWeeklySettings]

AS
BEGIN
				SELECT  
				ID,TopNOEM,
				                [Weekday],
								[Repricing OEM Eligibility],
								[CreatedBy],
								[ModifiedBy]		
						FROM dbo.[tbl_OEMWeeklySettings] 
						 where Active=0
	
END
GO
/****** Object:  StoredProcedure [dbo].[GetProcessorListName]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetProcessorListName]
@DeviceCategory nvarchar(250) null
AS
BEGIN

SELECT [DevelopedMarket(DM)] from tbl_PFProcesorList where DeviceCategory =@DeviceCategory 

END
GO
/****** Object:  StoredProcedure [dbo].[GetRawFileDataWithOutOHROnlyFail]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--sp_helptext GetRawFileDataWithOutOHROnlyFail
-- =============================================
-- Author:			<Kishore Kumar Pechetti>
-- Create date:		<08-07-2017>
-- Description:		< This method is used to get OHR Only Fail for OEM>
-- exec GetRawFileDataWithOutOHROnlyFail 'INFORMFINANS SERVICE',1449,20170806,'National Academic'
-- =============================================
CREATE PROCEDURE [dbo].[GetRawFileDataWithOutOHROnlyFail]
(
			@OEMName				varchar(255) = NULL,
			@ExecutionID			int = NULL,
			@WeekID					int = NULL		
)
AS
BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;
	  (SELECT 	 

		[Source]

		,[OEM Name] as 'Partner (Sold To)'

		,[OEM Soldto #] as 'Partner Number (Sold To)'

		,[Agreement#] as 'Agreement #'

		,[PKID]

		,[Licensable (SKU)] as 'Licensable Name'

		,[Licensable Part #] as 'Licensable Part Number'

		,[Device Category]

		,[Collection OS]

		,[Product Family] as 'Product Family Name'

		,[Market]

		,[Royalty]

		,[Fulfilment Date] as 'Fulfillment Date'

		,[CBR Submission Date] as 'Build Report Received Date'

		,[Processed Date] 

		,[Last Process Date] as 'Last Processed Date'

		,[Processor Model]

		,[Processor Model Validation Result]

		,[Total Physical RAM]

		,[Total Physical RAM Validation Result]

		,[Primary Disk Total Capacity]

		,[Primary Disk Total Capacity Validation Result]

		,[Internal Primary Display Size Physical Vertical (MM)] as 'Manufacturing Screen Size Physical Y (MM)'

		,[Internal Primary Display Size Physical Horizontal (MM)] as 'Manufacturing Screen Size Physical H (MM)'

		,[Primary Display Size (Inch)] as 'Manufacturing Screen Size (Inch)'

		,[Display Size Validation Result] as 'ScreenSizeDiagonal Validation Result'

		,[Internal Primary Display Resolution Vertical] as 'Display Resolution Vertical'

		,[Internal Primary Display Resolution Horizontal] as 'Display Resolution Horizontal'

		,[Display Resolution Validation Result] as 'ScreenResolutionDPI Validation Result'

		,[Primary Disk Type]

		,[Primary Disk Type Validation Result]

		,[Optical Disk Drive Type]

		,[Optical Disk Drive Type Validation Result]

		,[Digitizer Support] as 'Digitizer Support Name'

		,[Digitizer Support Validation Result]

		,[High End Licensable (SKU) Validation]

		,[OHR Form Factor]

		,[OHR Form Factor Validation Result]

		,[OHR Form Factor Sub Class]

		,[OHR Form Factor Sub Class Validation Result]

		,[Chassis Type Form Factor]

		,[Chassis Type Form Factor Sub Class]

		,[Chassis Type Validation Result]

		,[OHR Touch]

		,[OHR Touch Validation Result]

		,[OHR Screen Size]

		,[OHR Screen Size Validation Result]

		,[OHR Model Number] as 'OHR PC Model Number'

 FROM tbl_PFRawOEM WITH(NOLOCK) 

 WHERE [OEM Name] = @OEMName 

 AND WeekID=@WeekID 

 AND ExecutionID=@ExecutionID 

 AND DeletedYN = 0

 )

Except(

	      SELECT 	 

		[Source]

		,[OEM Name] as 'Partner (Sold To)'

		,[OEM Soldto #] as 'Partner Number (Sold To)'

		,[Agreement#] as 'Agreement #'

		,[PKID]

		,[Licensable (SKU)] as 'Licensable Name'

		,[Licensable Part #] as 'Licensable Part Number'

		,[Device Category]

		,[Collection OS]

		,[Product Family] as 'Product Family Name'

		,[Market]

		,[Royalty]

		,[Fulfilment Date] as 'Fulfillment Date'

		,[CBR Submission Date] as 'Build Report Received Date'

		,[Processed Date] 

		,[Last Process Date] as 'Last Processed Date'

		,[Processor Model]

		,[Processor Model Validation Result]

		,[Total Physical RAM]

		,[Total Physical RAM Validation Result]

		,[Primary Disk Total Capacity]

		,[Primary Disk Total Capacity Validation Result]

		,[Internal Primary Display Size Physical Vertical (MM)] as 'Manufacturing Screen Size Physical Y (MM)'

		,[Internal Primary Display Size Physical Horizontal (MM)] as 'Manufacturing Screen Size Physical H (MM)'

		,[Primary Display Size (Inch)] as 'Manufacturing Screen Size (Inch)'

		,[Display Size Validation Result] as 'ScreenSizeDiagonal Validation Result'

		,[Internal Primary Display Resolution Vertical] as 'Display Resolution Vertical'

		,[Internal Primary Display Resolution Horizontal] as 'Display Resolution Horizontal'

		,[Display Resolution Validation Result] as 'ScreenResolutionDPI Validation Result'

		,[Primary Disk Type]

		,[Primary Disk Type Validation Result]

		,[Optical Disk Drive Type]

		,[Optical Disk Drive Type Validation Result]

		,[Digitizer Support] as 'Digitizer Support Name'

		,[Digitizer Support Validation Result]

		,[High End Licensable (SKU) Validation]

		,[OHR Form Factor]

		,[OHR Form Factor Validation Result]

		,[OHR Form Factor Sub Class]

		,[OHR Form Factor Sub Class Validation Result]

		,[Chassis Type Form Factor]

		,[Chassis Type Form Factor Sub Class]

		,[Chassis Type Validation Result]

		,[OHR Touch]

		,[OHR Touch Validation Result]

		,[OHR Screen Size]

		,[OHR Screen Size Validation Result]

		,[OHR Model Number] as 'OHR PC Model Number'

 FROM tbl_PFRawOEM WITH(NOLOCK) 

 WHERE [OEM Name] = @OEMName 

	AND WeekID=@WeekID 

	AND ExecutionID=@ExecutionID 

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
 )

ORDER BY PKID 

END

GO
/****** Object:  StoredProcedure [dbo].[GetRawFileDetailsForNotifications]    Script Date: 9/11/2017 12:37:44 PM ******/
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

	SELECT  top 1 [OEM Soldto #]+','+[Agreement#] from tbl_PFRawOEM WITH(NOLOCK) WHERE ExecutionID =@ExecutionID AND [OEM Name] = @OEMName AND WeekID=@WeekID

END
GO
/****** Object:  StoredProcedure [dbo].[GetReports]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:			<Gopal Krishna k>
-- Create date:		<05-09-2017>
-- Description:		<This method is used to GetReport details frrom database>
--
-- =============================================
CREATE PROC [dbo].[GetReports]

AS
BEGIN
				SELECT  
				WeekID,OEMName,OEMType,PKIDCount,[Status]
				                		
						FROM dbo.tbl_PFLogOEM 
						 
	
END
GO
/****** Object:  StoredProcedure [dbo].[InsertGMContactDetails]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:			<Gopal Krishna k>
-- Create date:		<07-09-2017>
-- Description:		<This method is used to insert GMContact details into database>
-- =============================================
CREATE PROCEDURE [dbo].[InsertGMContactDetails]
(
            
 
			@GMID			    int,	
			@TVOName				varchar(100)	,			
			@GMContactName	    varchar(100)	,
			@TOAlias	varchar(100)	,
			@CCAlias    varchar(100)	,
			
			@Status             varchar(100)    = null output
			
)
AS
BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;  
    -- Insert statements for procedure here
			
			
			BEGIN
				INSERT INTO dbo.tbl_GMContactList 
					([ID],[TVOName],[GMContactName],TOAlias,CCAlias,DeletedYN)
					 VALUES
					(@GMID,@TVOName,@GMContactName,@TOAlias,@CCAlias,0)
				
				set  @Status =  'Record Created Successfully' 
				select @Status as Status1
			END
	
END
GO
/****** Object:  StoredProcedure [dbo].[InsertOEMData]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertOEMData]

(


			@OEMsName			nvarchar(100),	

			@MLANumber			nvarchar(100),		

			@SoldTo			    nvarchar(100),	

			@SoldToLocation		nvarchar(100),

			@Vat                decimal         = Null,

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

					([OEMs on Mass Collab],[MLA Number],SoldTo,SoldToLocation,[VAT%],Toalias,CCalias,DeletedYN,CreatedOn,CreatedBy)

					 VALUES

					(@OEMsName,@MLANumber,@SoldTo,@SoldToLocation,@Vat,@ToAlias,@CCAlias,0,GETDATE(),@CreatedBy)

				

				set  @Status =  'OEM created successfully' 

				select @Status as Status1

			END

	END

END

GO
/****** Object:  StoredProcedure [dbo].[ProcessorListValidationLogic]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ProcessorListValidationLogic]
@WeekID       NVARCHAR(250) NULL,
@ExecutionID  INT           NULL,
@OEMName      NVARCHAR(250) NULL

AS
BEGIN

DECLARE @Table1 TABLE (ID INT)

Insert into @Table1(ID )

select DISTINCT PFRAW.ID from tbl_pfRawoem PFRAW

join tbl_PFProcesorList PL on PFRAW.[Device Category] = PL.[RawFileDeviceCategory]

join tbl_PFCompleteList CL on CL.ProcessorList  = 'List '+PL.[DevelopedMarket(DM)]

where PFRAW.WEEKID = @WeekID

and  PFRAW.ExecutionID = @ExecutionID

and  PFRAW.[OEM Name] = @OEMName

and PFRAW.DeletedYN = 0

and PFRAW.[Processor Model Validation Result] = 'Fail'

and CHARINDEX(CL.[Model#],PFRAW.[Processor Model]) <> 0

UPDATE tbl_pfRawoem

SET DeletedYN = 1 , DeletedComments = 'Processor Model Fail'

WHERE ID IN(SELECT ID from @Table1)

Begin
select  'Processor Model Fail,'+ [Processor Model] as ColumnValue, count(*) as TotalCount from tbl_pfRawoem
where WEEKID = @WeekID
and  ExecutionID = @ExecutionID
and  [OEM Name] = @OEMName
and DeletedYN = 1
and DeletedComments = 'Processor Model Fail'
and [Processor Model Validation Result] = 'Fail'
Group by [Processor Model]

	END
END

--exec [ProcessorListValidationLogic] '20170903','35', 'DELL INC.'





GO
/****** Object:  StoredProcedure [dbo].[UpdateGMContactDetails]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:			<Gopal Krishna k>
-- Create date:		<07-09-2017>
-- Description:		<This method is used to update GM Contact details into database>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateGMContactDetails]
(
			@GMID			    int,	
			@TVOName				varchar(100)	,			
			@GMContactName	    varchar(100)	,
			@TOAlias	varchar(100)	,
			@CCAlias    varchar(100)	,
			@LastUpdatedBy		varchar(100)	= NULL,
			@Status             varchar(100)    = null output
			
)
AS
BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;
	 
    -- Insert statements for procedure here
		update dbo.tbl_GMContactList
						set 
						[TVOName]		=	@TVOName,
						[GMContactName]	=	@GMContactName,
						TOAlias         =   @TOAlias,
						CCAlias         =	@CCAlias,
						LastUpdatedOn	=	Getdate(),
						LastUpdatedBy	=	@LastUpdatedBy
						where ID=@GMID
			set  @Status =  'Record Updated Successfully' 
				select @Status as Status1
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateOEM]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateOEM]

(			

			@OEMID				int   = Null,

			@OEMsName			nvarchar(100),	

			@MLANumber			nvarchar(100),		

			@SoldTo			    nvarchar(100),	

			@SoldToLocation		nvarchar(100),

			@Vat                decimal        = Null,
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
/****** Object:  StoredProcedure [dbo].[UpdateOEMSettings]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:			<Gopal Krishna k>
-- Create date:		<04-09-2017>
-- Description:		<This method is used to update OEM Settngs details into database>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateOEMSettings]
(
            @ID int,
			@TopNOEM         int ,
			@Weekday	     varchar(100),	
			@RepricingEligibility int,
			@LastUpdatedBy		varchar(100)	= NULL,		
			@Status             varchar(100)    = null output 

			
)
AS
BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;
	 
    -- Insert statements for procedure here
		update dbo.[tbl_OEMWeeklySettings]
						set [TopNOEM]		=	@TopNOEM ,
						[Weekday]		=	@Weekday,
						[Repricing OEM Eligibility]=@RepricingEligibility,
                        ModifiedBy	=	@LastUpdatedBy
						where ID=@ID
			set  @Status =  'Record Updated Successfully' 
				select @Status as Status1
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateStatusBasedOnTableName]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateStatusBasedOnTableName]
	-- Add the parameters for the stored procedure here
	@TableName nvarchar(max),
	@WeekID nvarchar(max),
	@ReportID nvarchar(max),
	@Status nvarchar(max),
	@ProcessExecutionID int,
	@Comments nvarchar(max)
	as
BEGIN
	IF(@TableName='tbl_PFReconciliation')
	BEGIN
	UPDATE  tbl_PFReconciliation SET Status =@Status where ExecutionID = @ProcessExecutionID and WeekID=@WeekID
	END
	ELSE IF(@TableName= 'tbl_PFRepriceOEMs')
	BEGIN
	UPDATE  tbl_PFRepriceOEMs SET Status =@Status, Comments =@Comments where ProcessExecutionID = @ProcessExecutionID and WeekID=@WeekID and ReportID =@ReportID
	END    
END


GO
/****** Object:  StoredProcedure [dbo].[usp_DisplayGMContactsList]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:			<Gopal Krishna k>
-- Create date:		<07-09-2017>
-- Description:		<This method is used to Display GMContactList details frrom database>
-- =============================================
CREATE PROCEDURE [dbo].[usp_DisplayGMContactsList]
AS
BEGIN
Select	ID,
TVOName,
GMContactName ,
TOAlias,
ISNULL(CCAlias,'') CCAlias 
	from tbl_GMContactList where DeletedYN=0
END
GO
/****** Object:  StoredProcedure [dbo].[usp_DisplayOEMMasterDetails]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_DisplayOEMMasterDetails]



AS

BEGIN



	Select	ID,

			[OEMs on Mass Collab],

			ISNULL([MLA Number],'') [MLA Number],

			ISNULL(SoldTo,'') SoldTo,

			ISNULL(SoldToLocation,'') SoldToLocation,

			ISNULL([VAT%],0) [VAT%] ,
			Toalias,
			ISNULL(CCalias,'') CCalias 


	from tbl_MassCollabOEMContacts where DeletedYN=0



END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetSoldToAAndMLA]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetSoldToAAndMLA]

(

@OEMName nvarchar(500) = NULL

)

AS

BEGIN

	SET NOCOUNT ON;	

	SELECT [SoldTo] + ',' +[MLA Number] from tbl_MassCollabOEMContacts where [SoldTo] = @OEMName

	End
GO
/****** Object:  StoredProcedure [dbo].[usp_ReturnWeekIDs]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_ReturnWeekIDs]
AS
BEGIN
Select Distinct WeekID From tbl_PFLogOEM where DeletedYN=0
END
GO
/****** Object:  StoredProcedure [dbo].[ValidateOHRFail]    Script Date: 9/11/2017 12:37:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ValidateOHRFail]

@ProcessExecutionID				INT			  = NULL,
@WeekID							NVARCHAR(500) = NULL,
@ReportID						NVARCHAR(500) = NULL

AS
BEGIN

SET NOCOUNT ON;
--Select * from tbl_PFRawOEM 
UPDATE tbl_PFScrubbedData SET DeletedYN=1, [RequiredLicensable(SKU)] = 'Cancelled', 
[Required Licensable Part No.] = 'NA',  [Required Device Category] = 'NA',
LastUpdatedOn=GETDATE()										

	WHERE ReportID = @ReportID AND ProcessExecutionID=@ProcessExecutionID AND WeekID=@WeekID 

	AND [Processor Model Validation Result] <> 'Fail' 
	AND [Total Physical RAM Validation Result] <> 'Fail' 
	AND [Primary Disk Total Capacity Validation Result] <> 'Fail' 
	AND [Display Size Validation Result] <> 'Fail'
	AND [Display Resolution validation result] <> 'Fail'	
	AND [Primary Disk Type Validation Result] <> 'Fail'
	AND [Optical Disk Drive Type Validation Result] <> 'Fail'
	AND [Digitizer Support Validation Result] <> 'Fail'
	AND [Chassis Type Validation Result] <> 'Fail'
	AND ([OHR Form Factor Sub Class Validation Result] = 'Fail'	OR [OHR Form Factor Validation Result] = 'Fail'	OR [OHR Screen Size Validation Result] = 'Fail')
	
END


GO
