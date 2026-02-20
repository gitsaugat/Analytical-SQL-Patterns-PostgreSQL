-- Problem:
-- Detect customers whose spending increased for 3 consecutive rentals.

-- Description:
-- Uses window functions to compare sequential rental payments
-- and detect increasing patterns over time.

-- Grain:
-- One row per rental transaction (before filtering).

-- Concepts:
-- LAG(), partitioning, sequential pattern detection
with base_dataset as (
    select 
        r.customer_id,
        c.first_name,
        c.last_name,
        p.rental_id,
        lower(r.rental_period) as rental_date,
        p.amount
    from 
    payment p 
        join rental r on p.rental_id = r.rental_id
        join customer c on c.customer_id = r.customer_id
) ,lagged as (
        select * , 
            lag(amount,1) over(partition by customer_id order by rental_date) as prevamt ,
            lag(amount,2) over(partition by customer_id order by rental_date)  as prev2amt
        from base_dataset
)
 select 
 distinct customer_id ,
	 first_name,
	 last_name , 
	 prev2amt as "Month1" ,
	 prevamt as  "Month2 ",
	 amount as "Month3" 
 from lagged where 
 prev2amt < prevamt and prevamt < amount;