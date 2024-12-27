USE [Country]
GO

---Select city name, from cities similarly country name and region field from countries table
---Applying INNER JOIN operatin between cities and countries table by country_code
SELECT cities.name AS city, countries.country_name AS country, region
FROM cities
INNER JOIN countries   -- Perform INNER JOIN to match rows based on the country_code field
ON cities.country_code = countries.code;
GO


-- Select fields with aliases
SELECT c.code AS country_code, c.country_name, e.year, e.inflation_rate
FROM countries AS c
-- Join to economies (alias e)
INNER JOIN economies AS e
-- Match on code field using table aliases
ON c.code = e.code;
GO


---Use USING keyword to join country and language table
SELECT c.country_name AS country, l.name AS language, l.official
FROM countries AS c
INNER JOIN languages AS l
-- Match using the code column
ON c.code = l.code
WHERE l.name = 'Bhojpuri';
GO


-- Select relevant fields
-- Inner join countries and populations, aliased, on code
SELECT c.country_name, p.fertility_rate, e.unemployment_rate, e.year
FROM countries AS c
INNER JOIN populations AS p
ON c.code = p.country_code
INNER JOIN economies AS e 
ON c.code = e. code
	AND p.year = e.year;


