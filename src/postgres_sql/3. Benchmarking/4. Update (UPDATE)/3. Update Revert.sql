-- Update Benchmark Revert:
-- Restores the original popularity values, undoing the previous update,
-- to keep the dataset consistent with the source data for subsequent benchmarks.

EXPLAIN ANALYZE
UPDATE tracks
SET popularity = popularity - 1
WHERE track_id IN (
    SELECT tgm.track_id
    FROM track_genre_map tgm
    JOIN genres g
        ON tgm.genre_id = g.genre_id
    WHERE g.genre_name = 'pop'
);