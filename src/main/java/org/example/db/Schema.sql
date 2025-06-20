CREATE DATABASE IF NOT EXISTS complaint_db;

USE complaint_db;

CREATE TABLE IF NOT EXISTS users (
                                     id varchar(10) PRIMARY KEY ,
                                     username VARCHAR(50) UNIQUE NOT NULL,
                                     password VARCHAR(100) NOT NULL,
                                     role ENUM('EMPLOYEE', 'ADMIN') NOT NULL
);

CREATE TABLE IF NOT EXISTS complaints (
                                          id INT PRIMARY KEY AUTO_INCREMENT,
                                          title VARCHAR(100) NOT NULL,
                                          description TEXT NOT NULL,
                                          status ENUM('PENDING', 'IN_PROGRESS', 'RESOLVED') DEFAULT 'PENDING',
                                          remarks TEXT,
                                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                          user_id varchar(10) NOT NULL,
                                          FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);