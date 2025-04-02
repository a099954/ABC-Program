-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;

-- Data Preparation and Cleaning

-- Step 1: Data Extraction
-- Create a temporary table to store the joined results including StandardCost
SELECT 
    p.ProductID,
    p.Name AS ProductName,
    p.ListPrice,
    p.StandardCost,
    w.WorkOrderID,
    w.OrderQty,
    w.DueDate
INTO 
    #ProductWorkOrderTemp
FROM 
    Production.Product AS p
INNER JOIN 
    Production.WorkOrder AS w ON p.ProductID = w.ProductID;

-- Display the initial joined results
SELECT * FROM #ProductWorkOrderTemp;

-- Step 2: Initial Filtering
-- Filter products with a list price greater than 100 and non-null values for ListPrice and StandardCost
SELECT *
INTO #FilteredProductWorkOrder
FROM #ProductWorkOrderTemp
WHERE ListPrice > 100 
      AND ListPrice IS NOT NULL
      AND StandardCost IS NOT NULL;

-- Display the filtered results
SELECT * FROM #FilteredProductWorkOrder;

-- Step 3: Remove Duplicates
-- Create a temporary table with distinct products and work orders to eliminate duplicates
SELECT DISTINCT *
INTO #UniqueFilteredProductWorkOrder
FROM #FilteredProductWorkOrder;

-- Display the unique filtered products and work orders
SELECT * FROM #UniqueFilteredProductWorkOrder;

-- Step 4: Basic Statistics
-- Calculate average and standard deviation of list prices to understand central tendency
SELECT 
    AVG(ListPrice) AS AvgPrice, 
    STDEV(ListPrice) AS StdDev
INTO #PriceStats
FROM #UniqueFilteredProductWorkOrder;

-- Display the calculated average and standard deviation
SELECT * FROM #PriceStats;

-- Step 5: Calculate Standard Deviations
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

-- Step 6: Identify Products within Acceptable Range
-- Select products within the acceptable range based on deviation calculations
SELECT *
INTO #NonOutlierProducts
FROM #UniqueFilteredProductWorkOrder uf
INNER JOIN #DeviationRanges dr
ON uf.ListPrice >= dr.Minus3StdDev AND uf.ListPrice <= dr.Plus3StdDev;

-- Display products that are not outliers
SELECT * FROM #NonOutlierProducts;

-- Step 7: Identify Outliers
-- Select products outside the acceptable range to identify outliers
SELECT uf.*
INTO #OutlierProducts
FROM #UniqueFilteredProductWorkOrder uf
INNER JOIN #DeviationRanges dr
ON uf.ListPrice < dr.Minus3StdDev OR uf.ListPrice > dr.Plus3StdDev;

-- Display outlier products
SELECT * FROM #OutlierProducts;

-- Step 8: Recalculate Statistics for Non-Outliers
-- Calculate average and standard deviation of list prices for non-outlier products
SELECT 
    AVG(ListPrice) AS CleanAvgPrice, 
    STDEV(ListPrice) AS CleanStdDev
INTO #NonOutlierPriceStats
FROM #NonOutlierProducts;

-- Display recalculated average and standard deviation for non-outliers and compare to original
SELECT * FROM #NonOutlierPriceStats;
SELECT * FROM #PriceStats;

-- Mathematical and Statistical Analysis

-- Step 9: Profit Calculation
-- Calculate profit per unit and total profit for each product
SELECT 
    ProductID,
    ProductName,
    ListPrice,
    StandardCost,
    OrderQty,
    (ListPrice - StandardCost) AS ProfitPerUnit,
    (ListPrice - StandardCost) * OrderQty AS TotalProfit
INTO #ProfitAnalysis
FROM #NonOutlierProducts;

-- Display profit analysis results
SELECT * FROM #ProfitAnalysis;

-- Step 10: Aggregated Insights
-- Calculate average list price, average profit per unit, and total profit by product
SELECT pa.ProductID, 
       AVG(pa.ListPrice) AS AvgListPrice, 
       AVG(pa.ProfitPerUnit) AS AvgProfitPerUnit, 
       SUM(pa.TotalProfit) AS TotalProfit,
	   SUM(pa.OrderQty) AS TotalOrdered
INTO #ProductInsights
FROM #ProfitAnalysis pa
GROUP BY pa.ProductID;

-- Display product insights
SELECT * FROM #ProductInsights;

-- Step 11: Key Insights
-- Identify the product with the highest total profit
SELECT TOP 1 ProductID, AvgListPrice, AvgProfitPerUnit, TotalProfit, TotalOrdered
FROM #ProductInsights
ORDER BY TotalProfit DESC;

-- Step 12: Distribution Analysis
-- Categorize products into price ranges and store in a temporary table
SELECT ProductID, ListPrice,
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

-- Step 13: Due Date Analysis
-- Calculate the average and standard deviation of due dates
SELECT 
    AVG(CAST(DueDate AS FLOAT)) AS AvgDueDate, 
    STDEV(CAST(DueDate AS FLOAT)) AS StdDevDueDate
INTO #DueDateStats
FROM #NonOutlierProducts;

-- Display due date statistics
SELECT 
    CAST(AvgDueDate AS DATETIME) AS AvgDueDate, 
    StdDevDueDate
FROM #DueDateStats;

-- Step 14: Work Orders by Month
-- Aggregate the number of work orders by month to identify trends
SELECT 
    DATEPART(YEAR, DueDate) AS Year,
    DATEPART(MONTH, DueDate) AS Month,
    COUNT(*) AS WorkOrderCount
INTO #WorkOrdersByMonth
FROM #NonOutlierProducts
GROUP BY DATEPART(YEAR, DueDate), DATEPART(MONTH, DueDate)
ORDER BY Year, Month;

-- Display work orders by month
SELECT * FROM #WorkOrdersByMonth
ORDER BY Year, Month;

-- Clean up: Drop temporary tables when done to free up resources
DROP TABLE #ProductWorkOrderTemp;
DROP TABLE #FilteredProductWorkOrder;
DROP TABLE #UniqueFilteredProductWorkOrder;
DROP TABLE #PriceStats;
DROP TABLE #DeviationRanges;
DROP TABLE #NonOutlierProducts;
DROP TABLE #OutlierProducts;
DROP TABLE #NonOutlierPriceStats;
DROP TABLE #ProfitAnalysis;
DROP TABLE #ProductInsights;
DROP TABLE #DistResults;
DROP TABLE #DueDateStats;
DROP TABLE #WorkOrdersByMonth;