SELECT TOP 1 A.product_name AS PRODUCTO,
COUNT(B.product_id) VECES_PEDIDO
FROM SQL_EN_LLAMAS.CASE01.MENU A
LEFT JOIN SQL_EN_LLAMAS.CASE01.SALES B
ON A.product_id=B.product_id
GROUP BY 1
ORDER BY 2 DESC
