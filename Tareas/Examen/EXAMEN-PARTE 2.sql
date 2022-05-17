-----------------------------------------------
--------- 2ª EVAL. EXAMEN - 09/05/2022  -------
------------------- PARTE 2 -------------------
-----------------------------------------------
-----------------------------------------------
--- Nombre y apellidos: Adur Marques Herrero
-----------------------------------------------

-- =================================================================================
--   Ejercicio 1 (0,5p)
--   Crea el tipo de objeto Telefono con los atributos: tipo y numero
--   Crea el tipo ListaTelefonos como una lista de máximo 5 numeros de teléfono
-- =================================================================================
CREATE OR REPLACE TYPE Telefono AS OBJECT (
    tipo VARCHAR2(10),
    numero NUMBER
) NOT FINAL;

CREATE TYPE ListaTelefonos AS VARRAY(5) OF Telefono;

-- =================================================================================
--   Ejercicio 2 (0,5p)
--   Crea el tipo de objeto Direccion con los atributos: tipo, via, nombre, numero, ciudad, provincia y codigo postal
--   Crea el tipo ListaDirecciones como una lista de máximo 3 direcciones
-- =================================================================================

CREATE OR REPLACE TYPE Direccion AS OBJECT (
    tipo VARCHAR2(20),
    via VARCHAR2(20),
    nombre VARCHAR2(20),
    ciudad VARCHAR2(20),
    provincia VARCHAR2(20),
    codigoPostal NUMBER
) NOT FINAL;

CREATE TYPE ListaDirecciones AS VARRAY(3) OF Direccion;


-- =================================================================================
--   Ejercicio 3 (0,5p)
--   Crea el tipo de objeto Cliente con los atributos: DNI cliente, nombre de cliente,
--   lista de direcciones y lista de telefonos. 
--   con constructor
--   crea una tabla de clientes cuyo identificador sea el numero de cliente.
-- =================================================================================
CREATE OR REPLACE TYPE Cliente AS OBJECT (
     dni VARCHAR2(40),
     nombre VARCHAR2(40),
     listaDirecciones REF ListaDirecciones,
     listaTelefonos REF ListaTelefonos,

     CONSTRUCTOR FUNCTION Cliente(
        dni VARCHAR2,
        nombre VARCHAR2,
        listaDirecciones ListaDirecciones,
        listaTelefonos ListaTelefonos
     ) RETURN SELF AS RESULT
);
/
CREATE OR REPLACE TYPE BODY Cliente AS
    CONSTRUCTOR FUNCTION Cliente(
        dni VARCHAR2,
        nombre VARCHAR2,
        listaDirecciones ListaDirecciones,
        listaTelefonos ListaTelefonos
    )
    RETURN SELF AS RESULT IS
    BEGIN
         SELF.dni := dni;
         SELF.nombre := nombre;
         SELF.listaDirecciones := listaDirecciones;
         SELF.listaTelefonos := listaTelefonos;
         RETURN;
    END;
END;

CREATE TABLE Clientes OF Cliente (DNI PRIMARY KEY);


-- =================================================================================
--   Ejercicio 4 (1,75p)
--   Utilizando los tipos creados anteriormente, programa un bloque de codigo que inserte dos clientes:
--   A) Cliente 1
--      DNI cliente: 11111111A
--      nombre: Pepe Gomez
--      direccion1: Casa, Calle Caño 68, CP:32720, Esgos (Orense)
--      direccion2: Local, Calle San Sebastián 50, CP:13109, Puebla de Don Rodrigo (Segovia)
--      direccion3: Trabajo Avenida Madrid 128, CP:13001, Segovia (Segovia)
--      telefono1: Casa 988 871 089
--      telefono2: Movil 684 746 272
--      telefono3: Trabajo 921 267 150
--
    INSERT INTO Clientes VALUES (
        Cliente(
            '11111111A',
            'Pepe Gomez',
            ListaDirecciones(
                Direccion('Calle', 'Caño 68', 'Casa', 'Esgos', 'Orense', 32720),
                Direccion('Calle', 'San Sebastián 50', 'Local', 'Puebla de Don Rodrigo', 'Segovia', 13109),
                Direccion('Avenida', 'Madrid 128', 'Trabajo', 'Segovia', 'Segovia', 13001)
            ),
            ListaTelefonos(
                Telefono('Casa', 988871089),
                Telefono('Movil', 684746272),
                Telefono('Trabajo', 921267150)
            )
        )
    );
--   B) Cliente 2
--      numero de cliente: 22222222B
--      nombre: María Fernandez
--      direccion1: Casa, Calle Cuesta del Álamo 90, CP:29491, Algatocín (Ciudad Real)
--      telefono1: Móvil 640 858 435
--      telefono2: Trabajo 926 276 960

    INSERT INTO Clientes VALUES (
        Cliente(
            '22222222B',
            'María Fernandez',
            ListaDirecciones(
                Direccion('Calle', 'Cuesta del Álamo 90', 'Casa', 'Algatocín', 'Ciudad Real', 29491)
            ),
            ListaTelefonos(
                Telefono('Móvil', 640858435),
                Telefono('Trabajo', 926276960)
            )
        ));
-- Muestra los clientes insertados
-- =================================================================================

SELECT * FROM Clientes



