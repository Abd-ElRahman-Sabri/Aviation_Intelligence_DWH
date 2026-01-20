CREATE TABLE dwh.fact_weather (
    weather_id          BIGSERIAL PRIMARY KEY,
    airport_key         INT NOT NULL,          
    date_key            INT NOT NULL,           
    time_key            INT NOT NULL,           
    
    -- Measures
    temperature         DECIMAL(5,2),          
    wind_speed          DECIMAL(5,2),           
    
    -- Attributes 
    weather_condition   VARCHAR(50),           
    
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes 
CREATE INDEX idx_fact_weather_airport ON dwh.fact_weather(airport_key);
CREATE INDEX idx_fact_weather_date ON dwh.fact_weather(date_key);

-------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS dwh.fact_flight_tracking;

CREATE TABLE dwh.fact_flight_tracking (
    track_id            BIGSERIAL PRIMARY KEY,
    aircraft_key        INT NOT NULL,
    date_key            INT NOT NULL,
    time_key            INT NOT NULL,
    latitude            DECIMAL(10,6),
    longitude           DECIMAL(10,6),
    altitude_ft         DECIMAL(10,2),
    speed_knots         DECIMAL(10,2),
    heading             DECIMAL(10,2),
    climb_rate          DECIMAL(10,2),
    is_on_ground        BOOLEAN,
    callsign            VARCHAR(20),
    squawk_code         VARCHAR(10),
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_trk_aircraft ON dwh.fact_flight_tracking(aircraft_key);
CREATE INDEX idx_trk_date ON dwh.fact_flight_tracking(date_key);
-------------------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS dwh.fact_fuel;

CREATE TABLE dwh.fact_fuel (
    fuel_id             BIGSERIAL PRIMARY KEY,
    source_log_id       INT,
    aircraft_key        INT NOT NULL,
    date_key            INT NOT NULL,
    fuel_type           VARCHAR(20),
    gallons             DECIMAL(10,2),
    total_cost          DECIMAL(10,2),
    notes               VARCHAR(255),
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_fuel_aircraft ON dwh.fact_fuel(aircraft_key);
CREATE INDEX idx_fuel_date ON dwh.fact_fuel(date_key);
