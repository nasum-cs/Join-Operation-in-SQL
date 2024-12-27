USE [Country]
GO

--Using LEFT JOIN connect two tables cities and countries
SELECT 
	c1.name AS city, 
    code, 
    c2.country_name AS country,
    region, 
    city_proper_pop
FROM cities AS c1
-- Join right table (with alias)
LEFT JOIN countries AS c2
ON c1.country_code = c2.code
ORDER BY code DESC;
GO


-- Select region, and average gdp_percapita as avg_gdp
-- Order by descending avg_gdp
-- Return only first 10 records
SELECT TOP(10) c.region, AVG(e.gdp_percapita) AS avg_gdp
FROM countries AS c
LEFT JOIN economies AS e
	ON c.code = e.code
WHERE year = 2010
-- Group by region
GROUP BY region
ORDER BY avg_gdp;
GO





