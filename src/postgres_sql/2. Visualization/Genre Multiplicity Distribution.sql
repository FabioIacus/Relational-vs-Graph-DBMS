-- Genre Multiplicity Distribution:
-- For each Track, counts how many distinct Genres it is connected to,
-- then aggregates tracks by that count. Confirms that the relational model
-- correctly captures tracks belonging to multiple genres simultaneously,
-- mirroring the same check performed on the Neo4j side.
SELECT count(*) AS num_tracks, num_genres
FROM (
    SELECT track_id, count(genre_id) AS num_genres
    FROM track_genre_map
    GROUP BY track_id
) sub
GROUP BY num_genres
ORDER BY num_genres;