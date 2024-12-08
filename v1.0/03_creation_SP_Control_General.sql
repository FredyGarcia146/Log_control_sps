USE DB_PRODUCTION;

DROP PROCEDURE IF EXISTS dbo.SP_LOG_STOREPROCEDURE
GO

CREATE PROCEDURE dbo.SP_LOG_STOREPROCEDURE

(
	 @ActionSP			VARCHAR(1)		-- 'I' Insert Row   'F'  Finish  'E' Error
	,@LayoutSP			VARCHAR(50)		= NULL
	,@NumRowsUPD		INTEGER			= NULL
	,@NumRowsINS		INTEGER			= NULL
	,@DescError			VARCHAR(1000)	= NULL
	,@ExecStore BIGINT OUTPUT
)

AS
BEGIN 
	
	DECLARE @LayoutID		INT
	DECLARE @UserDB			VARCHAR(100)	= SYSTEM_USER


	SET @LayoutID = (SELECT LayoutID FROM dbo.TB_LAYOUT_STOREPROCEDURE
	WHERE LayoutSP =TRIM(@LayoutSP))


	IF (@ActionSP = 'I' AND  @LayoutID IS NOT NULL )
		BEGIN
			INSERT INTO dbo.TB_LOG_SP_GENERAL_CONTROL( 
				LayoutID		
				,LayoutSP		
				,UserDB			
				,StateExecID		
				,IniDate			
				,EndDate			
				,NumRowsUPD		
				,NumRowsINS			
		
			)
			VALUES (@LayoutID,TRIM(@LayoutSP),@UserDB,1,CURRENT_TIMESTAMP, NULL ,@NumRowsUPD,@NumRowsINS) ;

			SET @ExecStore = @@IDENTITY;

			DELETE dbo.TB_LOG_SP_SENTENCE_CONTROL
			WHERE LayoutID = @LayoutID;


		END
	ELSE IF (@ActionSP = 'F' AND @ExecStore IS NOT NULL )
		BEGIN

			UPDATE A
			SET 
				EndDate	= CURRENT_TIMESTAMP,
				StateExecID=2
			FROM dbo.TB_LOG_SP_GENERAL_CONTROL A
			WHERE ExecStore = @ExecStore ;

		END ;

	ELSE IF (@ActionSP = 'E' AND @ExecStore IS NOT NULL )
		BEGIN

			UPDATE A
			SET 
				DescError	= @DescError,
				StateExecID=3
			FROM dbo.TB_LOG_SP_GENERAL_CONTROL A
			WHERE ExecStore = @ExecStore ;

		END ;

END ;
