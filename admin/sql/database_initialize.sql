-- create database
CREATE DATABASE plymind_db CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';

-- create user
GRANT ALL PRIVILEGES ON plymind_db.* TO 'plymind_user'@'localhost' IDENTIFIED BY 'plymind_pass';
