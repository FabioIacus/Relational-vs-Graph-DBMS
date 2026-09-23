# Relational vs Graph DBMS: A comparative performance analysis
> **Course:** Data Management  
> **Technologies:** PostgreSQL (RDBMS) vs Neo4j (GDBMS)  
> **Dataset:** Spotify Tracks Dataset (Kaggle)

---

## 📌 Executive Summary
This project provides a comprehensive, empirical performance comparison between a traditional Relational Database Management System (**PostgreSQL**) and a native Graph Database Management System (**Neo4j**). 

Using the real-world **Spotify Tracks Dataset**, both technologies were evaluated across the entire data lifecycle:
1. **Data Ingestion & Normalization (ETL)**
2. **Schema & Integrity Constraints Enforcement**
3. **Exploratory & Topological Queries**
4. **Read Benchmarks** (Point Lookups, Content-Based Filtering, Multi-Hop Traversals, Recursive Paths)
5. **Write, Update, and Delete Benchmarks**

The core goal is to assess the architectural trade-offs between relational **B-Tree index scans** (subject to *Join Pain* on dense connections) and native **Index-Free Adjacency** (pointer chasing directly in RAM).

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
