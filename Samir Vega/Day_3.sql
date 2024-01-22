--------------------------------------------------------------DIA_3----------------------------------------------------------
--Versión JOIN_DATE desactualizado
SELECT DISTINCT
    D.CUSTOMER_ID,
    IFNULL(PRODUCT_NAME, 'ninguno') as PRODUCTOS_CONSUMIDOS,
    IFNULL(TO_CHAR(FECHA_DE_CONSUMO), 'nunca') AS FECHA_DE_CONSUMO
FROM (
    SELECT
        MIN(ORDER_DATE) AS FECHA_DE_CONSUMO,
        CUSTOMER_ID
    FROM SALES 
    GROUP BY CUSTOMER_ID) A
LEFT JOIN SALES B
    ON A.CUSTOMER_ID = B.CUSTOMER_ID
    AND A.FECHA_DE_CONSUMO = B.ORDER_DATE
INNER JOIN MENU C
    ON B.PRODUCT_ID = C.PRODUCT_ID
FULL JOIN MEMBERS D
    ON A.CUSTOMER_ID = D.CUSTOMER_ID;

    
--Versión JOIN_DATE actualizado
SELECT DISTINCT
    C.CUSTOMER_ID,
    IFNULL(PRODUCT_NAME, 'ninguno') as PRODUCTOS_CONSUMIDOS,
    CASE
        WHEN PRODUCTOS_CONSUMIDOS = 'ninguno' THEN 'nunca'
        ELSE TO_CHAR(JOIN_DATE)
    END AS FECHA_DE_CONSUMO
FROM SALES A
INNER JOIN MENU B
    ON A.PRODUCT_ID = B.PRODUCT_ID
RIGHT JOIN MEMBERS C
    ON A.CUSTOMER_ID = C.CUSTOMER_ID
    AND A.ORDER_DATE = C.JOIN_DATE;

/*********************************/
/***** COMENTARIO JUAN PEDRO *****/
/*********************************/
/*
Aunque correcto el resultado muy bien aprovechando el cambio de la fecha para sacar con un simple cruce la fecha mínima, piensa que el cliente C pidio dos platos
de ramen y esa información la has perdido con el distinct, el A pidio dos productos en su primer pedido pero al ser distintos no te ha ocurrido esa perdida de 
información.
Otra cosa es la visualización de los datos, tal vez con la función LISTAGG sería visualemtne más correcto pues agurparias en una sola fila cada cliente.
*/
