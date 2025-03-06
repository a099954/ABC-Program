/* Connections */

-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;

/* Product Tables Exercises - Where Clause  */

-- Question 1) Filter products over $100 list price
SELECT * 
FROM Production.Product 
WHERE ListPrice > 100;
-- This query retrieves products with a ListPrice greater than $100.
-- It's useful for finding high-priced items in the product table.

-- Question 2) Further filter products with StandardCost over $100
SELECT * 
FROM Production.Product 
WHERE ListPrice > 100 
AND StandardCost > 100;
-- This query filters products with both ListPrice and StandardCost over $100.
-- It helps identify products that are both expensive to sell and produce.

-- Question 3) Additionally, filter products with a sell start date of 2005
SELECT * FROM 
Production.Product 
WHERE ListPrice > 100
AND StandardCost > 100 
AND SellStartDate > '2005-01-01';
-- This query adds a filter for products with a SellStartDate in or after 2005.
-- It's valuable for selecting products available for sale after a specific date.

/* Product Tables Exercises - Pattern Matching  */

-- Question 1) Use LIKE to search for a name containing 'racing’
SELECT * 
FROM Production.Product 
WHERE Name LIKE '%racing%';
-- This query finds products with 'racing' in their name using the '%' wildcard.
-- It's helpful for locating products related to racing.

-- Question 2) Update the query to search for either 'racing' or 'touring' products
SELECT * 
FROM Production.Product 
WHERE Name LIKE '%racing%' OR Name LIKE '%touring%';
-- This query expands the search to include both 'racing' and 'touring' products.
-- It's useful for broadening the scope of the search.

-- Question 3) Add a NOT LIKE filter to leave out any product names containing 'frame’
SELECT * 
FROM Production.Product 
WHERE (Name LIKE '%racing%' OR Name LIKE '%touring%') 
AND Name NOT LIKE '%frame%';
-- This query excludes products with 'children' in their name.
-- It's beneficial for refining the search to exclude certain types of products.

/* Product Tables Exercises - Ordering */

-- Question 1) ORDER products by the lowest ListPrice first
SELECT * 
FROM Production.Product 
ORDER BY ListPrice;
-- This query orders products by ascending ListPrice.
-- It helps in identifying the least expensive products.

-- Question 2) ORDER products by descending ListPrice, i.e., most expensive first
SELECT * 
FROM Production.Product 
ORDER BY ListPrice DESC;
-- This query orders products by descending ListPrice, showing the most expensive first.
-- It's useful for finding the most costly items in the product list.

-- Question 3) Add a secondary sort to order by Name within list price
SELECT * 
FROM Production.Product 
ORDER BY ListPrice DESC, Name;
-- This query orders products by descending ListPrice and, within each price group, by Name.
-- It enhances the organization of the results for better analysis.