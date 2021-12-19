CREATE TABLE familia (
    codFamilia  NUMBER(3) PRIMARY KEY,
    denoFamilia VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE producto (
    codProducto     NUMBER(5) PRIMARY KEY,
    denoProducto    VARCHAR(20) NOT NULL,
    descripcion     VARCHAR(100),
    precioBase      NUMBER(6,2) CHECK (precioBase > 0 ) NOT NULL,
    porcReposicion  NUMBER(3) CHECK (porcReposicion > 0 ),
    unidadesMinimas NUMBER(4) CHECK (unidadesMinimas > 0 ) NOT NULL,
    codFamilia      NUMBER(3) NOT NULL,
    
    CONSTRAINT fk_producto_familia FOREIGN KEY (codFamilia) REFERENCES familia (codFamilia)
);

CREATE TABLE tienda (
    codTienda    NUMBER(5) PRIMARY KEY,
    denoTienda   VARCHAR(20) NOT NULL,
    telefono     VARCHAR(11),
    codigoPostal VARCHAR(5) NOT NULL,
    provincia    VARCHAR(5) NOT NULL
);

CREATE TABLE stock (
    codTienda   NUMBER(5) PRIMARY KEY,
    codProducto NUMBER(5) NOT NULL,
    unidades    NUMBER(6) NOT NULL,
    
    CONSTRAINT fk_stock_tienda FOREIGN KEY (codTienda) REFERENCES tienda (codTienda),
    CONSTRAINT fk_stock_producto FOREIGN KEY (codProducto) REFERENCES producto (codProducto)
);

