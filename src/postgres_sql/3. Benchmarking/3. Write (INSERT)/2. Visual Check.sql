-- Visual check: retrieves the newly inserted benchmark Track along with its
-- associated Artist and Genre, confirming the write test correctly created
-- both the row and its relationships before running the cleanup.
SELECT
    t.track_id,
    t.track_name,
    t.album_name,
    t.popularity,
    a.artist_name,
    g.genre_name
FROM tracks t
JOIN track_artist_map tam ON t.track_id = tam.track_id
JOIN artists a ON tam.artist_id = a.artist_id
JOIN track_genre_map tgm ON t.track_id = tgm.track_id
JOIN genres g ON tgm.genre_id = g.genre_id
WHERE t.track_id = 'benchmark_test_001';