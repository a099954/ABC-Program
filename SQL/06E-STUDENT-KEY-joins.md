# Exercise: SQL JOINs - STUDENT KEY

## Introduction

In the JOINs SQL lesson, we introduced the JOIN clause to connect related tables. For this exercise:

1. Create a new SQL file.
2. Set the connection in SQL Server Management Studio (SSMS) to look at Wide World Importers.
3. Write these queries.

Bonus: This [SQL Joins Cheatsheet](assets/images/sql-joins-cheatsheet.png) may help you figure out which join to use.

The student key contains general guidance to assure you that you are on the right track.

## Exercise

1. Write a SELECT query that gets all supplier names and categories where the category name contains `Service` without aliases and without the INNER keyword.

| SupplierName           | SupplierCategoryName        |
| ---------------------- | --------------------------- |
| Consolidated Messenger | Courier Services Supplier   |
| Humongous Insurance    | Insurance Services Supplier |
| Trey Research          | Marketing Services Supplier |
| Woodgrove Bank         | Financial Services Supplier |

2. Write a SELECT query that gets all supplier names and categories where the category name contains `Service` with table aliases and without the INNER keyword.

| SupplierName           | SupplierCategoryName        |
| ---------------------- | --------------------------- |
| Consolidated Messenger | Courier Services Supplier   |
| Humongous Insurance    | Insurance Services Supplier |
| Trey Research          | Marketing Services Supplier |
| Woodgrove Bank         | Financial Services Supplier |

3. Write a SELECT query that gets all supplier names and categories where the category name contains `Service` with table aliases and with the INNER keyword.

| SupplierName           | SupplierCategoryName        |
| ---------------------- | --------------------------- |
| Consolidated Messenger | Courier Services Supplier   |
| Humongous Insurance    | Insurance Services Supplier |
| Trey Research          | Marketing Services Supplier |
| Woodgrove Bank         | Financial Services Supplier |

4. Write a SELECT query that gets all unique supplier names, stock item names, and category names where the category is `Toy Supplier`.

18 rows, including:

| StockItemName                                           | SupplierName            | SupplierCategoryName |
| ------------------------------------------------------- | ----------------------- | -------------------- |
| RC toy sedan car with remote control (Black) 1/50 scale | Northwind Electric Cars | Toy Supplier         |
| RC toy sedan car with remote control (Red) 1/50 scale   | Northwind Electric Cars | Toy Supplier         |
| RC toy sedan car with remote control (Blue) 1/50 scale  | Northwind Electric Cars | Toy Supplier         |

5. Write a SELECT query to get the unique combinations of stock items in the supplier category is `Toy Supplier` and their stock groups.

36 rows, including:

| StockGroupName | StockItemName                                           |
| -------------- | ------------------------------------------------------- |
| Novelty Items  | RC toy sedan car with remote control (Black) 1/50 scale |
| Toys           | RC toy sedan car with remote control (Black) 1/50 scale |
| Novelty Items  | RC toy sedan car with remote control (Red) 1/50 scale   |
| Toys           | RC toy sedan car with remote control (Red) 1/50 scale   |

6. Write a set of statements that uses COALESCE to create a comma-delimited list of stock group names for `RC toy sedan car with remote control (Black) 1/50 scale`

```
Novelty Items, Toys
```

7. Write a SELECT query that lists all stock item names and their stock groups for those whose supplier is categorized as Toy Supplier.

18 rows, including:

| StockGroups        | StockItemName                                                     |
| ------------------ | ----------------------------------------------------------------- |
| Novelty Items,Toys | RC big wheel monster truck with remote control (Black) 1/50 scale |
| Novelty Items,Toys | RC toy sedan car with remote control (Black) 1/50 scale           |
| Novelty Items,Toys | RC toy sedan car with remote control (Blue) 1/50 scale            |

8. Write a SELECT query that shows how these Toy Supplier stock items are packaged both by unit and outer package types.

18 rows, including:

