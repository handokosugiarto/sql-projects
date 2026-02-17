/* 
===============================================================================================
Stored Procedure: Load sales data uncleaned2 (sales data uncleaned --> sales data uncleaned2)
===============================================================================================
Script Purpose:
	
	This stored procedure performs ETL (Extract, Transform, Load) process to provide cleaned and 
	transformed dataset.
    
	Action performed:
		- Truncate amazon table to avoid any duplicate records
		- Inserts transformed and cleaned data to amazon_sales_data_uncleaned2.
        - Used import file to import CSV files to Amazon tables

Source: 
	CSV files on Github repositories SQL-projects/Dataset/amazon folder under the name 
	amazon_products_sales_data_uncleaned (original Source: Kaggle.com).

Usage Example:
	EXEC amazon.load_data_uncleaned2

===============================================================================================
*/
	.

CREATE OR ALTER PROCEDURE amazon.load_data_uncleaned2 AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		PRINT '==================================================================';
		PRINT ' Loading Amazon Sales Data Uncleaned2';
		PRINT '==================================================================';


		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: amazon.amazon_sales_data_uncleaned2';
		TRUNCATE TABLE amazon.amazon_sales_data_uncleaned2;
		PRINT '>>inserting Data Into: amazon.amazon_sales_data_uncleaned2';

		--- Creating CTE to create queries readable. 
		WITH sales_data_clean AS (

		SELECT
		--- Queries for standardizing the product title and removing all unnecessary character.
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
			REPLACE(title,'(',''),')',''),'4pcs','4 pcs'),'â€“',''),'4pc','4 pcs'),'â€‹',''),
			'acer', 'Acer'),'adidas','Adidas'),'[',''),']',''),'Ryzen','Ryzen'),'Ryzenâ„¢','Ryzen'),'Radeonâ„¢','Radeon'),
			'27â€', '27"'),'27 Inch', '27"'),'3 Feet', '3ft'), 'amiibo', 'Amiibo'),'â€‘',' '),'â€¢',''), 'Â°', ''),
			'â€',''),'Â',''),'â„¢',''),'BAOFENG', 'Baofeng'), 'BATTRY', 'Battery'),'be quiet!', 'Be quiet!'),
			'fx', 'FX'), 'Inc.', ''),'CISCO', 'Cisco'),'Asrock', 'ASRock'),'beyerdynamic','Beyerdynamic'),'Cherry','CHERRY'),'Dell','DELL'),
			'Gigabyte','GIGABYTE'),'GODOX','Godox'),'Neewer','NEEWER'),'Netgear', 'NETGEAR'),'Nvidia', 'NVIDIA'),'Yamaha','YAMAHA')
			, 'Zebra', 'ZEBRA'))AS product_title,

		--- Queries for extracting the number of rating (measurement)from characters,replacing null value to 0 and converting NVARCHAR to FLOAT datatype.
			CAST(COALESCE(LEFT(rating,3),'0') AS FLOAT) AS product_rating,

		--- Queries for removing unnecessary characters, replacing null to 0 value, and converting NVARCHAR to INT datatype.
			CAST(COALESCE(REPLACE (number_of_reviews,',',''),'0') AS INT) AS total_reviews,

		--- Queries for extracting numbers of measurement from characters, replacing unnecessary characters, converting null to 0, 
		--- and convert datatype NVARCHAR to FLOAT.  
			TRY_CAST(COALESCE(REPLACE(REPLACE(REPLACE(SUBSTRING (bought_in_last_month,1,
			CHARINDEX ('+',bought_in_last_month,1)),'+',''),'K','000'),',',''),'0') AS FLOAT) AS purchased_last_month,

		--- Queries for removing unnecessary characters, converting null to 0 and NVARCHAR to FLOAT datatype. 
			CAST(COALESCE(REPLACE(current_discounted_price,',',''),'0') AS FLOAT) AS discounted_price,

		--- Queries for replacing unnecessary characters by using conditional expression to determine any measurements and 
		--- converting to FLOAT from NVARCHAR datatype.
			CAST(CASE WHEN REPLACE(REPLACE(SUBSTRING(price_on_variant, 21, LEN(price_on_variant)),'$',''),',','') LIKE '%[0-9]%' AND 
						  REPLACE(REPLACE(SUBSTRING(price_on_variant, 21, LEN(price_on_variant)),'$',''),',','') NOT LIKE '%[A-Za-z]%'
						  THEN REPLACE(REPLACE(SUBSTRING(price_on_variant, 21, LEN(price_on_variant)),'$',''),',','')
						  ELSE '0' END AS FLOAT) AS price_variant,

		--- Queries for removing all string characters and converting to measurement and FLOAT datatype.
			CAST(REPLACE(REPLACE(REPLACE(listed_price,'$',''),',',''),'No Discount','0') AS FLOAT) AS original_price,

			is_best_seller,

			is_sponsored,

			is_couponed AS has_coupon,

		--- Query for converting null to n/a (not applicable) 
			ISNULL(buy_box_availability,'n/a') AS buy_box_availability,

		--- Queries for extracting unnecessary characters and converting from empty column to null.
			NULLIF(
			SUBSTRING(
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
			SUBSTRING(delivery_details, PATINDEX('%[A-Z][a-z][a-z]%', delivery_details),LEN(delivery_details)),'Delivery',''),
			'FREE',''),'Or fastest',''),'Mon,',''),'Tue,',''),'Wed,',''),'Thu,',''),'Fri,',''),'Sat,',''),'Sun,',''),
			'Ships to Pakistan',''),'Tomorrow',''),',',''),'',' '),' ',''),'8AM - 8PM','')),1,6),'')
				AS delivery_date,
	
		--- Queries for converting null to n/a
			COALESCE(sustainability_badges,'n/a') AS sustainability_tags,

		--- Queries for converting null to n/a
			COALESCE(image_url,'n/a') AS product_image_url,

		--- Queries for converting null to n/a
			COALESCE(product_url,'n/a') AS product_page_url,

		--- Queries for converting null to n/a	
			FORMAT(CAST (collected_at AS DATETIME),'M/d/yyyy hh:mm:ss tt') AS data_collected_at

		FROM amazon.amazon_products_sales_data_uncleaned)

		--- Insert clean dataset to new table
		INSERT INTO amazon.amazon_sales_data_uncleaned2 (
			product_key,
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
			discount_percentage )


		SELECT 
		--- Query for creating surrogate key to provide unique id for each product	
			ROW_NUMBER() OVER(ORDER BY a.product_title) AS product_key,
			a.product_title,
			a.product_rating,
			a.total_reviews,
			a.purchased_last_month,
	
		--- Conditional expression queries to determine a column's value based from another column. 
			CASE WHEN a.discounted_price = 0 AND a.price_variant >0 THEN a.price_variant 
			 WHEN a.price_variant=0 AND a.discounted_price=0 THEN  a.original_price
			ELSE a.discounted_price END AS discounted_price,

		--- Conditional expression queries to determine a column's value based from another column.
			CASE WHEN a.original_price = 0 THEN (CASE WHEN a.discounted_price = 0 AND a.price_variant >0 THEN a.price_variant 
			 WHEN a.price_variant=0 AND a.discounted_price=0 THEN  a.original_price
			ELSE a.discounted_price END)
			ELSE a.original_price END AS original_price,	
			a.is_best_seller,
			a.is_sponsored,
			a.has_coupon,
			a.buy_box_availability,
	
		--- Queries for combining year measurement from other column to create date and converting to date from NVARCHAR and
		--- conditional expression to seperate between null and not null.
			CASE WHEN delivery_date IS NOT NULL 	
			THEN FORMAT(TRY_CAST(CONCAT(delivery_date,' ',YEAR(data_collected_at)) AS DATE),'M/d/yyyy')
			ELSE delivery_date
			END AS delivery_date,
			a.sustainability_tags,
			a.product_image_url, 
			a.product_page_url,
			a.data_collected_at,

		--- Queries for calculating discount % as new column in the table.
			ROUND(COALESCE((1-(NULLIF((CASE WHEN a.discounted_price = 0 AND a.price_variant >0 THEN a.price_variant 
			WHEN a.price_variant=0 AND a.discounted_price=0 THEN  a.original_price
			ELSE a.discounted_price END),0)/NULLIF(CASE WHEN a.original_price = 0 THEN (CASE WHEN a.discounted_price = 0 AND a.price_variant >0 THEN a.price_variant 
			WHEN a.price_variant=0 AND a.discounted_price=0 THEN  a.original_price
			ELSE a.discounted_price END)
			ELSE a.original_price END,0)))*100,'0'),2) AS discount_percentage

			FROM sales_data_clean AS a;
	
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
		END
