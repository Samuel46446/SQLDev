/*SELECT f.numfact, t.numtable, f.datefact
FROM facture as f INNER JOIN tables as t ON f.numtable = t.numtable;

SELECT libcons
FROM ligne_fact as l, conso as c, facture as f
WHERE l.numcons = c.numcons AND l.numfact = f.numfact AND f.datefact = '2012-02-22';

SELECT Count(*)
FROM serveur;*/

/*INSERT INTO serveur VALUES(54,'Léon','35, rue des Lilas',69000,'Lyon','20/06/76');
*/
/*SELECT t.numtable, t.nbplaces
FROM tables as t
WHERE t.numtable NOT IN (SELECT f.numtable FROM facture as f);

SELECT libcons, prixcons
FROM conso
WHERE prixcons = (SELECT MIN(prixcons) FROM conso);

SELECT f.numfact, f.datefact, SUM(c.prixcons * l.qte) as total
FROM facture as f, conso as c, ligne_fact as l
WHERE f.numfact = l.numfact AND c.numcons = l.numcons
GROUP BY f.numfact;

--Désactiver pour empêcher l'augmentation à chaque execution
SELECT libcons, prixcons FROM conso WHERE libcons LIKE '%Café%';

UPDATE conso
SET prixcons = prixcons * 1.10
WHERE libcons LIKE '%Café%';

SELECT libcons, prixcons FROM conso WHERE libcons LIKE '%Café%';

SELECT S.nomserv, SUM(C.prixcons * L.qte)
FROM serveur AS S, facture AS F, ligne_fact AS L, conso AS C
WHERE F.numfact=L.numfact AND S.numserv=F.numserv
AND C.numcons=L.numcons
GROUP BY S.nomserv
HAVING SUM(C.prixcons * L.qte) > 30;

SELECT S.nomserv, SUM(C.prixcons * L.qte) as total_ventes
FROM serveur AS S, facture AS F, ligne_fact AS L, conso AS C
WHERE F.numfact=L.numfact AND S.numserv=F.numserv
AND C.numcons=L.numcons
GROUP BY S.nomserv
ORDER BY total_ventes DESC
LIMIT 1;

DELETE FROM ligne_fact
WHERE numfact = 1207 AND numcons=108;*/

SELECT S.nomserv, SUM(C.prixcons * L.qte) as total_ventes
FROM serveur AS S, facture AS F, ligne_fact AS L, conso AS C
WHERE F.numfact=L.numfact AND S.numserv=F.numserv
AND C.numcons=L.numcons
GROUP BY S.nomserv
ORDER BY total_ventes DESC;

SELECT T.nomtable
FROM tables AS T, facture AS F, conso AS C, ligne_fact AS L
WHERE F.numfact = L.numfact
AND C.numcons = L.numcons
AND T.numtable = F.numtable
AND C.libcons = 'Perrier';

SELECT C.libcons, SUM(L.qte) AS quantite_totale
FROM conso AS C
JOIN ligne_fact AS L ON C.numcons = L.numcons
GROUP BY C.libcons
ORDER BY quantite_totale ASC;

SELECT F.datefact, SUM(C.prixcons * L.qte) AS ca_jour
FROM facture AS F
JOIN ligne_fact AS L ON F.numfact = L.numfact
JOIN conso AS C ON L.numcons = C.numcons
GROUP BY F.datefact
ORDER BY ca_jour ASC
LIMIT 1;