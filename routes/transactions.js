// const express = require('express');
// const router  = express.Router();
// const db      = require('../db');

// // Get all transactions
// router.get('/', (req, res) => {
//     db.query('CALL sp_GetAllTransactions()', (err, results) => {
//         if (err) return res.status(500).json({ message: 'Error getting transactions', error: err });
//         res.json(results[0]);
//     });
// });

// // Search transactions 
// router.get('/search', (req, res) => {
//     const q = req.query.q || '';
//     db.query('CALL sp_SearchTransactions(?)', [q], (err, results) => {
//         if (err) return res.status(500).json({ message: 'Error searching transactions', error: err });
//         res.json(results[0]);
//     });
// });

// // Get all currently borrowed books (not returned yet)
// router.get('/borrowed', (req, res) => {
//     db.query('CALL sp_GetBorrowedBooks()', (err, results) => {
//         if (err) return res.status(500).json({ message: 'Error getting borrowed books', error: err });
//         res.json(results[0]);
//     });
// });

// // Borrow a book
// router.post('/borrow', (req, res) => {
//     const { BookCopy_ID, Member_ID, Borrow_Date, Due_Date } = req.body;

//     if (!BookCopy_ID || !Member_ID || !Borrow_Date || !Due_Date) {
//         return res.json({ status: 'error', message: 'Missing required fields!' });
//     }

   
//     const borrow = new Date(Borrow_Date);
//     const due    = new Date(Due_Date);
//     const days   = Math.round((due - borrow) / (1000 * 60 * 60 * 24));

//     if (days < 1 || days > 30) {
//         return res.json({ status: 'error', message: 'Loan duration must be between 1 and 30 days!' });
//     }

//     db.query(
//         'CALL sp_BorrowBook(?, ?, ?, ?)',
//         [BookCopy_ID, Member_ID, Borrow_Date, Due_Date],
//         (err, results) => {
//             if (err) return res.status(500).json({ status: 'error', message: 'Database error', error: err });
//             res.json(results[0][0]);
//         }
//     );
// });

// // Return a book 
// router.post('/return/:id', (req, res) => {
//     const { id } = req.params;
//     const Return_Date = new Date().toISOString().split('T')[0];

//     db.query('CALL sp_ReturnBook(?, ?)', [id, Return_Date], (err, results) => {
//         if (err) return res.status(500).json({ message: 'Error returning book', error: err });
//         res.json(results[0][0]);
//     });
// });

// // Archive a transaction
// // router.put('/archive/:id', (req, res) => {
// //     const { id } = req.params;
// //     db.query(
// //         'UPDATE BorrowDetails SET Is_Archived = TRUE WHERE BorrowDetails_ID = ?',
// //         [id],
// //         (err) => {
// //             if (err) return res.json({ status: 'error', message: 'Database error' });
// //             res.json({ status: 'success', message: 'Transaction archived successfully!' });
// //         }
// //     );
// // });

// // Unarchive a transaction
// router.put('/unarchive/:id', (req, res) => {
//     const { id } = req.params;
//     db.query(
//         'UPDATE BorrowDetails SET Is_Archived = FALSE WHERE BorrowDetails_ID = ?',
//         [id],
//         (err) => {
//             if (err) return res.json({ status: 'error', message: 'Database error' });
//             res.json({ status: 'success', message: 'Transaction unarchived successfully!' });
//         }
//     );
// });

// // Permanently delete all archived transactions
// router.delete('/archived', (req, res) => {
//     db.query('DELETE FROM BorrowDetails WHERE Is_Archived = TRUE', (err) => {
//         if (err) return res.json({ status: 'error', message: 'Database error' });
//         res.json({ status: 'success', message: 'All archived transactions deleted!' });
//     });
// });

// // Permanently delete a single archived transaction
// router.delete('/:id', (req, res) => {
//     const { id } = req.params;
//     db.query(
//         'DELETE FROM BorrowDetails WHERE BorrowDetails_ID = ? AND Is_Archived = TRUE',
//         [id],
//         (err) => {
//             if (err) return res.json({ status: 'error', message: 'Database error' });
//             res.json({ status: 'success', message: 'Transaction deleted!' });
//         }
//     );
// });

// module.exports = router;


const express = require('express');
const router  = express.Router();
const db      = require('../db');

// ── GET ALL TRANSACTIONS ─────────────────────────────────────
router.get('/', (req, res) => {
    db.query('CALL sp_GetAllTransactions()', (err, results) => {
        if (err) return res.status(500).json({ message: 'Error getting transactions', error: err });
        res.json(results[0]);
    });
});

