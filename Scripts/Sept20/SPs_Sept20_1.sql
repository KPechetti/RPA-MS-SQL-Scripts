/****** Object:  StoredProcedure [dbo].[UpdateDetailsinFolderMapping]    Script Date: 9/20/2017 9:25:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[UpdateDetailsinFolderMapping]
(
@OEMName			NVARCHAR(200) =NULL,
@SoldTo  			NVARCHAR(200) =NULL,
@MLANumber			NVARCHAR(200) =NULL,
@LinkToReport		NVARCHAR(max) =NULL,
@LastUpdatedBy		NVARCHAR(100) =NULL,
@PartnerType		NVARCHAR(100) =NuLL
)
AS
BEGIN
	IF NOT Exists(select * from tbl_foldermapping where SoldTo = @SoldTo)	
	BEGIN
	insert into tbl_foldermapping (OEMName, SoldTo, MLANumber, LinkToReport,DeletedYN,LastUpdatedOn,LastUpdatedBy,PartnerType)
	values(@OEMName, @SoldTo, @MLANumber,@LinkToReport,0,getdate(),@LastUpdatedBy,@PartnerType)
	END
END
GO
