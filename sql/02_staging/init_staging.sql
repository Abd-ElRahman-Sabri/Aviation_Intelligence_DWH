CREATE SCHEMA IF NOT EXISTS staging;


DROP TABLE IF EXISTS staging.flights;
CREATE TABLE staging.flights (
    flight_id       SERIAL PRIMARY KEY, 
    icao24          TEXT,
    callsign        TEXT,
    origin_country  TEXT,
    event_time      TIMESTAMP, --  time_position
    last_contact    TIMESTAMP, --  last_contact 
    longitude       FLOAT,
    latitude        FLOAT,
    baro_altitude   FLOAT,
    on_ground       BOOLEAN,
    velocity        FLOAT,
    true_track      FLOAT,
    vertical_rate   FLOAT,
    geo_altitude    FLOAT,
    squawk          TEXT,
    position_source INT,
    ingestion_time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS staging.fuel_logs;

CREATE TABLE staging.fuel_logs (
    log_id          SERIAL PRIMARY KEY,
    aircraft_code   TEXT, -- SU-GDL
    fuel_type       TEXT, -- Jet-A1
    gallons         FLOAT,
    total_cost      FLOAT,
    log_date        DATE, 
    notes           TEXT,
    ingestion_time  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
