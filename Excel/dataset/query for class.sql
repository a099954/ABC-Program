SELECT top 10000
  p.EnglishProductName, 
  p.Color, 
  p.Size,
  p.Weight,
  p.StandardCost,
  p.ListPrice,
  cat.EnglishProductCategoryName, 
  scat.EnglishProductSubcategoryName, 
  c.FirstName,
  c.LastName,
  c.YearlyIncome,
  c.TotalChildren, 
  c.EnglishEducation,
  c.EnglishOccupation, 
  c.HouseOwnerFlag,
  c.NumberCarsOwned,
  f.OrderDateKey, 
  f.SalesAmount,
  f.DiscountAmount,  
  d.City, 
  d.StateProvinceName,
  d.EnglishCountryRegionName, 
  g.SalesTerritoryKey, 
  g.SalesTerritoryRegion
FROM
  dimProduct p  
INNER JOIN factInternetSales f ON f.ProductKey = p.ProductKey  
INNER JOIN dimCustomer c ON c.CustomerKey = f.CustomerKey
INNER JOIN dimGeography d ON d.GeographyKey = c.GeographyKey
INNER JOIN dimSalesTerritory g ON g.SalesTerritoryKey = f.SalesTerritoryKey
INNER JOIN dimProductSubcategory scat ON scat.ProductSubcategoryKey = p.ProductSubcategoryKey
INNER JOIN dimProductCategory cat ON cat.ProductCategoryKey = scat.ProductCategoryKey
ORDER BY 
  f.OrderDateKey DESC  