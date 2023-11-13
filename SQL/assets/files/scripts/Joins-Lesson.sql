USE WideWorldImporters

/* INNER JOINs */

-- What are stock items that are yellow?
SELECT StockItemName FROM Warehouse.StockItems
JOIN Warehouse.Colors ON Warehouse.StockItems.ColorID = Warehouse.Colors.ColorID
WHERE ColorName = 'Yellow'

SELECT StockItemName FROM Warehouse.StockItems
INNER JOIN Warehouse.Colors ON Warehouse.StockItems.ColorID = Warehouse.Colors.ColorID
WHERE ColorName = 'Yellow'

-- Stock Items Not Yellow, SQL Server specific
SELECT StockItemName, ColorName FROM Warehouse.StockItems
JOIN Warehouse.Colors ON Warehouse.StockItems.ColorID = Warehouse.Colors.ColorID
WHERE ColorName != 'Yellow'

-- Stock Items Not Yellow, ANSI compliant
SELECT StockItemName, ColorName FROM Warehouse.StockItems
JOIN Warehouse.Colors ON Warehouse.StockItems.ColorID = Warehouse.Colors.ColorID
WHERE ColorName <> 'Yellow'

/* Using aliases to reduce amibiguity */

-- Clarify ambiguity with aliases
SELECT Warehouse.StockItems.ColorID, StockItemName, ColorName FROM Warehouse.StockItems
JOIN Warehouse.Colors ON Warehouse.StockItems.ColorID = Warehouse.Colors.ColorID
WHERE ColorName <> 'Yellow'

-- Clarify ambiguity with short aliases
SELECT WS.ColorID, StockItemName, ColorName FROM Warehouse.StockItems WS
JOIN Warehouse.Colors C ON WS.ColorID = C.ColorID
WHERE ColorName <> 'Yellow'

/*  Working with COALESCE and JOINs */

-- Are these in Stock Groups?
SELECT StockGroupName, StockItemName
FROM Warehouse.StockItems
JOIN Warehouse.Colors ON Warehouse.StockItems.ColorID = Warehouse.Colors.ColorID
JOIN Warehouse.StockItemStockGroups ON Warehouse.StockItemStockGroups.StockItemID = Warehouse.StockItems.StockItemID
JOIN Warehouse.StockGroups ON Warehouse.StockGroups.StockGroupID = Warehouse.StockItemStockGroups.StockGroupID
WHERE ColorName = 'Yellow'

-- Using COALESCE to combine groups
DECLARE @GroupList VARCHAR(100)

SELECT @GroupList = COALESCE(@GroupList + ', ','') + StockGroupName
FROM Warehouse.StockItems
JOIN Warehouse.Colors ON Warehouse.StockItems.ColorID = Warehouse.Colors.ColorID
JOIN Warehouse.StockItemStockGroups ON Warehouse.StockItemStockGroups.StockItemID = Warehouse.StockItems.StockItemID
JOIN Warehouse.StockGroups ON Warehouse.StockGroups.StockGroupID = Warehouse.StockItemStockGroups.StockGroupID
WHERE ColorName = 'Yellow' AND  StockItemName ='Ride on toy sedan car (Yellow) 1/12 scale'

SELECT @GroupList

/* Using STRING_AGG with JOIN */

-- Using the newer STRING_AGG approach
SELECT StockItemName, STRING_AGG(StockGroupName,', ')
FROM Warehouse.StockItems
JOIN Warehouse.Colors ON Warehouse.StockItems.ColorID = Warehouse.Colors.ColorID
JOIN Warehouse.StockItemStockGroups ON Warehouse.StockItemStockGroups.StockItemID = Warehouse.StockItems.StockItemID
JOIN Warehouse.StockGroups ON Warehouse.StockGroups.StockGroupID = Warehouse.StockItemStockGroups.StockGroupID
WHERE ColorName = 'Yellow' 
GROUP BY StockItemName

--  Use an alias to give the STRING_AGG a name
SELECT StockItemName, STRING_AGG(StockGroupName,', ') GroupNames
FROM Warehouse.StockItems
JOIN Warehouse.Colors ON Warehouse.StockItems.ColorID = Warehouse.Colors.ColorID
JOIN Warehouse.StockItemStockGroups ON Warehouse.StockItemStockGroups.StockItemID = Warehouse.StockItems.StockItemID
JOIN Warehouse.StockGroups ON Warehouse.StockGroups.StockGroupID = Warehouse.StockItemStockGroups.StockGroupID
WHERE ColorName = 'Yellow' 
GROUP BY StockItemName

/* JOINing the same table multiple times */

