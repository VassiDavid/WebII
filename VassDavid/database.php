<?php
class Database {
    private static $instance = null;
    
    public static function getInstance() {
        if(!isset(self::$instance)) {
            $pdo_options[PDO::ATTR_ERRMODE] = PDO::ERRMODE_EXCEPTION;
            self::$instance = new PDO('mysql:host=localhost;dbname=database;charset=utf8', 'root', '', $pdo_options);
        }
        return self::$instance;
    }
}