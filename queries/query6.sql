
SELECT
    ID,
    species,
    health,
    status,
    ST_AsText(ST_MakePoint(longitude, latitude)) AS location
FROM
    nyc_tree
WHERE
    ST_DWithin(
        ST_MakePoint(longitude, latitude)::geography,
        ST_MakePoint(-73.96253174434912, 40.80737875669467)::geography,
        805  -- Radius in meters
    );
