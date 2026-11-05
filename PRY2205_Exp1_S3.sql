-- CASO 1: ANALISIS DE PROPIEDADES

SELECT
    p.id_tipo_propiedad AS TIPO,

    COUNT(p.nro_propiedad) AS TOTAL_PROPIEDADES,

    '$' || TO_CHAR(
        ROUND(MAX(p.valor_arriendo)),
        'FM999G999G999',
        'NLS_NUMERIC_CHARACTERS='',.'''
    ) AS MAX_ARRIENDO,

    '$' || TO_CHAR(
        ROUND(AVG(p.valor_arriendo)),
        'FM999G999G999',
        'NLS_NUMERIC_CHARACTERS='',.'''
    ) AS PROMEDIO_ARRIENDO,

    '$' || TO_CHAR(
        ROUND(MIN(p.valor_arriendo)),
        'FM999G999G999',
        'NLS_NUMERIC_CHARACTERS='',.'''
    ) AS MIN_ARRIENDO,

    CASE
        WHEN MAX(p.valor_arriendo) > 1000000
            THEN 'PREMIUM'
        ELSE 'ESTANDAR'
    END AS CLASIFICACION,

    '$' || TO_CHAR(
        SUM(NVL(p.valor_gasto_comun, 0)),
        'FM999G999G999',
        'NLS_NUMERIC_CHARACTERS='',.'''
    ) AS TOTAL_GASTOS_COMUNES

FROM propiedad p

GROUP BY p.id_tipo_propiedad

HAVING SUM(NVL(p.valor_gasto_comun, 0))
       > &VALOR_TOTAL_GASTO_COMUN

ORDER BY SUM(NVL(p.valor_gasto_comun, 0)) DESC;


-- CASO 2: ANALISIS DE ANTIGUEDAD DE EMPLEADOS

SELECT
    UPPER(TRIM(e.nombre_emp || ' ' || e.appaterno_emp))
        AS "NOMBRE EMPLEADO",

    REPLACE(
        TO_CHAR(ROUND(NVL(e.sueldo_emp, 0)), 'FM$999G999G999'),
        ',', '.'
    ) AS "SUELDO CON FORMATO",

    CASE
        WHEN NVL(e.sueldo_emp, 0) > 2000000 THEN 'ALTO'
        ELSE 'MEDIO'
    END AS "CLASIFICACION SUELDO",

    TRUNC(MONTHS_BETWEEN(SYSDATE, e.fecing_emp) / 12)
        AS "ANOS ANTIGUEDAD",

    CASE
        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, e.fecing_emp) / 12)
             BETWEEN 5 AND 10
        THEN 'Corresponde bono 5%: ' ||
             REPLACE(TO_CHAR(ROUND(NVL(e.sueldo_emp, 0) * 0.05),
             'FM$999G999G999'), ',', '.')

        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, e.fecing_emp) / 12)
             BETWEEN 11 AND 20
        THEN 'Corresponde bono 10%: ' ||
             REPLACE(TO_CHAR(ROUND(NVL(e.sueldo_emp, 0) * 0.10),
             'FM$999G999G999'), ',', '.')

        WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, e.fecing_emp) / 12) > 20
        THEN 'Corresponde bono 15%: ' ||
             REPLACE(TO_CHAR(ROUND(NVL(e.sueldo_emp, 0) * 0.15),
             'FM$999G999G999'), ',', '.')
    END AS BONO

FROM empleado e

WHERE e.id_categoria_emp = 3
  AND e.id_sucursal <> &CODIGO_SUCURSAL
  AND TRUNC(MONTHS_BETWEEN(SYSDATE, e.fecing_emp) / 12) > 5

ORDER BY e.sueldo_emp DESC;


-- CASO 3: LISTA DE CLIENTES

SELECT
    CASE
        WHEN c.renta_cli >= 1000000 THEN 'PREMIUM'
        WHEN c.renta_cli BETWEEN 600000 AND 999999 THEN 'ALTA'
        WHEN c.renta_cli BETWEEN 300000 AND 599999 THEN 'MEDIA'
        ELSE 'BAJA'
    END AS CLASIFICACION_RENTA,

    COUNT(*) AS CANTIDAD_CLIENTES,

    '$' || TO_CHAR(
        ROUND(AVG(c.renta_cli)),
        'FM999G999G999',
        'NLS_NUMERIC_CHARACTERS='',.'''
    ) AS RENTA_PROMEDIO,

    
    CASE
        WHEN MAX(
            CASE
                WHEN c.celular_cli IS NOT NULL THEN 1
                ELSE 0
            END
        ) = 1
        THEN 'Clientes con Teléfono'
        ELSE 'Clientes Sin Teléfono'
    END AS ESTADO_TELEFONO

FROM cliente c

GROUP BY
    CASE
        WHEN c.renta_cli >= 1000000 THEN 'PREMIUM'
        WHEN c.renta_cli BETWEEN 600000 AND 999999 THEN 'ALTA'
        WHEN c.renta_cli BETWEEN 300000 AND 599999 THEN 'MEDIA'
        ELSE 'BAJA'
    END

HAVING AVG(c.renta_cli) > 200000

ORDER BY
    CASE
        WHEN
            CASE
                WHEN c.renta_cli >= 1000000 THEN 'PREMIUM'
                WHEN c.renta_cli BETWEEN 600000 AND 999999 THEN 'ALTA'
                WHEN c.renta_cli BETWEEN 300000 AND 599999 THEN 'MEDIA'
                ELSE 'BAJA'
            END = 'ALTA' THEN 1
        WHEN
            CASE
                WHEN c.renta_cli >= 1000000 THEN 'PREMIUM'
                WHEN c.renta_cli BETWEEN 600000 AND 999999 THEN 'ALTA'
                WHEN c.renta_cli BETWEEN 300000 AND 599999 THEN 'MEDIA'
                ELSE 'BAJA'
            END = 'MEDIA' THEN 2
        WHEN
            CASE
                WHEN c.renta_cli >= 1000000 THEN 'PREMIUM'
                WHEN c.renta_cli BETWEEN 600000 AND 999999 THEN 'ALTA'
                WHEN c.renta_cli BETWEEN 300000 AND 599999 THEN 'MEDIA'
                ELSE 'BAJA'
            END = 'BAJA' THEN 3
        ELSE 4
    END;

