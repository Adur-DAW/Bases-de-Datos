-- Adur Marques Herrero

-- 1 Obtener los nombres y salarios de los empleados con m�s de 1000 euros de salario por orden alfab�tico.
select nombre, salario from empleado where salario > 1000 order by nombre;

-- 2 Obtener el nombre de los empleados cuya comisi�n es superior al 10% de su salario.
select nombre from empleado where (salario * 0.1) > comision;

-- 3 Obtener el c�digo de empleado, c�digo de departamento, nombre y sueldo total en pesetas de aquellos empleados cuyo sueldo total (salario m�s comisi�n) supera los 1800 euros. Presentarlos ordenados por c�digo de departamento y dentro de �stos por orden alfab�tico.
select codEmple, codDpto, nombre, salario from empleado where (salario + comision) > 1800;

-- 4 Obtener por orden alfab�tico los nombres de empleados cuyo salario igualen o superen en m�s de un 5% al salario de la empleada �MARIA JAZMIN�.
select nombre from empleado where salario >= (select salario + (salario * 0.05) from empleado where nombre = 'MARIA' AND ape1 = 'JAZMIN') order by nombre;

-- 5 Obtener una listado con los nombres y apellidos de los empleados y los a�os de antig�edad en la empresa ordenados de mayor a menor antig�edad
select nombre, ape1, ape2, fechaIngreso from empleado order by fechaIngreso;

-- 6 Obtener el nombre de los empleados que trabajan en un departamento con presupuesto superior a 50.000 euros.
select nombre from empleado where coddpto in (select coddpto from dpto where presupuesto > 50000);

-- 7 Obtener los nombres y apellidos de empleados que m�s cobran en la empresa. Considerar el salario m�s la comisi�n,
select nombre, ape1, ape2 from empleado order by (salario + comision) desc fetch first 5 rows only;

-- 8 Obtener en orden alfab�tico los nombres de empleado cuyo salario es inferior al m�nimo de los empleados del departamento 1.
select nombre from empleado where salario < (select salario from empleado where coddpto = 1 order by salario fetch first 1 rows only);

--  9 Obtener los nombre de empleados que trabajan en el departamento del cu�l es jefe el empleado con c�digo 1.

-- 10 Obtener los nombres de los empleados cuyo primer apellido empiece por las letras p, q, r, s.
select nombre from empleado where ape1 like 'P%' or ape1 like 'Q%' or ape1 like 'R%' or ape1 like 'S%';

-- 11 Obtener los empleados cuyo nombre de pila contenga el nombre JUAN.
select nombre from empleado where nombre = 'JUAN' or ape1 like 'JUAN' or ape2 like 'JUAN';

-- 12 Obtener los nombres de los empleados que viven en ciudades en las que hay alg�n centro de trabajo
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

-- 14 Obtener en orden alfab�tico los salarios y nombres de los empleados cuyo salario sea superior al 60% del m�ximo salario de la empresa.
-- 15 Obtener en cu�ntas ciudades distintas viven los empleados

-- 16 El nombre y apellidos del empleado que m�s salario cobra
select nombre, ape1, ape2 
from empleado 
where salario = (
    select max(salario) from empleado
);

-- 17 Obtener las localidades y n�mero de empleados de aquellas en las que viven m�s de 3 empleados
select localidad, count(*) 
from empleado 
group by localidad;

-- 18 Obtener para cada departamento cu�ntos empleados trabajan, la suma de sus salarios y la suma de sus comisiones para aquellos dep artamen to en los que hay alg�n empleado cuyo salario es superior a 2000 euros.
select d.coddpto, d.denominacion, 
count(e.codemple) as empleados,
sum(e.salario) as tot_salario,
sum(e.comision) as tot_comision 
from empleado e 
join dpto d on d.coddpto = e.coddpto
where e.coddpto in(
    select coddpto from empleado where salario > 2000
) group by d.coddpto, d.denominacion;

-- 19 Obtener el departamento que m�s empleados tiene
select denominacion 
from dpto d 
join empleado e on e.coddpto = d.coddpto 
group by denominacion
having count(*) = all (
    select count (*) from empleado group by coddpto
);

-- 20 Obtener los nombres de todos los centros y los departamentos que se ubican en cada uno,as� como aquellos centros que no tienen departamentos.
Select c.codcentro, c.localidad, d.denominacion, d.coddpto 
from dpto d 
join centro c on c.codcentro = d.codcentro;

-- 21 Obtener el nombre del departamento de m�s alto nivel, es decir, aquel que no depende de ning�n otro.
select codcentro, denominacion from dpto where coddptodepende is null;

-- 22 Obtener todos los departamentos existentes en la empresa y los empleados (si los tiene) que pertenecen a �l.
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

-- 24 Obtener un listado ordenado alfab�ticamente donde aparezcan los nombres de los empleados y a continuaci�n el literal "tiene comisi�n" si la tiene,y "no tiene comisi�n" si no la tiene.
select nombre, 
case 
    when comision is null then 'No tiene comisi�n' 
    else 'Tiene comision'
end as tieneComision 
from empleado 
order by nombre asc;

-- 25 Obtener un listado de las localidades en las que hay centros y no vive ning�n empleado ordenado alfab�ticamente.
select codcentro, localidad 
from centro 
where upper(localidad) not in(
    select localidad from empleado
) order by codcentro asc;

-- 26 Obtener un listado de las localidades en las que hay centros y adem�s vive al menos un empleado ordenado alfab�ticamente.
select nombre, localidad 
from empleado 
where localidad in(
    select upper(localidad) from centro
) order by nombre asc;

-- 27 Esta cuesti�n punt�a por 3. Se desea dar una gratificaci�n por navidades en funci�n de la antig�edad en la empresa. Obtener un listado de los empleados, ordenado alfab�ticamente, indicando cu�nto le corresponde de gratificaci�n siguiendo estas pautas:

    -- Si lleva entre 1 y 5 a�os, se le dar� 100 euros
    -- Si lleva entre 6 y 10 a�os, se le dar� 50 euros por a�o
    -- Si lleva entre 11 y 20 a�os, se le dar� 70 euros por a�o
    -- Si lleva m�s de 21 a�os, se le dar� 100 euros por a�o

-- He simplificado (como de 1 a 5 y mas de 21 es lo mismo, 100� lo he puesto todo en el ELSE
select nombre, ape1, ape2, trunc(months_between(current_date,fechaingreso) / 12) as duracion, 
case
    when (trunc(months_between(current_date,fechaingreso)/12)) between 6 and 10 then '50 euros' 
    when (trunc(months_between(current_date,fechaingreso)/12)) between 11 and 20 then '70 euros' 
    else '100 euros' 
end as gratificacion from empleado order by nombre asc;

-- 28 Obtener a los nombres, apellidos de los empleados que no son jefes de departamento.
select nombre, ape1, ape2 from empleado where codemple not in (select codemplejefe from dpto);






