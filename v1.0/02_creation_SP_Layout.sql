USE DB_PRODUCTION;

DROP  PROCEDURE IF EXISTS dbo.SP_LAYOUT_STOREPROCEDURE
GO

CREATE PROCEDURE dbo.SP_LAYOUT_STOREPROCEDURE

(
	@LayoutSP			VARCHAR(50)		
	,@NameSP			VARCHAR(100)	
	,@DescriptionSP		VARCHAR(1000)	
	,@Parameter01		VARCHAR(100) = NULL
	,@Parameter02		VARCHAR(100) = NULL
	,@Parameter03		VARCHAR(100) = NULL
	,@Parameter04		VARCHAR(100) = NULL
)

AS
BEGIN 
	
	DECLARE @LayoutID		INT
	DECLARE @UserDB			VARCHAR(100)	= SYSTEM_USER
	DECLARE @NameDB			VARCHAR(100)	= DB_NAME()


	SET @LayoutID = (SELECT LayoutID FROM dbo.TB_LAYOUT_STOREPROCEDURE
	WHERE LayoutSP =TRIM(@LayoutSP))


	IF (@LayoutID IS NULL )
		BEGIN
			INSERT INTO dbo.TB_LAYOUT_STOREPROCEDURE( 
				LayoutSP		
				,UserDB
				,NameDB
				,NameSP			
				,DescriptionSP	
				,Parameter01		
				,Parameter02		
				,Parameter03		
				,Parameter04					
			)
			VALUES (TRIM(@LayoutSP),@UserDB,@NameDB,TRIM(@NameSP),TRIM(@DescriptionSP),@Parameter01,@Parameter02,@Parameter03,@Parameter04) ;


			INSERT INTO dbo.TB_LAYOUT_HISTORY_STOREPROCEDURE  (
				 LayoutID
				,LayoutSP		
				,UserDB
				,NameDB
				,NameSP			
				,DescriptionSP	
				,Parameter01		
				,Parameter02		
				,Parameter03		
				,Parameter04
				,StateSP 
				,CreationDate
				)
			SELECT
				@@IDENTITY
				,LayoutSP		
				,UserDB
				,NameDB
				,NameSP			
				,DescriptionSP	
				,Parameter01		
				,Parameter02		
				,Parameter03		
				,Parameter04
				,1
				,CreationDate

			FROM dbo.TB_LAYOUT_STOREPROCEDURE
			WHERE LayoutID=@@IDENTITY;


		END
	ELSE
		BEGIN

			UPDATE A
			SET 
				UserDB			=@UserDB
				,NameDB			=@NameDB
				,NameSP			=TRIM(@NameSP)
				,DescriptionSP	=TRIM(@DescriptionSP)
				,Parameter01	=@Parameter01
				,Parameter02	=@Parameter02
				,Parameter03	=@Parameter03	
				,Parameter04	=@Parameter04
				,UpdateDate		=CURRENT_TIMESTAMP
			FROM dbo.TB_LAYOUT_STOREPROCEDURE A
			WHERE LayoutID = @LayoutID ;

			UPDATE A
			SET StateSP=0
			FROM dbo.TB_LAYOUT_HISTORY_STOREPROCEDURE A
			WHERE LayoutID = @LayoutID ;


			INSERT INTO dbo.TB_LAYOUT_HISTORY_STOREPROCEDURE  (
				 LayoutID
				,LayoutSP		
				,UserDB
				,NameDB
				,NameSP			
				,DescriptionSP	
				,Parameter01		
				,Parameter02		
				,Parameter03		
				,Parameter04
				,StateSP
				,CreationDate
				)
			SELECT
				@LayoutID
				,LayoutSP		
				,UserDB
				,NameDB
				,NameSP			
				,DescriptionSP	
				,Parameter01		
				,Parameter02		
				,Parameter03		
				,Parameter04
				,1
				,UpdateDate
			FROM dbo.TB_LAYOUT_STOREPROCEDURE 
			WHERE LayoutID=@LayoutID;

		END ;

END ;


