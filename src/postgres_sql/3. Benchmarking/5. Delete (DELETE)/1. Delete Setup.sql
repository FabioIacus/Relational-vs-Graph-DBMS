-- Delete Benchmark Setup:
-- Creates a temporary Track row with relationships to Artist and Genre, used
-- exclusively as the target for the delete benchmark below. This mirrors the
-- Write Benchmark setup, but its sole purpose is to be deleted.
EXPLAIN ANALYZE
INSERT INTO tracks (track_id, track_name, album_name, popularity)
VALUES ('benchmark_test_002', 'Delete Benchmark Track', 'Benchmark Album', 50);

EXPLAIN ANALYZE
INSERT INTO track_artist_map (track_id, artist_id)
SELECT 'benchmark_test_002', artist_id FROM artists WHERE artist_name = 'Ed Sheeran' LIMIT 1;

EXPLAIN ANALYZE
INSERT INTO track_genre_map (track_id, genre_id)
SELECT 'benchmark_test_002', genre_id FROM genres WHERE genre_name = 'pop' LIMIT 1;