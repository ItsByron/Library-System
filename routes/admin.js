const express = require('express');
const router  = express.Router();
const db      = require('../db');

// Admin Login
router.post('/login', (req, res) => {
  const { Username, Password } = req.body;

  if (!Username || !Password) {
    return res.json({ status: 'error', message: 'Missing credentials' });
  }

  db.query(
    'CALL sp_AdminLogin(?, ?)',
    [Username, Password],
    (err, results) => {
      if (err) {
        console.error('Login error:', err);
        return res.status(500).json({ status: 'error', message: 'Server error' });
      }

      if (results[0] && results[0].length > 0) {
        return res.json({ status: 'success' });
      } else {
        return res.json({ status: 'error', message: 'Invalid username or password.' });
      }
    }
  );
});

// Register Admin
router.post('/register', (req, res) => {
  const { Username, Password } = req.body;

  console.log("INPUT:", Username, Password);

  if (!Username || !Password) {
    return res.json({ status: 'error', message: 'Missing fields' });
  }

  db.query(
    'CALL sp_RegisterAdmin(?, ?)',
    [Username, Password],
    (err, results) => {

      if (err) {
        console.error("MYSQL ERROR:", err); 
        return res.status(500).json({ status: 'error', message: err.message });
      }

      console.log("RESULTS:", results);


      if (results && results[0] && results[0][0]) {
        return res.json(results[0][0]);
      } else {
        return res.json({
          status: 'error',
          message: 'No response from procedure'
        });
      }
    }
  );
});
module.exports = router;