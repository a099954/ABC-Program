# Exercise: Aggregates - INSTRUCTOR KEY

## Introduction

In the Aggregates SQL lesson, we introduced aggregates to better understand our data for descriptive analysis. For this exercise:

1. Create a new SQL file.
2. Set the connection in SQL Server Management Studio (SSMS) to look at Wide World Importers.
3. Write these `SELECT` queries.

## Exercise

1. What is the average typical weight per unit for warehouse stock items?

    ```sql
    SELECT AVG(TypicalWeightPerUnit)
    FROM Warehouse.StockItems
    ```

2. What are the heaviest and lightest stock items - based on typical weight per unit?

    ```sql
    DECLARE @HeaviestWeight decimal(18,3)
    DECLARE @LightestWeight decimal(18,3)

    SELECT @HeaviestWeight = MAX(TypicalWeightPerUnit), @LightestWeight = MIN(TypicalWeightPerUnit)
    FROM Warehouse.StockItems

    SELECT StockItemName, TypicalWeightPerUnit
    FROM Warehouse.StockItems
    WHERE TypicalWeightPerUnit = @HeaviestWeight
        OR TypicalWeightPerUnit = @LightestWeight
    ```

3. Create a list of brands and their total stock items in the warehouse. Sort it by the most to least items, then alphabetically by brand.

    ```sql
    SELECT Brand, COUNT(StockItemID)
    FROM Warehouse.StockItems
    GROUP BY Brand
    ORDER BY COUNT(StockItemID) DESC, Brand
    ```

4. How many temperature sensor recordings are there for the vehicle temperatures? What are their recordings? Include:
   * Count of temperature readings
   * Earliest date of recording
   * Latest date of recording

    ```sql
    SELECT COUNT(VehicleTemperatureID), MIN(RecordedWhen), MAX(RecordedWhen)
    FROM Warehouse.VehicleTemperatures
    ```

5. Get the VehicleRegistration, ChillerSensorNumber, Min temperature, Max temperature, Average temperature, number of readings, and number of unique vehicle registrations for March 2016. Order by vehicle registration and chiller sensor number.

    ```sql
    SELECT VehicleRegistration, ChillerSensorNumber, MIN(Temperature),
        MAX(Temperature), AVG(Temperature), COUNT(VehicleTemperatureID),
        COUNT(DISTINCT VehicleRegistration)
    FROM Warehouse.VehicleTemperatures
    WHERE YEAR(RecordedWhen) = 2016 AND MONTH(RecordedWhen) = 3
    GROUP BY VehicleRegistration, ChillerSensorNumber
    ORDER BY VehicleRegistration, ChillerSensorNumber

    SELECT VehicleRegistration, ChillerSensorNumber, MIN(Temperature),
        MAX(Temperature), AVG(Temperature), COUNT(VehicleTemperatureID),
        COUNT(DISTINCT VehicleRegistration)
    FROM Warehouse.VehicleTemperatures
    WHERE RecordedWhen BETWEEN '2016-03-01 00:00:00.0000000' AND '2016-03-31 23:59:59.9999999'
    GROUP BY VehicleRegistration, ChillerSensorNumber
    ORDER BY VehicleRegistration, ChillerSensorNumber

    SELECT VehicleRegistration, ChillerSensorNumber, MIN(Temperature),
        MAX(Temperature), AVG(Temperature), COUNT(VehicleTemperatureID),
        COUNT(DISTINCT VehicleRegistration)
    FROM Warehouse.VehicleTemperatures
    WHERE RecordedWhen >= '2016-03-01 00:00:00.0000000'
        AND RecordedWhen <= '2016-03-31 23:59:59.9999999'
    GROUP BY VehicleRegistration, ChillerSensorNumber
    ORDER BY VehicleRegistration, ChillerSensorNumber
    ```

6. Let's start by looking at the order lines for Order 1163.

    ```sql
    SELECT *
    FROM Sales.OrderLines
    WHERE OrderID = 1163
    ```

7. Now, let's get the total for these order lines for Order 1163.

    ```sql
    SELECT OrderID, SUM((Quantity * UnitPrice) + (Quantity * UnitPrice * TaxRate/100))
    FROM Sales.OrderLines
    WHERE OrderID = 1163
    GROUP BY OrderID
    ```

8. Are there any orders where Quantity and PickedQuantity don't match? Let's count the order lines.

    ```sql
    SELECT COUNT(OrderLineID)
    FROM Sales.OrderLines
    WHERE Quantity != PickedQuantity
    ```

9. Let's see what orders have outstanding quantities and how many are still outstanding for each order.

    ```sql
    SELECT OrderID, SUM(Quantity-PickedQuantity)
    FROM Sales.OrderLines
    WHERE Quantity <> PickedQuantity
    GROUP BY OrderID
    ```

10. What is the query for getting individual orders' totals?

    ```sql
    SELECT OrderID, SUM((Quantity * UnitPrice) + (Quantity * UnitPrice * TaxRate/100))
    FROM Sales.OrderLines
    GROUP BY OrderID
    ```

11. Suppose we want orders less than $1000. What is the query for orders less than $1000?

    ```sql
    SELECT OrderID, SUM((Quantity * UnitPrice) + (Quantity * UnitPrice * TaxRate/100))
    FROM Sales.OrderLines
    GROUP BY OrderID
    HAVING SUM((Quantity * UnitPrice) + (Quantity * UnitPrice * TaxRate/100)) < 1000.00
    ```
