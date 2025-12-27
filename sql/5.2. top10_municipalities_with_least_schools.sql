SELECT 
    division,
    municipality,
    COUNT(*) total_count
FROM masterlist
GROUP BY division, municipality
ORDER BY total_count, division ASC
LIMIT 10;