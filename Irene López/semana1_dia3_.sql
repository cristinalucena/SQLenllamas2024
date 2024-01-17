-- ¿Cuál es el primer producto que ha pedido cada cliente?

WITH CTE AS(
    SELECT
          DISTINCT ME.CUSTOMER_ID CLIENTE
        , M.PRODUCT_NAME 
        , S.ORDER_DATE 
        , ROW_NUMBER() OVER(PARTITION BY ME.CUSTOMER_ID ORDER BY S.ORDER_DATE) AS SEQ
    FROM SALES S
        JOIN MENU M
            ON S.PRODUCT_ID = M.PRODUCT_ID
        FULL JOIN MEMBERS ME
            ON ME.CUSTOMER_ID = S.CUSTOMER_ID
    ORDER BY CLIENTE,SEQ
) 

SELECT 
     CLIENTE
    , IFNULL(PRODUCT_NAME,'No ha pedido nada aún') AS "PRIMER PRODUCTO QUE HA PEDIDO"
FROM CTE
WHERE SEQ = 1
;
