--Start of Restaurant
DROP TABLE IF EXISTS CONTENANT CASCADE;
DROP TABLE IF EXISTS RESTO CASCADE;
DROP TABLE IF EXISTS MENU CASCADE;
DROP TABLE IF EXISTS MENURESTO CASCADE;
DROP TABLE IF EXISTS BOISSON CASCADE;

--Q1
CREATE TABLE CONTENANT(
    Id_Contenant INTEGER PRIMARY KEY,
    Nom_Contenant VARCHAR(50)
);
--Q2
INSERT INTO CONTENANT(Id_Contenant, Nom_Contenant) VALUES (1, 'Bouteille');
INSERT INTO CONTENANT(Id_Contenant, Nom_Contenant) VALUES (2, 'Pichet');
INSERT INTO CONTENANT(Id_Contenant, Nom_Contenant) VALUES (3, 'Verre');

SELECT * FROM CONTENANT;

--Q3
CREATE TABLE RESTO(
    ID_Resto INTEGER PRIMARY KEY,
    NomResto VARCHAR(50) UNIQUE,
    Adresse VARCHAR(200),
    Telephone INTEGER,
    NomChef VARCHAR(50),
    NbEtoiles INTEGER DEFAULT 0
);
--Q4
CREATE TABLE MENU(
    ID_Menu INTEGER PRIMARY KEY,
    Entree VARCHAR(50) DEFAULT 'SALADE',
    Plat VARCHAR(50) DEFAULT 'PÂTES',
    Dessert VARCHAR(50) DEFAULT 'FLAMBY'
);
--Q5
CREATE TABLE MENURESTO(
    ID_Menu INTEGER,
    ID_Resto INTEGER,
    Prix NUMERIC(3,2),
    CONSTRAINT pk_menuresto PRIMARY KEY(ID_Menu, ID_Resto),
    CONSTRAINT fk_ID_Menu FOREIGN KEY(ID_Menu) REFERENCES MENU(ID_Menu),
    CONSTRAINT fk_ID_Resto FOREIGN KEY(ID_Resto) REFERENCES RESTO(ID_Resto)
);
--Q6
CREATE TABLE BOISSON(
    ID_Boisson INTEGER PRIMARY KEY,
    NomBoisson VARCHAR(50) UNIQUE NOT NULL,
    Temperature NUMERIC CHECK (Temperature > 0),
    DegreeAlcool NUMERIC
);
--Q7
DROP TABLE CONTENANT;

--Q8
ALTER TABLE MENU ADD COLUMN Cafe BOOLEAN DEFAULT FALSE;
SELECT * FROM MENU;
--Q9
ALTER TABLE RESTO ALTER COLUMN NbEtoiles DROP DEFAULT;
SELECT * FROM RESTO;
--Q10
ALTER TABLE RESTO DROP COLUMN NbEtoiles;
SELECT * FROM RESTO;
--Q11
ALTER TABLE RESTO MODIFY COLUMN NomResto VARCHAR(30);
SELECT * FROM RESTO;
--Q12
ALTER TABLE MENU ALTER COLUMN Cafe SET DEFAULT TRUE;
--End