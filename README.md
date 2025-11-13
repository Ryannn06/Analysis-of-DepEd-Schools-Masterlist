# SQL-Case-Study-on-DepEd-Schools-Masterlist

## <br>Overview

This project uses the S.Y. 2020-2021 DepEd Schools Masterlist to demonstrate **SQL database creation**, **data cleaning**, and **analysis**.

The dataset contains 64,000+ school information across the Philippines, including location, sectors, and classification details.

Dataset source: [data.gov.ph](https://data.gov.ph/index/public/dataset/SY%202020-2021%20Masterlist%20of%20Schools/5dpij7nd-uhrj-wk5l-xv2h-q5pgkiccv9ag)

## <br>Database Structure
**Table name:** `masterlist` (denormalized)

| Column Name                                   | Description                             |
| --------------------------------------------- | --------------------------------------- |
| `region`                                      | Region where the school is located      |
| `division`                                    | Division under the region               |
| `district`                                    | District of the school                  |
| `municipality`                                | Municipality or city                    |
| `barangay`                                    | Barangay of the school                  |
| `beis_school_id`                              | Unique school ID                        |
| `school_name`                                 | Official school name                    |
| `street_address`                              | Street address                          |
| `legislative_district`                        | Legislative district                    |
| `sector`                                      | Public, Private, SUC/LUC                |
| `urban_rural_classification`                  | Urban, Rural, or Partially Urbanized                         |
| `school_subclassification`                    | DepEd Managed, Non-sectarian, Sectarian, etc. |
| `modified_curricular_offering_classification` | All Offering (K-12), ES and JHS (K-10), JHS with SHS, etc.           |

## <br>Project Workflow
1. **Data Extraction and Preprocessing (Python)**
   - Extracted the raw DepEd masterlist from CSV using pdfplumber (Python).
   - Cleaned and standardized data using Pandas:
      - Corrected inconsistencies in municipality, sector, and classification fields.
      - Reformatted text cases and standardized identifiers.
   - Exported the cleaned dataset for SQL analysis
2. **Database Design** 
   - Used a denormalized table structure to simplify querying and improve performance for analysis.
   - Columns include:
`region`, `division`, `district`, `school_name`, `municipality`, `barangay`,
`sector`, `urban_rural_classification`, `school_subclassification`, and others.

3. **SQL Analysis**
   - Used PostgreSQL to query and analyze data.
   - Example analyses:
     - Top regions and divisions by number of schools.
     - Comparison between public vs. private schools.
     - Ratio for public and private schools per sector.
     - Classification of schools by sector and location.

## <br>Tools and Technologies
   - Python (pandas, pdfplumber)
   - PostgreSQL / SQL
   - Excel (for initial validation)

## <br>Notes

- The dataset is SY 2020–2021 DepEd Masterlist.
- Being denormalized, the table is easier for read-heavy queries but may have redundancy.
- Data cleaning may be required for street address.

## <br>License

For educational and research purposes. Please credit DepEd Philippines when using in reports or projects.