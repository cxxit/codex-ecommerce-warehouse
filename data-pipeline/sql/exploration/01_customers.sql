-- Table: warehouse.raw.olist_customers_dataset
-- Olist exploration worksheet: write your own SQL in the blank spaces.
-- Scope: historical source snapshot in database warehouse; preserve raw unchanged.
-- Professional practice: reconcile source counts and record dataset version and check date.
-- Profiling describes observed data; validation compares evidence with justified expectations.
-- Record affected rows AND denominators; prioritize issues by analytical impact.
-- NULL differs from empty or whitespace text; distinct counts generally exclude NULL.
-- Samples help exploration but cannot prove completeness or uniqueness.
-- Declared nullability is not evidence of actual nulls; candidate keys need testing.
-- Preserve original values; propose staging treatments rather than changing raw.
-- Define grain before joins: a surrogate key cannot repair ambiguous source grain.
-- Repeat checks against the same snapshot; promote justified rules into automated tests.
-- Historical static data needs reproducibility, not an assumed live-feed freshness target.

select * from warehouse.raw.olist_customers_dataset;
select * from warehouse.raw.olist_orders_dataset;

select count(*) 
from warehouse.raw.olist_customers_dataset; --99441

select count(*) 
from warehouse.raw.olist_orders_dataset; -- 99441 

-- everytime a customer orders an order from olist, every instance which requires a new invoice, a new customer_id is generated for that order 

-- within the olist dataset the customer_unique_id represents the customer_id which is unique to a single person
    -- one customer_unique_id would be associated with many customer_id
    -- each customer_unique_id would be associated with many order_id
    -- each customer_id is a one to one relationship with each order_id 
select customer_id, count(*) 
from warehouse.raw.olist_orders_dataset
group by customer_id
having count(*) > 1; -- no records 
    -- each customer_id in the orders dataset appears once only
select order_id, count(*) 
from warehouse.raw.olist_orders_dataset
group by order_id 
having count(*) > 1;  -- no records 
    -- each order_id is unique 

select customer_unique_id, order_id

select customer_id, customer_unique_id, count(*)
from warehouse.raw.olist_customers_dataset
group by customer_id, customer_unique_id
having count(*)>1;


-- BEGINNER: inventory, grain, keys, and completeness.
-- Task 1: How many customer records were loaded, and do they reconcile with the source CSV?
-- Hint: Record the source version, counting method, and expected count; distinguish rows from distinct identifiers.
-- 99441 records were loaded and is reconiled with the source CSV
select count(*) as "number of customers"
from warehouse.raw.olist_customers_dataset; -- 99441 records 

-- Task 2: Is customer_id a complete, unique candidate primary key? Are duplicate keys identical or conflicting?
-- Hint: Key duplication and whole-row duplication answer different questions.
select count(*) as "number of records where customer_id is duplicated"
from (
    select customer_id, count(*) as "number of customer_id duplicates"
    from warehouse.raw.olist_customers_dataset 
    group by customer_id
    having count(*) > 1); -- there are no duplicated customer_Id
-- customer_id is a complete unique candidate primary key 

-- Task 3: How does customer_unique_id repeat across customer_id values? What grain does each identifier represent?
-- Hint: A repeating person identifier can be legitimate at the order-associated customer grain.
select count(*) as "number of records where customer_unique_id is duplicated"
from (
    select customer_unique_id, count(*) as "number of customer_unique_id duplicates" 
    from warehouse.raw.olist_customers_dataset 
    group by customer_unique_id
    having count(*) > 1); -- there are 2997 customer_unique_id which are duplicated

select customer_unique_id, count(*) as "number of customer_unique_id duplicates" 
from warehouse.raw.olist_customers_dataset 
group by customer_unique_id
having count(*) > 1; -- 2997 RECORDS where count(*) > 1
-- this suggests that 2997 customers within the olist database ordered from olist more than once

-- each grain for customer_unique_id represents a unique person 
        -- each customer_unique_id is related to multiple orders 
select count(*) as "number of customers in olist database"
from (
select distinct customer_unique_id
from warehouse.raw.olist_customers_dataset
group by customer_unique_id); --96096 customers 

-- INTERMEDIATE: validity, relationships, and business interpretation.
-- Task 4: Which identifiers and address fields contain nulls, empty strings, or whitespace?
-- Hint: Assess required identity fields separately from descriptive attributes.
select * from warehouse.raw.olist_customers_dataset;

select * 
from warehouse.raw.olist_customers_dataset
where customer_id is null   
        or trim(customer_id) = ''
        or customer_unique_id is null   
        or trim(customer_unique_id) = ''
        or customer_zip_code_prefix is null
        or customer_city is null 
        or trim(customer_city) = ''
        or customer_state is null
        or trim(customer_state) = ''; -- no records which means there are no records where the field contains a null value, or whitespace and empty strings

-- Task 5: Are postal prefixes, city names, and state codes consistently represented?
-- Hint: Postal prefixes are identifiers; investigate numeric storage and source formatting before proposing padding.
select * from warehouse.raw.olist_customers_dataset;
select customer_city, customer_zip_code_prefix 
from warehouse.raw.olist_customers_dataset 
where customer_city = 'franca'; -- for each customer_city there are many zip-codes 

