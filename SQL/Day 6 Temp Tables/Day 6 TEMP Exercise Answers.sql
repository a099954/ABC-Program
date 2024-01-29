-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;

-- Step 1: Data Extraction and Initial Filtering
-- Extract raw data into a temporary table and apply initial filtering
-- We create a temporary table named #FilteredProducts to store products with a list price greater than $100.
-- The SELECT INTO statement extracts data from the Product table and filters it based on the ListPrice column.
SELECT *
INTO #FilteredProducts
FROM Production.Product
WHERE ListPrice > 100; -- Filter products with a list price greater than 100

-- Display the result of Step 1
-- Here, we retrieve and display the contents of the #FilteredProducts temporary table.
SELECT * FROM #FilteredProducts;

-- Step 2: Creating Intermediate Results
-- Calculate the average list price for each product category
-- In this step, we calculate the average list price for each product subcategory.
-- The result is stored in a new temporary table named #AvgListPriceBySubcategory.
SELECT p1.ProductSubcategoryID, AVG(p1.ListPrice) AS AvgListPrice
INTO #AvgListPriceBySubcategory
FROM #FilteredProducts p1
GROUP BY p1.ProductSubcategoryID;

-- Display the result of Step 2
-- We retrieve and display the contents of the #AvgListPriceBySubcategory temporary table.

-- Step 3: Further Intermediate Analysis
-- Calculate the total number of products per subcategory
-- This step calculates the total number of products in each subcategory and stores the results in #SubcategoryProductCount.
SELECT p2.ProductSubcategoryID, COUNT(p2.ProductID) AS ProductCount
INTO #SubcategoryProductCount
FROM #FilteredProducts p2
GROUP BY p2.ProductSubcategoryID;

-- Display the result of Step 3
-- We retrieve and display the contents of the #SubcategoryProductCount temporary table.

-- Step 4: Joining Intermediate Results
-- Join the intermediate results to get category names and counts
-- We join the #AvgListPriceBySubcategory and #SubcategoryProductCount tables to combine the average list prices and product counts per subcategory.
-- The results are stored in the #CombinedResults temporary table.
SELECT alp.ProductSubcategoryID, alp.AvgListPrice, spc.ProductCount
INTO #CombinedResults
FROM #AvgListPriceBySubcategory alp
INNER JOIN #SubcategoryProductCount spc
ON alp.ProductSubcategoryID = spc.ProductSubcategoryID;

-- Display the result of Step 4
-- We retrieve and display the contents of the #CombinedResults temporary table.

-- Step 5: Additional Statistics
-- Calculate the minimum and maximum list prices for each subcategory
-- This step calculates the minimum and maximum list prices for each subcategory and stores the results in #MinMaxListPriceBySubcategory.
SELECT p3.ProductSubcategoryID, MIN(p3.ListPrice) AS MinListPrice, MAX(p3.ListPrice) AS MaxListPrice
INTO #MinMaxListPriceBySubcategory
FROM #FilteredProducts p3
GROUP BY p3.ProductSubcategoryID;

-- Display the result of Step 5
-- We retrieve and display the contents of the #MinMaxListPriceBySubcategory temporary table.

-- Step 6: Final Analysis
-- Find the subcategory with the highest average list price
-- In the final step, we identify the subcategory with the highest average list price.
-- We join the #CombinedResults and #MinMaxListPriceBySubcategory tables to obtain additional statistics.
-- The result provides insights into product subcategories based on list prices.

-- Clean up: Drop temporary tables when done
-- After completing the analysis, we drop all temporary tables to free up resources.
DROP TABLE #FilteredProducts;
DROP TABLE #AvgListPriceBySubcategory;
DROP TABLE #SubcategoryProductCount;
DROP TABLE #CombinedResults;
DROP TABLE #MinMaxListPriceBySubcategory;
