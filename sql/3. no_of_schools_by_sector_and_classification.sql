SELECT
    COALESCE(sector, 'Grant Total') AS sector,
    COALESCE(modified_curricular_offering_classification, 'Subtotal') AS classification,
    COUNT(*) AS total_count
FROM masterlist
GROUP BY CUBE(sector, modified_curricular_offering_classification)
ORDER BY sector DESC,  modified_curricular_offering_classification ASC;