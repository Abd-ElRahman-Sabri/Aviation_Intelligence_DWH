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


DROP TABLE IF EXISTS landing.flights_raw;
CREATE TABLE landing.flights_raw (
    icao24          TEXT,
    callsign        TEXT,
    origin_country  TEXT,
    time_position   BIGINT,
    last_contact    BIGINT,
    longitude       FLOAT,
    latitude        FLOAT,
    baro_altitude   FLOAT,
    on_ground       BOOLEAN,
    velocity        FLOAT,
    true_track      FLOAT,
    vertical_rate   FLOAT,
    sensors         TEXT,
    geo_altitude    FLOAT,
    squawk          TEXT,
    spi             BOOLEAN,
    position_source INT,
    load_timestamp  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


DROP TABLE IF EXISTS landing.aircraft_raw;

CREATE TABLE landing.aircraft_raw (
    icao24          TEXT,
    registration    TEXT, -- رقم التسجيل المكتوب على ديل الطيارة
    manufacturericao TEXT,
    manufacturername TEXT,
    model           TEXT,
    typecode        TEXT,
    serialnumber    TEXT,
    linenumber      TEXT,
    icaoaircrafttype TEXT,
    operator        TEXT, -- الشركة المشغلة
    operatorcallsign TEXT,
    operatoricao    TEXT,
    operatoriata    TEXT,
    owner           TEXT,
    testreg         TEXT,
    registered      TEXT, -- تاريخ التسجيل (TEXT مؤقتا)
    reguntil        TEXT,
    status          TEXT,
    built           TEXT, -- سنة الصنع
    firstflightdate TEXT,
    seatconfiguration TEXT,
    engines         TEXT,
    modes           TEXT,
    adsb            TEXT,
    acars           TEXT,
    notes           TEXT,
    categoryDescription TEXT
);

DROP TABLE IF EXISTS landing.weather_raw;

CREATE TABLE landing.weather_raw (
    airport_code TEXT,
    timestamp    TEXT,
    temperature  TEXT,
    wind_speed   TEXT,
    condition    TEXT,
    xml_source   TEXT 
);
