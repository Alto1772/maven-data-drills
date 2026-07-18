with recursive tr as (
select
    transaction_id, product_name, quantity, 1 as cur_row
from grocery_transactions
union all
select
    transaction_id, product_name, quantity, cur_row + 1
from tr
where cur_row <= quantity
), pairs as (
select distinct
    tr1.transaction_id, tr1.product_name as product1, tr2.product_name as product2
from tr tr1
join tr tr2
    on tr1.transaction_id = tr2.transaction_id
    and tr1.product_name < tr2.product_name
)
select product1, product2, count(*) as count
from pairs
group by product1, product2
order by count desc