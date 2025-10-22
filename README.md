# Laboratoire 6 – SQL + Node.js

**Auteur :** Sami Abdelkhalek  
**Cours :** 247-GFH-LG – Intégration logicielle  
**Collège :** Lionel-Groulx  

---

##  Objectif du laboratoire
Le but de ce laboratoire était de créer une application Node.js connectée à une base de données **MariaDB** (ou MySQL) pour exécuter des requêtes SQL sur un jeu de données concernant les pays du **G20**.

L'application permet :
- d'exécuter les 6 requêtes SQL demandées par le laboratoire (REQ1 à REQ6),
- d'afficher les résultats dans une interface web avec **EJS** et **Bootstrap**,
- d'insérer un nouveau pays dans la base de données,
- et de supprimer un pays existant via des formulaires HTML.
  
---

## Technologies utilisées
- **Node.js**  
- **Express.js**  
- **EJS** (avec `express-ejs-layouts`)  
- **MariaDB / MySQL**  
- **Bootstrap 5**  
- **MySQL2 (Promise)**
---

## Fonctionnement
### 1️ Lancer le serveur
```bash
npm install
node server.js
