-- List the films where the yr is 1962 [Show id, title]
SELECT id, title
 FROM movie
 WHERE yr=1962

--  Give year of 'Citizen Kane'.
SELECT yr
FROM movie
WHERE title='Citizen Kane'

-- List all of the Star Trek movies, include the id, title and yr 
-- (all of these movies include the words Star Trek in the title). 
-- Order results by year.
SELECT id, title, yr
FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr

-- What id number does the actor 'Glenn Close' have?
SELECT id
FROM actor
WHERE name='Glenn Close'

-- What is the id of the film 'Casablanca'
SELECT id
FROM movie
WHERE title='Casablanca'

-- Obtain the cast list for 'Casablanca'.

-- what is a cast list?
-- Use movieid=11768, 
-- (or whatever value you got from the previous question)

SELECT name
FROM casting JOIN actor ON id=actorid
WHERE movieid=11768

-- Obtain the cast list for the film 'Alien'

SELECT name
FROM movie JOIN casting ON movie.id=movieid
JOIN actor ON actor.id=casting.actorid
WHERE title='Alien'

-- List the films in which 'Harrison Ford' has appeared
SELECT title
FROM movie JOIN casting ON movie.id=movieid
JOIN actor ON actor.id=casting.actorid
WHERE actor.name='Harrison Ford'

-- Harrison Ford as a supporting actor
-- List the films where 'Harrison Ford' has appeared -
--  but not in the starring role. 
-- [Note: the ord field of casting gives the position of the actor.
--  If ord=1 then this actor is in the starring role]

SELECT title
FROM movie JOIN casting ON movie.id=movieid
JOIN actor ON actor.id=casting.actorid
WHERE actor.name='Harrison Ford' AND casting.ord <> 1

-- List the films together with the leading star for all 1962 films

SELECT title, name
FROM movie JOIN casting ON movie.id=movieid
JOIN actor ON actor.id=casting.actorid
WHERE movie.yr=1962 AND casting.ord=1

-- Which were the busiest years for 'Rock Hudson', 
-- show the year and the number of movies he made 
-- each year for any year in which he made more than 2 movies.

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2


-- List the film title and the leading actor for all of the films 'Julie Andrews' played in.

-- Did you get "Little Miss Marker twice"?
-- Julie Andrews starred in the 1980 remake of Little Miss Marker and not the original(1934).

-- Title is not a unique field, create a table of IDs in your subquery

SELECT title, name FROM 
movie JOIN casting ON (movie.id = movieid)
JOIN actor ON (actor.id = actorid)
WHERE ord = 1 AND movieid IN (
SELECT movieid FROM 
casting JOIN actor ON (actor.id = actorid)
WHERE name = 'Julie Andrews')

-- Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles

SELECT name FROM
	actor JOIN casting ON (actorid = actor.id)
	WHERE ord = 1 
	GROUP BY name
	HAVING COUNT(movieid) >= 30
	ORDER BY name

-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT title, COUNT(*)  FROM
	movie JOIN casting ON (movie.id = movieid)
	WHERE yr = 1978	
	GROUP BY title
	ORDER BY COUNT(*) DESC, title

-- List all the people who have worked with 'Art Garfunkel'.

SELECT name FROM
actor JOIN casting on (actor.id = actorid)
WHERE movieid IN (SELECT movieid FROM 
casting JOIN actor on (actor.id = actorid)
WHERE name = 'Art Garfunkel') AND name <> 'Art Garfunkel'