USE WideWorldImporters

/* Minimum, Maximum, and Average */

-- What is the average typical weight per unit for warehouse stock items? 
SELECT AVG(TypicalWeightPerUnit) FROM Warehouse.StockItems

-- Average typical weight per unit by supplier?
SELECT SupplierID, AVG(TypicalWeightPerUnit) AverageTypicalWeightPerUnit
FROM Warehouse.StockItems
GROUP BY SupplierID


-- What is the minimum temperature, maximum temperature, and average cold room temperature for the room overall?
SELECT MIN(Temperature) AS MinTemperature, MAX(Temperature) AS MaxTemperature, AVG(Temperature) AS AverageTemperature
FROM Warehouse.ColdRoomTemperatures

-- What are the average discount amount and discount percentage for special deals? Remember to use aliases to label your columns.
SELECT AVG(DiscountAmount) AS AverageDiscountAmount, AVG(DiscountPercentage) AS AverageDiscountPercent 
FROM Sales.SpecialDeals

-- What are the minimum and maximum discount percentages for special deals? Remember to use aliases to label your columns.
SELECT MIN(DiscountPercentage) AS MinDiscountPercent, MAX(DiscountPercentage) AS MaxDiscountPercent 
FROM Sales.SpecialDeals

/* COUNT and COUNT(DISTINCT) and GROUP BY */

-- Show a list of discount percents with the count of special deals for the respective percentage.  Label the counts as Special Deal Counts.
SELECT DiscountPercentage, COUNT(DiscountPercentage) AS SpecialDealCounts 
FROM Sales.SpecialDeals
GROUP BY DiscountPercentage

-- Show the count of transactions and the count of unique suppliers from the supplier transactions.
SELECT COUNT(SupplierID) AS TransactionCount, COUNT(DISTINCT SupplierID) AS SupplierCount
FROM Purchasing.SupplierTransactions

SELECT COUNT(SupplierTransactionID), SupplierID
FROM Purchasing.SupplierTransactions
WHERE OutstandingBalance > 0

-- Show a comma-delimited list of states for each sales territory

SELECT SalesTerritory, STRING_AGG(StateProvinceCode,', ') AS StatesList
FROM Application.StateProvinces
GROUP BY SalesTerritory

/* Working with SQL Variables */

-- What are the most populated and least populated countries in Application.Countries?
-- Use SQL variables to store the minimum and maximum values.
-- Then build a query off of those results.

DECLARE @HighestPopulation bigint
DECLARE @SmallestPopulation bigint

SELECT @HighestPopulation = MAX(LatestRecordedPopulation), @SmallestPopulation = MIN(LatestRecordedPopulation) 
FROM Application.Countries

SELECT CountryName, LatestRecordedPopulation 
FROM Application.Countries 
WHERE LatestRecordedPopulation = @HighestPopulation OR LatestRecordedPopulation = @SmallestPopulation

/* GROUP BY and ORDER BY */

-- Create a list of delivery postal codes and their total customers. Sort it by the most customers to least customers, then alphabetical by postal code.
SELECT DeliveryPostalCode, Count(CustomerID) AS CustomerCount
FROM Sales.Customers
GROUP BY DeliveryPostalCode
ORDER BY CustomerCount DESC, DeliveryPostalCode

/* GROUP BY and ORDER BY with WHERE */

-- How many temperature sensor recordings are there for the cold room? 
SELECT COUNT(ColdRoomTemperatureID) AS TemperatureCount, MIN(RecordedWhen) AS EarliestDate, MAX(RecordedWhen) AS LatestDate
FROM Warehouse.ColdRoomTemperatures

-- Get the ColdRoomSensorNumber, Min temperature, Max temperature,  Average temperature, number of readings for the month of May 2016.  Order by sensor number.
-- The date range makes a difference for the BETWEEN and <= and >= ranges.
-- You can get those specific values from MIN and MAX RecordedWhen values.

SELECT ColdRoomSensorNumber, MIN(Temperature) AS MinTemperature, MAX(Temperature) AS MaxTemperature, AVG(Temperature) AS AverageTemperature, COUNT(ColdRoomTemperatureID) AS NumberOfReadings
FROM Warehouse.ColdRoomTemperatures
WHERE YEAR(RecordedWhen) = 2016 AND MONTH(RecordedWhen) = 5
GROUP BY ColdRoomSensorNumber
ORDER BY ColdRoomSensorNumber

SELECT ColdRoomSensorNumber, MIN(Temperature) AS MinTemperature, MAX(Temperature) AS MaxTemperature, AVG(Temperature) AS AverageTemperature, COUNT(ColdRoomTemperatureID) AS NumberOfReadings
FROM Warehouse.ColdRoomTemperatures
WHERE RecordedWhen BETWEEN '2016-05-01 00:00:00.0000000' AND '2016-05-31 23:59:59.9999999'
GROUP BY ColdRoomSensorNumber
ORDER BY ColdRoomSensorNumber

SELECT ColdRoomSensorNumber, MIN(Temperature) AS MinTemperature, MAX(Temperature) AS MaxTemperature, AVG(Temperature) AS AverageTemperature, COUNT(ColdRoomTemperatureID) AS NumberOfReadings
FROM Warehouse.ColdRoomTemperatures
WHERE RecordedWhen >= '2016-05-01 00:00:00.0000000' AND RecordedWhen <= '2016-05-31 23:59:59.9999999'
GROUP BY ColdRoomSensorNumber
ORDER BY ColdRoomSensorNumber

/* Having Clause */

-- Suppose we want the invoices greater than $30000. What is the query for invoices greater than $30000?
SELECT InvoiceID, SUM(ExtendedPrice) AS InvoiceTotal
FROM Sales.InvoiceLines
GROUP BY InvoiceID
HAVING SUM(ExtendedPrice) > 30000.00

-- We want to see customers who were invoiced for both dry items and chiller items in 2016
-- Order by the most dry items, then the most chiller items, and finally the customer ID
SELECT CustomerID, SUM(TotalDryItems) TotalDryItems, SUM(TotalChillerItems) TotalChillerItems
FROM Sales.Invoices
WHERE YEAR(InvoiceDate) = 2016
GROUP BY CustomerID
HAVING SUM(TotalDryItems) > 0 AND SUM(TotalChillerItems) > 0
ORDER BY SUM(TotalDryItems) DESC, SUM(TotalChillerItems) DESC, CustomerID