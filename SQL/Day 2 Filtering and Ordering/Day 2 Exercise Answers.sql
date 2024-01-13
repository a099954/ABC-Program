/* Connections */

-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;




/* Product Tables Exercises - Where Clause  */


-- Question 1) Filter products over $100 list price
        
        SELECT * 
        FROM Production.Product 
        WHERE ListPrice > 100;


-- Question 2) Further filter products with StandardCost over $100
        
        SELECT * 
        FROM Production.Product 
        WHERE ListPrice > 100 
        AND StandardCost > 100;


-- Question 3) Additionally, filter products with sell start date of 2005

        SELECT * FROM 
        Production.Product 
        WHERE ListPrice > 100
        AND StandardCost > 100 
        AND SellStartDate > '2005-01-01';



/* Product Tables Exercises - Pattern Matching  */


-- Question 1) Use LIKE to search for a name containing 'racing’
        
        SELECT * 
        FROM Production.Product 
        WHERE Name LIKE '%racing%';

-- Question 2) Update the query to search for either 'racing' or 'touring' products
        
        SELECT * 
        FROM Production.Product 
        WHERE Name LIKE '%racing%' OR Name LIKE '%touring%';

-- Question 3) Add a NOT LIKE filter to leave out any product names containing 'children’

        SELECT * 
        FROM Production.Product 
        WHERE (Name LIKE '%racing%' OR Name LIKE '%touring%') 
        AND Name NOT LIKE '%children%'



/* Product Tables Exercises - Ordering */


-- Question 1) ORDER products by lowest ListPrice first

        SELECT * 
        FROM Production.Product 
        ORDER BY ListPrice;

-- Question 2) ORDER products by  descending ListPrice, ie. most expensive first

    SELECT * 
    FROM Production.Product 
    ORDER BY ListPrice DESC;

-- Question 3) Add a secondary sort to order Name within price groups

        SELECT * 
        FROM Production.Product 
        ORDER BY ListPrice DESC, Name;
