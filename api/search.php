<?php
/**
 * Virtual India - Search API
 * Search across cultural items, festivals, and regions
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require_once __DIR__ . '/../config/database.php';

$query = $_GET['q'] ?? '';
$lang = isset($_GET['lang']) && $_GET['lang'] === 'hi' ? 'hi' : 'en';
$type = $_GET['type'] ?? 'all'; // all, cultural, festival, region

if (strlen($query) < 2) {
    echo json_encode(['success' => false, 'message' => 'Search query too short']);
    exit;
}

$conn = getConnection();
$searchTerm = sanitize($conn, $query);

$results = [
    'cultural_items' => [],
    'festivals' => [],
    'regions' => []
];

$nameField = $lang === 'hi' ? 'name_hi' : 'name_en';
$descField = $lang === 'hi' ? 'description_hi' : 'description_en';

// Search cultural items
if ($type === 'all' || $type === 'cultural') {
    $culturalQuery = "SELECT c.id, c.category, c.$nameField as name, c.$descField as description, c.image_url, 
                      r.$nameField as region_name, 'cultural' as result_type
                      FROM cultural_items c
                      LEFT JOIN regions r ON c.region_id = r.id
                      WHERE c.name_en LIKE '%$searchTerm%' 
                      OR c.name_hi LIKE '%$searchTerm%' 
                      OR c.description_en LIKE '%$searchTerm%'
                      OR c.description_hi LIKE '%$searchTerm%'";

    $culturalResult = $conn->query($culturalQuery);
    while ($row = $culturalResult->fetch_assoc()) {
        $results['cultural_items'][] = $row;
    }
}

// Search festivals
if ($type === 'all' || $type === 'festival') {
    $festivalQuery = "SELECT f.id, f.$nameField as name, f.$descField as description, f.month, f.image_url,
                      r.$nameField as region_name, 'festival' as result_type
                      FROM festivals f
                      LEFT JOIN regions r ON f.region_id = r.id
                      WHERE f.name_en LIKE '%$searchTerm%' 
                      OR f.name_hi LIKE '%$searchTerm%'
                      OR f.description_en LIKE '%$searchTerm%'
                      OR f.description_hi LIKE '%$searchTerm%'";

    $festivalResult = $conn->query($festivalQuery);
    while ($row = $festivalResult->fetch_assoc()) {
        $results['festivals'][] = $row;
    }
}

// Search regions
if ($type === 'all' || $type === 'region') {
    $statesField = $lang === 'hi' ? 'states_hi' : 'states_en';
    $regionQuery = "SELECT id, $nameField as name, $descField as description, $statesField as states, image_url, 'region' as result_type
                    FROM regions
                    WHERE name_en LIKE '%$searchTerm%' 
                    OR name_hi LIKE '%$searchTerm%'
                    OR description_en LIKE '%$searchTerm%'
                    OR description_hi LIKE '%$searchTerm%'
                    OR states_en LIKE '%$searchTerm%'
                    OR states_hi LIKE '%$searchTerm%'";

    $regionResult = $conn->query($regionQuery);
    while ($row = $regionResult->fetch_assoc()) {
        $results['regions'][] = $row;
    }
}

$totalResults = count($results['cultural_items']) + count($results['festivals']) + count($results['regions']);

echo json_encode([
    'success' => true,
    'query' => $query,
    'total' => $totalResults,
    'data' => $results
]);

closeConnection($conn);
?>