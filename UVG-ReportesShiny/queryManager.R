# Title     : Manejador de Querys
# Objective : manejo de funciones que retornan los querys listos para ejecutarse
#             con los parametros seteados en los filtros
# Created by: Pablo Sao
# Created on: 12/05/2020


getCantidad_Sintomas<-function(fecha_inicial,fecha_final){
  # Descripcion:= retorna el query con la fecha en el filtro para retornar la cantidad
  #               de sintomas reportados
  # fecha_inicial:= type Date
  # fecha_final:= type Date
  # Ejemplo:= getCantidad_Sintomas('2020-04-01','2020-05-31')
  
  query <- sprintf("select               
                    	b.descripcion              
                    	,count(a.codigo_sintoma) as cantidad
                    from
                    	sintomas_persona as a
                    inner join tipo_sintoma as b on a.codigo_sintoma = b.codigo_sintoma
                    inner join solicitud as c on a.codigo_solicitud = c.codigo_solicitud
                    WHERE
                    c.fecha_solicitud BETWEEN '%s'::date AND '%s'::date
                    group by b.descripcion;",fecha_inicial,fecha_final)
  
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

