-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;

-- Step 1: Data Extraction and Initial Filtering
-- Extract products with a list price greater than 100 and non-null values for ListPrice and Color
SELECT *
INTO #FilteredProducts
FROM Production.Product
WHERE ListPrice > 100 
      AND ListPrice IS NOT NULL
      AND Color IS NOT NULL;

-- Display the filtered products
SELECT * FROM #FilteredProducts;

-- Step 2: Remove Duplicates
-- Create a temporary table with distinct products to eliminate duplicates
SELECT DISTINCT *
INTO #UniqueFilteredProducts
FROM #FilteredProducts;

-- Display the unique filtered products
SELECT * FROM #UniqueFilteredProducts;

-- Step 3: Basic Statistics
-- Calculate average and standard deviation of list prices to understand central tendency
SELECT 
    AVG(ListPrice) AS AvgPrice, 
    STDEV(ListPrice) AS StdDev
INTO #PriceStats
FROM #UniqueFilteredProducts;

-- Display the calculated average and standard deviation
SELECT * FROM #PriceStats;

-- Step 4: Calculate Standard Deviations
-- Calculate the values for 1, 2, and 3 standard deviations above and below the average
SELECT 
    AvgPrice - 3 * StdDev AS Minus3StdDev,
    AvgPrice - 2 * StdDev AS Minus2StdDev,
    AvgPrice - 1 * StdDev AS Minus1StdDev,
    AvgPrice AS AvgPrice,
    AvgPrice + 1 * StdDev AS Plus1StdDev,
    AvgPrice + 2 * StdDev AS Plus2StdDev,
    AvgPrice + 3 * StdDev AS Plus3StdDev
INTO #DeviationRanges
FROM #PriceStats;

-- Display the deviation ranges
SELECT * FROM #DeviationRanges;

-- Step 5: Identify Products within Acceptable Range
-- Create a temporary table for products within tail 1 (up to 2 standard deviations above average)
SELECT fp.*
INTO #Tail1Products
FROM #UniqueFilteredProducts fp
INNER JOIN #DeviationRanges dr
  ON fp.ListPrice <= dr.Plus2StdDev;

-- Create a temporary table for products within tail 2 (at least 1 standard deviation below average)
SELECT fp.*
INTO #Tail2Products
FROM #UniqueFilteredProducts fp
INNER JOIN #DeviationRanges dr
  ON fp.ListPrice >= dr.Minus1StdDev;

-- Step 6: Combine Results to Exclude Outliers
-- Combine the results from both tails to exclude outliers and keep only products within the acceptable range
SELECT t1.*
INTO #NonOutlierProducts
FROM #Tail1Products t1
INNER JOIN #Tail2Products t2
ON t1.ProductID = t2.ProductID;

-- Display products that are not outliers
SELECT * FROM #NonOutlierProducts;

-- Step 7: Color-Based Insights
-- Calculate the count of products by color and store in a temporary table
SELECT Color, COUNT(*) AS ProductCount
INTO #ProductCountByColor
FROM #NonOutlierProducts
GROUP BY Color;

-- Calculate the average list price by color and store in a temporary table
SELECT Color, AVG(ListPrice) AS AvgListPrice
INTO #AvgPriceByColor
FROM #NonOutlierProducts
GROUP BY Color;

-- Join the temporary tables on Color to combine product count and average list price
SELECT pc.Color, pc.ProductCount, ap.AvgListPrice
INTO #ColorInsights
FROM #ProductCountByColor pc
INNER JOIN #AvgPriceByColor ap
ON pc.Color = ap.Color;

-- Display color-based insights
SELECT * FROM #ColorInsights;

-- Step 8: Aggregated Insights
-- Calculate average list price and product count by subcategory
SELECT p1.ProductSubcategoryID, 
       AVG(p1.ListPrice) AS AvgListPrice, 
       COUNT(p1.ProductID) AS ProductCount
INTO #SubcategoryInsights
FROM #NonOutlierProducts p1
GROUP BY p1.ProductSubcategoryID;

-- Display subcategory insights
SELECT * FROM #SubcategoryInsights;

-- Step 9: Key Insights
-- Identify the subcategory with the highest average list price
SELECT TOP 1 ProductSubcategoryID, AvgListPrice, ProductCount
FROM #SubcategoryInsights
ORDER BY AvgListPrice DESC;

-- Step 10: Distribution Analysis
-- Categorize products into price ranges and store in a temporary table
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

-- Display distribution results
SELECT * FROM #DistResults;

-- Aggregate by price range to count products in each range
SELECT PriceRange, COUNT(*) AS ProductCount
FROM #DistResults
GROUP BY PriceRange
ORDER BY PriceRange;

-- Clean up: Drop temporary tables when done to free up resources
DROP TABLE #FilteredProducts;
DROP TABLE #UniqueFilteredProducts;
DROP TABLE #PriceStats;
DROP TABLE #DeviationRanges;
DROP TABLE #Tail1Products;
DROP TABLE #Tail2Products;
DROP TABLE #NonOutlierProducts;
DROP TABLE #ProductCountByColor;
DROP TABLE #AvgPriceByColor;
DROP TABLE #ColorInsights;
DROP TABLE #SubcategoryInsights;
DROP TABLE #DistResults;