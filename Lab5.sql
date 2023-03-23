USE [Dealership_Auto_Final]
GO

--creare functii


CREATE FUNCTION checkFormatNumber(@number varchar(MAX))
RETURNS BIT
AS
BEGIN
	IF @number IS NULL
		RETURN 0
	IF LTRIM(@number) = ''
		return 0

	declare @lungime int
	set @lungime = LEN(@number)

	declare @contor int
	set @contor = 1

	declare @substrin varchar(MAX)
	declare @car char

	while @contor <= @lungime
	begin
		select @car = SUBSTRING(@number, @contor, 1)
		if ISNUMERIC(@car) != 1
		begin
			return 0
		end

		set @contor = @contor + 1
	end
	return 1

END


GO
PRINT dbo.checkFormatNumber('23 A')

GO
CREATE FUNCTION checkFormatCNP( @cnp varchar(100))
RETURNS BIT
AS 
BEGIN
	if dbo.checkFormatNumber(@cnp) = 0
		return 0
	if len(@cnp) != 13
		return 0
	return 1
END

GO
PRINT dbo.checkFormatCNP('6030321090030')


GO
CREATE or ALTER FUNCTION checkFormatName(@name varchar(50))
RETURNS BIT
AS
BEGIN
	IF @name IS NULL
		RETURN 0
	IF LTRIM(@name) = ''
		return 0
	IF LEN(@name) < 3 
		RETURN 0

	declare @lungime int
	set @lungime = LEN(@name)

	declare @contor int
	set @contor = 1

	declare @substrin varchar(MAX)
	declare @car char

	while @contor <= @lungime
	begin
		if not SUBSTRING(@name, @contor, 1) like '%[a-zA-Z ]'
			return 0

		set @contor = @contor + 1
	end

	RETURN 1

END

GO
PRINT dbo.checkFormatName('Ana Varga')

GO
CREATE FUNCTION checkFormatSerieSasiu(@serie_sasiu varchar(50))
RETURNS BIT
AS
BEGIN
	IF @serie_sasiu IS NULL
		RETURN 1
	IF LTRIM(@serie_sasiu) = ''
		return 0
	IF LEN(@serie_sasiu) != 17
		RETURN 0

	declare @lungime int
	set @lungime = 17

	declare @contor int
	set @contor = 1

	declare @substrin varchar(MAX)
	declare @car char

	while @contor <= @lungime
	begin
		if not SUBSTRING(@serie_sasiu, @contor, 1) like '%[A-Z0-9]'
			return 0
		set @contor = @contor + 1
	end
	RETURN 1
END

GO
DROP FUNCTION DBO.checkFormatSerieSasiu
GO
PRINT dbo.checkFormatSerieSasiu('ZARL1R207YYWT5312')


--proceduri CRUD

GO
CREATE PROCEDURE crudAngajat
	@what varchar(MAX),
	@id varchar(15),
	@nume varchar(max),
	@cnp varchar(max),
	@cod_f varchar(15)
AS
BEGIN
	DECLARE @RES BIT = 1
	DECLARE @comm varchar(250)

	if dbo.checkFormatNumber(@id) = 0
	begin
		print 'Id is not a number'
		set @res = 0
	end

	if dbo.checkFormatName(@nume) = 0
	begin
		print 'Name is invalid'
		set @res = 0
	end

	if dbo.checkFormatCNP(@cnp) = 0
	begin
		print 'CNP is invalid'
		set @res = 0
	end

	if dbo.checkFormatNumber(@cod_f) = 0
	begin
		print 'Cod functie is not a number'
		set @res = 0
	end
	if not exists(select * from dbo.Funcție where cod_f = cast(@cod_f as int))
	begin
		print 'The action cannot be performed because the cod_f does not exist'
		set @RES = 0
	end
	

	--execute command

	if @RES = 1
	begin
		if @what = 'delete'
		begin
			if not exists (select * from dbo.Angajat where cod_a = cast(@id as int))
			begin
				print 'The action cannot be performed because the id does not exist'
				return
			end
			delete from	Angajat
			where cod_a = cast(@id as int)
			print 'Delete complet'
		end
		
		else if @what = 'insert'
		begin
			insert into Angajat(nume_a,cnp_a,cod_f) values(@nume,@cnp, @cod_f)
			print 'Insert complet'
		end
		else if @what = 'update'
		begin
			if @id is null
			begin
				print 'The action cannot be performed because the id is null'
				return
			end
			
			if not exists (select * from dbo.Angajat where cod_a = cast(@id as int))
			begin
				print 'The action cannot be performed because the id does not exist'
				return
			end
			
			update Angajat
			set nume_a=@nume, cnp_a=@cnp, cod_f=@cod_f
			where cod_a = cast(@id as int)

			print 'Update complet'
		end
		else if @what = 'select'
		begin
			select * from Angajat
			where nume_a=@nume
			
			print 'Select complet'
		end
		else 
			print 'Please insert a correct command!'
	end
