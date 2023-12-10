
SELECT
    z.zipcode,
    COUNT(*) AS total_trees
FROM
    nyc_tree t
JOIN
    zipcodes z ON ST_Within(t.geometry, z.geometry)
GROUP BY
    z.zipcode
ORDER BY
    total_trees DESC
LIMIT
    10;
