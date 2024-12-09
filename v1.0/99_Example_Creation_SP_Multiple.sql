USE DB_PRODUCTION;

DROP  PROCEDURE IF EXISTS dbo.SP_TEST_01;
DROP  PROCEDURE IF EXISTS dbo.SP_TEST_SUBPROCESS_01;
DROP  PROCEDURE IF EXISTS dbo.SP_TEST_SUBPROCESS_02;
GO

CREATE PROCEDURE dbo.SP_TEST_SUBPROCESS_01
AS
BEGIN
	
	-- GENERAL VARIABLES
	DECLARE @ExecStore BIGINT;
	DECLARE @SentStore BIGINT;
	DECLARE @Sentence VARCHAR(50)
	DECLARE @LayoutSP VARCHAR(50) = 'L_TEST_SUB_01' ;

	-------------------------------------------------------------------------------------------------------
	-- START LOG PROCEDURE
	-------------------------------------------------------------------------------------------------------
	EXEC dbo.SP_LOG_STOREPROCEDURE 'I' ,@LayoutSP,NULL,NULL,NULL ,@ExecStore= @ExecStore OUTPUT;


		-------------------------------------------------------------------------------------------------------
		-- SENTENCE 01
		-------------------------------------------------------------------------------------------------------
		SET @Sentence ='Print TABLE 01'
		EXEC dbo.SP_LOG_STOREPROCEDURE_SENTENCE 'I' ,@LayoutSP,@Sentence,@SentStore= @SentStore OUTPUT;

		PRINT @ExecStore 

		EXEC dbo.SP_LOG_STOREPROCEDURE_SENTENCE 'F' ,@SentStore = @SentStore;


		-------------------------------------------------------------------------------------------------------
		-- SENTENCE 01
		-------------------------------------------------------------------------------------------------------
		SET @Sentence ='Print TABLE 02'
		EXEC dbo.SP_LOG_STOREPROCEDURE_SENTENCE 'I' ,@LayoutSP,@Sentence,@SentStore= @SentStore OUTPUT;

		PRINT @ExecStore

		EXEC dbo.SP_LOG_STOREPROCEDURE_SENTENCE 'F' ,@SentStore = @SentStore;


	-------------------------------------------------------------------------------------------------------
	-- END LOG PROCEDURE
	-------------------------------------------------------------------------------------------------------
	EXEC dbo.SP_LOG_STOREPROCEDURE 'F' ,@ExecStore= @ExecStore 



END;

GO


CREATE PROCEDURE dbo.SP_TEST_SUBPROCESS_02
AS
BEGIN
	
	-- GENERAL VARIABLES
	DECLARE @ExecStore BIGINT;
	DECLARE @SentStore BIGINT;
	DECLARE @Sentence VARCHAR(50)
	DECLARE @LayoutSP VARCHAR(50) = 'L_TEST_SUB_02' ;





	-------------------------------------------------------------------------------------------------------
	-- START LOG PROCEDURE
	-------------------------------------------------------------------------------------------------------
	EXEC dbo.SP_LOG_STOREPROCEDURE 'I' ,@LayoutSP,NULL,NULL,NULL ,@ExecStore= @ExecStore OUTPUT;



		-------------------------------------------------------------------------------------------------------
		-- SENTENCE 01
		-------------------------------------------------------------------------------------------------------
		SET @Sentence ='Print TABLE 01'
		EXEC dbo.SP_LOG_STOREPROCEDURE_SENTENCE 'I' ,@LayoutSP,@Sentence,@SentStore= @SentStore OUTPUT;

		PRINT @ExecStore 

		EXEC dbo.SP_LOG_STOREPROCEDURE_SENTENCE 'F' ,@SentStore = @SentStore;


		-------------------------------------------------------------------------------------------------------
		-- SENTENCE 01
		-------------------------------------------------------------------------------------------------------
		SET @Sentence ='Print TABLE 02'
		EXEC dbo.SP_LOG_STOREPROCEDURE_SENTENCE 'I' ,@LayoutSP,@Sentence,@SentStore= @SentStore OUTPUT;

		PRINT @ExecStore

		EXEC dbo.SP_LOG_STOREPROCEDURE_SENTENCE 'F' ,@SentStore = @SentStore;


	-------------------------------------------------------------------------------------------------------
	-- END LOG PROCEDURE
	-------------------------------------------------------------------------------------------------------
	EXEC dbo.SP_LOG_STOREPROCEDURE 'F' ,@ExecStore= @ExecStore 



