/****** Object:  StoredProcedure [dbo].[DeleteGMContactDetails]    Script Date: 9/13/2017 3:08:52 PM ******/
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

			@GMID				int   = Null	

			--@Status             varchar(100)    = null output 

			

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

							---set  @Status =  'OEM Deleted Successfully' 

				--select @Status as Status1

	

END

GO
/****** Object:  StoredProcedure [dbo].[GetFolderLink]    Script Date: 9/13/2017 3:08:52 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetRepriceFileDataForOEM]    Script Date: 9/13/2017 3:08:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRepriceFileDataForOEM]
(
			@OEMName				nvarchar(255) = NULL,
			@ExecutionID			int = NULL,
			@WeekID					nvarchar(200)
)
AS
BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;
    SELECT 	 
		 [Source]
		,[ReportID] as 'Partner (Sold To)'
		,[OEM Soldto #] as 'Partner Number (Sold To)'		
		,[PKID]
		,[Licensable (SKU)] as 'Licensable Name'
		,[MLA] as 'Agreement #'
		,[Licensable Part #] as 'Licensable Part Number'
		,[Device Category]
		,[RequiredLicensable(SKU)] as 'Required Licensable Name'
		,[Required Licensable Part No.] as 'Required Licensable Part Number'
		,[Required Device Category] as 'Required Device Category'
		,[Collection OS]
		,[Product Family] as 'Product Family Name'
		,[Market]
		,[Royalty]
		,[Required Price]
		,[Price Difference]
		,[Default Charge]
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

 FROM tbl_PFScrubbedData WITH(NOLOCK) where [ReportID] = @OEMName and DeletedYN=0 and WeekID=@WeekID AND ProcessExecutionID=@ExecutionID ORDER BY PKID 

END

GO
/****** Object:  StoredProcedure [dbo].[GetSoldToLocation]    Script Date: 9/13/2017 3:08:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[GetSoldToLocation]
(
@SoldTo				nvarchar(500) null
)
AS
Begin
SET NOCOUNT ON;  
select SoldToLocation + ',' + ISNull(cast([VAT%] as varchar), '') from tbl_MassCollabOEMContacts where SoldTo = @SoldTo
End

GO
/****** Object:  StoredProcedure [dbo].[InsertDataForNewOemInMassCollab]    Script Date: 9/13/2017 3:08:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[InsertDataForNewOemInMassCollab]
@OEMsonMassCollab  nvarchar(250) NULL,
@MLANumber  nvarchar(250) NULL,
@DistributionListcontact nvarchar(250) NULL,
@EmailAddress nvarchar(250) NULL,
@OEMAdditionalContact nvarchar(250) NULL,
@EmailAddressAdditionalContact nvarchar(250) NULL,
@AM nvarchar(250) NULL,
@AMAlias nvarchar(250) NULL,
@com nvarchar(250) NULL,
@comalias nvarchar(250) NULL,
@SoldToLocation nvarchar(250) NULL,
@SoldTo nvarchar(250) NULL,
@VAT FLOAT(8) NULL,
@Toalias nvarchar(250) NULL,
@CCalias  nvarchar(250) NULL
 
AS
BEGIN

INSERT INTO tbl_MassCollabOEMContacts 
([OEMs on Mass Collab],[MLA Number],[Distribution List Contact],[Email Address],[OEM Additional Contact],[Email Address_AdditionalContact],[AM],
[AM Alias],[COM],[COM Alias],[SoldToLocation],[SoldTo],[VAT%],[Toalias],[CCalias])
VALUES(@OEMsonMassCollab , 
@MLANumber  ,
@DistributionListcontact ,
@EmailAddress ,
@OEMAdditionalContact ,
@EmailAddressAdditionalContact ,
@AM ,
@AMAlias ,
@com ,
@comalias ,
@SoldToLocation ,
@SoldTo,
@VAT,
@Toalias,
@CCalias
)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertGMContactDetails]    Script Date: 9/13/2017 3:08:52 PM ******/
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
            
 
			
			@TVOName				varchar(100)	,			
			@GMContactName	    varchar(100)	,
			@GMToAlias	varchar(100)	,
			@GMCCAlias    varchar(100)	,
			
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
					([TVOName],[GMContactName],GMAlias,TOAlias,CCAlias,DeletedYN)
					 VALUES
					(@TVOName,@GMContactName,'bpopriceflex@microsoft.com',@GMToAlias,@GMCCAlias,0)
				
				set  @Status =  'Record Created Successfully' 
				select @Status as Status1
			END
	
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateGMContactDetails]    Script Date: 9/13/2017 3:08:52 PM ******/
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
			@ToAlias	varchar(100)	,
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
						TOAlias         =   @ToAlias,
						CCAlias         =	@CCAlias,
						LastUpdatedOn	=	Getdate(),
						LastUpdatedBy	=	@LastUpdatedBy
						where ID=@GMID
			set  @Status =  'Record Updated Successfully' 
				select @Status as Status1
END
GO
/****** Object:  StoredProcedure [dbo].[ValidateOHRFail]    Script Date: 9/13/2017 3:08:52 PM ******/
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
