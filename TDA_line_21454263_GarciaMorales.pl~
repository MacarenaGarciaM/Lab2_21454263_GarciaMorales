:- module(tda_line_21454263_garciamorales, [
    largoLinea/4,
    getSectionLine/2,
    encontrar_camino/6,
    lineFirstStationType/1,
    lineLastStationType/1,
    getLineId/2,
    getLinesId/2
]).
%RF5-Auxilar
%largoLinea/4
%Descripción: auxiliar para obtener el largo de una linea
%Dom:
%Meta Primaria: largoLinea/4

largoLinea([], 0, 0, 0).
largoLinea([[_, _, Distancia, Costo] | Resto], Largo, DistanciaTotal, CostoTotal) :-
    largoLinea(Resto, RestoLargo, RestoDistancia, RestoCosto),
    Largo is RestoLargo + 1,
    DistanciaTotal is RestoDistancia + Distancia,
    CostoTotal is RestoCosto + Costo.

%RF6-Auxilar
%getSectionLine/2
%Descripción: auxiliar para obtener el las secciones de una liea
%Dom: Line (list) X Sections (list)
%Meta Primaria: getSectionLine/2

getSectionLine(Line, Sections):-
    line(_, _, _, Sections, Line).

%RF6-Auxilar
%encontrar_camino/6
%Descripción: encuentra la distancia y costo de una seccion
%Dom: Line (list) X Sections (list)
%Meta Primaria:encontrar_camino/6

encontrar_camino([], _, _, [], 0, 0).
encontrar_camino([Section], Station1Name, Station2Name, [Section], Distancia, Costo) :-
    section(Point1, Point2, Dist, Cost, Section),
    Point1 = [_, Station1Name, _, _],
    Point2 = [_, Station2Name, _, _],
    Distancia is Dist,
    Costo is Cost.


encontrar_camino([Section | Resto], Station1Name, Station2Name, [Section | Camino], DistanciaTotal, CostoTotal) :-
    section(Point1, Point2, Dist, Cost, Section),
    Point1 = [_, Station1Name, _, _],
    Point2 \= [_, Station2Name, _, _],
    Point2 = [_, NextStationName, _, _],
    encontrar_camino(Resto, NextStationName, Station2Name, Camino, RestoDistancia, RestoCosto),
    DistanciaTotal is Dist + RestoDistancia,
    CostoTotal is Cost + RestoCosto.

encontrar_camino([Section | Resto], Station1Name, Station2Name, Camino, Distancia, Costo) :-
    section(Point1, _, _, _, Section),
    Point1 \= [_, Station1Name, _, _],
    encontrar_camino(Resto, Station1Name, Station2Name, Camino, Distancia, Costo).


%RF7-Auxilar
%lineFirstStationType/1
% Descripción: revisa si la primera estacion de una linea cumple con sertipo t
%Dom:
%Meta Primaria:lineFirstStationType/1

lineFirstStationType(Line) :-
    getSectionLine(Line, Sections),
    Sections = [[FirstStation|_]|_],
    station(_, _, Type, _, FirstStation),
    Type = t.

%%RF7-Auxilar
%lineLastStationType/1
% Descripción: revisa si la ultima estacion de una linea cumple con
% ser tipo t
%Dom:
%Meta Primaria:lineLastStationType/1
lineLastStationType(Line) :-
    getSectionLine(Line, Sections),
    last(Sections, LastSection),
    LastSection = [_, LastStation|_],
    station(_, _, Type, _, LastStation),
    Type = t.

%RF18-Auxiliar
%get_Line_Id/2
%Descripción: Regla auxiliar que obtiene el ID de una línea.
%Dom: Line (List) X Id (Any)
%Meta Primaria: get_Line_Id/2

getLineId(Line, Id):-
    line(Id,_ ,_ ,_, Line).

%RF18-Auxiliar
%getLinesId/2
%Descripción: Regla auxiliar que obtiene los IDs de una lista de líneas.
%Dom: Lines (List) X Ids (List)
%Meta Primaria: getLinesId/2
%Meta Secundaria: get_Line_Id/2

getLinesId([], []).
getLinesId([Line | Rest], [Id | Ids]) :-
    getLineId(Line, Id),
    getLinesId(Rest, Ids).


