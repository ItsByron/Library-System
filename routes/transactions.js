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
            res.json({
            status: 'success',
            message: 'Book borrowed successfully!'
        });
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
// router.post('/archive', (req, res) => {
//     db.query(
//         'CALL sp_ArchiveOldTransactions()',
//         (err, results) => {
//             if (err) {
//                 res.status(500).json({ 
//                     message: 'Error archiving transactions', 
//                     error: err 
//                 });
//                 return;
//             }
//             res.json({ message: 'Old transactions archived!' });
//         }
//     );
// });




router.put('/archive/:id', (req, res) => {
    const { id } = req.params;

    db.query(
        `UPDATE Transactions 
         SET Is_Archived = TRUE 
         WHERE Transaction_ID = ?`,
        [id],
        (err, result) => {

            if (err) {
                console.error(err); // 🔥 VERY IMPORTANT
                return res.json({
                    status: 'error',
                    message: 'Database error'
                });
            }

            res.json({
                status: 'success',
                message: 'Transaction archived successfully!'
            });
        }
    );
});
router.put('/unarchive/:id', (req, res) => {
    const { id } = req.params;

    db.query(
        `UPDATE Transactions 
         SET Is_Archived = FALSE 
         WHERE Transaction_ID = ?`,
        [id],
        (err) => {
            if (err) {
                console.error(err);
                return res.json({
                    status: 'error',
                    message: 'Database error'
                });
            }
            res.json({
                status: 'success',
                message: 'Transaction unarchived successfully!'
            });
        }
    );
});

// PERMANENTLY DELETE ALL ARCHIVED TRANSACTIONS
router.delete('/archived', (req, res) => {
    db.query(
        `DELETE FROM Transactions WHERE Is_Archived = TRUE`,
        (err) => {
            if (err) {
                console.error(err);
                return res.json({ status: 'error', message: 'Database error' });
            }
            res.json({ status: 'success', message: 'All archived transactions deleted!' });
        }
    );
});

// PERMANENTLY DELETE A SINGLE ARCHIVED TRANSACTION
router.delete('/:id', (req, res) => {
    const { id } = req.params;

    db.query(
        `DELETE FROM Transactions WHERE Transaction_ID = ? AND Is_Archived = TRUE`,
        [id],
        (err) => {
            if (err) {
                console.error(err);
                return res.json({ status: 'error', message: 'Database error' });
            }
            res.json({ status: 'success', message: 'Transaction deleted!' });
        }
    );
});

module.exports = router;