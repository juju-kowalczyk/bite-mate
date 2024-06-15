-- sql/init.sql
CREATE DATABASE IF NOT EXISTS your_database_name;

USE your_database_name;

CREATE TABLE IF NOT EXISTS users (
                                     id INT AUTO_INCREMENT PRIMARY KEY,
                                     username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
    );

CREATE TABLE IF NOT EXISTS orders (
                                      id INT AUTO_INCREMENT PRIMARY KEY,
                                      user_id INT NOT NULL,
                                      description TEXT NOT NULL,
                                      FOREIGN KEY (user_id) REFERENCES users(id)
    );
