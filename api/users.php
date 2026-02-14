<?php
/**
 * Virtual India - User Authentication API
 * Handles login, signup, logout, and language switching
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header('Access-Control-Allow-Headers: Content-Type');

require_once __DIR__ . '/../includes/auth.php';

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);
    $action = $input['action'] ?? '';

    switch ($action) {
        case 'login':
            handleLogin($input);
            break;
        case 'register':
            handleRegister($input);
            break;
        case 'logout':
            handleLogout();
            break;
        case 'set_language':
            handleSetLanguage($input);
            break;
        default:
            echo json_encode(['success' => false, 'message' => 'Invalid action']);
    }
} elseif ($method === 'GET') {
    $action = $_GET['action'] ?? 'status';

    switch ($action) {
        case 'status':
            checkStatus();
            break;
        default:
            echo json_encode(['success' => false, 'message' => 'Invalid action']);
    }
}

function handleLogin($input)
{
    $email = $input['email'] ?? '';
    $password = $input['password'] ?? '';

    if (empty($email) || empty($password)) {
        echo json_encode(['success' => false, 'message' => 'Email and password are required']);
        return;
    }

    $result = loginUser($email, $password);
    echo json_encode($result);
}

function handleRegister($input)
{
    $name = $input['name'] ?? '';
    $email = $input['email'] ?? '';
    $password = $input['password'] ?? '';

    if (empty($name) || empty($email) || empty($password)) {
        echo json_encode(['success' => false, 'message' => 'All fields are required']);
        return;
    }

    if (strlen($password) < 6) {
        echo json_encode(['success' => false, 'message' => 'Password must be at least 6 characters']);
        return;
    }

    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        echo json_encode(['success' => false, 'message' => 'Invalid email format']);
        return;
    }

    $result = registerUser($name, $email, $password);
    echo json_encode($result);
}

function handleLogout()
{
    logoutUser();
    echo json_encode(['success' => true, 'message' => 'Logged out successfully']);
}

function handleSetLanguage($input)
{
    $lang = $input['language'] ?? 'en';
    setLanguage($lang);
    echo json_encode(['success' => true, 'language' => getLanguage()]);
}

function checkStatus()
{
    if (isLoggedIn()) {
        echo json_encode([
            'success' => true,
            'logged_in' => true,
            'user' => [
                'id' => $_SESSION['user_id'],
                'name' => $_SESSION['user_name'],
                'email' => $_SESSION['user_email'],
                'role' => $_SESSION['user_role']
            ],
            'language' => getLanguage()
        ]);
    } else {
        echo json_encode([
            'success' => true,
            'logged_in' => false,
            'language' => getLanguage()
        ]);
    }
}
?>