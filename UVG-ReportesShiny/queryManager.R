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

getCantidad_SintomasDummy<-function(){
  
  query <- "select 
               b.descripcion 
              ,count(a.codigo_sintoma) as cantidad
            from 
              sintomas_persona as a 
            inner join tipo_sintoma as b on a.codigo_sintoma = b.codigo_sintoma 
            group by b.descripcion;"
  
  return(query)
}

getCasos_MunicipioDummy<-function(){
  
  query <- "select 
               b.descripcion as pais
              ,c.descripcion as municipio
              ,a.caso_confirmado
              ,count(a.codigo_solicitud) as cantidad_registrados 
            from 
              solicitud as a 
            inner join pais as b on a.codigo_pais = b.codigo_pais 
            inner join municipio as c on a.codigo_municipio = c.codigo_municipio 
            group by b.descripcion,c.descripcion,a.caso_confirmado 
            order by c.descripcion;"
  
  return(query)
}

getCasos_SexoDummy<-function(){
  
  query <- "select 
               case sexo 
                 when 'F' then 'Femenino' 
                 when 'M' then 'Masculino' 
               end as sexo
              ,caso_confirmado
              ,count(codigo_solicitud) as cantidad
            from 
              solicitud 
            group by sexo,caso_confirmado 
            order by sexo;"
  
  return(query)
}

