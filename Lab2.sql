INSERT INTO Funcție(nume_f,salariu_baza_f) VALUES ('CEO',5600);
SELECT* FROM Funcție;
INSERT INTO Funcție(nume_f,salariu_baza_f) VALUES ('Sef Resurse umane',4500),('Asistent Resurse umane',3600),
('Sef Contabil',4500),('Adjunct Contabil',4000),('Administrator Sef',4200),('Asistent Administrator',3500),
('Dealer Auto',4500),('Receptioner',3000),('Secretar Sef',4500),('Asistent Secretar',3700),('Femeie de serviciu',2500),
('Paznic',2500);

INSERT INTO Angajat(nume_a,cnp_a,cod_f) VALUES ('Anghel Sorin','1961225101980',8);
SELECT* FROM Angajat;
INSERT INTO Angajat(nume_a,cnp_a,cod_f) VALUES ('Butea Cristina','2991101265012',1),('Oprescu Cosmin','1931001327797',8),
('Baluta Valentina','2870111427763',3),('Melter Delia','6010518379196',3),('Bobocea Iulia','2921025459864',4),
('Bunea Bogdan','1921123199171',5),('Macreanu Ioana','2960912529948',5),('Doaga Vlad','1870625333294',6),
('Orac David','1900831026417',7),('Huzum Dragos','5010825194404',2),('Burea Ana','2930111374376',8),
('Chiriac Denis','1920507221519',8),('Enache Costin','1750625382130',8),('Grigore Mircea','1971019313733',8),
('Turcu Alexandru','1880818274555',8),('Popa Romeo','1891109217435',8),('Tihan Dariana','2910122354541',8),
('Heres Iulia','2950609155340',8),('Smarandescu Julia','2951109057457',9),('Seles Paula','2920227164731',9),
('Marin Marius','1871212320665',10),('Popescu Maria','2970227415529',11),('Mocanescu Andreea','2850724222306',12),
('Darnea Sorina','2720921529390',12),('Pavel Delia','2700214173209',12),('Pavel Iulian','1850625382130',12),
('Nazaru Cornel','1901212320665',12);

INSERT INTO Client(nume_c,cnp_c) VALUES ('Aciu Mircea','1950215216231'),('Badea Ion','1950509325086'),
('Crisan Ovidiu','1980325256891'),('Litescu Simona','2930723030774'),('Antoniu Sabina','2910505281633'),
('Huminic Gabriela','2950807397248'),('Albulescu Radu','1950512395251'),('Babes Alexandru','1890111338447'),
('Paizs Csaba','1871010073142'),('Ionica Marcel','1950727282576'),('Piticescu Radu','1960325014535'),
('Vlase Sorin','1931118233520'),('Girtu Mihai','1950825021895'),('Mutihac Radu','1890625064207'),
('Radu Andrei','1970314076102'),('Moisescu Mihnea','5010320213319'),('Cantaragiu Stefan','1920824081015'),
('Avasilcai Silvia','2880910273397'),('Dumitrache Liliana','6000919151031'),('Buiu Octavia','2870521213841'),
('Banu Iuliana','2940423227960'),('Vidu Livia','6001014090911'),('Salageanu Aurora','2901030065706');
SELECT* FROM Client;

