# Exercise: SQL JOINs

## Introduction

In the JOINs SQL lesson, we introduced the JOIN clause to connect related tables. For this exercise:

1. Create a new SQL file.
2. Set the connection in SQL Server Management Studio (SSMS) to look at Wide World Importers.
3. Write these queries.

Bonus: This [SQL Joins Cheatsheet](assets/images/sql-joins-cheatsheet.png) may help you figure out which join to use.

## Exercise

1.  Write a SELECT query that gets all supplier names and categories where the category name contains `Service` without aliases and without the INNER keyword.

2.  Write a SELECT query that gets all supplier names and categories where the category name contains `Service` with table aliases and without the INNER keyword.

3.  Write a SELECT query that gets all supplier names and categories where the category name contains `Service` with table aliases and with the INNER keyword.

4.  Write a SELECT query that gets all unique supplier names, stock item names, and category names where the category is `Toy Supplier`.

5.  Write a SELECT query to get the unique combinations of stock items in the supplier category is `Toy Supplier` and their stock groups.

6.  Write a set of statements that uses COALESCE to create a comma-delimited list of stock group names for `RC toy sedan car with remote control (Black) 1/50 scale`

7.  Write a SELECT query that lists all stock item names and their stock groups for those whose supplier is categorized as Toy Supplier.

8.  Write a SELECT query that shows how these Toy Supplier stock items are packaged both by unit and outer package types.

9.  Write a SELECT query that gets invoices from May 2016 that are less than $100, ordered by total, and then by invoice number.

10. Write a SELECT query that shows the monthly breakdown for invoice totals for 2014 and 2015, ordered by year, then by month.

11. This step has 3 parts:

    1.  Write a SELECT query that shows invoice items with a stock group name for invoice 2. Examine results, making note of the data and how many rows returned.
    2.  Remove an item from stock groups to see how this affects the data returned in the prior query.

              Run this statement for the `WideWorldImporters` database:

              ```sql
              DELETE FROM Warehouse.StockItemStockGroups WHERE StockItemID = 50
              ```

        NOTE: You should receive a message stating how many rows are affected.

    3.  Re-run the query from step I. Examine the result set to see differences with the first run.

12. Write a SELECT query that shows all invoice items with their stock group name for invoice 2. For null stock groups, show '-'.

13. Write a SELECT query with a FULL OUTER JOIN to show all invoice items with their stock group name for invoice 2. For null stock groups, show '-'.
