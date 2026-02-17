--- Exploratory Data Analysis Superstore Dataset Source : Kaggle.com
/*======================================================================================
Measures Exploration
The purpose of this exploration is find out the key metrics of the business. 
========================================================================================*/
SELECT 
--- Find total Sales and round to 2 decimal	
	ROUND(SUM(sales),2) AS total_sales
	
--- Find total quantity	
	SUM(quantity) AS total_quantity,
	
--- Find average selling price and round to 2 decimal	
	ROUND(SUM(sales)/(sum(quantity)*(1- AVG(Discount))),2) AS average_price,
	
--- Find average discount and round to 2 decimal	
	ROUND(AVG(discount),2) AS average_discount,
	
---	Find total profits and round to 2 decimal number.
	ROUND(SUM(profit),2) AS total_profits,

--- Find total number of unique orders 	
	COUNT(DISTINCT Order_ID) AS total_orders,
	
--- Find total number of unique products	
	COUNT(DISTINCT Product_ID) AS total_products,

--- Find total number of unique customers
	COUNT(DISTINCT Customer_ID) AS total_customers
FROM dbo.Superstore

-- Generate a report that shows all key metrics of the business

SELECT 'Total Sales' AS measure_name, ROUND(SUM(sales),2) AS measure_value
FROM dbo.superstore
UNION ALL
SELECT 'Total Quantity' AS measure_name, SUM(quantity) AS measure_value
FROM dbo.superstore
UNION ALL
SELECT 'Average Price' AS measure_name, ROUND(SUM(sales)/(sum(quantity)*(1- AVG(Discount))),2) AS measure_value
FROM dbo.superstore
UNION ALL
SELECT 'Average Discount' AS measure_name, ROUND(AVG(discount),2)  AS measure_value
FROM dbo.superstore
UNION ALL
SELECT 'Total Profits' AS measure_name, ROUND(SUM(profit),2) AS measure_value
FROM dbo.superstore
UNION ALL
SELECT 'Total Orders' AS measure_name, COUNT(DISTINCT Order_ID) AS measure_value
FROM dbo.superstore
UNION ALL
SELECT 'Total Products' AS measure_name, COUNT(DISTINCT Product_ID) AS measure_value
FROM dbo.superstore
UNION ALL
SELECT 'Total Customers' AS measure_name, COUNT(DISTINCT Customer_ID) AS measure_value
FROM dbo.superstore
