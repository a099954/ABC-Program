USE SouvenirsDB
GO

/* - Get the 3 most inexpensive souvenirs. Then get the 7 most expensive souvenirs. */
SELECT TOP 3 Souvenir_Name, Price
FROM souvenirs
ORDER BY Price

SELECT TOP 7 Souvenir_Name, Price
FROM souvenirs
ORDER BY Price DESC

/* - List all mugs, ordered from heaviest to lightest.*/
SELECT Souvenir_Name, Weight
FROM souvenirs
WHERE Souvenir_Name LIKE '%Mug'
ORDER BY Weight DESC

/* - Count the number of spoons in the collection.*/
SELECT COUNT(Souvenir_Name)
FROM souvenirs
WHERE Souvenir_Name LIKE '%spoon%'

/* - Find the average weight, minimum weight, and maximum weight for each category by name.
Use meaningful alias names for the aggregates.
*/
SELECT Category, AVG(Weight), MIN(Weight), MAX(Weight)
FROM souvenirs
GROUP BY Category

/* - List all kitchenware souvenirs and their general location fields - including city name, region name, country name, longitude, and latitude - without duplication.*/

SELECT DISTINCT Souvenir_Name, City, Region, Country, Latitude, Longitude
FROM souvenirs
WHERE Category = 'Kitchenware'

/* - Find the earliest and latest obtained date for each owner, ordered by the earliest of the earliest dates to the latest of the earliest dates.*/

SELECT Owner, MIN(DateObtained), MAX(DateObtained)
FROM souvenirs
GROUP BY Owner
ORDER BY MIN(DateObtained)

/* - What is the most popular date for the souvenirs?  Store this date in a variable.  Find all souvenirs obtained on that date.*/

-- Find the most popular date, save value as variable, use to query for souvenirs
SELECT TOP 1 DateObtained, COUNT(Souvenir_Name)
FROM souvenirs
GROUP BY DateObtained
ORDER BY COUNT(Souvenir_Name) DESC

DECLARE @PopularDate date = '2021-05-18'

SELECT Souvenir_Name
FROM souvenirs
WHERE DateObtained = @PopularDate

-- ALTERNATIVE VARIABLE SOLUTION - save most popular date as variable directly, use to query for souvenirs

DECLARE @PopularDate date
SELECT @PopularDate = DateObtained
FROM souvenirs
GROUP BY DateObtained
ORDER BY COUNT(Souvenir_Name) ASC

SELECT Souvenir_Name
FROM souvenirs
WHERE DateObtained = @PopularDate


-- SUBQUERY SOLUTION (without VARIABLE) - query for souvenirs where date is the most popular date (from subquery)

SELECT Souvenir_Name
FROM souvenirs
WHERE DateObtained = (SELECT TOP 1 DateObtained
                      FROM souvenirs
                      GROUP BY DateObtained
                      ORDER BY COUNT(Souvenir_Name) DESC)


/* - Find all souvenirs that do not have a latitude and longitude.*/

SELECT Souvenir_Name, Latitude, Longitude
FROM souvenirs
WHERE (Latitude IS NULL) AND (Longitude IS NULL)

/* - Find all souvenirs that do not have a city, region, and country.*/

SELECT Souvenir_Name, City, Region, Country
FROM souvenirs
WHERE Country IS NULL and Region IS NULL and City IS NULL

/* - Find all souvenirs - name, city name, region name, country name, latitude, longitude, and weight - heavier than the average weight for all souvenirs.  Use a subquery in a WHERE clause to achieve this.*/
SELECT Souvenir_Name, City, Region, Country, Latitude, Longitude, Weight,
    (SELECT AVG(Weight) FROM souvenirs)
FROM souvenirs
WHERE Weight > (SELECT AVG(Weight) FROM souvenirs)

/* - Find the minimum and maximum price for souvenirs by category.*/

SELECT Category, MIN(Price), MAX(Price)
FROM souvenirs
GROUP BY Category
ORDER BY Category

/* - Find the three most expensive souvenir categories on average.*/

SELECT TOP 3 Category, AVG(Price)
FROM souvenirs
GROUP BY Category
ORDER BY AVG(Price) DESC

/* - Find the three least expensive souvenir categories on average.*/

SELECT TOP 3 Category, AVG(Price)
FROM souvenirs
GROUP BY Category
ORDER BY AVG(Price) ASC

/* Write a SQL statement that will return all the souvenirs, date descending.*/

SELECT *
FROM souvenirs
ORDER BY DateObtained DESC

/* Find the count of all the souvenirs by month obtained.*/

SELECT MONTH(DateObtained), COUNT(Souvenir_Name)
FROM souvenirs
GROUP BY MONTH(DateObtained)

/* Find out how many days each souvenir has been in our collection. Order the results from the fewest days to the most.
    - HINT: The `GETDATE()` and `DATEDIFF()` functions will come in handy for this. */

SELECT Souvenir_Name, DATEDIFF(d, DateObtained, GETDATE()), DateObtained
FROM souvenirs
ORDER BY DATEDIFF(d, DateObtained, GETDATE()) ASC 

/* Find out how many souvenirs have been in our collection for more than 15 years and less than 20 years.*/
-- To get all the souvenirs
SELECT Souvenir_Name, DATEDIFF(YY, DateObtained, GETDATE()), DateObtained
FROM souvenirs
WHERE DATEDIFF(YY, DateObtained, GETDATE()) >= 15
    AND DATEDIFF(YY, DateObtained, GETDATE()) <= 20
ORDER BY DATEDIFF(YY, DateObtained, GETDATE()) DESC 

-- To get the count of souvenirs
SELECT COUNT(Souvenir_Name)
FROM souvenirs
WHERE DATEDIFF(YY, DateObtained, GETDATE()) >= 15
    AND DATEDIFF(YY, DateObtained, GETDATE()) <= 20

/* For all souvenirs that have been in our collection for 20 or more years, get the count, minimum price, average price, and maximum price by category.*/

SELECT Category, COUNT(Souvenir_Name), MIN(Price), AVG(Price), MAX(Price)
FROM souvenirs
WHERE DATEDIFF(YY, DateObtained, GETDATE()) >= 20
GROUP BY Category

/* Find the average price by category for all souvenirs that start with the word "Hand".*/

SELECT Category, AVG(Price)
FROM souvenirs
WHERE Souvenir_Name LIKE 'Hand%'
GROUP BY Category

/* Find the number of souvenirs in each category by country for all souvenirs from Australia, Italy, Tanzania, or South Korea. Order the results by country and category name, both ascending.*/

SELECT Country, Category, COUNT(Souvenir_Name)
FROM souvenirs
WHERE Country IN ('Australia', 'Tanzania', 'Italy', 'South Korea')
GROUP BY Country, Category
ORDER BY Country ASC, Category ASC

