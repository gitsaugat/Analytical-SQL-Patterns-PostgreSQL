-- Problem:
-- Rank films by revenue within each category.

-- Description:
-- Aggregates revenue per film per category
-- and applies partitioned ranking.

-- Grain:
-- One row per film per category.

-- Concepts:
-- Aggregation, partitioned RANK(), multi-table joins

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
) select 
    * , 
    rank() over(partition by category_name order by film_revenue desc) 
    from total_film_revenue;
