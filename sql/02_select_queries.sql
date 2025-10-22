-- 02_select_queries.sql
-- Auteur: Sami Abdelkhalek
-- Requêtes demandées (SELECT)

USE PaysG20;

-- 1) Pays >100 000 000 hab ET densité > 100 hab/km2
SELECT Pays, NbHab, DensitePop
FROM CaracPays
WHERE NbHab > 100000000 AND DensitePop > 100;

-- 2) Pays visités ET (PIB > 2000 OU population > 300 000 000)
SELECT Pays, PIB, NbHab, dejaVisite
FROM CaracPays
WHERE (UPPER(dejaVisite) IN ('O','Y') OR dejaVisite='1')
  AND (PIB > 2000 OR NbHab > 300000000);

-- 3) Pays commençant par 'a' ET capitale contenant 'a'
SELECT Pays, Capitale
FROM CaracPays
WHERE LOWER(Pays) LIKE 'a%' AND LOWER(Capitale) LIKE '%a%';

-- 4) Conditions combinées
SELECT Pays, NbHab, DensitePop, PIB, dejaVisite
FROM CaracPays
WHERE (
        (NOT (UPPER(dejaVisite) IN ('O','Y') OR dejaVisite='1'))
        AND (PIB IS NULL OR DensitePop < 50)
      )
   OR (
        (UPPER(dejaVisite) IN ('O','Y') OR dejaVisite='1')
        AND NbHab < 50000000
      );

-- 5) Pays avec le plus grand PIB
SELECT c.*
FROM CaracPays c
WHERE PIB IS NOT NULL
  AND PIB = (SELECT MAX(PIB) FROM CaracPays WHERE PIB IS NOT NULL);

-- 6) Pays avec la plus petite population
SELECT c.*
FROM CaracPays c
WHERE NbHab IS NOT NULL
  AND NbHab = (SELECT MIN(NbHab) FROM CaracPays WHERE NbHab IS NOT NULL);