// ── SEARCH TRANSACTIONS (query param: ?q=) ───────────────────
router.get('/search', (req, res) => {
    const q = req.query.q || '';
    db.query('CALL sp_SearchTransactions(?)', [q], (err, results) => {
        if (err) return res.status(500).json({ message: 'Error searching transactions', error: err });
        res.json(results[0]);
    });
});

// ── GET CURRENTLY BORROWED BOOKS ────────────────────────────
router.get('/borrowed', (req, res) => {
    db.query('CALL sp_GetBorrowedBooks()', (err, results) => {
        if (err) return res.status(500).json({ message: 'Error getting borrowed books', error: err });
        res.json(results[0]);
    });
});

// ── BORROW A BOOK ────────────────────────────────────────────
// Body: { BookCopy_ID, Member_ID, Borrow_Date, Due_Date }
// Rules enforced in sp_BorrowBook:
//   1. Member must be Active
//   2. Copy must be Available (Book_Status_ID = 1)
//   3. Member can borrow max 3 books at a time
//   4. Member cannot borrow more than 1 copy of the same book
router.post('/borrow', (req, res) => {
    const { BookCopy_ID, Member_ID, Borrow_Date, Due_Date } = req.body;

    if (!BookCopy_ID || !Member_ID || !Borrow_Date || !Due_Date) {
        return res.json({ status: 'error', message: 'Missing required fields!' });
    }

    // Validate loan duration (1–30 days)
    const borrow = new Date(Borrow_Date);
    const due    = new Date(Due_Date);
    const days   = Math.round((due - borrow) / (1000 * 60 * 60 * 24));

    if (days < 1 || days > 30) {
        return res.json({ status: 'error', message: 'Loan duration must be between 1 and 30 days!' });
    }

    db.query(
        'CALL sp_BorrowBook(?, ?, ?, ?)',
        [BookCopy_ID, Member_ID, Borrow_Date, Due_Date],
        (err, results) => {
            if (err) return res.status(500).json({ status: 'error', message: 'Database error', error: err });
            res.json(results[0][0]);
        }
    );
});

// ── RETURN A BOOK ────────────────────────────────────────────
// :id = BorrowDetails_ID
router.post('/return/:id', (req, res) => {
    const { id } = req.params;
    const Return_Date = new Date().toISOString().split('T')[0];

    db.query('CALL sp_ReturnBook(?, ?)', [id, Return_Date], (err, results) => {
        if (err) return res.status(500).json({ message: 'Error returning book', error: err });
        res.json(results[0][0]);
    });
});

// ── ARCHIVE A TRANSACTION ────────────────────────────────────
router.put('/archive/:id', (req, res) => {
    const { id } = req.params;
    db.query(
        'UPDATE BorrowDetails SET Is_Archived = TRUE WHERE BorrowDetails_ID = ?',
        [id],
        (err) => {
            if (err) return res.json({ status: 'error', message: 'Database error' });
            res.json({ status: 'success', message: 'Transaction archived successfully!' });
        }
    );
});

// ── UNARCHIVE A TRANSACTION ──────────────────────────────────
router.put('/unarchive/:id', (req, res) => {
    const { id } = req.params;
    db.query(
        'UPDATE BorrowDetails SET Is_Archived = FALSE WHERE BorrowDetails_ID = ?',
        [id],
        (err) => {
            if (err) return res.json({ status: 'error', message: 'Database error' });
            res.json({ status: 'success', message: 'Transaction unarchived successfully!' });
        }
    );
});

// ── DELETE ALL ARCHIVED TRANSACTIONS ────────────────────────
router.delete('/archived', (req, res) => {
    db.query('DELETE FROM BorrowDetails WHERE Is_Archived = TRUE', (err) => {
        if (err) return res.json({ status: 'error', message: 'Database error' });
        res.json({ status: 'success', message: 'All archived transactions deleted!' });
    });
});

// ── DELETE A SINGLE ARCHIVED TRANSACTION ────────────────────
router.delete('/:id', (req, res) => {
    const { id } = req.params;
    db.query(
        'DELETE FROM BorrowDetails WHERE BorrowDetails_ID = ? AND Is_Archived = TRUE',
        [id],
        (err) => {
            if (err) return res.json({ status: 'error', message: 'Database error' });
            res.json({ status: 'success', message: 'Transaction deleted!' });
        }
    );
});

module.exports = router;