END

GO
CREATE PROCEDURE crudMasina
	@what varchar(MAX),
	@id varchar(15),
	@serie_sasiu varchar(max),
	@cod_model varchar(15)
AS
BEGIN
	DECLARE @RES BIT = 1
	DECLARE @comm varchar(250)

	if dbo.checkFormatNumber(@id) = 0
	begin
		print 'Id is not a number'
		set @res = 0
	end

	if dbo.checkFormatSerieSasiu(@serie_sasiu) = 0
	begin
		print 'Serie sasiu is invalid'
		set @res = 0
	end

	if dbo.checkFormatNumber(@cod_model) = 0
	begin
		print 'Cod model is not a number'
		set @res = 0
	end
	if not exists(select * from dbo.Model where cod_mm = cast(@cod_model as int))
	begin
		print 'The action cannot be performed because the cod_model does not exist'
		set @RES = 0
	end
	

	--execute command

	if @RES = 1
	begin
		if @what = 'delete'
		begin
			if not exists (select * from dbo.Mașină where cod_m = cast(@id as int))
			begin
				print 'The action cannot be performed because the id does not exist'
				return
			end
			delete from	Mașină
			where cod_m= cast(@id as int)
			print 'Delete complet'
		end
		
		else if @what = 'insert'
		begin
			insert into Mașină(serie_sasiu_m,cod_mm) values(@serie_sasiu,@cod_model)
			print 'Insert complet'
		end
		else if @what = 'update'
		begin
			if @id is null
			begin
				print 'The action cannot be performed because the id is null'
				return
			end
			
			if not exists (select * from dbo.Mașină where cod_m = cast(@id as int))
			begin
				print 'The action cannot be performed because the id does not exist'
				return
			end
			
			update Mașină
			set serie_sasiu_m=@serie_sasiu,cod_mm=@cod_model
			where cod_m = cast(@id as int)

			print 'Update complet'
		end
		else if @what = 'select'
		begin
			select * from Mașină
			where serie_sasiu_m=@serie_sasiu
			
			print 'Select complet'
		end
		else 
			print 'Please insert a correct command!'
	end
END

GO
CREATE PROCEDURE crudAccesMasina
	@what varchar(MAX),
	@id_angajat varchar(15),
	@id_masina varchar(15)
AS
BEGIN
	DECLARE @RES BIT = 1
	
	if dbo.checkFormatNumber(@id_angajat) = 0
	begin
		print 'Id angajat is not a number'
		set @res = 0
	end

	if dbo.checkFormatNumber(@id_masina) = 0
	begin
		print 'Id angajat is not a number'
		set @res = 0
	end

	if not exists(select * from dbo.Angajat where cod_a = cast(@id_angajat as int))
	begin
		print 'The action cannot be performed because the id angajat does not exist'
		set @RES = 0
	end

	if not exists(select * from dbo.Mașină where cod_m = cast(@id_masina as int))
	begin
		print 'The action cannot be performed because the id masina does not exist'
		set @RES = 0
	end
	

	--execute command

	if @RES = 1
	begin
		if @what = 'delete'
		begin
			if not exists (select * from dbo.Acces_masina where cod_a = cast(@id_angajat as int) and cod_m = cast(@id_masina as int))
			begin
				print 'The action cannot be performed because the id does not exist'
				return
			end
			delete from	Acces_masina
			where cod_a = cast(@id_angajat as int) and cod_m = cast(@id_masina as int)
			print 'Delete complet'
		end
		
		else if @what = 'insert'
		begin
			insert into Acces_masina(cod_m,cod_a) values(@id_masina,@id_angajat)
			print 'Insert complet'
		end
		else if @what = 'update angajat'
		begin
			if @id_angajat is null or @id_masina is null
			begin
				print 'The action cannot be performed because the id is null'
				return
			end
			
			if not exists (select * from dbo.Angajat where cod_a = cast(@id_angajat as int))
			begin
				print 'The action cannot be performed because the id angajat does not exist'
				return
			end
			
			update Acces_masina
			set cod_a=cast(@id_angajat as int)
			where cod_m = cast(@id_masina as int)

			print 'Update angajat complet'
		end
		else if @what = 'update masina'
		begin
			if @id_angajat is null or @id_masina is null
			begin
				print 'The action cannot be performed because the id is null'
				return
			end
			
			if not exists (select * from dbo.Mașină where cod_m = cast(@id_masina as int))
			begin
				print 'The action cannot be performed because the id does not exist'
				return
			end
			
			update Acces_masina
			set cod_m=cast(@id_masina as int)
			where cod_a = cast(@id_angajat as int)

			print 'Update masina complet'
		end
		else if @what = 'select'
		begin
			select * from Acces_masina
			where cod_a=@id_angajat
			
			print 'Select complet'
		end
		else 
			print 'Please insert a correct command!'
	end
