# Exercise: Basic SQL

## Introduction

In the Basic SQL lesson, we introduced various string and math functions that are built into SQL Server as well as a basic `SELECT` query to pull fields from a table. For this exercise:

For this exercise:

1. Create a new SQL file.
1. Set the connection in SQL Server Management Studio (SSMS) to look at Wide World Importers.
1. Write these queries and save your SQL file.

## Exercise

1. Write a `SELECT` query that uses the string `All for one, and one for all.`
1. Write `SELECT` queries that use the `+` operator to combine the following strings:
   * `All for one,` and `and one for all`
   * `All `, `for one `, `, and `, `one for`, and `all`
1. Write a `SELECT` query that returns the count of characters for the string `All for one, and one for all`
1. Write a `SELECT` query that uses the `CONCAT` function to combine `All for one, ` and ` and one for all`.
1. Write `SELECT` query for the following cases:
   * Split `All for one, and one for all.` on space.
   * Split `All for one, and one for all.` on a comma.
1. Write a `SELECT` query to get the top 5 full names from the `Application.People` table. Then write another `SELECT` query to get the full name, first name, and last initial of the person for the first 5 people.
   * Hint: Use the query in the lesson as a starting point for how to use `SUBSTRING`.
1. Write a `SELECT` query for the category name and the pattern index where the name starts with G for the first 8 customer category names.
1. Write a `SELECT` query for the category name and the pattern index where the name starts with G and contains an R as well for the first 8 customer category names.
1. Write a `SELECT` query that adds 6 and 6.
1. Write a `SELECT` query that divides 5 by 2.
1. Write a `SELECT` query that divides 5.0 by 2.0.
1. Write a `SELECT` query that divides 5 by 2.0.
1. Write a `SELECT` query that divides 5.0 by 2.
1. Write a `SELECT` query that gets the base type for the result of 5 divided by 2.0.
1. Write a `SELECT` query that gets the base type for the result of 5.0 divided by 2.
1. Write a `SELECT` query to get the absolute value of -5.
1. Write a `SELECT` query for 6 multiplied by 2.
1. Write a `SELECT` query for 6 multiplied by 2.0.
1. Write a `SELECT` query for 6 divided by 2.
1. Write a `SELECT` query that includes 2 values - 6 divided by 4 and its remainder.
   * Hint: The remainder uses an operator other than the division operator.
1. Write a `SELECT` query for 6 squared.
1. Write a `SELECT` query to get all the fields from the `Sales.CustomerCategories` table.
1. Write a `SELECT` query to get all of the customer category names.
1. Write a `SELECT` query to get the first eight customer category names.
