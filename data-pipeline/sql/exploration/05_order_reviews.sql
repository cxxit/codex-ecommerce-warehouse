-- Table: warehouse.raw.olist_order_reviews_dataset
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
-- Task 1: What is the row count, and how many distinct review and order identifiers exist?
-- Hint: Compare potential grains before selecting a primary key.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 2: Are review_id, (review_id, order_id), or other documented combinations complete and unique?
-- Hint: Treat each as a hypothesis; do not assume a column named ID is globally unique.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 3: Are repeated identifiers exact duplicate rows or distinct scores, comments, and timestamps?
-- Hint: Preserve evidence before designing deduplication or a stable record identity.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- INTERMEDIATE: validity, relationships, and business interpretation.
-- Task 4: Are scores present and within the expected 1-5 scale?
-- Hint: Record the rule's business justification and affected-row proportion.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 5: How often are titles and messages null, empty, or whitespace, and how does this vary by score?
-- Hint: Optional comments need not indicate invalid reviews; avoid confusing completeness with review validity.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 6: Can both review timestamps be parsed, and does the answer precede creation?
-- Hint: Verify timestamp meanings and quantify chronology exceptions.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 7: Do reviews resolve to orders, and how do review timing and coverage vary by delivery status?
-- Hint: A review before delivery requires interpretation rather than automatic exclusion.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- ADVANCED: analytical impact and dimensional modelling.
-- Task 8: Which orders have multiple reviews, and how do review-weighted and order-weighted score summaries differ?
-- Hint: State the averaging unit and denominator; review coverage can bias comparisons.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 9: How would a review fact retain source records while supporting order and product analysis?
-- Hint: Joining an order review to all its items changes weighting and does not prove product-specific attribution.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

