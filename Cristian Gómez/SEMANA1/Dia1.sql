SELECT 
    C.CUSTOMER_ID as CLIENTE,
    CASE 
        WHEN SUM(M.PRICE) IS NULL THEN 0  
        ELSE SUM(M.PRICE) 
    END AS GASTO_TOTAL_CLIENTE
FROM MEMBERS C
LEFT JOIN SALES S
    ON C.CUSTOMER_ID = S.CUSTOMER_ID
LEFT JOIN MENU M
    ON S.PRODUCT_ID = M.PRODUCT_ID
GROUP BY 1 
ORDER BY 1 ASC

/*********************************************************/
/***************** COMENTARIO ÁNGEL *********************/
/*********************************************************/
/*

El resultado es correcto, aunque simplificaria el CASE en un IFNULL.

SELECT 
    C.CUSTOMER_ID as CLIENTE,
    SUM(IFNULL(M.PRICE, 0)) AS GASTO_TOTAL_CLIENTE
FROM MEMBERS C
LEFT JOIN SALES S
    ON C.CUSTOMER_ID = S.CUSTOMER_ID
LEFT JOIN MENU M
    ON S.PRODUCT_ID = M.PRODUCT_ID
GROUP BY 1 
ORDER BY 1 ASC;

*/
