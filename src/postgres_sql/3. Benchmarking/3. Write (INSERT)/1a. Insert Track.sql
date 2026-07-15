-- Write Benchmark (1/3): Inserts a new Track row.
-- Part of the Write Benchmark suite — compares write cost against the
-- equivalent Neo4j CREATE operations. Run this statement individually
-- to capture its own execution plan.
EXPLAIN ANALYZE
INSERT INTO tracks (track_id, track_name, album_name, popularity)
VALUES ('benchmark_test_001', 'Benchmark Test Track', 'Benchmark Album', 50);