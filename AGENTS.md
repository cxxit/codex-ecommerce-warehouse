# Repository Guidelines

## Mandatory User Approval Workflow

Before modifying, creating, deleting, renaming, or otherwise changing any project file, first provide a complete change proposal. List every file you intend to create, modify, delete, or rename. For each file, describe the specific change and why it is needed for the user's request. Do not change files that were not listed.

Ask the user to type exactly E and press Enter to approve. E followed by Enter is the only valid approval. Do not treat yes, proceed, go ahead, okay, or any other response as approval. Do not make any project file changes while waiting. If the user does not enter exactly `E`, stop without modifying files.

Approval applies only to the files and changes in the proposal. If additional files need changes, or the actual changes would differ materially from the proposal, stop and present a new proposal; obtain another exact `E` approval before continuing. Do not partially implement a change or make helpful documentation, configuration, code, or formatting changes while waiting.

Treat questions, technology comparisons, and discussion of possible changes as discussion only. Answer and explain implications without editing files. If the discussion leads to a possible change, propose it and request exact `E` approval first. This approval step also applies when the user explicitly asks for implementation.

Read-only operations are allowed without approval, including inspecting files, searching the repository, reading documentation, examining directory structure, and running commands that do not modify project files. Obtain approval before running any command that may modify project files. This workflow is mandatory throughout the project lifecycle; do not bypass it because a change seems small, obvious, routine, or beneficial.

## Project Structure & Module Organization

This is a learning-oriented e-commerce warehouse project using the historical Olist dataset. `README.md` describes the project; `PROJECT_BRIEF.md` records its goals. `src/business-case.sql` captures business questions and draft architecture in SQL comments. As implementation begins, keep ingestion code, Airflow DAGs, dbt models, dashboard code, and tests in clearly named directories; do not mix downloaded data with code. Preserve original data files in a documented raw-data location and keep generated database files out of version control.

## Build, Test, and Development Commands

No dependency manifest or runnable pipeline exists yet, so there are currently no project-defined build, test, or run commands. The planned stack is Python ingestion, Apache Airflow and PostgreSQL in Docker Compose, dbt with the `dbt-postgres` adapter, and Power BI for business analytics. Persist PostgreSQL's data directory in a named Docker volume and publish port `5432` for local client access. Keep Airflow metadata separate from warehouse data. Record exact setup and execution commands when components are added; see `README.md` for architecture references.

## Coding Style & Naming Conventions

Use Python with four-space indentation and `snake_case` for modules, functions, and variables. Use SQL with uppercase keywords, lowercase `snake_case` identifiers, and explicit column lists. Name dbt models by layer and purpose, such as `stg_orders` and `fct_order_items`. Keep models focused and document their grain and business meaning. Add formatter and lint configuration when the implementation language and tools are selected.

## Testing Guidelines

No test framework or coverage target is configured yet. Add tests with each pipeline or model milestone. Use the selected Python test runner's standard `test_*.py` pattern and dbt tests for model keys, relationships, and required fields. Document the commands to run them once configured. Validate row counts and key uniqueness at each data layer.

## Commit & Pull Request Guidelines

Git history currently has one initial commit, so there is no settled message convention. Use short, imperative subjects that describe one change (for example, `Add order staging model`). Pull requests should state the business or learning goal, summarize design choices, list validation performed, and include dashboard screenshots when relevant.

## Learning & Data Handling

Work in small, reviewable stages. Explain tradeoffs and ask the repository owner about meaningful design choices rather than generating the whole system at once. Treat Olist as historical data: describe runs as repeatable loads or monthly replays, not as a live feed. Keep each fact table's grain explicit to avoid double-counting across orders, items, payments, and reviews. Define the business meaning and calculation for every Power BI KPI. Never commit credentials or local environment files.
