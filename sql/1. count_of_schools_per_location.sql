--total schools
SELECT COUNT(*) AS total_count
FROM masterlist;

-- schools per region
WITH region_cte AS (
    SELECT
        r.region_name,
        COUNT(*) AS no_of_schools,
        DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) as ranking
    FROM masterlist m
    JOIN region r ON m.region_id = r.region_id
    GROUP BY r.region_name
)
SELECT *
FROM region_cte
ORDER BY ranking ASC
LIMIT 5;


-- schools per division
SELECT 
    division, 
    COUNT(*) AS no_of_schools
FROM masterlist
GROUP BY division
ORDER BY no_of_schools DESC
LIMIT 20;

-- schools per district
SELECT 
    district, 
    COUNT(*) AS no_of_schools
FROM masterlist
GROUP BY district
ORDER BY no_of_schools DESC
LIMIT 20;