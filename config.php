<?php
// Thông tin database InfinityFree
$db_host = 'sql104.infinityfree.com';
$db_user = 'if0_40572983';
$db_pass = 'Ag27Qk5M7j21wJ';
$db_name = 'if0_40572983_clothing_store_db';
$db_port = 3306;

define('DB_HOST', $db_host);
define('DB_USER', $db_user);
define('DB_PASS', $db_pass);
define('DB_NAME', $db_name);
define('DB_PORT', $db_port);

// Kết nối database
function getDBConnection() {
    $conn = mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME, DB_PORT);
    
    if (! $conn) {
        die("Ket noi that bai: " . mysqli_connect_error());
    }
    
    mysqli_set_charset($conn, "utf8mb4");
    return $conn;
}

// Bắt đầu session
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Hàm kiểm tra đăng nhập
function isLoggedIn() {
    return isset($_SESSION['user_id']) && !empty($_SESSION['user_id']);
}

// Hàm redirect
function redirect($url) {
    header("Location: $url");
    exit();
}

// Hàm clean input
function cleanInput($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}

// Thiết lập timezone
date_default_timezone_set('Asia/Ho_Chi_Minh');
?>