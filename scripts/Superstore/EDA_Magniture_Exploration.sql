--- Exploratory Data Analysis Superstore Dataset Source : Kaggle.com
/*======================================================================================
Magnitude Exploration
The purpose of this exploration is to help us understand the importance of different 
categories and other dimension.
========================================================================================*/


--- Total Sales, Quantity, Average Selling Price, Avg Discount,avg cost and Total Profits by Segment
SELECT
	segment,
	total_sales,
	total_profits,
	average_price,
	total_sales-total_profits AS cost,
	ROUND(AVG(total_sales-total_profits) OVER(),2) AS average_cost,
	average_discount
FROM(
SELECT 
	Segment,
	ROUND(SUM(sales),2) AS total_sales,
	SUM(Quantity) AS total_quantity,
	ROUND(SUM(sales)/(sum(quantity)*(1- AVG(Discount))),2) AS average_price,
	ROUND(AVG(discount),2) AS average_discount,
	ROUND(SUM(profit),2) AS total_profits
	
FROM dbo.Superstore 
GROUP BY Segment) AS a

ORDER BY total_sales DESC

--- Total Sales, Quantity, Average Selling Price, Avg Discount, Avg cost and Total Profits by Category

SELECT
	category,
	total_sales,
	total_profits,
	average_price,
	total_sales-total_profits AS cost,
	ROUND(AVG(total_sales-total_profits) OVER(),2) AS average_cost,
	average_discount
FROM(
SELECT 
	Category,
	ROUND(SUM(sales),2) AS total_sales,
	SUM(Quantity) AS total_quantity,
	ROUND(SUM(sales)/(sum(quantity)*(1- AVG(Discount))),2) AS average_price,
	ROUND(AVG(discount),2) AS average_discount,
	ROUND(SUM(profit),2) AS total_profits
	
FROM dbo.Superstore 
GROUP BY Category) AS a

ORDER BY total_sales DESC

--- Total Sales, Quantity, Average Selling Price, Avg Discount, Avg cost and Total Profits by SubCategory
SELECT
	sub_category,
	total_sales,
	total_profits,
	average_price,
	total_sales-total_profits AS cost,
	ROUND(AVG(total_sales-total_profits) OVER(),2) AS average_cost,
	average_discount
FROM(
SELECT 
	Sub_Category,
	ROUND(SUM(sales),2) AS total_sales,
	SUM(Quantity) AS total_quantity,
	ROUND(SUM(sales)/(sum(quantity)*(1- AVG(Discount))),2) AS average_price,
	ROUND(AVG(discount),2) AS average_discount,
	ROUND(SUM(profit),2) AS total_profits
	
FROM dbo.Superstore 
GROUP BY Sub_Category) AS a

ORDER BY total_sales DESC

--- Total Sales, Quantity, Average Selling Price, Avg Discount, and Total Profits by Region
SELECT 
	Region,
	ROUND(SUM(sales),2) AS total_sales,
	SUM(Quantity) AS total_quantity,
	ROUND(SUM(sales)/(sum(quantity)*(1- AVG(Discount))),2) AS average_price,
	ROUND(AVG(discount),2) AS average_discount,
	ROUND(SUM(profit),2) AS total_profits
FROM dbo.Superstore
GROUP BY Region
ORDER BY total_sales DESC

--- Total Revenue,Profits, and Orders by each customer

SELECT 
	customer_name,
	ROUND(SUM(sales),2) AS total_sales,
	ROUND(SUM(profit),2) AS total_profit,
	COUNT(DISTINCT order_id) AS total_order
FROM dbo.Superstore
GROUP BY Customer_Name
ORDER BY total_sales DESC
