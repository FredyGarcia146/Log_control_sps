USE DB_PRODUCTION;

-- Creating Layout

EXEC dbo.SP_LAYOUT_STOREPROCEDURE 'L_TEST_01' ,'SP_TEST_01','Description ','Parameter 01 VARIABLE'

SELECT * FROM dbo.TB_LAYOUT_STOREPROCEDURE

---------------------------------------------------------------------------------------
SELECT * FROM TB_LAYOUT_HISTORY_STOREPROCEDURE
---------------------------------------------------------------------------------------



-- Change Description or add Parameters

EXEC dbo.SP_LAYOUT_STOREPROCEDURE 'L_TEST_01' ,'SP_TEST_01','Description v2','Parameter 01 VARIABLE','Parameter 02 VARIABLE'


SELECT * FROM dbo.TB_LAYOUT_STOREPROCEDURE

---------------------------------------------------------------------------------------
SELECT * FROM TB_LAYOUT_HISTORY_STOREPROCEDURE



-- Creating Layout for sub process


EXEC dbo.SP_LAYOUT_STOREPROCEDURE 'L_TEST_SUB_01' ,'SP_TEST_SUBPROCESS_01','Description ','Parameter 01 VARIABLE'



EXEC dbo.SP_LAYOUT_STOREPROCEDURE 'L_TEST_SUB_02' ,'SP_TEST_SUBPROCESS_02','Description ','Parameter 01 VARIABLE'




SELECT * FROM dbo.TB_LAYOUT_STOREPROCEDURE

---------------------------------------------------------------------------------------
SELECT * FROM TB_LAYOUT_HISTORY_STOREPROCEDURE