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
├── data/                                 # preprocessed CSV files
├── src/
│   ├── preprocess.py                     # cleans and normalizes raw records into atomic entities and junction CSV files (tracks, artists, genres, and bridge tables)
│   ├── analyzedata.py                    # performs preliminary Exploratory Data Analysis (EDA) to inspect raw column structures and diagnose unnormalized fields
│   └── postgres_sql/                     # organizes modular SQL scripts covering 3NF schema DDL, bulk COPY loading, sanity checks, and CRUD benchmarking
│   └── neo4j_query_saved_cypher.csv      # stores Cypher scripts organized into uniqueness constraints, LOAD CSV ingestion, topology exploration, and PROFILE benchmarks
└── README.md
```
 
analyzedata.py inspects raw data, preprocess.py outputs normalized CSVs, postgres_sql/ contains the relational pipeline (schema, bulk load, CRUD benchmarks), and neo4j_query_saved_cypher.csv stores equivalent Cypher ingestion and query scripts.
 
---
 
## Benchmark Methodology
 
Comparison across 4 operation types: **read, insert, update, delete**, with execution plans collected via `EXPLAIN ANALYZE` (Postgres) and `PROFILE` (Neo4j).
 
Read queries include: point lookup, content-based recommendation, artist prolificacy, global aggregation, multi-hop analysis, and "degrees of separation".
 
---
 
## Technologies
 
PostgreSQL, Neo4j, SQL, Cypher, Python
 
---
 
**Author**: Fabio Iacus - Software Engineering Student
