-- Active: 1761546932084@@localhost@5432@deped_masterlist@public
DROP TABLE IF EXISTS masterlist;
DROP TABLE IF EXISTS region;

CREATE TABLE IF NOT EXISTS region (
    region_id INT PRIMARY KEY,
    region_name TEXT NOT NULL UNIQUE,
    latitude FLOAT,
    longitude FLOAT
);

CREATE TABLE IF NOT EXISTS masterlist (
    beis_school_id INT PRIMARY KEY,
    region_id INT REFERENCES region(region_id),
    division TEXT,
    district TEXT,
    school_name TEXT NOT NULL,
    street_address TEXT,
    municipality TEXT NOT NULL,
    legislative_district TEXT,
    barangay TEXT,
    sector TEXT,
    urban_rural TEXT,
    school_subclassification TEXT,
    modified_curricular_offering_classification TEXT
);