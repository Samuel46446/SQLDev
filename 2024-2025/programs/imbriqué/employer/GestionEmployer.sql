CREATE DATABASE sturpin_gestionemployer;

CREATE TABLE DEPARTEMENT(
    DNO INT PRIMARY KEY,
    DNOM VARCHAR(50),
    DIR INT,
    VILLE VARCHAR(50)
);

CREATE TABLE EMPLOYER(
    ENO INT PRIMARY KEY,
    ENOM VARCHAR(50),
    PROF VARCHAR(50) CHECK(PROF != 'Directeur'),
    DATEEMB DATE,
    SAL NUMERIC,
    COMM INT,
    DNO INT
);

INSERT INTO DEPARTEMENT (DNO, DNOM, DIR, VILLE) VALUES
(1, 'Commercial', 30, 'New York'),
(2, 'Production', 20, 'Houston'),
(3, 'Développement', 40, 'Boston');

INSERT INTO EMPLOYER (ENO, ENOM, PROF, DATEEMB, SAL, COMM, DNO) VALUES
(10, 'Joe', 'Ingénieur', '1993-10-01', 4000, 3000, 3),
(20, 'Jack', 'Technicien', '1988-05-01', 3000, 2000, 2),
(30, 'Jim', 'Vendeur', '1980-03-01', 5000, 5000, 1),
(40, 'Lucy', 'Ingénieur', '1980-03-01', 5000, 5000, 3);

ALTER TABLE EMPLOYER ADD CONSTRAINT fk_DNO FOREIGN KEY(DNO) REFERENCES DEPARTEMENT(DNO);
ALTER TABLE DEPARTEMENT ADD CONSTRAINT fk_ENO FOREIGN KEY(DIR) REFERENCES EMPLOYER(ENO);

--Nom & salaire des employées
SELECT ENOM, SAL
FROM EMPLOYER;
--  enom | sal
-- ------+------
--  Joe  | 4000
--  Jack | 3000
--  Jim  | 5000
--  Lucy | 5000
-- (4 lignes)

SELECT DISTINCT PROF
FROM EMPLOYER;
--     prof
-- ------------
--  Vendeur
--  Technicien
--  Ingénieur
-- (3 lignes)

SELECT ENOM, DATEEMB
FROM EMPLOYER
WHERE PROF='Technicien';
--  enom |  dateemb
-- ------+------------
--  Jack | 1988-05-01
-- (1 ligne)

SELECT *
FROM EMPLOYER AS E, DEPARTEMENT AS D
WHERE E.DNO=D.DNO AND D.DIR=E.ENO;
--  eno | enom |    prof    |  dateemb   | sal  | comm | dno | dno |     dnom      | dir |  ville
-- -----+------+------------+------------+------+------+-----+-----+---------------+-----+----------
--   30 | Jim  | Vendeur    | 1980-03-01 | 5000 | 5000 |   1 |   1 | Commercial    |  30 | New York
--   20 | Jack | Technicien | 1988-05-01 | 3000 | 2000 |   2 |   2 | Production    |  20 | Houston
--   40 | Lucy | Ingénieur  | 1980-03-01 | 5000 | 5000 |   3 |   3 | Développement |  40 | Boston
-- (3 lignes)

SELECT ENOM, DNOM
FROM EMPLOYER AS E, DEPARTEMENT AS D
WHERE E.DNO=D.DNO AND D.DIR=E.ENO AND VILLE='Boston';
--  enom |     dnom
-- ------+---------------
--  Lucy | Développement
-- (1 ligne)

SELECT ENOM, PROF
FROM EMPLOYER AS E, DEPARTEMENT AS D
WHERE E.DNO=D.DNO AND E.ENO=D.DIR AND D.DNO IN (1, 3);
--  enom |   prof
-- ------+-----------
--  Jim  | Vendeur
--  Lucy | Ingénieur
-- (2 lignes)

SELECT ENOM, PROF, SAL, COMM
FROM EMPLOYER
WHERE COMM != 0;
--  enom |    prof    | sal  | comm
-- ------+------------+------+------
--  Joe  | Ingénieur  | 4000 | 3000
--  Jack | Technicien | 3000 | 2000
--  Jim  | Vendeur    | 5000 | 5000
--  Lucy | Ingénieur  | 5000 | 5000
-- (4 lignes)

