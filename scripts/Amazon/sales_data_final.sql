/*
========================================================================================
Amazon Sales Data Final Views

========================================================================================
Script Purpose:
	This script creates views for Amazon Sales Data which represents the final dimension
	and fact tables. Each columns in this table has been cleaned, transformed and
	business ready dataset.

========================================================================================*/


IF OBJECT_ID('amazon.amazon_sales_data_final', 'V') IS NOT NULL
DROP VIEW amazon.amazon_sales_data_final;
GO

CREATE VIEW amazon.amazon_sales_data_final AS
SELECT
	a.product_key,
	a.product_title,
	a.product_rating,
	a.total_reviews,
	a.purchased_last_month,
	a.discounted_price,
	a.original_price,
	a.is_best_seller,
	a.is_sponsored,
	a.has_coupon,
	a.buy_box_availability,
	a.delivery_date,
	a.sustainability_tags,
	a.product_image_url,
	a.product_page_url,
	a.data_collected_at,
	b.product_category,
	a.discount_percentage 
FROM amazon.amazon_sales_data_uncleaned2 AS a
LEFT JOIN amazon.amazon_sales_data_cleaned2 AS b
ON a.product_key=b.product_key
