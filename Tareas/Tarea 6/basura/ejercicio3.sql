CREATE OR REPLACE PROCEDURE copiarFamilia(idOrigen NUMBER, idDestino NUMBER) IS
    familiaOrigen Familias % ROWTYPE;
    familiaDestino Familias % ROWTYPE;
    TYPE cursorFamilias IS
        REF CURSOR RETURN familias % ROWTYPE;
    cFamilias cursorFamilias;
    nuevoNombre VARCHAR2(100);

    -- Función auxiliar
    FUNCTION fu_nombre(padre number, destino number)
    RETURN VARCHAR2 IS
        nombrePadre varchar2(100);
    BEGIN
        SELECT nombre INTO nombrePadre FROM FAMILIAS WHERE IDENTIFICADOR = padre;
        RETURN nombrePadre ||'-'|| destino;
    END;

    BEGIN
        -- Comprobamos si la familia destino no existe
        OPEN cFamilias FOR
            SELECT * FROM familias WHERE identificador = idDestino;
        FETCH cFamilias INTO familiaDestino;

        IF (cFamilias % FOUND = TRUE) THEN
            RAISE_APPLICATION_ERROR(-20013, 'La familia destino existe');
        END IF;

        -- Comprobamos si la familia origen existe
        OPEN cFamilias FOR
            SELECT * FROM familias WHERE identificador = idOrigen;
        FETCH cFamilias INTO familiaOrigen;

        IF (cFamilias % FOUND = FALSE) THEN
            RAISE_APPLICATION_ERROR(-20011, 'La familia origen no existe');
        END IF;

        nuevoNombre:=fu_nombre(familiaOrigen.familia,idDestino);

        INSERT INTO familias (identificador, nombre, familia, oficina)
        VALUES (idDestino, nuevoNombre, familiaOrigen.familia, familiaOrigen.oficina);

        COMMIT;
        DBMS_OUTPUT.put_line('Se ha copiado con exito la familia ['|| idOrigen || '] a la familia ['|| idDestino || '] ');
    END;

/*
ERROR: 'La familia origen no existe'

-- Resultado esperado:
-- ORA-20011: La familia origen no existe
*/
BEGIN
    copiarFamilia(33,900);
END;

/*
ERROR: 'La familia destino existe'

-- Resultado esperado:
-- ORA-20013: La familia destino existe
*/
BEGIN
    copiarFamilia(111,112);
END;

/*
Comprobar que funciona

-- Resultado esperado:
-- Se ha copiado con exito la familia [111] a la familia [901]
-- Madrid-1.2-901
*/
DECLARE
    familiaOrigen number:= 111;
    familiaDestino number:= 901;
    nuevoNombre varchar(100);
BEGIN
    copiarFamilia(familiaOrigen,familiaDestino);
    SELECT nombre INTO nuevoNombre FROM familias WHERE identificador = familiaDestino;
    DBMS_OUTPUT.put_line(nuevoNombre);
END;
