-- from the terminal run:
-- psql < air_traffic.sql
--THIS schema can be improved by breaking down this large table into smaller tables.  That way we have a table of airlines, cities, and countries that can be maintained seperately from the flight info table.  We can then refer the flight info to smaller referenced tables for the airlines, passengers, countries, and cities.  By breaking down the schema into smaller, related tables and establishing foreign key relationships, you can achieve a more structured and maintainable database design. It also makes it easier to query and manage data while reducing data redundancy and improving data integrity.
DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic
-- CREATE TABLE flight_num(
--   flight_num SERIAL PRIMARY KEY
-- );



CREATE TABLE airlines (
  airline_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE cities(
  city_id SERIAL PRIMARY KEY,
  city_name TEXT NOT NULL
);

CREATE TABLE countries(
  country_id SERIAL PRIMARY KEY,
  country_name TEXT NOT NULL
);

CREATE TABLE passengers (
  passenger_id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  seat_assignment TEXT NOT NULL UNIQUE
);

CREATE TABLE flight_info(
  id SERIAL PRIMARY KEY,
  passenger INTEGER REFERENCES passengers (passenger_id) ON DELETE CASCADE,
  airline INTEGER REFERENCES airlines (airline_id) ON DELETE SET NULL,
  departure TIMESTAMP NOT NULL,
  arrival TIMESTAMP NOT NULL,
  from_city INTEGER REFERENCES cities (city_id) ON DELETE SET NULL,
  from_country INTEGER REFERENCES countries (country_id) ON DELETE SET NULL,
  to_city INTEGER REFERENCES cities (city_id) ON DELETE SET NULL,
  to_country INTEGER REFERENCES countries (country_id) ON DELETE SET NULL
);

INSERT INTO passengers (first_name, last_name, seat_assignment)
VALUES
('Jennifer', 'Finch', '33B'),
('Thadeus', 'Gathercoal', '8A'),
('Sonja', 'Pauley', '12F'),
('Jennifer', 'Finch', '20A'),
('Waneta', 'Skeleton', '23D'),
('Thadeus', 'Gathercoal', '18C'),
('Berkie', 'Wycliff','9E'),
('Alvin', 'Leathes', '1A'),
('Berkie', 'Wycliff','32B'),
('Cory', 'Squibbes', '10D');

INSERT INTO airlines (name)
VALUES
('United'),
('British Airways'),
('Delta'),
('TUI Fly Belgium'),
('Air China'),
('American Airlines'),
('Avianca Brasil');

INSERT INTO cities (city_name)
VALUES
('Washington DC'),
('Tokyo'),
('Los Angeles'),
('Seattle'),
('Paris'),
('Dubai'),
('New York'),
('Cedar Rapids'),
('Charlotte'),
('Sao Paolo'),
('Casablanca'),
('Beijing'),
('London'),
('Las Vegas'),
('Mexico City'),
('Chicago'),
('New Orleans'),
('Santiago');

INSERT INTO countries (country_name)
VALUES
('United States'),
('Japan'),
('France'),
('UAE'),
('Brazil'),
('Morocco'),
('China'),
('United Kingdom'),
('Chile'),
('Mexico')
;

INSERT INTO flight_info (passenger, airline, departure, arrival, from_city, from_country, to_city, to_country)
VALUES
(1, 1, '2018-04-08 09:00:00', '2018-04-08 12:00:00', 1, 1, 4, 1),
(2, 2, '2018-12-19 12:45:00', '2018-12-19 16:15:00', 2, 2, 13, 8),
(3, 3, '2018-01-02 07:00:00', '2018-01-02 08:03:00', 3, 1, 14, 1),
(4, 3, '2018-04-15 16:50:00', '2018-04-15 21:00:00', 4, 1, 15, 10),
(5, 4, '2018-08-01 18:30:00', '2018-08-01 21:50:00', 5, 3, 11, 6),
(6, 5, '2018-10-31 01:15:00', '2018-10-31 12:55:00', 6, 4, 12, 7),
(7, 1, '2019-02-06 06:00:00', '2019-02-06 07:47:00', 7, 1, 9, 1),
(8, 6, '2018-12-22 14:42:00', '2018-12-22 15:56:00', 8, 1, 16, 1),
(9, 6, '2019-02-06 16:28:00', '2019-02-06 19:18:00', 9, 1, 17, 1),
(10, 7, '2019-01-20 19:30:00', '2019-01-20 22:45:00', 10, 5, 18, 9);

SELECT first_name, last_name, seat_assignment, name AS airline, c.city_name AS from_city, cs.country_name AS from_country, ci.city_name AS to_city, co.country_name AS to_country 
FROM flight_info fi
JOIN passengers p ON p.passenger_id = fi.passenger
JOIN airlines a ON a.airline_id = fi.airline
JOIN cities c ON c.city_id = fi.from_city
JOIN countries cs ON cs.country_id = fi.from_country
JOIN cities ci ON ci.city_id = fi.to_city
JOIN countries co ON co.country_id = fi.to_country;

SELECT first_name, last_name, seat_assignment, name AS airline, c.city_name AS from_city, cs.country_name AS from_country, ci.city_name AS to_city, co.country_name AS to_country 
FROM flight_info fi
JOIN passengers p ON p.passenger_id = fi.passenger
JOIN airlines a ON a.airline_id = fi.airline
JOIN cities c ON c.city_id = fi.from_city
JOIN countries cs ON cs.country_id = fi.from_country
JOIN cities ci ON ci.city_id = fi.to_city
JOIN countries co ON co.country_id = fi.to_country
WHERE from_country = 1;