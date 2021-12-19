ALTER TABLE stock ADD (
    fechaultimaentrada DATE DEFAULT sysdate,
    beneficio          NUMBER(1) CHECK ( beneficio BETWEEN 1 AND 5 )
);

ALTER TABLE producto DROP COLUMN descripcion;

ALTER TABLE producto ADD perecedero VARCHAR(1) CHECK ( perecedero IN ( 'S', 'N' ) );

ALTER TABLE producto MODIFY
    denoproducto VARCHAR(50);

ALTER TABLE tienda ADD CONSTRAINT codigopostal UNIQUE ( codigopostal );

RENAME stock TO prodxtiendas;

DROP TABLE familia CASCADE CONSTRAINTS;

CREATE USER C##Invitado IDENTIFIED BY invitado;

GRANT ALL PRIVILEGES ON producto TO C##Invitado;

REVOKE ALTER, UPDATE ON producto FROM C##Invitado;

