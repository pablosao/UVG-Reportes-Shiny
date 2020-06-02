DROP FUNCTION IF EXISTS stp_s_sintomas_reportados(date, date);
CREATE OR REPLACE FUNCTION stp_s_sintomas_reportados(fecha_inicial date,fecha_final date)
RETURNS TABLE (
	sintoma varchar(180),
	cantidad_reportada bigint
)
AS $$

--===========================================================
-- Nombre: Pablo Sao
-- Fecha: 01/06/2020
-- Descripcion: Obtención de los sintomas reportados como
-- 				presentes (SI) en las personas registradas
--===========================================================

BEGIN
	RETURN QUERY
	SELECT
		 tmp.sintoma
		,COUNT(tmp.id_user) as cantidad_reportada
	FROM
	     (
	        SELECT
                b.title AS sintoma
                ,a.id_user
            FROM
                user_answer as a
            INNER JOIN questions b ON a.id_questions = b.id
            WHERE
                -- Seleccionamos las respuestas marcadas como SI, correspondientes al codigo 3
                a.id_answer = 3
            -- Seleccionando sintomas registrados.
            AND b.id IN (47,48,49,50,51,52,53,54,55,56,57,58,59,60,61)
            AND a.report_date BETWEEN fecha_inicial and fecha_final
            GROUP BY b.title,a.id_user
            ORDER BY b.title

             ) as tmp
	GROUP BY tmp.sintoma;
END
$$
LANGUAGE 'plpgsql';