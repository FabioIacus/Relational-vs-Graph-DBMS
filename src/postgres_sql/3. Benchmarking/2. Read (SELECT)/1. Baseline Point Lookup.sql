-- Baseline Point Lookup:
-- Retrieves a single Track by its primary key. No joins involved — establishes
-- a baseline cost where neither system's structural advantage (B-Tree index vs
-- index-free adjacency) comes into play, since no relationships are traversed.
EXPLAIN ANALYZE
SELECT track_name, popularity, album_name
FROM tracks
WHERE track_id = '1gLLVtr9kIjmyoRzENZ11w';