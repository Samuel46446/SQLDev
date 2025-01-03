CREATE DATABASE sturpin_loueauto;

DROP TABLE IF EXISTS vehicule CASCADE;
DROP TABLE IF EXISTS client CASCADE;
DROP TABLE IF EXISTS lalocation CASCADE;

CREATE TABLE vehicule(
    immatriculation VARCHAR(10),
    modele VARCHAR(20),
    marque VARCHAR(20),
    etat TEXT,
    km INTEGER,
    CONSTRAINT pk_vehicule PRIMARY KEY(immatriculation)
);

CREATE TABLE client(
    reference INTEGER,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    adresseRue VARCHAR(200),
    adresseVille VARCHAR(50),
    adresseCodePostal INTEGER,
    CONSTRAINT pk_client PRIMARY KEY(reference)
);

CREATE TABLE lalocation(
    numero INTEGER,
    immatriculationVehicule VARCHAR(10),
    jour DATE,
    kmDebut INTEGER,
    kmFin INTEGER,
    commentaires TEXT,
    referenceClient INTEGER,
    nbJours INTEGER,
    CONSTRAINT pk_location PRIMARY KEY(numero),
    CONSTRAINT fk_Vimmatriculation FOREIGN KEY(immatriculationVehicule) REFERENCES vehicule(immatriculation),
    CONSTRAINT fk_Cref FOREIGN KEY(referenceClient) REFERENCES client(reference)
);

INSERT INTO vehicule(immatriculation, modele, marque, etat, km)
VALUES('123ASZ93', 'clio', 'Renault', 'rayure porte arrière gauche', 10235);
INSERT INTO vehicule(immatriculation, modele, marque, etat, km) 
VALUES('4561FR93', 'clio', 'Renault', '', 9654);
INSERT INTO vehicule(immatriculation, modele, marque, etat, km) 
VALUES('7895EZ93', 'AX', 'Citroen', 'pare-choc avant droit ; porte avant gauche', 4789);


INSERT INTO client(reference, nom, prenom, adresseRue, adresseVille, adresseCodePostal) 
VALUES(2, 'Bounard', 'Hamed', '23, rue des petits', 'Aulnay', 93600);
INSERT INTO client(reference, nom, prenom, adresseRue, adresseVille, adresseCodePostal) 
VALUES(3, 'Baltazard', 'Farid', '56, rue Arnaud', 'Montreuil', 93100);
INSERT INTO client(reference, nom, prenom, adresseRue, adresseVille, adresseCodePostal) 
VALUES(4, 'Fermi', 'Jean', '1, rue de Paris', 'Romainville', 93230);
INSERT INTO client(reference, nom, prenom, adresseRue, adresseVille, adresseCodePostal) 
VALUES(5, 'Valmont', 'Yann', '23, rue des Merlins', 'Montreuil', 93100);
INSERT INTO client(reference, nom, prenom, adresseRue, adresseVille, adresseCodePostal) 
VALUES(6, 'Rouault', 'Martine', '18, rue des Perles', 'Aulnay', 93600);
INSERT INTO client(reference, nom, prenom, adresseRue, adresseVille, adresseCodePostal) 
VALUES(11, 'Raqui', 'Sophie', '89, rue Ménard', 'Aulnay', 93600);

INSERT INTO lalocation(numero, immatriculationVehicule, jour, kmDebut, kmFin, commentaires, referenceClient, nbJours) 
VALUES(21, '123ASZ93', '01-08-09', 9425, 9512, 'ras', 2, 1);
INSERT INTO lalocation(numero, immatriculationVehicule, jour, kmDebut, kmFin, commentaires, referenceClient, nbJours) 
VALUES(22, '4561FR93', '02-08-09', 8521, 8645, 'ras', 11, 1);
INSERT INTO lalocation(numero, immatriculationVehicule, jour, kmDebut, kmFin, commentaires, referenceClient, nbJours) 
VALUES(24, '4561FR93', '04-08-09', 9645, 9021, 'ras', 5, 2);
INSERT INTO lalocation(numero, immatriculationVehicule, jour, kmDebut, kmFin, commentaires, referenceClient, nbJours) 
VALUES(42, '123ASZ93', '02-08-09', 9512, 9628, 'rayure porte arrière gauche', 5, 1);
INSERT INTO lalocation(numero, immatriculationVehicule, jour, kmDebut, kmFin, commentaires, referenceClient, nbJours) 
VALUES(43, '123ASZ93', '04-08-09', 9628, 10235, 'ras', 4, 2);

SELECT marque
FROM vehicule AS V, lalocation AS L
WHERE L.immatriculationVehicule = V.immatriculation AND L.numero = 24;

SELECT C.nom
FROM client AS C, lalocation AS L
WHERE C.reference=L.referenceClient AND L.numero = 24;
--Renault
--Valmont

--KmDebut et Fin servent à savoir à qui il ne faut plus préter de véhicule (qui doit rester piéton)
--Dans la table véhicule la colonne km doit servir pour de l'entretiens
--La valeur km dans la table Vehicule récupére la valeur kmFin en fonction l'immatriculation

SELECT C.nom, C.adresseVille
FROM client AS C, lalocation AS L
WHERE C.reference=L.referenceClient AND L.jour='15-08-09';

SELECT DISTINCT modele
FROM vehicule AS V, lalocation AS L
WHERE L.immatriculationVehicule = V.immatriculation AND L.nbJours >= 2;

SELECT C.nom
FROM client AS C, lalocation AS L
WHERE C.reference=L.referenceClient AND (kmFin-KmDebut) >= 300;