<?php
session_start();

require_once('database.php');

function menuCreate($parent_id = 0) {
    $permission = 1;
    if(isset($_SESSION["account_permission"])) {
        $permission = $_SESSION["account_permission"] + 1;
    }
        
    $connection = Database::getInstance();
    $req = $connection->prepare("SELECT * FROM menu WHERE menu_permission < :menu_permission AND menu_parent_id = :menu_parent_id ORDER BY menu_order, menu_parent_id");
    $req->execute(array('menu_permission' => $permission, 'menu_parent_id' => $parent_id));
    if ($req->rowCount() > 0) {
        if($parent_id == 0) {
            echo '<ul class="menu">';
        } else {
            echo '<ul class="menu submenu">';
        }
        foreach ($req->fetchAll() as $element) {
            echo '<li>';
            echo '<a href="index.php?page=' . $element["menu_file"] . '">' . $element["menu_title"] . '</a>';
            menuCreate($element["menu_id"]);
            echo '</li>';
        }
        echo '</ul>';
    }
}

?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="css/style.css" type="text/css" />
        <script src="scripts/jquery.min.js"></script>
        <script src="scripts/main_script.js"></script>
        <title>Vehicles</title>
    </head>
    <body>
        <header>
            <?php if(!isset($_SESSION["account_id"])) { ?>
                <a href="index.php?page=login">Login</a> | 
                <a href="index.php?page=registration">Register</a>
            <?php } else { ?>
                <a id="logout-btn" href="#">Logout</a>
            <?php } ?>
        </header>
        <nav>
            <?php
                menuCreate();
            ?>
        </nav>
        <div class="body">
            <?php 
                if(isset($_GET["page"])) {
                    if(file_exists(__DIR__ . "/pages/" . $_GET["page"] . '.php')) {
                        require_once("pages/" . $_GET["page"] . '.php'); 
                    } else {
                        require_once("pages/error.php"); 
                    }
                } else {
                    require_once("pages/home.php");
                }
                
            ?>
        </div>
    </body>
</html>
