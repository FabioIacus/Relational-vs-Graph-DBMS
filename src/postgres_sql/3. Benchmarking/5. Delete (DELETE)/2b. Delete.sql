-- 2b. Delete Track-Genre Relationship:
-- Removes the row connecting the temporary Track to its Genre in the
-- bridge table. Must run before deleting the Track itself, for the same
-- referential integrity reason as above.
EXPLAIN ANALYZE
DELETE FROM track_genre_map WHERE track_id = 'benchmark_test_002';