
SELECT 
    zipcode, 
    COUNT(*) AS num_complaints
FROM 
    nyc_311
WHERE 
    date BETWEEN '2022-10-01' AND '2023-09-30'
GROUP BY 
    zipcode
ORDER BY 
    num_complaints DESC;
