-- Problem:
-- Compute total revenue per month.

-- Description:
-- Aggregates payments at monthly level using DATE_TRUNC.
-- Demonstrates time-based aggregation.

-- Grain:
-- One row per month.

-- Concepts:
-- DATE_TRUNC, aggregation, temporal grouping

select 
    DATE_TRUNC('month',payment_date) as Month, 
    TO_CHAR(sum(amount),'$999999.99') as "Monthly RR" 
FROM PAYMENT 
GROUP BY 
    Month 
ORDER BY 
    Month ASC
;
