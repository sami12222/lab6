// src/server.js
const express = require('express');
const path = require('path');
const layouts = require('express-ejs-layouts');
const routes = require('./routes');
require('dotenv').config();

const app = express();

// middlewares
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// ejs + layouts
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));
app.use(layouts);

// static (si besoin de CSS/JS custom)
app.use(express.static(path.join(__dirname, 'public')));

// routes
app.use('/', routes);

// start
const PORT = Number(process.env.PORT || 3000);
app.listen(PORT, () => {
  console.log(`✅ Serveur démarré: http://localhost:${PORT}`);
});
