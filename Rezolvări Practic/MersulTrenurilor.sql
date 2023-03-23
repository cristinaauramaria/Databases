CREATE DATABASE MersulTrenurilor;
GO
USE MersulTrenurilor;
GO

CREATE TABLE Tip(
cod_tip INT PRIMARY KEY IDENTITY,
descriere VARCHAR(100)
);

CREATE TABLE Tren(
cod_tren INT PRIMARY KEY IDENTITY,
nume VARCHAR(100),
cod_tip INT FOREIGN KEY REFERENCES Tip(cod_tip)
);

CREATE TABLE Statie(
cod_statie INT PRIMARY KEY IDENTITY,
nume VARCHAR(100)
);

CREATE TABLE Ruta(
cod_ruta INT PRIMARY KEY IDENTITY,
nume VARCHAR(100),
cod_tren INT FOREIGN KEY REFERENCES Tren(cod_tren)
);

CREATE TABLE Traseu(
cod_ruta INT FOREIGN KEY REFERENCES Ruta(cod_ruta),
cod_statie INT FOREIGN KEY REFERENCES Statie(cod_statie),
ora_sosire TIME,
ora_plecare TIME,
CONSTRAINT pk_traseu PRIMARY KEY (cod_ruta,cod_statie)
);

INSERT INTO Tip(descriere) VALUES ('t1'),('t2'),('t3');
INSERT INTO Tren(nume,cod_tip) VALUES ('T1',1),('T2',2),('T3',3);
INSERT INTO Statie(nume) VALUES ('s1'),('s2'),('s3');
INSERT INTO Ruta(nume,cod_tren) VALUES ('r1',1),('r2',2),('r3',3);
INSERT INTO Traseu(cod_ruta,cod_statie,ora_sosire,ora_plecare) VALUES (1,1,'22:29:00','22:50:00'),(2,2,'23:29:00','23:50:00'),(3,3,'12:29:00','12:50:00');

SELECT *FROM Tip;
SELECT *FROM Tren;
SELECT *FROM Statie;
SELECT *FROM Ruta;
SELECT *FROM Traseu;

GO
CREATE PROCEDURE TraseuNou @cod_ruta INT, @cod_statie INT,@ora_sosirii TIME,@ora_plecarii TIME
AS
BEGIN
	IF EXISTS(SELECT *FROM Traseu WHERE cod_ruta=@cod_ruta AND cod_statie=@cod_statie)
	BEGIN
		UPDATE Traseu SET ora_plecare=@ora_plecarii,ora_sosire=@ora_sosirii  WHERE cod_ruta=@cod_ruta AND cod_statie=@cod_statie
	END
	ELSE
	BEGIN
		INSERT INTO Traseu(cod_ruta,cod_statie,ora_plecare,ora_sosire) values (@cod_ruta,@cod_statie,@ora_plecarii,@ora_sosirii)
	END

END

EXEC TraseuNou 1,3,'12:30:00','15:50:00'

GO
CREATE VIEW RutaCompleta
AS SELECT R.nume FROM Ruta R INNER JOIN Traseu T ON T.cod_ruta=R.cod_ruta GROUP BY R.cod_ruta,R.nume
HAVING COUNT(*)=(SELECT COUNT(*) FROM Statie);

GO
SELECT * FROM RutaCompleta;

GO 
CREATE FUNCTION StatieTM()
RETURNS TABLE AS
RETURN
	SELECT DISTINCT S.nume FROM Statie S 
	INNER JOIN Traseu T ON S.cod_statie=T.cod_statie 
	INNER JOIN Traseu T2 ON S.cod_statie=T2.cod_statie AND T.cod_ruta != T2.cod_ruta
	WHERE T.ora_sosire BETWEEN T2.ora_sosire AND T2.ora_plecare;

GO
SELECT* FROM dbo.StatieTM();

DROP FUNCTION dbo.StatieTM