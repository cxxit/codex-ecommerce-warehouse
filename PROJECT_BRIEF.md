# Olist E-Commerce Data Warehouse Project Brief

## Goal

Build a portfolio-quality local data warehouse and Power BI report for e-commerce sales and operations analytics using Olist's historical Brazilian E-Commerce Public Dataset. Work through implementation in understandable stages and explain important choices, data grains, and KPI definitions as the project develops.

## Data Source and Scope

Use the Olist dataset distributed through Kaggle as nine related CSV files. It contains historical records from the Brazilian marketplace, including orders, order items, payments, reviews, customers, sellers, products, geolocation, and a product-category translation table. The data supports repeatable historical analysis; it is not a live feed and Olist is not being used as a REST API source in this project.

Keep the original downloaded files in a documented raw-data location, separate from application code. Avoid committing source data or generated database files unless a later project decision calls for it. Record the dataset version or download date so loads can be reproduced.

Source: [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

## Planned Architecture

`Olist CSV files -> Python ingestion -> PostgreSQL raw/staging schemas -> dbt SQL models -> Power BI report`

Python will load the source files repeatably into PostgreSQL. Preserve source columns and identifiers in the raw layer, then transform them into documented staging and dimensional models with dbt and the `dbt-postgres` adapter. The current Compose setup provides PostgreSQL and pgAdmin, and a data-pipeline Dockerfile scaffold exists. Ingestion code, the dbt project, and the report are planned work. Airflow is optional and should be considered only after the basic pipeline works and orchestration is a useful learning goal.

## Candidate Dimensional Model

- `fact_order_items`: one row per `order_id` and `order_item_id`; product price and freight at item grain.
- `fact_orders`: one row per `order_id`; order status and lifecycle timestamps.
- `fact_payments`: one row per payment record, identified using the available order and payment sequence fields.
- `fact_reviews`: one row per source review record, keyed by the review identifier and related to its order.
- Dimensions may include product, customer, seller, date, and geography.

Validate source keys, null behavior, and relationships while profiling the files. Olist has both an order-specific `customer_id` and a cross-order `customer_unique_id`; retain that distinction when modeling repeat customers. Keep each fact's grain explicit and avoid joining facts at different grains in a way that inflates measures.

## Analytics Scope

Potential report measures include item sales, freight, order volume, payment values, delivery duration or lateness, and review scores. Define each metric's business meaning, filters, and calculation before creating its Power BI visual. Explain any exclusions or source limitations, especially around cancelled or unavailable timestamps and review coverage.

## Implementation Milestones

1. Obtain the dataset and document the source files and their grains.
2. Profile schemas, keys, missing values, and relationships.
3. Build repeatable Python CSV ingestion into PostgreSQL raw tables.
4. Add row-count, uniqueness, required-field, and relationship checks.
5. Build dbt staging and dimensional models with appropriate tests.
6. Define KPIs and develop the Power BI report.
7. Consider scheduling or Airflow after the end-to-end pipeline is stable.
