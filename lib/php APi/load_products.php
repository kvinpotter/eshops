<?php

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

$servername = "127.0.0.1";
$username = "root";
$password = "";
$dbname = "ellipsis_db";

$conn = new mysqli($servername, $username, $password, $dbname);

// Check for connection errors
if ($conn->connect_error) {
    die(json_encode(array('error' => 'Connection failed: ' . $conn->connect_error)));
}

$sql = "SELECT * FROM product_information";
$result = $conn->query($sql);

// Check for SQL errors
if ($result === false) {
    die(json_encode(array('error' => 'Query failed: ' . $conn->error)));
}

$products = array();

// Fetch the data from the result set
while ($row = $result->fetch_assoc()) {
    $products[] = $row;
}

// Check for empty result set
if (empty($products)) {
    die(json_encode(array('error' => 'No products found')));
}

// Output the JSON-encoded array
echo json_encode($products);

$conn->close();

?>