END

GO
CREATE PROCEDURE mainCRUD
AS
BEGIN 
	SELECT* FROM Angajat 
	Execute crudAngajat 'insert','83','Pavel Bartos','6040321090037','12'
	Execute crudAngajat 'select','83','Pavel Bartos','6040321090037','12'
	Execute crudAngajat 'insert','84','Anghel Dorin','600321090037','250'
	Execute crudAngajat 'update','83','Pavel Dragos','6090321090037','12'
	Execute crudAngajat 'select','83','Pavel Dragos','6090321090037','12'
	Execute crudAngajat 'update','82','Anghel Dorin','6030321090037','250'
	Execute crudAngajat 'delete','83','Pavel Dragos','6090321090037','12'
	Execute crudAngajat 'delete','82','Anghel Dorin','603032109007','12'
	
	SELECT* FROM Mașină
	Execute crudMasina 'insert','4','ZARBE00NDBDFT0568','28'
	Execute crudMasina 'select','4','ZARBE00NDBDFT0568','28'
	Execute crudMasina 'insert','4','','28'
	Execute crudMasina 'update','4','ZARBE00NDBDFT0568','29'
	Execute crudMasina 'select','4','ZARBE00NDBDFT0568','29'
	Execute crudMasina 'update','4','Anghel Do','28'
	Execute crudMasina 'delete','4','ZARBE00NDBDFT0568','29'
	Execute crudMasina 'delete','4','Anghel ','280'

	SELECT *FROM Acces_masina
	Execute crudAccesMasina 'insert','4','1'
	Execute crudAccesMasina 'select','4','1'
	Execute crudAccesMasina 'insert','640','1'
	Execute crudAccesMasina 'update masina','4','3'
	Execute crudAccesMasina 'select','4','3'
	Execute crudAccesMasina 'update angajat','330','28'
	Execute crudAccesMasina 'delete','4','3'
	Execute crudAccesMasina 'delete','33','280'
	

END

GO 
EXECUTE mainCRUD

GO
CREATE NONCLUSTERED INDEX index_angajat ON Angajat(nume_a ASC) 
CREATE NONCLUSTERED INDEX index_masina ON Mașină(serie_sasiu_m ASC)

GO 
CREATE VIEW vw_Angajat AS SELECT nume_a FROM Angajat
GO 
CREATE VIEW vw_Masina AS SELECT serie_sasiu_m FROM Mașină

GO 
CREATE PROCEDURE mainViewsIndexes
AS
BEGIN
	select nume_a from vw_Angajat order by nume_a

	select serie_sasiu_m from vw_Masina  order by serie_sasiu_m
END

GO
EXECUTE mainViewsIndexes


--

GO
EXECUTE crudAccesMasina 'update masina','58','6'
GO
EXECUTE crudMasina 'insert','1','ZARBE00NDBDFY0568','28'
GO
Execute crudAngajat 'update','82','Anghel Dorin','6030321090037','17'

SELECT* FROM Angajat 
SELECT* FROM Funcție
SELECT* FROM Mașină
SELECT* FROM Acces_masina

DELETE FROM Mașină
DBCC CHECKIDENT ([Mașină], RESEED, 3);
DBCC CHECKIDENT ([Angajat], RESEED, 82);
DBCC CHECKIDENT ([Acces_masina], RESEED, 0);

DROP PROCEDURE dbo.crudMasina

insert into Mașină(serie_sasiu_m,cod_mm) values ('szdfssdf',33)

DELETE FROM Angajat 
DELETE FROM Mașină where cod_m=4
DELETE FROM Acces_masina