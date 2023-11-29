USE [AdventureWorks2019]
GO

drop view if exists Production.vCategoryTransactions2014
GO

/****** Object:  View [Production].[vProductModelInstructions]    Script Date: 1/17/2022 1:44:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [Production].[vCategoryTransactions2014] 
AS 
SELECT *
	FROM ( 
	select P.ProductID, PC.Name as Category, Format(TransactionDate,'MMM') as TransactionMonth
  from production.TransactionHistory TH
  join Production.Product p
    on P.ProductID = TH.ProductID
  join Production.ProductSubcategory PS
    on P.ProductSubcategoryID = PS.ProductSubcategoryID
  join Production.ProductCategory PC
    on PC.ProductCategoryID = PS.ProductCategoryID
	where year(transactionDate) = 2014
   and month(transactionDate) < 7
 
	) AS ST
PIVOT ( Count(ST.ProductID) FOR ST.Category IN (Accessories, Bikes, Clothing, Components) ) AS PivotTable;
GO



