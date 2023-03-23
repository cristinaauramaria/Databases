CREATE DATABASE FLORARIE
GO

CREATE TABLE Florarie(
cod_f INT PRIMARY KEY IDENTITY,
nume_f NVARCHAR(50) NOT NULL,
nrtelef_f NVARCHAR(50) NOT NULL,
adresa_f NVARCHAR(50) NOT NULL,
);

CREATE TABLE CategorieAranjamentFloral(
cod_caf INT PRIMARY KEY IDENTITY,
nume_caf NVARCHAR(50) NOT NULL
);

CREATE TABLE AranjamentFloral(
cod_af INT PRIMARY KEY IDENTITY,
nume_af NVARCHAR(50) NOT NULL,
pret_af FLOAT NOT NULL,
descriere_af NVARCHAR(50) NOT NULL,
inaltime FLOAT NOT NULL,
cod_caf INT FOREIGN KEY REFERENCES CategorieAranjamentFloral(cod_caf) ON UPDATE CASCADE ON DELETE CASCADE,
cod_f INT FOREIGN KEY REFERENCES Florarie(cod_f) ON UPDATE CASCADE ON DELETE CASCADE

);

CREATE TABLE Planta(
cod_p INT PRIMARY KEY IDENTITY,
nume_af NVARCHAR(50) NOT NULL,
descriere_af NVARCHAR(50) NOT NULL
);



CREATE TABLE PlantaAranjament(
cod_p INT,
cod_af INT,
nr_exemplare INT,
CONSTRAINT fk_Planta FOREIGN KEY(cod_p) REFERENCES Planta(cod_p),
CONSTRAINT fk_Aranjament FOREIGN KEY(cod_af) REFERENCES AranjamentFloral(cod_af),
Constraint pk_PlantaAranjament PRIMARY KEY (cod_p,cod_af),

);


INSERT INTO Planta(nume_af,descriere_af) VALUES ('LALEA','ROZ'),('TRANDAFIR','GALBEN'),('ZAMBILA','MOV');
SELECT* FROM Planta;

INSERT INTO Florarie(nume_f,nrtelef_f,adresa_f) VALUES ('PRIMA','0733555789','STR 5'),('DOUA','0789123456','STR 7'),('TREI','0789867634','STR 98');
SELECT * FROM Florarie;
INSERT INTO Florarie(nume_f,nrtelef_f,adresa_f) VALUES ('MARTA','345','DF4');
INSERT INTO CategorieAranjamentFloral(nume_caf) VALUES ('BUCHET'),('GHIVECI'),('COROANA');
SELECT* FROM CategorieAranjamentFloral;

INSERT INTO AranjamentFloral(nume_af,pret_af,descriere_af,inaltime,cod_caf,cod_f) VALUES 
('A1',35,'FRUMOS',10,1,1),('A2',20,'FRUMUSEL',22,2,2),('A3',55,'MHEH',50,3,3);
SELECT*FROM AranjamentFloral;
INSERT INTO AranjamentFloral(nume_af,pret_af,descriere_af,inaltime,cod_caf,cod_f) VALUES 
('A1',35,'FRUMOS',10,1,4);

INSERT INTO PlantaAranjament(cod_p,cod_af,nr_exemplare) VALUES (1,1,2),(2,2,4),(3,3,5);
SELECT* FROM PlantaAranjament;
INSERT INTO PlantaAranjament(cod_p,cod_af,nr_exemplare) VALUES (1,4,2);

DELETE FROM PlantaAranjament;


GO
CREATE PROCEDURE florarie_help @cod_af1 INT, @cod_p1 INT, @nrexemplare1 INT
AS
BEGIN
	IF EXISTS(SELECT *FROM PlantaAranjament WHERE cod_p=@cod_p1 AND cod_af=@cod_af1)
	BEGIN
		UPDATE PlantaAranjament SET nr_exemplare=@nrexemplare1 WHERE cod_p=@cod_p1 AND cod_af=@cod_af1
	END
	ELSE
	BEGIN
		INSERT INTO PlantaAranjament(cod_p,cod_af,nr_exemplare) values (@cod_p1,@cod_af1,@nrexemplare1)
	END

END

GO 
EXEC florarie_help 1,3,6;
SELECT *FROM PlantaAranjament;

GO
CREATE VIEW fview AS SELECT F.nume_f,A.pret_af,PA.nr_exemplare,P.nume_af  FROM Florarie F 
INNER JOIN AranjamentFloral A ON F.cod_f=A.cod_f 
INNER JOIN PlantaAranjament PA ON A.cod_af=PA.cod_af
INNER JOIN Planta P ON PA.cod_p=P.cod_p
WHERE F.nume_f LIKE '[^M]%';

GO
SELECT *FROM test;

GO
CREATE VIEW test AS SELECT F.nume_f,A.pret_af,PA.nr_exemplare,P.nume_af  FROM Florarie F 
INNER JOIN AranjamentFloral A ON F.cod_f=A.cod_f 
INNER JOIN PlantaAranjament PA ON A.cod_af=PA.cod_af
INNER JOIN Planta P ON PA.cod_p=P.cod_p;
