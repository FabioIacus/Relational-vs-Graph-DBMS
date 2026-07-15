-- Artist Prolificacy:
-- Ranks artists by number of performed tracks. Equivalent to the degree-based
-- aggregation on the graph side, expressed here as a GROUP BY + COUNT
-- over the track_artist_map bridge table.
EXPLAIN ANALYZE
SELECT a.artist_name AS Artist, count(*) AS Num_Tracks
FROM artists a
JOIN track_artist_map tam ON a.artist_id = tam.artist_id
GROUP BY a.artist_name
ORDER BY Num_Tracks DESC
LIMIT 10;