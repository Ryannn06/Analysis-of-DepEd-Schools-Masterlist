SELECT
    urban_rural,
    SUM(CASE WHEN sector IN ('Public', 'SUCs/LUCs') THEN 1 ELSE 0 END) AS public_count,
    SUM(CASE WHEN sector = 'Private' THEN 1 ELSE 0 END) AS private_count,
    ROUND(SUM(CASE WHEN sector IN ('Public', 'SUCs/LUCs') THEN 1 ELSE 0 END)::numeric/SUM(COUNT(*)) OVER(PARTITION BY urban_rural) * 100,2) AS public_percentage,
    ROUND(SUM(CASE WHEN sector = 'Private' THEN 1 ELSE 0 END)::numeric/SUM(COUNT(*)) OVER(PARTITION BY urban_rural) * 100,2) AS private_percentage,
    CONCAT(ROUND(
            SUM(CASE WHEN sector IN ('Public', 'SUCs/LUCs') THEN 1 ELSE 0 END)::numeric/
            SUM(CASE WHEN sector = 'Private' THEN 1 ELSE 0 END), 2
        ), ' : 1') AS public_private_ratio
FROM masterlist
GROUP BY urban_rural;

SELECT urban_rural, sector,
    COUNT(*) AS total_schools,
    ROUND(COUNT(*)::numeric/SUM(COUNT(*)) OVER(PARTITION BY urban_rural) * 100,2) AS percentage
FROM masterlist
GROUP BY urban_rural, sector
ORDER BY urban_rural, sector;