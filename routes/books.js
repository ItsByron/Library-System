const express = require('express');
const router  = express.Router();
const db      = require('../db');

//CRUD OPERATION FOR BOOK (Create - READ - UPDATE - DELETE)

// METHOD PANG DISPLAY NG MGA BOOK
router.get('/', (req, res) => {
    db.query(
        'CALL sp_GetAllBooks()',
        (err, results) => {
            if (err) {
                res.status(500).json({ 
                    message: 'Error getting books', 
                    error: err 
                });
                return;
            }
            res.json(results[0]);
        }
    );
});

// METHOD PANG ADD NG BAGONG BOOK
router.post('/', (req, res) => {
    const { Title, Author, Isbn, Genre, Year } = req.body;
    db.query(
        'CALL sp_AddBook(?, ?, ?, ?, ?)',
        [Title, Author, Isbn, Genre, Year],
        (err, results) => {
            if (err) {
                res.status(500).json({ 
                    message: 'Error adding book', 
                    error: err 
                });
                return;
            }
            res.json({ message: 'Book added successfully!' });
        }
    );
});


// METHOD PANG UPDATE NG INFO SA BOOK (Itong part ay wala pa sa UI)
router.put('/', (req, res) => {
    const { Book_ID, Title, Author, 
            Isbn, Genre, Year } = req.body;
    db.query(
        'CALL sp_UpdateBook(?, ?, ?, ?, ?, ?)',
        [Book_ID, Title, Author, Isbn, Genre, Year],
        (err, results) => {
            if (err) {
                res.status(500).json({ 
                    message: 'Error updating book', 
                    error: err 
                });
                return;
            }
            res.json({ message: 'Book updated successfully!' });
        }
    );
});

// METHOD PANG DELETE NG EXISTING NA BOOK
router.delete('/:id', (req, res) => {
    const { id } = req.params;
    db.query(
        'CALL sp_DeleteBook(?)',
        [id],
        (err, results) => {
            if (err) {
                if (err.sqlState === '45000') {
                    res.status(400).json({ 
                        message: err.sqlMessage
                    });
                } else {
                    res.status(500).json({ 
                        message: 'Error deleting book', 
                        error: err 
                    });
                }
                return;
            }
            res.json({ message: 'Book deleted successfully!' });
        }
    );
});

module.exports = router;