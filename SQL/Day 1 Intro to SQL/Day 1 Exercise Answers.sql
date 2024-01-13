/* Connections */

-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;




/* Product Tables Exercises - Columns & Rows  */

-- Question 1) How many columns does the Production.Product table have?  
-- Query:  
        SELECT *  
        FROM Production.Product;

-- Answer: 
    -- There are 25 columns in the Product table


-- Question 2) Retrieve the Name and ListPrice columns

-- Query: 
        SELECT Name, ListPrice
        FROM Production.Product;

--Answer:
    -- Returns Name and ListPrice for all rows in any order


-- Question 3) Get the first 10 rows sorted descending by name

--Query:  
        SELECT TOP 10 *
        FROM Production.Product 
        ORDER BY Name DESC;

--Answer:  
    -- Returns the first 10 rows with all columns
    -- Ordered descending alphabetically by Name




/* Product Tables Exercises - DISTINCT  */

-- Question 1) How many unique product colors exist?
--Query:  
        SELECT DISTINCT Color  
        FROM Production.Product;

--Answer the question in a comment:
    -- There are 9 unique colors


-- Question 2) Get distinct product names from the Name column

--Query:
        SELECT DISTINCT Name
        FROM Production.Product;

-- Answer:  
    -- There are 504 distinct product names


-- Question 3) Select the distinct product categories ordering alphabetically

-- Query:
        SELECT DISTINCT ProductSubcategoryID, Name
        FROM Production.Product
        ORDER BY ProductSubcategoryID;

-- Answer: 
    -- There are 37 distinct product subcategories
    -- Ordered alphabetically A-Z by ProductSubcategoryID



/* Product Tables Exercises - Aliases */

-- Question 1) Select ProductID and Alias to 'P1'

-- Query:
        SELECT ProductID AS P1
        FROM Production.Product;

-- Answer:
    -- Returns ProductID with column alias P1


-- Question 2) Alias the table Production.Product as 'P' 
-- Query:  
        SELECT P.Name, P.ListPrice   
        FROM Production.Product AS P;

-- Answer:  
    -- Aliased Production.Product table as P
    -- Referenced Name and ListPrice from alias P



-- Question 3) Merge Name and ProductNumber as ProductInfo
-- Query:  
        SELECT Name + ' (' + ProductNumber + ')' AS ProductInfo
        FROM Production.Product;

-- Answer:  
    -- Concatenated Name and ProductNumber 
    -- Alias created called ProductInfo
