select * from raw.olist_orders_dataset;

select * from raw.olist_customers_dataset;
select * from raw.olist_geolocation_dataset;

select * 

select product_id, count(*)
from raw.olist_products_dataset 
group by product_id 
having count(*) > 1;


select geolocation_zip_code_prefix, geolocation_city, geolocation_state, count(*)
from raw.olist_geolocation_dataset 
group by geolocation_zip_code_prefix, geolocation_city, geolocation_state
order by geolocation_zip_code_prefix;


select customer_id, customer_state, count(*) 
from raw.olist_customers_dataset 
group by customer_id, customer_state
having count(*) > 1;

select distinct c.customer_zip_code_prefix 
from raw.olist_customers_dataset c
join raw.olist_geolocation_dataset g
on c.customer_zip_code_prefix = g.geolocation_zip_code_prefix
where c.customer_zip_code_prefix not in (
    select distinct geolocation_zip_code_prefix
    from raw.olist_geolocation_dataset
); -- no records, all zip code in customer table is valid 

select count(*) 
from (
select distinct g.geolocation_zip_code_prefix 
from raw.olist_geolocation_dataset g  
where g.geolocation_zip_code_prefix not in (
    select distinct customer_zip_code_prefix 
    from raw.olist_customers_dataset
)); -- 4000 + records not all valid geolocation has an associating customer

select count(*) from raw.olist_geolocation_dataset;

select customer_id, count(*)
from raw.olist_orders_dataset
group by customer_id 
having count(*) > 1; -- each record in orders have a unique ustomer_id from the customer_table
-- for each new record in orders, a new custoer_id is generated 

select * from raw.olist_order_items_dataset;

select order_id 
from raw.olist_order_items_dataset 
where order_id not in (
    select order_id 
    from raw.olist_orders_dataset
); -- all order id in order_items is in order table




select * 
from raw.olist_orders_dataset 
where order_id not in (
    select order_id 
    from raw.olist_order_items_dataset
)
and order_status = 'shipped'; -- order status or unavailbale, canceled, shopped, invvoiced, created


select * 
from (
SELECT
    o.order_id,
    o.order_status,
    CASE
        WHEN o.order_status IN ('shipped', 'invoiced')
             AND NOT EXISTS (
                 SELECT 1
                 FROM raw.olist_order_items_dataset oi
                 WHERE oi.order_id = o.order_id
             )
        THEN 'MISSING_ORDER_ITEMS'
        ELSE 'OK'
    END AS data_quality_status
FROM raw.olist_orders_dataset o)
where data_quality_status = 'MISSING_ORDER_ITEMS'; -- FIXME: data-quality issues 

select * from raw.olist_order_items_dataset;

select order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, freight_value, count(*)
from raw.olist_order_items_dataset 
group by order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, freight_value 
having count(*) > 1; -- there are no whole records which is duplicated


select order_id, order_item_id, count(*)
from raw.olist_order_items_dataset 
group by order_id, order_item_id
having count(*) > 1; -- no order_id, and order_item_id which are duplicated

-- but order_id in order_items dataset is duplicated why is that ??? 
select * 
from raw.olist_order_items_dataset
where order_id in
(select order_id
from raw.olist_order_items_dataset 
group by order_id
having count(*) > 1)
order by order_id; 


select * from raw.olist_products_dataset;

select product_id, count(*) 
from raw.olist_products_dataset 
group by product_id 
having count(*) > 1; -- no duplicates 


select * from raw.olist_sellers_dataset;

select seller_id, count(*)
from raw.olist_sellers_dataset 
group by seller_id 
having count(*) > 1; -- no duplicated seller_id

-- relatioinship between geolocation and sellers 


select distinct seller_zip_code_prefix 
from raw.olist_sellers_dataset 
where seller_zip_code_prefix not in (
    select distinct geolocation_zip_code_prefix 
    from raw.olist_geolocation_dataset
);

select distinct geolocation_zip_code_prefix 
from raw.olist_geolocation_dataset
where geolocation_zip_code_prefix = '2285'; -- FIXME: