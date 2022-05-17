-----------------------------------------------
--------- 2ª EVAL. EXAMEN - 09/05/2022  -------
------------------- PARTE 1 -------------------
-----------------------------------------------
-----------------------------------------------
--- Nombre y apellidos: Adur Marques Herrero
-----------------------------------------------

-- =================================================================================
--   Ejercicio 1 (1p)
--   SILVIA CARRASCO devolvió el ejemplar 1 de "KILL BILL VOL.1" un día más tarde
--   de la fecha que quedó registrada. 
-- 
--   Utiliza una sentencia de actualización para modificar los datos. 
--   La sentencia debe utilizar el nombre del socio, el titulo de la película y 
--   la fecha de devolución que quedó registrada.
-- =================================================================================

-- He intentado esto pero me modifica 8 registros
UPDATE ALQUILA
SET FECHA_DEVOLUCION = TO_DATE('2022-03-03', 'YYYY-MM-DD')
WHERE EXISTS (
    SELECT 1
    FROM ALQUILA a
    INNER JOIN PELICULA p ON p.ID = a.IDPELICULA
    INNER JOIN SOCIO s ON s.DNI = a.DNI
    WHERE p.TITULO = 'KILL BILL VOL.1' AND
          s.NOMBRE = 'SILVIA CARRASCO' AND
          a.FECHA_DEVOLUCION = TO_DATE('2022-03-02', 'YYYY-MM-DD')
);

-- Con esto solo me actualiza el que es pero es muy fea
UPDATE ALQUILA
SET FECHA_DEVOLUCION = FECHA_DEVOLUCION + 1
WHERE
DNI = (SELECT DNI FROM SOCIO WHERE NOMBRE = 'SILVIA CARRASCO') AND
IDPELICULA = (SELECT ID FROM PELICULA WHERE TITULO = 'KILL BILL VOL.1') AND
FECHA_DEVOLUCION = TO_DATE('2022-03-02', 'YYYY-MM-DD');

-- =================================================================================
--   Ejercicio 2 (1p)
--   Elimina de la base de datos todos aquellos ejemplares de películas que hayan sido devueltos nunca
--   han sido alquilados. 
-- 
--   La sentencia debe funcionar independientemente de los datos actuales de la base de datos.
-- =================================================================================

DELETE EJEMPLAR WHERE IDPELICULA NOT IN (SELECT IDPELICULA FROM ALQUILA);

-- =================================================================================
--   Ejercicio 3 (1p)
--   A) Crea una nueva tabla denominada "REPARACIONES" con los campos id de pelicula, título de película,
--   numero de ejemplar, estado y urgente. Escoge la clave primaria más adecuada.
-- 
--   B) Inserta en la nueva tabla los datos de aquellos ejemplares cuyo estado sea malo o regular
--   Si el estado es malo, en urgente se almacenará SI y si es regular se almacenará NO.
-- 
--   La sentencia debe funcionar independientemente de los datos actuales de la base de datos.
-- =================================================================================
CREATE TABLE REPARACIONES (
    IDPELICULA NUMBER,
    TITULO_PELICULA VARCHAR(40),
    NUMERO     NUMBER,
    ESTADO     VARCHAR(40),
    URGENTE    CHAR(2),
    PRIMARY KEY (IDPELICULA, NUMERO),
    CONSTRAINT REPARACIONES_FK_IDPELICULA FOREIGN KEY(IDPELICULA) REFERENCES PELICULA(ID)
);

INSERT INTO REPARACIONES (IDPELICULA, TITULO_PELICULA, NUMERO, ESTADO, URGENTE)
SELECT E.IDPELICULA, P.TITULO, E.NUMERO, E.ESTADO, CASE
    WHEN E.ESTADO='MAL' THEN 'SI'
    WHEN E.ESTADO='REGULAR' THEN 'NO'
    END AS URGENTE
FROM EJEMPLAR E
INNER JOIN PELICULA P on E.IDPELICULA = P.ID
WHERE ESTADO = 'REGULAR' OR ESTADO = 'MAL';

