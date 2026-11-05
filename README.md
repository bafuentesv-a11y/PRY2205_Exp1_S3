# PRY2205 – Actividad Sumativa Semana 3
## Aplicando funciones de agrupación SQL

### Descripción del proyecto

Este repositorio contiene el desarrollo de la actividad sumativa de la asignatura **Consulta de Bases de Datos**, correspondiente a la Semana 3.

El objetivo es resolver distintos requerimientos de información mediante sentencias SQL en Oracle, aplicando funciones de una fila, funciones de grupo, agrupaciones, condiciones y ordenamiento de datos.

### Objetivos

- Aplicar funciones SQL para procesar y presentar información.
- Utilizar funciones de agrupación como `COUNT`, `MAX`, `MIN`, `AVG` y `SUM`.
- Implementar condiciones mediante `CASE`.
- Filtrar resultados utilizando `WHERE` y `HAVING`.
- Aplicar variables de sustitución para obtener información parametrizada.
- Presentar resultados con formatos específicos.

### Casos desarrollados

**Caso 1: Análisis de propiedades**

Genera un informe agrupado por tipo de propiedad que presenta:

- Cantidad de propiedades.
- Valor máximo, mínimo y promedio de arriendo.
- Clasificación del arriendo: ESTÁNDAR o PREMIUM.
- Total de gastos comunes por tipo de propiedad.

Se utiliza la variable de sustitución `VALOR_TOTAL_GASTO_COMUN`.

**Caso 2: Análisis de antigüedad de empleados**

Genera un informe de empleados pertenecientes a la categoría Ejecutivo de Arriendo, considerando su antigüedad y excluyendo una sucursal determinada.

Incluye:

- Nombre del empleado.
- Sueldo y clasificación salarial.
- Años de antigüedad.
- Cálculo del bono correspondiente según años de servicio.

Se utiliza la variable de sustitución `CODIGO_SUCURSAL`.

**Caso 3: Lista de clientes**

Clasifica a los clientes según su renta y presenta:

- Clasificación de renta: PREMIUM, ALTA, MEDIA o BAJA.
- Cantidad de clientes por clasificación.
- Renta promedio.
- Estado de disponibilidad de teléfono de los clientes.

Se consideran únicamente los grupos cuyo promedio de renta supera los $200.000.

### Herramientas utilizadas

- Oracle Database.
- Oracle Database Actions (SQL Worksheet).
- SQL / Oracle SQL.
- GitHub para el control y almacenamiento del proyecto.

### Ejecución

1. Conectarse a la base de datos Oracle correspondiente.
2. Ejecutar previamente el script de creación y poblamiento del esquema.
3. Abrir el archivo SQL de la actividad.
4. Ejecutar las sentencias correspondientes a cada caso.
5. Ingresar los valores solicitados cuando se presenten las variables de sustitución.


**Institución:** Duoc UC  
**Año:** 2026
