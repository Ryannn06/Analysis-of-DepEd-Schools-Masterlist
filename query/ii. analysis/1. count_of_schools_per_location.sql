--total schools
SELECT COUNT(*) AS total_count
FROM masterlist;

-- schools per region
SELECT
    region, 
    COUNT(*) AS no_of_schools,
    DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) as ranking
FROM masterlist
GROUP BY region
ORDER BY region ASC;


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