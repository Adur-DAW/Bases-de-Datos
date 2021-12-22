CREATE TABLE familia (
    codfamilia  NUMBER(3) PRIMARY KEY,
    denofamilia VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE producto (
    codproducto     NUMBER(5) PRIMARY KEY,
    denoproducto    VARCHAR(20) NOT NULL,
    descripcion     VARCHAR(100),
    preciobase      NUMBER(6, 2) CHECK ( preciobase > 0 ) NOT NULL,
    porcreposicion  NUMBER(3) CHECK ( porcreposicion > 0 ),
    unidadesminimas NUMBER(4) CHECK ( unidadesminimas > 0 ) NOT NULL,
    codfamilia      NUMBER(3) NOT NULL,
    
    CONSTRAINT fk_producto_familia FOREIGN KEY ( codfamilia ) REFERENCES familia ( codfamilia )
);

CREATE TABLE tienda (
    codtienda    NUMBER(5) PRIMARY KEY,
    denotienda   VARCHAR(20) NOT NULL,
    telefono     VARCHAR(11),
    codigopostal VARCHAR(5) NOT NULL,
    provincia    VARCHAR(5) NOT NULL
);

CREATE TABLE stock (
    codtienda   NUMBER(5) NOT NULL,
    codproducto NUMBER(5) NOT NULL,
    unidades    NUMBER(6) NOT NULL,
    
    CONSTRAINT fk_stock_tienda FOREIGN KEY ( codtienda ) REFERENCES tienda ( codtienda ),
    CONSTRAINT fk_stock_producto FOREIGN KEY ( codproducto ) REFERENCES producto ( codproducto )
);

ALTER TABLE stock ADD CONSTRAINT pk_stock PRIMARY KEY (codtienda, codproducto);