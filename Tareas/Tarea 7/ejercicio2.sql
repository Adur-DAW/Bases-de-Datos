/* 2. Crea, como tipo heredado de Personal, el tipo de objeto Responsable con sus atributos
y que contenga:
- Método constructor en el que se indiquen como parámetros el código, nombre, primer apellido,
segundo apellido y tipo. Este método debe asignar al atributo apellidos los datos de primer
apellido y segundo apellido que se han pasado como parámetros, uniéndolos con un espacio entre ellos.
- Método getNombreCompleto que permita obtener su nombre completo con el formato apellidos nombre
*/

CREATE OR REPLACE TYPE Responsable UNDER Personal (
    tipo CHAR,
    antiguedad INTEGER,

    CONSTRUCTOR FUNCTION Responsable(
        codigo INTEGER,
        nombre VARCHAR2,
        apellido1 VARCHAR2,
        apellido2 VARCHAR2,
        tipo CHAR
    ) RETURN SELF AS RESULT,

    MEMBER FUNCTION getNombreCompleto RETURN VARCHAR2
);

CREATE OR REPLACE TYPE BODY Responsable AS
    CONSTRUCTOR FUNCTION Responsable(
        codigo INTEGER,
        nombre VARCHAR2,
        apellido1 VARCHAR2,
        apellido2 VARCHAR2,
        tipo CHAR
    ) RETURN SELF AS RESULT IS

    BEGIN
        SELF.codigo := codigo;
        SELF.nombre := nombre;
        SELF.apellidos := CONCAT(apellido1, apellido2);
        SELF.tipo := tipo;
        antiguedad := 1;
        RETURN;
    END;

    MEMBER FUNCTION getNombreCompleto RETURN VARCHAR2 IS
    BEGIN
        RETURN (apellidos || ' ' || nombre);
    END getNombreCompleto;
END;