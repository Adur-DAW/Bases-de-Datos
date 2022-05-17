/* 1. Crea el tipo de objetos Personal con sus atributos */
CREATE OR REPLACE TYPE Personal AS OBJECT (
    codigo INTEGER,
    dni VARCHAR2(10),
    nombre VARCHAR2(30),
    apellidos VARCHAR2(30),
    sexo VARCHAR2(1),
    fecha_nac DATE
) NOT FINAL;