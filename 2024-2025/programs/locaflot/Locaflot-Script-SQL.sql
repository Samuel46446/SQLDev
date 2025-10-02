CREATE TABLE typeembarcation(
codeType VARCHAR(2) PRIMARY KEY,
nomType VARCHAR(20),
nbPlace INTEGER,
prix_demi_heure NUMERIC (10,2),
prix_heure NUMERIC (10,2),
prix_demi_journee NUMERIC (10,2),
prix_journee NUMERIC (10,2));


insert into typeembarcation VALUES ('B1','barque',2,15.00,25.00,80.00,150.00);
insert into typeembarcation VALUES ('B2','barque',4,30.00,50.00,140.00,200.00);
insert into typeembarcation VALUES ('J1','jet-ski',1,80.00,150.00,300.00,500.00);
insert into typeembarcation VALUES ('J2','jet-ski',2,120.00,250.00,400.00,700.00);
insert into typeembarcation VALUES ('M1','bateau a moteur',4,100.00,200.00,400.00,800.00);
insert into typeembarcation VALUES ('P1','pedalo simple',2,30.00,55.00,150.00,250.00);
insert into typeembarcation VALUES ('P2','pedalo double',4,40.00,75.00,170.00,280.00);
insert into typeembarcation VALUES ('P3','pedalo toboggan',6,45.00,80.00,180.00,300.00);


CREATE TABLE embarcation (
numEmbarcation VARCHAR(4) PRIMARY KEY,
couleur VARCHAR(15),
disponible BOOLEAN,
codeType VARCHAR(2) REFERENCES typeembarcation(codeType));


insert into embarcation values ('B101','vert','T','B1');
insert into embarcation values ('B102','blanc','T','B1');
insert into embarcation values ('B103','jaune','F','B1');
insert into embarcation values ('B201','blanc','F','B2');
insert into embarcation values ('B202','rouge','T','B2');
insert into embarcation values ('J101','multicolore','T','J1');
insert into embarcation values ('J102','blanc','F','J1');
insert into embarcation values ('J103','blanc','T','J1');
insert into embarcation values ('J201','jaune','F','J2');
insert into embarcation values ('J202','blanc','T','J2');
insert into embarcation values ('M101','jaune','T','M1');
insert into embarcation values ('M102','blanc','F','M1');
insert into embarcation values ('M103','blanc','F','M1');
insert into embarcation values ('P101','blanc','T','P1');
insert into embarcation values ('P102','blanc','T','P1');
insert into embarcation values ('P103','jaune','F','P1');
insert into embarcation values ('P104','bleu','T','P1');
insert into embarcation values ('P105','rouge','F','P1');
insert into embarcation values ('P106','blanc','T','P1');
insert into embarcation values ('P107','bleu','T','P1');
insert into embarcation values ('P108','jaune','F','P1');
insert into embarcation values ('P109','rouge','T','P1');
insert into embarcation values ('P110','jaune','T','P1');
insert into embarcation values ('P201','rouge','F','P2');
insert into embarcation values ('P202','jaune','T','P2');
insert into embarcation values ('P203','blanc','F','P2');
insert into embarcation values ('P204','blanc','T','P2');
insert into embarcation values ('P205','bleu','T','P2');
insert into embarcation values ('P206','violet','F','P2');
insert into embarcation values ('P207','blanc','T','P2');
insert into embarcation values ('P208','jaune','T','P2');
insert into embarcation values ('P301','blanc','F','P3');
insert into embarcation values ('P302','rouge','T','P3');
insert into embarcation values ('P303','rouge','F','P3');
insert into embarcation values ('P304','jaune','T','P3');
insert into embarcation values ('P305','bleu','T','P3');
insert into embarcation values ('P306','bleu','F','P3');
insert into embarcation values ('P307','bleu','F','P3');


CREATE TABLE location(
numLocation SERIAL PRIMARY KEY,
_date DATE,
heuredebut TIME,
heurefin TIME
);


insert into location VALUES (1,'29-08-2024','10:00:00','10:30:00');
insert into location VALUES (2,'29-08-2024','10:05:00','10:35:00');
insert into location VALUES (3,'29-08-2024','10:02:00','11:02:00');
insert into location VALUES (4,'30-08-2024','10:30:00','18:00:00');
insert into location VALUES (5,'30-08-2024','10:45:00','11:15:00');
insert into location VALUES (6,'31-08-2024','11:30:00','12:30:00');
insert into location VALUES (7,'31-08-2024','11:45:00','12:15:00');
insert into location VALUES (8,'01-09-2024','13:30:00','14:00:00');
insert into location VALUES (9,'01-09-2024','13:32:00','14:02:00');
insert into location VALUES (10,'01-09-2024','13:40:00','14:40:00');
insert into location VALUES (11,'01-09-2024','13:45:00','14:00:00');
insert into location VALUES (12,'01-09-2024','13:47:00','18:00:00');



CREATE TABLE louer (
numLocation INTEGER REFERENCES location(numLocation),
numEmbarcation VARCHAR(4) REFERENCES embarcation(numEmbarcation),
nbPersonnes INTEGER,
CONSTRAINT pk_louer PRIMARY KEY (numEmbarcation,numLocation)
);


INSERT INTO louer VALUES
(1,'J101',4),(1,'B202',1),(1,'P110',4),(2,'B102',5),(3,'P205',2),(3,'P304',1),(4,'P109',4),(5,'B101',2),
(6,'J101',4),(6,'B202',1),(7,'P110',4),(8,'B102',5),(8,'P205',2),(9,'P304',1),(10,'P109',4),(10,'B101',2),
(10,'P106',1),(11,'P204',4),(12,'P302',2);

