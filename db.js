require('dotenv').config();
const mysql = require('mysql2');
console.log('Password being used:', process.env.DB_PASSWORD);
console.log('User being used:', process.env.DB_USER);
const connection = mysql.createConnection({
    host    : process.env.DB_HOST,
    port    : process.env.DB_PORT,
    user    : process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
});

connection.connect((err) => {
    if (err) {
        console.log('❌ Database connection failed:', err);
        return;
    }
    console.log('✅ Connected to MySQL database!');
});

module.exports = connection;