SELECT
	 sexo
	,CASE WHEN positivo IS NULL
		THEN 0
		ELSE positivo
	END AS Positivo
	,CASE WHEN negativo IS NULL
		THEN 0
		ELSE negativo
	END AS Negativo
FROM
	crosstab(
			$$SELECT
				 CASE sexo
					WHEN 'F' THEN 'Femenino' 
					WHEN 'M' THEN 'Masculino'
				 END AS sexo		 
				,CASE caso_confirmado
					WHEN true THEN 'Positivo'
					WHEN false THEN 'Negativo'
				 END AS caso_confirmado
				,COUNT(codigo_solicitud) AS cantidad
			FROM 
				solicitud
			WHERE
				fecha_solicitud BETWEEN '2020-04-01 00:00:00.00'::date AND '2020-06-01 00:00:00.00'::date
			GROUP BY sexo,caso_confirmado
			ORDER BY sexo
			$$,
			$$SELECT 'Positivo' AS descripcion
			UNION ALL
			SELECT 'Negativo' AS descripcion
			$$	
			)
	AS final_result( Sexo TEXT
					,Positivo  bigint
					,Negativo bigint
					);