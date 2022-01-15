CREATE SCHEMA AnimeDatabase;
USE AnimeDatabase;

/* This table is generally the table that stores the attributes of the anime. Also, anime_id is the primary key.  */
CREATE TABLE anime(
anime_id INT PRIMARY KEY,
anime_name VARCHAR(50) NOT NULL,
studio_id INT,
type_anime VARCHAR(10),
genre VARCHAR(20),
episode_num INT NOT NULL,
duration INT,
source_anime VARCHAR(20),
rating INT
);

/* ALTER operation here is done to insert the studio id, which is a foreign key, into the anime. */

ALTER TABLE anime
ADD FOREIGN KEY (studio_id)
REFERENCES studio(studio_id)
ON DELETE SET NULL;

/* The studio table is the table that holds the animation's studio information and where studio_id is the primary key.  */
CREATE TABLE studio(
studio_id INT PRIMARY KEY,
anime_id INT,
studio_name VARCHAR(20) NOT NULL,
producer_name VARCHAR(30),
licensor_name VARCHAR(20),
CONSTRAINT studio_anime_FK FOREIGN KEY (anime_id) REFERENCES anime (anime_id) ON DELETE CASCADE
);

/* In the date_anime table, the anime_id is both a primary key and a foreign key. The table shows which anime on which date.  */
CREATE TABLE date_anime(
anime_id INT,
anime_status VARCHAR(20),
aired DATE,
premiered VARCHAR(20),
broadcast VARCHAR(20),
PRIMARY KEY(anime_id),
CONSTRAINT date_anime_anime_FK FOREIGN KEY (anime_id) REFERENCES anime (anime_id) ON DELETE CASCADE
);

/* Is there a translation of the published anime in these regions or not (exist or not exist).
and anime_id is both primary and foreign key  */

CREATE TABLE religion_language(
anime_id INT,
japanese VARCHAR(20),
chinese VARCHAR(20),
english VARCHAR(20),
turkish VARCHAR(20),
PRIMARY KEY(anime_id),
CONSTRAINT religion_language_anime_FK FOREIGN KEY (anime_id) REFERENCES anime (anime_id) ON DELETE CASCADE
);

/* The statistic table is the table that stores the statistics of the anime and anime_id serves as both a primary key and a foreign key. */

CREATE TABLE statistic(
anime_id INT,
score DECIMAL(3,2),
ranked INT,
popularity INT,
members INT,
favorites DECIMAL(6,3),
PRIMARY KEY(anime_id),
CONSTRAINT statistic_anime_FK FOREIGN KEY (anime_id) REFERENCES anime (anime_id) ON DELETE CASCADE
);

/* summary stats table stores viewers' statistics and anime_id is both primary key and foreign key  */
CREATE TABLE summary_stats(
anime_id INT,
watching DECIMAL(7,4),
completed INT,
on_hold DECIMAL(7,4),
dropped DECIMAL(7,4),
plan_to_watch DECIMAL(7,4),
total INT,
PRIMARY KEY(anime_id),
CONSTRAINT summary_stats_anime_FK FOREIGN KEY (anime_id) REFERENCES anime (anime_id) ON DELETE CASCADE
);

/* The studio address table stores the address information of the studio, where studio_id is both primary and foreign key.  */
CREATE TABLE studio_adress(
studio_id INT,
city VARCHAR(20),
country VARCHAR(20),
PRIMARY KEY(studio_id),
CONSTRAINT studio_adress_anime_FK FOREIGN KEY (studio_id) REFERENCES studio (studio_id) ON DELETE CASCADE
);

/* The anime characters table stores the main characters and id's of the anime, anime_id here acts as both primary and foreign key.  */
CREATE TABLE anime_characters(
anime_id INT,
main_character_name VARCHAR(20),
PRIMARY KEY(anime_id),
CONSTRAINT anime_characters_anime_FK FOREIGN KEY (anime_id) REFERENCES anime (anime_id) ON DELETE CASCADE
);

