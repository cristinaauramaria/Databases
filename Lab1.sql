CREATE DATABASE [Dealership_Auto_Final];
GO
USE [Dealership_Auto_Final];

CREATE TABLE Funcție
(cod_f INT PRIMARY KEY IDENTITY,
nume_f VARCHAR(100) NOT NULL,
salariu_baza_f INT
);

CREATE TABLE Angajat
(cod_a INT PRIMARY KEY IDENTITY,
nume_a VARCHAR(100) NOT NULL,
cnp_a VARCHAR(100) NOT NULL UNIQUE,
cod_f INT FOREIGN KEY REFERENCES Funcție(cod_f) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Client
(cod_c INT PRIMARY KEY IDENTITY,
nume_c VARCHAR(100) NOT NULL,
cnp_c VARCHAR(100) NOT NULL UNIQUE,
);

CREATE TABLE Review_client
(cod_r INT PRIMARY KEY IDENTITY,
comentariu_rc VARCHAR(300),
stea_rc INT CHECK(stea_rc>=1 AND stea_rc<=5),
data_rc DATE DEFAULT GETDATE(),
cod_c INT FOREIGN KEY REFERENCES Client(cod_c) 
);

CREATE TABLE Vizionare
(cod_v INT PRIMARY KEY IDENTITY,
data_si_ora_vizionarii DATETIME,
detalii_masina_v VARCHAR(100)
);

CREATE TABLE Participant_vizionare
(cod_c INT,
cod_v INT,
cod_a INT,
CONSTRAINT fk_ClientParticipant_vizionare FOREIGN KEY(cod_c) REFERENCES Client(cod_c),
CONSTRAINT fk_VizionareParticipant_vizionare FOREIGN KEY(cod_v) REFERENCES Vizionare(cod_v),
CONSTRAINT fk_AngajatParticipant_vizionare FOREIGN KEY(cod_a) REFERENCES Angajat(cod_a),
Constraint pk_Participant_vizionare PRIMARY KEY(cod_c,cod_v,cod_a)
);

CREATE TABLE Model
(cod_mm INT PRIMARY KEY IDENTITY,
nume_m VARCHAR(100) NOT NULL,
model_m VARCHAR(100) NOT NULL,
an_fabricatie_m INT CHECK(an_fabricatie_m>=1990),
);

CREATE TABLE Mașină
(cod_m INT PRIMARY KEY IDENTITY,
serie_sasiu_m VARCHAR(30) NOT NULL UNIQUE,
cod_mm INT FOREIGN KEY REFERENCES Model(cod_mm) 
);


CREATE TABLE Vanzare_masina
(cod_vm INT PRIMARY KEY IDENTITY,
pret INT NOT NULL,
data_v DATE NOT NULL,
cod_m INT FOREIGN KEY REFERENCES  Mașină(cod_m)
);

CREATE TABLE Acces_masina
(cod_m INT,
cod_a INT,
CONSTRAINT fk_MasinaAcces_masina FOREIGN KEY(cod_m) REFERENCES Mașină(cod_m) ,
CONSTRAINT fk_AngajatAcces_masina FOREIGN KEY(cod_a) REFERENCES Angajat(cod_a),
Constraint pk_Acces_masina PRIMARY KEY(cod_m,cod_a)
);


CREATE TABLE Versiune
(versiune INT
);