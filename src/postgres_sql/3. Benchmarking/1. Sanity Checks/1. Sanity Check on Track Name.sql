-- Sanity check: verify whether 'Shape of You' corresponds to a single row
-- or multiple entries (e.g., remixes, live versions, duplicates), mirroring
-- the same check performed on the Neo4j side before running the recommendation query.
SELECT track_id, album_name, popularity
FROM tracks
WHERE track_name = 'Shape of You';