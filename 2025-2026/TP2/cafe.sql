create table conso (
 numcons integer primary key,
 libcons varchar(50),
 prixcons float);

create table serveur (
 numserv    integer primary key,
 nomserv    VARCHAR(50),
 rueserv    VARCHAR(50),
 cpserv     integer,
 villeserv  VARCHAR(30),
 datenaiss  date );

create table tables(
 numtable   integer primary key,
 nomtable   VARCHAR(50),
 nbplaces   integer);

create table facture(
 numfact    integer primary key,
 numtable   integer,
 numserv    integer,
 datefact   date,
constraint fk1_facture  foreign key (numserv) references serveur(numserv),
constraint fk2_facture foreign key (numtable) references tables(numtable)
);

create table ligne_fact(
 numfact  integer ,
 numcons  integer,
 qte	    integer,
constraint pk_ligne_fact primary key (numfact, numcons),
CONSTRAINT fk1_ligne_fact FOREIGN KEY (numfact) REFERENCES facture(numfact),
CONSTRAINT fk2_ligne_fact FOREIGN KEY (numcons) REFERENCES conso(numcons)
 );


INSERT INTO CONSO VALUES(100,'Café',1.1);
                              
INSERT INTO CONSO VALUES(102,'Café crème',2);                              
INSERT INTO CONSO VALUES(105,'Chocolat',3.5);
INSERT INTO CONSO VALUES(106,'Bière pression',2.8);
INSERT INTO CONSO VALUES(107,'Bière 25cl',3.2); 
INSERT INTO CONSO VALUES(108,'Bière 33cl',4.1); 
INSERT INTO CONSO VALUES(110,'Bière 50cl',6);
INSERT INTO CONSO VALUES(120,'Jus de fruits',2.1);
INSERT INTO CONSO VALUES(121,'Jus de fruit pressé',3.5);
INSERT INTO CONSO VALUES(122,'Perrier',2.5);
INSERT INTO CONSO VALUES(124,'Orangina',2.8); 
INSERT INTO CONSO VALUES(130,'Coca Cola',2.8);                                  
INSERT INTO CONSO VALUES(101,'Café double',2);
INSERT INTO TABLES VALUES(1,'entree-gche',6);                              
INSERT INTO TABLES VALUES(2,'entree-dte',10);                              
INSERT INTO TABLES VALUES(3,'fenetre1',3); 
INSERT INTO TABLES VALUES(4,'fenetre2',8); 
INSERT INTO TABLES VALUES(5,'fenetre3',4); 
INSERT INTO TABLES VALUES(6,'fond-gche',4);
INSERT INTO TABLES VALUES(7,'fond-drt',2); 

INSERT INTO SERVEUR VALUES(50,'Pizzi','3, rue des lilas',90000,'BELFORT','10/12/76');
INSERT INTO SERVEUR VALUES(51,'Cathy','25, av Roosevelt',90100,'DELLE','05/06/78');
INSERT INTO SERVEUR VALUES(52,'Totof','46, grande rue',90500,'BAVILLIERS','03/09/76');
INSERT INTO SERVEUR VALUES(53,'Pilou', '5, impasse Martin',90000,'BELFORT','09/08/76');
                                                                                                    
INSERT INTO FACTURE VALUES(1200,1,53,'21/08/2011');                                            
INSERT INTO FACTURE VALUES(1201,5,53,'21/08/2011');
INSERT INTO FACTURE VALUES(1202,3,52,'21/08/2011');                                  
INSERT INTO FACTURE VALUES(1203,5,50,'21/08/2011');
INSERT INTO FACTURE VALUES(1204,4,52,'22/02/2012');
INSERT INTO FACTURE VALUES(1205,1,53,'22/08/2011');
INSERT INTO FACTURE VALUES(1206,3,52,'22/08/2011');
INSERT INTO FACTURE VALUES(1207,5,53,'22/08/2011');  

INSERT INTO LIGNE_FACT VALUES(1200,101,3);                                                   
INSERT INTO LIGNE_FACT VALUES(1200,106,1);       
INSERT INTO LIGNE_FACT VALUES(1200,120,1); 
INSERT INTO LIGNE_FACT VALUES(1201,105,2);
INSERT INTO LIGNE_FACT VALUES(1201,106,2);
INSERT INTO LIGNE_FACT VALUES(1202,100,2);
INSERT INTO LIGNE_FACT VALUES(1202,122,1);
INSERT INTO LIGNE_FACT VALUES(1203,102,1); 
INSERT INTO LIGNE_FACT VALUES(1203,108,1);   
INSERT INTO LIGNE_FACT VALUES(1203,121,1); 
INSERT INTO LIGNE_FACT VALUES(1203,130,1); 
INSERT INTO LIGNE_FACT VALUES(1204,122,4);
INSERT INTO LIGNE_FACT VALUES(1204,124,2);  
INSERT INTO LIGNE_FACT VALUES(1205,100,2); 
INSERT INTO LIGNE_FACT VALUES(1206,108,3); 
INSERT INTO LIGNE_FACT VALUES(1207,110,2); 
INSERT INTO LIGNE_FACT VALUES(1207,108,1);                                                                       



