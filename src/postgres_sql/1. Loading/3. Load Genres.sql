-- Load genres
COPY genres FROM 'C:/temp/genres.csv' WITH (FORMAT csv, HEADER true);