/*
    1) Non une location ne peut contenir qu'une seule embarquation
    2) Non
    3) Oui
    4) Oui
    5) disponible sous forme (bool/boolean)
*/

--Nbr de couleur blanche
SELECT Count(*) AS MaxiWhite
FROM embarcation
WHERE couleur = 'blanc';
--maxiwhite
-----------
--       14

--Le nombre d'embarcations de couleur jaune
SELECT Count(*) AS MaxiYellow
FROM embarcation
WHERE couleur = 'jaune';
--maxiyellow
------------
--        9

--Le nombre total d'embarcations
SELECT Count(*) AS MaxiMax
FROM embarcation;
--maximax
---------
--    38

--Le nombre de pédalos toboggans disponibles
--pédalos toboggans=P3
SELECT Count(*) AS MaxiToboggandPedalos
FROM embarcation
WHERE codetype='P3';
--maxitoboggandpedalos
----------------------
--                  7

--Pour le dernier c'est le nombre d'embarcation qui ont un nombre de place supérieur à 2.
SELECT count(numembarcation)
FROM typembarcation, embarcation 
WHERE typenbarcation.codetype = embarcation.codetype AND nbplace > 2 ;

--Type d'embarcation
SELECT codetype, COUNT(numEmbarcation) AS NbrMax
FROM embarcation
GROUP BY codetype;

--codetype | nbrmax
-----------+--------
--M1       |      3
--P2       |      8
--P1       |     10
--B1       |      3
--J2       |      2
--B2       |      2
--J1       |      3
--P3       |      7
--(8 lignes)

--Nbr d'embarcation par couleur
SELECT couleur, count(numembarcation)
FROM embarcation
GROUP BY couleur;
-- couleur    | count
--------------+-------
--blanc       |    14
--jaune       |     9
--bleu        |     6
--rouge       |     6
--multicolore |     1
--violet      |     1
--vert        |     1
--(7 lignes)

SELECT T.nomtype, count(E.numembarcation)
FROM embarcation AS E, typeembarcation AS T
Where E.codetype = T.codetype
GROUP BY T.nomtype;
--      nomtype     | count
-- -----------------+-------
--  bateau a moteur |     3
--  jet-ski         |     5
--  pedalo toboggan |     7
--  pedalo simple   |    10
--  pedalo double   |     8
--  barque          |     5
-- (6 lignes)

SELECT _date, count(numembarcation)
FROM louer, location
Where louer.numlocation = location.numlocation
GROUP BY _date;
--    _date    | count
-- ------------+-------
--  2024-08-31 |     3
--  2024-08-30 |     2
--  2024-08-29 |     6
--  2024-09-01 |     8
-- (4 lignes)

SELECT LOUER.numlocation, _date, count(numembarcation)
FROM LOUER, LOCATION
WHERE LOUER.numlocation = LOCATION.numlocation
GROUP BY LOUER.numlocation, _date;
--  numlocation |   _date    | count
-- -------------+------------+-------
--            1 | 2024-08-29 |     3
--            4 | 2024-08-30 |     1
--           12 | 2024-09-01 |     1
--            7 | 2024-08-31 |     1
--            8 | 2024-09-01 |     2
--            9 | 2024-09-01 |     1
--           10 | 2024-09-01 |     3
--            5 | 2024-08-30 |     1
--           11 | 2024-09-01 |     1
--            2 | 2024-08-29 |     1
--            6 | 2024-08-31 |     2
--            3 | 2024-08-29 |     2
-- (12 lignes)

--Le nombre d'embarcations disponibles dont le tarif horaire est inférieur à 100 €.
SELECT count(E.numembarcation) AS PrixInf100
FROM embarcation AS E, typeembarcation AS T
Where E.codetype = T.codetype AND prix_heure < 100;
--  prixinf100
-- ------------
--          30
-- (1 ligne)

SELECT _date, count(LOCATION.numlocation) as LocationParJour
FROM LOUER, LOCATION
WHERE LOUER.numlocation = LOCATION.numlocation
GROUP BY _date;
--    _date    | locationparjour
-- ------------+-----------------
--  2024-08-31 |               3
--  2024-08-30 |               2
--  2024-08-29 |               6
--  2024-09-01 |               8
-- (4 lignes)

SELECT T.nomtype, count(E.numembarcation) as NbrJetSki
FROM embarcation AS E, typeembarcation AS T
Where E.codetype = T.codetype AND T.nomtype='jet-ski'
GROUP BY T.nomtype;
--  nbrjetski | count
-- ---------+-------
--  jet-ski |     5
-- (1 ligne)

SELECT T.nomtype, T.prix_demi_heure, count(E.numembarcation) as Nbr2Place
FROM embarcation AS E, typeembarcation AS T
Where E.codetype = T.codetype AND T.nbplace=2
GROUP BY T.nomtype, T.prix_demi_heure;
--     nomtype    | prix_demi_heure | nbr2place
-- ---------------+-----------------+-----------
--  barque        |           15.00 |         3
--  jet-ski       |          120.00 |         2
--  pedalo simple |           30.00 |        10
-- (3 lignes)


SELECT T.nomtype, count(E.numembarcation) as NbrEmbarcation
FROM embarcation AS E, typeembarcation AS T
Where E.codetype = T.codetype
GROUP BY T.nomtype
ORDER BY T.nomtype ASC;
--      nomtype     | nbrembarcation
-- -----------------+----------------
--  barque          |              5
--  bateau a moteur |              3
--  jet-ski         |              5
--  pedalo double   |              8
--  pedalo simple   |             10
--  pedalo toboggan |              7
-- (6 lignes)

