-- Write Benchmark (3/3): Connects the new Track to an existing Genre.
-- Run individually to capture its own execution plan.
EXPLAIN ANALYZE
INSERT INTO track_genre_map (track_id, genre_id)
SELECT 'benchmark_test_001', genre_id FROM genres WHERE genre_name = 'pop' LIMIT 1;