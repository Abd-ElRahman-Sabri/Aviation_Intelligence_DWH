CREATE SCHEMA IF NOT EXISTS dwh;

-- Dimension: Aircraft
DROP TABLE IF EXISTS dwh.dim_aircraft;
CREATE TABLE dwh.dim_aircraft (
    aircraft_key    SERIAL PRIMARY KEY,
    icao24          TEXT,
    registration    TEXT,
    manufacturer    TEXT,
    model           TEXT,
    operator        TEXT,
    built_year      TEXT,
    engine_type     TEXT,
    start_date      TIMESTAMP,
    end_date        TIMESTAMP
);

ALTER TABLE dwh.dim_aircraft ADD COLUMN version INT;
CREATE INDEX idx_dim_aircraft_icao24 ON dwh.dim_aircraft(icao24);

-- Dimension: Airports
DROP TABLE IF EXISTS dwh.dim_airports;
CREATE TABLE dwh.dim_airports (
    airport_key     SERIAL PRIMARY KEY,
    airport_id      INT,
    name            TEXT,
    city            TEXT,
    country         TEXT,
    iata_code       TEXT,
    icao_code       TEXT,
    latitude        FLOAT,
    longitude       FLOAT,
    timezone        FLOAT,
    dst             TEXT,
    start_date      TIMESTAMP,
    end_date        TIMESTAMP
);

ALTER TABLE dwh.dim_airports ADD COLUMN version INT;
