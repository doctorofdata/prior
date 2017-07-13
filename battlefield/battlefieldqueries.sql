SHOW VARIABLES LIKE 'SECURE_FILE_PRIV';

USE BATTLEFIELD;

SET SQL_SAFE_UPDATES = 0; 

ALTER TABLE `games` ADD `newcolumn` DATE;
UPDATE `games` SET `newcolumn`=STR_TO_DATE(`Date`, '%m/%d/%y');

ALTER TABLE GAMES
DROP DATE;
ALTER TABLE GAMES
CHANGE NEWCOLUMN DATE DATE;

SELECT * 
FROM GAMES;

-- CREATE TABLES 
CREATE TABLE IF NOT EXISTS WINS AS
	SELECT *
    FROM GAMES
    WHERE OUTCOME = 'VICTORY';

SELECT * FROM WINS;

CREATE TABLE IF NOT EXISTS LOSSES AS
	SELECT * 
    FROM GAMES
    WHERE OUTCOME = 'DEFEAT';
    
SELECT * FROM LOSSES;

CREATE TABLE IF NOT EXISTS MAPS AS
	SELECT GAME_ID,
		   MAP,
           OUTCOME,
           SCORE
	FROM GAMES;

SELECT * FROM MAPS;

drop table maps;

CREATE TABLE IF NOT EXISTS CLASSES AS 
	SELECT GAME_ID,
		   TYPE AS CLASS,
		   OUTCOME,
           SCORE
	FROM GAMES;

SELECT * FROM CLASSES;

-- Win/Loss record
(SELECT COUNT(*),
	   AVG(SCORE)
FROM GAMES
WHERE OUTCOME = 'VICTORY')
UNION
(SELECT COUNT(*),
       AVG(SCORE)
FROM GAMES
WHERE OUTCOME = 'DEFEAT');

-- SCORE SUMMARY *
SELECT MIN(SCORE) AS 'MIN', 
	   MAX(SCORE) AS 'MAX', 
       AVG(SCORE) AS 'AVG'
FROM GAMES;

-- SCORE BY CLASS
SELECT TYPE AS 'CLASS',
	   COUNT(TYPE) AS 'GAMES',
	   AVG(SCORE) AS 'AVERAGE SCORE',
	   SUM(SCORE) AS 'TOTAL SCORE'
FROM GAMES
GROUP BY TYPE;

-- OUTCOME BY CLASS
(SELECT TYPE AS 'ASSAULT',
	   COUNT(*) AS 'WINS/LOSSES',
       AVG(SCORE)
FROM GAMES
WHERE TYPE='ASSAULT' AND OUTCOME='VICTORY')
UNION
(SELECT TYPE AS 'ASSAULT',
	   COUNT(*) AS 'WINS/LOSSES',
       AVG(SCORE)
FROM GAMES
WHERE TYPE='ASSAULT' AND OUTCOME='DEFEAT');

(SELECT TYPE AS 'MEDIC',
	   COUNT(*) AS 'WINS/LOSSES',
       AVG(SCORE)
FROM GAMES
WHERE TYPE='MEDIC' AND OUTCOME='VICTORY')
UNION
(SELECT TYPE AS 'MEDIC',
	   COUNT(*) AS 'WINS/LOSSES',
       AVG(SCORE)
FROM GAMES
WHERE TYPE='MEDIC' AND OUTCOME='DEFEAT');

(SELECT TYPE AS 'SCOUT',
	   COUNT(*) AS 'WINS/LOSSES',
       AVG(SCORE)
FROM GAMES
WHERE TYPE='SCOUT' AND OUTCOME='VICTORY')
UNION
(SELECT TYPE AS 'SCOUT',
	   COUNT(*) AS 'WINS/LOSSES',
       AVG(SCORE)
FROM GAMES
WHERE TYPE='SCOUT' AND OUTCOME='DEFEAT');

-- SCORE BY MAP
SELECT MAP,
	   COUNT(MAP) AS 'GAMES',
       AVG(SCORE) AS 'AVERAGE SCORE',
       SUM(SCORE) AS 'TOTAL SCORE'
FROM GAMES
GROUP BY MAP;

-- OUTCOME BY MAP
SELECT MAP,
	   COUNT(*) AS 'WINS',
       AVG(SCORE)
FROM GAMES
WHERE OUTCOME = 'VICTORY'
GROUP BY MAP;

SELECT MAP,
	   COUNT(*) AS 'LOSSES',
       AVG(SCORE)
FROM GAMES
WHERE OUTCOME = 'DEFEAT'
GROUP BY MAP;

-- BREAKDOWN BY MAP 
SELECT MAP,
	   TYPE,
	   OUTCOME,
       SCORE
FROM GAMES
WHERE MAP = 'AMIENS';

SELECT MAP,
	   TYPE,
	   OUTCOME,
       SCORE
FROM GAMES
WHERE MAP = 'ARGONNE FOREST';

SELECT MAP,
       TYPE,
	   OUTCOME,
       SCORE
FROM GAMES
WHERE MAP = 'BALLROOM BLITZ';

SELECT MAP,
	   TYPE,
	   OUTCOME,
       SCORE
FROM GAMES
WHERE MAP LIKE '%EMPIRE%';

SELECT MAP,
       TYPE,
	   OUTCOME,
       SCORE
FROM GAMES
WHERE MAP = 'FAO FORTRESS';

SELECT MAP,
       TYPE,
	   OUTCOME,
       SCORE
FROM GAMES
WHERE MAP LIKE '%GIANT%';

SELECT MAP,
       TYPE,
	   OUTCOME,
       SCORE
FROM GAMES
WHERE MAP = 'MONTE GRAPPA';

SELECT MAP,
       TYPE,
	   OUTCOME,
       SCORE
FROM GAMES
WHERE MAP = 'SINAI DESERT';

SELECT MAP,
	   TYPE,
	   OUTCOME,
       SCORE
FROM GAMES
WHERE MAP = 'ST QUENTIN SCAR';

SELECT MAP,
       TYPE,
	   OUTCOME,
       SCORE
FROM GAMES
WHERE MAP = 'SUEZ';

DROP SCHEMA BATTLEFIELD;

