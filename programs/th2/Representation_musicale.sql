CREATE DATABASE sturpin_repMus;

DROP TABLE IF EXISTS representation CASCADE;
DROP TABLE IF EXISTS musicien CASCADE;
DROP TABLE IF EXISTS programmer CASCADE;

CREATE TABLE representation(
numRepresentation INTEGER PRIMARY KEY,
titre_representation VARCHAR,
lieu VARCHAR);

CREATE TABLE musicien(
nom VARCHAR PRIMARY KEY,
numRepresentation INTEGER,
CONSTRAINT fk_numRepMus FOREIGN KEY (numRepresentation) REFERENCES representation(numRepresentation)
);

CREATE TABLE programmer(
date DATE,
numRepresentation INTEGER,
tarif FLOAT,
CONSTRAINT pk_prog PRIMARY KEY (date, numRepresentation),
CONSTRAINT fk_numRepProg FOREIGN KEY (numRepresentation) REFERENCES representation(numRepresentation)
);

INSERT INTO representation VALUES
(1, 'Carmen', 'opera Bastille'),
(2, 'Figaro', 'théâtre Marigny'),
(3, 'Le Lac des Cygnes', 'theatre Michel'),
(4, 'Carmen','theâtre Mogador'),
(5, 'Mme Butterfly', 'theatre Moliere'),
(6, 'Carmen', 'Opéra Garnier');

INSERT INTO musicien VALUES(
'Marvel Comics', 1),(
'Super Man', 5),(
'Spider Man', 2),(
'Herr Man', 3),(
'Bat Man', 4
);

INSERT INTO programmer VALUES(
'09-09-2012', 1, 15),(
'12-12-2012', 2, NULL),(
'04-04-2012', 3, 7.5),(
'06-06-2012', 4, 9.7),(
'07-07-2012', 5, 10),(
'08-08-2012', 5, 11.90),(
'01-06-2012', 5, 12.10),(
'10-10-2012', 3, 7.50);

SELECT DISTINCT titre_representation
FROM representation;

SELECT titre_representation
FROM representation
WHERE lieu = 'opera Bastille';

SELECT lieu
FROM representation
WHERE lieu LIKE 'O%' OR lieu LIKE 'o%';

SELECT nom, titre_representation
FROM representation AS R, musicien AS M
WHERE R.numRepresentation=M.numRepresentation;

SELECT R.titre_representation, R.lieu, P.tarif
FROM representation AS R, programmer AS P
WHERE R.numRepresentation=P.numRepresentation AND date = '14-09-2012';

SELECT DISTINCT M.nom
FROM representation AS R, musicien AS M
WHERE R.numRepresentation=M.numRepresentation AND titre_representation = 'Carmen';

SELECT R.numRepresentation, R.titre_representation, R.lieu
FROM representation AS R, programmer AS P
WHERE R.numRepresentation=P.numRepresentation AND P.tarif < 15;

SELECT R.titre_representation
FROM representation AS R, programmer AS P
WHERE R.numRepresentation=P.numRepresentation AND date BETWEEN '01-04-2012' AND '30-04-2012';

SELECT P.date, R.numRepresentation
FROM representation AS R, programmer AS P
WHERE R.numRepresentation=P.numRepresentation AND P.tarif IS NULL;

SELECT DISTINCT M.nom, R.lieu
FROM representation AS R, musicien AS M
WHERE R.numRepresentation=M.numRepresentation AND 
R.lieu IN ('théâtre Marigny', 'théâtre Michel', 'théâtre Mogador', 'théâtre Molière');

--Partie 2 

SELECT COUNT(numRepresentation) AS NbrRepresentation
FROM representation;

SELECT COUNT(numRepresentation) AS NbrDateProgrm
FROM programmer
WHERE date IS NOT NULL;

SELECT DISTINCT nom
FROM representation AS R, musicien AS M
WHERE R.numRepresentation=M.numRepresentation AND lieu = 'Basilique St Sernin'
ORDER BY nom ASC;

SELECT AVG(P.tarif) AS PrixMoyenReprs
FROM representation AS R, programmer AS P
WHERE R.numRepresentation=P.numRepresentation;

SELECT numRepresentation, COUNT(numRepresentation) AS decroissant
FROM programmer
WHERE date IS NOT NULL
GROUP BY numRepresentation
ORDER BY numRepresentation DESC;

SELECT MAX(tarif) AS PrixMax
FROM programmer;

SELECT R.numRepresentation, titre_representation, COUNT(nom) AS NbrMusicien
FROM representation  AS R, musicien AS M
WHERE R.numRepresentation=M.numRepresentation
GROUP BY R.numRepresentation, titre_representation
ORDER BY numRepresentation ASC;

SELECT P.date, P.tarif
FROM programmer AS P
WHERE P.date IS NOT NULL
GROUP BY P.date, P.tarif
HAVING P.tarif <= 30.00
ORDER BY P.tarif, P.date ASC;