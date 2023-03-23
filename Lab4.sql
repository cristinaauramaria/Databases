USE [Dealership_Auto_Final]
GO

CREATE PROCEDURE Main @nr_rows varchar(30)
AS
BEGIN
	IF(ISNUMERIC(@nr_rows) != 1)
	BEGIN
		print('Nu ai introdus un numar!')
		return 1
	END

	declare @all_start datetime
	set @all_start = GETDATE()

	declare @accesM_delete_start datetime
	set @accesM_delete_start=GETDATE()
	exec delete_rows 'Acces_masina'
	declare @accesM_delete_end datetime
	set @accesM_delete_end = GETDATE()

	declare @angajat_delete_start datetime
	set @angajat_delete_start=GETDATE()
	exec delete_rows 'Angajat'
	declare @angajat_delete_end datetime
	set @angajat_delete_end = GETDATE()
	

	declare @functie_delete_start datetime
	set @functie_delete_start=GETDATE()
	exec delete_rows 'Functie'
	declare @functie_delete_end datetime
	set @functie_delete_end = GETDATE()

	declare @functie_insert_start datetime
	set @functie_insert_start=GETDATE()
	exec insert_rows @nr_rows, 'Functie'
	declare @functie_insert_end datetime
	set @functie_insert_end = GETDATE()
	
	declare @angajat_insert_start datetime
	set @angajat_insert_start=GETDATE()
	exec insert_rows @nr_rows, 'Angajat'
	declare @angajat_insert_end datetime
	set @angajat_insert_end = GETDATE()

	declare @accesM_insert_start datetime
	set @accesM_insert_start=GETDATE()
	exec insert_rows @nr_rows, 'Acces_masina'
	declare @accesM_insert_end datetime
	set @accesM_insert_end = GETDATE()

	declare @view_1_table_start datetime
	set @view_1_table_start = GETDATE()
	exec select_view 'vw_1_table'
	declare @view_1_table_end datetime
	set @view_1_table_end = GETDATE()

	declare @view_2_tables_start datetime
	set @view_2_tables_start = GETDATE()
	exec select_view 'vw_2_tables'
	declare @view_2_tables_end datetime
	set @view_2_tables_end = GETDATE()

	declare @view_2_tables_group_by_start datetime
	set @view_2_tables_group_by_start = GETDATE()
	exec select_view 'vw_2_tables_groupby'
	declare @view_2_tables_group_by_end datetime
	set @view_2_tables_group_by_end = GETDATE()

	declare @all_stop datetime 
	set @all_stop = getdate() 

	declare @description varchar(100)
	set @description = 'TestRun delete, insert ' + @nr_rows + 'rows, select all views'

	insert into TestRuns(Description, StartAt, EndAt)
	values(@description, @all_start, @all_stop);

	declare @lastTestRunID int; 
	set @lastTestRunID = (select max(TestRunID) from TestRuns);

	
	insert into TestRunTables
	values(@lastTestRunID, 1, @accesM_insert_start, @accesM_insert_end)

	insert into TestRunTables
	values(@lastTestRunID, 2, @angajat_insert_start, @angajat_insert_end)

	insert into TestRunTables
	values(@lastTestRunID, 3, @functie_insert_start, @functie_insert_end)

	insert into TestRunViews
	values(@lastTestRunID, 1, @view_1_table_start, @view_1_table_end)
	
	insert into TestRunViews
	values(@lastTestRunID, 2, @view_2_tables_start, @view_2_tables_end)

	insert into TestRunViews
	values(@lastTestRunID,3, @view_2_tables_group_by_start, @view_2_tables_group_by_end)


END

GO
EXEC Main '100'

DELETE FROM TestRuns
DELETE FROM TestRunTables
DELETE FROM TestRunViews

SELECT *FROM TestRuns
SELECT *FROM TestRunTables
SELECT *FROM TestRunViews


SELECT *FROM Tables
SELECT *FROM Tests
SELECT *FROM TestTables
SELECT *FROM TestViews
SELECT *FROM Views

DROP PROCEDURE Main