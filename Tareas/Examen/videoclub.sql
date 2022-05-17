 
/** BORRADO DE TABLAS */
DROP TABLE ALQUILA;
DROP TABLE ACTUA;
DROP TABLE SOCIO;
DROP TABLE ACTORES;
DROP TABLE EJEMPLAR;
DROP TABLE PELICULA;
DROP TABLE DIRECTOR;

/** CREACION DE TABLAS **/

CREATE TABLE DIRECTOR (
  ID NUMBER,
  NOMBRE VARCHAR2(40),
  NACIONALIDAD VARCHAR2(40),
  PRIMARY KEY(ID)
);

CREATE TABLE PELICULA (
  ID NUMBER,
  TITULO VARCHAR2(40),
  NACIONALIDAD VARCHAR2(40),
  ANYO_ESTRENO DATE,
  DIRECTOR NUMBER,
  LIBRES NUMBER,
  PRIMARY KEY (ID), 
  CONSTRAINT PELICULAS_FK_1 FOREIGN KEY (DIRECTOR) REFERENCES DIRECTOR(ID)
);

CREATE TABLE EJEMPLAR (
  IDPELICULA NUMBER,
  NUMERO NUMBER,
  ESTADO VARCHAR2(40),
  PRIMARY KEY (IDPELICULA, NUMERO),
  CONSTRAINT EJEMPLAR_FK_1 FOREIGN KEY(IDPELICULA) REFERENCES PELICULA(ID)
);

CREATE TABLE ACTORES (
  ID NUMBER,
  NOMBRE VARCHAR2(40),
  NACIONALIDAD VARCHAR2(40),
  SEXO VARCHAR2(1),
  PRIMARY KEY (ID),
  CHECK (SEXO IN ('H', 'M'))
);

CREATE TABLE SOCIO (
  DNI VARCHAR2(9),
  NOMBRE VARCHAR2(40),
  DIRECCION VARCHAR2(40),
  TELEFONO NUMBER(9),
  PRIMARY KEY(DNI)
);

CREATE TABLE ACTUA (
  ACTOR NUMBER,
  IDPELICULA NUMBER,
  PROTAGONISTA VARCHAR2(2) DEFAULT 'NO',
  PRIMARY KEY(ACTOR, IDPELICULA),
  CONSTRAINT ACTUA_FK1 FOREIGN KEY (ACTOR) REFERENCES ACTORES(ID) ON DELETE CASCADE,  
  CONSTRAINT ACTUA_FK2 FOREIGN KEY(IDPELICULA) REFERENCES PELICULA(ID) ON DELETE CASCADE,
  CHECK (PROTAGONISTA IN ('NO','SI'))
);

CREATE TABLE ALQUILA (
  DNI VARCHAR2(9),
  IDPELICULA NUMBER,
  NUMERO NUMBER,
  FECHA_ALQUILER DATE,
  FECHA_DEVOLUCION DATE,
  PRIMARY KEY(DNI, IDPELICULA, NUMERO, FECHA_ALQUILER),
  CONSTRAINT ALQUILA_FK1 FOREIGN KEY(DNI) REFERENCES SOCIO(DNI),
  CONSTRAINT ALQUILA_FK2 FOREIGN KEY(IDPELICULA, NUMERO) REFERENCES EJEMPLAR(IDPELICULA, NUMERO)
);

/** VALORES **/

INSERT INTO DIRECTOR VALUES (1, 'QUENTIN TARANTINO',  'USA');
INSERT INTO DIRECTOR VALUES (2, 'ALEJANDRO AMENABAR', 'ESPA�OLA');

INSERT INTO PELICULA VALUES (1, 'PULP FICTION', 'USA', '01-01-1994', 1, 3);
INSERT INTO PELICULA VALUES (2, 'KILL BILL VOL.1', 'USA', '01-01-2003', 1, 2);
INSERT INTO PELICULA VALUES (3, 'ABRE LOS OJOS','ESPA�A', '01-01-1997', 2, 1);
INSERT INTO PELICULA VALUES (4, 'TESIS', 'ESPA�A', '01-01-1996', 2, 1);
INSERT INTO PELICULA VALUES (5, 'KILL BILL VOL.2', 'USA', '01-01-2004', 1, 2);

