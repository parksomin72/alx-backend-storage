-- Task 3: List Glam rock bands ranked by longevity
SELECT band_name, 
       IF(split = 0, 2022 - formed, split - formed) AS lifespan
FROM bands
WHERE style = 'Glam rock'
ORDER BY lifespan DESC, band_name ASC;
