-- Create indexes
CREATE INDEX idx_artist_name ON public.artists (artist_name);
CREATE INDEX idx_track_name ON public.tracks (track_name);