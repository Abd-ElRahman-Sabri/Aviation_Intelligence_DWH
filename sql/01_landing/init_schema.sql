-- (Schemas)
CREATE SCHEMA IF NOT EXISTS landing;
CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS dwh;

DROP TABLE IF EXISTS landing.airports_raw;
CREATE TABLE landing.airports_raw (
    airport_id TEXT, name TEXT, city TEXT, country TEXT, iata TEXT, icao TEXT, 
    latitude TEXT, longitude TEXT, altitude TEXT, timezone TEXT, dst TEXT, 
    tz_db_timezone TEXT, type TEXT, source TEXT
);
