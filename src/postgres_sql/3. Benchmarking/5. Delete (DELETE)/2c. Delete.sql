-- 2c. Delete Track:
-- Removes the temporary Track row itself, now that both dependent rows
-- in the bridge tables have been deleted. Compares delete cost against
-- the equivalent Neo4j DETACH DELETE, which removes a node and its
-- relationships in a single operation — here Postgres requires three
-- separate, ordered DELETE statements to achieve the same result.
EXPLAIN ANALYZE
DELETE FROM tracks WHERE track_id = 'benchmark_test_002';