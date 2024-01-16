-- ¿Cuánto ha gastado en total cada cliente en el restaurante? -- 
SELECT 
     MEMBERS.CUSTOMER_ID
    ,IFNULL(SUM(MENU.PRICE),0) AS TOTAL_GASTADO
FROM CASE01.SALES
INNER JOIN CASE01.MENU
        ON SALES.PRODUCT_ID = MENU.PRODUCT_ID
FULL JOIN CASE01.MEMBERS 
        ON SALES.CUSTOMER_ID = MEMBERS.CUSTOMER_ID
GROUP BY MEMBERS.CUSTOMER_ID;
