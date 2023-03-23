USE [Dealership_Auto_Final]
GO
CREATE VIEW vw_1_table AS SELECT nume_f FROM Funcție

GO
CREATE VIEW vw_2_tables AS SELECT AM.cod_m, A.nume_a FROM Angajat A INNER JOIN Acces_masina AM ON A.cod_a = AM.cod_a 


GO
CREATE VIEW vw_2_tables_groupby  AS SELECT F.nume_f, COUNT(cod_a) nr_angajati FROM Funcție F 
INNER JOIN Angajat A on F.cod_f=A.cod_f 
GROUP BY F.cod_f,F.nume_f

GO
CREATE PROCEDURE select_view @view_name varchar(30)
AS
BEGIN
	IF(@view_name = 'vw_1_table')
	BEGIN
		SELECT *FROM vw_1_table
	END

	IF(@view_name = 'vw_2_tables')
	BEGIN
		SELECT *FROM vw_2_tables
	END

	IF(@view_name = 'vw_2_tables_groupby')
	BEGIN
		SELECT *FROM vw_2_tables_groupby
	END
END

INSERT INTO Views(Name) VALUES ('vw_1_table'),('vw_2_tables'),('vw_2_tables_groupby')
INSERT INTO Tables(Name) VALUES ('Functie'),('Angajat'),('Acces_masina')

GO
SELECT *FROM vw_1_table
SELECT *FROM vw_2_tables
SELECT *FROM vw_2_tables_groupby
