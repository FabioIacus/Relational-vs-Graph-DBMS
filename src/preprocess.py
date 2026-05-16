import os
import pandas as pd

# 1. Load data and remove rows with missing crucial values
df = pd.read_csv(os.path.join('data', 'dataset.csv'))
df = df.dropna(subset=['artists', 'track_name', 'album_name'])

# 2. ARTISTS Management (Explode)
# In the original file, if a track is sung by three artists, the cell under the artists column contains the string "Artist A; Artist B; Artist C"
# A single cell cannot contain multiple values (1NF in relational databases)
# We create a DataFrame for the Track-Artist relationship
df['artists_list'] = df['artists'].str.split(';') # Takes this string and transforms it into an actual list of separated elements: ['Artist A', 'Artist B', 'Artist C']
df_artists_exploded = df.explode('artists_list') # Takes that list and "explodes" the row. If Track 1 had 3 artists, there will now be 3 distinct rows for Track 1, each with a single artist
df_artists_exploded['artists_list'] = df_artists_exploded['artists_list'].str.strip() # Removes any leading/trailing whitespace (e.g., " Artist B" becomes "Artist B")

# ARTISTS Table Creation (Nodes in Neo4j / Table in Postgres)
unique_artists = df_artists_exploded['artists_list'].unique() # Takes all exploded artists and removes duplicates to get a list of unique artists
df_artists_final = pd.DataFrame({'artist_name': unique_artists})
df_artists_final['artist_id'] = range(1, len(df_artists_final) + 1) # Assigns a numeric artist_id to each one (1, 2, 3...)
df_artists_final = df_artists_final[['artist_id', 'artist_name']] # Move artist_id to the first column

# 3. GENRES Management (takes all present musical genres (unique_genres), creates a dedicated new table and assigns a genre_id to each (1, 2, 3...))
# Even if it looks single in the preview, in the full dataset genres vary per track
unique_genres = df['track_genre'].unique()
df_genres_final = pd.DataFrame({'genre_name': unique_genres})
df_genres_final['genre_id'] = range(1, len(df_genres_final) + 1)
df_genres_final = df_genres_final[['genre_id', 'genre_name']] # Move genre_id to the first column

# 4. RELATIONSHIPS Creation (Bridge/Junction Tables)
# Track - Artist Relationship
df_track_artist = df_artists_exploded.merge(df_artists_final, left_on='artists_list', right_on='artist_name') # 'merge' acts like a SQL JOIN query. It takes the "exploded" DataFrame (which has the track_id and artist_name) and cross-references it with the newly created Artists table
df_track_artist = df_track_artist[['track_id', 'artist_id']].drop_duplicates() # In the end, we only keep the IDs. We discard the textual names
# This two-column file (track_id and artist_id) will be the map telling Cypher how to draw the edge between the Track node and the Artist node

# Track - Genre Relationship
df_track_genre = df.merge(df_genres_final, left_on='track_genre', right_on='genre_name')
df_track_genre = df_track_genre[['track_id', 'genre_id']].drop_duplicates()

# 5. Save files for the databases
# For tracks, we remove the "dirty" columns (artists and track_genre)
# because we now have the bridge/relationship tables
df_tracks_final = df.drop(columns=['artists', 'artists_list', 'track_genre', 'Unnamed: 0'], errors='ignore')

# Remove duplicates keeping only one row per track ID.
# Without this, Postgres will throw a Primary Key violation error
df_tracks_final = df_tracks_final.drop_duplicates(subset=['track_id'])

# Ensure track_id is the first column
track_columns = ['track_id'] + [col for col in df_tracks_final.columns if col != 'track_id']
df_tracks_final = df_tracks_final[track_columns]

# Save the DataFrames into physical .csv files, without the Pandas row index (index=False)
os.makedirs('data', exist_ok=True)
df_artists_final.to_csv(os.path.join('data', 'artists.csv'), index=False)
df_genres_final.to_csv(os.path.join('data', 'genres.csv'), index=False)
df_track_artist.to_csv(os.path.join('data', 'track_artist_map.csv'), index=False)
df_track_genre.to_csv(os.path.join('data', 'track_genre_map.csv'), index=False)
df_tracks_final.to_csv(os.path.join('data', 'tracks.csv'), index=False)

print("Pre-processing completed! Files saved in the 'data/' folder.")