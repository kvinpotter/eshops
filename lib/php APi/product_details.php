<?php

$servername = "127.0.0.1";
$username = "root";
$password = "";
$dbname = "ellipsis_db";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if product_id is set in the request
if (isset($_GET['productId'])) {
    $productId = $_GET['productId'];

    $sql = "SELECT product_id, product_name, product_price, product_description FROM product_information WHERE product_id = $productId";

    $result = $conn->query($sql);

    if ($result === false) {
        die(json_encode(array('error' => 'Query failed: ' . $conn->error)));
    }

    if ($result->num_rows > 0) {
        $product = $result->fetch_assoc();
        echo json_encode($product);
    } else {
        echo json_encode(array('error' => 'No product found for the specified ID'));
    }
} else {
    echo json_encode(array('error' => 'Product ID not provided'));
}


$conn->close();

?>

