-- Degrees of Separation:
-- Finds artists reachable from a target artist ('Ed Sheeran') within a variable
-- number of hops (2 to 6), traversing both the artist-track and track-genre
-- relationships. Requires building a unified edge list across heterogeneous
-- node types (Artist, Track, Genre) and a recursive CTE to express what Cypher
-- handles natively with variable-length path syntax (*2..6). This contrast is
-- the clearest illustration of the join pain the graph model is designed to avoid.
EXPLAIN ANALYZE
WITH RECURSIVE edges AS (
    SELECT artist_id::text AS node, 'Artist' AS node_type, track_id AS neighbor, 'Track' AS neighbor_type FROM track_artist_map
    UNION ALL
    SELECT track_id, 'Track', artist_id::text, 'Artist' FROM track_artist_map
    UNION ALL
    SELECT track_id, 'Track', genre_id::text, 'Genre' FROM track_genre_map
    UNION ALL
    SELECT genre_id::text, 'Genre', track_id, 'Track' FROM track_genre_map
),
reachable AS (
    SELECT a.artist_id::text AS node, 'Artist'::text AS node_type, 0 AS depth
    FROM artists a
    WHERE a.artist_name = 'Ed Sheeran'
    UNION
    SELECT e.neighbor, e.neighbor_type, r.depth + 1
    FROM reachable r
    JOIN edges e ON e.node = r.node AND e.node_type = r.node_type
    WHERE r.depth < 6
)
SELECT DISTINCT a.artist_name
FROM reachable r
JOIN artists a ON a.artist_id::text = r.node AND r.node_type = 'Artist'
WHERE r.depth BETWEEN 2 AND 6
LIMIT 20;