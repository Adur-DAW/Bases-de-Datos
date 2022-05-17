CREATE OR REPLACE TRIGGER numeroAgentes
BEFORE INSERT OR DELETE ON agentes
FOR EACH ROW
DECLARE
 TYPE cursorOficinas IS REF CURSOR RETURN oficinas % ROWTYPE;
    cOficinas cursorOficinas;
 TYPE cursorFamilias IS REF CURSOR RETURN familias % ROWTYPE;
    cFamilias cursorFamilias;
 rtFamilias Familias % ROWTYPE;
 rtOficinas Oficinas % ROWTYPE;
BEGIN
    IF inserting THEN
        --1. La familias y la oficina no pueden ser las dos nulas
        IF (:new.familia IS NULL AND :new.oficina IS NULL) THEN
            raise_application_error(-20021, 'No pueden ser nulas a la vez la familia y la oficina');
        END IF;

        --2. La oficina y la categoria no pueden tener valor las dos
        IF (:new.familia IS NOT NULL AND :new.oficina IS NOT NULL) THEN
            raise_application_error(-20022, 'No pueden tener valor la familia y la oficina a la vez. Debes elegir una');
        END IF;

        --3. Si un agente tiene categoría 2 no puede pertenecer a ninguna familia y debe pertenecer a una oficina.
        IF (:new.categoria = 2 AND :new.oficina IS NULL) THEN
            RAISE_APPLICATION_ERROR(-20023, 'Si el agente pertenece a la categoria 2, debe tener una oficina asociada.');
        END IF;

        --4. Si un agente tiene categoría 1 no puede pertenecer a ninguna oficina y debe pertenecer a una familia.
        IF (:new.categoria = 1 AND :new.familia IS NULL) THEN
            RAISE_APPLICATION_ERROR(-20024, 'Si el agente pertenece a la categoria 1, debe tener una familia asociada.');
        END IF;

        --5. Al insertar un agente en la tabla AGENTES se actualizará, incrementándose en 1,
        UPDATE familias SET numagentes = numagentes+1 WHERE identificador=: new.familia OR oficina=: new.oficina;
    END IF;

    IF deleting THEN
        --6. Antes de eliminar un agente en la tabla AGENTES se actualizará¡, decrementándose en 1, el campo NumAgentes de la tabla FAMILIAS
        UPDATE familias SET numagentes = numagentes- 1 WHERE identificador=: old.familia or oficina=: old.oficina;
    END IF;
END;

--1. La familias y la oficina no pueden ser las dos nulas
INSERT INTO
AGENTES (identificador, Nombre, Usuario, Clave, Habilidad, Categoria, Familia, oficina)
VALUES (316, 'Federico', 'Fede11', 'Fed11', 4, 0, null, null);

--2. La oficina y la categoría no pueden tener valor las dos
INSERT INTO
AGENTES (identificador, Nombre, Usuario, Clave, Habilidad, Categoria, Familia, oficina)
VALUES (316, 'Federico', 'Fede11', 'Fed11', 4, 0, 11, 1);

--3. Si un agente tiene categoría 2 no puede pertenecer a ninguna familia y debe pertenecer a una oficina.
INSERT INTO AGENTES (identificador, Nombre, Usuario, Clave, Habilidad, Categoria, Familia, oficina)
VALUES (316, 'Federico', 'Fede11', 'Fed11', 4, 2, 4, null);

--4. Si un agente tiene categoría 1 no puede pertenecer a ninguna oficina y debe pertenecer a una familia.
INSERT INTO AGENTES (identificador, Nombre, Usuario, Clave, Habilidad, Categoria, Familia, oficina)
    VALUES (316, 'Federico', 'Fede11', 'Fed11', 4, 1, null, 4); --Insertar Agente de categoría 2

SELECT * FROM FAMILIAS WHERE oficina = 2; -- comprobamos qué valor tiene el campo numAgentes antes de insertar
INSERT INTO AGENTES (identificador, Nombre, Usuario, Clave, Habilidad, Categoria, Familia, oficina)
    VALUES (317, 'Elisa', 'Elis2', 'El2', 4, 2, null, 2);

SELECT * FROM AGENTES WHERE identificador = 317; -- comprobamos que el agente está insertado correctamente
SELECt * FROM FAMILIAS WHERE oficina = 2; --comprobamos que el valor del campo numAgentes se ha incrementado

--Insertar Agente de categoría 1
SELECt * FROM FAMILIAS WHERE identificador = 11; -- comprobamos quÃ© valor tiene el campo numAgentes antes de insertar

INSERT INTO AGENTES (identificador, Nombre, Usuario, Clave, Habilidad, Categoria, Familia, oficina)
 VALUES (316, 'Federico', 'Fede11', 'Fed11', 4, 1, 11, null);

SELECT * FROM AGENTES WHERE identificador = 316; -- comprobamos que el agente estÃ¡ insertado correctamente

SELECT * FROM familias WHERE identificador = 11; --comprobamos que el valor del campo numAgentes se ha incrementado

SELECT * FROM familias WHERE identificador = 11; -- comprobamos quÃ© valor tiene el campo numAgentes antes de eliminar

DELETE agentes WHERE identificador = 316; --Eliminar Agente 316

SELECT * FROM agentes WHERE identificador = 316;

SELECT * FROM familias WHERE identificador = 11; --comprobamos que el valor del campo numAgentes se ha decrementado