USE WideWorldImporters;

-- What is the average typical weight per unit for warehouse stock items? 
SELECT AVG(TypicalWeightPerUnit) FROM Warehouse.StockItems

-- What are the heaviest and lightest stock items - based on typical weight per unit?
-- Use SQL variables to store the minimum and maximum values.
-- Then build a query off of those results.

DECLARE @HeaviestWeight decimal(18,3)
DECLARE @LightestWeight decimal(18,3)

SELECT @HeaviestWeight = MAX(TypicalWeightPerUnit), @LightestWeight = MIN(TypicalWeightPerUnit) FROM Warehouse.StockItems

SELECT StockItemName, TypicalWeightPerUnit 
FROM Warehouse.StockItems 
WHERE TypicalWeightPerUnit = @HeaviestWeight OR TypicalWeightPerUnit = @LightestWeight

-- Create a list of brands and their total stock items in the warehouse. Sort it by the most items items to least items, then alphabetical by brand.
SELECT Brand, Count(StockItemID) AS StockItemCount
FROM Warehouse.StockItems
GROUP BY Brand
ORDER BY StockItemCount DESC, Brand

-- How many temperature sensor recordings are there for the vehicle temperatures? 
SELECT COUNT(VehicleTemperatureID) AS TemperatureCount, MIN(RecordedWhen) AS EarliestDate, MAX(RecordedWhen) AS LatestDate
FROM Warehouse.VehicleTemperatures

-- Get the VehicleRegistration, ChillerSensorNumber, Min temperature, Max temperature,  Average temperature, number of readings, and number of unique vehicle registrations for the month of March 2016.  Order by vehicle registration and chiller sensor number.
-- The date range makes a difference for the BETWEEN and <= and >= ranges.
-- You can get those specific values from MIN and MAX RecordedWhen values.

SELECT VehicleRegistration, ChillerSensorNumber, MIN(Temperature) AS MinTemperature, MAX(Temperature) AS MaxTemperature, AVG(Temperature) AS AverageTemperature, COUNT(VehicleTemperatureID) AS NumberOfReadings,COUNT(DISTINCT VehicleRegistration) AS NumberOfVehicles
FROM Warehouse.VehicleTemperatures
WHERE YEAR(RecordedWhen) = 2016 AND MONTH(RecordedWhen) = 3
GROUP BY VehicleRegistration, ChillerSensorNumber
ORDER BY VehicleRegistration, ChillerSensorNumber

SELECT VehicleRegistration, ChillerSensorNumber, MIN(Temperature) AS MinTemperature, MAX(Temperature) AS MaxTemperature, AVG(Temperature) AS AverageTemperature, COUNT(VehicleTemperatureID) AS NumberOfReadings,COUNT(DISTINCT VehicleRegistration) AS NumberOfVehicles
FROM Warehouse.VehicleTemperatures
WHERE RecordedWhen BETWEEN '2016-03-01 00:00:00.0000000' AND '2016-03-31 23:59:59.9999999'
GROUP BY VehicleRegistration, ChillerSensorNumber
ORDER BY VehicleRegistration, ChillerSensorNumber

SELECT VehicleRegistration, ChillerSensorNumber, MIN(Temperature) AS MinTemperature, MAX(Temperature) AS MaxTemperature, AVG(Temperature) AS AverageTemperature, COUNT(VehicleTemperatureID) AS NumberOfReadings,COUNT(DISTINCT VehicleRegistration) AS NumberOfVehicles
FROM Warehouse.VehicleTemperatures
WHERE RecordedWhen >= '2016-03-01 00:00:00.0000000' AND RecordedWhen <= '2016-03-31 23:59:59.9999999'
GROUP BY VehicleRegistration, ChillerSensorNumber
ORDER BY VehicleRegistration, ChillerSensorNumber

-- Let's start by looking at the order lines for Order 1163
SELECT * FROM Sales.OrderLines WHERE OrderID = 1163

-- Now let's get the total for these order lines for Order 11663
SELECT OrderID, SUM((Quantity * UnitPrice) + (Quantity * UnitPrice * TaxRate/100))
FROM Sales.OrderLines
WHERE OrderID = 1163
GROUP BY OrderID

-- Are there any orders where Quantity and PickedQuantity don't match? Let's count the order lines
SELECT COUNT(OrderLineID) FROM Sales.OrderLines WHERE Quantity != PickedQuantity

-- Let's see what orders have outstanding quantities and how many quantites are still outstanding for each order.
SELECT OrderID, SUM(Quantity-PickedQuantity) AS OutstandingQuantity
FROM Sales.OrderLines
WHERE Quantity <> PickedQuantity
GROUP BY OrderID

-- What is the query for getting individual orders' totals?
SELECT OrderID, SUM((Quantity * UnitPrice) + (Quantity * UnitPrice * TaxRate/100))
FROM Sales.OrderLines
GROUP BY OrderID

-- Suppose we want the orders less than $1000. What is the query for orders less than $1000?
SELECT OrderID, SUM((Quantity * UnitPrice) + (Quantity * UnitPrice * TaxRate/100)) AS OrderTotal
FROM Sales.OrderLines
GROUP BY OrderID
HAVING SUM((Quantity * UnitPrice) + (Quantity * UnitPrice * TaxRate/100)) < 1000.00