/* Connections */

-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;


-- For this exercise, we are using the production tables.



/* Product Tables Exercises - INNER JOIN  */


-- Question 1) What are the inventory shelf locations for the "Bearing Ball" product over time?

-- Step 1) Join Product table (p) to the ProductInventory table (inv)
-- and return p.Name AS Product, inv.Shelf AS InventoryShelf, and inv.ModifiedDate AS SnapshotDate


-- Step 2) Filter the results using p.Name = 'Bearing Ball'



-- Question 2) What are the standard costs over time for our high-end road bike models?

-- Step 1) Join Product table (p) to the ProductCostHistory table (pch)
-- and return p.Name AS Product, pch.StartDate, and pch.StandardCost


--Step 2) Order the results by Cost Date




/* Product Tables Exercises - LEFT JOIN  */

-- Question 1) What products do we currently not have any inventory quantity on hand for?

-- Step 1) Join the Product table (p) to the ProductInventory table (inv)
-- and return p.Name AS (Product)


-- Step 2) check for Missing Snapshot by filtering out NULL on ProductID


-- Step 3) Order Results




/* Product Tables Exercises - Aggregate INNER JOINS  */

-- Question 1) What products have we stocked the highest inventory quantity for over time?

-- Step 1) Join the Product table (p) to the ProductInventory table (inv)
-- and return the p.Name AS (Product) and inv.LocationID AS InventoryLocationID


-- Step 2) Add an Aggregate by taking the SUM of inv.Quantity
-- and group by p.Name


-- Step 3) Order the results by TotalQuantity

