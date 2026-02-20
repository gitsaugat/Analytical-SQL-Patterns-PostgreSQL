-- Problem:
-- Extract rental start and end timestamps for each customer.

-- Description:
-- Retrieves rental period boundaries using PostgreSQL range functions.
-- Demonstrates handling of tsrange and temporal data extraction.

-- Grain:
-- One row per rental transaction.

-- Concepts:
-- Range types (tsrange), lower(), upper(), joins

SELECT 
    lower(r.rental_period) as "Rental Start" ,
    upper(r.rental_period) as "Rental End" ,
c.customer_id FROM customer c
inner join rental r
    ON c.customer_id = r.customer_id;