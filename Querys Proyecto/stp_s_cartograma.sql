DROP FUNCTION IF EXISTS stp_s_cartograma(date, date);
CREATE OR REPLACE FUNCTION stp_s_cartograma(fecha_inicial date,fecha_final date)
RETURNS TABLE (
	pais varchar(175),
	departamento varchar(175),
	municipio varchar(175),
	cantidad_solicitudes bigint
)
AS $$

--===========================================================
-- Nombre: Pablo Sao
-- Fecha: 16/05/2020
-- Descripcion: Obtiene departamento y municipio que ha
-- 				registrado el usuario como su domicilio
--===========================================================

BEGIN

	-- Obteniendo los codigos de departamento
	CREATE TEMP TABLE IF NOT EXISTS tempDepartamento AS
    SELECT
         id as codigo_departamento
        ,description AS nombre
    FROM
         answers
    WHERE
        substring(code FROM 1 FOR 4) IN ('dep_');

	-- Obteniendo los codigos de los municipios
    CREATE TEMP TABLE IF NOT EXISTS tempMunicipio AS
    SELECT
         id AS codigo_municipio
        ,id_father AS codigo_departamento
        ,description AS nombre
    FROM
         answers
    WHERE
        substring(code FROM 1 FOR 4) IN ('mun_');


	RETURN QUERY
    SELECT
         'Guatemala'::varchar AS pais
        ,c.nombre AS departamento
        ,b.nombre AS municipio
        ,count(a.id) AS cantidad_solicitudes
    FROM
         user_answer AS a
    INNER JOIN tempMunicipio AS b ON a.id_answer = b.codigo_municipio
    INNER JOIN tempDepartamento AS c ON b.codigo_departamento = c.codigo_departamento
	WHERE
        a.report_date BETWEEN fecha_inicial and fecha_final
    GROUP BY b.nombre ,c.nombre;

	-- Se eliminan tablas temporales
    DROP TABLE tempDepartamento;
	DROP TABLE tempMunicipio;

END
$$
LANGUAGE 'plpgsql';