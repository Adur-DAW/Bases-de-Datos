CREATE OR REPLACE PROCEDURE actualizaAgente(idCat number) IS
    CURSOR cAgentes IS
        SELECT identificador, nombre, usuario,habilidad, categoria
        FROM agentes where categoria=idCat;
        ag_rec cAgentes%ROWTYPE;
    BEGIN
        OPEN CAGENTES;
        FETCH cAgentes INTO ag_rec ;

        IF (cAgentes%FOUND = FALSE) THEN
            RAISE_APPLICATION_ERROR(-20012,'No Hay agentes con la categorÃ-a ' || idCat );
        END IF;

        WHILE cAgentes%FOUND LOOP
            DBMS_OUTPUT.put_line('El Agente ' || ag_rec.nombre
        || ' ha cambiado a usuario ' ||
 generarUsuario(ag_rec.IdENTIFICADOR,12,'-', 'H'|| ag_rec.habilidad));
 update agentes set usuario = generarUsuario(ag_rec.IdENTIFICADOR,12,'-', 'H' ||
ag_rec.habilidad)
 where IDENTIFICADOR=ag_rec.IDENTIFICADOR;
 FETCH cAgentes INTO ag_rec ;
 END LOOP;
 DBMS_OUTPUT.put_line('Se han actualizado '|| cagentes%ROWCOUNT || ' Agentes');
 close cagentes;
END;
begin
actualizaAgente(1);
end;
-- Resultado esperado:
-- El Agente Diosdado SÃ¡nchez HernÃ¡ndez ha cambiado a usuario 211-----H8
-- El Agente JesÃºs BaÃ±os Sancho ha cambiado a usuario 111-----H8
-- El Agente Salvador Romero Villegas ha cambiado a usuario 1111----H7
-- El Agente JosÃ© Javier BermÃºdez HernÃ¡ndez ha cambiado a usuario 1112----H7
-- El Agente Alfonso Bonillo Sierra ha cambiado a usuario 1113----H7
-- El Agente Silvia Thomas BarrÃ³s ha cambiado a usuario 1121----H7
-- Se han actualizado 6 Agentes
begin
actualizaAgente(3);
end;
-- Resultado esperado:
-- ORA-20012: No Hay agentes con la categorÃ-a 3