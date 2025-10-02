DROP TABLE IF EXISTS QUESTION CASCADE;
DROP TABLE IF EXISTS ENQUETE CASCADE;
DROP TABLE IF EXISTS REPONSE CASCADE;

CREATE TABLE QUESTION(
	num INTEGER PRIMARY KEY,
	libelle VARCHAR(50),
	numQuestionnaire INTEGER, foreign key(numQuestionnaire) references questionnaire(num)
);

CREATE TABLE ENQUETE(
	num INTEGER PRIMARY KEY,
	nom VARCHAR(50),
	numEchantillon INTEGER, foreign key(numEchantillon) references echantillon(num),
	matenqueteur INTEGER, foreign key(matenqueteur) references enqueteur(matricule)
);

CREATE TABLE REPONSE(
	numQuestion INTEGER,
	numPeriode INTEGER,
	numEnquete INTEGER,
	reponse BOOLEAN,
	CONSTRAINT pk_rep PRIMARY KEY(numQuestion, numPeriode, numEnquete),
    CONSTRAINT fk_q FOREIGN KEY(numQuestion) REFERENCES QUESTION(num),
    CONSTRAINT fk_p FOREIGN KEY(numPeriode) REFERENCES periode(num),
    CONSTRAINT fk_e FOREIGN KEY(numEnquete) REFERENCES ENQUETE(num)
);

-- Table Question
INSERT INTO Question (num, libelle, numquestionnaire) VALUES
(1, 'Antoine', 1),
(2, 'Ariane', 1),
(3, 'Albert', 1);

-- Table Enquêté
INSERT INTO Enquete (num, nom, numechantillon, matenqueteur) VALUES
(1, 'Albert', 1, 1),
(2, 'Bruno', 1, 1),
(3, 'Corinne', 2, 1),
(4, 'Denis', 2, 1);

-- Table Réponse
INSERT INTO Reponse (numquestion, numperiode, numenquete, reponse) VALUES
(1, 1, 1, TRUE),
(1, 2, 1, TRUE),
(2, 1, 1, FALSE),
(3, 1, 1, FALSE),
(2, 1, 4, TRUE);
