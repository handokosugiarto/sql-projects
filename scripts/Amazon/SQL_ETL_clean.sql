/* 
===============================================================================================
Stored Procedure: Load sales data cleaned2 (sales data cleaned --> sales data cleaned2)
===============================================================================================
Script Purpose:
	
	This stored procedure performs ETL (Extract, Transform, Load) process to provide cleaned and 
	transformed dataset.
    
	Action performed:
		- Truncate amazon table to avoid any duplicate records
		- Inserts transformed and cleaned data to amazon_sales_data_cleaned2
		- Used import file to import CSV files to Amazon tables.

Source: 
	CSV files on Github repositories SQL-projects/Dataset/amazon folder under the name 
	amazon_products_sales_data_cleaned (original Source: Kaggle.com).

Usage Example:
	EXEC amazon.load_data_cleaned2

===============================================================================================
*/

CREATE OR ALTER PROCEDURE amazon.load_data_cleaned2 AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		PRINT '==================================================================';
		PRINT ' Loading Amazon Sales Data cleaned2';
		PRINT '==================================================================';


		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: amazon.amazon_sales_data_cleaned2';

		TRUNCATE TABLE amazon.amazon_sales_data_cleaned2;
		PRINT '>>inserting Data Into: amazon.amazon_sales_data_cleaned2';
		
--- Creating CTE to create queries readable. 		
		WITH sales_data_clean2 AS(
--- Queries for standardizing the product title and removing all unnecessary characters.		
		SELECT 
			TRIM(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(
			REPLACE(product_title,'(',''),')',''),'4pcs','4 pcs'),'â€“',''),'4pc','4 pcs'),'â€‹',''),
			'acer', 'Acer'),'adidas','Adidas'),'[',''),']',''),'Ryzen','Ryzen'),'Ryzenâ„¢','Ryzen'),'Radeonâ„¢','Radeon'),
			'27â€', '27"'),'27 Inch', '27"'),'3 Feet', '3ft'), 'amiibo', 'Amiibo'),'â€‘',' '),'â€¢',''), 'Â°', ''),
			'â€',''),'Â',''),'â„¢',''),'BAOFENG', 'Baofeng'), 'BATTRY', 'Battery'),'be quiet!', 'Be quiet!'),
			'fx', 'FX'), 'Inc.', ''),'CISCO', 'Cisco'),'Asrock', 'ASRock'),'beyerdynamic','Beyerdynamic'),'Cherry','CHERRY'),'Dell','DELL'),
			'Gigabyte','GIGABYTE'),'GODOX','Godox'),'Neewer','NEEWER'),'Netgear', 'NETGEAR'),'Nvidia', 'NVIDIA'),'Yamaha','YAMAHA')
			, 'Zebra', 'ZEBRA'),'?',''))AS product_title,
			product_rating,
			total_reviews,
			purchased_last_month,
			discounted_price,
			original_price,	
			is_best_seller,
			is_sponsored,
			has_coupon,
			buy_box_availability,
			delivery_date,
			sustainability_tags,
			product_image_url, 
			product_page_url,
			data_collected_at,
			product_category,
			discount_percentage	
			FROM amazon.amazon_products_sales_data_cleaned)

		INSERT INTO amazon.amazon_sales_data_cleaned2
		SELECT 
			ROW_NUMBER() OVER(ORDER BY product_title) AS product_key,
			product_title,
			product_rating,
			total_reviews,
			purchased_last_month,
			discounted_price,
			original_price,	
			is_best_seller,
			is_sponsored,
			has_coupon,
			buy_box_availability,
			delivery_date,
			sustainability_tags,
			product_image_url, 
			product_page_url,
			data_collected_at,
			product_category,
			discount_percentage
		FROM sales_data_clean2

		END TRY
		BEGIN CATCH
			PRINT '===================================================';
			PRINT 'ERROR  OCCURED  DURING  LOADING  BRONZE  LAYER';
			PRINT 'Error Message' + ERROR_MESSAGE();
			PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
			PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
			PRINT '===================================================';
		END CATCH

		END
