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

    // ✅ Check if email already exists
    if (Email) {
        db.query(
            'SELECT COUNT(*) AS count FROM Members WHERE Email = ?',
            [Email],
            (err, results) => {
                if (err) {
                    res.status(500).json({
                        status : 'error',
                        message: 'Error checking email'
                    });
                    return;
                }

                // ✅ Email already exists!
                if (results[0].count > 0) {
                    res.status(400).json({
                        status : 'error',
                        message: 'Email is already registered!'
                    });
                    return;
                }

                // ✅ Email is unique — check contact next
                checkContact();
            }
        );
    } else {
        // No email provided — check contact directly
        checkContact();
    }

    // ✅ Check if contact already exists
    function checkContact() {
        if (Contact_Number) {
            db.query(
                'SELECT COUNT(*) AS count FROM Members WHERE Contact_Number = ?',
                [Contact_Number],
                (err, results) => {
                    if (err) {
                        res.status(500).json({
                            status : 'error',
                            message: 'Error checking contact'
                        });
                        return;
                    }

                    // ✅ Contact already exists!
                    if (results[0].count > 0) {
                        res.status(400).json({
                            status : 'error',
                            message: 'Contact number is already registered!'
                        });
                        return;
                    }

                    // ✅ Contact is unique — add member
                    addMember();
                }
            );
        } else {
            // No contact provided — add member directly
            addMember();
        }
    }

    // ✅ Finally add the member
    function addMember() {
        const Date_Joined = new Date()
            .toISOString()
            .split('T')[0];

        db.query(
            'CALL sp_AddMember(?, ?, ?, ?)',
            [Name, Email, Contact_Number, Date_Joined],
            (err, results) => {
                if (err) {
                    res.status(500).json({
                        status : 'error',
                        message: 'Error adding member'
                    });
                    return;
                }
                res.json({
                    status : 'success',
                    message: 'Member added successfully!'
                });
            }
        );
    }
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

    // ✅ Check if member has borrowed books
    db.query(
        'SELECT COUNT(*) AS count FROM Transactions WHERE Member_ID = ? AND Return_Date IS NULL',
        [id],
        (err, results) => {
            if (err) {
                res.status(500).json({
                    status : 'error',
                    message: 'Error checking member status'
                });
                return;
            }

            const borrowCount = results[0].count;

            // ✅ Member has borrowed books
            if (borrowCount > 0) {
                res.status(400).json({
                    status : 'error',
                    message: 'Cannot delete member with borrowed books!'
                });
                return;
            }

            // ✅ Safe to delete
            db.query(
                'CALL sp_DeleteMember(?)',
                [id],
                (err, results) => {
                    if (err) {
                        res.status(500).json({
                            status : 'error',
                            message: 'Error deleting member'
                        });
                        return;
                    }
                    res.json({
                        status : 'success',
                        message: 'Member deleted successfully!'
                    });
                }
            );
        }
    );
});

// GET borrowed books for specific member
router.get('/:id/borrowed', (req, res) => {
    const { id } = req.params;
    db.query(
        'CALL sp_GetMemberBorrowedBooks(?)',
        [id],
        (err, results) => {
            if (err) {
                res.status(500).json({
                    message: 'Error getting member books',
                    error  : err
                });
                return;
            }
            res.json(results[0]);
        }
    );
});

module.exports = router;