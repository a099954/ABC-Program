/* Connections */

-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;

-- Step 1: Examine the Tables

-- Explanation Before:
-- Before diving into joins, it's essential to understand the data you're working with.
-- We'll start by counting the number of records in each table to get a sense of the dataset size.

-- Count the number of products
SELECT COUNT(*) AS ProductCount
FROM Production.Product;

-- Count the number of inventory records
SELECT COUNT(*) AS InventoryCount
FROM Production.ProductInventory;

-- Explanation After:
-- Compare the counts from both tables. This gives you an idea of how many products exist
-- and how many inventory records are available. If the product count is significantly higher
-- than the inventory count, expect many products without inventory records.

-- Step 2: Use LEFT JOIN to Retrieve All Products and Their Inventory Details

-- Explanation Before:
-- A LEFT JOIN will include all records from the left table (Production.Product),
-- along with matched records from the right table (Production.ProductInventory).
-- Unmatched records will have NULL values for columns from the right table.

-- Retrieve all products with their inventory details
SELECT 
    p.ProductID, 
    p.Name, 
    pi.LocationID, 
    pi.Quantity
FROM 
    Production.Product p
LEFT JOIN 
    Production.ProductInventory pi ON p.ProductID = pi.ProductID;

-- Explanation After:
-- Look at the results and note the rows where LocationID and Quantity are NULL.
-- These represent products without inventory records. Compare the number of rows returned
-- here with the product count from Step 1 to ensure all products are included.

-- Step 3: Filter Products with Inventory Using IS NOT NULL

-- Explanation Before:
-- By filtering with IS NOT NULL, we can exclude products that don't have inventory records,
-- effectively simulating an INNER JOIN.

-- Retrieve products that have inventory records
SELECT 
    p.ProductID, 
    p.Name, 
    pi.LocationID, 
    pi.Quantity
FROM 
    Production.Product p
LEFT JOIN 
    Production.ProductInventory pi ON p.ProductID = pi.ProductID
WHERE 
    pi.ProductID IS NOT NULL;

-- Explanation After:
-- Compare the results with Step 2. Notice that rows with NULL values for inventory details
-- are excluded. The number of rows should match the inventory count from Step 1,
-- showing only products with inventory records.

-- Step 4: Use INNER JOIN for Direct Comparison

-- Explanation Before:
-- An INNER JOIN directly retrieves records with matches in both tables.
-- This should yield the same results as Step 3.

-- Retrieve products with inventory using INNER JOIN
SELECT 
    p.ProductID, 
    p.Name, 
    pi.LocationID, 
    pi.Quantity
FROM 
    Production.Product p
INNER JOIN 
    Production.ProductInventory pi ON p.ProductID = pi.ProductID;

-- Explanation After:
-- Compare these results with Step 3. They should be identical, confirming that filtering
-- with IS NOT NULL on a LEFT JOIN can achieve the same outcome as an INNER JOIN.

-- Step 5: Demonstrate FULL JOIN for Completeness

-- Explanation Before:
-- A FULL JOIN returns all records from both tables, including unmatched records from both sides.
-- This provides a complete view of all possible combinations.

-- Retrieve all possible combinations of products and inventory records
SELECT 
    p.ProductID, 
    p.Name, 
    pi.LocationID, 
    pi.Quantity
FROM 
    Production.Product p
FULL JOIN 
    Production.ProductInventory pi ON p.ProductID = pi.ProductID;

-- Explanation After:
-- Examine the results to see products without inventory and inventory records without products.
-- Compare this with the previous steps to understand how FULL JOIN differs by including unmatched
-- records from both tables.

-- How to Compare and Contrast:
-- 1. Row Counts: Compare the number of rows returned by each query. This helps you understand
--    the impact of each join type and filter.
-- 2. Column Values: Focus on LocationID and Quantity to identify unmatched records.
--    NULL values indicate no match in the right table.
-- 3. Data Completeness: Use FULL JOIN to see all possible combinations, which can highlight
--    gaps in data matching.