/* Voice actors stores the information of those who are voicing the animen characters, and anime_id is both primary and foreign key here.  */
CREATE TABLE voice_actors(
anime_id INT,
main_character_voice_actor VARCHAR(30),
actor_birthday DATE,
member_favorites INT,
PRIMARY KEY(anime_id),
CONSTRAINT voice_actors_anime_FK FOREIGN KEY (anime_id) REFERENCES anime (anime_id) ON DELETE CASCADE
);

/* The music_studio table contains the information of the groups that make the music of the anime, where anime_id works as both primary and foreign key.  */
CREATE TABLE music_studio(
anime_id INT,
singer VARCHAR(30),
band_name VARCHAR(30),
PRIMARY KEY(anime_id),
CONSTRAINT music_studio_anime_FK FOREIGN KEY (anime_id) REFERENCES anime (anime_id) ON DELETE CASCADE
);

/* The reason why UPDATE is used after each row when inserting into the anime table is that, the studio table has not been created yet and therefore 
the studio_id part is initially. It is because it remains NULL. Later, we correct this by UPDATE the NULL part in each row. */

INSERT INTO anime VALUES(1,'Akame ga Kill', NULL , 'TV', 'Fantasy', 24, 23, 'manga', 17);
UPDATE anime
SET studio_id = 10
WHERE anime_id = 1;

INSERT INTO anime VALUES(2,'Naruto', NULL ,'TV', 'Shounen', 220, 23, 'manga', 13);
UPDATE anime
SET studio_id = 20
WHERE anime_id = 2;

INSERT INTO anime VALUES(3,'Hunter X Hunter', NULL , 'TV', 'Action', 148, 23, 'manga', 13);
UPDATE anime
SET studio_id = 30
WHERE anime_id = 3;

INSERT INTO anime VALUES(4,'Ginga Eiyuu Densetsu', NULL , 'TV', 'Military', 110, 23, 'novel', 17);
UPDATE anime
SET studio_id = 40
WHERE anime_id = 4;

INSERT INTO anime VALUES(5,'Death Note', NULL , 'TV', 'Supernatural', 37, 23, 'manga', 17);
UPDATE anime
SET studio_id = 50
WHERE anime_id = 5;

INSERT INTO studio VALUES(10, 1, 'White Fox', 'Square Enix', 'Sentai Filmworks');
INSERT INTO studio VALUES(20, 2, 'Studio Pierrot', 'TV Tokyo', 'VIZ Media');
INSERT INTO studio VALUES(30, 3, 'Madhouse', 'Nippon Television','VIZ Media');
INSERT INTO studio VALUES(40, 4, 'Artland', 'Kitty Films', 'Sentai Filmworks');
INSERT INTO studio VALUES(50, 5, 'Madhouse', 'Konami', 'VIZ Media');

INSERT INTO date_anime VALUES(1, 'Finished Airing', '2014-06-07', 'Summer 2014', 'Monday');
INSERT INTO date_anime VALUES(2, 'Finished Airing', '2002-10-03', 'Fall 2002', 'Thursday');
INSERT INTO date_anime VALUES(3, 'Finished Airing', '2011-10-02', 'Fall 2011', 'Sunday');
INSERT INTO date_anime VALUES(4, 'Finished Airing', '1988-06-08', NULL, NULL);
INSERT INTO date_anime VALUES(5, 'Finished Airing', '2006-10-04', 'Fall 2006', 'Wednesday');

INSERT INTO religion_language VALUES(1,'exist', 'exist', 'exist', 'exist');
INSERT INTO religion_language VALUES(2,'exist', 'exist', 'exist', 'exist');
INSERT INTO religion_language VALUES(3,'exist', 'exist', 'exist', 'exist');
INSERT INTO religion_language VALUES(4,'exist', 'not exist', 'exist', 'exist');
INSERT INTO religion_language VALUES(5,'exist', 'not exist', 'exist', 'exist');

