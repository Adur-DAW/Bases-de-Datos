/* 4. Crea el tipo de objeto Zonas con sus atributos y que contenga:
- Método MAP ordenarZonas que devuelva el nombre completo del Responsable al
que hace referencia cada zona. Para obtener el nombre debes utilizar el método
getNombreCompleto que se ha creado anteriormente
*/

CREATE OR REPLACE TYPE Zonas AS OBJECT (
 codigo INTEGER,
 nombre VARCHAR2(20),
 refResponsable REF Responsable,
 codigoPostal CHAR(5),

 MAP MEMBER FUNCTION ordenarZonas RETURN VARCHAR2
);

CREATE OR REPLACE TYPE BODY Zonas AS
    MAP MEMBER FUNCTION ordenarZonas RETURN VARCHAR2 IS
    unResponsable Responsable;
    BEGIN
        SELECT DEREF(refResponsable) INTO unResponsable FROM Dual;
        RETURN (unResponsable.getNombreCompleto());
    END ordenarZonas;
END;