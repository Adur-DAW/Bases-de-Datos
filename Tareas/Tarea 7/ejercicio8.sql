/* 8. Crea un bloque de código que realice las siguientes acciones:
- Guarda en una instancia listaZonas1 de dicha lista, dos Zonas ...

- Inserta en la tabla TablaComerciales las siguientes filas ...

- Obtener, de la tabla TablaComerciales, el Comercial que tiene el código 100,
asignándoselo a una variable unComercial

- Modifica el código del Comercial guardado en esa variable unComercial
asignando el valor 101, y su zona debe ser la segunda que se había creado
anteriormente. Inserta ese Comercial en la tabla TablaComerciales
*/

DECLARE
    zona1 Zonas;
    zona2 Zonas;
    listaZonas1 ListaZonas;
    unComercial Comercial;
    refUnResponsable REF Responsable;
BEGIN
     SELECT REF(tp) INTO RefUnResponsable FROM TablaResponsables tp WHERE codigo = 5;
     zona1 := Zonas(1, 'zona 1', RefUnResponsable, '06834');

     SELECT REF(tp) INTO RefUnResponsable FROM TablaResponsables tp WHERE dni = '51083099F';
     zona2 := Zonas(2, 'zona 2', RefUnResponsable, '28003');

     listaZonas1 := ListaZonas(zona1, zona2);

     INSERT INTO TablaComerciales VALUES (100, '23401092Z', 'MARCOS', 'SUAREZ LOPEZ', 'M', '30/3/1990', zona1);
     INSERT INTO TablaComerciales VALUES (102, '6932288V', 'ANASTASIA', 'GOMES PEREZ', 'F', '28/11/1984', listaZonas1(2));

     SELECT VALUE(a) INTO unComercial FROM TablaComerciales a WHERE codigo = 100;
     unComercial.codigo := 101;
     unComercial.zonaComercial := zona2;

     INSERT INTO TablaComerciales VALUES (unComercial);
END;
