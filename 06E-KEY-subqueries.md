# Exercise: SQL Subqueries - INSTRUCTOR KEY

## Introduction

In the Subqueries SQL lesson, we introduced the many cases for a SQL subquery. For this exercise:

1. Create a new SQL file.
1. Set the connection in SQL Server Management Studio (SSMS) to look at Wide World Importers.
1. Write these queries.

## Exercise

1. Get all stock items that have Blue colors. We only need the stock item's name and don't need the color name in our results.

    ```sql
    SELECT DISTINCT StockItemName
    FROM Warehouse.StockItems
    WHERE EXISTS
        (SELECT ColorName
         FROM Warehouse.Colors
         WHERE Warehouse.Colors.ColorID = Warehouse.StockItems.ColorID
            AND ColorName LIKE '%Blue%')
    ```

2. Get all stock items and their color IDs for those that don't have Blue colors. Include stock items that do not have colors.

    ```sql
    SELECT DISTINCT StockItemName, ColorID
    FROM Warehouse.StockItems
    WHERE NOT EXISTS
        (SELECT ColorName
         FROM Warehouse.Colors
         WHERE Warehouse.Colors.ColorID = Warehouse.StockItems.ColorID
            AND ColorName LIKE '%Blue%')
    ```

3. Get all stock items without colors using the simplest query.

    ```sql
    -- Doing this here to remind them that it's easy to overcomplicate queries
    -- Don't do a join unless necessary
    SELECT DISTINCT StockItemName
    FROM Warehouse.StockItems
    WHERE ColorID IS NULL
    ```

4. What are stock items and their suppliers for packaging suppliers? Use a subquery in an `IN` clause.

    ```sql
    DECLARE @PackagingID INT
    SELECT @PackagingID = SupplierCategoryID
    FROM Purchasing.SupplierCategories
    WHERE SupplierCategoryName LIKE '%Packaging%'

    SELECT StockItemName, (SELECT SupplierName
                           FROM Purchasing.Suppliers
                           WHERE SupplierCategoryID = @PackagingID)
    FROM Warehouse.StockItems
    WHERE SupplierID IN (SELECT SupplierID
                         FROM Purchasing.Suppliers
                         WHERE SupplierCategoryID = @PackagingID)
    ```

5. What stock items and suppliers from packaging suppliers had transactions in 2014?

    ```sql
    DECLARE @PackagingID INT
    SELECT @PackagingID = SupplierCategoryID
    FROM Purchasing.SupplierCategories
    WHERE SupplierCategoryName LIKE '%Packaging%'

    SELECT StockItemName, (SELECT SupplierName 
                           FROM Purchasing.Suppliers
                           WHERE SupplierCategoryID = @PackagingID)
    FROM Warehouse.StockItems
    WHERE SupplierID IN
        (SELECT SupplierID
         FROM Purchasing.Suppliers
         WHERE SupplierCategoryID = @PackagingID)
        AND EXISTS
        (SELECT DISTINCT StockItemID
         FROM Warehouse.StockItemTransactions
         WHERE YEAR(TransactionOccurredWhen) = 2014
            AND Warehouse.StockItems.StockItemID = Warehouse.StockItemTransactions.StockItemID)
    ```

6. What suppliers from toy suppliers had transactions in 2013? How many individual stock items did those suppliers have in 2013?

    ```sql
    DECLARE @ToysID INT
    SELECT @ToysID = SupplierCategoryID
    FROM Purchasing.SupplierCategories
    WHERE SupplierCategoryName LIKE '%Toy Supplier%'

    SELECT SupplierID,
        (SELECT SupplierName
         FROM Purchasing.Suppliers
         WHERE SupplierCategoryID = @ToysID),
         COUNT(DISTINCT StockItemID)
    FROM Warehouse.StockItemTransactions
    WHERE YEAR(TransactionOccurredWhen) = 2013
        AND SupplierID IN (SELECT SupplierID
                           FROM Purchasing.Suppliers
                           WHERE SupplierCategoryID = @ToysID)
    GROUP BY SupplierID
    ```

7. Get a list of supplier category IDs, supplier count for the category, and total supplier count.

    ```sql
    SELECT SupplierCategoryID, COUNT(SupplierName),
        (SELECT COUNT(SupplierID)
         FROM Purchasing.Suppliers)
    FROM Purchasing.Suppliers
    GROUP BY SupplierCategoryID
    ```

8. Get a list of supplier category names, supplier count for the category, and total supplier count, including the category name rather than the category ID.

    ```sql
    SELECT (SELECT SupplierCategoryName
            FROM Purchasing.SupplierCategories
            WHERE Purchasing.SupplierCategories.SupplierCategoryID = Purchasing.Suppliers.SupplierCategoryID),
            COUNT(SupplierName),
            (SELECT COUNT(SupplierID) FROM Purchasing.Suppliers)
    FROM Purchasing.Suppliers
    GROUP BY SupplierCategoryID
    ```

9. Get transactions by supplier overall for "A Datum Corporation."

    ```sql
    SELECT SupplierID, TransactionAmount
    FROM Purchasing.SupplierTransactions
    WHERE SupplierID IN (SELECT SupplierID
                         FROM Purchasing.Suppliers
                         WHERE SupplierName = 'A Datum Corporation')
    ```

10. Get the transactions by supplier for "A Datum Corporation," but only those whose transaction amounts are greater than the average transaction amount.

    ```sql
    SELECT SupplierID, TransactionAmount
    FROM Purchasing.SupplierTransactions
    WHERE SupplierID IN (SELECT SupplierID
                         FROM Purchasing.Suppliers
                         WHERE SupplierName = 'A Datum Corporation')
        AND TransactionAmount > (SELECT AVG(TransactionAmount)
                                 FROM Purchasing.SupplierTransactions)
    ```
