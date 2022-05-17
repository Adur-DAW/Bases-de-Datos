/* 5. Crea una colección VARRAY llamada ListaZonas en la que se puedan almacenar hasta 10 objetos Zonas */
CREATE OR REPLACE TYPE ListaZonas IS VARRAY(10) OF Zonas;