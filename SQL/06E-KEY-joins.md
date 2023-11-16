# Exercise: SQL JOINs - INSTRUCTOR KEY

## Introduction

In the JOINs SQL lesson, we introduced the JOIN clause to connect related tables. For this exercise:

1. Create a new SQL file.
2. Set the connection in SQL Server Management Studio (SSMS) to look at Wide World Importers.
3. Write these queries.

Bonus: This [SQL Joins Cheatsheet](assets/images/sql-joins-cheatsheet.png) may help you figure out which join to use.

## Exercise

1. Write a SELECT query that gets all supplier names and categories where the category name contains `Service` without aliases and without the INNER keyword.

```sql
SELECT SupplierName, SupplierCategoryName FROM Purchasing.Suppliers
JOIN Purchasing.SupplierCategories ON Purchasing.Suppliers.SupplierCategoryID = Purchasing.SupplierCategories.SupplierCategoryID
WHERE SupplierCategoryName LIKE '%Service%'
```

2. Write a SELECT query that gets all supplier names and categories where the category name contains `Service` with table aliases and without the INNER keyword.

```sql
-- with AS

SELECT SupplierName, SupplierCategoryName FROM Purchasing.Suppliers AS Suppliers
JOIN Purchasing.SupplierCategories AS SupplierCategories ON Suppliers.SupplierCategoryID = SupplierCategories.SupplierCategoryID
WHERE SupplierCategoryName LIKE '%Service%'

-- without AS
SELECT SupplierName, SupplierCategoryName FROM Purchasing.Suppliers Suppliers
JOIN Purchasing.SupplierCategories SupplierCategories ON Suppliers.SupplierCategoryID = SupplierCategories.SupplierCategoryID
WHERE SupplierCategoryName LIKE '%Service%'
```

3. Write a SELECT query that gets all supplier names and categories where the category name contains `Service` with table aliases and with the INNER keyword.

```sql
-- with AS

SELECT SupplierName, SupplierCategoryName FROM Purchasing.Suppliers AS Suppliers
INNER JOIN Purchasing.SupplierCategories AS SupplierCategories ON Suppliers.SupplierCategoryID = SupplierCategories.SupplierCategoryID
WHERE SupplierCategoryName LIKE '%Service%'

-- without AS
SELECT SupplierName, SupplierCategoryName FROM Purchasing.Suppliers Suppliers
INNER JOIN Purchasing.SupplierCategories SupplierCategories ON Suppliers.SupplierCategoryID = SupplierCategories.SupplierCategoryID
WHERE SupplierCategoryName LIKE '%Service%'
```

4. Write a SELECT query that gets all unique supplier names, stock item names, and category names where the category is `Toy Supplier`.

```sql
SELECT DISTINCT StockItemName, SupplierName, SupplierCategoryName FROM Warehouse.StockItems StockItems
JOIN Purchasing.Suppliers Suppliers ON StockItems.SupplierID = Suppliers.SupplierID
JOIN Purchasing.SupplierCategories SupplierCategories ON Suppliers.SupplierCategoryID = SupplierCategories.SupplierCategoryID
WHERE SupplierCategoryName = 'Toy Supplier'
```

5. Write a SELECT query to get the unique combinations of stock items in the supplier category is `Toy Supplier` and their stock groups.

```sql
SELECT StockGroupName, StockItemName
FROM Warehouse.StockItems
JOIN Warehouse.StockItemStockGroups ON Warehouse.StockItemStockGroups.StockItemID = Warehouse.StockItems.StockItemID
JOIN Warehouse.StockGroups ON Warehouse.StockGroups.StockGroupID = Warehouse.StockItemStockGroups.StockGroupID
JOIN Purchasing.Suppliers ON Warehouse.StockItems.SupplierID = Purchasing.Suppliers.SupplierID
JOIN Purchasing.SupplierCategories ON Purchasing.Suppliers.SupplierCategoryID = Purchasing.SupplierCategories.SupplierCategoryID
WHERE SupplierCategoryName = 'Toy Supplier'
```

6. Write a set of statements that uses COALESCE to create a comma-delimited list of stock group names for `RC toy sedan car with remote control (Black) 1/50 scale`

```sql
-- Using COALESCE to combine groups
DECLARE @GroupList VARCHAR(100)

SELECT @GroupList = COALESCE(@GroupList + ', ','') + StockGroupName
FROM Warehouse.StockItems
JOIN Warehouse.StockItemStockGroups ON Warehouse.StockItemStockGroups.StockItemID = Warehouse.StockItems.StockItemID
JOIN Warehouse.StockGroups ON Warehouse.StockGroups.StockGroupID = Warehouse.StockItemStockGroups.StockGroupID
WHERE StockItemName = 'RC toy sedan car with remote control (Black) 1/50 scale'

SELECT @GroupList
```

7. Write a SELECT query that lists all stock item names and their stock groups for those whose supplier is categorized as Toy Supplier.

```sql
-- Using the STRING_AGG approach
SELECT STRING_AGG(StockGroupName,',') AS StockGroups, StockItemName
FROM Warehouse.StockItems
JOIN Warehouse.StockItemStockGroups ON Warehouse.StockItemStockGroups.StockItemID = Warehouse.StockItems.StockItemID
JOIN Warehouse.StockGroups ON Warehouse.StockGroups.StockGroupID = Warehouse.StockItemStockGroups.StockGroupID
JOIN Purchasing.Suppliers ON Warehouse.StockItems.SupplierID = Purchasing.Suppliers.SupplierID
JOIN Purchasing.SupplierCategories ON Purchasing.Suppliers.SupplierCategoryID = Purchasing.SupplierCategories.SupplierCategoryID
WHERE SupplierCategoryName = 'Toy Supplier'
GROUP BY StockItemName
```

