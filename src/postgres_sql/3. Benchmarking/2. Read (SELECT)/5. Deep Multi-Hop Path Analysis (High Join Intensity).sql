-- Deep Multi-Hop Path Analysis (High Join Intensity):
-- Finds artists connected to a target artist ('Ed Sheeran') through shared
-- genres across their tracks. Requires 6 explicit joins to express the same
-- 5-hop pattern that Cypher expresses as a single MATCH clause — this is
-- the "join pain" scenario the graph model is designed to avoid.
EXPLAIN ANALYZE
SELECT a2.artist_name AS Similar_Artist, count(DISTINCT t2.track_id) AS Connected_Tracks
FROM artists a1
JOIN track_artist_map tam1 ON a1.artist_id = tam1.artist_id
JOIN tracks t1 ON tam1.track_id = t1.track_id
JOIN track_genre_map tg1 ON t1.track_id = tg1.track_id
JOIN track_genre_map tg2 ON tg1.genre_id = tg2.genre_id
JOIN tracks t2 ON tg2.track_id = t2.track_id AND t2.track_id <> t1.track_id
JOIN track_artist_map tam2 ON t2.track_id = tam2.track_id
JOIN artists a2 ON tam2.artist_id = a2.artist_id AND a2.artist_id <> a1.artist_id
WHERE a1.artist_name = 'Ed Sheeran'
GROUP BY a2.artist_name
ORDER BY Connected_Tracks DESC
LIMIT 10;