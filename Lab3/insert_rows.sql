USE [Dealership_Auto_Final]
GO
CREATE PROCEDURE insert_rows @nr_rows varchar(30),@table_name varchar(30)
AS
BEGIN
	declare @table varchar(100)
	set @table = ('['+ @table_name +']')

	if ISNUMERIC(@nr_rows) != 1
	begin
		print('Nu ai introdus un numar!')
		return 1
	end

	SET @nr_rows = CAST(@nr_rows as INT)

	declare @indice int
	set @indice = 1

	--Functie
	declare @nume_f varchar(30)
	declare @salariu_baza_f INT
	set @salariu_baza_f = 2750

	--Angajat
	declare @nume_a varchar(30)
	declare @cnp_a varchar(30)
	declare @cod_f INT

	--Acces_masina
	declare @cod_m INT
	set @cod_m = 5
	declare @cod_a INT


	WHILE (@indice <= @nr_rows)
	begin
		if (@table_name = 'Functie')
		begin
			--cod
			set @nume_f = 'Functia' + convert(varchar(7),@indice)
			insert into Funcție(nume_f,salariu_baza_f) values (@nume_f,@salariu_baza_f)
		end
		
		if (@table_name = 'Angajat')
		begin
			--cod
			set @nume_a = 'Nume' + convert(varchar(7),@indice)
			set @cnp_a = 'Cnp' + convert(varchar(7),@indice)
			set @cod_f = (select MAX(cod_f) from Funcție)-@indice+1
			insert into Angajat(nume_a,cnp_a,cod_f) values (@nume_a,@cnp_a,@cod_f)
		end

		if (@table_name = 'Acces_masina')
		begin
			--cod
			set @cod_a = (select MAX(cod_a) from Angajat) - @indice+1
			insert into Acces_masina(cod_m,cod_a) values (@cod_m,@cod_a)
		end

		set @indice = @indice + 1
	end
END

DROP PROCEDURE insert_rows
DELETE FROM Acces_masina
DELETE FROM Angajat
DELETE FROM Funcție

GO
EXEC insert_rows @nr_rows='100', @table_name='Functie'
EXEC insert_rows @nr_rows='100', @table_name='Angajat'
EXEC insert_rows @nr_rows='100', @table_name='Acces_masina'

SELECT * FROM Acces_masina
SELECT * FROM Angajat
SELECT * FROM Funcție

