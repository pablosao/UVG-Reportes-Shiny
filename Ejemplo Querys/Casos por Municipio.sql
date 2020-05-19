select 
	 b.descripcion as pais
	,c.descripcion as municipio
	,a.caso_confirmado
	,count(a.codigo_solicitud) as cantidad_registrados
from 
	solicitud as a
inner join pais as b on a.codigo_pais = b.codigo_pais
inner join municipio as c on a.codigo_municipio = c.codigo_municipio

group by b.descripcion,c.descripcion,a.caso_confirmado
order by c.descripcion;