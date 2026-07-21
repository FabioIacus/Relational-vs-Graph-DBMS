# Relational vs Graph DBMS
 
A comparative performance analysis between **PostgreSQL** (relational) and **Neo4j** (graph) using the **Spotify Tracks Dataset**, evaluating how the data model affects query execution, data manipulation, and scalability.
 
---
 
## Data Models
 
**PostgreSQL**: normalized schema with `tracks`, `artists`, `genres`, and bridge tables (`track_artist_map`, `track_genre_map`) for many-to-many relationships.
 
**Neo4j**: `Track`, `Artist`, `Genre` nodes connected via native `PERFORMED_BY` and `BELONGS_TO_GENRE` relationships, without bridge tables.
 
---
 
## Dataset
 
Spotify Tracks Dataset (Kaggle), preprocessed and normalized into separate CSV files per entity (tracks, artists, genres, mapping tables).
 
---
 
## Repository Structure
 
```
.
├── data/                  # preprocessed CSV files
├── src/
│   ├── preprocess.py
│   ├── analyzedata.py
│   └── postgres_sql/      # loading, visualization, benchmarking
└── README.md
```
 
`preprocess.py` generates the CSV files; `postgres_sql/` contains the SQL scripts organized into loading, exploration, and benchmarking (read/write/update/delete).
 
---
 
## Benchmark Methodology
 
Comparison across 4 operation types: **read, insert, update, delete**, with execution plans collected via `EXPLAIN ANALYZE` (Postgres) and `PROFILE` (Neo4j).
 
Read queries include: point lookup, content-based recommendation, artist prolificacy, global aggregation, multi-hop analysis, and "degrees of separation".
 
---
 
## Technologies
 
PostgreSQL, Neo4j, SQL, Cypher, Python
 
---
 
**Author**: Fabio Iacus - Software Engineering Student
