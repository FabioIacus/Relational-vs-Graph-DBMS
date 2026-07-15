-- Basic Exploration:
-- Retrieving a random sample of 20 rows across Tracks, Artists, and Genres
-- to visually verify the loaded entities before exploring their relationships.
(SELECT 'Track' AS entity_type, track_id AS id, track_name AS name FROM tracks ORDER BY random() LIMIT 7)
UNION ALL
(SELECT 'Artist' AS entity_type, artist_id::text AS id, artist_name AS name FROM artists ORDER BY random() LIMIT 7)
UNION ALL
(SELECT 'Genre' AS entity_type, genre_id::text AS id, genre_name AS name FROM genres ORDER BY random() LIMIT 6);