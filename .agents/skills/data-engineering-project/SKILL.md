---
name: data-engineering-project
description: Guide local data engineering projects that ingest REST API data with Python and build PostgreSQL, dbt, dimensional warehouse, and Airflow pipelines. Emphasizes small milestones, reproducibility, data quality, and testing rather than bulk code generation.
---

# Data Engineering Project Guide

Use this skill when planning, building, reviewing, or debugging a local data engineering project that ingests API data and turns it into analytics-ready warehouse models.

## Working approach

- Start from the user's business questions, source systems, data volume, refresh needs, local environment, and learning goals. Reuse decisions already made; ask only when a choice materially affects the design.
- Work in reviewable milestones. Prefer one end-to-end vertical slice—a source endpoint through a raw table, a dbt model, and a data check—before expanding to every entity or adding orchestration.
- Explain the purpose and tradeoffs of each component. Offer checklists and focused examples first. Generate broad scaffolding or large code changes only when the user asks for them.
- Keep the stack proportional to the goal. Airflow is useful for scheduling and orchestration, but can wait until the ingestion and transformation steps work independently.

## Source and API ingestion

- Record the API's base URL, resources, authentication method, pagination contract, rate limits, expected response shape, and update behavior. Keep credentials in environment configuration or a secrets mechanism, never in source control.
- Handle timeouts and transient failures with bounded retries and backoff. Respect rate limits and distinguish retryable errors from invalid requests or data.
- Implement pagination completely. Avoid assuming that one response contains the full resource set.
- Make extraction repeatable. Track useful run metadata such as source, extraction time, request window, page or cursor, row count, and outcome.
- For incremental loads, define the cursor or watermark, overlap needed for late updates, deduplication key, upsert behavior, and any deletion policy. Ensure a retry or rerun does not create duplicate rows or skip data.
- Preserve source values and identifiers in the raw layer. Keep API payloads or raw columns sufficiently intact to support debugging and reprocessing.

## PostgreSQL and warehouse design

- Separate raw ingestion, cleaned staging, and analytics marts into clear schemas or equivalent layers. Keep Airflow metadata storage separate from warehouse data when both use PostgreSQL.
- Before defining a fact table, write its grain in one sentence (for example, “one row per order item”). Identify its business key, measures, and relationships. Define dimensions and their keys explicitly.
- Never join facts at different grains without accounting for fanout. State how null, duplicate, late-arriving, and changing source records affect the model.
- Use explicit column lists and stable types. Choose constraints, indexes, and transaction boundaries to support correctness and the expected workload.
- Keep configuration portable across local environments; document database names, schemas, ports, and required environment variables without committing secrets.

## Python, dbt, and Airflow

- Keep Python responsibilities focused on extraction, transport, loading, and operational logging. Separate API clients, transformation logic, and database operations enough to make them understandable and testable.
- In dbt, organize source declarations and staging models before dimensional marts. Document model purpose and grain. Add appropriate `not_null`, `unique`, relationship, and accepted-value tests, plus freshness checks when source timing makes them meaningful.
- Use incremental dbt models only after defining their unique key, update strategy, late-arriving data behavior, and full-refresh path.
- Build and run ingestion outside Airflow first. When orchestration is needed, make tasks bounded and retry-safe; set sensible timeouts, retries, schedules, time zones, and backfill behavior. Keep DAG code focused on orchestration rather than embedding the pipeline implementation.

## Quality and verification checklist

For each milestone, define the checks that demonstrate it works. Consider:

- API pagination reaches the expected records, and errors are visible in logs.
- Source and loaded row counts reconcile within documented rules.
- Business keys are unique at the stated grain; required fields and relationships are checked.
- Rerunning the same extraction or load produces the intended result without duplicate or missing records.
- Transformations handle representative edge cases such as nulls, updated records, empty responses, and late-arriving data.
- dbt models build successfully and their tests cover important assumptions.
- A small end-to-end run produces warehouse outputs that answer at least one stated business question.

Prefer focused unit tests for parsing and transformation logic, integration checks for API/database boundaries, dbt tests for model assumptions, and a small end-to-end check for the pipeline. Keep test data representative and avoid relying on live external APIs for routine deterministic tests when fixtures can cover the behavior.

## Suggested milestone checklist

1. **Scope:** document business questions, source resources, refresh pattern, data grain, and local constraints.
2. **Thin slice:** ingest one paginated resource into a raw PostgreSQL table and make reruns safe.
3. **Quality:** profile source data, reconcile counts, validate keys, and document exceptions.
4. **Model:** create dbt staging and one dimensional model with an explicit grain and tests.
5. **Expand:** add related resources and models while checking joins and measures for fanout.
6. **Operate:** document setup and recovery, then add Airflow or other orchestration if the workflow benefits from it.

Keep a short decision record when a choice affects correctness or future work, such as an incremental key, deletion policy, fact grain, or historical dimension strategy.
