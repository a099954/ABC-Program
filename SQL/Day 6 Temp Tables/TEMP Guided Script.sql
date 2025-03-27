-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;

-- Step 1: Data Extraction and Initial Filtering
SELECT *
INTO #FilteredProducts
FROM Production.Product
WHERE ListPrice > 100 
      AND ListPrice IS NOT NULL
      AND Color IS NOT NULL;

-- Look at results
SELECT *
FROM #FilteredProducts;

-- Step: Remove Duplicates
SELECT DISTINCT *
INTO #UniqueFilteredProducts
FROM #FilteredProducts;

-- Look at results
SELECT *
FROM #UniqueFilteredProducts;

-- Step 2: Basic Statistics
-- Explanation: Calculate average, standard deviation, and mode of list prices to understand central tendency.

-- Calculate average and standard deviation
SELECT 
    AVG(ListPrice) AS AvgPrice, 
    STDEV(ListPrice) AS StdDev
INTO #PriceStats
FROM #UniqueFilteredProducts;

-- Look at results
SELECT *
FROM #PriceStats;

-- Calculate mode
SELECT TOP 1 ListPrice AS ModePrice
INTO #ModePrice
FROM #UniqueFilteredProducts
GROUP BY ListPrice
ORDER BY COUNT(*) DESC;

-- Look at results
SELECT *
FROM #ModePrice;

-- Step 3: Outlier Identification
-- Explanation: Identify outliers by checking products that fall outside the typical range defined by standard deviation.

-- Find the outliers on tail 1 (above the upper threshold)
SELECT fp.*
FROM #UniqueFilteredProducts fp
INNER JOIN #PriceStats ps
  ON fp.ListPrice >= ps.AvgPrice + 2 * ps.StdDev;

-- Find the outliers on tail 2 (below the lower threshold)
SELECT fp.*
FROM #UniqueFilteredProducts fp
INNER JOIN #PriceStats ps
  ON fp.ListPrice <= ps.AvgPrice - 1 * ps.StdDev;

-- Explanation: Now, identify products that are within the acceptable range.
-- This includes products that are not outliers on either tail.

-- Data to include tail 1
SELECT fp.*
FROM #UniqueFilteredProducts fp
INNER JOIN #PriceStats ps
  ON fp.ListPrice <= ps.AvgPrice + 2 * ps.StdDev;

-- Data to include tail 2
SELECT fp.*
FROM #UniqueFilteredProducts fp
INNER JOIN #PriceStats ps
  ON fp.ListPrice >= ps.AvgPrice - 1 * ps.StdDev;

-- Explanation: Combine both criteria to exclude outliers and create a temporary table with non-outlier products.
SELECT fp.*
INTO #NonOutlierProducts
FROM #UniqueFilteredProducts fp
INNER JOIN #PriceStats ps
  ON fp.ListPrice BETWEEN ps.AvgPrice - 1 * ps.StdDev AND ps.AvgPrice + 2 * ps.StdDev;

-- Look at results
SELECT *
FROM #NonOutlierProducts;

-- Step: Check for Missing Values
SELECT *
FROM #NonOutlierProducts
WHERE ProductSubcategoryID IS NULL;

-- Step: Count of Products by Color
SELECT Color, COUNT(*) AS ProductCount
FROM #NonOutlierProducts
GROUP BY Color
ORDER BY ProductCount DESC;

-- Step: Average List Price by Color
SELECT Color, AVG(ListPrice) AS AvgListPrice
FROM #NonOutlierProducts
GROUP BY Color
ORDER BY AvgListPrice DESC;

-- Step 4: Aggregated Insights
SELECT p1.ProductSubcategoryID, 
       AVG(p1.ListPrice) AS AvgListPrice, 
       COUNT(p1.ProductID) AS ProductCount
INTO #SubcategoryInsights
FROM #NonOutlierProducts p1
GROUP BY p1.ProductSubcategoryID;

-- Look at results
SELECT *
FROM #SubcategoryInsights;

-- Step 5: Key Insights
SELECT TOP 1 ProductSubcategoryID, AvgListPrice, ProductCount
FROM #SubcategoryInsights
ORDER BY AvgListPrice DESC;

-- Step 6: Distribution Analysis
SELECT ListPrice,
    CASE 
        WHEN ListPrice < 200 THEN '100-199'
        WHEN ListPrice BETWEEN 200 AND 299 THEN '200-299'
        WHEN ListPrice BETWEEN 300 AND 399 THEN '300-399'
        WHEN ListPrice BETWEEN 400 AND 499 THEN '400-499'
        ELSE '500+' 
    END AS PriceRange
INTO #DistResults
FROM #NonOutlierProducts;

-- Look at results
SELECT *
FROM #DistResults;

-- Aggregate by price range
SELECT PriceRange, COUNT(*) AS ProductCount
FROM #DistResults
GROUP BY PriceRange
ORDER BY PriceRange;

-- Clean up: Drop temporary tables when done
DROP TABLE #FilteredProducts;
DROP TABLE #UniqueFilteredProducts;
DROP TABLE #PriceStats;
DROP TABLE #ModePrice;
DROP TABLE #NonOutlierProducts;
DROP TABLE #SubcategoryInsights;
DROP TABLE #DistResults;