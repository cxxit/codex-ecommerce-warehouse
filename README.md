# Olist E-Commerce Data Warehouse

A learning-focused portfolio project for building a local analytics warehouse and Power BI report from the historical Brazilian E-Commerce Public Dataset by Olist. The project is developed in small, reviewable stages, with each data model and KPI tied to a clear business meaning.

## Project Scope

Use Olist's published CSV files as the source. The dataset contains historical order, item, payment, review, customer, seller, product, and geolocation data. It supports analysis of sales, order activity, delivery performance, and review scores for the period covered by the dataset. This is a repeatable file-based ingestion project; a live commerce platform and REST API ingestion are outside the current scope.

## Architecture and Current Status

```text
Olist CSV files -> Python ingestion -> PostgreSQL raw/staging schemas
                -> dbt staging and dimensional models -> Power BI report
```

The Docker Compose setup for PostgreSQL and pgAdmin is in place, and the data-pipeline Dockerfile is configured for ingestion dependencies. The Olist CSV tables have been loaded into the PostgreSQL `raw` schema. The next steps are to validate the raw data, then build dbt staging and dimensional models with the `dbt-postgres` adapter.

Keep downloaded source files separate from code, and do not commit source data or generated database files unless the project later documents a reason to do so. Treat loads as repeatable historical data loads, not as a live feed. Airflow may be added later if orchestration becomes a useful learning milestone; it is not required for the initial pipeline.

## Warehouse Model

Model each fact table at an explicit grain to prevent double-counting:

- `fact_order_items`: one row per order item, for product sales and freight analysis.
- `fact_orders`: one row per order, for order lifecycle and delivery measures.
- `fact_payments`: one row per payment record, for payment method and payment value analysis.
- `fact_reviews`: one row per review record, for review score and review timing analysis.

Potential dimensions include date, product, customer, seller, and geography. Preserve the distinction between Olist's order-level `customer_id` and the repeat-customer `customer_unique_id`. Confirm source keys and relationships during raw data validation, and document every KPI's grain and calculation before using it in Power BI.

## Learning Plan

1. **Complete:** Set up the Docker Compose services and data-pipeline image, then load the Olist CSV tables into PostgreSQL's `raw` schema.
2. Validate raw row counts, required fields, key uniqueness, and relationships against the source files.
3. Set up dbt sources and staging models, then build dimensional models with tests for important keys and relationships.
4. Define business KPIs and build the Power BI report.
5. Add orchestration only if it supports a later project milestone.

See [PROJECT_BRIEF.md](PROJECT_BRIEF.md) for the project goals and modeling scope, and [dictionary/plan.md](dictionary/plan.md) for the staged implementation checklist.

---

_This document describes the current Olist-based project scope._
