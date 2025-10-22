// src/routes.js
const express = require('express');
const pool = require('./db');
const router = express.Router();

// Normalisation 'dejaVisite' entrée utilisateur → 'O'/'N'
function normalizeVisited(v) {
  if (v == null) return null;
  const s = String(v).trim().toLowerCase();
  if (['o','oui','y','yes','1','v','true'].includes(s)) return 'O';
  if (['n','non','0','false'].includes(s)) return 'N';
  return null;
}

// Page d'accueil
router.get('/', async (req, res) => {
  res.render('index', {
    title: 'PaysG20 - Accueil'
  });
});

// ====== REQUETES 1 à 6 ======
router.get('/requete1', async (req, res) => {
  const sql = `
    SELECT Pays, NbHab, DensitePop
    FROM CaracPays
    WHERE NbHab > 100000000
      AND DensitePop > 100
    ORDER BY NbHab DESC;
  `;
  const [rows] = await pool.query(sql);
  res.render('table', { title: 'Requête 1', subtitle: 'Pays >100M hab & densité >100', rows });
});

router.get('/requete2', async (req, res) => {
  const sql = `
    SELECT Pays, PIB, NbHab, dejaVisite
    FROM CaracPays
    WHERE (UPPER(dejaVisite) IN ('O','Y') OR dejaVisite='1')
      AND (PIB > 2000 OR NbHab > 300000000)
    ORDER BY PIB DESC, NbHab DESC;
  `;
  const [rows] = await pool.query(sql);
  res.render('table', { title: 'Requête 2', subtitle: 'Visités & (PIB>2000 ou pop>300M)', rows });
});

router.get('/requete3', async (req, res) => {
  const sql = `
    SELECT Pays, Capitale
    FROM CaracPays
    WHERE LOWER(Pays) LIKE 'a%'
      AND LOWER(Capitale) LIKE '%a%'
    ORDER BY Pays ASC;
  `;
  const [rows] = await pool.query(sql);
  res.render('table', { title: 'Requête 3', subtitle: "Pays commencent par 'a' & capitale contient 'a'", rows });
});

router.get('/requete4', async (req, res) => {
  const sql = `
    SELECT Pays, NbHab, DensitePop, PIB, dejaVisite
    FROM CaracPays
    WHERE (
            (NOT (UPPER(dejaVisite) IN ('O','Y') OR dejaVisite='1'))
            AND (PIB IS NULL OR DensitePop < 50)
          )
       OR (
            (UPPER(dejaVisite) IN ('O','Y') OR dejaVisite='1')
            AND NbHab < 50000000
          )
    ORDER BY dejaVisite ASC, NbHab ASC, DensitePop ASC;
  `;
  const [rows] = await pool.query(sql);
  res.render('table', { title: 'Requête 4', subtitle: 'Mix critères visités/non-visités', rows });
});

router.get('/requete5', async (req, res) => {
  const sql = `
    SELECT *
    FROM CaracPays
    WHERE PIB IS NOT NULL
      AND PIB = (SELECT MAX(PIB) FROM CaracPays WHERE PIB IS NOT NULL);
  `;
  const [rows] = await pool.query(sql);
  res.render('table', { title: 'Requête 5', subtitle: 'Pays avec le PIB maximum', rows });
});

router.get('/requete6', async (req, res) => {
  const sql = `
    SELECT *
    FROM CaracPays
    WHERE NbHab IS NOT NULL
      AND NbHab = (SELECT MIN(NbHab) FROM CaracPays WHERE NbHab IS NOT NULL);
  `;
  const [rows] = await pool.query(sql);
  res.render('table', { title: 'Requête 6', subtitle: 'Pays avec la plus petite population', rows });
});

// ====== INSERT ======
router.get('/insert', (req, res) => {
  res.render('form-insert', { title: 'Insérer un pays' });
});

router.post('/insert', async (req, res) => {
  let { Pays, NbHab, Capitale, DensitePop, PIB, dejaVisite, Commentaires } = req.body;

  // Normaliser & caster
  const v = normalizeVisited(dejaVisite);
  const nb = NbHab === '' ? null : Number(NbHab);
  const dens = DensitePop === '' ? null : Number(DensitePop);
  const pib = PIB === '' ? null : Number(PIB);

  const sql = `
    INSERT INTO CaracPays (Pays, NbHab, Capitale, DensitePop, PIB, dejaVisite, Commentaires)
    VALUES (?, ?, ?, ?, ?, ?, ?)
  `;
  const params = [Pays || null, nb, Capitale || null, dens, pib, v, Commentaires || null];
  await pool.query(sql, params);
  res.redirect('/requete1');
});

// ====== DELETE ======
router.get('/delete', (req, res) => {
  res.render('form-delete', { title: 'Supprimer un pays' });
});

router.post('/delete', async (req, res) => {
  const { Pays } = req.body;
  if (!Pays) return res.redirect('/delete');
  const sql = `DELETE FROM CaracPays WHERE Pays = ?`;
  await pool.query(sql, [Pays]);
  res.redirect('/');
});

module.exports = router;

// ====== VISUALISER TOUTE LA TABLE ======
router.get('/data', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM CaracPays ORDER BY id ASC');
    res.render('table', {
      title: 'Toutes les données',
      subtitle: 'Table CaracPays complète',
      rows
    });
  } catch (err) {
    console.error(err);
    res.status(500).send('Erreur lors du chargement des données.');
  }
});
