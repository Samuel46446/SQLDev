SELECT libelle 
FROM QUESTION AS Q 
INNER JOIN questionnaire AS qre
ON Q.numQuestionnaire = qre.num 
WHERE qre.nom = 'présidentielle 2017';

SELECT e.num, e.nom
FROM ENQUETE e
JOIN REPONSE r ON e.num = r.numEnquete
GROUP BY e.num, e.nom
HAVING COUNT(DISTINCT r.numQuestion) > 1;

SELECT num, nom
FROM ENQUETE AS E
WHERE E.num NOT IN (SELECT R.numEnquete FROM REPONSE AS R);

SELECT E.num, E.nom
FROM ENQUETE AS E INNER JOIN echantillon AS ech ON E.numEchantillon = ech.num
WHERE E.num NOT IN (SELECT R.numEnquete FROM REPONSE AS R) AND ech.nom = 'cadres parisiens';

SELECT e.num, e.nom
FROM ENQUETE e
JOIN REPONSE r ON e.num = r.numEnquete
GROUP BY e.num, e.nom
HAVING COUNT(DISTINCT r.numQuestion) > (SELECT COUNT(*) 
FROM ENQUETE e
JOIN REPONSE r ON e.num = r.numEnquete
WHERE e.nom = 'Denis');

SELECT Count(*) AS nb_oui
FROM QUESTION AS Q, REPONSE AS R, questionnaire AS qre
WHERE Q.num = R.numQuestion AND qre.num = Q.numQuestionnaire 
AND qre.nom = 'présidentielle 2017' AND R.reponse = TRUE;

SELECT s.nom
FROM sondage AS s INNER JOIN periode AS p ON p.num = s.numPeriode
WHERE '2016-02-18' BETWEEN p.dateDeb AND p.dateFin;