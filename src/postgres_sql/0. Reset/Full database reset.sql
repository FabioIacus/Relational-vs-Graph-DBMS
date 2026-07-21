-- Full relational schema reset: drops all tables and their dependencies to ensure a clean state.
DROP TABLE IF EXISTS track_artist_map CASCADE;
DROP TABLE IF EXISTS track_genre_map CASCADE;
DROP TABLE IF EXISTS tracks CASCADE;
DROP TABLE IF EXISTS artists CASCADE;
DROP TABLE IF EXISTS genres CASCADE;