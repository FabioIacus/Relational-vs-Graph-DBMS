-- Topology Exploration:
-- Visualizing the immediate neighborhood of Track rows.
-- Retrieves a sample of tracks joined with all their direct connections
-- (both Artist and Genre), regardless of relationship type.
SELECT t.track_id, t.track_name, a.artist_name, g.genre_name
FROM tracks t
LEFT JOIN track_artist_map tam ON t.track_id = tam.track_id
LEFT JOIN artists a ON tam.artist_id = a.artist_id
LEFT JOIN track_genre_map tgm ON t.track_id = tgm.track_id
LEFT JOIN genres g ON tgm.genre_id = g.genre_id
LIMIT 25;