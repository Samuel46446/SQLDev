DROP TABLE IF EXISTS attribuer_bonification;
DROP TABLE IF EXISTS participer;
DROP TABLE IF EXISTS etape;
DROP TABLE IF EXISTS type_etape;
DROP TABLE IF EXISTS coureur;
DROP TABLE IF EXISTS pays;
DROP TABLE IF EXISTS equipe;

create table equipe (
codeequipe text primary key,
nomequipe text,
directeursportif text);

create table pays (
codepays text primary key,
nompays text);

create table coureur (
numerocoureur int primary key,
nomcoureur text,
codeequipe text references equipe(codeequipe),
codepays text references pays(codepays));

create table type_etape (
codetype text primary key,
libelletype text);

create table etape (
numeroetape int primary key,
dateetape date,
villedep text,
villearr text,
nbkm int,
codetype text references type_etape(codetype));

create table participer (
numerocoureur int references coureur(numerocoureur),
numeroetape int references etape(numeroetape),
primary key(numerocoureur, numeroetape),
tempsrealise int);

create table attribuer_bonification (
numeroetape int references etape(numeroetape),
km int,
rang int,
primary key(numeroetape, km, rang),
nbsecondes int,
numerocoureur int references coureur(numerocoureur));

insert into equipe 
values ('LRQT', 'La roue qui tourne', 'Beloeuf'),
('LFDE', 'La fourche des enfers', 'Quignard');

insert into pays
values ('FR', 'France'),
('EN', 'England');

insert into coureur
values (1, 'Babel', 'LRQT', 'FR'),
(2, 'Booboole', 'LFDE', 'EN'),
(3, 'Oursan', 'LRQT', 'FR');

insert into type_etape 
values ('MONT', 'Montagne'),
('SPR', 'Sprint');

insert into etape
values (1, '02/03/1997', 'Paris', 'Nantes', 362, 'SPR'),
(2, '03/03/1997', 'Nantes', 'Bordeaux', 453, 'MONT'),
(3, '02/03/1998', 'Paris', 'Nantes', 362, 'SPR');

insert into participer
values (1, 1, 6900),
(1, 2, 7850),
(1, 3, 6900),
(2, 1, 5400);

insert into attribuer_bonification
values (1, 362, 1, 5400, 2),
(1, 362, 2, 6900, 1),
(2, 453, 1, 7850, 1);