INSERT INTO EJEMPLAR VALUES (1, 1, 'BIEN');
INSERT INTO EJEMPLAR VALUES (1, 2, 'MAL');
INSERT INTO EJEMPLAR VALUES (1, 3, 'MAL');
INSERT INTO EJEMPLAR VALUES (1, 4, 'BIEN');
INSERT INTO EJEMPLAR VALUES (2, 1, 'BIEN');
INSERT INTO EJEMPLAR VALUES (2, 2, 'MAL');
INSERT INTO EJEMPLAR VALUES (3, 1, 'BIEN');
INSERT INTO EJEMPLAR VALUES (3, 2, 'REGULAR');
INSERT INTO EJEMPLAR VALUES (3, 3, 'REGULAR');
INSERT INTO EJEMPLAR VALUES (4, 1, 'BIEN');
INSERT INTO EJEMPLAR VALUES (4, 2, 'REGULAR');
INSERT INTO EJEMPLAR VALUES (5, 1, 'BIEN');
INSERT INTO EJEMPLAR VALUES (5, 2, 'MAL');

INSERT INTO SOCIO VALUES ('15405967M', 'MANUELA CARMENA', 'C/ LARGA, 7', 693456676);
INSERT INTO SOCIO VALUES ('15405978V', 'DANIEL MART�NEZ', 'C/ NUEVA, 1', 697565656);
INSERT INTO SOCIO VALUES ('15405979Z', 'ANA GARC�A',    'C/ ANCHA, 5', 697545454);
INSERT INTO SOCIO VALUES ('15405971A', 'SILVIA CARRASCO', 'C/ FORT,  4', 697121212);
INSERT INTO SOCIO VALUES ('15405972N', 'XAVI CAMPS',   'C/ ANCHA, 2', 197232323);

INSERT INTO ACTORES VALUES (1, 'John Travolta',  'USA', 'H');
INSERT INTO ACTORES VALUES (2, 'Samuel L. Jackson', 'USA', 'H');
INSERT INTO ACTORES VALUES (3, 'Uma Thurman', 'USA', 'M');
INSERT INTO ACTORES VALUES (4, 'Bruce Willis', 'ALEMANIA', 'H');
INSERT INTO ACTORES VALUES (5, 'Lucy Liu',    'USA', 'M');
INSERT INTO ACTORES VALUES (6, 'Daryl Hannah',  'USA',  'M');
INSERT INTO ACTORES VALUES (7, 'Eduardo Noriega',  'ESPAÑA',  'H');
INSERT INTO ACTORES VALUES (8, 'Pen�lope Cruz',  'ESPAÑA',  'M');
INSERT INTO ACTORES VALUES (9, 'Fele Mart�nez',  'ESPAÑA',  'H');

INSERT INTO ACTUA VALUES (1, 1, 'SI');
INSERT INTO ACTUA VALUES (2, 1, 'SI');
INSERT INTO ACTUA VALUES (3, 1, 'SI');
INSERT INTO ACTUA VALUES (4, 1, 'NO');
INSERT INTO ACTUA VALUES (3, 2, 'SI');
INSERT INTO ACTUA VALUES (5, 2, 'NO');
INSERT INTO ACTUA VALUES (6, 2, 'NO');
INSERT INTO ACTUA VALUES (7, 3, 'SI');
INSERT INTO ACTUA VALUES (8, 3, 'SI');
INSERT INTO ACTUA VALUES (9, 3, 'NO');
INSERT INTO ACTUA VALUES (7, 4, 'NO');
INSERT INTO ACTUA VALUES (9, 4, 'SI');
INSERT INTO ACTUA VALUES (3, 5, 'SI');
INSERT INTO ACTUA VALUES (5, 5, 'NO');

INSERT INTO ALQUILA VALUES ('15405978V', 001, 01, '01-01-2022', '03-01-2022');
INSERT INTO ALQUILA VALUES ('15405979Z', 001, 02, '23-11-2021', NULL);

INSERT INTO ALQUILA VALUES ('15405971A', 002, 01, '12-02-2022', '02-03-2022');
INSERT INTO ALQUILA VALUES ('15405978V', 002, 02, '03-06-2021', '12-06-2021');

INSERT INTO ALQUILA VALUES ('15405972N', 003, 01, '13-12-2021', NULL);
INSERT INTO ALQUILA VALUES ('15405972N', 003, 02, '30-03-2021', NULL);

INSERT INTO ALQUILA VALUES ('15405979Z', 004, 01, '21-04-2022', '03-05-2022');
INSERT INTO ALQUILA VALUES ('15405979Z', 004, 02, '01-04-2022', NULL);

ALTER TABLE ALQUILA read only;
ALTER TABLE ACTUA read only;
ALTER TABLE SOCIO read only;
ALTER TABLE ACTORES read only;
ALTER TABLE EJEMPLAR read only;
ALTER TABLE PELICULA read only;
ALTER TABLE DIRECTOR read only;



quit;