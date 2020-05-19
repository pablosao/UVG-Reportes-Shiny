select
	 b.descripcion
	,count(a.codigo_sintoma)
from
	sintomas_persona as a
inner join tipo_sintoma as b on a.codigo_sintoma = b.codigo_sintoma
group by b.descripcion;
