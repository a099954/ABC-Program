USE WideWorldImporters

/* Using Subqueries with Existence - EXISTS and NOT EXISTS */

-- How many countries do not have states or provinces?  Use NOT EXISTS
SELECT COUNT(DISTINCT CountryName) FROM Application.Countries C WHERE NOT EXISTS (SELECT CountryID from Application.StateProvinces SP WHERE SP.CountryID = C.CountryID)

-- How many countries do not have states or provinces?  Use LEFT JOIN
SELECT COUNT(DISTINCT CountryName) FROM Application.Countries C 
LEFT JOIN Application.StateProvinces SP ON C.CountryID = SP.CountryID
WHERE SP.CountryID IS NULL

-- How many countries states or provinces?  Use EXISTS
SELECT COUNT(DISTINCT CountryName) FROM Application.Countries C WHERE EXISTS (SELECT CountryID from Application.StateProvinces SP WHERE SP.CountryID = C.CountryID)

/* Using Subqueries in WHERE Clauses */

-- Using a subquery as a WHERE clause.  Identify the city with the largest recorded population.
SELECT CityName FROM Application.Cities WHERE LatestRecordedPopulation IN (SELECT MAX(LatestRecordedPopulation) FROM Application.Cities)


-- As a WHERE clause not using IN.  Get the cities and populations where their population is greater than the average recorded population.
SELECT CityName, LatestRecordedPopulation
FROM Application.Cities
WHERE LatestRecordedPopulation > (SELECT AVG(LatestRecordedPopulation) FROM Application.Cities)


/* Using Subqueries in SELECT Clauses */


-- Can't do this -- uncomment and run to see the error message
-- SELECT CityName, LatestRecordedPopulation, (SELECT AVG(LatestRecordedPopulation) AveragePop, MAX(LatestRecordedPopulation) HighestPop FROM Application.Cities) AS AveragePopulation
-- FROM Application.Cities

-- Get a count of cities by province and a total count of unique provinces
SELECT StateProvinceID, COUNT(DISTINCT CityID) AS CityCount, (SELECT COUNT(DISTINCT StateProvinceID) FROM Application.Cities) AS StateCount
FROM Application.Cities
GROUP BY StateProvinceID

/* Using Subqueries in HAVING Clauses */

-- Getting all cities with populations above the average population as well as the sum of populations by state (for cities over average) and sum of populations by state overall
SELECT InvoiceID, SUM(ExtendedPrice) AS InvoiceTotal
FROM Sales.InvoiceLines
GROUP BY InvoiceID
HAVING SUM(ExtendedPrice) < (SELECT AVG(ExtendedPrice) FROM Sales.InvoiceLines)