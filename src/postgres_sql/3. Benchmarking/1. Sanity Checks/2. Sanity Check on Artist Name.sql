-- Sanity check: verify whether 'Ed Sheeran' corresponds to a single row 
-- or multiple entries in the artists table.
-- This ensures that the multi-hop and degrees-of-separation benchmark queries
-- can safely start from the artist name alone, avoiding Cartesian product
-- explosions or duplicated traversal results in SQL.
SELECT artist_id, COUNT(*) OVER() AS occurrences
FROM artists
WHERE artist_name = 'Ed Sheeran';