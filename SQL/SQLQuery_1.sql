-- Cleansed DIM_Date Table --
SELECT 
  [DateKey], 
  [FullDateAlternateKey] AS Date, 
  [EnglishDayNameOfWeek] AS Day, 
  [EnglishMonthName] AS Month, 
  Left([EnglishMonthName], 3) AS MonthShort,  
  [MonthNumberOfYear] AS MonthNo, 
  [CalendarQuarter] AS Quarter, 
  [CalendarYear] AS Year 
FROM 
 [AdventureWorksDW2019].[dbo].[DimDate]
WHERE 
  CalendarYear > 2010 AND CalendarYear < 2014;

-- Cleansed DIM_Customers Table --
SELECT * from [dbo].[DimCustomer]
--lay CustomerKey, FirstName + LastName = FullName, Gender, DateFirstPurchase
SELECT c.CustomerKey as CustomerKey,
c.FirstName + c.Lastname as [Full name],
case c.Gender WHEN 'M' then 'Male' WHEN 'F' THEN 'Feamle' end as Gender,
c.DateFirstPurchase as [Date FirstPurchase],
c.BirthDate,
--join voi bang Geopraphy de lay them thong tin ve thanh pho khach hang 
g.city as [Customer City]
FROM
dbo.DimCustomer as c LEFT JOIN dbo.DimGeography as g on c.geographykey = g.geographykey
ORDER BY
CustomerKey ASC

-- Cleansed DIM_Products Table --
SELECT 
  p.[ProductKey], 
  p.[ProductAlternateKey] AS ProductItemCode, 
  p.[EnglishProductName] AS [Product Name], 
  ps.[EnglishProductSubcategoryName] AS [Sub Category], -- Joined in from Sub Category Table
  pc.[EnglishProductCategoryName] AS [Product Category], -- Joined in from Category Table 
  p.[Color] AS [Product Color], 
  p.[Size] AS [Product Size], 
  p.[ProductLine] AS [Product Line], 
  p.[ModelName] AS [Product Model Name], 
  p.[EnglishDescription] AS [Product Description], 
  ISNULL (p.Status, 'Outdated') AS [Product Status] 
FROM 
  [AdventureWorksDW2019].[dbo].[DimProduct] as p
  LEFT JOIN [AdventureWorksDW2019].[dbo].[DimProductSubcategory] AS ps ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey 
  LEFT JOIN [AdventureWorksDW2019].[dbo].[DimProductCategory] AS pc ON ps.ProductCategoryKey = pc.ProductCategoryKey 
order by 
  p.ProductKey asc


-- Cleansed FACT_InternetSales Table --
SELECT 
  [ProductKey], 
  [OrderDateKey], 
  [DueDateKey], 
  [ShipDateKey], 
  [CustomerKey], 
  [TotalProductCost],
  [SalesOrderNumber], 
  [SalesAmount]
FROM 
  [AdventureWorksDW2019].[dbo].[FactInternetSales]
WHERE 
  LEFT (OrderDateKey, 4) BETWEEN '2010' AND '2014'
ORDER BY
  OrderDateKey ASC


