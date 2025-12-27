SELECT
    school_subclassification,
    COUNT(*) as total_count,
    ROUND(COUNT(*)::numeric/(SELECT COUNT(*) FROM masterlist) * 100, 4) AS percentage
FROM masterlist
GROUP BY school_subclassification
ORDER BY total_count DESC;