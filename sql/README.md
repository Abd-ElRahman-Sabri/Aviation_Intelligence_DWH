# 🗄️ Database Schema Layers

This directory manages the database objects for the entire data lifecycle, divided into three logical layers.

## 📂 Layers Description

### `01_landing/`
* **Purpose:** The rawest entry point for data.
* **Content:** Schemas or tables designed to receive data exactly as it comes from the source (APIs/CSVs) without any modification.
* **Use Case:** Acts as a data lake layer within the database for auditing and full-history preservation.

### `02_staging/`
* **Purpose:** The intermediate processing area (Transient Layer).
* **Content:** Tables like `staging.flights`, `staging.weather`, and `staging.fuel_logs`.
* **Behavior:** Data here is typically truncated and reloaded during every ETL run. It serves as the input source for the Transformation engine.

### `03_dwh/`
* **Purpose:** The final destination (Presentation Layer).
* **Architecture:** Dimensional Modeling (Star Schema).
* **Key Tables:**
    * **Facts:** `fact_flight_tracking`, `fact_fuel`, `fact_weather` (Optimized for aggregation).
    * **Dimensions:** `dim_aircraft` (Handles **SCD Type 2** for history), `dim_airports`.
