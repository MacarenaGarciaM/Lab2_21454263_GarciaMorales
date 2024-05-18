%Rf2-Constructor
%station/5
% Descripcion:Predicado constructor de una estaciÃ³n de metro, las que
% pueden ser estaciones del tipo: regular, mantenciÃ³n, combinaciÃ³n o
% terminal.
%Dom:id (int) X name (String)  X type (stationType) X stopTime (positive integer) X Station
%Meta Primaria:station/5
%Meta Secundaria:
station(Id, Name, Type, StopTime, [Id, Name, Type, StopTime]):-
    member(Type, ["r", "m", "c", "t"]).

%Rf3-Constructor
%Section/5
% Descripcion:Predicado Que permite establecer enlaces entre dos
% estaciones
%Dom: point1 (station) X point2 (station) X distance
% (positive-number) X cost (positive-number U {0}) X Section Meta
% Primaria:section/5 Meta Secundaria:
section(Point1, Point2, Distance, Cost, [Point1, Point2, Distance, Cost]).

%RF4-Constructor
%line/5
%Descripcion:Predicado que permite crear una línea
%Dom:id (int) X name (string) X rail-type (string) X sections (List section) X Line
%Meta Primaria:line/5
%Meta Secundaria:
line(Id, Name, RailType, sections, [Id, Name, RailType, sections]).

%RF5-Otros
%line/4
%
% Predicado auxiliar para calcular la longitud, distancia y costo totales de una lista de secciones
largoLinea([], 0, 0, 0).
largoLinea([[_, _, Distancia, Costo] | Resto], Largo, DistanciaTotal, CostoTotal) :-
    largoLinea(Resto, RestoLargo, RestoDistancia, RestoCosto),
    Largo is RestoLargo + 1,
    DistanciaTotal is RestoDistancia + Distancia,
    CostoTotal is RestoCosto + Costo.

% Predicado principal para calcular las métricas de una línea
lineLength([_, _, _, Sections], Length, Distance, Cost) :-
    largoLinea(Sections, Length, Distance, Cost).
