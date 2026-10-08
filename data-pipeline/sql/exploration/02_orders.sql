-- Table: warehouse.raw.olist_orders_dataset
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

-- BEGINNER: inventory, grain, keys, and completeness.
-- Task 1: What is the row count, and is order_id complete and unique?
-- Hint: Establish one-row-per-order grain and reconcile the load before calculating order volume.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 2: Are repeated order identifiers exact duplicates or conflicting lifecycle records?
-- Hint: Arbitrary deduplication can discard meaningful differences.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 3: Which order_status values occur, including blank or missing values?
-- Hint: Profile observed values before proposing an accepted-values rule.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- INTERMEDIATE: validity, relationships, and business interpretation.
-- Task 4: Can each lifecycle timestamp stored as text be interpreted consistently?
-- Hint: Check missing values and formats before conversion; one malformed value can invalidate a direct cast.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 5: How does timestamp completeness vary by order status?
-- Hint: An undelivered order and a delivered order need different completeness expectations.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 6: Are purchase, approval, carrier handoff, and customer delivery chronologically consistent?
-- Hint: Compare applicable events and document exceptions; estimated delivery is a promise rather than a completed event.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 7: Do customer references resolve, and how does item, payment, and review coverage vary by status?
-- Hint: Aggregate child tables before comparing coverage; direct joins can multiply order rows.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- ADVANCED: analytical impact and dimensional modelling.
-- Task 8: What denominators and date rules would make delivery duration and lateness meaningful?
-- Hint: Decide eligible statuses, missing-event treatment, timestamp versus calendar-date comparison, and timezone assumptions.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 9: Which measures belong in an order-grain fact, and which dates need separate analytical roles?
-- Hint: Preserve one row per order; explicitly define purchase-date and delivery-date reporting.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

