

select b.product_name,
        count(a.product_id) as cuenta
    from SQL_EN_LLAMAS.CASE01.SALES a
        left join SQL_EN_LLAMAS.CASE01.MENU b
            on a.product_id=b.product_id
        group by b.product_name
    order by cuenta desc
    limit 1

/*********************************************************/
/***************** COMENTARIO MARÍA *********************/
/*********************************************************/
/* 

Perfecto Jorge!

Como nota, a mí me gusta poner las palabras clave en mayúsculas. Pero bueno, es subjetivo.

*/
