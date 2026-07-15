-- Load artists
COPY artists FROM 'C:/temp/artists.csv' WITH (FORMAT csv, HEADER true);