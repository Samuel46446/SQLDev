create table enqueteur(
	matricule integer primary key,
	nom text,
	adr1 text,
	adr2 text,
	cp char(5),
	ville text 
);
insert into enqueteur values (1, 'Albert', '11 rue Taine', '', '75012' ,'Paris');

create table questionnaire(
	num integer primary key,
	nom text
);
insert into questionnaire values (1, 'présidentielle 2017');

create table periode(
	num integer primary key,
	dateDeb date,
	dateFin date
);
insert into periode values (1, '2016-02-01', '2016-02-20');
insert into periode values (2, '2016-02-01', '2016-02-17');

create table echantillon(
	num integer primary key,
	nom text
);
insert into echantillon values (1, 'cadres parisiens');
insert into echantillon values (2, 'cadres bordelais');

create table sondage(
	id integer primary key,
	nom text,
	numQuestionnaire integer references questionnaire(num),
	numPeriode integer references periode(num),
	numEchantillon integer references echantillon(num),
	matResp integer references enqueteur(matricule)
);
insert into sondage values (1, 'présidentielle 11/12/2017', 1, 1, 1, 1);
insert into sondage values (2, 'présidentielle 11/05/2017', 1, 2, 2, 1);