| StockItemName                                           | UnitPackage | OuterPackage |
| ------------------------------------------------------- | ----------- | ------------ |
| RC toy sedan car with remote control (Black) 1/50 scale | Each        | Each         |
| RC toy sedan car with remote control (Red) 1/50 scale   | Each        | Each         |
| RC toy sedan car with remote control (Blue) 1/50 scale  | Each        | Each         |
| RC toy sedan car with remote control (Green) 1/50 scale | Each        | Each         |

9. Write a SELECT query that gets invoices from May 2016 that are less than $100, ordered by total, and then by invoice number.

27 rows, including:

| InvoiceID | InvoiceTotal |
| --------- | ------------ |
| 69907     | 5.52         |
| 70359     | 27.60        |
| 70237     | 29.90        |
| 69805     | 33.12        |

10. Write a SELECT query that shows the monthly breakdown for invoice totals for 2014 and 2015, ordered by year, then by month.

24 rows, including:

| ReportYear | ReportMonth | Total      |
| ---------- | ----------- | ---------- |
| 2014       | 1           | 4677669.28 |
| 2014       | 2           | 3990741.07 |
| 2014       | 3           | 4441218.55 |
| 2014       | 4           | 4709520.43 |
| 2014       | 5           | 5279235.69 |

11. This exercise has 3 parts:

    1.  Write a SELECT query that shows invoice items with a stock group name for invoice 2. Examine results, making note of the data and how many rows returned.

    | InvoiceID | InvoiceLineID | StockItemID | StockItemName                                           | StockGroupName      |
    | --------- | ------------- | ----------- | ------------------------------------------------------- | ------------------- |
    | 2         | 2             | 50          | Developer joke mug - old C developers never die (White) | Novelty Items       |
    | 2         | 2             | 50          | Developer joke mug - old C developers never die (White) | Mugs                |
    | 2         | 2             | 50          | Developer joke mug - old C developers never die (White) | Computing Novelties |
    | 2         | 3             | 10          | USB food flash drive - chocolate bar                    | Novelty Items       |
    | 2         | 3             | 10          | USB food flash drive - chocolate bar                    | Computing Novelties |
    | 2         | 3             | 10          | USB food flash drive - chocolate bar                    | USB Novelties       |

    2. We need to remove an item from stock groups to see how this affects the data returned in the prior query.

    Run this statement for the `WideWorldImporters` database:

    ```sql
     DELETE FROM Warehouse.StockItemStockGroups WHERE StockItemID = 50
    ```

    NOTE: You should receive a message stating how many rows are affected.

    3. Re-run the query from step 1. Examine the result set to see differences with the first run.

| InvoiceID | InvoiceLineID | StockItemID | StockItemName                        | StockGroupName      |
| --------- | ------------- | ----------- | ------------------------------------ | ------------------- |
| 2         | 3             | 10          | USB food flash drive - chocolate bar | Novelty Items       |
| 2         | 3             | 10          | USB food flash drive - chocolate bar | Computing Novelties |
| 2         | 3             | 10          | USB food flash drive - chocolate bar | USB Novelties       |

12. Write a SELECT query that shows all invoice items with their stock group name for invoice 2. For null stock groups, show '-'.

| InvoiceID | InvoiceLineID | StockItemName                                           | StockGroupName      |
| --------- | ------------- | ------------------------------------------------------- | ------------------- |
| 2         | 2             | Developer joke mug - old C developers never die (White) | -                   |
| 2         | 3             | USB food flash drive - chocolate bar                    | Novelty Items       |
| 2         | 3             | USB food flash drive - chocolate bar                    | Computing Novelties |
| 2         | 3             | USB food flash drive - chocolate bar                    | USB Novelties       |

13. Write a SELECT query with a FULL OUTER JOIN to show all invoice items with their stock group name for invoice 2. For null stock groups, show '-'.

| InvoiceID | InvoiceLineID | StockItemName                                           | StockGroupName      |
| --------- | ------------- | ------------------------------------------------------- | ------------------- |
| 2         | 2             | Developer joke mug - old C developers never die (White) | -                   |
| 2         | 3             | USB food flash drive - chocolate bar                    | Novelty Items       |
| 2         | 3             | USB food flash drive - chocolate bar                    | Computing Novelties |
| 2         | 3             | USB food flash drive - chocolate bar                    | USB Novelties       |
