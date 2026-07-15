# Relational vs Graph DBMS

A comparative performance analysis between **Relational Database Management Systems (RDBMS)** and **Graph Database Management Systems (GDBMS)** using the **Spotify Tracks Dataset**.

The project investigates how different data models affect query execution, data manipulation performance, and scalability by implementing the same dataset in:

- **PostgreSQL** as a relational database
- **Neo4j** as a native graph database

The objective is to evaluate the strengths and limitations of both paradigms through a controlled benchmarking methodology.

---

## Project Overview

Modern database systems adopt different approaches depending on whether the main challenge is managing structured attributes or navigating complex relationships.

This project analyzes this trade-off by transforming the Spotify dataset into two different physical models.

### Relational Model (PostgreSQL)

The dataset is normalized into multiple relations:

- `tracks`
- `artists`
- `genres`
- `track_artist_map`
- `track_genre_map`

Many-to-many relationships are represented through bridge tables and foreign keys.

### Graph Model (Neo4j)

The same information is represented as a connected graph.

#### Nodes

- `Track`
- `Artist`
- `Genre`

#### Relationships

- `(:Track)-[:PERFORMED_BY]->(:Artist)`
- `(:Track)-[:BELONGS_TO_GENRE]->(:Genre)`

The graph representation removes intermediate join tables and materializes relationships as native connections.

---

# Dataset

The project uses the **Spotify Tracks Dataset** available on Kaggle.

The original dataset contains information about Spotify tracks, including:

- Track metadata
- Artist information
- Genre information
- Audio-related features

The data has been preprocessed and normalized to create independent CSV files suitable for both relational and graph databases.

The final dataset structure is:

```
data/
├── artists.csv
├── genres.csv
├── tracks.csv
├── dataset.csv
├── track_artist_map.csv
└── track_genre_map.csv
```

The preprocessing phase extracts atomic entities and resolves multi-valued attributes such as tracks associated with multiple artists or genres.

---

# Repository Structure

```
.
├── data/
│   ├── artists.csv
│   ├── genres.csv
│   ├── tracks.csv
│   ├── dataset.csv
│   ├── track_artist_map.csv
│   └── track_genre_map.csv
│
├── src/
│   ├── preprocess.py
│   ├── analyzedata.py
│   ├── neo4j_query_saved_cypher.csv
│   │
│   └── postgres_sql/
│       │
│       ├── 1. Loading/
│       │   ├── Create Schema.sql
│       │   ├── Load Artists.sql
│       │   ├── Load Genres.sql
│       │   ├── Load Tracks.sql
│       │   ├── Load Track-Artist.sql
│       │   ├── Load Track-Genre.sql
│       │   └── Create Indexes.sql
│       │
│       ├── 2. Visualization/
│       │   ├── Basic Exploration.sql
│       │   ├── Genre Multiplicity Distribution.sql
│       │   ├── Hub Pattern.sql
│       │   ├── Random Sampling.sql
│       │   └── Topology Exploration.sql
│       │
│       └── 3. Benchmarking/
│           ├── Sanity Checks/
│           ├── Read (SELECT)/
│           ├── Write (INSERT)/
│           ├── Update (UPDATE)/
│           └── Delete (DELETE)/
│
└── README.md
```

---

# PostgreSQL Implementation

All PostgreSQL scripts are available in:

```
src/postgres_sql/
```

## 1. Loading

The loading phase creates the relational schema and imports the processed CSV files.

The workflow includes:

- Schema creation
- Table creation
- Bulk loading using PostgreSQL `COPY`
- Foreign key constraints
- Index creation

Indexes are added on frequently searched attributes to improve query execution.

---

## 2. Visualization

This section contains exploratory SQL queries used to analyze the dataset topology before benchmarking.

The analysis includes:

- Basic entity exploration
- Random sampling
- Genre multiplicity distribution
- Hub pattern identification
- Relationship topology analysis

These queries are not included in performance measurements but are used to validate the correctness of the data model.

---

# Benchmarking Methodology

The benchmark suite compares PostgreSQL and Neo4j using equivalent workloads.

The evaluated operations are:

- Read operations
- Insert operations
- Update operations
- Delete operations

