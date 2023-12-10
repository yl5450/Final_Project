
-- Common Table Expressions (CTEs)
WITH Rent AS (
    SELECT
        zipcode,
        AVG("2023-01-31") AS average_rent
    FROM
        zillow
    GROUP BY
        zipcode
    HAVING
        AVG("2023-01-31") > 0
),
TreeCount AS (
    SELECT
        zipcode,
        COUNT(*) AS tree_count
    FROM
        nyc_tree
    GROUP BY
        zipcode
),
ComplaintCount AS (
    SELECT
        zipcode,
        COUNT(*) AS complaint_count
    FROM
        nyc_311
    WHERE
        date >= '2023-01-01' AND date < '2023-01-31'
    GROUP BY
        zipcode
),
RankedRent AS (
    SELECT
        zipcode,
        TO_CHAR(average_rent, 'FM9,999,999.99') AS formatted_average_rent,
        average_rent,
        DENSE_RANK() OVER (ORDER BY average_rent DESC) AS high_rank,
        DENSE_RANK() OVER (ORDER BY average_rent ASC) AS low_rank
    FROM
        Rent
)

-- Final SELECT statement
SELECT
    RankedRent.zipcode,
    RankedRent.formatted_average_rent,
    TreeCount.tree_count,
    ComplaintCount.complaint_count
FROM
    RankedRent
LEFT JOIN
    TreeCount ON RankedRent.zipcode = TreeCount.zipcode
LEFT JOIN
    ComplaintCount ON RankedRent.zipcode = ComplaintCount.zipcode
WHERE
    RankedRent.high_rank < 5 OR RankedRent.low_rank < 5
ORDER BY
    RankedRent.average_rent DESC,
    RankedRent.high_rank,
    RankedRent.low_rank;
