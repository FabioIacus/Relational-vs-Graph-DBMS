-- Write Benchmark Cleanup:
-- Removes the test row and its relationships, restoring the database
-- to its original state before continuing with further read benchmarks.
DELETE FROM track_artist_map WHERE track_id = 'benchmark_test_001';
DELETE FROM track_genre_map WHERE track_id = 'benchmark_test_001';
DELETE FROM tracks WHERE track_id = 'benchmark_test_001';