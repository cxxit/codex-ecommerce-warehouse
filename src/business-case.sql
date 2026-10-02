-- ## Proposed business problem

-- Give an e-commerce operations team a way to understand sales performance and 
-- fulfillment quality:

-- - Which products, sellers, and regions contribute to item sales?
-- - Where are delivery delays most common?
-- - How do delivery times relate to review scores?

-- The Olist dataset supports these questions with order, item, payment, seller, 
-- product, customer, delivery, and review data. It covers about 100,000 orders 
-- from 2016–2018, so it’s a realistic but bounded historical dataset. 
-- Since it isn’t a live feed, we should present pipeline runs as repeatable 
-- historical loads or monthly replays, not pretend they’re processing current orders. 
-- [Olist dataset](<https://www.kaggle.com/olistbr/brazilian-ecommerce>)

-- ## Draft local architecture

-- `Olist CSVs → raw files → Python ingestion → DuckDB staging → dbt models → dashboard`