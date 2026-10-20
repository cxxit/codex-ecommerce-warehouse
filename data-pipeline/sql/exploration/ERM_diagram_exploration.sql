select * from raw.olist_orders_dataset;


select * from raw.olist_sellers_dataset;
select * from raw.olist_order_items_dataset;


select order_id, order_item_id, count(*)
from raw.olist_order_items_dataset
group by order_id, order_item_id
having count(*) > 1; -- this shows that order items table have a composite primary key
    -- this also shows that each order item is only

-- Identify cardinalities between order items and sellers table
select seller_id, count(*)
from raw.olist_order_items_dataset
group by seller_id
having count(*) > 1; -- there obviously is many sellers associated with each order_item

select seller_id
from raw.olist_order_items_dataset
where seller_id not in (
    select seller_id
    from raw.olist_sellers_dataset
    ); -- all seller id in order items are valid


select seller_id, count(*)
from raw.olist_order_items_dataset
group by seller_id
having count(*) = 1; -- all seller id in sellers table is in order items tables


-- investigate order_reviews table
select *
from raw.olist_order_reviews_dataset;


-- investigate whether each review_id is unique
select review_id, count(*)
from raw.olist_order_reviews_dataset
group by review_id
having count(*) > 1
order by review_id; -- there are many records of duplicated review_id
-- investigate the duplicated review_id
select *
from raw.olist_order_reviews_dataset
where review_id = '0467560f511c516ddaa54a60edb0c291'; -- same review_id, different order_id, same review message


-- what does the above mean
    -- for each of the review id there is one or many order_id
select review_id, order_id, count(*)
from raw.olist_order_reviews_dataset
group by review_id, order_id
having count(*) > 1; -- review_id, and order_id together is the composite key
SELECT
    review_id,
    COUNT(*) AS total_records,
    COUNT(DISTINCT order_id) AS distinct_orders
FROM raw.olist_order_reviews_dataset
GROUP BY review_id
HAVING COUNT(*) > 1
ORDER BY review_id;


-- why can each review id have multiple order_id
select *
from raw.olist_order_reviews_dataset
where order_id  in (
    select order_id
    from raw.olist_order_reviews_dataset
    group by order_id
    having  count(*) > 1
    )
and order_id = '565b0bdb5bfef65df5a23890967586f6'
order by order_id;

select *
from raw.olist_orders_dataset
where order_id = '565b0bdb5bfef65df5a23890967586f6';

select *
from raw.olist_order_items_dataset
where order_id = '565b0bdb5bfef65df5a23890967586f6';

select order_id
    from raw.olist_order_reviews_dataset
    group by order_id
    having  count(*) > 1;

select *
from raw.olist_order_reviews_dataset
where order_id = '565b0bdb5bfef65df5a23890967586f6';
SELECT
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
FROM raw.olist_order_reviews_dataset
WHERE order_id = '565b0bdb5bfef65df5a23890967586f6'
ORDER BY review_creation_date, review_answer_timestamp; -- this explains why there is 2 reviews for the same order_id
-- customer is given the ability to review a product again, as seen in this query after a few days the customer gave it a review score of 1 ffrom review score = 5

-- explain why there is duplicated review_id?, edit?
select review_id
from raw.olist_order_reviews_dataset
group by review_id
having count(*) =3; -- all these are the review_id that has more than 1 count

select *
from raw.olist_order_reviews_dataset
where review_id = '1fb4ddc969e6bea80e38deec00393a6f'; -- this shows the same review_id but different order_id

-- investigate whether all order id has a review
select order_id
from raw.olist_orders_dataset
where order_id not in
(select order_id
from raw.olist_order_reviews_dataset); -- not all order_id from orders table has a review


-- investigate order_payments
select * from raw.olist_order_payments_dataset;

select order_id, count(*)
from raw.olist_order_payments_dataset
group by order_id
having count(*) > 1;


select *
from raw.olist_order_payments_dataset
where order_id = '53f5a7f622d498ff3eeb334b8efa7ae7'; -- many order_id because each order can be paid with many methods, with payment sequential made


select * from raw.olist_order_items_dataset;

select order_id, order_item_id, product_id, count(*)
from raw.olist_order_items_dataset
group by order_id, order_item_id, product_id
having count(*) > 1; -- for each product id is only associated with a single order_id, and order_item id

select * from raw.product_category_name_translation;

select distinct product_category_name
from raw.olist_products_dataset
where product_category_name not in
(
    select distinct product_category_name
    from raw.product_category_name_translation
    ); -- there are two product category in products table that is not in product category translation table, ERROR TO BE FIXED


select product_category_name
from raw.product_category_name_translation
group by product_category_name
having count(*) > 1; -- no duplicates, product category name is unique

select product_category_name
from raw.product_category_name_translation
where product_category_name not in (
    select product_category_name
    from raw.olist_products_dataset
    ); -- all product category name is in the PRODUCT table