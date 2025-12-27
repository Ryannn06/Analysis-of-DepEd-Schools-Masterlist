-- Active: 1761546932084@@localhost@5432@deped_masterlist
WITH sector_rename AS (
    SELECT 
        CASE 
            WHEN sector IN ('Public','SUCs/LUCs') THEN 'Public'
            WHEN sector ILIKE '%private%' THEN 'Private'
            ELSE 'Others'
        END AS sector_cleaned
    FROM masterlist
)
SELECT 
    sector_cleaned AS sector,
    COUNT(*) AS total_count,
    ROUND(COUNT(*)::numeric/ (SELECT COUNT(*) FROM masterlist) * 100, 2) AS percentage
FROM sector_rename
GROUP BY sector_cleaned
ORDER BY total_count DESC;
