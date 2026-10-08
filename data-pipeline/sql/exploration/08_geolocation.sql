-- Table: warehouse.raw.olist_geolocation_dataset
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
-- Task 1: What are the row count and distinct postal-prefix count, and what does one source row represent?
-- Hint: A repeated postal prefix may be expected; establish grain before declaring duplicates.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 2: How many exact duplicate rows and repeated coordinate/place combinations exist?
-- Hint: Whole-row duplication differs from several valid observations for one prefix.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 3: Which prefixes, coordinates, cities, and states are missing?
-- Hint: Separate rows usable for geographic mapping from rows usable only for place labels.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- INTERMEDIATE: validity, relationships, and business interpretation.
-- Task 4: Are latitude and longitude within valid ranges and consistent with plausible source geography?
-- Hint: Check global bounds, swapped coordinates, zeroes, and unusual locations; bounds alone do not establish accuracy.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 5: Does a postal prefix map to multiple city or state labels?
-- Hint: Investigate spelling, accents, whitespace, and actual geographic ambiguity before normalizing.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 6: Do customer and seller prefixes have geolocation coverage?
-- Hint: Report both prefix coverage and affected entity counts; they answer different questions.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 7: How much would a direct postal-prefix join increase customer, seller, or item row counts?
-- Hint: Check join cardinality and row-count preservation before using geographic attributes in reporting.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- ADVANCED: analytical impact and dimensional modelling.
-- Task 8: What defensible rule could produce one representative location per prefix?
-- Hint: Compare candidate approaches, document ties and outliers, and avoid arbitrarily selecting a row.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 9: How would a geography dimension express representative coordinates and spatial uncertainty?
-- Hint: Prefix-level coordinates are approximate; precise delivery-distance claims require stronger location evidence.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

