--
/* Task 1: Database Design */ 
--

-- In this step I am designing a simple Relational Database called FootballDB
CREATE DATABASE FootballDB;

-- Here I am selecting the new FootballDB database to be the one in use for the statements that will follow
USE footballdb;

-- In this step I am creating the tables for the database FootballDB
-- Creating the first table, 'Players'
CREATE TABLE Players (
    PlayerID INT PRIMARY KEY,
    TeamID INT,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Position VARCHAR(50),
    DateOfBirth DATE,
    Nationality VARCHAR(50),
    FOREIGN KEY (TeamID) REFERENCES Teams(TeamID)
);
-- Creating the second table, 'Teams'
CREATE TABLE Teams (
    TeamID INT PRIMARY KEY,
    TeamName VARCHAR(255),
    StadiumID INT,
    FOREIGN KEY (StadiumID) REFERENCES Stadiums(StadiumID)
);
-- Creating the third table, 'Stadiums'
CREATE TABLE Stadiums (
    StadiumID INT PRIMARY KEY,
    StadiumName VARCHAR(255),
    Capacity INT,
    Location VARCHAR(255)
);
-- Creating the fourth table, 'Matches'
CREATE TABLE Matches (
    MatchID INT PRIMARY KEY,
    HomeTeamID INT,
    AwayTeamID INT,
    MatchDate DATE,
    StadiumID INT,
    FOREIGN KEY (HomeTeamID) REFERENCES Teams(TeamID),
    FOREIGN KEY (AwayTeamID) REFERENCES Teams(TeamID),
    FOREIGN KEY (StadiumID) REFERENCES Stadiums(StadiumID)
);

-- Creating the fifth table, 'PlayerStatistics'
CREATE TABLE PlayerStatistics (
    StatID INT,
    PlayerID INT,
    MatchID INT,
    GoalsScored INT,
    Assists INT,
    MinutesPlayed INT,
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID),
    FOREIGN KEY (MatchID) REFERENCES Matches(MatchID)
);

--
/* Task 2: Data Manipulation */
--

/*In these statements I am populating the tables with dummy data based on players from my football team in Portugal, 
and then making changes to introduce other teams and stadiums*/

-- Information for 'Players' table:
INSERT INTO Players (PlayerID, TeamID, FirstName, LastName, Position, DateOfBirth, Nationality) VALUES
	(9, 1, 'Viktor', 'Gyokeres', 'Forward', '1998-06-04', 'Swedish'),
	(8, 1, 'Pedro', 'Goncalves', 'Midfielder', '1998-06-28', 'Portuguese'),
	(72, 2, 'Eduardo', 'Quaresma', 'Defender', '2002-03-02', 'Portuguese'),
	(11, 2, 'Marcus', 'Edwards', 'Winger', '1998-12-03', 'English'),
	(23, 3, 'Daniel', 'Braganca', 'Midfielder', '1999-05-27', 'Portuguese');

-- Information for 'Teams' table
INSERT INTO Teams (TeamID, TeamName, StadiumID) VALUES
	(1, 'Sporting CP', 1),
	(2, 'SC Braga', 2),
    (3, 'Vale Milhacos',3);

-- Information for 'Stadiums' table
INSERT INTO Stadiums (StadiumID, StadiumName, Capacity, Location) VALUES
	(1, 'Alvalade XXI', 60000, 'Lisboa'),
	(2, 'Braga Fort', 74000, 'Braga'),
    (3, 'Corroios Arena', 35000, 'Corroios');

-- Information for 'Matches' table
INSERT INTO Matches (MatchID, HomeTeamID, AwayTeamID, MatchDate, StadiumID) VALUES
	(1, 1, 2, '2024-05-07', 1),
	(2, 2, 1, '2024-05-14', 2),
    (3, 2, 3, '2024-05-21', 2),
    (4, 3, 1, '2024-05-28', 3),
    (5, 3, 2, '2024-06-04', 3),
    (6, 1, 3, '2024-06-12', 1);
    
-- Information for 'PlayerStatistics' table
INSERT INTO PlayerStatistics (StatID, PlayerID, MatchID, GoalsScored, Assists, MinutesPlayed) VALUES
	(1, 9, 1, 3, 0, 90),
	(2, 11, 1, 2, 1, 79),
	(3, 9, 2, 1, 0, 65),
	(4, 72, 3, 2, 0, 90),
	(5, 8, 3, 1, 1, 72),
	(6, 23, 2, 1, 0, 85);

/* In this step, I will create queries to retrieve specific information from the database */

-- This query is to just retrieve the data from the 'Players' table where the players are Portuguese
Select 
	*
From
	Players
Where
	Nationality = 'Portuguese';
    
-- This query is to just retrieve the data from the 'Matches' table where the Stadium was the number 3
Select
	*
From
	Matches
Where
	StadiumID = 3;

/* In this query I will use a JOIN statement, to retrieve the data from both 'Players' and 'PlayerStatistics' tables, 
to see the names of the players that scored more than 1 goal*/
Select
	Players.FirstName, Players.LastName, PlayerStatistics.GoalsScored
From
	Players
Join
	PlayerStatistics On Players.PlayerID = PlayerStatistics.PlayerID
Where
	GoalsScored > 1
Order by
	LastName;

-- 
/* Task 3: Database Modification */
-- 

/* In the next statement, I will change the database structure, by dropping the 'DateOfBirth' column from the 'Players' table */

/* To do this, I will use the ALTER Table statement, selecting the table from which I will remove the column, 
and then use the DROP COLUMN statement, specifying the column that will be deleted */
ALTER TABLE Players
DROP COLUMN DateOfBirth;

/* In this next statement, I will update the number of goals scored by player 9 and also insert a new player in the 'Players' table */
-- Updating the number of Goals Scored for Viktor Gyokeres
UPDATE PlayerStatistics
SET GoalsScored = 7
WHERE PlayerID = 9;

-- Inserting the new player Bruno Fernandes in the 'Players' table
INSERT INTO Players (PlayerID, TeamID, FirstName, LastName, Position, Nationality)
VALUES (18, 3, 'Bruno', 'Fernandes', 'Midfielder', 'Portuguese');

/* In this next section, I will demonstrate the use of DELETE statements */
-- In this statement, I will delete the 'MatchID' = 5 from the 'Matches' table, as we can assume that it was an error and this match did not actually occur
DELETE FROM Matches
WHERE MatchID = 5;
