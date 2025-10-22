-- 01_load_csv.sql
-- Chemin local à adapter selon ta machine
USE PaysG20;

-- Exemple si les entêtes du CSV sont: Pays,NbHab,Capitale,DensitePop,PIB,dejaVisite,Commentaires
LOAD DATA LOCAL INFILE 'C:/path/vers/pays.csv'
INTO TABLE CaracPays
CHARACTER SET utf8
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Pays, NbHab, Capitale, DensitePop, PIB, dejaVisite, Commentaires);
