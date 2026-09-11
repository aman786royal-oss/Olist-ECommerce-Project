-- for data cleaning sabse phele 1st table pei

-- Null Search karne k liye
Select *
From olist_customers_dataset
where 
customer_id is null or customer_id = '' or
customer_unique_id is null or customer_unique_id = '' or
customer_zip_code_prefix is null or customer_zip_code_prefix = '' or
customer_city is null or customer_city = '' or
customer_state is null or customer_state = '';

-- 2nd table 

Select *
From olist_order_items_dataset
where 
order_id is null or order_id = '' or
order_item_id is null or order_item_id = '' or
product_id is null or product_id = '' or
seller_id is null or seller_id = '' or
shipping_limit_date is null or shipping_limit_date = '' or
price is null or price = '' or
freight_value is null or freight_value = '';
 
 
 -- 3rd table
 
 Select *
From olist_orders_dataset
where 
order_id is null or order_id = '' or
customer_id is null or customer_id = '' or
order_status is null or order_status = '' or
order_purchase_timestamp is null or order_purchase_timestamp = '' or
order_approved_at is null or order_approved_at = '' or
order_delivered_carrier_date is null or order_delivered_carrier_date = '' or
order_delivered_customer_date is null or order_delivered_customer_date = '' or
order_estimated_delivery_date is null or order_delivered_carrier_date = '';


-- 4th table

 Select *
From products
where 
Product_id is null or Product_id = '' or
product_category_name is null or product_category_name = '' or
product_name_lenght is null or product_name_lenght = '' or
product_description_lenght is null or product_description_lenght = '' or
product_photos_qty is null or product_photos_qty = '' or
product_weight_g is null or product_weight_g = '' or
product_length_cm is null or product_length_cm = '' or
product_height_cm is null or product_height_cm = '' or
product_width_cm is null or product_height_cm = '';




-- duplicates find karne k liye table & column wise

--first table

SELECT 
customer_id, 
COUNT(*) as Total_Duplicates
FROM olist_customers_dataset
Group by customer_id
HAVING Count(*)>1;

SELECT 
customer_unique_id, 
COUNT(*) as Total_Duplicates
FROM olist_customers_dataset
Group by customer_unique_id
HAVING Count(*)>1
ORDER BY Total_Duplicates DESC;

SELECT 
customer_zip_code_prefix, 
COUNT(*) as Total_Duplicates
FROM olist_customers_dataset
Group by customer_zip_code_prefix
HAVING Count(*)>1;

SELECT 
customer_city, 
COUNT(*) as Total_Duplicates
FROM olist_customers_dataset
Group by customer_city
HAVING Count(*)>1;

SELECT 
customer_state, 
COUNT(*) as Total_Duplicates
FROM olist_customers_dataset
Group by customer_state
HAVING Count(*)>1;


--for second table

SELECT order_id, Product_id, COUNT(*) from olist_order_items_dataset
GROUP BY order_id, Product_id
HAVING COUNT(*)>1;

--for third table

SELECT 
order_id, 
Count(*) as order_count
from olist_orders_dataset
GROUP BY order_id
HAVING order_count >1
ORDER BY order_id;

-- for fourth table 

SELECT Product_id, COUNT(*) as Product_id_count FROM products
GROUP BY product_id 
HAVING Product_id_count>1
ORDER BY product_id; 


--High-Level KPIs 
-- 1st we find total revenue
SELECT 
ROUND(SUM(price+freight_value),2) as total_revenue
FROM olist_order_items_dataset as t_s;

--total orders
SELECT 
count(DISTINCT order_id) as total_orders
FROM olist_order_items_dataset as t_o;

--total customers
SELECT 
COUNT(DISTINCT customer_unique_id) as total_customers 
FROM olist_customers_dataset;

-- Average Price Per Order

SELECT 
ROUND(SUM(price + freight_value)/ COUNT(DISTINCT order_id),2) as Per_order_price from olist_order_items_dataset; 
