DROP USER IF EXISTS normal_user;
-- Create a new postgres user named normal_user
CREATE USER normal_user;

DROP DATABASE IF EXISTS normal_cars;
-- Create a new database named normal_cars owned by normal_user
CREATE DATABASE normal_cars;
ALTER DATABASE normal_cars OWNER TO normal_user;

\c normal_cars;
\i scripts/denormal_data.sql;
-- table for all of the makes of the cars
CREATE TABLE make_of_cars (
  make_id SERIAL PRIMARY KEY,
  make_code character varying(125),
  make_title character varying(125)
);

-- table for all of the models of the cars
CREATE TABLE model_of_cars (
  model_id SERIAL PRIMARY KEY,
  model_code character varying(125),
  model_title character varying(125)
);

CREATE TABLE norm_cars (
  id SERIAL PRIMARY KEY,
  make_id INTEGER REFERENCES make_of_cars(make_id),
  model_id INTEGER REFERENCES model_of_cars(model_id),
  year integer
);

-- Create queries to insert all of the data that was in the
-- denormal_cars.car_models table, into the new normalized tables
-- of the normal_cars database.
INSERT INTO make_of_cars (make_code, make_title)
  SELECT DISTINCT make_code, make_title
  FROM car_models;

INSERT INTO model_of_cars (model_code, model_title)
  SELECT DISTINCT model_code, model_title
  FROM car_models;

-- Insert the specific values into the norm_cars table
-- where the make and model code/titles are the same as the
-- car_model.make/model code/titles
INSERT INTO norm_cars (make_id, model_id, year)
  SELECT make_of_cars.make_id, model_of_cars.model_id, car_models.year
  FROM make_of_cars, model_of_cars, car_models
  WHERE make_of_cars.make_code = car_models.make_code
  AND model_of_cars.model_code = car_models.model_code
  AND make_of_cars.make_title = car_models.make_title
  AND model_of_cars.model_title = car_models.model_title;

DROP TABLE IF EXISTS car_models;

-- In normal.sql Create a query to get a list of all make_title values in the
-- car_models table. (should have 71 results)
SELECT DISTINCT make_title
  FROM make_of_cars
  ORDER BY make_title ASC;