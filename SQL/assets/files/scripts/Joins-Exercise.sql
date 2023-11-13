USE WideWorldImporters


-- Gets all supplier names and categories where the category name contains `Service` without aliases and without the INNER keyword.
SELECT SupplierName, SupplierCategoryName FROM Purchasing.Suppliers 
JOIN Purchasing.SupplierCategories ON Purchasing.Suppliers.SupplierCategoryID = Purchasing.SupplierCategories.SupplierCategoryID
WHERE SupplierCategoryName LIKE '%Service%'

-- Gets all supplier names and categories where the category name contains `Service` with table aliases and without the INNER keyword.

-- with AS
SELECT SupplierName, SupplierCategoryName FROM Purchasing.Suppliers AS Suppliers 
JOIN Purchasing.SupplierCategories AS SupplierCategories ON Suppliers.SupplierCategoryID = SupplierCategories.SupplierCategoryID
WHERE SupplierCategoryName LIKE '%Service%'

-- without AS
SELECT SupplierName, SupplierCategoryName FROM Purchasing.Suppliers Suppliers 
JOIN Purchasing.SupplierCategories SupplierCategories ON Suppliers.SupplierCategoryID = SupplierCategories.SupplierCategoryID
WHERE SupplierCategoryName LIKE '%Service%'

-- Gets all supplier names and categories where the category name contains `Service` with table aliases and with the INNER keyword.
-- with AS
SELECT SupplierName, SupplierCategoryName FROM Purchasing.Suppliers AS Suppliers 
INNER JOIN Purchasing.SupplierCategories AS SupplierCategories ON Suppliers.SupplierCategoryID = SupplierCategories.SupplierCategoryID
WHERE SupplierCategoryName LIKE '%Service%'

-- without AS
SELECT SupplierName, SupplierCategoryName FROM Purchasing.Suppliers Suppliers 
INNER JOIN Purchasing.SupplierCategories SupplierCategories ON Suppliers.SupplierCategoryID = SupplierCategories.SupplierCategoryID
WHERE SupplierCategoryName LIKE '%Service%'

-- Gets all unique supplier names, stock item names, and category names where the category is `Toy Supplier`.
SELECT DISTINCT StockItemName, SupplierName, SupplierCategoryName FROM Warehouse.StockItems StockItems
JOIN Purchasing.Suppliers Suppliers ON StockItems.SupplierID = Suppliers.SupplierID
JOIN Purchasing.SupplierCategories SupplierCategories ON Suppliers.SupplierCategoryID = SupplierCategories.SupplierCategoryID
WHERE SupplierCategoryName = 'Toy Supplier'

-- Get the unique combinations of stock items in the supplier category is `Toy Supplier` and their stock groups.

SELECT StockGroupName, StockItemName
FROM Warehouse.StockItems
JOIN Warehouse.StockItemStockGroups ON Warehouse.StockItemStockGroups.StockItemID = Warehouse.StockItems.StockItemID
JOIN Warehouse.StockGroups ON Warehouse.StockGroups.StockGroupID = Warehouse.StockItemStockGroups.StockGroupID
JOIN Purchasing.Suppliers ON Warehouse.StockItems.SupplierID = Purchasing.Suppliers.SupplierID
JOIN Purchasing.SupplierCategories ON Purchasing.Suppliers.SupplierCategoryID = Purchasing.SupplierCategories.SupplierCategoryID
WHERE SupplierCategoryName = 'Toy Supplier'

-- set of statements that uses COALESCE to create a comma-delimited list of stock group names for `RC toy sedan car with remote control (Black) 1/50 scale`
-- Using COALESCE to combine groups
DECLARE @GroupList VARCHAR(100)

SELECT @GroupList = COALESCE(@GroupList + ', ','') + StockGroupName
FROM Warehouse.StockItems
JOIN Warehouse.StockItemStockGroups ON Warehouse.StockItemStockGroups.StockItemID = Warehouse.StockItems.StockItemID
JOIN Warehouse.StockGroups ON Warehouse.StockGroups.StockGroupID = Warehouse.StockItemStockGroups.StockGroupID
WHERE StockItemName = 'RC toy sedan car with remote control (Black) 1/50 scale'

SELECT @GroupList


-- Using the STRING_AGG approach
-- Lists all stock item names and their stock groups for those whose supplier is categorized as Toy Supplier.
SELECT STRING_AGG(StockGroupName,',') AS StockGroups, StockItemName
FROM Warehouse.StockItems
JOIN Warehouse.StockItemStockGroups ON Warehouse.StockItemStockGroups.StockItemID = Warehouse.StockItems.StockItemID
JOIN Warehouse.StockGroups ON Warehouse.StockGroups.StockGroupID = Warehouse.StockItemStockGroups.StockGroupID
JOIN Purchasing.Suppliers ON Warehouse.StockItems.SupplierID = Purchasing.Suppliers.SupplierID
JOIN Purchasing.SupplierCategories ON Purchasing.Suppliers.SupplierCategoryID = Purchasing.SupplierCategories.SupplierCategoryID
WHERE SupplierCategoryName = 'Toy Supplier'
GROUP BY StockItemName


