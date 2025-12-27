SELECT
    region,
    school_subclassification,
    COUNT(*) as total_count
FROM masterlist
GROUP BY region, school_subclassification
ORDER BY region ASC, total_count DESC;