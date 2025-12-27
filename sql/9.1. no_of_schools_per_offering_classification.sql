SELECT 
    modified_curricular_offering_classification,
    COUNT(*) AS total_count,
    ROUND(COUNT(*)::numeric/(SELECT COUNT(*) FROM masterlist) * 100,2) AS percentage
FROM masterlist
GROUP BY modified_curricular_offering_classification
ORDER BY total_count DESC;