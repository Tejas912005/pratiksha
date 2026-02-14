<?php
/**
 * Virtual India - Database Configuration
 * Database connection settings for MySQL via XAMPP or Docker
 */

define('DB_HOST', getenv('DB_HOST') ?: 'localhost');
define('DB_USER', getenv('DB_USER') ?: 'root');
define('DB_PASS', getenv('DB_PASS') !== false ? getenv('DB_PASS') : '');
define('DB_NAME', getenv('DB_NAME') ?: 'virtual_india');

/**
 * Create database connection
 * @return mysqli Database connection object
 */
function getConnection() {
    $conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
    
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    
    $conn->set_charset("utf8mb4");
    return $conn;
}

/**
 * Close database connection
 * @param mysqli $conn Database connection object
 */
function closeConnection($conn) {
    if ($conn) {
        $conn->close();
    }
}

/**
 * Sanitize input to prevent SQL injection
 * @param mysqli $conn Database connection
 * @param string $input User input to sanitize
 * @return string Sanitized input
 */
function sanitize($conn, $input) {
    return $conn->real_escape_string(htmlspecialchars(trim($input)));
}
?>