-- How are these Yellow items packaged?  Look at both Unit Package and Outer Package.
SELECT StockItemName, UnitPackageType.PackageTypeName AS UnitPackage, OuterPackageType.PackageTypeName AS OuterPackage
FROM Warehouse.StockItems
JOIN Warehouse.Colors ON Warehouse.StockItems.ColorID = Warehouse.Colors.ColorID
JOIN Warehouse.PackageTypes AS UnitPackageType ON UnitPackageType.PackageTypeID = Warehouse.StockItems.UnitPackageID
JOIN Warehouse.PackageTypes AS OuterPackageType ON OuterPackageType.PackageTypeID = Warehouse.StockItems.OuterPackageID
WHERE ColorName = 'Yellow'

-- Suppose we want the orders from 2016 less than $1000, ordered by total, then order number. What is the query for orders less than $1000?
SELECT Sales.Orders.OrderID, SUM((Quantity * UnitPrice) + (Quantity * UnitPrice * TaxRate/100)) AS OrderTotal
FROM Sales.OrderLines
JOIN Sales.Orders ON Sales.Orders.OrderID = Sales.OrderLines.OrderID
WHERE YEAR(OrderDate) = 2016
GROUP BY Sales.Orders.OrderID
HAVING SUM((Quantity * UnitPrice) + (Quantity * UnitPrice * TaxRate/100)) < 1000.00
ORDER BY OrderTotal, Sales.Orders.OrderID

/* JOIN with HAVING */

-- Suppose we want the orders from 2016 less than $1000, ordered by total, then order number. What is the query for orders less than $1000?
SELECT Sales.Orders.OrderID, SUM((Quantity * UnitPrice) + (Quantity * UnitPrice * TaxRate/100)) AS OrderTotal
FROM Sales.OrderLines
JOIN Sales.Orders ON Sales.Orders.OrderID = Sales.OrderLines.OrderID
WHERE YEAR(OrderDate) = 2016
GROUP BY Sales.Orders.OrderID
HAVING SUM((Quantity * UnitPrice) + (Quantity * UnitPrice * TaxRate/100)) < 1000.00
ORDER BY OrderTotal, Sales.Orders.OrderID

-- With the INNER keyword
SELECT Sales.Orders.OrderID, SUM((Quantity * UnitPrice) + (Quantity * UnitPrice * TaxRate/100)) AS OrderTotal
FROM Sales.OrderLines
INNER JOIN Sales.Orders ON Sales.Orders.OrderID = Sales.OrderLines.OrderID
WHERE YEAR(OrderDate) = 2016
GROUP BY Sales.Orders.OrderID
HAVING SUM((Quantity * UnitPrice) + (Quantity * UnitPrice * TaxRate/100)) < 1000.00
ORDER BY OrderTotal, Sales.Orders.OrderID

-- This only includes stock items with colors.  We need to segue into outer joins.
SELECT StockItemName, Warehouse.StockItems.ColorID 
FROM Warehouse.StockItems
INNER JOIN Warehouse.Colors ON Warehouse.StockItems.ColorID = Warehouse.Colors.ColorID
WHERE ColorName <> 'Yellow'

/* OUTER JOINS */

-- LEFT OUTER
SELECT TOP 5 StockItemName, ColorName
FROM Warehouse.StockItems AS StockItems 
LEFT JOIN Warehouse.Colors AS Colors ON StockItems.ColorID = Colors.ColorID

-- LEFT OUTER with NULL right key
SELECT TOP 5 StockItemName, ColorName
FROM Warehouse.StockItems AS StockItems 
LEFT OUTER JOIN Warehouse.Colors AS Colors ON StockItems.ColorID = Colors.ColorID
WHERE Colors.ColorID IS NULL

-- RIGHT OUTER
SELECT TOP 5 StockItemName, ColorName
FROM Warehouse.StockItems AS StockItems 
RIGHT JOIN Warehouse.Colors AS Colors ON StockItems.ColorID = Colors.ColorID

-- RIGHT OUTER with NULL left key
SELECT TOP 5 StockItemName, ColorName
FROM Warehouse.StockItems AS StockItems 
RIGHT OUTER JOIN Warehouse.Colors AS Colors ON StockItems.ColorID = Colors.ColorID
WHERE StockItems.ColorID IS NULL

-- FULL OUTER
SELECT TOP 5 StockItemName, ColorName
FROM Warehouse.StockItems AS StockItems 
FULL JOIN Warehouse.Colors AS Colors ON StockItems.ColorID = Colors.ColorID

-- FULL OUTER with either key NULL
SELECT TOP 100 StockItemName, ColorName
FROM Warehouse.StockItems AS StockItems 
FULL OUTER JOIN Warehouse.Colors AS Colors ON StockItems.ColorID = Colors.ColorID
WHERE StockItems.ColorID IS NULL OR Colors.ColorID IS NULL