CREATE TABLE typeembarcation(
codeType VARCHAR(2) PRIMARY KEY,
nomType VARCHAR(20),
nbPlace INTEGER,
prix_demi_heure NUMERIC (10,2),
prix_heure NUMERIC (10,2),
prix_demi_journee NUMERIC (10,2),
prix_journee NUMERIC (10,2));


insert into typeembarcation ("B1","barque",2,15.00,25.00,80.00,150.00)
insert into typeembarcation ("B2","barque",4,30.00,50.00,140.00,200.00)
insert into typeembarcation ("J1","jet-ski",1,80.00,150.00,300.00,500.00)
insert into typeembarcation ("J2","jet-ski",2,120.00,250.00,400.00,700.00)
insert into typeembarcation ("M1","bateau a moteur",4,100.00,200.00,400.00,800.00)
insert into typeembarcation ("P1","pedalo simple",2,30.00,55.00,150.00,250.00)
insert into typeembarcation ("P2","pedalo double",4,40.00,75.00,170.00,280.00)
insert into typeembarcation ("P3","pedalo toboggan",6,45.00,80.00,180.00,300.00)


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


insert into location VALUES (1,'29/08/2024','10:00:00','10:30:00');
insert into location VALUES (2,'29/08/2024','10:05:00','10:35:00');
insert into location VALUES (3,'29/08/2024','10:02:00','11:02:00');
insert into location VALUES (4,'30/08/2024','10:30:00','18:00:00');
insert into location VALUES (5,'30/08/2024','10:45:00','11:15:00');
insert into location VALUES (6,'31/08/2024','11:30:00','12:30:00');
insert into location VALUES (7,'31/08/2024','11:45:00','12:15:00');
insert into location VALUES (8,'01/09/2024','13:30:00','14:00:00');
insert into location VALUES (9,'01/09/2024','13:32:00','14:02:00');
insert into location VALUES (10,'01/09/2024','13:40:00','14:40:00');
insert into location VALUES (11,'01/09/2024','13:45:00','14:00:00');
insert into location VALUES (12,'01/09/2024','13:47:00','18:00:00');



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





