-- ¿Cuántos días ha visitado el restaurante cada cliente?
SELECT 
    MEMBERS.CUSTOMER_ID AS CLIENTE
   ,COUNT(DISTINCT ORDER_DATE) AS DIAS_VISITADOS
FROM CASE01.SALES
RIGHT JOIN CASE01.MEMBERS
       ON SALES.CUSTOMER_ID = MEMBERS.CUSTOMER_ID       
GROUP BY MEMBERS.CUSTOMER_ID;

/*********************************/
/***** COMENTARIO JUAN PEDRO *****/
/*********************************/
/*
¡Todo correcto enhorabuena!
*/
