-- We continue practicing simple SQL queries on a single table.

-- This tutorial is concerned with a table of Nobel prize winners:

-- nobel(yr, subject, winner)
-- Using the SELECT statement.

-- Change the query shown so that it displays Nobel prizes for 1950.
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950

-- Show who won the 1962 prize for Literature.
 SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'

-- Show the year and subject that won 'Albert Einstein' his prize.
SELECT yr, subject
FROM nobel
WHERE winner='Albert Einstein'

-- Give the name of the 'Peace' winners since the year 2000, including 2000.
SELECT winner
FROM nobel
WHERE yr>=2000 AND subject='Peace'

-- Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive.
SELECT yr, subject, winner
FROM nobel
WHERE subject='Literature' AND yr BETWEEN 1980 AND 1989;

-- Show all details of the presidential winners:

-- Theodore Roosevelt
-- Woodrow Wilson
-- Jimmy Carter
-- Barack Obama

SELECT * FROM nobel
 WHERE subject = 'Peace'
  AND yr IN (2009,
             2002,
             1919,
             1906)


-- Show the winners with first name John
SELECT winner
FROM nobel
WHERE winner LIKE 'John%'

-- Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984.
SELECT yr, subject, winner
FROM nobel
WHERE (subject='Physics' AND yr=1980) OR (subject='Chemistry' AND yr=1984) 

-- Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine
SELECT yr, subject, winner
FROM nobel
WHERE yr=1980 AND NOT subject IN ('Chemistry', 'Medicine')

-- Show year, subject, and name of people who won a 'Medicine' prize in an early year 
-- (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year 
-- (after 2004, including 2004)

SELECT yr, subject, winner
FROM nobel
WHERE (yr<1910 AND subject='Medicine') 
OR (yr>=2004 AND subject='Literature')

-- Find all details of the prize won by PETER GRÜNBERG

SELECT * 
FROM nobel
WHERE winner='PETER GRÜNBERG'

-- Find all details of the prize won by EUGENE O'NEILL

-- Escaping single quotes
-- You can't put a single quote in a quote string directly. 
-- You can use two single quotes within a quoted string.

SELECT * 
FROM nobel
WHERE winner='EUGENE O''NEILL'

-- Knights in order

-- List the winners, year and subject where the winner starts with Sir.
-- Show the the most recent first,
-- then by name order.

SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'Sir%'
ORDER BY yr DESC, winner ASC

-- The expression subject IN ('Chemistry','Physics') can be used as a value - it will be 0 or 1.

-- Show the 1984 winners and subject ordered by subject and winner name;
--  but list Chemistry and Physics last.

SELECT winner, subject
 FROM nobel
 WHERE yr=1984
 ORDER BY  subject IN ('Chemistry','Physics') ASC,subject,winner