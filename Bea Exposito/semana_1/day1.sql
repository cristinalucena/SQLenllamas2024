SELECT sales.customer_id, SUM(menu.price) as total_gastado
FROM case1.sales
INNER JOIN case1.menu 
ON sales.product_id = menu.product_id
GROUP BY sales.customer_id