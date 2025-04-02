/* Connections */

-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;
-- For this exercise, we are using the production tables.



/* Product Tables Exercises - INNER JOIN  */


-- Question 1) What are the inventory shelf locations for the "Bearing Ball" product over time?

-- Step 1) Join Product table (p) to the ProductInventory table (inv)
-- and return p.Name AS Product, inv.Shelf AS InventoryShelf, and inv.ModifiedDate AS SnapshotDate
-- This INNER JOIN combines product and inventory data to track the shelf locations of the "Bearing Ball" product over time.

        SELECT p.Name AS Product, 
        inv.Shelf AS InventoryShelf,
        inv.ModifiedDate AS SnapshotDate
        FROM Production.Product p
        JOIN Production.ProductInventory inv
          ON p.ProductID = inv.ProductID;

-- Step 2) Filter the results using p.Name = 'Bearing Ball'
-- This step filters the previous result to focus on the "Bearing Ball" product.

        SELECT p.Name AS Product, 
        inv.Shelf AS InventoryShelf,
        inv.ModifiedDate AS SnapshotDate
        FROM Production.Product p
        JOIN Production.ProductInventory inv
          ON p.ProductID = inv.ProductID
        WHERE p.Name = 'Bearing Ball';


-- Question 2) What are the standard costs over time for our high-end road bike models?

-- Step 1) Join Product table (p) to the ProductCostHistory table (pch)
-- and return p.Name AS Product, pch.StartDate, and pch.StandardCost
-- This INNER JOIN connects product and cost history data to track standard costs over time for high-end road bike models.

        SELECT p.Name AS Product, 
        pch.StartDate, 
        pch.StandardCost
        FROM Production.Product p
        JOIN Production.ProductCostHistory AS pch
          ON p.ProductID = pch.ProductID;


-- Step 2) Filter p.Name using LIKE '%Road-%'
-- This step filters the previous result to focus on high-end road bike models.

        SELECT p.Name AS Product, 
        pch.StartDate, 
        pch.StandardCost
        FROM Production.Product p
        JOIN Production.ProductCostHistory AS pch
          ON p.ProductID = pch.ProductID 
        WHERE p.Name LIKE '%Road-%';


-- Step 3) Order the results by Cost Date
-- This step orders the previous result by cost date to show the cost history.

        SELECT p.Name AS Product,
        pch.StartDate,
        pch.StandardCost 
        FROM Production.Product p  
        JOIN Production.ProductCostHistory AS pch
          ON p.ProductID = pch.ProductID
        WHERE p.Name LIKE '%Road-%'
        ORDER BY pch.StartDate DESC;


/* Product Tables Exercises - LEFT JOIN  */

-- Question 1) What products do we currently not have any inventory quantity on hand for?

-- Step 1) Join the Product table (p) to the ProductInventory table (inv)
-- and return p.Name AS (Product)
-- This LEFT JOIN combines product and inventory data to identify products with no current inventory quantity on hand.

        SELECT p.Name AS Product, 
        inv.Quantity AS OnHandQty  
        FROM Production.Product p
        LEFT JOIN Production.ProductInventory inv
          ON p.ProductID = inv.ProductID;

-- Step 2) Check for Missing Snapshot by filtering out NULL on ProductID
-- This step identifies products with no inventory records by checking for NULL values in the ProductID column.

        SELECT p.Name AS Product   
        FROM Production.Product p
        LEFT JOIN Production.ProductInventory inv
          ON p.ProductID = inv.ProductID
        WHERE inv.ProductID IS NULL;

-- Step 3) Order Results
-- This step orders the previous result alphabetically to list products with no inventory.

        SELECT p.Name AS Product  
        FROM Production.Product p
        LEFT JOIN Production.ProductInventory inv
          ON p.ProductID = inv.ProductID
        WHERE inv.ProductID IS NULL
        ORDER BY p.Name DESC;


