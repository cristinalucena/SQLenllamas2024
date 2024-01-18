//Día 2: ¿Cuántos días ha visitado el restaurante cada cliente?
select sales.customer_id as Clientes, count(sales.order_date) as Cantidad_de_dias
from case01.sales
group by sales.customer_id;


/*********************************************************/
/***************** COMENTARIO MARÍA *********************/
/*********************************************************/

/* 

Nos encontramos en el mismo caSso que el día 01. ¿Y si Josep considera la tabla de members como tabla maestra de clientes?

En ese caso estamos filtrando información, en concreto, el cliente D, que aunque no haya hecho ninguna compra, forma parte del conjunto de datos.

Te propongo, añadir como base (FROM) la tabla de members, y a través de LEFT JOIN añadir el resto de tablas, el uso de LEFT JOIN en vez de INNER JOIN es simplemente
para  asegurarnos de traer clientes que no tengan pedidos. Cuando se tienen modelos tan sencillos con 3 clientes y no más de 10 pedidos, es fácil ver a ojo si algo no cruza, 
pero cuando contamos con millones de registros debemos hacer uso de LEFT JOIN o RIGHT JOIN.

Por otro lado, no es del todo correcto los días que muestras. 
¿Por qué? estás sumando días de más al cliente cuando en un mismo día hace distintos pedidos. Añade un DISTINCT a tu conteo y PERFECTO!

*/
