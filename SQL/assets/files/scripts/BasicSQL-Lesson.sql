USE WideWorldImporters

/* SQL and Strings */

-- Basic string
SELECT 'This is a string'

-- String concatenation with +
SELECT 'This is ' + 'a string'
SELECT 'This ' + 'is a ' + 'string'
SELECT 'This ' + 'is ' + 'a ' + 'string'

-- String length
SELECT LEN('This is a string')

-- String concatenation / aggregation
SELECT CONCAT('This is ', 'a string')
SELECT CONCAT('This ', 'is a', ' string')
SELECT STRING_AGG(ColorName, ', ')
FROM Warehouse.Colors 

-- String SPLIT
SELECT * FROM STRING_SPLIT('This is a string',' ')
SELECT * FROM STRING_SPLIT('Apples, oranges, peaches, bananas',',')

-- Substrings
SELECT TOP 5 FullName FROM Application.People
SELECT TOP 5 LEFT(FullName,1) AS FirstInitial, SUBSTRING(FullName,CHARINDEX(' ',FullName)+1,LEN(FullName)) AS LastName FROM Application.People

SELECT TOP 5 FullName,CHARINDEX(' ',FullName) FROM Application.People
SELECT TOP 5 FullName,CHARINDEX(',',FullName) FROM Application.People

-- Patterns
SELECT TOP 5 FullName, PATINDEX('A%',FullName) FROM Application.People 
SELECT TOP 5 FullName, PATINDEX('%aa%a',FullName) FROM Application.People 
SELECT TOP 5 FullName, PATINDEX('%aa%[aeiou]',FullName) FROM Application.People 
SELECT TOP 5 FullName, PATINDEX('%aa%[^aeiou]',FullName) FROM Application.People
SELECT TOP 5 FullName, PATINDEX('A%B%',FullName) FROM Application.People WHERE PATINDEX('A%B%',FullName) > 0 -- doesn't make sense to use PATINDEX in WHERE; use for substrings and split strings
SELECT TOP 5 FullName, PATINDEX('A%B%',FullName) FROM Application.People WHERE FullName LIKE 'A%B%'

/* SQL and Math */

-- Basic Math, matching types
SELECT 1 + 1
SELECT 3/2
SELECT 3.0/2.0

-- Basic Math, mixing types
SELECT 3/2.0
SELECT 3.0/2

-- Checking data types
SELECT SQL_VARIANT_PROPERTY(3/2.0,'BaseType')

SELECT SQL_VARIANT_PROPERTY(3/2,'BaseType')

-- Introducing comments
/*

This is a multi-line comment.  In this line of code below, we're seeing what the result is from dividing an int by a numeric.

*/
SELECT SQL_VARIANT_PROPERTY(3/2.0,'BaseType')

-- This is a single-line comment.  In this line of code below, we are seeing what the result is from dividing an int by an int.
SELECT SQL_VARIANT_PROPERTY(3/2,'BaseType')

-- ABS
SELECT ABS(-3.1415)

-- Math operators >=, <=, >, , ^, %, *, /, +, -
SELECT 8 * 2
SELECT 8 * 2.0
SELECT 8/2
SELECT 8 % 2
SELECT 8/6, 8 % 6 -- dividend and remainder
SELECT SQUARE(8)
SELECT 8.0+2
SELECT 8-2.0

/* SELECT with Fields */

-- SELECT *
SELECT * FROM Warehouse.Colors

-- Specific fields
SELECT ColorID, ColorName FROM Warehouse.Colors

-- Top records
SELECT TOP 5 ColorID, ColorName FROM Warehouse.Colors
