-- Problem:
-- Compute film revenue share and cumulative contribution within category.

-- Description:
-- Calculates total category revenue,
-- percentage share per film,
-- and cumulative revenue distribution (Pareto logic).

-- Grain:
-- One row per film per category.

-- Concepts:
-- Window SUM(), partition totals, cumulative distribution, ranking

with total_film_revenue as (
    select 
        c.name as category_name,
        f.title as film_name, 
        sum(p.amount) as film_revenue
    from film f
        join film_category fc on f.film_id = fc.film_id
        join inventory i on f.film_id = i.film_id
        join rental r on r.inventory_id = i.inventory_id
        join payment p on p.rental_id = r.rental_id
        join category c on fc.category_id = c.category_id
    group by 
        c.category_id,
        f.title
)
select 
    * ,
    SUM(film_revenue) over(partition by category_name) 
                            as total_category_revenue, 
    to_char(round(((film_revenue) / SUM(film_revenue) 
                            over(partition by category_name))*100,2),'99.99 %' )
                            as pct_share,
    rank() over(partition by category_name order by film_revenue desc) 
                            from total_film_revenue;