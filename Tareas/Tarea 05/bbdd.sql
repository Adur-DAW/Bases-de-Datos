-- Ejercicio 2
INSERT INTO departamentos (IDDEPARTAMENTO, Nombre, Usuario, Ubicacion, Fecha_Crea, Presupuesto) VALUES ('DED', 'Empresa y Desarrollo Económico', 'IDP06', 'P2-01', '04/06/1983', 6000);
INSERT INTO departamentos (IDDEPARTAMENTO, Nombre, Ubicacion, Presupuesto) VALUES ('IIT', 'Ingeniería y Telecomunicación', 'P1-03', 4000);
INSERT INTO departamentos (IDDEPARTAMENTO, Nombre, Usuario, Ubicacion, Presupuesto) VALUES ('DLM', 'Lenguas Modernas', 'IDP04', 'P2-02', 3300);
INSERT INTO departamentos (IDDEPARTAMENTO, Nombre, Usuario, Ubicacion, Fecha_Crea, Presupuesto) VALUES ('DCF', 'Ciencias Físicas', 'IDP03', 'P0-02', '23/02/1981', 1200);
INSERT INTO departamentos (IDDEPARTAMENTO, Nombre, Usuario, Ubicacion, Presupuesto) VALUES ('DEI', 'Estadística e Informática', 'IDP02', 'P1-01', 1200);
INSERT INTO departamentos (IDDEPARTAMENTO, Nombre, Ubicacion, Fecha_Crea, Presupuesto) VALUES ('DCE', 'Ciencias Exactas', 'P0-01', '25/02/1985', 1200);

-- Ejercicio 4
UPDATE departamentos SET presupuesto = presupuesto - 150 WHERE presupuesto > 3200;
SELECT nombre, presupuesto FROM departamentos;

-- Ejercicio 5
DELETE profesores WHERE apellido2 = 'Membibre' AND horas = 6;
SELECT * FROM profesores WHERE apellido2 = 'Membibre' AND horas = 6;

-- Ejercicio 6
SELECT count(IdProfesor) FROM profesores;

INSERT INTO profesores (Apellido1, Apellido2, Nombre_pila, Categoria, Dedicacion, Horas)
SELECT Apellido1, Apellido2, Nombre_pila, Categoria, Dedicacion, Horas FROM becarios WHERE dedicacion = '6 h';

SELECT count(IdProfesor) FROM profesores;

-- Ejercicio 8
INSERT INTO departamentos (IDDepartamento, Nombre, Ubicacion) VALUES ('CIS', 'Ciencias de la salud', 'P1-04');
INSERT INTO areas (IdArea, Nombre, Departamento) VALUES ('FTE', 'Fisioterapia', 'CIS');
INSERT INTO profesores (Apellido1, Apellido2, Nombre_pila, Area) VALUES ('Virto', 'Manero', 'Amaya', 'FTE');

-- SELECT * FROM profesores WHERE DE = 'CIS'

-- Ejercicio 9
UPDATE profesores SET Area = 'CIA', Horas = 10 WHERE Area IS NULL;
SELECT * FROM profesores WHERE Area = 'CIA' AND Horas = 10;

-- Ejercicio 10
DELETE profesores WHERE idProfesor IN 
(
    SELECT idProfesor FROM profesores pr   
    INNER JOIN areas ar ON ar.IdArea = pr.Area
    INNER JOIN departamentos de ON de.idDepartamento = ar.Departamento
    WHERE de.ubicacion LIKE 'PI-%'
);

SELECT COUNT(*) FROM profesores;

-- Ejercicio 11

-- Sin Hacer : )