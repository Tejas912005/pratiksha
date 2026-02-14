<?php
/**
 * Virtual India - Quiz API
 * Endpoints for quiz questions and score tracking
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header('Access-Control-Allow-Headers: Content-Type');

require_once __DIR__ . '/../config/database.php';

$method = $_SERVER['REQUEST_METHOD'];
$lang = isset($_GET['lang']) && $_GET['lang'] === 'hi' ? 'hi' : 'en';

if ($method === 'GET') {
    $action = $_GET['action'] ?? 'questions';

    switch ($action) {
        case 'questions':
            $limit = intval($_GET['limit'] ?? 10);
            $category = $_GET['category'] ?? null;
            getQuestions($limit, $category, $lang);
            break;
        case 'leaderboard':
            getLeaderboard();
            break;
        default:
            echo json_encode(['error' => 'Invalid action']);
    }
} elseif ($method === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);
    $action = $input['action'] ?? 'submit';

    switch ($action) {
        case 'submit':
            submitScore($input);
            break;
        default:
            echo json_encode(['error' => 'Invalid action']);
    }
}

/**
 * Get quiz questions
 */
function getQuestions($limit, $category, $lang)
{
    $conn = getConnection();

    $questionField = $lang === 'hi' ? 'question_hi' : 'question_en';
    $optionA = $lang === 'hi' ? 'option_a_hi' : 'option_a_en';
    $optionB = $lang === 'hi' ? 'option_b_hi' : 'option_b_en';
    $optionC = $lang === 'hi' ? 'option_c_hi' : 'option_c_en';
    $optionD = $lang === 'hi' ? 'option_d_hi' : 'option_d_en';

    $query = "SELECT id, $questionField as question, $optionA as option_a, $optionB as option_b, 
              $optionC as option_c, $optionD as option_d, correct_option, category 
              FROM quiz_questions";

    if ($category && in_array($category, ['dance', 'art', 'craft', 'festival', 'general'])) {
        $query .= " WHERE category = '$category'";
    }

    $query .= " ORDER BY RAND() LIMIT $limit";

    $result = $conn->query($query);

    $questions = [];
    while ($row = $result->fetch_assoc()) {
        $questions[] = [
            'id' => $row['id'],
            'question' => $row['question'],
            'options' => [
                'A' => $row['option_a'],
                'B' => $row['option_b'],
                'C' => $row['option_c'],
                'D' => $row['option_d']
            ],
            'correct' => $row['correct_option'],
            'category' => $row['category']
        ];
    }

    echo json_encode(['success' => true, 'data' => $questions, 'total' => count($questions)]);
    closeConnection($conn);
}

/**
 * Submit quiz score
 */
function submitScore($input)
{
    $score = intval($input['score'] ?? 0);
    $total = intval($input['total'] ?? 0);
    $userId = intval($input['user_id'] ?? 0);

    if ($total <= 0) {
        echo json_encode(['success' => false, 'message' => 'Invalid quiz data']);
        return;
    }

    $conn = getConnection();

    // If user is logged in, save score
    if ($userId > 0) {
        $query = "INSERT INTO quiz_scores (user_id, score, total_questions) VALUES ($userId, $score, $total)";
        $conn->query($query);
    }

    // Calculate percentage
    $percentage = round(($score / $total) * 100);

    // Generate feedback message
    if ($percentage >= 80) {
        $feedback = "Excellent! You're a true cultural expert!";
        $feedbackHi = "उत्कृष्ट! आप एक सच्चे सांस्कृतिक विशेषज्ञ हैं!";
    } elseif ($percentage >= 60) {
        $feedback = "Great job! You know Indian culture well!";
        $feedbackHi = "शानदार! आप भारतीय संस्कृति को अच्छी तरह जानते हैं!";
    } elseif ($percentage >= 40) {
        $feedback = "Good effort! Keep exploring Indian heritage!";
        $feedbackHi = "अच्छा प्रयास! भारतीय विरासत की खोज जारी रखें!";
    } else {
        $feedback = "Keep learning! India has so much to discover!";
        $feedbackHi = "सीखते रहें! भारत में खोजने के लिए बहुत कुछ है!";
    }

    echo json_encode([
        'success' => true,
        'score' => $score,
        'total' => $total,
        'percentage' => $percentage,
        'feedback' => $feedback,
        'feedback_hi' => $feedbackHi
    ]);
    closeConnection($conn);
}

/**
 * Get quiz leaderboard
 */
function getLeaderboard()
{
    $conn = getConnection();

    $query = "SELECT u.name, qs.score, qs.total_questions, 
              ROUND((qs.score / qs.total_questions) * 100) as percentage,
              qs.taken_at
              FROM quiz_scores qs
              JOIN users u ON qs.user_id = u.id
              ORDER BY percentage DESC, qs.taken_at DESC
              LIMIT 10";

    $result = $conn->query($query);

    $leaderboard = [];
    $rank = 1;
    while ($row = $result->fetch_assoc()) {
        $row['rank'] = $rank++;
        $leaderboard[] = $row;
    }

    echo json_encode(['success' => true, 'data' => $leaderboard]);
    closeConnection($conn);
}
?>