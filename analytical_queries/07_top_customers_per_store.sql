-- Problem:
-- Identify top 3 customers per store by total spending.

-- Description:
-- Aggregates spending per customer per store,
-- then ranks customers within each store partition.

-- Grain:
-- One row per customer per store.

-- Concepts:
-- Partitioned ranking, ROW_NUMBER(), multi-table joins

with customer_spent_per_store as (
    select 
        sum(p.amount) as TotalSpent,
        c.customer_id,
        c.first_name,
        c.last_name,
        sr.store_id,
        a.address
    from 
        payment p 
        join rental r on r.rental_id = p.rental_id
        join staff s on r.staff_id = s.staff_id
        join store sr on sr.store_id = s.store_id 
        join address a on sr.address_id = a.address_id
        join customer c on r.customer_id = c.customer_id

    group by 
        c.customer_id,
        sr.store_id,
        a.address

) select * from(
    select * , 
    ROW_NUMBER() over( partition by store_id order by TotalSpent desc) as RankInStore 
    from customer_spent_per_store
)r  
    where  r.RankInStore <=3 
    order by store_id,RankInStore;