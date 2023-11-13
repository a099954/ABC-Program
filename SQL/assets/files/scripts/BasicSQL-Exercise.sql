-- Needed for String_Split and others support
-- ALTER DATABASE WideWorldImporters SET COMPATIBILITY_LEVEL = 150

USE WideWorldImporters

/* SQL and Strings */

-- Basic string
SELECT 'All for one, and one for all'

-- String concatenation with +
SELECT 'All for one, ' + 'and one for all'
SELECT 'All ' + 'for one ' + ', and ' + ' one for ' + 'all'


-- String length
SELECT LEN('All for one, and one for all')

-- String concatenation / aggregation
SELECT CONCAT('All for one,', ' and one for all')
SELECT STRING_AGG(CustomerCategoryName, ', ')
FROM Sales.CustomerCategories 

-- String SPLIT
SELECT * FROM STRING_SPLIT('All for one, and one for all.',' ')
SELECT * FROM STRING_SPLIT('All for one, and one for all.',',')

-- Substrings
SELECT TOP 5 FullName FROM Application.People
SELECT TOP 5 FullName, SUBSTRING(FullName,0,CHARINDEX(' ',FullName)+1) AS FirstName, LEFT(SUBSTRING(FullName,CHARINDEX(' ',FullName)+1,LEN(FullName)),1) AS LastInitial  FROM Application.People

-- Patterns
SELECT TOP 8 CustomerCategoryName, PATINDEX('G%',CustomerCategoryName) FROM Sales.CustomerCategories
SELECT TOP 8 CustomerCategoryName, PATINDEX('G%R%',CustomerCategoryName) FROM Sales.CustomerCategories

/* SQL and Math */

-- Basic Math, matching types
SELECT 6 + 6
SELECT 5/2
SELECT 5.0/2.0

-- Basic Math, mixing types
SELECT 5/2.0
SELECT 5.0/2

-- Checking data types
SELECT SQL_VARIANT_PROPERTY(5/2.0,'BaseType')

SELECT SQL_VARIANT_PROPERTY(5.0/2,'BaseType')

-- ABS
SELECT ABS(-5)

-- Math operators  %, *, /, +, -
SELECT 6 * 2
SELECT 6 * 2.0
SELECT 6/2
SELECT 6 % 2
SELECT 6/4, 6 % 4 -- dividend and remainder
SELECT SQUARE(6)
SELECT 6.0+2
SELECT 6-2.0

/* SELECT with Fields */

-- SELECT *
SELECT * FROM Sales.CustomerCategories

-- SELECT category names (individual field)
SELECT CustomerCategoryName FROM Sales.CustomerCategories

-- SELECT top 8 category names
SELECT TOP 8 CustomerCategoryName FROM Sales.CustomerCategories