SELECT ENOM, PROF, SAL
FROM EMPLOYER
ORDER BY PROF ASC, SAL DESC;
--  enom |    prof    | sal
-- ------+------------+------
--  Lucy | Ingénieur  | 5000
--  Joe  | Ingénieur  | 4000
--  Jack | Technicien | 3000
--  Jim  | Vendeur    | 5000
-- (4 lignes)

SELECT ROUND(AVG(SAL), 2)
FROM EMPLOYER;
--   round
-- ---------
--  4250.00
-- (1 ligne)

SELECT COUNT(*)
FROM EMPLOYER AS E, DEPARTEMENT AS D
WHERE E.DNO=D.DNO AND E.ENO=D.DIR AND DNOM='Production';
--  count
-- -------
--      1
-- (1 ligne)

SELECT E.DNO, Max(SAL)
FROM EMPLOYER AS E
GROUP BY E.DNO;

SELECT E1.ENOM
FROM EMPLOYER AS E1
WHERE E.DNO IN (SELECT E2.DNO FROM EMPLOYER AS E2 WHERE E2.PROF='Ingénieur')


SELECT E1.ENOM, E1.SAL
FROM EMPLOYER AS E1
WHERE E1.SAL > ANY (SELECT E2.SAL FROM EMPLOYER AS E2 WHERE E2.PROF='Ingénieur');

SELECT E1.ENOM, E1.SAL
FROM EMPLOYER AS E1
WHERE E1.SAL > ALL (SELECT E2.SAL FROM EMPLOYER AS E2 WHERE E2.PROF='Ingénieur');

SELECT *
FROM DEPARTEMENT
WHERE DNO NOT IN (SELECT DNO FROM EMPLOYER);

SELECT ENOM
FROM EMPLOYER, DEPARTEMENT
WHERE EMPLOYER.DNO=DEPARTEMENT.DNO AND ENOM='Commercial'
AND DATEEMB IN (SELECT DATEEMB
                FROM EMPLOYER, DEPARTEMENT
                WHERE EMPLOYER.DNO=DEPARTEMENT.DNO AND DNOM='Production');

SELECT ENOM
FROM EMPLOYER, DEPARTEMENT
WHERE ENOM <> 'Joe' 
AND EMPLOYER.DNO=DEPARTEMENT.DNO 
AND (PROF, DIR) = (SELECT PROF, DIR FROM EMPLOYER WHERE ENOM='Joe'
                   AND EMPLOYER.DNO=DEPARTEMENT.DNO);

SELECT ENOM
FROM EMPLOYER
WHERE ENOM <> 'JIM' AND 
DNO IN (SELECT D.DNO FROM DEPARTEMENT AS D 
WHERE D.DIR IN (SELECT E.ENO FROM EMPLOYER AS E, DEPARTEMENT AS D1
WHERE E.DNO=D1.DNO E.ENOM='JIM'));

SELECT ENOM
FROM EMPLOYER
WHERE (DNO, SAL) IN (SELECT DNO, MAX(SAL) FROM EMPLOYER GROUP BY DNO);

SELECT ENOM
FROM EMPLOYER AS E
WHERE SAL = (SELECT MAX(SAL) FROM EMPLOYER AS F WHERE F.DNO=E.DNO);

SELECT PROF, AVG(SAL)
FROM EMPLOYER
GROUP BY PROF;

SELECT ENOM
FROM EMPLOYER
WHERE (DNO, SAL) IN (SELECT DNO, MAX(SAL) FROM EMPLOYER GROUP BY DNO);

SELECT (AVG(SAL))
FROM EMPLOYER E1
GROUP BY prof
HAVING AVG(SAL) <= 
(SELECT AVG(SAL) FROM EMPLOYER AS E2 
WHERE E1.PROF=E2.PROF);

SELECT PROF, AVG(SAL)
FROM EMPLOYER
GROUP BY PROF
HAVING AVG(SAL) = (SELECT MIN(AVG(SAL)) FROM EMPLOYER GROUP BY PROF);

