CREATE DATABASE [Vinuri]
GO
USE [Vinuri]
GO

CREATE TABLE Tari(
id_tara INT PRIMARY KEY IDENTITY,
nume_tara VARCHAR(20))

CREATE TABLE SoiVin(
id_soi INT PRIMARY KEY IDENTITY,
nume_soi VARCHAR(20),
calitate VARCHAR(20))

CREATE TABLE Vin(
id_vin INT PRIMARY KEY IDENTITY,
denumire VARCHAR(100),
descriere VARCHAR(100),
an_fabr INT,
cod_tara INT FOREIGN KEY REFERENCES Tari(id_tara) ,
cod_soi INT FOREIGN KEY REFERENCES SoiVin(id_soi) )

CREATE TABLE Somelier(
id_som INT PRIMARY KEY IDENTITY,
nume_somn VARCHAR(100),
nrTel VARCHAR(100),
email VARCHAR(100))

CREATE TABLE Degustare(
cod_som INT,
cod_vin INT,
comentariu VARCHAR(100),
CONSTRAINT fk_Vin FOREIGN KEY (cod_vin) REFERENCES Vin(id_vin), 
CONSTRAINT fk_Somelier FOREIGN KEY (cod_som) REFERENCES Somelier(id_som),
CONSTRAINT pk_Degustare  PRIMARY KEY  (cod_vin,cod_som)) 


GO
CREATE OR ALTER PROCEDURE AddCom @vin INT,@somelier INT, @comentariu VARCHAR(100)
AS
BEGIN 
	if EXISTS(SELECT * FROM Degustare WHERE cod_vin = @vin AND cod_som = @somelier)
	BEGIN
		UPDATE Degustare SET comentariu = @comentariu WHERE cod_vin = @vin AND cod_som = @somelier
	END
	else
	BEGIN
		INSERT INTO Degustare(cod_vin,cod_som,comentariu) VALUES (@vin,@somelier,@comentariu)
	END
END
Go

CREATE FUNCTION F()
RETURNS TABLE
AS
	RETURN SELECT Vin.denumire, Count(Degustare.comentariu) as 'nr. com' from Vin
	INNER JOIN Degustare on Vin.id_vin = Degustare.cod_vin	
	GROUP BY  Vin.denumire
	HAVING Count(Degustare.comentariu) != 2