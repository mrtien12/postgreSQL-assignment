SELECT CustomerFullName, CustomerKey, SalesAmount, OrderMonth, OrderYear
FROM (VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12)) month(m)
CROSS APPLY(
	select TOP 3 d.CustomerFullName, d.CustomerKey, sum(f.SalesAmount) as SalesAmount, 
		year(f.OrderDate) as OrderYear , month(f.orderDate) as OrderMonth from DimCustomer as d 
	inner join FactInternetSales f on f.CustomerKey = d.CustomerKey
	WHERE month(f.orderDate) = m
	group by d.CustomerKey, d.CustomerFullName, year(f.OrderDate), month(f.orderDate)
	order by OrderMonth,  SalesAmount desc 
) as t order by OrderMonth
---------------------------
SELECT  YEAR(OrderDate) AS OrderYear,
        MONTH(OrderDate) AS OrderMonth,
        SUM(SalesAmount) AS InternetSalesAmount,
        LAG(SUM(SalesAmount), 12)   OVER(ORDER BY YEAR(OrderDate), MONTH(OrderDate)) AS InternetMonthAmount_LastYear,
        (SUM(SalesAmount) -  LAG(SUM(SalesAmount), 12)   OVER(ORDER BY YEAR(OrderDate), MONTH(OrderDate)))
            /  LAG(SUM(SalesAmount), 12)   OVER(ORDER BY YEAR(OrderDate), MONTH(OrderDate)) * 100 AS PercentSalesGrowth
FROM [AdventureWorksDW2019].[dbo].[FactInternetSales]
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY YEAR(OrderDate), MONTH(OrderDate)
------------------------------

DECLARE @TODAY DATE = '2015-01-01';
WITH 
cte_rfm AS (
	SELECT	FIS.CustomerKey, 
			CONCAT_WS(' ', DC.FirstName, DC.MiddleName, DC.LastName) AS CustomerName,
			DATEDIFF(MONTH, MIN(CONVERT(CHAR(10), FIS.OrderDate, 120)), @TODAY) AS MonthsFrom1stPurchase,
			MAX(FIS.OrderDate) AS RecentOrder,
			COUNT(DISTINCT(FIS.SalesOrderNumber)) 
				/CAST(DATEDIFF(YEAR, MIN(CONVERT(CHAR(10), FIS.OrderDate, 120)), @TODAY) AS FLOAT) AS NoPurchasePerYear,
			CAST(SUM(FIS.SalesAmount)
				/DATEDIFF(YEAR, MIN(CONVERT(CHAR(10), FIS.OrderDate, 120)), @TODAY) AS FLOAT) AS AmountPerYear,
			SUM(FIS.SalesAmount) - SUM(FIS.TotalProductCost) AS TotalProfit
	FROM [AdventureWorksDW2019].[dbo].[FactInternetSales] AS FIS
	LEFT JOIN [AdventureWorksDW2019].[dbo].[DimCustomer] AS DC
	ON FIS.CustomerKey = DC.CustomerKey
	GROUP BY CONCAT_WS(' ', DC.FirstName, DC.MiddleName, DC.LastName), FIS.CustomerKey
), 

cte_percentrank AS (
	SELECT	*, 
			PERCENT_RANK() OVER (ORDER BY AmountPerYear DESC) AS AmountPerYear_rank,
			PERCENT_RANK() OVER (ORDER BY TotalProfit DESC) AS TotalProfit_rank
	FROM cte_rfm
), 
cte_segment AS (
	SELECT	CustomerKey, 
			CASE WHEN YEAR(RecentOrder) = (YEAR(@TODAY)-1) THEN 1 ELSE 0 END AS TopActive,
			CASE WHEN AmountPerYear_rank BETWEEN 0 AND 0.2 THEN 2 ELSE 0 END AS TopAmountPerYear,
			CASE WHEN TotalProfit_rank BETWEEN 0 AND 0.2 THEN 2 ELSE 0 END AS TopTotalProfit,
			CASE WHEN NoPurchasePerYear > 1 THEN 1 ELSE 0 END AS TopNoPurchasePerYear
	FROM cte_percentrank
),
cte_score AS (
	SELECT	CustomerKey, 
			Score,
			Customer_Segment
	FROM cte_segment
	UNPIVOT (
		Score FOR Customer_Segment IN(TopActive, TopAmountPerYear, TopTotalProfit, TopNoPurchasePerYear)
	) AS u
), 
cte_finalscore AS (
	SELECT	CustomerKey,
			SUM(Score) AS TotalScore
	FROM cte_score
	GROUP BY CustomerKey
),

cte_finalsegment AS (
	SELECT	CustomerKey, 
			CASE 
			WHEN TotalScore >= 5 THEN 'Diamond'
			WHEN TotalScore = 4 THEN 'Gold'
			WHEN TotalScore = 3 THEN 'Silver'
			WHEN TotalScore < 3 THEN 'Normal'
			END AS Customer_Segment
	FROM cte_finalscore
)
SELECT	rfm.CustomerKey,
		rfm.CustomerName,
		rfm.MonthsFrom1stPurchase,
		rfm.NoPurchasePerYear,
		rfm.AmountPerYear,
		rfm.TotalProfit,
		fs.Customer_Segment
FROM cte_rfm AS rfm
LEFT JOIN cte_finalsegment fs
ON rfm.CustomerKey = fs.CustomerKey
