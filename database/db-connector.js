// ./database/db-connector.js
const dotenv = require("dotenv");
dotenv.config();

// Get an instance of mysql we can use in the app
var mysql = require("mysql2/promise");

// Create a 'connection pool' using the provided credentials
var pool = mysql.createPool({
  connectionLimit: 10,
  host: "containers-us-west-35.railway.app",
  user: "root",
  password: process.env.MYSQL_PASSWORD,
  database: "patient_physician_db",
  port: 7487,
});

// Export it for use in our applicaiton
module.exports.pool = pool;
