# Spotify-Analysis-Using-SQL---P3

[Click Here to get Dataset](https://www.kaggle.com/datasets/sanjanchaudhari/spotify-dataset)

![Spotify Logo](https://github.com/najirh/najirh-Spotify-Data-Analysis-using-SQL/blob/main/spotify_logo.jpg)

## Overview
This project involves analyzing a Spotify dataset with various attributes about tracks, albums, and artists using **SQL**. It covers an end-to-end process of normalizing a denormalized dataset, performing SQL queries of varying complexity (easy, medium, and advanced), and optimizing query performance. The primary goals of the project are to practice advanced SQL skills and generate valuable insights from the dataset.

```sql
-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);
```

## 9 Query Question With Solution

### Easy Level
1. Retrieve the names of all tracks that have more than 1 billion streams.
```sql
SELECT track,stream FROM spotify
WHERE stream > 1000000000
```

2. List all albums along with their respective artists.
```sql
SELECT album,artist FROM spotify
```

3. Get the total number of comments for tracks where `licensed = TRUE`.
```sql
SELECT track,comments,licensed FROM spotify
WHERE licensed = 'true'
```
4. Find all tracks that belong to the album type `single`.
```sql
SELECT track,album_type FROM spotify
WHERE album_type = 'single'
```

5. Count the total number of tracks by each artist.
```sql
SELECT artist,COUNT(track) AS Total_Track FROM spotify
GROUP BY 1
```

### Medium Level
1. Calculate the average danceability of tracks in each album.
```sql
SELECT album,ROUND(AVG(danceability)::NUMERIC,2) AS average FROM spotify
GROUP BY 1
```

2. Find the top 5 tracks with the highest energy values.
```sql
SELECT track, energy FROM spotify
ORDER BY energy DESC
LIMIT 5
```

3. List all tracks along with their views and likes where `official_video = TRUE`.
```sql
SELECT track,views,likes,official_video FROM spotify
WHERE official_video = True
```

4. For each album, calculate the total views of all associated tracks.
```sql
SELECT album,views FROM spotify
GROUP BY 1,2
```

5. Retrieve the track names that have been streamed on Spotify more than YouTube.
```sql
SELECT track,most_played_on FROM spotify
WHERE most_played_on = 'Spotify'
```

### Advanced Level

6. Write a query to find tracks where the liveness score is above the average.
```sql
SELECT track,liveness FROM spotify 
WHERE liveness > (SELECT AVG(liveness) FROM spotify)
```

7. **Use a `WITH` clause to calculate the difference between the highest and lowest energy values for tracks in each album.**
```sql
WITH details AS
(SELECT album,MAX(energy) AS Highest_Energy,MIN(energy) AS Lowest_Energy FROM spotify
GROUP BY 1
)
SELECT album,Round((Highest_Energy - Lowest_Energy)::numeric,2) AS Difference FROM details
```
   
8. Find tracks where the energy-to-liveness ratio is greater than 1.2.
```sql
WITH ratio AS
(SELECT track,energy,liveness FROM spotify
WHERE liveness != 0)
SELECT track,energy,liveness,ROUND((energy/liveness)::numeric,2) AS Ratio FROM ratio
WHERE (energy/liveness) > 1.2
```

9. Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.
```sql
SELECT track,SUM(likes)OVER(PARTITION BY track ORDER BY views) FROM spotify
```


