-- Content-Based Recommendation (Shared Genres):
-- Finds tracks sharing the highest number of genres with a target track
-- ('Shape of You'), via a self-join through the track_genre_map bridge table.
-- Equivalent to the Cypher pattern-matching traversal on the graph side.
EXPLAIN ANALYZE
SELECT t2.track_name AS Recommendation, count(*) AS Shared_Genres
FROM tracks t1
JOIN track_genre_map tg1 ON t1.track_id = tg1.track_id
JOIN track_genre_map tg2 ON tg1.genre_id = tg2.genre_id
JOIN tracks t2 ON tg2.track_id = t2.track_id AND t2.track_id <> t1.track_id
WHERE t1.track_name = 'Shape of You'
GROUP BY t2.track_name
ORDER BY Shared_Genres DESC
LIMIT 10;