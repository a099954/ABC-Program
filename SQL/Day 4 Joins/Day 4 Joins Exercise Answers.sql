/* Connections */

-- Connect to the AdventureWorks2012 database
USE AdventureWorks2012;





/* Product Tables Exercises - INNER JOIN  */


-- Question 1) What are the inventory shelf locations for the "Bearing Ball" product over time?

-- Step 1) Join Product table (p) to the ProductInventory table (inv)
-- and return p.Name AS Product, inv.Shelf AS InventoryShelf, and inv.ModifiedDate AS SnapshotDate

        SELECT p.Name AS Product, 
        inv.Shelf AS InventoryShelf,
        inv.ModifiedDate AS SnapshotDate
        FROM Production.Product p
        JOIN Production.ProductInventory inv
          ON p.ProductID = inv.ProductID;

-- Step 2) Filter the results using p.Name = 'Bearing Ball'

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

        SELECT p.Name AS Product, 
        pch.StartDate, 
        pch.StandardCost
        FROM Production.Product p
        JOIN Production.ProductCostHistory AS pch
          ON p.ProductID = pch.ProductID;


-- Step 2) Filter p.Name using LIKE '%Road-%'

        SELECT p.Name AS Product, 
        pch.StartDate, 
        pch.StandardCost
        FROM Production.Product p
        JOIN Production.ProductCostHistory AS pch
          ON p.ProductID = pch.ProductID 
        WHERE p.Name LIKE '%Road-%';


--Step 3) Order the results by Cost Date

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

        SELECT p.Name AS Product, 
        inv.Quantity AS OnHandQty  
        FROM Production.Product p
        LEFT JOIN Production.ProductInventory inv
          ON p.ProductID = inv.ProductID;

-- Step 2) check for Missing Snapshot by filtering out NULL on ProductID

        SELECT p.Name AS Product   
        FROM Production.Product p
        LEFT JOIN Production.ProductInventory inv
          ON p.ProductID = inv.ProductID
        WHERE inv.ProductID IS NULL;

-- Step 3) Order Results

        SELECT p.Name AS Product  
        FROM Production.Product p
        LEFT JOIN Production.ProductInventory inv
          ON p.ProductID = inv.ProductID
        WHERE inv.ProductID IS NULL
        ORDER BY p.Name DESC;



/* Product Tables Exercises - Aggregate INNER JOINS  */

-- Question 1) What products have we stocked the highest inventory quantity for over time?

-- Step 1) Join the Product table (p) to the ProductInventory table (inv)
-- and return the p.Name AS (Product) and inv.LocationID AS InventoryLocationID

        SELECT p.Name AS Product, 
        inv.LocationID AS InventoryLocationID
        FROM Production.Product p   
        INNER JOIN Production.ProductInventory inv
          ON p.ProductID = inv.ProductID;

-- Step 2) Add an Aggregate by taking the SUM of inv.Quantity
-- and group by p.Name

        SELECT p.Name AS Product,
        SUM(inv.Quantity) AS TotalQuantity  
        FROM Production.Product p
        INNER JOIN Production.ProductInventory inv
          ON p.ProductID = inv.ProductID
        GROUP BY p.Name;

-- Step 3) Order the results by TotalQuantity 

    SELECT p.Name AS Product,
    SUM(inv.Quantity) AS TotalQuantity
    FROM Production.Product p
    INNER JOIN Production.ProductInventory inv
      ON p.ProductID = inv.ProductID 
    GROUP BY p.Name
    ORDER BY TotalQuantity DESC;