-- shows how these Toy Supplier stock items are packaged both by unit and outer package types.
SELECT StockItemName, UnitPackageType.PackageTypeName AS UnitPackage, OuterPackageType.PackageTypeName AS OuterPackage
FROM Warehouse.StockItems
JOIN Warehouse.PackageTypes AS UnitPackageType ON UnitPackageType.PackageTypeID = Warehouse.StockItems.UnitPackageID
JOIN Warehouse.PackageTypes AS OuterPackageType ON OuterPackageType.PackageTypeID = Warehouse.StockItems.OuterPackageID
JOIN Purchasing.Suppliers ON Warehouse.StockItems.SupplierID = Purchasing.Suppliers.SupplierID
JOIN Purchasing.SupplierCategories ON Purchasing.Suppliers.SupplierCategoryID = Purchasing.SupplierCategories.SupplierCategoryID
WHERE SupplierCategoryName = 'Toy Supplier'

-- Suppose we want the invoices from May 2016 less than $100, ordered by total, then invoice number. What is the query for invoices less than $1000?

SELECT Sales.Invoices.InvoiceID, SUM(ExtendedPrice) AS InvoiceTotal
FROM Sales.InvoiceLines
JOIN Sales.Invoices ON Sales.Invoices.InvoiceID = Sales.InvoiceLines.InvoiceID
WHERE YEAR(InvoiceDate) = 2016  AND MONTH(InvoiceDate) = 5
GROUP BY Sales.Invoices.InvoiceID
HAVING SUM(ExtendedPrice) < 100.00
ORDER BY InvoiceTotal, Sales.Invoices.InvoiceID

-- Suppose we want the monthly invoice totals for 2014 and 2015, ordered by year then month.
SELECT YEAR(InvoiceDate) as ReportYear, MONTH(InvoiceDate) AS ReportMonth, SUM(ExtendedPrice) as Total
FROM Sales.InvoiceLines
INNER JOIN Sales.Invoices ON Sales.Invoices.InvoiceID = Sales.InvoiceLines.InvoiceID
WHERE YEAR(InvoiceDate) IN (2014, 2015)
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate)
ORDER BY YEAR(InvoiceDate), MONTH(InvoiceDate)


/* OUTER JOINS */

-- We need to remove an item from stock groups
-- DELETE FROM Warehouse.StockItemStockGroups WHERE StockItemID = 50

SELECT InvoiceID, InvoiceLineID, StockItemName, StockGroupName
FROM Sales.InvoiceLines AS InvoiceLines
JOIN Warehouse.StockItems AS StockItems ON StockItems.StockItemID = InvoiceLines.StockItemID
LEFT OUTER JOIN Warehouse.StockItemStockGroups AS ItemGroups ON StockItems.StockItemID = ItemGroups.StockItemID
LEFT OUTER JOIN Warehouse.StockGroups AS Groups ON ItemGroups.StockGroupID = Groups.StockGroupID
WHERE Groups.StockGroupName IS NULL AND InvoiceID = 2
ORDER BY InvoiceID, InvoiceLineID

-- Only not null group names
SELECT InvoiceID, InvoiceLineID, InvoiceLines.StockItemID, StockItemName, StockGroupName
FROM Sales.InvoiceLines AS InvoiceLines
JOIN Warehouse.StockItems AS StockItems ON StockItems.StockItemID = InvoiceLines.StockItemID
LEFT OUTER JOIN Warehouse.StockItemStockGroups AS ItemGroups ON StockItems.StockItemID = ItemGroups.StockItemID
LEFT OUTER JOIN Warehouse.StockGroups AS Groups ON ItemGroups.StockGroupID = Groups.StockGroupID
WHERE Groups.StockGroupName IS NOT NULL AND InvoiceID = 2
ORDER BY InvoiceID, InvoiceLineID

-- LEFT JOIN all results, Show '-' for null group names

SELECT InvoiceID, InvoiceLineID, StockItemName, CASE WHEN StockGroupName IS NULL THEN '-' ELSE StockGroupName END AS GroupName
FROM Sales.InvoiceLines AS InvoiceLines
JOIN Warehouse.StockItems AS StockItems ON StockItems.StockItemID = InvoiceLines.StockItemID
LEFT OUTER JOIN Warehouse.StockItemStockGroups AS ItemGroups ON StockItems.StockItemID = ItemGroups.StockItemID
LEFT OUTER JOIN Warehouse.StockGroups AS Groups ON ItemGroups.StockGroupID = Groups.StockGroupID
WHERE InvoiceID = 2
ORDER BY InvoiceID, InvoiceLineID

-- FULL OUTER
SELECT InvoiceID, InvoiceLineID, StockItemName, CASE WHEN StockGroupName IS NULL THEN '-' ELSE StockGroupName END AS GroupName
FROM Sales.InvoiceLines AS InvoiceLines
JOIN Warehouse.StockItems AS StockItems ON StockItems.StockItemID = InvoiceLines.StockItemID
FULL OUTER JOIN Warehouse.StockItemStockGroups AS ItemGroups ON StockItems.StockItemID = ItemGroups.StockItemID
FULL OUTER JOIN Warehouse.StockGroups AS Groups ON ItemGroups.StockGroupID = Groups.StockGroupID
WHERE InvoiceID = 2
ORDER BY InvoiceID, InvoiceLineID

-- Invoice Line ID does not represent line number within invoice
SELECT * FROM Sales.InvoiceLines
WHERE InvoiceID = 2

-- Add our own line numbers for within the invoice, using InvoiceLineID to guide order
SELECT ROW_NUMBER() OVER (ORDER BY InvoiceLineID) AS LineNumber,*
FROM Sales.InvoiceLines
WHERE InvoiceID = 2