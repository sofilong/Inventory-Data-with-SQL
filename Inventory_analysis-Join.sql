-- SQL Script to analys Inventory_data using joins

-- Enable the RDBMS
use sofia_data_proyects;

-- Select the inventory_data table
select *
from inventory_data;


/*Check the product cost and retail price by Supplier and Expiry_date using left join
to check potential null values on the expiry_date*/
select id1.sku, id1.category, id1.name, id1.cost_price, id1.retail_price,
		id2.supplier_name, id2.expiry_date
from inventory_data id1 left join inventory_data id2
on id1.sku = id2.sku;

/*Know what is the min/max cost and retail price per category*/
SELECT id1.category, min(id1.cost_price) as min_cost,max(id1.cost_price) as max_cost,
		min(id1.retail_price) as min_price ,max(id1.retail_price) as max_price
	from inventory_data id1 
	left join inventory_data id2
	on id1.sku=id2.sku
	group by id1.category;

/* Calculate the retail price difference, do a selfjoin and then compare the retail price
	between the products*/
SELECT id1.item_id, id1.name, id1.retail_price,
	   id2.item_id, id2.name, id2.retail_price,
      abs(round(id1.retail_price - id2.retail_price,2)) as price_diff
	from inventory_data id1 inner join inventory_data id2
	     on id1.item_id > id2.item_id
	where abs(id1.retail_price - id2.retail_price) > 50
		 and id1.name < id2.name	
    order by price_diff desc;

    
-- Group by Category and count records with and without expiration date
select id1.category, id1.with_ed, id2.missing_ed
from 
	(select category, sum(case when expiry_date <>0 then 1 else 0 end) as with_ed from inventory_data
			group by category) id1
left join
   (select category, sum(case when expiry_date = 0 then 1 else 0 end) as missing_ed from inventory_data
			group by category) id2
on id1.category = id2.category;


