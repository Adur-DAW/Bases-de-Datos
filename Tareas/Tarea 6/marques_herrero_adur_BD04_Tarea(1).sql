-- Adur Marques Herrero

-- 1 Obtener los nombres y salarios de los empleados con más de 1000 euros de salario por orden alfabético.
select nombre, salario from empleado where salario > 1000 order by nombre;

-- 2 Obtener el nombre de los empleados cuya comisión es superior al 10% de su salario.
select nombre from empleado where (salario * 0.1) > comision;

-- 3 Obtener el código de empleado, código de departamento, nombre y sueldo total en pesetas de aquellos empleados cuyo sueldo total (salario más comisión) supera los 1800 euros. Presentarlos ordenados por código de departamento y dentro de éstos por orden alfabético.
select codEmple, codDpto, nombre, salario from empleado where (salario + comision) > 1800;

-- 4 Obtener por orden alfabético los nombres de empleados cuyo salario igualen o superen en más de un 5% al salario de la empleada ‘MARIA JAZMIN’.
select nombre from empleado where salario >= (select salario + (salario * 0.05) from empleado where nombre = 'MARIA' AND ape1 = 'JAZMIN') order by nombre;

-- 5 Obtener una listado con los nombres y apellidos de los empleados y los años de antigüedad en la empresa ordenados de mayor a menor antigüedad
select nombre, ape1, ape2, fechaIngreso from empleado order by fechaIngreso;

-- 6 Obtener el nombre de los empleados que trabajan en un departamento con presupuesto superior a 50.000 euros.
select nombre from empleado where coddpto in (select coddpto from dpto where presupuesto > 50000);

-- 7 Obtener los nombres y apellidos de empleados que más cobran en la empresa. Considerar el salario más la comisión,
select nombre, ape1, ape2 from empleado order by (salario + comision) desc fetch first 5 rows only;

-- 8 Obtener en orden alfabético los nombres de empleado cuyo salario es inferior al mínimo de los empleados del departamento 1.
select nombre from empleado where salario < (select salario from empleado where coddpto = 1 order by salario fetch first 1 rows only);

--  9 Obtener los nombre de empleados que trabajan en el departamento del cuál es jefe el empleado con código 1.

-- 10 Obtener los nombres de los empleados cuyo primer apellido empiece por las letras p, q, r, s.
select nombre from empleado where ape1 like 'P%' or ape1 like 'Q%' or ape1 like 'R%' or ape1 like 'S%';

-- 11 Obtener los empleados cuyo nombre de pila contenga el nombre JUAN.
select nombre from empleado where nombre = 'JUAN' or ape1 like 'JUAN' or ape2 like 'JUAN';

-- 12 Obtener los nombres de los empleados que viven en ciudades en las que hay algún centro de trabajo
select nombre from empleado where localidad in (select upper(localidad) from centro);

-- 13 Obtener el nombre del jefe de departamento que tiene mayor salario de entre los jefes de departament
select nombre, salario 
from empleado 
where salario = (
    select max(salario) from empleado 
    where codemple in(
        select codemplejefe from dpto
    )
);

-- 14 Obtener en orden alfabético los salarios y nombres de los empleados cuyo salario sea superior al 60% del máximo salario de la empresa.
-- 15 Obtener en cuántas ciudades distintas viven los empleados

-- 16 El nombre y apellidos del empleado que más salario cobra
select nombre, ape1, ape2 
from empleado 
where salario = (
    select max(salario) from empleado
);

-- 17 Obtener las localidades y número de empleados de aquellas en las que viven más de 3 empleados
select localidad, count(*) 
from empleado 
group by localidad;

-- 18 Obtener para cada departamento cuántos empleados trabajan, la suma de sus salarios y la suma de sus comisiones para aquellos dep artamen to en los que hay algún empleado cuyo salario es superior a 2000 euros.
select d.coddpto, d.denominacion, 
count(e.codemple) as empleados,
sum(e.salario) as tot_salario,
sum(e.comision) as tot_comision 
from empleado e 
join dpto d on d.coddpto = e.coddpto
where e.coddpto in(
    select coddpto from empleado where salario > 2000
) group by d.coddpto, d.denominacion;

-- 19 Obtener el departamento que más empleados tiene
select denominacion 
from dpto d 
join empleado e on e.coddpto = d.coddpto 
group by denominacion
having count(*) = all (
    select count (*) from empleado group by coddpto
);

-- 20 Obtener los nombres de todos los centros y los departamentos que se ubican en cada uno,así como aquellos centros que no tienen departamentos.
Select c.codcentro, c.localidad, d.denominacion, d.coddpto 
from dpto d 
join centro c on c.codcentro = d.codcentro;

-- 21 Obtener el nombre del departamento de más alto nivel, es decir, aquel que no depende de ningún otro.
select codcentro, denominacion from dpto where coddptodepende is null;

-- 22 Obtener todos los departamentos existentes en la empresa y los empleados (si los tiene) que pertenecen a él.
select d.coddpto, d.denominacion, e.nombre 
from empleado e 
join dpto d on d.coddpto = e.coddpto;

-- 23 Obtener un listado en el que aparezcan todos los departamentos existentes y el departamento del cual depende,si depende de alguno.
select coddpto, denominacion, 
case 
    when coddptodepende=1 then 'Direccion'
    when coddptodepende=5 then 'Central comercial'
    else 'No depende de otro departamento'
end as departamento 
from dpto;

-- 24 Obtener un listado ordenado alfabéticamente donde aparezcan los nombres de los empleados y a continuación el literal "tiene comisión" si la tiene,y "no tiene comisión" si no la tiene.
select nombre, 
case 
    when comision is null then 'No tiene comisión' 
    else 'Tiene comision'
end as tieneComision 
from empleado 
order by nombre asc;

-- 25 Obtener un listado de las localidades en las que hay centros y no vive ningún empleado ordenado alfabéticamente.
select codcentro, localidad 
from centro 
where upper(localidad) not in(
    select localidad from empleado
) order by codcentro asc;

-- 26 Obtener un listado de las localidades en las que hay centros y además vive al menos un empleado ordenado alfabéticamente.
select nombre, localidad 
from empleado 
where localidad in(
    select upper(localidad) from centro
) order by nombre asc;

-- 27 Esta cuestión puntúa por 3. Se desea dar una gratificación por navidades en función de la antigüedad en la empresa. Obtener un listado de los empleados, ordenado alfabéticamente, indicando cuánto le corresponde de gratificación siguiendo estas pautas:

    -- Si lleva entre 1 y 5 años, se le dará 100 euros
    -- Si lleva entre 6 y 10 años, se le dará 50 euros por año
    -- Si lleva entre 11 y 20 años, se le dará 70 euros por año
    -- Si lleva más de 21 años, se le dará 100 euros por año

-- He simplificado (como de 1 a 5 y mas de 21 es lo mismo, 100€ lo he puesto todo en el ELSE
select nombre, ape1, ape2, trunc(months_between(current_date,fechaingreso) / 12) as duracion, 
case
    when (trunc(months_between(current_date,fechaingreso)/12)) between 6 and 10 then '50 euros' 
    when (trunc(months_between(current_date,fechaingreso)/12)) between 11 and 20 then '70 euros' 
    else '100 euros' 
end as gratificacion from empleado order by nombre asc;

-- 28 Obtener a los nombres, apellidos de los empleados que no son jefes de departamento.
select nombre, ape1, ape2 from empleado where codemple not in (select codemplejefe from dpto);






