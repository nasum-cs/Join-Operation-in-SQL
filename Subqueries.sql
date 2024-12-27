USE [Country]
GO


--Example of Semi Join by using WHERE clause in subqeury
SELECT DISTINCT name
FROM languages
WHERE code IN
    (SELECT code
    FROM countries
    WHERE region = 'Middle East')
ORDER BY name;
GO


--Example of Anti Join
SELECT code, country_name
FROM countries
WHERE continent = 'Oceania'
AND code NOT IN
    (SELECT code
    FROM currencies);
GO


--Example of subquery using WHERE clause
SELECT *
FROM populations
WHERE year = 2015
-- Filter for only those populations where life expectancy is 1.15 times higher than average
  AND life_expectancy > 1.15 * 
  (SELECT AVG(life_expectancy)
   FROM populations
   WHERE year = 2015);
GO


--Example of subquery using WHERE IN clause
-- Select relevant fields from cities table
SELECT name, country_code, urbanarea_pop
FROM cities
-- Filter using a subquery on the countries table
WHERE name IN
    (SELECT capital
    FROM countries)
ORDER BY urbanarea_pop DESC;
GO



--Example of subquery using SELECT clause
SELECT TOP(9) countries.country_name AS country,
-- Subquery that provides the count of cities   
  (SELECT COUNT(*)
   FROM cities
   WHERE countries.code = cities.country_code) AS cities_num
FROM countries
ORDER BY cities_num DESC, country;
GO


-- Select local_name and lang_num from appropriate tables
SELECT countries.local_name, sub.lang_num
FROM countries
JOIN
  (SELECT code, COUNT(*) AS lang_num
  FROM languages
  GROUP BY code) AS sub
-- Where codes match
ON countries.code = sub.code
ORDER BY lang_num DESC;
GO


-- Select relevant fields
SELECT economies.code, economies.inflation_rate, economies.unemployment_rate
FROM economies
WHERE year = 2015 
  AND code IN
-- Subquery returning country codes filtered on gov_form
	(SELECT code
  FROM countries
  WHERE gov_form LIKE '%Monarchy%' OR gov_form LIKE '%Republic%' )
ORDER BY inflation_rate;


-- Select fields from cities
SELECT 
	TOP(10)
    cities.name, 
    cities.country_code, 
    cities.city_proper_pop, 
    cities.metroarea_pop,
    (city_proper_pop/metroarea_pop*100) AS city_perc
FROM cities
-- Use subquery to filter city name
WHERE name IN (SELECT capital
FROM countries
WHERE continent = 'Europe' OR continent LIKE '%America')
-- Add filter condition such that metroarea_pop does not have null values
AND metroarea_pop IS NOT NULL
-- Sort and limit the result
ORDER BY city_perc DESC;
GO