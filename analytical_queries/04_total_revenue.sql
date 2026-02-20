-- Problem:
-- Compute total revenue across all time.

-- Description:
-- Aggregates full payment table to derive total revenue.
-- Demonstrates simple global aggregation.

-- Grain:
-- Single row representing entire dataset.

-- Concepts:
-- SUM(), aggregation

SELECT 
    TO_CHAR(SUM(amount),'$99999999.99') 
from payment;