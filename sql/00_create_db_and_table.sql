-- 00_create_db_and_table.sql
-- Auteur: Sami Abdelkhalek
-- Objet: Création de la BD et de la table pour Laboratoire 6

-- Crée la base (UTF-8)
CREATE DATABASE IF NOT EXISTS PaysG20 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';
USE PaysG20;

-- Table CaracPays
DROP TABLE IF EXISTS CaracPays;
CREATE TABLE CaracPays (
  id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  Pays VARCHAR(63) NOT NULL,
  NbHab INT NULL,                    -- population (habitants)
  Capitale VARCHAR(63) NULL,
  DensitePop DECIMAL(8,2) NULL,      -- hab/km2
  PIB INT NULL,                      -- en milliards (ou unité du CSV)
  dejaVisite CHAR(1) NULL,           -- 'O'/'N' ou 'Y'/'N'
  Commentaires TEXT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Optionnel: inspection
DESCRIBE CaracPays;
