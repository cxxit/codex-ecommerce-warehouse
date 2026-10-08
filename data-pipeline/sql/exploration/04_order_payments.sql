-- Table: warehouse.raw.olist_order_payments_dataset
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
-- Task 1: What is the row count, and is (order_id, payment_sequential) a complete, unique candidate key?
-- Hint: A payment sequence belongs to an order; validate the proposed scope of uniqueness.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 2: Are duplicate keys identical or conflicting, and are sequences positive or discontinuous?
-- Hint: Sequence gaps need evidence before being labelled lost payments.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 3: Which payment types occur, including missing or blank values?
-- Hint: Establish the observed domain and investigate its meaning before enforcing rules.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- INTERMEDIATE: validity, relationships, and business interpretation.
-- Task 4: Are payment_installments missing, zero, negative, or unusual for particular payment types?
-- Hint: Validate by payment method; one universal installment rule may be inappropriate.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 5: Are payment values missing, negative, zero, or extreme?
-- Hint: Separate validity rules from distribution-based anomaly detection; document floating-point tolerance.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 6: Do all payments resolve to orders, and which orders have multiple payment records or methods?
-- Hint: Split payments can be legitimate; payment-record count is not order count.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 7: Do summed payments reconcile with item price plus freight at order grain?
-- Hint: Aggregate each side independently, include unmatched orders, and explain the comparison population.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- ADVANCED: analytical impact and dimensional modelling.
-- Task 8: Does multiplying payment_value by installments have a justified business meaning?
-- Hint: Verify source semantics; an installment count does not establish that recorded value is per installment.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

-- Task 9: How should a payment fact support payment-method analysis without overstating order counts or product sales?
-- Hint: Define payment grain and distinct-order measures; product-level allocation requires an explicit policy.




-- Evidence and interpretation:
-- Check date / dataset version / source filename:
-- Expected result and justification:
-- Observed result / affected rows / denominator:
-- Severity / analytical impact:
-- Proposed staging treatment / future automated test:

