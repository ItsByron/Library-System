const express = require('express');
const router  = express.Router();
const db      = require('../db');

// RENDER ALL THE TRANSACTIONS
router.get('/', (req, res) => {
    db.query(
        'CALL sp_GetAllTransactions()',
        (err, results) => {
            if (err) {
                res.status(500).json({ 
                    message: 'Error getting transactions', 
                    error: err 
                });
                return;
            }
            res.json(results[0]);
        }
    );
});

// DISPLAY THE BARROWED BOOKS
router.get('/borrowed', (req, res) => {
    db.query(
        'CALL sp_GetBorrowedBooks()',
        (err, results) => {
            if (err) {
                res.status(500).json({ 
                    message: 'Error getting borrowed books', 
                    error: err 
                });
                return;
            }
            res.json(results[0]);
        }
    );
});

// METHOD FOR BORROWING A BOOK
router.post('/borrow', (req, res) => {
    const { Book_ID, Member_ID, 
            Borrow_Date, Due_Date } = req.body;

    db.query(
        'CALL sp_BorrowBook(?, ?, ?, ?)',
        [Book_ID, Member_ID, Borrow_Date, Due_Date],
        (err, results) => {
            if (err) {
                res.status(500).json({ 
                    message: 'Error borrowing book', 
                    error: err 
                });
                return;
            }
            res.json({ message: 'Book borrowed successfully!' });
        }
    );
});

// METHOD WHEN RETURNING A BOOK
router.post('/return/:id', (req, res) => {
    const { id } = req.params;

    // Automatically set today as Return_Date
    const Return_Date = new Date()
        .toISOString()
        .split('T')[0];

    db.query(
        'CALL sp_ReturnBook(?, ?)',
        [id, Return_Date],
        (err, results) => {
            if (err) {
                res.status(500).json({ 
                    message: 'Error returning book', 
                    error: err 
                });
                return;
            }
            res.json({ message: 'Book returned successfully!' });
        }
    );
});

// ARCHIVING OF TRANSACTION
router.post('/archive', (req, res) => {
    db.query(
        'CALL sp_ArchiveOldTransactions()',
        (err, results) => {
            if (err) {
                res.status(500).json({ 
                    message: 'Error archiving transactions', 
                    error: err 
                });
                return;
            }
            res.json({ message: 'Old transactions archived!' });
        }
    );
});

module.exports = router;
