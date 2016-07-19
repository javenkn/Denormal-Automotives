DROP USER IF EXISTS normal_user;
-- Create a new postgres user named normal_user
CREATE USER normal_user;

DROP DATABASE IF EXISTS normal_cars;
-- Create a new database named normal_cars owned by normal_user
CREATE DATABASE normal_cars;
ALTER DATABASE normal_cars OWNER TO normal_user;