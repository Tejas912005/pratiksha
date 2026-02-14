<?php
/**
 * Virtual India - Regions API
 * Endpoints for fetching regional cultural content
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require_once __DIR__ . '/../config/database.php';

$lang = isset($_GET['lang']) && $_GET['lang'] === 'hi' ? 'hi' : 'en';

$action = $_GET['action'] ?? 'list';

switch ($action) {
    case 'list':
        getRegions($lang);
        break;
    case 'detail':
        $id = intval($_GET['id'] ?? 0);
        getRegionDetail($id, $lang);
        break;
    case 'cultural_items':
        $regionId = intval($_GET['region_id'] ?? 0);
        $category = $_GET['category'] ?? null;
        getCulturalItems($regionId, $category, $lang);
        break;
    default:
        echo json_encode(['error' => 'Invalid action']);
}

/**
 * Get all regions
 */
function getRegions($lang)
{
    $conn = getConnection();

    $nameField = $lang === 'hi' ? 'name_hi' : 'name_en';
    $descField = $lang === 'hi' ? 'description_hi' : 'description_en';
    $statesField = $lang === 'hi' ? 'states_hi' : 'states_en';

    $query = "SELECT id, $nameField as name, $descField as description, $statesField as states, image_url FROM regions";
    $result = $conn->query($query);

    $regions = [];
    while ($row = $result->fetch_assoc()) {
        $regions[] = $row;
    }

    echo json_encode(['success' => true, 'data' => $regions]);
    closeConnection($conn);
}

/**
 * Get region detail with cultural items
 */
function getRegionDetail($id, $lang)
{
    $conn = getConnection();

    $nameField = $lang === 'hi' ? 'name_hi' : 'name_en';
    $descField = $lang === 'hi' ? 'description_hi' : 'description_en';
    $statesField = $lang === 'hi' ? 'states_hi' : 'states_en';

    // Get region
    $query = "SELECT id, $nameField as name, $descField as description, $statesField as states, image_url FROM regions WHERE id = $id";
    $result = $conn->query($query);

    if ($result->num_rows === 0) {
        echo json_encode(['success' => false, 'message' => 'Region not found']);
        closeConnection($conn);
        return;
    }

    $region = $result->fetch_assoc();

    // Get cultural items for this region
    $itemQuery = "SELECT id, category, $nameField as name, $descField as description, image_url FROM cultural_items WHERE region_id = $id";
    $itemResult = $conn->query($itemQuery);

    $items = [];
    while ($row = $itemResult->fetch_assoc()) {
        $items[] = $row;
    }

    $region['cultural_items'] = $items;

    // Get festivals for this region
    $festivalQuery = "SELECT id, $nameField as name, $descField as description, month, image_url FROM festivals WHERE region_id = $id OR region_id IS NULL";
    $festivalResult = $conn->query($festivalQuery);

    $festivals = [];
    while ($row = $festivalResult->fetch_assoc()) {
        $festivals[] = $row;
    }

    $region['festivals'] = $festivals;

    echo json_encode(['success' => true, 'data' => $region]);
    closeConnection($conn);
}

/**
 * Get cultural items with optional filters
 */
function getCulturalItems($regionId, $category, $lang)
{
    $conn = getConnection();

    $nameField = $lang === 'hi' ? 'name_hi' : 'name_en';
    $descField = $lang === 'hi' ? 'description_hi' : 'description_en';
    $regionNameField = $lang === 'hi' ? 'r.name_hi' : 'r.name_en';

    $query = "SELECT c.id, c.category, c.$nameField as name, c.$descField as description, c.image_url, $regionNameField as region_name 
              FROM cultural_items c 
              LEFT JOIN regions r ON c.region_id = r.id 
              WHERE 1=1";

    if ($regionId > 0) {
        $query .= " AND c.region_id = $regionId";
    }

    if ($category && in_array($category, ['art', 'dance', 'craft', 'music', 'cuisine'])) {
        $query .= " AND c.category = '$category'";
    }

    $result = $conn->query($query);

    $items = [];
    while ($row = $result->fetch_assoc()) {
        $items[] = $row;
    }

    echo json_encode(['success' => true, 'data' => $items]);
    closeConnection($conn);
}
?>