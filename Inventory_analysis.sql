-- Enable the RDBMS_database 
use sofia_data_proyects;

-- Rename old column ï»¿item_id for item_id
alter table inventory_data
change ï»¿item_id item_id varchar(3);

-- Select table to check records
select *
from inventory_data;

-- Count many rows (data) on the inventory_data table
select count(item_id) as total_data
from inventory_data;

-- Know how many categories in the Inventory_data table
select count(DISTINCT category) as Total_category
from inventory_data;

-- Know how many products in the Inventory_data table
select count(DISTINCT name) as Total_products
from inventory_data;

-- Know all products and their cost and sale price
select category, name, SUM(retail_price) as Value_product, round(SUM(cost_price),2) as Product_cost
from inventory_data
group by name, category
order by Product_cost desc;

-- Know all products and their value by Category
select category, round(SUM(retail_price),2) as Value_product, round(SUM(cost_price),2) as Product_cost
from inventory_data
group by category;

-- Know all products and their sale value by Category, list the top 5
select category, round(SUM(retail_price),2) as Value_product, round(SUM(cost_price),2) as Product_cost
from inventory_data
group by category
order by Product_cost desc
limit 5;

-- Know Total and Retail price by category using the BIG 6
select category, round(SUM(cost_price),2) as Product_Cost, round(SUM(retail_price),2) as Value_product 
from inventory_data
where  category is not null
group by category
having Product_cost >0
order by Value_product desc;
