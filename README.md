# ✈️ Aviation Intelligence Data Warehouse (Tracks)

## 📌 Project Overview
**Tracks** is an end-to-end Data Engineering solution designed to ingest, process, and analyze high-frequency aviation data. The project implements a robust **ELT/ETL pipeline** moving data from raw APIs to a polished Data Warehouse using **PostgreSQL**, **Python**, and **Pentaho Data Integration (PDI)**.

## 🏗️ Architecture & Pipeline Flow
The system follows a modular architecture:
1.  **Extraction:** Python scripts pull raw flight (ADS-B) and weather data from APIs.
2.  **Ingestion:** Data is loaded into a **Staging Area** in PostgreSQL.
3.  **Transformation:** Pentaho (PDI) orchestrates complex logic, cleaning, and **SCD Type 2** historical tracking.
4.  **Warehousing:** Final data is modeled into a **Star Schema** for analytics.

## 📂 Project Structure
* **`sql/`**: Contains the complete database evolution strategy (Landing -> Staging -> DWH).
* **`scripts/`**: The engine room containing Python scripts for extraction/ingestion and Pentaho files for transformation.
* **`docker/`**: Containerization setup for the full stack (Airflow, Postgres, etc.).
* **`dags/`**: Airflow DAGs for orchestrating the pipeline (Future Integration).
* **`config/`**: Configuration management for database connections and API keys.

## 🚀 How to Run
1.  Initialize the database using scripts in `sql/`.
2.  Configure credentials in `config/`.
3.  Run extraction scripts in `scripts/extract/`.
4.  Trigger the Master Job in `scripts/transform/` to populate the DWH.
