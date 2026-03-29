const express = require('express');
const cors    = require('cors');
const app     = express();

// MIDDLEWARE
app.use(cors());
app.use(express.json());
app.use(express.static('public'));

//ROUTES
app.use('/api/books',        require('./routes/books'));
app.use('/api/members',      require('./routes/members'));
app.use('/api/transactions', require('./routes/transactions'));

// START SERVER
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Server running at:`);
    console.log(`http://localhost:${PORT}`);
});