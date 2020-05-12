# Title     : Manejador de Querys
# Objective : manejo de funciones que retornan los querys listos para ejecutarse
#             con los parametros seteados en los filtros
# Created by: Pablo Sao
# Created on: 12/05/2020


getSexo_EstadoPrueba<-function(fecha_inicial,fecha_final){
  # Descripcion:= retorna el query con la fecha en el filtro para retornar la cantidad
  #               de los resultados de los casos vs sexo
  # fecha_inicial:= type Date
  # fecha_final:= type Date
  # Ejemplo:= getSexo_EstadoPrueba('2020-04-01 00:00:00.00','2020-05-31 00:00:00.00')

  query <- sprintf("
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
                            fecha_solicitud BETWEEN '%s'::date AND '%s'::date
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
        ",fecha_inicial,fecha_final)

  return(query)
}