END;

GO


CREATE PROCEDURE dbo.SP_TEST_01
AS
BEGIN
	
	-- GENERAL VARIABLES
	DECLARE @ExecStore BIGINT;
	DECLARE @SentStore BIGINT;
	DECLARE @Sentence VARCHAR(50)
	DECLARE @LayoutSP VARCHAR(50) = 'L_TEST_01' ;


	BEGIN TRY


		-------------------------------------------------------------------------------------------------------
		-- START LOG PROCEDURE
		-------------------------------------------------------------------------------------------------------
		EXEC dbo.SP_LOG_STOREPROCEDURE 'I' ,@LayoutSP,NULL,NULL,NULL ,@ExecStore= @ExecStore OUTPUT;




			-------------------------------------------------------------------------------------------------------
			-- SENTENCE 01
			-------------------------------------------------------------------------------------------------------
			SET @Sentence ='L_TEST_SUB_01'
			EXEC dbo.SP_LOG_STOREPROCEDURE_SENTENCE 'I' ,@LayoutSP,@Sentence,@SentStore= @SentStore OUTPUT;

				EXEC dbo.SP_TEST_SUBPROCESS_01

			EXEC dbo.SP_LOG_STOREPROCEDURE_SENTENCE 'F' ,@SentStore = @SentStore;


			-------------------------------------------------------------------------------------------------------
			-- SENTENCE 01
			-------------------------------------------------------------------------------------------------------
			SET @Sentence ='L_TEST_SUB_02'
			EXEC dbo.SP_LOG_STOREPROCEDURE_SENTENCE 'I' ,@LayoutSP,@Sentence,@SentStore= @SentStore OUTPUT;

				EXEC dbo.SP_TEST_SUBPROCESS_02

			EXEC dbo.SP_LOG_STOREPROCEDURE_SENTENCE 'F' ,@SentStore = @SentStore;


		-------------------------------------------------------------------------------------------------------
		-- END LOG PROCEDURE
		-------------------------------------------------------------------------------------------------------
		EXEC dbo.SP_LOG_STOREPROCEDURE 'F' ,@ExecStore= @ExecStore 




	END TRY
	BEGIN CATCH
		PRINT 'Error detectado:';
		PRINT 'Número de error: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Mensaje de error: ' + ERROR_MESSAGE();
		DECLARE @DescError VARCHAR(1000) =  LEFT(ERROR_MESSAGE(),1000);

		EXEC dbo.SP_LOG_STOREPROCEDURE 'E' ,@DescError = @DescError,@ExecStore= @ExecStore 
	END CATCH

END;






/*

EXEC dbo.SP_TEST_01
SELECT * FROM dbo.TB_LOG_SP_GENERAL_CONTROL WHERE LayoutSP = 'L_TEST_01'
SELECT * FROM dbo.TB_LOG_SP_SENTENCE_CONTROL WHERE LayoutSP = 'L_TEST_01'
SELECT * FROM dbo.TB_LOG_SP_GENERAL_CONTROL WHERE LayoutSP = 'L_TEST_SUB_01'
SELECT * FROM dbo.TB_LOG_SP_SENTENCE_CONTROL WHERE LayoutSP = 'L_TEST_SUB_01'
SELECT * FROM dbo.TB_LOG_SP_GENERAL_CONTROL WHERE LayoutSP = 'L_TEST_SUB_02'
SELECT * FROM dbo.TB_LOG_SP_SENTENCE_CONTROL WHERE LayoutSP = 'L_TEST_SUB_02'


*/

