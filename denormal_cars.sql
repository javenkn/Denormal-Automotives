DROP USER IF EXISTS denormal_user;
-- Create a new postgres user named denormal_user
CREATE USER denormal_user;

DROP DATABASE IF EXISTS denormal_cars;
-- Create a new database named denormal_cars owned by denormal_user
CREATE DATABASE denormal_cars;
ALTER DATABASE indexed_cars OWNER TO denormal_user;