-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;

-- Step 1: Data Extraction and Initial Filtering
-- Extract raw data into a temporary table and apply initial filtering
SELECT *
INTO #FilteredProducts
FROM Production.Product
WHERE ListPrice > 100; -- Filter products with a list price greater than 100

-- Display the result of Step 1
SELECT * FROM #FilteredProducts;

-- Step 2: Creating Intermediate Results
-- Calculate the average list price for each product category
SELECT p1.ProductSubcategoryID, AVG(p1.ListPrice) AS AvgListPrice
INTO #AvgListPriceBySubcategory
FROM #FilteredProducts p1
GROUP BY p1.ProductSubcategoryID;

-- Display the result of Step 2
SELECT * FROM #AvgListPriceBySubcategory;

-- Step 3: Further Intermediate Analysis
-- Calculate the total number of products per subcategory
SELECT p2.ProductSubcategoryID, COUNT(p2.ProductID) AS ProductCount
INTO #SubcategoryProductCount
FROM #FilteredProducts p2
GROUP BY p2.ProductSubcategoryID;

-- Display the result of Step 3
SELECT * FROM #SubcategoryProductCount;

-- Step 4: Joining Intermediate Results
-- Join the intermediate results to get category names and counts
SELECT alp.ProductSubcategoryID, alp.AvgListPrice, spc.ProductCount
INTO #CombinedResults
FROM #AvgListPriceBySubcategory alp
INNER JOIN #SubcategoryProductCount spc
ON alp.ProductSubcategoryID = spc.ProductSubcategoryID;

-- Display the result of Step 4
SELECT * FROM #CombinedResults;

-- Step 5: Additional Statistics
-- Calculate the minimum and maximum list prices for each subcategory
SELECT p3.ProductSubcategoryID, MIN(p3.ListPrice) AS MinListPrice, MAX(p3.ListPrice) AS MaxListPrice
INTO #MinMaxListPriceBySubcategory
FROM #FilteredProducts p3
GROUP BY p3.ProductSubcategoryID;

-- Display the result of Step 5
SELECT * FROM #MinMaxListPriceBySubcategory;

-- Step 6: Final Analysis
-- Find the subcategory with the highest average list price
SELECT TOP 1 alp.ProductSubcategoryID, alp.AvgListPrice, alp.ProductCount, mmlp.MinListPrice, mmlp.MaxListPrice
FROM #CombinedResults alp
INNER JOIN #MinMaxListPriceBySubcategory mmlp
ON alp.ProductSubcategoryID = mmlp.ProductSubcategoryID
ORDER BY alp.AvgListPrice DESC;

-- Clean up: Drop temporary tables when done
DROP TABLE #FilteredProducts;
DROP TABLE #AvgListPriceBySubcategory;
DROP TABLE #SubcategoryProductCount;
DROP TABLE #CombinedResults;
DROP TABLE #MinMaxListPriceBySubcategory;


/* In this script, we start with the #FilteredProducts table, and in each step, 
we join it back to itself to create intermediate results. 
This approach allows you to see how data evolves as you perform multiple joins 
on the same table. */
