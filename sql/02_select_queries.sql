-- 02_select_queries.sql
-- Auteur: Sami Abdelkhalek
-- Requêtes demandées (SELECT) pour Laboratoire 6
USE PaysG20;

-- 1) Pays >100 000 000 hab ET densité > 100 hab/km2
-- (100 000 000 = 1e8)
SELECT Pays, NbHab, DensitePop
FROM CaracPays
WHERE NbHab > 100000000
  AND DensitePop > 100;

-- 2) Pays visités (dejaVisite='O'/'Y'/'1') ET (PIB > 2000 OU population > 300 000 000)
SELECT Pays, PIB, NbHab, dejaVisite
FROM CaracPays
WHERE (UPPER(dejaVisite) IN ('O','Y') OR dejaVisite='1')
  AND (PIB > 2000 OR NbHab > 300000000);

-- 3) Pays commençant par 'a' ET capitale contenant 'a'
-- (insensible à la casse via LOWER)
SELECT Pays, Capitale
FROM CaracPays
WHERE LOWER(Pays) LIKE 'a%'
  AND LOWER(Capitale) LIKE '%a%';

-- 4) Pays:
--    - soit NON visités ET (PIB IS NULL OU DensitePop < 50)
--    - soit visités ET NbHab < 50 000 000
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
-- (en cas d'ex-aequo, on les affiche tous)
SELECT c.*
FROM CaracPays c
WHERE PIB IS NOT NULL
  AND PIB = (SELECT MAX(PIB) FROM CaracPays WHERE PIB IS NOT NULL);

-- 6) Pays avec la plus petite population
-- (en cas d'ex-aequo, on les affiche tous; on ignore NULL)
SELECT c.*
FROM CaracPays c
WHERE NbHab IS NOT NULL
  AND NbHab = (SELECT MIN(NbHab) FROM CaracPays WHERE NbHab IS NOT NULL);