INSERT INTO Model(nume_m,model_m,an_fabricatie_m) VALUES ('Dacia','Duster',2015),('Dacia','Logan',2017),
('Dacia','Sandero',2019),('Dacia','Dokker',2016);
SELECT* FROM Model;
INSERT INTO Model(nume_m,model_m,an_fabricatie_m) VALUES ('Peugeot','208',2020),('Peugeot','308',2019),
('Peugeot','2008',2010),('Peugeot','508',2020),('Peugeot','307',2018),('Toyota','Auris',2018),('Toyota','Yaris',2016),
('Toyota','RAV4',2015),('Toyota','Corrola',2007),('Toyota','C-HR',2019),('Skoda','Octavia',2020),('Skoda','Superb',2019),
('Skoda','Fabia',2005),('Skoda','RAPID',2018),('Skoda','Kodiaq',2017),('Audi','A6',2018),('Audi','A8',2020),('Audi','Q8',2022),
('Mercedes-Benz','GLC',2019),('Mercedes-Benz','GLE',2020),('Mercedes-Benz','S',2018),
('Volkswagen','Polo',2012),('Volkswagen','Golf',2009),('Volkswagen','Jetta',2015),('BMW','Seria 7',2017),
('BMW','X6',2018);
INSERT INTO Model(nume_m,model_m,an_fabricatie_m) VALUES ('Volkswagen','Polo',2012),('Volkswagen','Golf',2009),('Volkswagen','Jetta',2015);

INSERT INTO Mașină(serie_sasiu_m,cod_mm) VALUES ('WA1FTUMPZCJW54841',20),('TRUVEZ7XYD8MK9955',21),('WA1UKTSW1C3A32309',22),
('UU18XE28J4DHY8104',1),('VF2M9RNCZDA3E8173',2),('UU1VM0N4SCKTU8079',3),('VF2U2R3V4Y8J14731',4),
('VF39H8V6JFZ091061',5),('SDBWXUX2PK0603751',6),('VF3JEXNTY6JNL1641',7),('VF30WBK50YDHW4908',8),('VF3WJL3VCPPXN2897',9),
('VNKUUYMPNVYXG1446',10),('TW1D0130H6S6D6990',11),('TW1Y71BR0XMDP7431',12),('TW10XUUADU8V87193',13),('SB165BEFFYS203208',14),
('TMBKAZPTVPCPS0607',15),('TMBLMPU0E3V6X1621',16),('TMBP65NNAD4VK8716',17),('TMBLNVDACMPHD9213',18),('TMB4ZZXYWX45R9527',19),
('WDFB7X2GU9CZH7011',23),('WDDKSHNPGYC7U2873',24),('WDFMA4EJE4EZW3538',25),('WVWBCFBABAE3E0998',26),('WVW1H4NGLYVE46117',27),
('WV1T9EL6FURAC3993',28),('WBWL5VM7EBNLV2766',29);
INSERT INTO Mașină(serie_sasiu_m,cod_mm) VALUES ('WBSSG5FK5NML36318',30);

SELECT* FROM Mașină;

INSERT INTO Vizionare(data_si_ora_vizionarii,detalii_masina_v) VALUES ('2022-10-20 18:00:00','Dacia Duster 2015');
SELECT* FROM Vizionare;

INSERT INTO Vizionare(data_si_ora_vizionarii,detalii_masina_v) VALUES ('2022-10-30 14:00:00','Toyota Auris 2018'),
('2022-11-05 09:00:00','Peugeot 208 2020'),('2022-11-10 19:00:00','Skoda Octavia 2020'),
('2022-11-15 16:00:00','Audi A8 2020'),('2022-11-20 11:00:00','Mercedes-Benz GLC 2019'),
('2022-11-25 17:00:00','Skoda Fabia 2005');

INSERT  INTO Participant_vizionare(cod_a,cod_c,cod_v) VALUES (12,1,1);
SELECT* FROM Participant_vizionare;
INSERT  INTO Participant_vizionare(cod_a,cod_c,cod_v) VALUES (13,2,1),(14,7,2),(14,9,3),(16,9,1);
INSERT  INTO Participant_vizionare(cod_a,cod_c,cod_v) VALUES (17,10,1),(16,15,7),(15,9,6),(14,2,3),(13,20,2),(12,21,5);
INSERT  INTO Participant_vizionare(cod_a,cod_c,cod_v) VALUES (12,10,5);

