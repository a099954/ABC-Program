-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;

-- Step 1: Data Extraction and Initial Filtering
-- Extract raw data into a temporary table, apply initial filtering, and handle nulls
SELECT *
INTO #FilteredProducts
FROM Production.Product
WHERE ListPrice > 100 AND ListPrice IS NOT NULL; -- Filter products with a list price greater than 100 and ensure no nulls

-- Step 2: Calculate Average and Standard Deviation
-- Calculate the average and standard deviation of the list prices
SELECT 
    AVG(ListPrice) AS AvgPrice, 
    STDEV(ListPrice) AS StdDev
INTO #PriceStats
FROM #FilteredProducts;

-- Step 3: Outlier Identification
-- Join the filtered products with price stats to identify non-outliers
SELECT fp.*
INTO #NonOutlierProducts
FROM #FilteredProducts fp
LEFT JOIN #PriceStats ps
ON fp.ListPrice <= ps.AvgPrice + 3 * ps.StdDev;

-- Step 4: Creating Intermediate Results
-- Calculate the average list price for each product category using non-outlier data
SELECT p1.ProductSubcategoryID, AVG(p1.ListPrice) AS AvgListPrice
INTO #AvgListPriceBySubcategory
FROM #NonOutlierProducts p1
GROUP BY p1.ProductSubcategoryID;

-- Step 5: Further Intermediate Analysis
-- Calculate the total number of products per subcategory using non-outlier data
SELECT p2.ProductSubcategoryID, COUNT(p2.ProductID) AS ProductCount
INTO #SubcategoryProductCount
FROM #NonOutlierProducts p2
GROUP BY p2.ProductSubcategoryID;

-- Step 6: Joining Intermediate Results
-- Join the intermediate results to get category names and counts
SELECT alp.ProductSubcategoryID, alp.AvgListPrice, spc.ProductCount
INTO #CombinedResults
FROM #AvgListPriceBySubcategory alp
LEFT JOIN #SubcategoryProductCount spc
ON alp.ProductSubcategoryID = spc.ProductSubcategoryID;

-- Step 7: Additional Statistics
-- Calculate the minimum and maximum list prices for each subcategory using non-outlier data
SELECT p3.ProductSubcategoryID, MIN(p3.ListPrice) AS MinListPrice, MAX(p3.ListPrice) AS MaxListPrice
INTO #MinMaxListPriceBySubcategory
FROM #NonOutlierProducts p3
GROUP BY p3.ProductSubcategoryID;

-- Step 8: Final Analysis
-- Find the subcategory with the highest average list price
SELECT TOP 1 cr.ProductSubcategoryID, cr.AvgListPrice, cr.ProductCount, mmlp.MinListPrice, mmlp.MaxListPrice
FROM #CombinedResults cr
INNER JOIN #MinMaxListPriceBySubcategory mmlp
ON cr.ProductSubcategoryID = mmlp.ProductSubcategoryID
ORDER BY cr.AvgListPrice DESC;

-- Step 9: Distribution Analysis
-- Frequency count of products by price range
SELECT 
    CASE 
        WHEN ListPrice < 200 THEN '100-199'
        WHEN ListPrice BETWEEN 200 AND 299 THEN '200-299'
        WHEN ListPrice BETWEEN 300 AND 399 THEN '300-399'
        WHEN ListPrice BETWEEN 400 AND 499 THEN '400-499'
        ELSE '500+' 
    END AS PriceRange,
    COUNT(*) AS ProductCount
FROM #NonOutlierProducts
GROUP BY 
    CASE 
        WHEN ListPrice < 200 THEN '100-199'
        WHEN ListPrice BETWEEN 200 AND 299 THEN '200-299'
        WHEN ListPrice BETWEEN 300 AND 399 THEN '300-399'
        WHEN ListPrice BETWEEN 400 AND 499 THEN '400-499'
        ELSE '500+' 
    END
ORDER BY PriceRange;

-- Step 10: Basic Descriptive Statistics
-- Calculate mean, variance, and standard deviation of ListPrice
SELECT 
    AVG(ListPrice) AS MeanListPrice,
    VAR(ListPrice) AS VarianceListPrice,
    STDEV(ListPrice) AS StdDevListPrice
FROM #NonOutlierProducts;

-- Calculate mode of ListPrice
SELECT TOP 1 ListPrice AS ModeListPrice
FROM #NonOutlierProducts
GROUP BY ListPrice
ORDER BY COUNT(*) DESC;

-- Clean up: Drop temporary tables when done
DROP TABLE #FilteredProducts;
DROP TABLE #PriceStats;
DROP TABLE #NonOutlierProducts;
DROP TABLE #AvgListPriceBySubcategory;
DROP TABLE #SubcategoryProductCount;
DROP TABLE #CombinedResults;
DROP TABLE #MinMaxListPriceBySubcategory;

/* This enhanced script includes distribution analysis and basic descriptive statistics 
such as mean, variance, standard deviation, and mode. The median calculation is omitted 
as it typically requires a subquery or window functions, which are not requested here. */