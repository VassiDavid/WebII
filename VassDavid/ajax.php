<?php
require_once("database.php");

if($_GET["action"] == 'login') {
    $connection = Database::getInstance();
    $req = $connection->prepare("SELECT * FROM accounts WHERE account_name = :account_name AND account_password = PASSWORD(:account_password) LIMIT 1");
    $req->execute(array('account_name' => $_POST["username"], 'account_password' => $_POST["password"]));
    if($req->rowCount() == 1) {
        $result = $req->fetch();
        session_start();
        $_SESSION["account_id"] = $result["account_id"];
        $_SESSION["account_name"] = $result["account_name"];
        $_SESSION["account_permission"] = $result["account_permission"];
        echo json_encode(array('success' => 1));
    } else {
        echo json_encode(array('success' => 0));
    }
} else if($_GET["action"] == 'registration') {
    $connection = Database::getInstance();
    $req = $connection->prepare("SELECT * FROM accounts WHERE account_name = :account_name OR account_email = :account_email");
    $req->execute(array('account_name' => $_POST["username"], 'account_email' => $_POST["email"]));
    if($req->rowCount() == 0) {
        $req = $connection->prepare("INSERT INTO accounts (account_name, account_password, account_email) VALUES (:account_name, PASSWORD(:account_password), :account_email)");
        $req->execute(array('account_name' => $_POST["username"], 'account_email' => $_POST["email"], 'account_password' => $_POST["password"]));
        if($req->rowCount() == 1) {
            echo json_encode(array('success' => 1));
        } else {
            echo json_encode(array('success' => 0));
        }
    } else {
        echo json_encode(array('success' => 0));
    }
} else if($_GET["action"] == 'logout') {
    session_start();
    session_destroy();
    echo json_encode(array('success' => 1));
} else if($_GET["action"] == 'news_add') {
    session_start();
    $connection = Database::getInstance();
    $req = $connection->prepare("INSERT INTO news (account_id, news_title, news_text, news_date) VALUES (:account_id, :news_title, :news_text, :news_date)");
    $req->execute(array('account_id' => $_SESSION["account_id"], 'news_title' => $_POST["title"], 'news_text' => $_POST["text"], 'news_date' => date("Y-m-d H:i:s")));
    echo json_encode(array('success' => 1));
} else if($_GET["action"] == 'news_get') {
    session_start();
    $connection = Database::getInstance();
    $req = $connection->prepare("SELECT * FROM news JOIN accounts USING(account_id) ORDER BY news_date DESC");
    $req->execute();
    echo json_encode(array('success' => 1, 'news' => $req->fetchAll()));
} 