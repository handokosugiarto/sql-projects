--- Exploratory Data Analysis Superstore Dataset Source : Kaggle.com
/*======================================================================================
Date Exploration
The purpose of this exploration is to have basic understanding about the scope of data 
and the timespan.
========================================================================================*/

--- Find first order, last order, and order range in year.  
SELECT 
	MIN(order_date) AS first_order,
	MAX(order_date) AS last_order,
	DATEDIFF(year, MIN(order_date), MAX(order_date)) AS order_range_year
FROM dbo.Superstore

--- Find lead time 
SELECT 
	order_date,
	ship_date,
	DATEDIFF(day, order_date, Ship_Date) AS lead_time
FROM dbo.Superstore
