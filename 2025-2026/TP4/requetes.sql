-- 1
SELECT C.numerocoureur, C.nomcoureur, P.nompays
FROM coureur C JOIN pays P ON C.codepays = P.codepays JOIN equipe E ON C.codeequipe = E.codeequipe
WHERE E.nomequipe = 'La fourche des enfers';

--2
SELECT SUM(nbkm) as total_km_97
FROM etape
WHERE dateetape BETWEEN '1997-01-01' AND '1997-12-31';

--3
SELECT SUM(nbkm) as total_km_montagne
FROM etape AS E JOIN type_etape T ON E.codetype = T.codetype
WHERE T.libelletype LIKE '%ontagn%';

--4
SELECT C.nomcoureur
FROM coureur AS C
WHERE C.nomcoureur NOT IN (
    SELECT C2.nomcoureur
    FROM coureur AS C2 JOIN attribuer_bonification AS A2 
    ON C2.numerocoureur = A2.numerocoureur);

--5
SELECT C.nomcoureur, Count(*) AS nb_etapes
FROM coureur AS C JOIN participer AS P ON C.numerocoureur = P.numerocoureur
JOIN etape AS E ON P.numeroetape = E.numeroetape
WHERE C.numerocoureur IN (SELECT C2.numerocoureur
FROM coureur AS C2 JOIN participer AS P2 
ON C2.numerocoureur = P2.numerocoureur)
GROUP BY C.nomcoureur
HAVING Count(*) = (SELECT Count(*) FROM etape);

--6
SELECT C.nomcoureur, C.codeequipe, C.codepays, SUM(P.tempsrealise) AS temps_total
FROM coureur AS C JOIN participer AS P ON C.numerocoureur = P.numerocoureur
WHERE P.numeroetape IN (SELECT numeroetape FROM etape ORDER BY numeroetape LIMIT 3)
GROUP BY C.nomcoureur, C.codeequipe, C.codepays
ORDER BY temps_total ASC;