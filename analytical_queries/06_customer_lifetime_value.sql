-- Problem:
-- Calculate customer lifetime value (LTV).

-- Description:
-- Computes first rental date, last rental date,
-- and total spending per customer.

-- Grain:
-- One row per customer.

-- Concepts:
-- Aggregation, MIN(), MAX(), SUM(), multi-table joins

with customer_lifetime as (
	SELECT 
	    r.customer_id,
	    MIN(lower(r.rental_period)) AS first_rental_date,
	    MAX(lower(r.rental_period)) AS last_rental_date,
	    SUM(p.amount) AS total_spent
	FROM rental r
	JOIN payment p 
	    ON p.rental_id = r.rental_id
	GROUP BY 
        r.customer_id
	ORDER BY 
        r.customer_id
) select 
	cl.customer_id,
	c.first_name,
	c.last_name,
	cl.first_rental_date,
	cl.last_Rental_date,
	cl.total_spent
from customer_lifetime cl join customer c 
on c.customer_id = cl.customer_id
order by 
    cl.total_spent;