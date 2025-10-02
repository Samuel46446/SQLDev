CREATE DATABASE sturpin_notes;

DROP TABLE IF EXISTS epreuve CASCADE;
DROP TABLE IF EXISTS academie CASCADE;
DROP TABLE IF EXISTS etablissement CASCADE;
DROP TABLE IF EXISTS candidat CASCADE;
DROP TABLE IF EXISTS notation CASCADE;

CREATE TABLE epreuve(
codeepreuve SERIAL PRIMARY KEY, 
designepreuve VARCHAR(30), 
coef NUMERIC(2,1));

CREATE TABLE academie(
codeAc SERIAL PRIMARY KEY, 
libelleAc VARCHAR(20)
);

CREATE TABLE etablissement (
codeetab SERIAL PRIMARY KEY, 
nomEtab VARCHAR(30), 
codeAc INTEGER REFERENCES academie(codeAc)
);

CREATE TABLE candidat(
numCandidat SERIAL PRIMARY KEY,
nomCandidat VARCHAR(30), 
codeetab INTEGER REFERENCES etablissement(codeetab)
);

CREATE TABLE notation(
codeepreuve INTEGER REFERENCES epreuve(codeepreuve),
numCandidat INTEGER REFERENCES candidat(numCandidat),
note NUMERIC(4,2),
CONSTRAINT pk_notation PRIMARY KEY (codeepreuve,numCandidat)
);

INSERT INTO epreuve(designepreuve,coef) VALUES 
('Merise',2.5),('PHP',1),('SQL',3),('Javascript',1),('Anglais',0.5),('UML',2),('Java',1);

INSERT INTO academie(libelleAc) VALUES
('Bordeaux'),('Nantes'),('Poitiers'),('Toulouse'),('Marseille'),('Paris');

INSERT INTO etablissement(nomEtab,codeAc) VALUES 
('St Jory',4),('Charles De Gaulle',6),('St Lazarre',1),('St Jacques',2),('St Pierre',2),('Gustave Eiffel',1),
('Pierre Semard',3),('LaGorce',5);

INSERT INTO candidat(nomCandidat,codeetab) VALUES
('Jean Dupont',1),('Jean Pierre',1),('Lucie Holch',1),('Karim Lafdal',2),('Fabien Delhaye',2),('Romain Jacques',2),
('Frederic Rau',3),('Rose Marie',3),('Pierre Mignon',4),('Karl Much',5),('Emile Torch',5),('Louis Gan',6),('Romain Duc',6),
('Sylvain Bouy',7),('Michel Jean',8),('Georgette Luce',8);

INSERT INTO notation(codeepreuve,numCandidat,note) VALUES
(1,1,12),(1,3,14),(2,2,16),(2,5,7),(2,3,18),(2,8,10),(3,10,18),(5,4,12),(6,8,14),(6,2,15),(5,9,12),(2,9,14),(7,8,16),(1,10,15);

--Réponses

ALTER TABLE candidat ADD COLUMN prenomCandidat VARCHAR(30) DEFAULT 'None';

SELECT DISTINCT C.numCandidat
FROM candidat AS C, notation AS N
WHERE C.numCandidat=N.numCandidat;

SELECT C.nomCandidat
FROM candidat AS C, etablissement AS E
WHERE C.codeetab=E.codeetab AND C.codeetab=230 AND C.nomCandidat LIKE 'c%';

SELECT DISTINCT C.numCandidat
FROM candidat AS C, notation AS N
WHERE C.numCandidat=N.numCandidat AND codeepreuve=6 AND note BETWEEN 8 AND 14;

SELECT C.numCandidat, C.nomCandidat
FROM candidat AS C
WHERE C.codeetab IN (203, 206, 230, 235, 289);

UPDATE TABLE notation SET note = note + 1 WHERE codeepreuve=6;

SELECT C.nomCandidat, N.note
FROM candidat AS C, notation AS N, epreuve AS E
WHERE C.numCandidat=N.numCandidat AND N.codeepreuve=E.codeepreuve AND N.codeepreuve=6;

SELECT C.nomCandidat, E.nomEtab
FROM candidat AS C, etablissement AS E, notation AS N
WHERE C.codeetab=E.codeetab AND C.numCandidat=N.numCandidat AND note IS NOT NULL;

SELECT C.numCandidat, N.codeepreuve, N.note, E.coef, N.note*E.coef AS Moy
FROM candidat AS C, notation AS N, epreuve AS E
WHERE C.numCandidat=N.numCandidat AND N.codeepreuve=E.codeepreuve;

DELETE FROM candidat WHERE codeetab IS NULL;

--Partie 2

SELECT numCandidat, note
FROM notation
WHERE codeepreuve = 6
GROUP BY numCandidat, note
ORDER BY note DESC;

SELECT N.numCandidat, N.codeepreuve, N.note, E.coef, N.note*E.coef AS NoteCoeff
FROM notation AS N, epreuve AS E
WHERE N.codeepreuve=E.codeepreuve;

SELECT N.codeepreuve, COUNT(N.note) AS TotNotes
FROM notation AS N, epreuve AS E
WHERE N.codeepreuve=E.codeepreuve
GROUP BY N.codeepreuve;

SELECT E.nomEtab, COUNT(C.numCandidat)
FROM etablissement AS E, candidat AS C
WHERE E.codeetab=C.codeetab
GROUP BY E.nomEtab;

SELECT N.codeepreuve, AVG(N.note) AS MoydeNote, MIN(N.note) AS MindeNote, MAX(N.note) AS MaxdeNote
FROM notation AS N
GROUP BY N.codeepreuve;

SELECT C.numCandidat, SUM(N.note) / COUNT(N.note) AS Moy
FROM candidat AS C, etablissement AS E, notation AS N
WHERE C.codeetab=E.codeetab AND C.numCandidat=N.numCandidat AND codeepreuve = 6
GROUP BY C.numCandidat
HAVING SUM(N.note) / COUNT(N.note) >= 10
ORDER BY 2 DESC;