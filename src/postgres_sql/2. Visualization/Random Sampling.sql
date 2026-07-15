-- Random Sampling:
-- Retrieving a randomized subset of (Track, Artist, Genre) triads.
-- Useful for live demonstrations to ensure dynamic and diverse visual results.
SELECT t.track_id, t.track_name, a.artist_name, g.genre_name
FROM tracks t
JOIN track_artist_map tam ON t.track_id = tam.track_id
JOIN artists a ON tam.artist_id = a.artist_id
JOIN track_genre_map tgm ON t.track_id = tgm.track_id
JOIN genres g ON tgm.genre_id = g.genre_id
ORDER BY random() -- assigns each row a random value and sorts by it, ensuring a different sample on every run
LIMIT 30;