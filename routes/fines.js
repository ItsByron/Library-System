const express = require('express');
const router  = express.Router();
const db      = require('../db');

// Get all fines
router.get('/', (req, res) => {
    db.query('CALL sp_GetAllFines()', (err, results) => {
        if (err) return res.status(500).json({ message: 'Error getting fines', error: err });
        res.json(results[0]);
    });
});

// Mark a fine as Paid
router.put('/pay/:id', (req, res) => {
    const { id } = req.params;
    db.query('CALL sp_PayFine(?)', [id], (err, results) => {
        if (err) return res.status(500).json({ status: 'error', message: 'Database error', error: err });
        res.json(results[0][0]);
    });
});

// Mark a fine as Waived (no payment needed)
router.put('/waive/:id', (req, res) => {
    const { id } = req.params;
    db.query('CALL sp_WaiveFine(?)', [id], (err, results) => {
        if (err) return res.status(500).json({ status: 'error', message: 'Database error', error: err });
        res.json(results[0][0]);
    });
});

module.exports = router;