INSERT INTO statistic VALUES(1, 7.49, 1608, 26, 1542137, 21.856);
INSERT INTO statistic VALUES(2, 7.92, 652, 8, 2037156, 54.603);
INSERT INTO statistic VALUES(3, 9.08, 5, 11, 1892667, 146.570);
INSERT INTO statistic VALUES(4, 9.06, 6, 647, 224667, 13.050);
INSERT INTO statistic VALUES(5, 8.63, 61, 1, 2842743, 129.603);

INSERT INTO summary_stats VALUES(1, 70.044, 1191365, 29.052, 49.025, 202.780, 1542266);
INSERT INTO summary_stats VALUES(2, 154.922, 1628762, 68.343, 106.039, 79.295, 2037361);
INSERT INTO summary_stats VALUES(3, 256.856, 1237583, 92.574, 36.433, 269.458, 1892904);
INSERT INTO summary_stats VALUES(4, 27.105, 55342, 15.702, 6.265, 140.284, 244698);
INSERT INTO summary_stats VALUES(5, 137.961, 2353302, 82.267, 87.829, 181.613, 2842972);

INSERT INTO studio_adress VALUES(10, 'london', 'England');
INSERT INTO studio_adress VALUES(20, 'Berlin', 'Germany');
INSERT INTO studio_adress VALUES(30, 'Ankara', 'Turkey');
INSERT INTO studio_adress VALUES(40, 'Tokyo','Japan');
INSERT INTO studio_adress VALUES(50, 'Kyoto', 'Japan');

INSERT INTO anime_characters VALUES(1, 'Akame');
INSERT INTO anime_characters VALUES(2, 'Naruto');
INSERT INTO anime_characters VALUES(3, 'Gon');
INSERT INTO anime_characters VALUES(4, 'Reinhard');
INSERT INTO anime_characters VALUES(5, 'Light');

INSERT INTO voice_actors VALUES(1, 'Marieke', '1979-06-10', 17);
INSERT INTO voice_actors VALUES(2, 'Takeuchi', '1972-04-05', 4972);
INSERT INTO voice_actors VALUES(3, 'Jackie', NULL, 6);
INSERT INTO voice_actors VALUES(4, 'Horikawa', '1958-01-01', 876);
INSERT INTO voice_actors VALUES(5, 'Miyano', '1983-06-08', 75102);

INSERT INTO music_studio VALUES(1,'Sakura', 'Okihara');
INSERT INTO music_studio VALUES(2, 'Hinata', 'One K');
INSERT INTO music_studio VALUES(3, 'Aria', 'It goes down');
INSERT INTO music_studio VALUES(4, 'Chelsea', 'Katedral');
INSERT INTO music_studio VALUES(5, 'Hana', 'Bullets and roses');

/* Here, combining join, arithmetic functions and group functions, combining anime and studio tables, where the id's are the same. Also, I printed 
the anime_id in decreasing order  */

SELECT anime.anime_id, anime.anime_name, studio.studio_name
FROM anime
JOIN studio
ON 10*(anime.anime_id) = (studio.studio_id)
GROUP BY anime_name
ORDER BY anime_id DESC;

/* Using UPDATE here, I changed the studio name from Madhouse to MadH  */

UPDATE studio
SET studio_name = 'MadH'
WHERE studio_name ='Madhouse';

/* Here, I deleted member favorites less than 100 by doing a DELETE operation in the voice actors table.  */

DELETE FROM voice_actors
WHERE member_favorites < 100;

/* Here I simply wrote the column names in Turkish using ALIAS and GROUP BY.  */
SELECT summary_stats.watching AS izliyor, summary_stats.completed AS tamamlamıs, summary_stats.dropped AS bırakmıs
FROM summary_stats
GROUP BY completed;

/* Here, using SUB-QUERY, I printed the row where the favorite sin is less than 20.  */

SELECT statistic.score, statistic.favorites
FROM statistic
WHERE favorites = (SELECT favorites FROM statistic WHERE favorites < 20.00);



