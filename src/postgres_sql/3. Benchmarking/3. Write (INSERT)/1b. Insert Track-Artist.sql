-- Write Benchmark (2/3): Connects the new Track to an existing Artist.
-- Run individually to capture its own execution plan.
EXPLAIN ANALYZE
INSERT INTO track_artist_map (track_id, artist_id)
SELECT 'benchmark_test_001', artist_id FROM artists WHERE artist_name = 'Ed Sheeran' LIMIT 1;