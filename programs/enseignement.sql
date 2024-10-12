-- Exercice : Cas Enseignement
CREATE DATABASE sturpin_enseignement;

DROP TABLE IF EXISTS ETUDIANT CASCADE;
DROP TABLE IF EXISTS ENSEIGNANT CASCADE;
DROP TABLE IF EXISTS COURS CASCADE;
DROP TABLE IF EXISTS INSCRIT CASCADE;

--Tables de base
CREATE TABLE ETUDIANT(
    NumE INTEGER PRIMARY KEY,
    NomE VARCHAR(50),
    AgeE INTEGER
);

CREATE TABLE ENSEIGNANT(
    NumEn INTEGER PRIMARY KEY,
    NomEn VARCHAR(50),
    NumDept INTEGER
);

CREATE TABLE COURS(
    NomC VARCHAR(50) PRIMARY KEY,
    HoraireC TIME,
    SalleCapacite INTEGER,
    NumEn INTEGER,
    CONSTRAINT fk_NumEn FOREIGN KEY(NumEn) REFERENCES ENSEIGNANT(NumEn)
);

CREATE TABLE INSCRIT(
    NumE INTEGER,
    NomC VARCHAR(50),
    CONSTRAINT pk_inscrit PRIMARY KEY(NumE, NomC),
    CONSTRAINT fk_NumE FOREIGN KEY(NumE) REFERENCES ETUDIANT(NumE),
    CONSTRAINT fk_NomC FOREIGN KEY(NomC) REFERENCES COURS(NomC)
);

--Ajout d'une contrainte pour que la capacité d'une salle soit supérieur à 0
ALTER TABLE COURS ADD CONSTRAINT checkSupZero CHECK (SalleCapacite > 0);

--Ajout d'une valeur par default pour l'âge d'un etudiant
ALTER TABLE ETUDIANT ALTER COLUMN AgeE SET DEFAULT 18;

--Supression de la contrainte précédément créer
ALTER TABLE COURS DROP CONSTRAINT checkSupZero;

--Insertion du professeur et du cours
INSERT INTO ENSEIGNANT(NumEn, NomEn, NumDept) VALUES(1, 'Mme Campos', 75);
INSERT INTO COURS(NomC, HoraireC, SalleCapacite, NumEn) VALUES('SQL', '11:00:00', 305, 1);

--Insertion d'un nouveau professeur et modification de l'ancien cours
INSERT INTO ENSEIGNANT(NumEn, NomEn, NumDept) VALUES(2, 'Mme Jimenez', 75);
UPDATE COURS SET NumEn = 2, SalleCapacite = 402
WHERE NomC = 'SQL' AND NumEn = 1;

--Insertion d'un etudiant qui et ensuite supprimer
INSERT INTO ETUDIANT(NumE, NomE, AgeE) VALUES(123, 'Jean', 18);
DELETE FROM ETUDIANT WHERE NumE = 123;

--Changement pour que tous les cours commençent à 8h00
UPDATE COURS SET HoraireC = '8:00:00';

--Insertion d'étudiant différents
INSERT INTO ETUDIANT(NumE, NomE, AgeE) VALUES(1, 'Jack', 100);
INSERT INTO ETUDIANT(NumE, NomE, AgeE) VALUES(2, 'Jule', 9);
INSERT INTO ETUDIANT(NumE, NomE, AgeE) VALUES(3, 'Marc', 19);

--Suppression des étudiants teste pour voir ce qu'il reste
DELETE FROM ETUDIANT WHERE AgeE < 13 OR AgeE > 99;

--Insertion d'un prof qu'on connait pas encore
INSERT INTO ENSEIGNANT(NumEn, NomEn, NumDept) VALUES(3, 'Unknow AMSI Professor', 75);

--Insertion du cours avec ce même prof inconnu
INSERT INTO COURS(NomC, HoraireC, SalleCapacite, NumEn) VALUES('AMSI', '12:00:00', 208, 3);