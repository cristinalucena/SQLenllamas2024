/* Day 1
    ¿Cuántos pedidos y cuántas pizzas se han entregado con éxito por cada runner,
    cuál es el porcentaje de éxito de cada runner?
    ¿Qué porcentaje de las pizzas entregadas tenían modificaciones?
*/

USE SQL_EN_LLAMAS;
USE SCHEMA CASE02;

WITH RUNNER_ORDERS_CLEAN AS (
    SELECT
        ORDER_ID,
        RUNNER_ID, 
        DECODE(PICKUP_TIME,'null',NULL,PICKUP_TIME) AS PICKUP_TIME,
        DECODE(DISTANCE,'null',NULL,DISTANCE) AS DISTANCE,
        DECODE(DURATION,'null',NULL,DURATION) AS DURATION, 
        DECODE(CANCELLATION,'null',NULL,'',NULL,CANCELLATION) AS CANCELLATION
    FROM RUNNER_ORDERS
),
CUSTOMER_ORDERS_CLEAN AS (
    SELECT
        ORDER_ID,
        CUSTOMER_ID,
        PIZZA_ID,
        DECODE(EXCLUSIONS,'null',NULL,'',NULL,EXCLUSIONS) AS EXCLUSIONS,
        DECODE(EXTRAS,'null',NULL,'',NULL,EXTRAS) AS EXTRAS,
        ORDER_TIME
    FROM CUSTOMER_ORDERS
),
-- Número de pizzas en cada pedido
PIZZAS_PEDIDO AS (
    SELECT
        ORDER_ID,
        COUNT(PIZZA_ID) AS N_PIZZAS
    FROM CUSTOMER_ORDERS_CLEAN
    GROUP BY ORDER_ID
    ORDER BY ORDER_ID
),
-- Total de pedidos por cada runner
PEDIDOS_TOTALES AS (
    SELECT
        R.RUNNER_ID,
        COUNT(RO.ORDER_ID) AS N_PEDIDOS_TOTALES,
        NVL(SUM(P.N_PIZZAS),0) AS PIZZAS_TOTALES
    FROM PIZZAS_PEDIDO AS P
    RIGHT JOIN RUNNER_ORDERS_CLEAN AS RO
        ON P.ORDER_ID = RO.ORDER_ID
    RIGHT JOIN RUNNERS AS R
        ON RO.RUNNER_ID = R.RUNNER_ID
    GROUP BY R.RUNNER_ID   
),
-- Total de pedidos exitosos de cada runner
PEDIDOS_EXITO AS (
    SELECT
        R.RUNNER_ID,
        COUNT(RO.ORDER_ID) AS N_PEDIDOS_EXITO,
        NVL(SUM(P.N_PIZZAS),0) AS TOTAL_PIZZAS_EXITO
    FROM PIZZAS_PEDIDO AS P
    RIGHT JOIN RUNNER_ORDERS_CLEAN AS RO
        ON P.ORDER_ID = RO.ORDER_ID
    RIGHT JOIN RUNNERS AS R
        ON RO.RUNNER_ID = R.RUNNER_ID
    WHERE PICKUP_TIME IS NOT NULL
    GROUP BY R.RUNNER_ID   
),
-- Número de pizzas modificadas por runner
PIZZAS_MODIFICADAS AS (
    SELECT
        R.RUNNER_ID,
        COUNT(*) AS NUM_PIZZAS_MODIFICADAS
    FROM CUSTOMER_ORDERS_CLEAN AS C
    LEFT JOIN RUNNER_ORDERS_CLEAN AS R
        ON C.ORDER_ID = R.ORDER_ID
    WHERE R.PICKUP_TIME IS NOT NULL AND (EXCLUSIONS IS NOT NULL OR EXTRAS IS NOT NULL)
    GROUP BY R.RUNNER_ID
)

SELECT 
    T.RUNNER_ID,
    NVL(N_PEDIDOS_EXITO,0) AS N_PEDIDOS_EXITO,
    NVL(TOTAL_PIZZAS_EXITO,0) AS TOTAL_PIZZAS_EXITO,
    CAST(N_PEDIDOS_EXITO * 100 / N_PEDIDOS_TOTALES AS NUMBER(5,2)) AS PCT_EXITO_RUNNER, -- al ser porcentaje lo dejo en null
    CAST(NUM_PIZZAS_MODIFICADAS *100 / TOTAL_PIZZAS_EXITO AS NUMBER(5,2)) AS PCT_PIZZAS_MODIFICADAS -- al ser porcentaje lo dejo en null
FROM PEDIDOS_TOTALES AS T
LEFT JOIN PEDIDOS_EXITO AS E
    ON T.RUNNER_ID = E.RUNNER_ID
LEFT JOIN PIZZAS_MODIFICADAS AS P
    ON T.RUNNER_ID = P.RUNNER_ID;

/*********************************************************/
/***************** COMENTARIO ÁNGEL *********************/
/*********************************************************/
/*

Perfecto! Te iba a comentar el tema de controlar los nulos en los % pero veo que has comentado el motivo asi que 0 pegas.

*/
