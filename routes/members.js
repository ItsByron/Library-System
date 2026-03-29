const express = require('express');
const router  = express.Router();
const db      = require('../db');

//CRUD OPERATION FOR BOOK (Create - READ - UPDATE - DELETE)
// METHOD PANG RENDER NG MGA MEMBERS
router.get('/', (req, res) => {
    db.query(
        'CALL sp_GetAllMembers()',
        (err, results) => {
            if (err) {
                res.status(500).json({ 
                    message: 'Error getting members', 
                    error: err 
                });
                return;
            }
            res.json(results[0]);
        }
    );
});

// METHOD PANG ADD NG NEW MEMBER
router.post('/', (req, res) => {
    const { Name, Email, Contact_Number } = req.body;

    // Automatically set today as Date_Joined
    const Date_Joined = new Date()
        .toISOString()
        .split('T')[0];

    db.query(
        'CALL sp_AddMember(?, ?, ?, ?)',
        [Name, Email, Contact_Number, Date_Joined],
        (err, results) => {
            if (err) {
                res.status(500).json({ 
                    message: 'Error adding member', 
                    error: err 
                });
                return;
            }
            res.json({ message: 'Member added successfully!' });
        }
    );
});

// METHOD PANG UPDATE NG INFO NUNG MEMBER (Wala pa sa UI)
router.put('/', (req, res) => {
    const { Member_ID, Name, 
            Email, Contact_Number } = req.body;

    db.query(
        'CALL sp_UpdateMember(?, ?, ?, ?)',
        [Member_ID, Name, Email, Contact_Number],
        (err, results) => {
            if (err) {
                res.status(500).json({ 
                    message: 'Error updating member', 
                    error: err 
                });
                return;
            }
            res.json({ message: 'Member updated successfully!' });
        }
    );
});

// METHOD PANG DELETE NG MEMBERS
router.delete('/:id', (req, res) => {
    const { id } = req.params;

    db.query(
        'CALL sp_DeleteMember(?)',
        [id],
        (err, results) => {
            if (err) {
                res.status(500).json({ 
                    message: 'Error deleting member', 
                    error: err 
                });
                return;
            }
            res.json({ message: 'Member deleted successfully!' });
        }
    );
});

module.exports = router;