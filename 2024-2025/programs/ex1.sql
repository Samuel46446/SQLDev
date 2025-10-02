--Start
CREATE TABLE Soldat(
    Matricule CHAR(20) PRIMARY KEY,
    Nom CHAR(30),
    Prenom CHAR(40)
);

CREATE TABLE NivDifficulte(
    CodeNiv CHAR(5) PRIMARY KEY,
    LibelleNiv CHAR(20),
    Bonus NUMERIC
);

CREATE TABLE Participation(
    Nparticipation NUMERIC PRIMARY KEY,
    Matricule CHAR(20),
    Date DATE, 
    CONSTRAINT fk_matricule FOREIGN KEY(Matricule) REFERENCES Soldat(Matricule)
);

CREATE TABLE Obstacle(
    NomObstacle CHAR(30) PRIMARY KEY,
    CodeNiv CHAR(5),
    NoteMini NUMERIC, 
    CONSTRAINT fk_codeniv FOREIGN KEY(CodeNiv) REFERENCES NivDifficulte(CodeNiv)
);

CREATE TABLE Passer(
    NomObstacle CHAR(30),
    Nparticipation NUMERIC,
    NoteInstructeur NUMERIC, 
    Temps DATE, 
    CONSTRAINT pk_passer PRIMARY KEY(NomObstacle, Nparticipation),
    CONSTRAINT fk_nomObstacle FOREIGN KEY(NomObstacle) REFERENCES Obstacle(NomObstacle),
    CONSTRAINT fk_Nparticipation FOREIGN KEY(Nparticipation) REFERENCES Participation(Nparticipation)
);
--End