
SELECT
    nyc_tree.zipcode,
    ROUND(AVG(zillow."2023-08-31")::numeric, 2) AS Average_Rent
FROM
    nyc_tree
JOIN
    zillow ON nyc_tree.zipcode = CAST(zillow.zipcode AS TEXT)
GROUP BY
    nyc_tree.zipcode
ORDER BY
    COUNT(*) DESC
LIMIT
    10;
