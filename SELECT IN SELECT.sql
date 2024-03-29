-- List each country name where the population is larger than that of 'Russia'.

-- world(name, continent, area, population, gdp)

SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

-- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

-- Per Capita GDP
-- The per capita GDP is the gdp/population

SELECT name FROM world
WHERE gdp/population>(SELECT gdp/population FROM world WHERE name='United Kingdom') 
AND continent='Europe'


-- List the name and continent of countries in
--  the continents containing either Argentina or Australia.
--  Order by name of the country.

SELECT name, continent 
FROM world
WHERE continent IN (SELECT continent FROM world WHERE name IN ('Argentina', 'Australia'))
ORDER BY name

-- Which country has a population that is 
-- more than Canada but less than Poland? Show the name and the population.

SELECT name, population
FROM world
WHERE population>(SELECT population
FROM world
WHERE name='Canada') AND population<(SELECT population
FROM world
WHERE name='Poland') 

-- Germany (population 80 million) has the largest population of the countries in Europe.
--  Austria (population 8.5 million) has 11% of the population of Germany.

-- Show the name and the population of each country in Europe. 
-- Show the population as a percentage of the population of Germany.

-- Decimal places
-- You can use the function ROUND to remove the decimal places.
-- Percent symbol %
-- You can use the function CONCAT to add the percentage symbol.

SELECT name, CONCAT(
    ROUND(
        (population/(SELECT population FROM world WHERE name='Germany')) * 100 
        ), '%') AS population
FROM world
WHERE continent='Europe'

-- Which countries have a GDP greater than every country in Europe?
--  [Give the name only.] (Some countries may have NULL gdp values)

SELECT name
  FROM world
 WHERE gdp > ALL(SELECT gdp
                           FROM world
                          WHERE gdp>0 AND continent='Europe')


-- Find the largest country (by area) in each continent,
--  show the continent, the name and the area:

SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)

-- List each continent and the name of the country that comes first alphabetically.

SELECT continent, name FROM world x
  WHERE name<= ALL
    (SELECT name FROM world y
        WHERE y.continent=x.continent)
ORDER BY name ASC


-- Find the continents where all countries have a population <= 25000000.
-- Then find the names of the countries associated with these continents.
--  Show name, continent and population.

SELECT name, continent, population 
FROM world w
WHERE NOT EXISTS (                 
   SELECT *
   FROM world nx
   WHERE nx.continent = w.continent 
   AND nx.population > 25000000     
   );


-- Some countries have populations more than three 
-- times that of any of their neighbours (in the same continent).
--  Give the countries and continents.

SELECT x.name, x.continent
FROM world x
WHERE x.population/3 > ALL (
  SELECT y.population
  FROM world y
  WHERE x.continent = y.continent
  AND x.name != y.name);