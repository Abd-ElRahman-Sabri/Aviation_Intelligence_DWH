# ⚙️ ETL & Data Processing Scripts

This directory contains the operational logic of the pipeline, segregated by function.

## 📂 Modules

### `extract/` (Python)
* **Role:** Connects to external worlds.
* **Function:** Python scripts responsible for querying APIs (e.g., OpenSky, WeatherAPI) or parsing raw files.
* **Output:** Saves raw data to the `data/` directory or passes it to the ingest module.

### `ingest/` (Python)
* **Role:** The Gatekeeper to the Database.
* **Function:** Scripts that take the extracted raw data and perform bulk loads into the `02_staging` schema in PostgreSQL.
* **Key Logic:** Handles database connections and efficient insertion methods (COPY command / batch inserts).

### `transform/` (Pentaho Data Integration)
* **Role:** The Transformation Engine (Core Logic).
* **Content:**
    * **`.ktr` (Transformations):** Detailed cleaning, lookup resolution, and surrogate key generation.
    * **`.kjb` (Jobs):** The orchestrator job (`job_master_load`) that manages dependencies (Dimensions first -> Facts second).
* **Key Feature:** Implements **Slowly Changing Dimensions (SCD Type 2)** for aircraft data.

### `utility/` (Python)
* **Role:** Shared Helpers.
* **Content:** Reusable code modules used across extract and ingest scripts.
* **Examples:** Database connection factories, logging setups, and configuration readers.
