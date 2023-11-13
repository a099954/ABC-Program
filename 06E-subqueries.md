# Exercise: SQL Subqueries

## Introduction

In the Subqueries SQL lesson, we introduced the many cases for a SQL subquery. For this exercise:

1. Create a new SQL file.
1. Set the connection in SQL Server Management Studio (SSMS) to look at Wide World Importers.
1. Write these queries.

## Exercise

1. Get all stock items that have Blue colors. We only need the stock item's name and don't need the color name in our results.
1. Get all stock items and their color IDs for those that don't have Blue colors. Include stock items that do not have colors.
1. Get all stock items without colors using the simplest query.
1. What are stock items and their suppliers for packaging suppliers? Use a subquery in an `IN` clause.
1. What stock items and suppliers from packaging suppliers had transactions in 2014?
1. What suppliers from toy suppliers had transactions in 2013? How many individual stock items did those suppliers have in 2013?
1. Get a list of supplier category IDs, supplier count for the category, and total supplier count.
1. Get a list of supplier category names, supplier count for the category, and total supplier count, including the category name rather than the category id.
1. Get the transactions by supplier overall for "A Datum Corporation."
1. Get the transactions by supplier for "A Datum Corporation," but only those whose transaction amounts are greater than the average transaction amount.
