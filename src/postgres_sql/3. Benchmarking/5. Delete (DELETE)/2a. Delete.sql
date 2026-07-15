-- 2a. Delete Track-Artist Relationship:
-- Removes the row connecting the temporary Track to its Artist in the
-- bridge table. Must run before deleting the Track itself, since Postgres
-- enforces referential integrity via foreign key constraints.
EXPLAIN ANALYZE
DELETE FROM track_artist_map WHERE track_id = 'benchmark_test_002';