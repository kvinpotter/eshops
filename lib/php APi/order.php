<?php

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "ellipsis_db";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get data from POST request
$userName = $_POST['userName'];
$userAddress = $_POST['userAddress'];
$paymentDetails = $_POST['paymentDetails'];
$orderItems = $_POST['orderItems'];

// Insert user details into 'order_information' table
$sql = "INSERT INTO order_information (user, address, paymentDetails, orderItems, orderDate) 
        VALUES ('$userName', '$userAddress', '$paymentDetails', '$orderItems', NOW())";

if ($conn->query($sql) === TRUE) {
    echo "Order placed successfully";
} else {
    echo "Error placing order: " . $conn->error;
}

$conn->close();

?>
