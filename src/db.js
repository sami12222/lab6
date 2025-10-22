// src/db.js
const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host: '127.0.0.1',    // évite 'localhost' (IPv6)
  user: 'root',
  password: '1220',
  database: 'paysg20',
  port: 3306,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  multipleStatements: false
});

module.exports = pool;
