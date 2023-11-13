USE SouvenirsRUs
GO

/* Video games need to be broken out from the Toy category.  Add a category for Video Game.  
Update the souvenirs that are video games with the new category.  
This may require you looking at the data carefully to identify video games. */
IF NOT EXISTS (SELECT CategoryID FROM Category WHERE Name='Video Game') BEGIN
    INSERT INTO Category (Name) VALUES ('Video Game')
END

UPDATE Souvenir SET CategoryID= (SELECT CategoryID FROM Category WHERE Name='Video Game')
WHERE ItemDescription LIKE '%video game%'

/* - Jewelry boxes should be recategorized as Miscellaneous. */

UPDATE Souvenir SET CategoryID= (SELECT CategoryID FROM Category WHERE Name='Miscellaneous')
WHERE Name LIKE '%jewelry%box%'

/* Shamisen, Egyptian Drum, and Zuffolo need to be broken out as Musical Instruments.*/
IF NOT EXISTS (SELECT CategoryID FROM Category WHERE Name='Musical Instrument') BEGIN
    INSERT INTO Category (Name) VALUES ('Musical Instrument')
END

UPDATE Souvenir SET CategoryID= (SELECT CategoryID FROM Category WHERE Name='Musical Instrument')
WHERE Name IN ('Shamisen','Zuffolo','Egyptian Drum')

/* - Delete the souvenir that is the heaviest.  This is causing trouble in graphing data and is an outlier we want to exclude. */
DELETE FROM Souvenir
WHERE Weight = (SELECT MAX(Weight) FROM Souvenir)

/* - Delete *all* souvenirs that are dirt or sand.
 */
 DELETE FROM Souvenir
 WHERE Name LIKE '%-dirt' OR Name LIKE '%-sand'

/* - Get the 3 most inexpensive souvenirs. Then get the 7 most expensive souvenirs. */
SELECT TOP 3 Name, Price
FROM Souvenir
ORDER BY Price

SELECT TOP 7 Name, Price
FROM Souvenir
ORDER BY Price DESC

/* - List all mugs, ordered from heaviest to lightest.*/
SELECT Name, Weight
FROM Souvenir
WHERE Name LIKE '%Mug'
ORDER BY Weight DESC

/* - Count the number of spoons in the collection.*/
SELECT COUNT(Name)
FROM Souvenir
WHERE Name LIKE '%spoon%'

/* - Find the average weight, minimum weight, and maximum weight for each category by name.
Use meaningful alias names for the aggregates.
*/
SELECT CG.Name, AVG(Weight) AvgWeight, MIN(Weight) MinWeight, MAX(Weight) MaxWeight
FROM Souvenir S
INNER JOIN Category CG ON CG.CategoryID = S.CategoryID
GROUP BY CG.Name

/* - List all kitchenware souvenirs and their general location fields - including city name, region name, country name, longitude, and latitude - without duplication.*/

SELECT S.Name, CT.Name, R.Name, C.Name, Latitude, Longitude
FROM Souvenir S
LEFT OUTER JOIN City CT ON CT.CityID = S.CityID
LEFT OUTER JOIN Region R ON R.RegionID = CT.RegionID
LEFT OUTER JOIN Country C ON C.CountryID = R.CountryID
LEFT OUTER JOIN Location L ON L.LocationID = S.LocationID
INNER JOIN Category CG ON CG.CategoryID = S.CategoryID
WHERE CG.Name = 'Kitchenware'

/* - Find the earliest and latest obtained date for each owner, ordered by the earliest of the earliest dates to the latest of the earliest dates.*/

SELECT O.Name, MIN(DateObtained) EarliestDate, MAX(DateObtained) LatestDate
FROM Souvenir S
INNER JOIN Owner O ON O.OwnerID = S.OwnerID
GROUP BY O.Name
ORDER BY EarliestDate

/* - What is the most popular date for the souvenirs?  Store this date in a variable.  Find all souvenirs obtained on that date.*/

DECLARE @PopularDate date

-- Find the most popular date
SELECT TOP 1 DateObtained, COUNT(Name) NumberOfSouvenirs
FROM Souvenir
GROUP BY DateObtained
ORDER BY NumberOfSouvenirs DESC

SET @PopularDate = '2021-05-18'

SELECT Name
FROM Souvenir
WHERE DateObtained = @PopularDate

/* - Find all souvenirs that do not have a latitude and longitude.*/

SELECT S.Name, Latitude, Longitude
FROM Souvenir S
LEFT OUTER JOIN Location L ON L.LocationID = S.LocationID
WHERE Latitude IS NULL and Longitude IS NULL

/* - Find all souvenirs that do not have a city, region, and country.*/

SELECT S.Name, CT.Name, R.Name, C.Name
FROM Souvenir S
LEFT OUTER JOIN City CT ON CT.CityID = S.CityID
LEFT OUTER JOIN Region R ON R.RegionID = CT.RegionID
LEFT OUTER JOIN Country C ON C.CountryID = R.CountryID
WHERE CT.Name IS NULL and R.Name IS NULL and C.Name IS NULL

/* - Find all souvenirs - name, city name, region name, country name, latitude,longitude, and weight - heavier than the average weight for all souvenirs.  Use a subquery in a WHERE clause to achieve this.*/
SELECT S.Name, CT.Name, R.Name, C.Name, Latitude, Longitude, Weight, (SELECT AVG(Weight) FROM Souvenir) AvgWeight
FROM Souvenir S
LEFT OUTER JOIN City CT ON CT.CityID = S.CityID
LEFT OUTER JOIN Region R ON R.RegionID = CT.RegionID
LEFT OUTER JOIN Country C ON C.CountryID = R.CountryID
LEFT OUTER JOIN Location L ON L.LocationID = S.LocationID
INNER JOIN Category CG ON CG.CategoryID = S.CategoryID
WHERE Weight > (SELECT AVG(Weight) FROM Souvenir)

/* - Find the most expensive and least expensive souvenirs in each category.*/

-- Subquery
SELECT S.Name SouvenirName, Price, CG.Name CategoryName 
FROM Souvenir S
INNER JOIN Category CG ON CG.CategoryID = S.CategoryID
INNER JOIN (SELECT CategoryID, MAX(Price) MaxPrice, MIN(Price) MinPrice
FROM Souvenir S
GROUP BY CategoryID) CP ON CP.CategoryID = S.CategoryID
WHERE S.Price = CP.MaxPrice OR S.Price = CP.MinPrice
ORDER BY CategoryName, Price

-- CTE approach
WITH category_prices AS
(SELECT CategoryID, MAX(Price) MaxPrice, MIN(Price) MinPrice
FROM Souvenir S
GROUP BY CategoryID)
SELECT S.Name SouvenirName, Price, CG.Name CategoryName 
FROM Souvenir S
INNER JOIN Category CG ON CG.CategoryID = S.CategoryID
INNER JOIN category_prices CP ON CP.CategoryID = S.CategoryID
WHERE S.Price = CP.MaxPrice OR S.Price = CP.MinPrice
ORDER BY CategoryName, Price
