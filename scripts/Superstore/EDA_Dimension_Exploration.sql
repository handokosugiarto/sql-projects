--- Exploratory Data Analysis Superstore Dataset Source : Kaggle.com
/*
=========================================================================================
Dimension Exploration
The purpose of this exploration is to have basic understanding about available dimensions
in the table in order to gain big picture about the table.
=========================================================================================*/


--- Explore category, sub_category and product_name to gain understanding about product information
SELECT DISTINCT Category, Sub_Category, Product_Name
FROM dbo.Superstore 
ORDER BY 1,2,3

--- Explore customer segmentation 
SELECT DISTINCT segment, customer_name
FROM dbo.Superstore
ORDER BY 1,2

--- Explore all countries available
SELECT DISTINCT Country
FROM dbo.Superstore

--- Explore all regions available
SELECT DISTINCT Region
FROM dbo.Superstore

--- Explore all cities available
SELECT DISTINCT City
FROM dbo.Superstore

--- Explore all states available
SELECT DISTINCT State
FROM dbo.Superstore
