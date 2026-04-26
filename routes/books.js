// const express = require('express');
// const router  = express.Router();
// const db      = require('../db');

// // Get all books 
// router.get('/', (req, res) => {
//     db.query('CALL sp_GetAllBooks()', (err, results) => {
//         if (err) return res.status(500).json({ message: 'Error getting books', error: err });
//         res.json(results[0]);
//     });
// });


// router.get('/search', (req, res) => {
//     const q = req.query.q || '';
//     db.query('CALL sp_SearchBooks(?)', [q], (err, results) => {
//         if (err) return res.status(500).json({ message: 'Error searching books', error: err });
//         res.json(results[0]);
//     });
// });

// // Add a new book

// router.post('/', (req, res) => {
//     const { Title, Author, Isbn, Genre, Year, CopyCount } = req.body;

//     if (!Title || !Author) {
//         return res.json({ status: 'error', message: 'Title and Author are required!' });
//     }

//     db.query(
//         'CALL sp_AddBook(?, ?, ?, ?, ?, ?)',
//         [Title, Author, Isbn || null, Genre, Year || null, CopyCount || 1],
//         (err, results) => {
//             if (err) return res.json({ status: 'error', message: 'Database error' });
//             res.json(results[0][0]);
//         }
//     );
// });

// // Update a book's info

// router.put('/', (req, res) => {
//     const { Book_ID, Title, Author, Isbn, Genre, Year } = req.body;

//     db.query(
//         'CALL sp_UpdateBook(?, ?, ?, ?, ?, ?)',
//         [Book_ID, Title, Author, Isbn || null, Genre, Year || null],
//         (err, results) => {
//             if (err) return res.status(500).json({ message: 'Error updating book', error: err });
//             res.json(results[0][0]);
//         }
//     );
// });

// // Delete a book (blocked if any copies are currently borrowed)
// router.delete('/:id', (req, res) => {
//     const { id } = req.params;
//     db.query('CALL sp_DeleteBook(?)', [id], (err, results) => {
//         if (err) {
//             if (err.sqlState === '45000') {
//                 return res.status(400).json({ message: err.sqlMessage });
//             }
//             return res.status(500).json({ message: 'Error deleting book', error: err });
//         }
//         res.json(results[0][0]);
//     });
// });

// module.exports = router;


const express = require('express');
const router  = express.Router();
const db      = require('../db');

// ── GET ALL BOOKS ────────────────────────────────────────────
router.get('/', (req, res) => {
    db.query('CALL sp_GetAllBooks()', (err, results) => {
        if (err) return res.status(500).json({ message: 'Error getting books', error: err });
        res.json(results[0]);
    });
});

// ── SEARCH BOOKS (query param: ?q=) ─────────────────────────
router.get('/search', (req, res) => {
    const q = req.query.q || '';
    db.query('CALL sp_SearchBooks(?)', [q], (err, results) => {
        if (err) return res.status(500).json({ message: 'Error searching books', error: err });
        res.json(results[0]);
    });
});

// ── ADD BOOK ─────────────────────────────────────────────────
// Body: { Title, Author, Isbn, Genre, Year, CopyCount (optional, default 1) }
router.post('/', (req, res) => {
    const { Title, Author, Isbn, Genre, Year, CopyCount } = req.body;

    if (!Title || !Author) {
        return res.json({ status: 'error', message: 'Title and Author are required!' });
    }

    db.query(
        'CALL sp_AddBook(?, ?, ?, ?, ?, ?)',
        [Title, Author, Isbn || null, Genre, Year || null, CopyCount || 1],
        (err, results) => {
            if (err) return res.json({ status: 'error', message: 'Database error' });
            res.json(results[0][0]);
        }
    );
});

// ── UPDATE BOOK ──────────────────────────────────────────────
// Body: { Book_ID, Title, Author, Isbn, Genre, Year }
router.put('/', (req, res) => {
    const { Book_ID, Title, Author, Isbn, Genre, Year } = req.body;

    db.query(
        'CALL sp_UpdateBook(?, ?, ?, ?, ?, ?)',
        [Book_ID, Title, Author, Isbn || null, Genre, Year || null],
        (err, results) => {
            if (err) return res.status(500).json({ message: 'Error updating book', error: err });
            res.json(results[0][0]);
        }
    );
});

// ── DELETE BOOK ──────────────────────────────────────────────
router.delete('/:id', (req, res) => {
    const { id } = req.params;
    db.query('CALL sp_DeleteBook(?)', [id], (err, results) => {
        if (err) {
            if (err.sqlState === '45000') {
                return res.status(400).json({ message: err.sqlMessage });
            }
            return res.status(500).json({ message: 'Error deleting book', error: err });
        }
        res.json(results[0][0]);
    });
});

module.exports = router;