-- =================================================================================
--   Ejercicio 4 (3,75p)
--   Crea un trigger denominado “ejercicio4” en la tabla ALQUILA que realice las siguientes comprobaciones 
--   antes de insertar o modificar un registro de la tabla.
--
--   A) Si se está insertando, habrá que realizar las siguientes acciones:
-- 	   1. Si el ejemplar especificado ya está alquilado, lanzará el error "ORA-20021: El ejemplar aparece como alquilado"
--     2. Si el socio ya tiene 3 películas alquiladas, lanzará el error "ORA-20022: El socio ha llegado al límite de películas en alquiler"
--     3. Si los datos están correctos, habrá que actualizar el campo "alquilado" con valor "S" en el registro que corresponda de la tabla EJEMPLAR y se guardará
--        como fecha de alquiler la actual.
--  B) Si se está actualizando, habrá que realizar las siguientes acciones:
--     1. Si la fecha de devolución está vacía, no se realizará ninguna acción.
--     2. Si la fecha de devolución es anterior a la de alquiler, lanzará el error "ORA-20024: La fecha de devolución debe ser posterior a la de alquiler"
--     3. Si la fecha de devolución es correcta, habrá que actualizar el campo "alquilado" con valor "N" en el registro que corresponda de la tabla EJEMPLAR
--        y revisar si el alquiler estaba en la tabla de morosos, en cuyo caso será eliminado de dicha tabla.
--
--  Pon tantos ejemplos como sean necesarios para verificar todos los casos del trigger. Especifica en cada ejemplo a que caso se corresponde.
-- =================================================================================

CREATE OR REPLACE TRIGGER ejercicio4
BEFORE INSERT OR UPDATE ON ALQUILA
	DECLARE
		NUMERO_ALQUILADO INTEGER;
		NUMERO_PELICULAS INTEGER;
	BEGIN
	    IF INSERTING THEN
            SELECT COUNT(*) INTO NUMERO_ALQUILADO
            FROM ALQUILA
            WHERE IDPELICULA = :NEW.IDPELICULA
            AND NUMERO = :NEW.NUMERO
            AND FECHA_ALQUILER IS NOT NULL
            AND FECHA_DEVOLUCION IS NULL;

            IF (NUMERO_ALQUILADO > 0) THEN
                raise_application_error(-20021,'El ejemplar aparece como alquilado');
            END IF;

            SELECT COUNT(*) INTO NUMERO_PELICULAS
            FROM ALQUILA
            WHERE DNI = :NEW.DNI
            AND FECHA_ALQUILER IS NOT NULL
            AND FECHA_DEVOLUCION IS NULL;

            IF (NUMERO_ALQUILADO >= 3) THEN
                raise_application_error(-20022, 'El socio ha llegado al límite de películas en alquiler');
            END IF;

            UPDATE EJEMPLAR
            SET ESTADO = "ALQUILADO"
            WHERE IDPELICULA = :NEW.IDPELICULA
            AND NUMERO = :NEW.NUMERO;

            UPDATE ALQUILA
            SET FECHA_ALQUILER = CURRENT_DATE
            WHERE IDPELICULA = :NEW.IDPELICULA
            AND NUMERO = :NEW.NUMERO
            AND DNI = :NEW.DNI;
        END IF;

	    IF UPDATING THEN
            IF (FECHA_DEVOLUCION_DEVOLUCION IS NOT NULL) THEN
                IF (FECHA_DEVOLUCION < ALQUILA.FECHA_ALQUILER) THEN
                    raise_application_error(-20024, 'La fecha de devolución debe ser posterior a la de alquiler');
                ELSE
                    UPDATE EJEMPLAR SET ALQUILADO = 'N'
                    WHERE IDPELICULA = NEW.IDPELICULA AND
                            NUMERO =  NEW.NUMERO;
                END IF;
            END IF;
        END IF;
	END;