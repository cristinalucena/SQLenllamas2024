-- Dia 1
select 
    'El cliente ' || c.customer_id || ' ha gastado ' || sum(nvl(b.price, 0)) || ' euros.' as Respuesta
from sales a
join menu b
on a.product_id = b.product_id
right join members c
on a.customer_id = c.customer_id
group by c.customer_id
;
