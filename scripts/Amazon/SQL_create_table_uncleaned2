/*
==================================================================================
DDL Scripts: create table Amazon products sales data Uncleaned2

==================================================================================
Script purpose:
	This script creates table in amazon schema by dropping existing table if
	they already exist.
	Run this scripts to re-define DDL structure of uncleaned2 table
==================================================================================
*/


IF OBJECT_ID ('amazon.amazon_sales_data_uncleaned2', 'U') IS NOT NULL
DROP TABLE amazon.amazon_sales_data_uncleaned2;
CREATE TABLE amazon.amazon_sales_data_uncleaned2 (
	product_key INT,
	product_title NVARCHAR(MAX),
	product_rating FLOAT,
	total_reviews INT,
	purchased_last_month FLOAT,
	discounted_price FLOAT,
	original_price FLOAT,
	is_best_seller NVARCHAR(50),
	is_sponsored NVARCHAR(50),
	has_coupon NVARCHAR(50),
	buy_box_availability NVARCHAR(50),
	delivery_date DATE,
	sustainability_tags NVARCHAR(50),
	product_image_url NVARCHAR(100),
	product_page_url NVARCHAR(800),
	data_collected_at DATETIME,
	discount_percentage FLOAT);
