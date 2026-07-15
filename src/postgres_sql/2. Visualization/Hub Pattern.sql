-- Hub Pattern:
-- Track as the central entity connecting Artist and Genre.
-- Sample of 30 (Track, Artist, Genre) triads for exploration.
SELECT t.track_id, t.track_name, a.artist_name, g.genre_name
FROM tracks t
JOIN track_artist_map tam ON t.track_id = tam.track_id
JOIN artists a ON tam.artist_id = a.artist_id
JOIN track_genre_map tgm ON t.track_id = tgm.track_id
JOIN genres g ON tgm.genre_id = g.genre_id
LIMIT 30;