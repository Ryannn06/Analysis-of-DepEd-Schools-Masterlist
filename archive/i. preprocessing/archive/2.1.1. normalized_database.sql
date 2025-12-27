-- Active: 1761546932084@@localhost@5432@deped_masterlist
CREATE TABLE IF NOT EXISTS region (
    region_id SERIAL PRIMARY KEY,
    region TEXT UNIQUE
);

CREATE TABLE IF NOT EXISTS division (
    division_id SERIAL PRIMARY KEY,
    division TEXT UNIQUE,
    region_id INT REFERENCES region(region_id),
    UNIQUE(division, region_id)
);

CREATE TABLE IF NOT EXISTS district (
    district_id SERIAL PRIMARY KEY,
    district TEXT UNIQUE,
    division_id INT REFERENCES division(division_id),
    UNIQUE(district, division_id)
);

CREATE TABLE IF NOT EXISTS legislative_district (
    legislative_id SERIAL PRIMARY KEY,
    legislative_district TEXT
);

CREATE TABLE IF NOT EXISTS municipality (
    municipality_id SERIAL PRIMARY KEY,
    municipality TEXT UNIQUE,
    district_id INT REFERENCES district(district_id),
    legislative_id INT REFERENCES legislative_district(legislative_id),
    UNIQUE(municipality, district_id, legislative_id)
);

CREATE TABLE IF NOT EXISTS barangay (
    barangay_id SERIAL PRIMARY KEY,
    barangay TEXT,
    municipality_id INT REFERENCES municipality(municipality_id),
    UNIQUE (barangay, municipality_id)
);

CREATE TABLE IF NOT EXISTS sector (
    sector_id SERIAL PRIMARY KEY,
    sector TEXT UNIQUE
);

CREATE TABLE IF NOT EXISTS location_type (
    location_id SERIAL PRIMARY KEY,
    location_type TEXT UNIQUE
);

CREATE TABLE IF NOT EXISTS school_subclassification (
    subclassification_id SERIAL PRIMARY KEY,
    subclassification VARCHAR UNIQUE
);

CREATE TABLE IF NOT EXISTS modified_curricular_offering_classification (
    offering_id SERIAL PRIMARY KEY,
    offering_classification TEXT UNIQUE
);

CREATE TABLE IF NOT EXISTS school (
    school_id INT PRIMARY KEY,
    school_name TEXT,
    street_address TEXT,
    barangay_id INT REFERENCES barangay(barangay_id),
    sector_id INT REFERENCES sector(sector_id),
    location_id INT REFERENCES location_type(location_id),
    subclassification_id INT REFERENCES school_subclassification(subclassification_id),
    offering_id INT REFERENCES modified_curricular_offering_classification(offering_id),
    UNIQUE(school_id, barangay_id, sector_id, location_id, subclassification_id, offering_id)
);







