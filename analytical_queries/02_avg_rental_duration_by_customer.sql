-- Problem:
-- Calculate average rental duration per customer.

-- Description:
-- Computes average rental duration using timestamp range arithmetic.
-- Demonstrates aggregation discipline and proper grouping.

-- Grain:
-- One row per customer.

-- Concepts:
-- Aggregation, GROUP BY, interval arithmetic

SELECT 
    rental.customer_id,
    customer.first_name,
    customer.last_name,
    avg(upper(rental.rental_period) - lower(rental.rental_period)) as "Average Duration"
from rental
inner join customer 
    on customer.customer_id = rental.customer_id 
group by 
    rental.customer_id , 
    customer.first_name , 
    customer.last_name;
