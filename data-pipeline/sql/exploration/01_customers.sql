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

-- BEGINNER: inventory, grain, keys, and completeness.
-- Task 1: How many customer records were loaded, and do they reconcile with the source CSV?
-- Hint: Record the source version, counting method, and expected count; distinguish rows from distinct identifiers.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 2: Is customer_id a complete, unique candidate primary key? Are duplicate keys identical or conflicting?
-- Hint: Key duplication and whole-row duplication answer different questions.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 3: How does customer_unique_id repeat across customer_id values? What grain does each identifier represent?
-- Hint: A repeating person identifier can be legitimate at the order-associated customer grain.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- INTERMEDIATE: validity, relationships, and business interpretation.
-- Task 4: Which identifiers and address fields contain nulls, empty strings, or whitespace?
-- Hint: Assess required identity fields separately from descriptive attributes.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 5: Are postal prefixes, city names, and state codes consistently represented?
-- Hint: Postal prefixes are identifiers; investigate numeric storage and source formatting before proposing padding.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 6: Do orders reference existing customers, and which customers have no matching orders?
-- Hint: Examine both relationship directions; missing references and unused master records have different implications.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- ADVANCED: analytical impact and dimensional modelling.
-- Task 7: Do repeated customer_unique_id values have multiple addresses, cities, or states?
-- Hint: Variation may reflect moves or source differences; these columns alone do not establish address-change history.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 8: How would you model repeat-customer identity while preserving the location associated with an order?
-- Hint: Define dimension grain, business key, surrogate key, and unknown-member handling before joining facts.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

