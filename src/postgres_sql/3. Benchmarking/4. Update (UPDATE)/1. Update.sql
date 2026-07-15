-- Update Benchmark:
-- Bulk-updates the popularity of all tracks belonging to a specific genre ('pop'),
-- simulating a typical update operation across many related rows.
-- Compares update cost against the equivalent Neo4j update over connected nodes.
-- NOTE: this mutates existing data — run the revert query afterward
-- to restore the original popularity values before executing other read benchmarks.

EXPLAIN ANALYZE
UPDATE tracks
SET popularity = popularity + 1
WHERE track_id IN (
    SELECT tgm.track_id
    FROM track_genre_map tgm
    JOIN genres g
        ON tgm.genre_id = g.genre_id
    WHERE g.genre_name = 'pop'
)
RETURNING track_id;