select upper(customer_city), count(distinct customer_city),
        string_agg(distinct customer_city, '_' order by customer_city) as "original values"
from warehouse.raw.olist_customers_dataset
group by upper(customer_city)
having count(distinct customer_city)>1;

select distinct customer_state
from warehouse.raw.olist_customers_dataset;
-- all values are consistent 

-- Task 6: Do orders reference existing customers, and which customers have no matching orders?
-- Hint: Examine both relationship directions; missing references and unused master records have different implications.
explain analyze
select * 
from (
select c.customer_id, o.order_id 
from warehouse.raw.olist_customers_dataset c
left join warehouse.raw.olist_orders_dataset o
on c.customer_id = o.customer_id)
where customer_id is null or order_id is null;
 -- no record suggesting that all customer_id that exists in the customer dataset is linked to one instance of order in the order dataset 
explain analyze
select customer_id 
from warehouse.raw.olist_customers_dataset 
where customer_id not in (
    select distinct customer_id 
    from warehouse.raw.olist_orders_dataset
); -- no records, suggesting the same evidence as the above
explain analyze
select c.customer_id 
from warehouse.raw.olist_customers_dataset c
where not EXISTS (
    select 1 
    from warehouse.raw.olist_orders_dataset o
    where o.customer_id = c.customer_id
); -- no records 


-- ADVANCED: analytical impact and dimensional modelling.
-- Task 7: Do repeated customer_unique_id values have multiple addresses, cities, or states?
-- Hint: Variation may reflect moves or source differences; these columns alone do not establish address-change history.
select customer_unique_id, count(distinct customer_city) as city_count,
            string_agg(distinct customer_city, ', ' order by customer_city) as city_list
from warehouse.raw.olist_customers_dataset
group by customer_unique_id
having count(distinct customer_city)>2
order by customer_unique_id; -- there is 122 records in the olist customer dataset where a customer_unique_id is associated with 2 city list 
-- what does this mean????
select * from warehouse.raw.olist_geolocation_dataset; 
        -- this geolocation dataset shows that for each unique zip code prefix within a geolocation city and state 
-- each customer references one geolocation 
-- if a customer has differing cities that could either mean they moved cities or there is a mistype 

select * 
from warehouse.raw.olist_customers_dataset 


select * from warehouse.raw.olist_customers_dataset;


select customer_unique_id, 
        customer_zip_code_prefix, 
        customer_city, customer_state 
from warehouse.raw.olist_customers_dataset 
where customer_unique_id in (
    select customer_unique_id
    from warehouse.raw.olist_customers_dataset
    group by customer_unique_id
    having count(distinct customer_zip_code_prefix)>1)
order by customer_unique_id; -- from what i have found here 
        -- it is suggested that for each unique customer id, the customer can have different ustomer_zip_code_prefix 
        -- and customer city and customer state 
        -- it is possible for some customer to have changed their zipcode prefix multiple times but same state and city 

-- that is the next we have to explore 
    -- explore the customers which has a change of zip code 
select customer_unique_id, count(distinct customer_zip_code_prefix) as zip_code_count,
            string_agg(distinct customer_zip_code_prefix::TEXT, ', ' order by customer_zip_code_prefix::TEXT) as zip_code_list
from warehouse.raw.olist_customers_dataset
group by customer_unique_id
having count(distinct customer_zip_code_prefix)>1
order by customer_unique_id;


select customer_unique_id, count(distinct customer_state) as zip_code_count,
            string_agg(distinct customer_state, ', ' order by customer_state) as zip_code_list
from warehouse.raw.olist_customers_dataset
group by customer_unique_id
having count(distinct customer_state)>1
order by customer_unique_id;
-- The queries above hoewever wont help me detect all geolocation change

SELECT
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
FROM warehouse.raw.olist_customers_dataset
WHERE customer_unique_id IN (
    SELECT customer_unique_id
    FROM warehouse.raw.olist_customers_dataset
    GROUP BY customer_unique_id
    HAVING COUNT(DISTINCT customer_zip_code_prefix) > 1
        OR COUNT(DISTINCT customer_city) > 1
        OR COUNT(DISTINCT customer_state) > 1
)
ORDER BY customer_unique_id; -- 541 recorrds
-- threr are 541 customer which has changes made to their zip code, city and state 

-- which leads  us to the question what does zip code, city and state for each customer represent 
    -- for now, from what we understand by the olist database, it is the location at which the customer is currently situated 
    -- however we do not have the start date and end date of this period and when the change happened 
    -- so how do we create accurate analysis, given customer changes their locaiton 
        -- we can create a temporal dimension ?

select * from warehouse.raw.olist_orders_dataset; -- this table suggests that there is a timestamp recorded for each order 
-- QUESTION: 
    -- how do we preserve historical customer locatios when the source database doesn't explicityly record when a customer changed addresses 
    -- we need to determine which customer location was associated with an order at the time of purchase 


-- Task 8: How would you model repeat-customer identity while preserving the location associated with an order?
-- Hint: Define dimension grain, business key, surrogate key, and unknown-member handling before joining facts.
-- create a number of customer fact masure, under customerFACT 
-- connect the customer_unique_id as a PK identifier within the FACT to the customerDIM
-- create a customerLocationDIM
-- create a orderFACT, for fact measure number of orders
