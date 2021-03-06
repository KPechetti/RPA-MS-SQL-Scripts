/****** Object:  StoredProcedure [dbo].[GetLogOEMDataAfterValidation]    Script Date: 9/20/2017 5:33:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLogOEMDataAfterValidation]  
@ExecutionID int   =NULL,  
@WeekID nvarchar(100) = NULL,  
@Status nvarchar(500) = NULL  
AS  
BEGIN  
 SET NOCOUNT ON;  
 if(@Status = 'Validate Log File Completed')   
 BEGIN  
   select * from tbl_PFLogOEM where WeekID=@WeekID and ExecutionID=@ExecutionID and Status in ('Validate Log File Completed','Download Raw File Failed') and DeletedYN=0 AND IsReady=1  ORDER BY [OEMName]
 END  
 else if(@Status = 'Download Raw File Completed')  
 BEGIN  
   select * from tbl_PFLogOEM where WeekID=@WeekID and ExecutionID=@ExecutionID and Status in ('Download Raw File Completed','Raw File Validation Failed') and DeletedYN=0 AND IsReady=1  ORDER BY [OEMName]

 END  
 ELSE if(@Status = 'Raw File Validation Completed')  
 BEGIN  
    select * from tbl_PFLogOEM where WeekID=@WeekID and ExecutionID=@ExecutionID and Status in ('Raw File Validation Completed','Child Case Creation Failed') and DeletedYN=0 AND IsReady=1  ORDER BY [OEMName]
 END  

 ELSE if(@Status = 'Child Case Creation Completed')   
  BEGIN  
   select * from tbl_PFLogOEM where WeekID=@WeekID and ExecutionID=@ExecutionID and Status in ('Child Case Creation Completed','SP Tracker Item Creation Failed') and DeletedYN=0 AND IsReady=1  ORDER BY [OEMName]
 END  
 ELSE if(@Status = 'SP Tracker Item Creation Completed')  
 BEGIN  
   select * from tbl_PFLogOEM where WeekID=@WeekID and ExecutionID=@ExecutionID and Status in ('SP Tracker Item Creation Completed','Review Process Failed') and DeletedYN=0 AND IsReady=1  ORDER BY [OEMName]
 END  
 ELSE if(@Status = 'Review Process Completed')  
  BEGIN  
   select * from tbl_PFLogOEM where WeekID=@WeekID and ExecutionID=@ExecutionID and Status in ('Review Process Completed','Scrubbing Process Failed') and DeletedYN=0 AND IsReady=1  ORDER BY [OEMName]
 END  
 ELSE if(@Status = 'Scrubbing Process Completed')  
 BEGIN  
   select * from tbl_PFLogOEM where WeekID=@WeekID and ExecutionID=@ExecutionID and Status in ('Scrubbing Process Completed','SP Tracker Update Failed') and DeletedYN=0 AND IsReady=1  ORDER BY [OEMName]
 END  
 ELSE if(@Status = 'SP Tracker Update Completed')  
 BEGIN  
   select * from tbl_PFLogOEM where WeekID=@WeekID and ExecutionID=@ExecutionID and Status in ('SP Tracker Update Completed','Download Scrubbed Data Failed') and DeletedYN=0 AND IsReady=1  ORDER BY [OEMName]
 END  
 ELSE if(@Status = 'Download Scrubbed Data Completed')  
 BEGIN  
   select * from tbl_PFLogOEM where WeekID=@WeekID and ExecutionID=@ExecutionID and Status in ('Download Scrubbed Data Completed','Upload Data to BI Failed','Cancelled','Cancelled OEM Upload Failed') and DeletedYN=0 AND IsReady=1  ORDER BY [OEMName]
 END  
 ELSE if(@Status = 'Upload Data to BI Completed')  
 BEGIN  
   select * from tbl_PFLogOEM where WeekID=@WeekID and ExecutionID=@ExecutionID and Status in ('Upload Data to BI Completed','Update Case Details Post Scrubbing Failed','Cancelled OEM Upload Completed','Update Case For Cancelled OEM Failed') and DeletedYN

=0 AND IsReady=1  ORDER BY [OEMName]
 END  
 ELSE if(@Status = 'Update Case Details Post Scrubbing Completed')  
 BEGIN  
   select * from tbl_PFLogOEM where WeekID=@WeekID and ExecutionID=@ExecutionID and Status in ('Update Case Details Post Scrubbing Completed','GM Notification Failed','Cancelled OEM Update Case Completed', 'Cancelled OEM GM Notification Failed','No Records Found and GM Notification not sent','No Records Found and GM Notification Failed') and DeletedYN=0 AND IsReady=1  ORDER BY [OEMName]
 END  
 ELSE if(@Status = 'GM Notification Completed')  
 BEGIN  
   select * from tbl_PFLogOEM where WeekID=@WeekID and ExecutionID=@ExecutionID and Status in ('GM Notification Completed','GM Notification Not Sent','First Level Notification Failed') AND DeletedYN=0 AND IsReady=1 AND DATEDIFF(day,GMNotification,GETDATE(
)) >= 1  ORDER BY [OEMName]
 END  
 ELSE if(@Status = 'Cancelled')  
 BEGIN  
   select * from tbl_PFLogOEM where WeekID=@WeekID and ExecutionID=@ExecutionID and Status in ('Cancelled') AND DeletedYN=0 AND IsReady=1 ORDER BY [OEMName]
 END  
 ELSE if(@Status = 'Not Started')  
 BEGIN  
   select WeekID,OEMName as ReportID, Status from tbl_PFLogOEM where WeekID=@WeekID and ExecutionID=@ExecutionID  AND DeletedYN=0  ORDER BY [OEMName]
 END  
 ELSE  
 BEGIN  
   select * from tbl_PFLogOEM where WeekID=@WeekID and ExecutionID=@ExecutionID and Status = @Status and DeletedYN=0  ORDER BY [OEMName]
 END 
END

GO
/****** Object:  StoredProcedure [dbo].[GetWeekDay]    Script Date: 9/20/2017 5:33:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetWeekDay]
AS
BEGIN
Select WeekDay  +','+ Cast(TopNOEM as nvarchar) from tbl_OEMWeeklySettings
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateOEMStatus]    Script Date: 9/20/2017 5:33:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateOEMStatus]
@ExecutionID int,
@WeekID nvarchar(100),
@OemName nvarchar(500),
@Status	nvarchar(100)		=NULL,
@Comments nvarchar(max)		=NULL,
@LastUpdatedBy nvarchar(100)=NULL
AS
BEGIN
	SET NOCOUNT ON;
if(@Status = 'SP Tracker Update Failed')
 BEGIN
 Update tbl_PFLogOEM set Status=@Status,
							--Comments=@Comments,
							LastUpdatedOn=getdate(),
							LastUpdatedBy=@LastUpdatedBy
		where ExecutionID = @ExecutionID AND WeekID = @WeekID AND OEMName = @OemName
 END

 if(@Status = 'Validate Log File Completed')
 BEGIN
 --PKID Count >0
 Update tbl_PFLogOEM set Status=@Status,
							--Comments=@Comments,
							LastUpdatedOn=getdate(),
							LastUpdatedBy=@LastUpdatedBy
		where ExecutionID = @ExecutionID AND WeekID = @WeekID AND OEMName = @OemName  AND PKIDCount > 0

--For TVOs PKID Count = 0
Update tbl_PFLogOEM set Status='No Records Found and GM Notification not sent',
							--Comments=@Comments,
							LastUpdatedOn=getdate(),
							LastUpdatedBy=@LastUpdatedBy
		where ExecutionID = @ExecutionID AND WeekID = @WeekID AND OEMName = @OemName  AND PKIDCount = 0
 END

 ELSE
 BEGIN
	Update tbl_PFLogOEM set Status=@Status,
							Comments=@Comments,
							LastUpdatedOn=getdate(),
							LastUpdatedBy=@LastUpdatedBy
		where ExecutionID = @ExecutionID AND WeekID = @WeekID AND OEMName = @OemName
		----Updating ExecutionID EndDate for caluculating 
		--UPDATE tbl_ExecutionMaster 
		--			SET		
		--				 LastUpdatedOn	= GETDATE(),
		--				 EndDate		= GETDATE(),	
		--				 Diffrence		= DATEDIFF(minute, StartDate, EndDate)
		--		WHERE ExecutionID=@ExecutionID
	END
END

GO
