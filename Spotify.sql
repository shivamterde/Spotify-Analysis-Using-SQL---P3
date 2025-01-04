CREATE TABLE spotify (
    Artist VARCHAR(255),
    Track VARCHAR(255),
    Album VARCHAR(255),
    Album_type VARCHAR(50),
    Danceability FLOAT,
    Energy FLOAT,
    Loudness FLOAT,
    Speechiness FLOAT,
    Acousticness FLOAT,
    Instrumentalness FLOAT,
    Liveness FLOAT,
    Valence FLOAT,
    Tempo FLOAT,
    Duration_min FLOAT,
    Title VARCHAR(255),
    Channel VARCHAR(255),
    Views FLOAT,
    Likes BIGINT,
    Comments BIGINT,
    Licensed BOOLEAN,
    official_video BOOLEAN,
    Stream BIGINT,
    EnergyLiveness FLOAT,
    most_playedon VARCHAR(50)
);

SELECT * FROM spotify

/* Retrieve the names of all tracks that have more than 1 billion streams. */

SELECT track,stream FROM spotify
WHERE stream > 1000000000

/* List all albums along with their respective artists. */

SELECT album,artist FROM spotify

/* Get the total number of comments for tracks where licensed = TRUE */

SELECT track,comments,licensed FROM spotify
WHERE licensed = 'true'

/* Find all tracks that belong to the album type single. */

SELECT track,album_type FROM spotify
WHERE album_type = 'single'

/* Count the total number of tracks by each artist. */

SELECT artist,COUNT(track) AS Total_Track FROM spotify
GROUP BY 1

/* Calculate the average danceability of tracks in each album. */

SELECT album,ROUND(AVG(danceability)::NUMERIC,2) AS average FROM spotify
GROUP BY 1

/* Find the top 5 tracks with the highest energy values. */

SELECT track, energy FROM spotify
ORDER BY energy DESC
LIMIT 5

/* List all tracks along with their views and likes where official_video = TRUE. */

SELECT track,views,likes,official_video FROM spotify
WHERE official_video = True

/* For each album, calculate the total views of all associated tracks */

SELECT album,views FROM spotify
GROUP BY 1,2

/* Retrieve the track names that have been streamed on Spotify more than YouTube. */

SELECT track,most_played_on FROM spotify
WHERE most_played_on = 'Spotify'

/*  Write a query to find tracks where the liveness score is above the average. */
/* Advanced Level */

SELECT track,liveness FROM spotify 
WHERE liveness > (SELECT AVG(liveness) FROM spotify)

/* Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album. */

WITH details AS
(SELECT album,MAX(energy) AS Highest_Energy,MIN(energy) AS Lowest_Energy FROM spotify
GROUP BY 1
)
SELECT album,Round((Highest_Energy - Lowest_Energy)::numeric,2) AS Difference FROM details

/* Find tracks where the energy-to-liveness ratio is greater than 1.2. */

WITH ratio AS
(SELECT track,energy,liveness FROM spotify
WHERE liveness != 0)
SELECT track,energy,liveness,ROUND((energy/liveness)::numeric,2) AS Ratio FROM ratio
WHERE (energy/liveness) > 1.2

/* Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions. */

SELECT track,SUM(likes)OVER(PARTITION BY track ORDER BY views) FROM spotify