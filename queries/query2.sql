
SELECT
    zipcode AS "Zipcode",
    COUNT(*) AS "Total_Trees"
FROM
    nyc_tree
GROUP BY
    zipcode
ORDER BY
    "Total_Trees" DESC
LIMIT
    10;
