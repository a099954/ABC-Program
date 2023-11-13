USE WideWorldImporters

/* Existence */

-- All stock items that have Blue colors
-- We just need the stock item's name and don't care about the color's name.
SELECT DISTINCT StockItemName FROM Warehouse.StockItems WHERE EXISTS 
(SELECT ColorName FROM Warehouse.Colors WHERE Warehouse.Colors.ColorID = Warehouse.StockItems.ColorID AND ColorName LIKE '%Blue%')

-- Stock items without Blue colors -- includes NULL
SELECT DISTINCT StockItemName, ColorID FROM Warehouse.StockItems WHERE NOT EXISTS 
(SELECT ColorName FROM Warehouse.Colors WHERE Warehouse.Colors.ColorID = Warehouse.StockItems.ColorID AND ColorName LIKE '%Blue%')

-- Stock items without colors
-- Doing this here to remind them that it's easy to overcomplicate queries
-- Don't to a join unless necessary
SELECT DISTINCT StockItemName FROM Warehouse.StockItems WHERE ColorID IS NULL

/* WHERE clauses */

-- What are stock items and their suppliers for packaging suppliers? Use a subquery in an IN clause.
SELECT StockItemName, SupplierName FROM Warehouse.StockItems
JOIN Purchasing.Suppliers ON Purchasing.Suppliers.SupplierID = Warehouse.StockItems.SupplierID
WHERE SupplierCategoryID IN (SELECT SupplierCategoryID FROM Purchasing.SupplierCategories WHERE SupplierCategoryName LIKE '%Packaging%' OR SupplierCategoryName LIKE '%Other%' )

-- What stock items and suppliers from packaging suppliers had transactions in 2014?
SELECT StockItemName, SupplierName FROM Warehouse.StockItems
JOIN Purchasing.Suppliers ON Purchasing.Suppliers.SupplierID = Warehouse.StockItems.SupplierID
WHERE SupplierCategoryID IN (SELECT SupplierCategoryID FROM Purchasing.SupplierCategories WHERE SupplierCategoryName LIKE '%Packaging%' OR SupplierCategoryName LIKE '%Other%' )
AND EXISTS (Select distinct StockItemID FROM Warehouse.StockItemTransactions WHERE YEAR(TransactionOccurredWhen) = 2014 AND Warehouse.StockItems.StockItemID = Warehouse.StockItemTransactions.StockItemID)

-- What suppliers from toy suppliers had transactions in 2015?  How many individual stock items did those suppliers have in 2015?
SELECT SupplierName, COUNT (DISTINCT StockItemID) TotalUniqueItems FROM Warehouse.StockItems
JOIN Purchasing.Suppliers ON Purchasing.Suppliers.SupplierID = Warehouse.StockItems.SupplierID
WHERE SupplierCategoryID IN (SELECT SupplierCategoryID FROM Purchasing.SupplierCategories WHERE SupplierCategoryName LIKE '%Toy%')
AND EXISTS (Select distinct StockItemID FROM Warehouse.StockItemTransactions WHERE YEAR(TransactionOccurredWhen) = 2015 AND Warehouse.StockItemTransactions.StockItemID = Warehouse.StockItems.StockItemID)
GROUP BY SupplierName

/* SELECT as a result value */

-- Get a list of category IDs, supplier count for the category, and total supplier count
SELECT SupplierCategoryID, COUNT(SupplierName) AS SupplierCountByCategory, (SELECT COUNT(SupplierID) FROM Purchasing.Suppliers) AS TotalSupplierCount
FROM Purchasing.Suppliers
GROUP BY SupplierCategoryID

-- Get a list of supplier category names, supplier count for the category, and total supplier count, including the category name rather than the category id
SELECT SupplierCategoryName, COUNT(SupplierName) AS SupplierCountByCategory, (SELECT COUNT(SupplierID) FROM Purchasing.Suppliers) AS TotalSupplierCount
FROM Purchasing.Suppliers S
JOIN Purchasing.SupplierCategories SC ON S.SupplierCategoryID = SC.SupplierCategoryID
GROUP BY SupplierCategoryName

/* HAVING statement */

-- Getting transactions above the average transaction amount as well as the sum of transaction amount by supplier (for transactions over average) and sum of transactions by supplier overall for 'A Datum Corporation'
SELECT SupplierName, TransactionAmount,
SUM(TransactionAmount) OVER(PARTITION BY ST1.SupplierID) AS SupplierSumOverAverage,
(SELECT SUM(TransactionAmount) FROM Purchasing.SupplierTransactions ST2 WHERE ST2.SupplierID = ST1.SupplierID) AS SupplierTransactionSumOverall
FROM Purchasing.SupplierTransactions ST1
JOIN Purchasing.Suppliers S ON S.SupplierID = ST1.SupplierID
WHERE SupplierName = 'A Datum Corporation'
GROUP BY SupplierName, ST1.SupplierID, TransactionAmount
HAVING TransactionAmount > (SELECT AVG(TransactionAmount) FROM Purchasing.SupplierTransactions)

-- If the final sum doesn't seem right, what aggregate query can you use to check the math?
SELECT SUM(TransactionAmount) FROM Purchasing.SupplierTransactions ST
JOIN Purchasing.Suppliers S ON S.SupplierID = ST.SupplierID
WHERE SupplierName = 'A Datum Corporation'

