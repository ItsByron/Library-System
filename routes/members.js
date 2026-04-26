// const express = require('express');
// const router  = express.Router();
// const db      = require('../db');

// // Get all members
// router.get('/', (req, res) => {
//     db.query('CALL sp_GetAllMembers()', (err, results) => {
//         if (err) return res.status(500).json({ message: 'Error getting members', error: err });
//         res.json(results[0]);
//     });
// });


// router.get('/search', (req, res) => {
//     const q = req.query.q || '';
//     db.query('CALL sp_SearchMembers(?)', [q], (err, results) => {
//         if (err) return res.status(500).json({ message: 'Error searching members', error: err });
//         res.json(results[0]);
//     });
// });

// // Get all borrow records for a specific member 
// router.get('/:id/borrowed', (req, res) => {
//     const { id } = req.params;
//     db.query('CALL sp_GetMemberBorrowedBooks(?)', [id], (err, results) => {
//         if (err) return res.status(500).json({ message: 'Error getting member books', error: err });
//         res.json(results[0]);
//     });
// });

// // Get all fines for a specific member
// router.get('/:id/fines', (req, res) => {
//     const { id } = req.params;
//     db.query('CALL sp_GetMemberFines(?)', [id], (err, results) => {
//         if (err) return res.status(500).json({ message: 'Error getting member fines', error: err });
//         res.json(results[0]);
//     });
// });

// // Add a new member
// router.post('/', (req, res) => {
//     const { Name, Email, Contact_Number } = req.body;

//     if (!Name || !Name.trim()) {
//         return res.json({ status: 'error', message: 'Name is required!' });
//     }

//     const hasEmail   = Email          && Email.trim().length > 0;
//     const hasContact = Contact_Number && Contact_Number.trim().length > 0;

//     if (!hasEmail && !hasContact) {
//         return res.json({ status: 'error', message: 'At least an Email or Contact Number is required!' });
//     }

//     if (hasEmail) {
//         const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
//         if (!emailRegex.test(Email.trim())) {
//             return res.json({ status: 'error', message: 'Invalid email address format!' });
//         }
//     }

//     if (hasContact) {
//         const contactRegex = /^(09|\+639)\d{9}$/;
//         if (!contactRegex.test(Contact_Number.trim())) {
//             return res.json({ status: 'error', message: 'Contact number must be in format 09XXXXXXXXX or +639XXXXXXXXX!' });
//         }
//     }

//     // Check if email or contact is already used
//     const emailCheck = hasEmail
//         ? new Promise((resolve, reject) =>
//             db.query(
//                 'SELECT COUNT(*) AS cnt FROM Members WHERE Email = ?',
//                 [Email.trim()],
//                 (err, r) => err ? reject(err) : resolve(r[0].cnt)
//             ))
//         : Promise.resolve(0);

//     const contactCheck = hasContact
//         ? new Promise((resolve, reject) =>
//             db.query(
//                 'SELECT COUNT(*) AS cnt FROM Members WHERE Contact_Number = ?',
//                 [Contact_Number.trim()],
//                 (err, r) => err ? reject(err) : resolve(r[0].cnt)
//             ))
//         : Promise.resolve(0);

//     Promise.all([emailCheck, contactCheck])
//         .then(([emailCnt, contactCnt]) => {
//             if (emailCnt > 0) {
//                 return res.json({ status: 'error', message: 'Email is already registered!' });
//             }
//             if (contactCnt > 0) {
//                 return res.json({ status: 'error', message: 'Contact number is already registered!' });
//             }

//             const Date_Joined = new Date().toISOString().split('T')[0];
//             db.query(
//                 'CALL sp_AddMember(?, ?, ?, ?)',
//                 [Name.trim(), hasEmail ? Email.trim() : null, hasContact ? Contact_Number.trim() : null, Date_Joined],
//                 (err) => {
//                     if (err) return res.status(500).json({ status: 'error', message: 'Error adding member' });
//                     res.json({ status: 'success', message: 'Member added successfully!' });
//                 }
//             );
//         })
//         .catch(() => res.status(500).json({ status: 'error', message: 'Database error' }));
// });

// // Update member status 
// router.put('/status', (req, res) => {
//     const { Member_ID, Member_Status } = req.body;

//     if (!Member_ID || !Member_Status) {
//         return res.json({ status: 'error', message: 'Member ID and Status are required!' });
//     }

