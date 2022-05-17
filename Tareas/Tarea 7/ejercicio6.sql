/* 6. Crea, como tipo heredado de Personal, el tipo de objeto Comercial con sus atributos. */
CREATE OR REPLACE TYPE Comercial UNDER Personal (
    zonaComercial Zonas
);