8. Write a SELECT query that shows how these Toy Supplier stock items are packaged both by unit and outer package types.

```sql
SELECT StockItemName, UnitPackageType.PackageTypeName AS UnitPackage, OuterPackageType.PackageTypeName AS OuterPackage
FROM Warehouse.StockItems
JOIN Warehouse.PackageTypes AS UnitPackageType ON UnitPackageType.PackageTypeID = Warehouse.StockItems.UnitPackageID
JOIN Warehouse.PackageTypes AS OuterPackageType ON OuterPackageType.PackageTypeID = Warehouse.StockItems.OuterPackageID
JOIN Purchasing.Suppliers ON Warehouse.StockItems.SupplierID = Purchasing.Suppliers.SupplierID
JOIN Purchasing.SupplierCategories ON Purchasing.Suppliers.SupplierCategoryID = Purchasing.SupplierCategories.SupplierCategoryID
WHERE SupplierCategoryName = 'Toy Supplier'
```

9. Write a SELECT query that gets invoices from May 2016 that are less than $100, ordered by total, and then by invoice number.

```sql
-- Suppose we want the invoices from 2016 less than $100, ordered by total, then invoice number. What is the query for invoices less than $1000?
SELECT Sales.Invoices.InvoiceID, SUM(ExtendedPrice) AS InvoiceTotal
FROM Sales.InvoiceLines
JOIN Sales.Invoices ON Sales.Invoices.InvoiceID = Sales.InvoiceLines.InvoiceID
WHERE YEAR(InvoiceDate) = 2016 AND MONTH(InvoiceDate) = 5
GROUP BY Sales.Invoices.InvoiceID
HAVING SUM(ExtendedPrice) < 100.00
ORDER BY InvoiceTotal, Sales.Invoices.InvoiceID
```

10. Write a SELECT query that shows the monthly breakdown for invoice totals for 2014 and 2015, ordered by year, then by month.

```sql
-- Suppose we want the monthly invoice totals for 2014 and 2015, ordered by year then month.
SELECT YEAR(InvoiceDate) as ReportYear, MONTH(InvoiceDate) AS ReportMonth, SUM(ExtendedPrice) as Total
FROM Sales.InvoiceLines
INNER JOIN Sales.Invoices ON Sales.Invoices.InvoiceID = Sales.InvoiceLines.InvoiceID
WHERE YEAR(InvoiceDate) IN (2014, 2015)
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate)
ORDER BY YEAR(InvoiceDate), MONTH(InvoiceDate)
```

11. This exercise has 3 parts:

    1. Write a SELECT query that shows invoice items with a stock group name for invoice 2. Examine results, making note of the data and how many rows returned.

    ```sql
    SELECT InvoiceID, InvoiceLineID, StockItemName, StockGroupName
    FROM Sales.InvoiceLines AS InvoiceLines
    JOIN Warehouse.StockItems AS StockItems ON StockItems.StockItemID = InvoiceLines.StockItemID
    LEFT OUTER JOIN Warehouse.StockItemStockGroups AS ItemGroups ON StockItems.StockItemID = ItemGroups.StockItemID
    LEFT OUTER JOIN Warehouse.StockGroups AS Groups ON ItemGroups.StockGroupID = Groups.StockGroupID
    WHERE Groups.StockGroupName IS NOT NULL AND InvoiceID = 2
    ORDER BY InvoiceID, InvoiceLineID
    ```

    2. We need to remove an item from stock groups to see how this affects the data returned in the prior query.

    Run this statement for the `WideWorldImporters` database:

        ```sql
        DELETE FROM Warehouse.StockItemStockGroups WHERE StockItemID = 50
        ```

    NOTE: You should receive a message stating how many rows are affected. --> 3 rows affected

    3. Re-run the query from step 1. Examine the result set to see differences with the first run.

12. Write a SELECT query that shows all invoice items with their stock group name for invoice 2. For null stock groups, show '-'.

```sql
SELECT InvoiceID, InvoiceLineID, StockItemName, CASE WHEN StockGroupName IS NULL THEN '-' ELSE StockGroupName END AS GroupName
FROM Sales.InvoiceLines AS InvoiceLines
JOIN Warehouse.StockItems AS StockItems ON StockItems.StockItemID = InvoiceLines.StockItemID
LEFT OUTER JOIN Warehouse.StockItemStockGroups AS ItemGroups ON StockItems.StockItemID = ItemGroups.StockItemID
LEFT OUTER JOIN Warehouse.StockGroups AS Groups ON ItemGroups.StockGroupID = Groups.StockGroupID
WHERE InvoiceID = 2
ORDER BY InvoiceID, InvoiceLineID
```

13. Write a SELECT query with a FULL OUTER JOIN to show all invoice items with their stock group name for invoice 2. For null stock groups, show '-'.

```sql
-- FULL OUTER
SELECT InvoiceID, InvoiceLineID, StockItemName, CASE WHEN StockGroupName IS NULL THEN '-' ELSE StockGroupName END AS GroupName
FROM Sales.InvoiceLines AS InvoiceLines
JOIN Warehouse.StockItems AS StockItems ON StockItems.StockItemID = InvoiceLines.StockItemID
FULL OUTER JOIN Warehouse.StockItemStockGroups AS ItemGroups ON StockItems.StockItemID = ItemGroups.StockItemID
FULL OUTER JOIN Warehouse.StockGroups AS Groups ON ItemGroups.StockGroupID = Groups.StockGroupID
WHERE InvoiceID = 2
ORDER BY InvoiceID, InvoiceLineID
```