PostgreSQL execution plans are collected using:

```
EXPLAIN ANALYZE
```

Neo4j execution profiles are collected using:

```
PROFILE
```

---

# Benchmark Workloads

## Read Queries

The read benchmark includes:

1. **Baseline Point Lookup**
   - Single track lookup by identifier

2. **Content-Based Recommendation**
   - Find tracks sharing genres with a target track

3. **Artist Prolificacy**
   - Rank artists by number of tracks

4. **Global Aggregation and Filtering**
   - Analyze genre popularity statistics

5. **Deep Multi-Hop Path Analysis**
   - Discover similar artists through shared genres

6. **Degrees of Separation**
   - Explore variable-length paths between artists

---

## Write Queries

The write benchmark evaluates insertion of a complete entity:

- Track creation
- Artist relationship creation
- Genre relationship creation

---

## Update Queries

The update benchmark measures bulk modifications:

- Updating popularity values of tracks belonging to a genre
- Verification and rollback operations

---

## Delete Queries

The delete benchmark evaluates removal of entities and relationships:

- Removing bridge table references
- Deleting tracks
- Maintaining integrity constraints

---

# Performance Results

## Data Loading

| DBMS | Total Loading Time |
|---|---:|
| PostgreSQL | 21,178 ms |
| Neo4j | 17,533 ms |

Neo4j achieved a lower total loading time mainly due to the direct materialization of relationships as graph edges.

---

# Read Benchmark Results

| Query | PostgreSQL | Neo4j | Best Performer |
|---|---:|---:|---|
| Point Lookup | 0.109 ms | 9 ms | PostgreSQL |
| Content-Based Recommendation | 36.409 ms | 23 ms | Neo4j |
| Artist Prolificacy | 178.024 ms | 127 ms | Neo4j |
| Global Aggregation | 300.646 ms | 148 ms | Neo4j |
| Deep Multi-Hop Analysis | 3620.708 ms | 462 ms | Neo4j |
| Degrees of Separation | 3799.909 ms | 68 ms | Neo4j |

### Analysis

PostgreSQL performs better for isolated key-based lookups thanks to highly optimized B-Tree indexes.

Neo4j becomes significantly faster when the workload requires traversing multiple relationships because connections are physically stored as graph relationships, avoiding expensive runtime joins.

The largest performance difference appears in recursive and multi-hop queries, where Neo4j provides a substantial advantage.

---

# Mutation Benchmark Results

## Insert

| DBMS | Operation | Time |
|---|---|---:|
| PostgreSQL | Insert Track + Relationships | 1.943 ms |
| Neo4j | Create Track + Relationships | 85 ms |

PostgreSQL is faster for simple atomic writes due to its efficient tuple storage and low-level storage engine optimizations.

---

## Update

| DBMS | Operation | Time |
|---|---|---:|
| PostgreSQL | Bulk Update | 130.549 ms |
| Neo4j | Bulk Update | 31 ms |

Neo4j benefits from in-place property updates, while PostgreSQL suffers from MVCC overhead and tuple versioning.

---

## Delete

| DBMS | Operation | Time |
|---|---|---:|
| PostgreSQL | Delete Entity + Relationships | 1.129 ms |
| Neo4j | `DETACH DELETE` | 7 ms |

PostgreSQL performs better for structured deletions, although Neo4j provides a simpler operation through automatic relationship removal.

---

# Conclusions

The experimental results show that neither technology dominates universally.

## PostgreSQL is preferable for:

- Point lookups
- Simple inserts
- Structured transactional workloads
- Strong schema enforcement
- Complex integrity constraints

## Neo4j is preferable for:

- Relationship-heavy queries
- Graph traversal
- Multi-hop analysis
- Recommendation systems
- Variable-length path exploration

The benchmark confirms that the choice between relational and graph databases should depend on the dominant access pattern of the application.

Relational databases optimize structured data access, while graph databases provide significant advantages when relationships represent the core value of the information.

---

# Technologies

- PostgreSQL
- Neo4j
- SQL
- Cypher
- Python
- CSV data processing

---

# Author

**Fabio Iacus**

Computer Engineering Student

---

# License

This project was developed for academic purposes.