//     db.query('CALL sp_UpdateMemberStatus(?, ?)', [Member_ID, Member_Status], (err) => {
//         if (err) return res.json({ status: 'error', message: 'Error updating status' });
//         res.json({ status: 'success', message: 'Status updated successfully!' });
//     });
// });

// // Update member info
// router.put('/', (req, res) => {
//     const { Member_ID, Name, Email, Contact_Number } = req.body;

//     if (!Name || !Name.trim()) {
//         return res.json({ status: 'error', message: 'Name is required!' });
//     }

//     const hasEmail   = Email          && Email.trim().length > 0;
//     const hasContact = Contact_Number && Contact_Number.trim().length > 0;

//     if (!hasEmail && !hasContact) {
//         return res.json({ status: 'error', message: 'At least an Email or Contact Number is required!' });
//     }

//     db.query(
//         'CALL sp_UpdateMember(?, ?, ?, ?)',
//         [Member_ID, Name.trim(), hasEmail ? Email.trim() : null, hasContact ? Contact_Number.trim() : null],
//         (err, results) => {
//             if (err) return res.status(500).json({ message: 'Error updating member', error: err });
//             res.json(results[0][0] || { status: 'success', message: 'Member updated successfully!' });
//         }
//     );
// });

// // Delete a member 
// // router.delete('/:id', (req, res) => {
// //     const { id } = req.params;
// //             db.query('CALL sp_DeleteMember(?)', [id], (err) => {
// //                 if (results[0].cnt > 0) {
// //                     return res.status(400).json({
// //                         status : 'error',
// //                         message: `Cannot delete member — they have ${results[0].cnt} unreturned book(s)!`
// //                     });
// //                 }
// //                 else if (err) return res.status(500).json({ status: 'error', message: 'Error deleting member' });
// //                 else{
                    
// //                     res.json({ status: 'success', message: 'Member deleted successfully!' });
// //                 }
// //             }); 
// //     // db.query(
// //     //     `SELECT COUNT(*) AS cnt
// //     //      FROM BorrowDetails bd
// //     //      INNER JOIN BorrowRecord br ON bd.Borrow_ID = br.Borrow_ID
// //     //      WHERE br.Member_ID = ? AND bd.Borrow_Status_ID != 2`,
// //     //     [id],
// //     //     (err, results) => {
// //     //         if (err) return res.status(500).json({ status: 'error', message: 'Error checking member' });

// //     //         if (results[0].cnt > 0) {
// //     //             return res.status(400).json({
// //     //                 status : 'error',
// //     //                 message: `Cannot delete member — they have ${results[0].cnt} unreturned book(s)!`
// //     //             });
// //     //         }

// //     //         db.query('CALL sp_DeleteMember(?)', [id], (err) => {
// //     //             if (err) return res.status(500).json({ status: 'error', message: 'Error deleting member' });
// //     //             res.json({ status: 'success', message: 'Member deleted successfully!' });
// //     //         });
// //     //     }
// //     // );
// // });
// router.delete('/:id', (req, res) => {
//     const { id } = req.params;

//     db.query('CALL sp_DeleteMember(?)', [id], (err, results) => {

//         if (err) {
//             return res.status(500).json({
//                 status: 'error',
//                 message: 'Error deleting member'
//             });
//         }

//         const data = results[0][0]; // 🔥 important

//         if (data.unreturned_count > 0) {
//             return res.status(400).json({
//                 status: 'error',
//                 message: `Cannot delete member — they have ${data.unreturned_count} unreturned book(s)!`
//             });
//         }

//         res.json({
//             status: 'success',
//             message: data.message || 'Member deleted successfully!'
//         });
//     });
// });
// router.get('/checkBorrowed/:id', (req, res) => {
//     const { id } = req.params;

//     db.query('CALL sp_CheckBorrowedBooksPerMemberID(?)', [id], (err, results) => {
//         if (err) {
//             return res.status(500).json({ status: 'error' });
//         }

//         const records = results[0];

//         // ✅ Check if ALL are returned
//         const allReturned = records.every(
//             r => r.Borrow_Status_Name === 'Returned'
//         );
 

//         res.json({ allReturned }); // true or false
//     });
// });

// module.exports = router;

const express = require('express');
const router  = express.Router();
const db      = require('../db');

// ── GET ALL MEMBERS ──────────────────────────────────────────
router.get('/', (req, res) => {
    db.query('CALL sp_GetAllMembers()', (err, results) => {
        if (err) return res.status(500).json({ message: 'Error getting members', error: err });
        res.json(results[0]);
    });
});

