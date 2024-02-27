/* Exercise: Introduction to SQL Queries */

-- In this exercise, we'll explore different SQL queries to retrieve and manipulate data.

-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;

-- Exercise 1: Simple SELECT

-- Start with a basic select of all columns from the 'Product' table.
-- This query retrieves all rows and columns from the 'Product' table.
SELECT *
FROM Production.Product;

/*
   Notes:
   - This query is a straightforward way to get a sense of the data in the 'Product' table.
   - The asterisk (*) symbol represents all columns.
   - It retrieves all rows, providing an overview of the table's content.
*/

-- Exercise 2: Specific Columns

-- Specify only the columns you want.
-- This query retrieves the 'Name,' 'ProductNumber,' and 'Color' columns from the 'Product' table.
SELECT Name, ProductNumber, Color
FROM Production.Product;

/*
   Notes:
   - By specifying specific columns, we can focus on the information we need, making the result set more concise.
   - This is particularly useful when you don't need all columns from a table.
*/

-- Exercise 3: Column Aliases

-- Rename columns with aliases for clarity.
-- This query selects specific columns and renames them with aliases for better understanding.
SELECT ProductNumber AS PN, 
       Name AS Product, 
       Color AS PColor 
FROM Production.Product;

/*
   Notes:
   - Column aliases provide custom names for columns in the result set.
   - Aliases can make the output more descriptive and user-friendly.
   - In this query, 'ProductNumber' is renamed as 'PN,' 'Name' as 'Product,' and 'Color' as 'PColor.'
*/

-- Exercise 4: Simple Transformations

-- Perform simple transformations on columns.
-- This query concatenates the 'Name' and 'Color' columns and names the result as 'ProductInfo.'
SELECT Name + ' ' + Color AS ProductInfo 
FROM Production.Product;

/*
   Notes:
   - SQL allows us to perform operations on columns. Here, we concatenate two columns to create a new one.
   - The plus (+) operator is used for concatenation.
   - The result column is named 'ProductInfo' for clarity.
*/

-- This query calculates a new price by multiplying 'ListPrice' by 1.1 and names the result as 'NewPrice.'
SELECT ListPrice * 1.1 AS NewPrice
FROM Production.Product;

/*
   Notes:
   - Here, we perform a mathematical operation on the 'ListPrice' column to increase it by 10%.
   - The result is named 'NewPrice.'
*/

-- Exercise 5: Top N Rows

-- Limit the number of rows returned.
-- This query retrieves the top 10 rows from the 'Product' table.
SELECT TOP 10 * 
FROM Production.Product;

/*
   Notes:
   - The 'TOP' clause limits the number of rows returned in the result set.
   - In this case, it retrieves the top 10 rows.
*/

-- This query retrieves the bottom 10 rows (last records) by ordering them in descending order based on the 'Name' column.
SELECT TOP 10 * 
FROM Production.Product 
ORDER BY Name DESC;

/*
   Notes:
   - To get the bottom (last) records, we use 'TOP' in combination with 'ORDER BY' in descending order.
   - This provides an alternative way to see the last rows of data.
*/

-- This query retrieves the top 5 most expensive products by selecting the 'Name' and 'ListPrice' columns and ordering them in descending order based on 'ListPrice.'
SELECT TOP 5 Name, ListPrice  
FROM Production.Product
ORDER BY ListPrice DESC;

/*
   Notes:
   - You can use 'TOP' along with 'ORDER BY' to fetch the top records based on a specific column's values.
   - In this case, it retrieves the top 5 most expensive products.
*/

-- This query retrieves the top 10 products by name in descending order.
SELECT TOP 10 Name
FROM Production.Product
ORDER BY Name DESC;

/*
   Notes:
   - 'TOP' can also be combined with 'ORDER BY' to retrieve the top rows based on alphabetical order (in this case, product names).
*/

-- This query returns the top 10% of rows from the 'Person.Person' table.
SELECT TOP 10 PERCENT *
FROM Person.Person;

/*
   Notes:
   - To get a specified percentage of rows, we use 'TOP' with a percentage value.
   - In this query, it retrieves the top 10% of rows from the 'Person.Person' table.
*/

-- Exercise 6: DISTINCT

-- Use DISTINCT to retrieve unique values.
-- This query retrieves the unique 'Color' values from the 'Product' table.
SELECT DISTINCT Color
FROM Production.Product;

/*
   Notes:
   - 'DISTINCT' is used to retrieve unique values and remove duplicates from the result set.
   - It's helpful when you want to find distinct categories or items within a dataset.
*/

-- This query retrieves the top 5 unique 'Color' values from the 'Product' table.
SELECT DISTINCT TOP 5 Color 
FROM Production.Product;

/*
   Notes:
   - When combined with 'TOP,' 'DISTINCT' allows you to retrieve a specific number of unique values.
   - In this case, it fetches the top 5 unique colors.
*/

-- This query counts the number of distinct 'Color' values in the 'Product' table.
SELECT COUNT(DISTINCT Color) 
FROM Production.Product;

/*
   Notes:
   - You can use 'COUNT' with 'DISTINCT' to count the number of unique values in a column.
   - This is useful for understanding the diversity of data within a category.
*/

-- Exercise 7: Column Aliases

-- Provide custom names for columns.
-- This query renames the 'Name' column as 'Product Name' and the 'ListPrice' column as 'Cost' from the 'Product' table.
SELECT Name AS 'Product Name', 
       ListPrice AS 'Cost'
FROM Production.Product;

/*
   Notes:
   - Column aliases offer custom names for columns, enhancing clarity and readability.
   - In this query, 'Name' is renamed as 'Product Name,' and 'ListPrice' is renamed as 'Cost.'
*/

-- This query shortens column names:
-- 1. 'ProductNumber' as 'PN'
-- 2. 'Name' as 'ProdName'
-- 3. 'SafetyStockLevel' as 'SSL' 
-- from the 'Product' table.
SELECT ProductNumber AS PN, 
       Name AS ProdName,
       SafetyStockLevel AS SSL 
FROM Production.Product;

/*
   Notes:
   - Column aliases can simplify lengthy column names for better usability.
   - Here, we use shorter aliases for 'ProductNumber,' 'Name,' and 'SafetyStockLevel.'
*/

-- This query creates a new column named 'DiscountPrice' by multiplying the 'ListPrice' by 1.2.
SELECT Name,
       ListPrice,
       ListPrice * 1.2 AS DiscountPrice
FROM Production.Product;

/*
   Notes:
   - You can create new columns in a query by performing calculations.
   - In this example, 'DiscountPrice' is calculated as 1.2 times the 'ListPrice.'
*/

-- This query concatenates the 'Name' and 'ProductNumber' columns and names the result as 'ProductInfo' from the 'Product' table.
SELECT Name + ' (' + ProductNumber + ')' AS ProductInfo  
FROM Production.Product;

/*
   Notes:
   - SQL allows you to concatenate columns to create new information.
   - In this query, we combine 'Name' and 'ProductNumber' with a custom format, naming the result 'ProductInfo.'
*/
