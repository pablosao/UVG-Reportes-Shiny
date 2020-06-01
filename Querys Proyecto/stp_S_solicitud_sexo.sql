DROP FUNCTION IF EXISTS stp_s_solicitud_sexo(date, date);
CREATE OR REPLACE FUNCTION stp_S_solicitud_sexo(fecha_inicial date,fecha_final date)
RETURNS TABLE (
	sexo varchar(150),
	cantidad_solicitudes bigint
)
AS $$

--==================================================================
-- Nombre: Pablo Sao
-- Fecha: 16/05/2020
-- Descripcion: Obtención de la cantidad de personas registradas
--    			por sexo
--==================================================================

BEGIN

	-- Creando Tabla temporal con el codigo de sexo
    CREATE TEMP TABLE IF NOT EXISTS temp_sexo AS
    SELECT
         id
        ,description
    FROM
        answers
    WHERE
        code IN ('M','F');



    RETURN QUERY
    SELECT
        b.description AS sexo
        ,count(a.id) AS cantidad_solicitudes
    FROM
        user_answer AS a
    INNER JOIN temp_sexo AS b ON a.id_answer = b.id
    WHERE
        a.report_date BETWEEN fecha_inicial and fecha_final
    GROUP BY  sexo;

	-- Se elimina tabla temporal
    DROP TABLE temp_sexo;

END
$$
LANGUAGE 'plpgsql';