USE DB_PRODUCTION;

DROP PROCEDURE IF EXISTS dbo.SP_LOG_STOREPROCEDURE_SENTENCE
GO

CREATE PROCEDURE dbo.SP_LOG_STOREPROCEDURE_SENTENCE

(
	@ActionSP			VARCHAR(1)		-- 'I' Insert Row   'F'  Finish  'E' Error
	,@LayoutSP			VARCHAR(50) = NULL		
	,@Sentence			VARCHAR(50)	= NULL
	,@SentStore			BIGINT OUTPUT
)

AS
BEGIN 
	
	DECLARE @LayoutID		INT
	DECLARE @UserDB			VARCHAR(100)	= SYSTEM_USER


	SET @LayoutID = (SELECT LayoutID FROM dbo.TB_LAYOUT_STOREPROCEDURE
	WHERE LayoutSP =TRIM(@LayoutSP))


	IF (@ActionSP = 'I' AND @LayoutID IS NOT NULL AND @Sentence IS NOT NULL)
		BEGIN
			INSERT INTO dbo.TB_LOG_SP_SENTENCE_CONTROL( 
				LayoutID
				,LayoutSP
				,Sentence
				,[State]	
				,IniDate	
				,EndDate		
		
			)
			VALUES (@LayoutID,TRIM(@LayoutSP),@Sentence,1,CURRENT_TIMESTAMP, NULL )

			SET @SentStore = @@IDENTITY;

		END
	ELSE IF (@ActionSP = 'F' AND @SentStore	 IS NOT NULL )
		BEGIN

			UPDATE A
			SET 
				EndDate	= CURRENT_TIMESTAMP,
				[State]=2
			FROM dbo.TB_LOG_SP_SENTENCE_CONTROL A
			WHERE SentStore = @SentStore ;
		END ;
END ;