// ── SEARCH MEMBERS (query param: ?q=) ───────────────────────
router.get('/search', (req, res) => {
    const q = req.query.q || '';
    db.query('CALL sp_SearchMembers(?)', [q], (err, results) => {
        if (err) return res.status(500).json({ message: 'Error searching members', error: err });
        res.json(results[0]);
    });
});

// ── GET BORROWED BOOKS FOR A MEMBER ─────────────────────────
router.get('/:id/borrowed', (req, res) => {
    const { id } = req.params;
    db.query('CALL sp_GetMemberBorrowedBooks(?)', [id], (err, results) => {
        if (err) return res.status(500).json({ message: 'Error getting member books', error: err });
        res.json(results[0]);
    });
});

// ── ADD MEMBER ───────────────────────────────────────────────
router.post('/', (req, res) => {
    const { Name, Email, Contact_Number } = req.body;

    if (!Name) return res.json({ status: 'error', message: 'Name is required!' });

    // Check email uniqueness
    const emailCheck = Email
        ? new Promise((resolve, reject) =>
            db.query(
                'SELECT COUNT(*) AS cnt FROM Members WHERE Email = ?',
                [Email],
                (err, r) => err ? reject(err) : resolve(r[0].cnt)
            ))
        : Promise.resolve(0);

    // Check contact uniqueness
    const contactCheck = Contact_Number
        ? new Promise((resolve, reject) =>
            db.query(
                'SELECT COUNT(*) AS cnt FROM Members WHERE Contact_Number = ?',
                [Contact_Number],
                (err, r) => err ? reject(err) : resolve(r[0].cnt)
            ))
        : Promise.resolve(0);

    Promise.all([emailCheck, contactCheck])
        .then(([emailCnt, contactCnt]) => {
            if (emailCnt > 0) return res.json({ status: 'error', message: 'Email is already registered!' });
            if (contactCnt > 0) return res.json({ status: 'error', message: 'Contact number is already registered!' });

            const Date_Joined = new Date().toISOString().split('T')[0];
            db.query(
                'CALL sp_AddMember(?, ?, ?, ?)',
                [Name, Email || null, Contact_Number || null, Date_Joined],
                (err) => {
                    if (err) return res.status(500).json({ status: 'error', message: 'Error adding member' });
                    res.json({ status: 'success', message: 'Member added successfully!' });
                }
            );
        })
        .catch(() => res.status(500).json({ status: 'error', message: 'Database error' }));
});

// ── UPDATE MEMBER INFO ───────────────────────────────────────
router.put('/', (req, res) => {
    const { Member_ID, Name, Email, Contact_Number } = req.body;

    db.query(
        'CALL sp_UpdateMember(?, ?, ?, ?)',
        [Member_ID, Name, Email || null, Contact_Number || null],
        (err, results) => {
            if (err) return res.status(500).json({ message: 'Error updating member', error: err });
            res.json(results[0][0]);
        }
    );
});

// ── UPDATE MEMBER STATUS ─────────────────────────────────────
// Body: { Member_ID, Member_Status }  — pass status NAME string e.g. "Active"
router.put('/status', (req, res) => {
    const { Member_ID, Member_Status } = req.body;

    db.query(
        'CALL sp_UpdateMemberStatus(?, ?)',
        [Member_ID, Member_Status],
        (err) => {
            if (err) return res.json({ status: 'error', message: 'Error updating status' });
            res.json({ status: 'success', message: 'Status updated successfully!' });
        }
    );
});

// ── DELETE MEMBER ────────────────────────────────────────────
router.delete('/:id', (req, res) => {
    const { id } = req.params;

    db.query(
        'SELECT COUNT(*) AS cnt FROM BorrowDetails WHERE Member_ID = ? AND Return_Date IS NULL',
        [id],
        (err, results) => {
            if (err) return res.status(500).json({ status: 'error', message: 'Error checking member' });

            if (results[0].cnt > 0) {
                return res.status(400).json({
                    status : 'error',
                    message: 'Cannot delete member with borrowed books!'
                });
            }

            db.query('CALL sp_DeleteMember(?)', [id], (err) => {
                if (err) return res.status(500).json({ status: 'error', message: 'Error deleting member' });
                res.json({ status: 'success', message: 'Member deleted successfully!' });
            });
        }
    );
});

module.exports = router;