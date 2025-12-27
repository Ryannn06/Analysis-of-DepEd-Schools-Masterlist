WITH sector_rename AS (
    SELECT
        division,
        municipality,
        CASE 
            WHEN sector IN ('Public','SUCs/LUCs') THEN  'Public'
            WHEN sector IN ('Private') THEN 'Private'
            ELSE  'Others'
        END AS cleaned_sector
    FROM masterlist
    --WHERE modified_curricular_offering_classification IN ('Purely ES')
), sector_counts AS (
    SELECT 
        division,
        municipality,
        cleaned_sector,
        COUNT(*) AS total_count,
        COUNT(*)::numeric / SUM(COUNT(*)) OVER(PARTITION BY division, municipality) * 100 AS percentage
    FROM sector_rename
    GROUP BY division, municipality, cleaned_sector
)
SELECT 
    division,
    municipality,
    total_count
FROM sector_counts
WHERE cleaned_sector = 'Public' AND total_count = 0
ORDER BY division, municipality;