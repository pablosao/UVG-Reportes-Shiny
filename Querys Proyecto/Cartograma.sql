
BEGIN;
--===========================================================
-- Nombre: Pablo Sao
-- Fecha: 16/05/2020
-- Descripcion: Obtiene departamento y municipio que ha
-- 				registrado el usuario como su domicilio
--===========================================================

    CREATE TEMPORARY TABLE tempDepartamento ON COMMIT DROP AS
    select
         id as codigo_departamento
        ,description as nombre
    from
         answers
    where
        substring(code from 1 for 4) in ('dep_');

    

    CREATE TEMPORARY TABLE tempMunicipio ON COMMIT DROP AS
    select
         id as codigo_municipio
        ,id_father as codigo_departamento
        ,description as nombre
    from
         answers
    where
        substring(code from 1 for 4) in ('mun_');


    select
         'Guatemala' as Pais
        ,c.nombre as Departamento
        ,b.nombre as Municipio
        ,count(a.id) as cantidad_municipio
    from
         user_answer as a
    inner join tempMunicipio as b on a.id_answer = b.codigo_municipio
    inner join tempDepartamento c on b.codigo_departamento = c.codigo_departamento
    group by b.nombre ,c.nombre;


COMMIT;




