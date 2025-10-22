-- 01_load_csv.sql
USE PaysG20;

LOAD DATA LOCAL INFILE 'C:/Users/samis/OneDrive/Desktop/pays.csv'
INTO TABLE CaracPays
CHARACTER SET utf8
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@Pays, @NbHab, @Capitale, @DensitePop, @PIB, @dejaVisite, @Commentaires)
SET
  Pays        = NULLIF(@Pays, ''),
  NbHab       = NULLIF(@NbHab, ''),
  Capitale    = NULLIF(@Capitale, ''),
  DensitePop  = NULLIF(REPLACE(@DensitePop, ',', '.'), ''),
  PIB         = NULLIF(NULLIF(@PIB, ''), 'N'),
  dejaVisite  = NULLIF(@dejaVisite, ''),
  Commentaires= NULLIF(@Commentaires, '');
