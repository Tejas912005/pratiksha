<?php
/**
 * Virtual India - Enhanced Festivals API
 * Endpoints for interactive festival calendar with detailed information
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require_once __DIR__ . '/../config/database.php';

$lang = isset($_GET['lang']) && $_GET['lang'] === 'hi' ? 'hi' : 'en';

$action = $_GET['action'] ?? 'list';

switch ($action) {
    case 'list':
        getFestivals($lang);
        break;
    case 'by_month':
        $month = intval($_GET['month'] ?? date('n'));
        getFestivalsByMonth($month, $lang);
        break;
    case 'detail':
        $id = intval($_GET['id'] ?? 0);
        getFestivalDetail($id, $lang);
        break;
    case 'today':
        getTodaysFestival($lang);
        break;
    case 'upcoming':
        $days = intval($_GET['days'] ?? 30);
        getUpcomingFestivals($days, $lang);
        break;
    case 'by_state':
        $regionId = intval($_GET['region_id'] ?? 0);
        getFestivalsByRegion($regionId, $lang);
        break;
    default:
        echo json_encode(['error' => 'Invalid action']);
}

/**
 * Get all festivals with enhanced details
 */
function getFestivals($lang)
{
    $conn = getConnection();

    $nameField = $lang === 'hi' ? 'f.name_hi' : 'f.name_en';
    $descField = $lang === 'hi' ? 'f.description_hi' : 'f.description_en';
    $historyField = $lang === 'hi' ? 'f.history_hi' : 'f.history_en';
    $ritualsField = $lang === 'hi' ? 'f.rituals_hi' : 'f.rituals_en';
    $foodField = $lang === 'hi' ? 'f.food_hi' : 'f.food_en';
    $dressField = $lang === 'hi' ? 'f.dress_hi' : 'f.dress_en';
    $regionNameField = $lang === 'hi' ? 'r.name_hi' : 'r.name_en';

    $query = "SELECT f.id, $nameField as name, $descField as description, 
              f.month, f.day_of_month, f.image_url, f.color, f.emoji,
              $historyField as history, $ritualsField as rituals, 
              $foodField as food, $dressField as dress,
              f.region_id, $regionNameField as region_name 
              FROM festivals f 
              LEFT JOIN regions r ON f.region_id = r.id 
              ORDER BY f.month, f.day_of_month";
    $result = $conn->query($query);

    $festivals = [];
    while ($row = $result->fetch_assoc()) {
        $festivals[] = $row;
    }

    echo json_encode(['success' => true, 'data' => $festivals]);
    closeConnection($conn);
}

/**
 * Get festivals by month
 */
