-- Load track-artist map
COPY track_artist_map FROM 'C:/temp/track_artist_map.csv' WITH (FORMAT csv, HEADER true);