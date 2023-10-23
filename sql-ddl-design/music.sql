-- from the terminal run:
-- psql < music.sql

DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music

CREATE TABLE songs(
  song_id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  duration_in_seconds INTEGER NOT NULL,
  release_date DATE NOT NULL,
  album TEXT NOT NULL
);

CREATE TABLE artists(
artist_id SERIAL PRIMARY KEY,
name TEXT NOT NULL
);

CREATE TABLE producers(
producer_id SERIAL PRIMARY KEY,
name TEXT NOT NULL
);

CREATE TABLE song_artists(
  song_id INTEGER REFERENCES songs(song_id) ON DELETE CASCADE,
  artist_id INTEGER REFERENCES artists(artist_id) ON DELETE CASCADE
);

CREATE TABLE song_producers(
  song_id INTEGER REFERENCES songs(song_id),
  producer_id INTEGER REFERENCES producers(producer_id) ON DELETE CASCADE
);

INSERT INTO songs (title, duration_in_seconds, release_date, album)
VALUES
  ('MMMBop', 238, '1997-04-15', 'Middle of Nowhere'),
  ('Bohemian Rhapsody', 355, '1975-10-31', 'A Night at the Opera'),
  ('One Sweet Day', 282, '1995-11-14', 'Daydream'),
  ('Shallow', 216, '2018-09-27', 'A Star Is Born'),
  ('How You Remind Me', 223, '2001-08-21', 'Silver Side Up'),
  ('New York State of Mind', 276, '2009-10-20', 'The Blueprint 3'),
  ('Dark Horse', 215, '2013-12-17', 'Prism'),
  ('Moves Like Jagger', 201, '2011-06-21', 'Hands All Over'),
  ('Complicated', 244, '2002-05-14', 'Let Go'),
  ('Say My Name', 240, '1999-11-07', 'The Writing''s on the Wall');

INSERT INTO artists (name)
VALUES
  ('Hanson'),
  ('Queen'),
  ('Mariah Carey'),
  ('Boyz II Men'),
  ('Lady Gaga'),
  ('Bradley Cooper'),
  ('Nickelback'),
  ('Jay Z'),
  ('Alicia Keys'),
  ('Katy Perry'),
  ('Juicy J'),
  ('Maroon 5'),
  ('Christina Aguilera'),
  ('Avril Lavigne'),
  ('Destiny''s Child');

INSERT INTO producers (name)
VALUES
  ('Dust Brothers'),
  ('Stephen Lironi'),
  ('Roy Thomas Baker'),
  ('Walter Afanasieff'),
  ('Benjamin Rice'),
  ('Rick Parashar'),
  ('Al Shux'),
  ('Max Martin'),
  ('Cirkut'),
  ('Shellback'),
  ('Benny Blanco'),
  ('The Matrix'),
  ('Darkchild');

INSERT INTO song_artists (song_id, artist_id)
VALUES
(1,1),
(2,2),
(3,4),
(3,3),
(4,5),
(4,6),
(5,7),
(6,8),
(6,9),
(7,10),
(7,11),
(8,12),
(8,13),
(9,14);

INSERT INTO song_producers (song_id, producer_id)
VALUES
(1,1),
(1,2),
(2,3),
(3,4),
(4,5),
(5,6),
(6,7),
(7,8),
(7,9),
(8,10),
(8,11),
(9,12);

SELECT songs.title, artists.name
FROM songs
JOIN song_artists ON songs.song_id = song_artists.song_id
JOIN artists ON artists.artist_id = song_artists.artist_id;

SELECT songs.title, producers.name
FROM songs
JOIN song_producers ON songs.song_id = song_producers.song_id
JOIN producers ON producers.producer_id = song_producers.producer_id;

SELECT songs.title, artists.name AS artists, producers.name AS producers
FROM songs
JOIN song_artists ON songs.song_id = song_artists.song_id
JOIN artists ON artists.artist_id = song_artists.artist_id
JOIN song_producers ON songs.song_id = song_producers.song_id
JOIN producers ON producers.producer_id = song_producers.producer_id;