INSERT INTO Review_client(comentariu_rc,stea_rc,data_rc,cod_c) VALUES ('Dezamagit!',1,'2022-10-20 18:37:23',1);
INSERT INTO Review_client(comentariu_rc,stea_rc,data_rc,cod_c) VALUES ('Deja s-a stricat!',1,'2021-11-20 14:37:23',10);
INSERT INTO Review_client(comentariu_rc,stea_rc,data_rc,cod_c) VALUES ('Nu recomand!',1,'2022-11-20 13:37:23',1),
('Sunt foarte multumita!',5,'2022-11-25 17:37:23',4);
SELECT* FROM Review_client;

INSERT INTO Vanzare_masina(pret,data_v,cod_m) VALUES (4500,'2022-11-20',30);
INSERT INTO Vanzare_masina(pret,data_v,cod_m) VALUES (9500,'2021-08-25',29),(7650,'2021-12-12',28),(3600,'2022-03-15',19);
SELECT* FROM Vanzare_masina;

INSERT INTO Acces_masina(cod_m,cod_a) VALUES (5,1),(6,3),(7,16),(8,13),(9,16),(10,12),(5,13),(6,19),(7,18),(8,3),(9,3),(10,1);
INSERT INTO Acces_masina(cod_m,cod_a) VALUES (5,19),(10,3);
SELECT* FROM Acces_masina;

/*1.numele clientilor care au dat review uri de 1 stea*/
SELECT DISTINCT C.nume_c FROM Client C 
INNER JOIN Review_client R on C.cod_c=R.cod_c 
WHERE R.stea_rc=1 ;

/*2.numele functiilor care au minim 2 angajati*/
SELECT F.nume_f, COUNT(cod_a) nr_angajati FROM Funcție F 
INNER JOIN Angajat A on F.cod_f=A.cod_f 
GROUP BY F.cod_f,F.nume_f HAVING COUNT(cod_a)>1; 

/*3.data si ora vizionarilor cu mai mult de 3 participanti(clienti+angajati distincti)*/
SELECT V.data_si_ora_vizionarii, COUNT(cod_c), COUNT(cod_a) FROM Vizionare V 
INNER JOIN Participant_vizionare P on V.cod_v=P.cod_v 
GROUP BY V.cod_v,V.data_si_ora_vizionarii
HAVING COUNT(cod_c)+COUNT(DISTINCT cod_a)>3 ;

/*4.seria de sasiu si modelul masinilor cu anul de fabricatie mai mare de 2018*/
SELECT M.serie_sasiu_m , MD.model_m  FROM Mașină M, Model MD 
WHERE MD.cod_mm=M.cod_mm AND MD.an_fabricatie_m>2018;

/*5.seria de sasiu si pretul masinilor vandute in anul curent*/
SELECT M.serie_sasiu_m,V.pret FROM Mașină M, Vanzare_masina V 
WHERE M.cod_m=V.cod_m AND V.data_v>'2022-01-01';

/*6.numele si functia angajatilor care au salariul de baza mai mare decat 3500lei*/
SELECT A.nume_a,F.nume_f FROM Angajat A, Funcție F 
WHERE A.cod_f=F.cod_f AND F.salariu_baza_f>3500; 

/*7.masinile la care au acces minim 3 angajati*/
SELECT M.serie_sasiu_m,COUNT(cod_a) nr_angajati FROM Mașină M, Acces_masina A 
WHERE M.cod_m=A.cod_m  
GROUP BY M.cod_m,M.serie_sasiu_m HAVING COUNT(cod_a)>2;

/*8.toate modelele de masina pentru care numele este Toyota*/
SELECT M.model_m  FROM Model M WHERE M.nume_m='Toyota';

/*9.afiseaza toti producatorii de la care avem masini*/
SELECT DISTINCT nume_m FROM Model;

/*10.afiseaza toate vizionarile disponibile dupa o data aleasa*/
SELECT data_si_ora_vizionarii,detalii_masina_v FROM Vizionare WHERE data_si_ora_vizionarii>GETDATE();

INSERT INTO Versiune(versiune) VALUES (1);
SELECT* FROM Versiune;