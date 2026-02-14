<?php
/**
 * Virtual India - Authentication Module
 * Handles user authentication, sessions, and authorization
 */

session_start();
require_once __DIR__ . '/../config/database.php';

/**
 * Register a new user
 * @param string $name User's full name
 * @param string $email User's email
 * @param string $password Plain text password
 * @return array Result with success status and message
 */
function registerUser($name, $email, $password) {
    $conn = getConnection();
    
    // Check if email already exists
    $email = sanitize($conn, $email);
    $checkQuery = "SELECT id FROM users WHERE email = '$email'";
    $result = $conn->query($checkQuery);
    
    if ($result->num_rows > 0) {
        closeConnection($conn);
        return ['success' => false, 'message' => 'Email already registered'];
    }
    
    // Hash password and insert user
    $name = sanitize($conn, $name);
    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
    
    $insertQuery = "INSERT INTO users (name, email, password) VALUES ('$name', '$email', '$hashedPassword')";
    
    if ($conn->query($insertQuery)) {
        closeConnection($conn);
        return ['success' => true, 'message' => 'Registration successful'];
    } else {
        closeConnection($conn);
        return ['success' => false, 'message' => 'Registration failed'];
    }
}

/**
 * Authenticate user login
 * @param string $email User's email
 * @param string $password Plain text password
 * @return array Result with success status, message, and user data
 */
function loginUser($email, $password) {
    $conn = getConnection();
    $email = sanitize($conn, $email);
    
    $query = "SELECT id, name, email, password, role, language_pref FROM users WHERE email = '$email'";
    $result = $conn->query($query);
    
    if ($result->num_rows === 1) {
        $user = $result->fetch_assoc();
        
        if (password_verify($password, $user['password'])) {
            // Set session variables
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['user_name'] = $user['name'];
            $_SESSION['user_email'] = $user['email'];
            $_SESSION['user_role'] = $user['role'];
            $_SESSION['language'] = $user['language_pref'];
            $_SESSION['logged_in'] = true;
            
            closeConnection($conn);
            return ['success' => true, 'message' => 'Login successful', 'user' => [
                'id' => $user['id'],
                'name' => $user['name'],
                'email' => $user['email'],
                'role' => $user['role'],
                'language' => $user['language_pref']
            ]];
        }
    }
    
    closeConnection($conn);
    return ['success' => false, 'message' => 'Invalid email or password'];
}

/**
 * Logout user
 */
function logoutUser() {
    session_unset();
    session_destroy();
}

/**
 * Check if user is logged in
 * @return bool
 */
function isLoggedIn() {
    return isset($_SESSION['logged_in']) && $_SESSION['logged_in'] === true;
}

/**
 * Check if user is admin
 * @return bool
 */
function isAdmin() {
    return isLoggedIn() && isset($_SESSION['user_role']) && $_SESSION['user_role'] === 'admin';
}

/**
 * Get current user ID
 * @return int|null
 */
function getCurrentUserId() {
    return $_SESSION['user_id'] ?? null;
}

/**
 * Get current language preference
 * @return string 'en' or 'hi'
 */
function getLanguage() {
    return $_SESSION['language'] ?? 'en';
}

/**
 * Set language preference
 * @param string $lang 'en' or 'hi'
 */
function setLanguage($lang) {
    if (in_array($lang, ['en', 'hi'])) {
        $_SESSION['language'] = $lang;
        
        // Update in database if logged in
        if (isLoggedIn()) {
            $conn = getConnection();
            $userId = getCurrentUserId();
            $conn->query("UPDATE users SET language_pref = '$lang' WHERE id = $userId");
            closeConnection($conn);
        }
    }
}

/**
 * Require user to be logged in
 * Redirects to login page if not authenticated
 */
function requireLogin() {
    if (!isLoggedIn()) {
        header('Location: /pratiksha06/pages/login.html');
        exit;
    }
}

/**
 * Require admin access
 * Redirects to home page if not admin
 */
function requireAdmin() {
    if (!isAdmin()) {
        header('Location: /pratiksha06/index.html');
        exit;
    }
}
?>
