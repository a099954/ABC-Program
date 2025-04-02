/* Exercise: Introduction to SQL Queries */

-- In this exercise, we'll explore different SQL queries related to the 'Production.Product' table in the AdventureWorks2012 database.

-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;

/* Product Tables Exercises - Columns & Rows  */

-- Question 1) How many columns does the Production.Product table have?  
-- Query:  
SELECT *  
FROM Production.Product;

/*
   Answer:
   - There are 25 columns in the Product table.
*/

-- Question 2) Retrieve the Name and ListPrice columns

-- Query: 
SELECT Name, ListPrice
FROM Production.Product;

/*
   Answer:
   - This query retrieves the 'Name' and 'ListPrice' columns for all rows in the 'Product' table.
   - The result will contain the product names and their respective list prices.
*/

-- Question 3) Get the first 10 rows sorted descending by name

--Query:  
SELECT TOP 10 *
FROM Production.Product 
ORDER BY Name DESC;

/*
   Answer:  
   - This query returns the first 10 rows of data from the 'Product' table.
   - The rows are sorted in descending order alphabetically by the 'Name' column.
   - It provides an overview of the top products in reverse alphabetical order.
*/


/* Product Tables Exercises - DISTINCT  */

-- Question 1) How many unique product colors exist?
--Query:  
SELECT DISTINCT Color  
FROM Production.Product;

/*
   Answer:
   - There are 9 unique colors in the 'Product' table.
   - The 'DISTINCT' keyword eliminates duplicates and returns only distinct values.
*/

-- Question 2) Get distinct product names from the Name column

--Query:
SELECT DISTINCT Name
FROM Production.Product;

/*
   Answer:  
   - There are 504 distinct product names in the 'Product' table.
   - This query retrieves unique product names, eliminating any duplicate entries.
*/

-- Question 3) Select the distinct ProductSubcategoryID sorted small to large

-- Query:
SELECT DISTINCT ProductSubcategoryID, Name
FROM Production.Product
ORDER BY ProductSubcategoryID;


/*
   Answer: 
   - There are 37 distinct product subcategories in the 'Product' table.
   - The result set is ordered alphabetically by the 'ProductSubcategoryID' column.
   - This query provides a list of unique product categories.
*/


/* Product Tables Exercises - Aliases */

-- Question 1) Select ProductID and Alias it as 'P1'

-- Query:
SELECT ProductID AS P1
FROM Production.Product;

/*
   Answer:
   - This query returns the 'ProductID' column from the 'Product' table with an alias 'P1.'
   - Column aliases can make the result set more readable.
*/

-- Question 2) Alias the table Production.Product as 'P' 

-- Query:  
SELECT P.Name, P.ListPrice   
FROM Production.Product AS P;

/*
   Answer:  
   - In this query, the 'Production.Product' table is aliased as 'P.'
   - It selects the 'Name' and 'ListPrice' columns from the aliased 'P' table.
   - Table aliases can simplify queries, especially when working with complex joins or subqueries.
*/

-- Question 3) Merge Name and ProductNumber as ProductInfo

-- Query:  
SELECT Name + ' (' + ProductNumber + ')' AS ProductInfo
FROM Production.Product;

/*
   Answer:  
   - This query concatenates the 'Name' and 'ProductNumber' columns to create a new column called 'ProductInfo.'
   - Column aliases are used to provide a descriptive name for the result column.
   - The result combines product names and their corresponding product numbers in a user-friendly format.
*/

