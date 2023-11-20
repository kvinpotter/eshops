<?php

// order.php

// Set the timezone (replace 'your_timezone' with a valid timezone identifier)
date_default_timezone_set('UTC');

// Receive data from Flutter app
$input_data = file_get_contents('php://input');
$data = json_decode($input_data, true);

// Debugging: Log the received data
error_log("Received data: " . print_r($data, true));

// Extract data
$userName = isset($data['userName']) ? $data['userName'] : '';
$userAddress = isset($data['userAddress']) ? $data['userAddress'] : '';
$paymentDetails = isset($data['paymentDetails']) ? $data['paymentDetails'] : '';
$orderItems = isset($data['orderItems']) ? $data['orderItems'] : '';

// Insert data into the database
$servername = "127.0.0.1";
$username = "root";
$password = "";
$dbname = "ellipsis_db";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get the current timestamp
$orderDate = date('Y-m-d H:i:s');

// Prepare and execute SQL query to insert data
$sql = "INSERT INTO order_information (user, Address, paymentDetails, orderDate, orderItems) VALUES ('$userName', '$userAddress', '$paymentDetails', '$orderDate', '$orderItems')";

if ($conn->query($sql) === TRUE) {
    // Database insertion successful
    echo json_encode(['message' => 'Order placed successfully']);
} else {
    // Error in database insertion
    echo json_encode(['error' => 'Error placing order: ' . $conn->error]);
}

// Close the database connection
$conn->close();

?>
