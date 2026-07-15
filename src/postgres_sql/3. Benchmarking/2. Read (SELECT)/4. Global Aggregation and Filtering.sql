-- Global Aggregation and Filtering:
-- Calculates the average popularity of genres containing more than 50 tracks.
-- Requires scanning the full track_genre_map join, regardless of starting point —
-- the same scenario where the graph's index-free adjacency offered little
-- advantage on the Neo4j side.
EXPLAIN ANALYZE
SELECT g.genre_name, round(avg(t.popularity)::numeric, 2) AS avg_pop, count(*) AS total_tracks
FROM genres g
JOIN track_genre_map tg ON g.genre_id = tg.genre_id
JOIN tracks t ON tg.track_id = t.track_id
GROUP BY g.genre_name
HAVING count(*) > 50
ORDER BY avg_pop DESC
LIMIT 5;