USE [Dealership_Auto_Final]
GO
CREATE PROCEDURE delete_rows @table_name varchar(30)
AS
BEGIN
	declare @table varchar(100)
	set @table = ('['+ @table_name +']')

	if(@table_name = 'Functie')
	begin
		delete from Funcție
	end

	if(@table_name = 'Angajat')
	begin
		delete from Angajat
	end

	if(@table_name = 'Acces_masina')
	begin
		delete from Acces_masina
	end
END

DROP PROCEDURE delete_rows
DELETE FROM Acces_masina
DELETE FROM Angajat
DELETE FROM Funcție
EXEC delete_rows @table_name='Acces_masina'
SELECT * FROM Acces_masina
SELECT * FROM Angajat
SELECT * FROM Funcție