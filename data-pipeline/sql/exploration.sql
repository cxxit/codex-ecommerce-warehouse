-- BACKGROUND -- 
-- url: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce/data
-- 

select * from raw.olist_customers_dataset;

select * from raw.olist_geolocation_dataset;

select * from raw.olist_order_items_dataset order by order_id;

select *
from raw.olist_order_payments_dataset
where order_id = '0bcaf262925111aa4be36f35bcb92fdd'
order by order_id; -- suggests that for that particular order_id, it has 7 payment records / sequences

select distinct payment_sequential from raw.olist_order_payments_dataset order by payment_sequential; -- customer pay with more than one paymnt method 


select * from raw.olist_order_reviews_dataset;
-- PROBLEM:
    -- when analysis would like to be done on review_score 
    -- we need to create a dimension scoredim, which provides the description of each numerical score 
select distinct review_score from raw.olist_order_reviews_dataset order by review_score; -- score is from 1-5


select * from raw.olist_orders_dataset;


select * from raw.olist_products_dataset;
-- PROBLEM:
    -- product_category_name is in potuguese 
    -- this can be fixed through joining olist_products_dataset with olist_product category_name translsation
-- QUESTION: each product_category is not only once, but product_id is unique
-- QUESTION: what analytics questions can we get from here

select * from raw.olist_sellers_dataset; -- product seller information
-- distinct seeler state
select json_agg(t)
from (select distinct seller_state from raw.olist_sellers_dataset) t; -- changed to JSON format output 
-- PROBLEM:
-- seller state is a short form code style information on the state
    -- have to research and understand how each state relates to its actual name 
    -- for analytical problems around understanding data from state point of view we have to make a state dimension 

select * from raw.product_category_name_translation; -- product transaltion from potuguese to english

