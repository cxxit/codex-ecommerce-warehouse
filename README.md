# Olist E-Commerce Data Warehouse

A learning-focused portfolio project for building a local analytics warehouse and Power BI report from the historical Brazilian E-Commerce Public Dataset by Olist. The project is developed in small, reviewable stages, with each data model and KPI tied to a clear business meaning.

## Project Scope

Use Olist's published CSV files as the source. The dataset contains historical order, item, payment, review, customer, seller, product, and geolocation data. It supports analysis of sales, order activity, delivery performance, and review scores for the period covered by the dataset. This is a repeatable file-based ingestion project; a live commerce platform and REST API ingestion are outside the current scope.

## Planned Architecture

```text
Olist CSV files -> Python ingestion -> PostgreSQL raw/staging schemas
                -> dbt staging and dimensional models -> Power BI report
```

Keep downloaded source files in a documented raw-data location, separate from code. Preserve the original files and do not commit downloaded data or generated database files unless the project later documents a reason to do so. Use Python to load the CSVs repeatably into PostgreSQL. Use dbt with the `dbt-postgres` adapter to transform and test the warehouse models. Airflow may be added later if orchestration becomes a learning milestone; it is not required for the initial pipeline.

The current `docker-compose.yml` provides PostgreSQL and pgAdmin with named data volumes. A data-pipeline Dockerfile scaffold is present. The Python ingestion implementation, dbt project, and Power BI report remain future milestones.

## Warehouse Model

Model each fact table at an explicit grain to prevent double-counting:

- `fact_order_items`: one row per order item, for product sales and freight analysis.
- `fact_orders`: one row per order, for order lifecycle and delivery measures.
- `fact_payments`: one row per payment record, for payment method and payment value analysis.
- `fact_reviews`: one row per review record, for review score and review timing analysis.

Potential dimensions include date, product, customer, seller, and geography. Preserve the distinction between Olist's order-level `customer_id` and the repeat-customer `customer_unique_id`. Confirm source keys and relationships during profiling, and document every KPI's grain and calculation before using it in Power BI.

## Learning Plan

1. Obtain and inspect the Olist source files; document their tables, columns, grains, keys, and relationships.
2. Load the original CSVs repeatably into PostgreSQL raw tables with Python.
3. Validate row counts, required fields, key uniqueness, and relationships.
4. Build dbt staging and dimensional models, with tests for important keys and relationships.
5. Define business KPIs and build the Power BI report.
6. Add orchestration only if it supports a later project milestone.

See [PROJECT_BRIEF.md](PROJECT_BRIEF.md) for the project goals and modeling scope, and [dictionary/plan.md](dictionary/plan.md) for the staged implementation checklist.

---

_This document describes the current Olist-based project scope._
