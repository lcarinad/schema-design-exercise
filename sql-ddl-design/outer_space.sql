-- from the terminal run:
-- psql < outer_space.sql

DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space

CREATE TABLE planets
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  orbital_period_in_years FLOAT NOT NULL,
  orbits_around TEXT NOT NULL,
  galaxy TEXT NOT NULL
);

CREATE TABLE moons (
  moon_id SERIAL PRIMARY KEY,
  planet_parent INTEGER REFERENCES planets,
  name TEXT NOT NULL
);

INSERT INTO planets
  (name, orbital_period_in_years, orbits_around, galaxy)
VALUES
  ('Earth', 1.00, 'The Sun', 'Milky Way'),
  ('Mars', 1.88, 'The Sun', 'Milky Way'),
  ('Venus', 0.62, 'The Sun', 'Milky Way'),
  ('Neptune', 164.8, 'The Sun', 'Milky Way'),
  ('Proxima Centauri b', 0.03, 'Proxima Centauri', 'Milky Way'),
  ('Gliese 876 b', 0.23, 'Gliese 876', 'Milky Way');

INSERT INTO moons
(planet_parent, name)
VALUES
(1, 'The Moon'),
(2, 'Phobos'),
(2, 'Deimos'), 
(4, 'Naiad'),
(4, 'Thalassa'),
(4, 'Despina'),
(4, 'Galatea'),
(4, 'Larissa'),
(4, 'S/2004 N 1'),
(4, 'Triton'),
(4, 'Nereid'),
(4, 'Halimede'),
(4, 'Sao'),
(4, 'Laomedeia'),
(4, 'Psamathe'),
(4, 'Neso');

SELECT planets.name, orbital_period_in_years, orbits_around, galaxy, planet_parent, moons.name AS moon_name                                                                
FROM planets  
JOIN moons ON moons.planet_parent = planets.id;

SELECT planets.name, orbital_period_in_years, orbits_around, galaxy, planet_parent, moons.name AS moon_name                                                                
FROM planets  
JOIN moons ON moons.planet_parent = planets.id
WHERE planets.name = 'Neptune';

