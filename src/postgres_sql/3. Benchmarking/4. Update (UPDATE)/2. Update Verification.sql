-- Update Benchmark Verification:
-- Spot-checks a few updated tracks to visually confirm that the UPDATE
-- operation was applied correctly before reverting the changes.

EXPLAIN ANALYZE
SELECT t.track_name,
       t.popularity
FROM tracks t
JOIN track_genre_map tgm
    ON t.track_id = tgm.track_id
JOIN genres g
    ON tgm.genre_id = g.genre_id
WHERE g.genre_name = 'pop'
LIMIT 5;