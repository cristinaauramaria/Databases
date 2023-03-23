USE [Dealership_Auto_Final];

CREATE TABLE Versiune(versiune INT);
INSERT INTO Versiune VALUES (0);
SELECT * FROM Versiune;

GO

CREATE PROCEDURE do_procedure1
AS
BEGIN
ALTER TABLE Review_client
ALTER COLUMN comentariu_rc NVARCHAR(500)
UPDATE Versiune
SET versiune=1;
END;

GO
CREATE PROCEDURE undo_procedure1
AS
BEGIN
ALTER TABLE Review_client
ALTER COLUMN comentariu_rc VARCHAR(300)
UPDATE Versiune
SET versiune=0;
END;

GO
CREATE PROCEDURE do_procedure2
AS 
BEGIN
CREATE TABLE Tuning_masina
(cod_t INT PRIMARY KEY IDENTITY,
 servicii_t NVARCHAR(300) NOT NULL,
 cod_m INT
);
UPDATE Versiune
SET versiune=2;
END;

GO
CREATE PROCEDURE undo_procedure2
AS 
BEGIN
DROP TABLE Tuning_masina;
UPDATE Versiune
SET versiune=1;
END;

GO
CREATE PROCEDURE do_procedure3
AS
BEGIN
ALTER TABLE Vanzare_masina
ADD CONSTRAINT df_data_vanzarii DEFAULT GETDATE() FOR data_v;
UPDATE Versiune
SET versiune=3;
END;

GO
CREATE PROCEDURE undo_procedure3
AS
BEGIN
ALTER TABLE Vanzare_masina
DROP CONSTRAINT df_data_vanzarii
UPDATE Versiune
SET versiune=2;
END;

GO
CREATE PROCEDURE do_procedure4
AS
BEGIN
ALTER TABLE Client
ADD email_c NVARCHAR(100);
UPDATE Versiune
SET versiune=4;
END;

GO
CREATE PROCEDURE undo_procedure4
AS
BEGIN
ALTER TABLE Client
DROP COLUMN email_c;
UPDATE Versiune
SET versiune=3;
END;

GO
CREATE PROCEDURE do_procedure5
AS
BEGIN
ALTER TABLE Tuning_masina
ADD CONSTRAINT fk_cod_m FOREIGN KEY (cod_m) REFERENCES Mașină(cod_m);
UPDATE Versiune
SET versiune=5;
END;

GO
CREATE PROCEDURE undo_procedure5
AS
BEGIN 
ALTER TABLE Tuning_masina
DROP CONSTRAINT fk_cod_m
UPDATE Versiune
SET versiune=4;
END;

GO
CREATE PROCEDURE UpdateVersiune @versiune_new INT
 AS
 BEGIN
	IF @versiune_new < 0 OR @versiune_new > 5
	BEGIN 
		PRINT 'Ai ales o versiune invalida!'
		RETURN
	END

	DECLARE @versiune AS INT
	SET @versiune  = (SELECT versiune FROM Versiune)
	IF @versiune_new = @versiune
	BEGIN
		PRINT 'Ne aflam deja in versiunea aleasa!'
		RETURN
	END
	DECLARE @procedura VARCHAR(20)
	DECLARE @undo_procedura VARCHAR(20)

	WHILE(@versiune < @versiune_new )
		BEGIN
			SET @versiune = @versiune + 1
			SET @procedura = 'do_procedure' + CAST(@versiune AS VARCHAR(20))
			PRINT 'Am executat ' + @procedura;
			EXEC @procedura
		END
	WHILE(@versiune > @versiune_new)
		BEGIN
			SET @undo_procedura = 'undo_procedure' + CAST(@versiune AS VARCHAR(20))
			EXEC @undo_procedura
			PRINT 'Am executat ' + @undo_procedura;
			SET @versiune = @versiune - 1
		END
END


GO
EXEC UpdateVersiune 7;
SELECT* FROM Versiune





/*
DROP PROCEDURE AdaugaCampNou;
DROP PROCEDURE AdaugaConstrangereDefault;
DROP PROCEDURE AdaugaFK;
DROP PROCEDURE CreateTableTuningMasina;
DROP PROCEDURE DropTableTuningMasina;
DROP PROCEDURE EliminaConstrangereDefault;
DROP PROCEDURE EliminaFK;
DROP PROCEDURE ModificaTipulColoanei;
DROP PROCEDURE StergeCampNou;
DROP PROCEDURE UndoModificaTipulColoanei;
*/