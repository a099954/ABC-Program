-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;

-- Step 1: Data Extraction and Initial Filtering
-- Extract raw data into a temporary table and apply initial filtering
-- We create a temporary table named #FilteredWorkOrders to store work orders for products with a list price greater than $100.
-- The SELECT INTO statement extracts data from the joined Product and WorkOrder tables and filters it based on the ListPrice column.


-- Display the result of Step 1


-- Step 2: Creating Intermediate Results
-- Calculate the average order quantity for each product
-- In this step, we calculate the average order quantity for each product.
-- The result is stored in a new temporary table named #AvgOrderQtyByProduct.


-- Display the result of Step 2


-- Step 3: Further Intermediate Analysis
-- Calculate the total number of work orders per product
-- This step calculates the total number of work orders for each product and stores the results in #ProductWorkOrderCount.


-- Display the result of Step 3


-- Step 4: Joining Intermediate Results
-- Join the intermediate results to get average order quantities and work order counts
-- We join the #AvgOrderQtyByProduct and #ProductWorkOrderCount tables to combine the average order quantities and work order counts per product.
-- The results are stored in the #CombinedResults temporary table.



-- Display the result of Step 4


-- Step 5: Additional Statistics
-- Calculate the minimum and maximum order quantities for each product
-- This step calculates the minimum and maximum order quantities for each product and stores the results in #MinMaxOrderQtyByProduct.


-- Display the result of Step 5


-- Step 6: Final Analysis
-- Find the product with the highest average order quantity
-- In the final step, we identify the product with the highest average order quantity.
-- We join the #CombinedResults and #MinMaxOrderQtyByProduct tables to obtain additional statistics.
-- The result provides insights into products based on order quantities.

-- Clean up: Drop temporary tables when done