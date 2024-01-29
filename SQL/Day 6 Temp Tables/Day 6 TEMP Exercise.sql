-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;

-- Exercise: Analyzing Product Data
-- In this exercise, you will perform a series of SQL tasks to analyze product data from the AdventureWorks2012 database.
-- You will use temporary tables to break down the analysis into intermediate steps.

-- Step 1: Data Extraction and Initial Filtering
-- Create a temporary table named #FilteredProducts to store products with a list price greater than $100.
-- Hint: Use the SELECT INTO statement to extract data from the Product table and filter based on the ListPrice column.

-- Step 2: Creating Intermediate Results
-- Calculate the average list price for each product subcategory and store the results in a temporary table named #AvgListPriceBySubcategory.
-- Hint: Use the AVG() function and GROUP BY clause.

-- Step 3: Further Intermediate Analysis
-- Calculate the total number of products in each subcategory and store the results in a temporary table named #SubcategoryProductCount.
-- Hint: Use the COUNT() function and GROUP BY clause.

-- Step 4: Joining Intermediate Results
-- Join the #AvgListPriceBySubcategory and #SubcategoryProductCount tables to combine average list prices and product counts per subcategory.
-- Store the results in a temporary table named #CombinedResults.
-- Hint: Use the INNER JOIN clause.

-- Step 5: Additional Statistics
-- Calculate the minimum and maximum list prices for each subcategory and store the results in a temporary table named #MinMaxListPriceBySubcategory.
-- Hint: Use the MIN() and MAX() functions along with GROUP BY.

-- Step 6: Final Analysis
-- Find the subcategory with the highest average list price.
-- Join the #CombinedResults and #MinMaxListPriceBySubcategory tables to obtain additional statistics.
-- Identify the subcategory with the highest average list price.
-- Hint: Use the TOP 1 and ORDER BY clauses.

-- Clean up: Drop temporary tables when done.

-- Your task is to write SQL statements for each step of the exercise.
-- Use the provided hints to guide you. Good luck!
