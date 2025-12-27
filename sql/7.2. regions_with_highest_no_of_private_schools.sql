SELECT 
    region,
    COUNT(*) AS total_count
FROM masterlist
WHERE sector = 'Private'
GROUP BY region
ORDER BY total_count DESC LIMIT 10;