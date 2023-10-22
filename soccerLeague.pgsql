DROP DATABASE soccerleague_db;
CREATE DATABASE soccerleague_db;
\c soccerleague_db;

Create Table teams (
    team_id SERIAL PRIMARY KEY,
    team_name TEXT NOT NULL,
    team_rank INTEGER NOT NULL
    );

Create Table players (
    player_id Serial PRIMARY KEY,
    first_name  TEXT NOT NULL,
    last_name TEXT NOT NULL,
    team_id INTEGER REFERENCES teams (team_id) ON DELETE SET NULL,
    goals_scored INTEGER
);

CREATE TABLE referees (
    referee_id SERIAL PRIMARY KEY,
    ref_name TEXT NOT NULL
);

CREATE TABLE matches (
    referee_id INTEGER REFERENCES referees (referee_id) ON DELETE SET NULL,
    home_team INTEGER REFERENCES teams (team_id),
    visiting_team INTEGER REFERENCES teams (team_id),
    winning_team INTEGER REFERENCES teams (team_id)
);

INSERT INTO teams (team_name, team_rank)
VALUES
('Manchester United', 1),
('Real Madrid', 2),
('FC Barcelona', 3),
('Bayern Munich', 4),
('Chelsea FC', 5);

INSERT INTO players (first_name, last_name, team_id, goals_scored)
VALUES
('Cristiano', 'Ronaldo', 1, 30),
('Lionel', 'Messi', 3, 28),
('Robert', 'Lewandowski', 4, 35),
('Neymar', 'Jr.', 3, 20),
('Sergio', 'Ramos', 2, 5);

INSERT INTO referees (ref_name)
VALUES
('John Smith'),
('Emily Johnson'),
('Michael Brown'),
('Sarah Davis');

INSERT INTO matches (referee_id, home_team, visiting_team, winning_team)
VALUES
(1, 1, 2, 1),
(2, 3, 4, 3),
(3, 5, 2, 5),
(4, 1, 3, 3),
(1, 4, 5, 4);

SELECT team_id, th.team_name AS home_team, tv.team_name AS visiting_team, tw.team_name AS winning_team, ref_name
FROM matches m  
JOIN teams th ON m.home_team = th.team_id
JOIN teams tv ON m.visiting_team = tv.team_id
JOIN teams tw ON m.winning_team = tw.team_id
JOIN referees ON m.referee_id = referees.referee_id;