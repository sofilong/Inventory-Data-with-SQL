
-- Using Subqueries + CTE + Windows expressions
-- Enable the RDBMS
use sofia_data_proyects;

-- See all available attributes from the Inventory data table
select * 
from inventory_data;

-- Review the 10 ten Suppliers
-- Select product, supplier and reorder_qty
with orderqty as (select category, min(reorder_quantity) as Min_orderqty, max(reorder_quantity) as Max_orderqty,
					sum(quantity_on_hand) as OH
				from inventory_data
				group by category
				order by Min_orderqty)
select *
from orderqty;

-- Review the exisitng quantity and compare with the reorder_qty, list by supplier
create view Supplier as 
with order_status as (select category, supplier_name, reorder_quantity, quantity_on_hand,
					abs(round(quantity_on_hand - reorder_quantity)) as order_diff, 
					row_number() over(order by reorder_quantity desc) as reorder_list
					from inventory_data
					where quantity_on_hand < reorder_quantity)
-- Count total of items needing restock
select *
from order_status;

-- Count total of items needing restock, group by Category
select category,count(order_diff)
from order_status
group by category;