function getFestivalsByMonth($month, $lang)
{
    $conn = getConnection();

    $nameField = $lang === 'hi' ? 'f.name_hi' : 'f.name_en';
    $descField = $lang === 'hi' ? 'f.description_hi' : 'f.description_en';
    $regionNameField = $lang === 'hi' ? 'r.name_hi' : 'r.name_en';

    $query = "SELECT f.id, $nameField as name, $descField as description, 
              f.month, f.day_of_month, f.image_url, f.color, f.emoji,
              f.region_id, $regionNameField as region_name 
              FROM festivals f 
              LEFT JOIN regions r ON f.region_id = r.id 
              WHERE f.month = $month
              ORDER BY f.day_of_month, f.name_en";
    $result = $conn->query($query);

    $festivals = [];
    while ($row = $result->fetch_assoc()) {
        $festivals[] = $row;
    }

    $monthNames = [
        'en' => ['', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
        'hi' => ['', 'जनवरी', 'फरवरी', 'मार्च', 'अप्रैल', 'मई', 'जून', 'जुलाई', 'अगस्त', 'सितंबर', 'अक्टूबर', 'नवंबर', 'दिसंबर']
    ];

    echo json_encode([
        'success' => true,
        'month' => $month,
        'month_name' => $monthNames[$lang][$month],
        'data' => $festivals
    ]);
    closeConnection($conn);
}

/**
 * Get festival detail with all information
 */
function getFestivalDetail($id, $lang)
{
    $conn = getConnection();

    $nameField = $lang === 'hi' ? 'f.name_hi' : 'f.name_en';
    $descField = $lang === 'hi' ? 'f.description_hi' : 'f.description_en';
    $historyField = $lang === 'hi' ? 'f.history_hi' : 'f.history_en';
    $ritualsField = $lang === 'hi' ? 'f.rituals_hi' : 'f.rituals_en';
    $foodField = $lang === 'hi' ? 'f.food_hi' : 'f.food_en';
    $dressField = $lang === 'hi' ? 'f.dress_hi' : 'f.dress_en';
    $regionNameField = $lang === 'hi' ? 'r.name_hi' : 'r.name_en';

    $query = "SELECT f.id, $nameField as name, $descField as description, 
              f.month, f.day_of_month, f.image_url, f.color, f.emoji,
              $historyField as history, $ritualsField as rituals, 
              $foodField as food, $dressField as dress,
              f.region_id, $regionNameField as region_name 
              FROM festivals f 
              LEFT JOIN regions r ON f.region_id = r.id 
              WHERE f.id = $id";
    $result = $conn->query($query);

    if ($result->num_rows === 0) {
        echo json_encode(['success' => false, 'message' => 'Festival not found']);
        closeConnection($conn);
        return;
    }

    $festival = $result->fetch_assoc();

    $monthNames = [
        'en' => ['', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
        'hi' => ['', 'जनवरी', 'फरवरी', 'मार्च', 'अप्रैल', 'मई', 'जून', 'जुलाई', 'अगस्त', 'सितंबर', 'अक्टूबर', 'नवंबर', 'दिसंबर']
    ];

    $festival['month_name'] = $monthNames[$lang][$festival['month']];

    echo json_encode(['success' => true, 'data' => $festival]);
    closeConnection($conn);
}

/**
 * Get today's festival(s) - for "Today's Festival" widget
 */
function getTodaysFestival($lang)
{
    $conn = getConnection();

    $today = date('n'); // Current month
    $day = date('j'); // Current day

    $nameField = $lang === 'hi' ? 'f.name_hi' : 'f.name_en';
    $descField = $lang === 'hi' ? 'f.description_hi' : 'f.description_en';
    $regionNameField = $lang === 'hi' ? 'r.name_hi' : 'r.name_en';

    $query = "SELECT f.id, $nameField as name, $descField as description, 
              f.month, f.day_of_month, f.image_url, f.color, f.emoji,
              f.region_id, $regionNameField as region_name 
              FROM festivals f 
              LEFT JOIN regions r ON f.region_id = r.id 
              WHERE f.month = $today AND f.day_of_month = $day
              ORDER BY f.name_en";
    $result = $conn->query($query);

    $festivals = [];
    while ($row = $result->fetch_assoc()) {
        $festivals[] = $row;
    }

    // If no exact match, find closest upcoming
    if (empty($festivals)) {
        $upcomingQuery = "SELECT f.id, $nameField as name, $descField as description, 
                          f.month, f.day_of_month, f.image_url, f.color, f.emoji,
                          f.region_id, $regionNameField as region_name 
                          FROM festivals f 
                          LEFT JOIN regions r ON f.region_id = r.id 
                          WHERE (f.month = $today AND f.day_of_month > $day) 
                          OR f.month > $today
                          ORDER BY f.month, f.day_of_month
                          LIMIT 3";
        $upcomingResult = $conn->query($upcomingQuery);

        while ($row = $upcomingResult->fetch_assoc()) {
            $row['is_upcoming'] = true;
            $festivals[] = $row;
        }
    }

    echo json_encode([
        'success' => true,
        'today' => date('Y-m-d'),
        'has_festival_today' => !empty($festivals) && !isset($festivals[0]['is_upcoming']),
        'data' => $festivals
    ]);
    closeConnection($conn);
}

/**
 * Get upcoming festivals within N days
 */
function getUpcomingFestivals($days, $lang)
{
    $conn = getConnection();

    $currentMonth = date('n');
    $currentDay = date('j');

    $nameField = $lang === 'hi' ? 'f.name_hi' : 'f.name_en';
    $descField = $lang === 'hi' ? 'f.description_hi' : 'f.description_en';
    $regionNameField = $lang === 'hi' ? 'r.name_hi' : 'r.name_en';

    // Get festivals in current and next month
    $query = "SELECT f.id, $nameField as name, $descField as description, 
              f.month, f.day_of_month, f.image_url, f.color, f.emoji,
              f.region_id, $regionNameField as region_name 
              FROM festivals f 
              LEFT JOIN regions r ON f.region_id = r.id 
              WHERE (f.month = $currentMonth AND f.day_of_month >= $currentDay)
              OR f.month = $currentMonth + 1
              ORDER BY f.month, f.day_of_month
              LIMIT 10";
    $result = $conn->query($query);

    $festivals = [];
    while ($row = $result->fetch_assoc()) {
        // Calculate days until festival
        $festivalDate = date('Y') . '-' . str_pad($row['month'], 2, '0', STR_PAD_LEFT) . '-' . str_pad($row['day_of_month'] ?? 1, 2, '0', STR_PAD_LEFT);
        $daysUntil = (strtotime($festivalDate) - strtotime(date('Y-m-d'))) / 86400;

        if ($daysUntil >= 0 && $daysUntil <= $days) {
            $row['days_until'] = round($daysUntil);
            $festivals[] = $row;
        }
    }

    echo json_encode(['success' => true, 'data' => $festivals]);
    closeConnection($conn);
}

/**
 * Get festivals by region/state
 */
function getFestivalsByRegion($regionId, $lang)
{
    $conn = getConnection();

    $nameField = $lang === 'hi' ? 'f.name_hi' : 'f.name_en';
    $descField = $lang === 'hi' ? 'f.description_hi' : 'f.description_en';
    $regionNameField = $lang === 'hi' ? 'r.name_hi' : 'r.name_en';

    $whereClause = $regionId > 0 ? "WHERE f.region_id = $regionId OR f.region_id IS NULL" : "";

    $query = "SELECT f.id, $nameField as name, $descField as description, 
              f.month, f.day_of_month, f.image_url, f.color, f.emoji,
              f.region_id, $regionNameField as region_name 
              FROM festivals f 
              LEFT JOIN regions r ON f.region_id = r.id 
              $whereClause
              ORDER BY f.month, f.day_of_month";
    $result = $conn->query($query);

    $festivals = [];
    while ($row = $result->fetch_assoc()) {
        $festivals[] = $row;
    }

    echo json_encode(['success' => true, 'data' => $festivals]);
    closeConnection($conn);
}
?>