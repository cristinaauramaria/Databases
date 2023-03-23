CREATE DATABASE FARMACIE
GO

USE FARMACIE

CREATE TABLE Farmacie(
cod_farmacie INT PRIMARY KEY IDENTITY,
nume VARCHAR(100),
adresa VARCHAR(100),
nr_telef VARCHAR(100),
oras VARCHAR(100),
);

CREATE TABLE Medicament(
cod_medicament INT PRIMARY KEY IDENTITY,
nume VARCHAR(100),
descriere VARCHAR(100),
producator VARCHAR(100),
mod_administrare VARCHAR(100),
);

CREATE TABLE Stoc(
cod_farmacie INT FOREIGN KEY REFERENCES Farmacie(cod_farmacie),
cod_medicament INT FOREIGN KEY REFERENCES Medicament(cod_medicament),
pret FLOAT
CONSTRAINT pk_stoc PRIMARY KEY (cod_farmacie,cod_medicament)
);

CREATE TABLE Afectiune(
cod_afectiune INT PRIMARY KEY IDENTITY,
nume VARCHAR(100),
descriere VARCHAR(100)
);

CREATE TABLE Tratament(
cod_medicament INT FOREIGN KEY REFERENCES Medicament(cod_medicament),
cod_afectiune INT FOREIGN KEY REFERENCES Afectiune(cod_afectiune)
CONSTRAINT pk_tratament PRIMARY KEY (cod_afectiune,cod_medicament)
);

INSERT INTO Farmacie(nume,adresa,nr_telef,oras) VALUES ('F1','STR5','072343523','Cluj'),('F2','STR6','072343523','Cluj'),('F3','STR7','072343523','Cluj');
INSERT INTO Medicament(nume,descriere,producator,mod_administrare) VALUES ('M1','D1','P1','S1'),('M2','D2','P2','S2'),('M3','D3','P3','S3');
INSERT INTO Stoc(cod_farmacie,cod_medicament,pret) VALUES (1,1,20),(2,2,30),(3,3,75);
INSERT INTO Afectiune(nume,descriere) VALUES ('gripa','D1'),('durere de spate','D2'),('durere de cap','D3'),('gripa','D4');
INSERT INTO Tratament(cod_afectiune,cod_medicament) VALUES (1,1),(2,2),(3,3),(4,1);
INSERT INTO Tratament(cod_afectiune,cod_medicament) VALUES (4,3);
INSERT INTO Tratament(cod_afectiune,cod_medicament) VALUES (2,3);
INSERT INTO Tratament(cod_afectiune,cod_medicament) VALUES (2,1);
DELETE FROM Tratament;
DELETE FROM Afectiune WHERE cod_afectiune=4;
INSERT INTO Tratament(cod_afectiune,cod_medicament) VALUES (1,1),(2,1),(1,2);
SELECT *FROM Farmacie;
SELECT *FROM Medicament;
SELECT *FROM Stoc;
SELECT *FROM Afectiune;
SELECT *FROM Tratament;

GO
CREATE PROCEDURE Oferta @cod_farmacie INT, @cod_medicament INT, @pret FLOAT
AS
BEGIN
	IF EXISTS(SELECT *FROM Stoc WHERE cod_farmacie=@cod_farmacie AND cod_medicament=@cod_medicament)
	BEGIN
		UPDATE Stoc SET pret=@pret WHERE cod_farmacie=@cod_farmacie AND cod_medicament=@cod_medicament
	END
	ELSE
	BEGIN
		INSERT INTO Stoc(cod_farmacie,cod_medicament,pret) values (@cod_farmacie,@cod_medicament,@pret)
	END

END

GO
EXEC Oferta 3,1,400;
EXEC Oferta 1,2,35;

GO
CREATE VIEW view_med AS SELECT M.nume FROM Medicament M 
INNER JOIN Tratament T ON M.cod_medicament=T.cod_medicament
INNER JOIN Afectiune A ON T.cod_afectiune=A.cod_afectiune
WHERE A.nume='gripa' AND NOT EXISTS(
	SELECT * FROM Tratament T2
	INNER JOIN Afectiune A2 ON T2.cod_afectiune=A2.cod_afectiune AND A.cod_afectiune!=A2.cod_afectiune
	INNER JOIN Medicament M2 ON M2.cod_medicament=T2.cod_medicament AND M2.cod_medicament=M.cod_medicament
	WHERE A2.nume='durere de spate')
GROUP BY M.nume;

GO
SELECT* FROM view_med;

DROP VIEW view_med;



GO
CREATE VIEW view_med AS SELECT M.nume FROM Medicament M 
INNER JOIN Tratament T ON M.cod_medicament=T.cod_medicament
INNER JOIN Afectiune A ON T.cod_afectiune=A.cod_afectiune
INNER JOIN Medicament M2 ON T.cod_medicament=M2.cod_medicament AND T.cod_afectiune!= A.cod_afectiune
WHERE A.nume='gripa' AND A.nume!='durere de spate' AND M.cod_medicament!=M2.cod_medicament
GROUP BY M.nume;



