-- Load track-genre map
COPY track_genre_map FROM 'C:/temp/track_genre_map.csv' WITH (FORMAT csv, HEADER true);