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
line(Id, Name, RailType, Sections, [Id, Name, RailType, Sections]).

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

%RF6-otros
%line/6
%Descripcion:Predicado que permite determinar el trayecto entre una estación origen y una final,
%la distancia de ese trayecto y el costo. No queda establecido en este enunciado la unidad de distancia ya que
%no afecta el objetivo del proyecto.
%Dom:line (line) X station1-name (String) X station2-name (String) X path (List Section) X distance (Number) X cost (Number)
%Meta Primaria: line/6
%Meta Secundaria:
lineSectionLength(Line, Station1Name, Station2Name, Path, Distance, Cost) :-
    line(_, _, _, Sections, Line),
    encontrar_camino(Sections, Station1Name, Station2Name, Path, Distance, Cost).

% Predicado para encontrar el trayecto entre dos estaciones
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


%RF7-otros
%line/3
%Descripcion:  Predicado que permite añadir tramos a una línea
%Dom:line (Line) X section (Section) X lineOut (Line)
%Meta Primaria: line/3
%Meta Secundaria:
lineAddSection(Line, Section, LineOut):-
   \+ member(Section, Line),
   append(Line,[Section], LineOut).

%RF8-otros
%line/
%Descripcion:
%Dom:
%Meta Primaria:
%Meta Secundaria:


%RF9-Constructor
%pcar/5
%Descripcion: Permite crear los carros de pasajeros que conforman un convoy. Los carros pueden ser de tipo terminal (tr) o central (ct).
%Dom:id (int) X capacity (positive integer) X model (string) X type (car-type) X PCar
%Meta Primaria:pcar/5
%Meta Secundaria:

pcar(Id, Capacity, Model, Type, [Id, Capacity, Model, Type]):-
    member(Type,[tr, ct]).


%RF10- Constructor
%train/
%Descripcion:
%Dom:id (int) X maker (string) X rail-type (string) X speed (positive number) X pcars (Lista de PCar) X Train
%Meta Primaria:
%Meta Secundaria:


primerPcarValido([Pcar1| _]) :-
    pcar(_,_,_,Type, Pcar1),
    Type = tr.
primerPcarValido([]) :- !.
primerPcarValido([]).

ultimoPcarValido(PCars) :-
    reverse(PCars, ReversePCars),
    primerPcarValido(ReversePCars).

restoPcars([]).
restoPcars([[_, _, Type, _] | Resto]) :-
    Type \= tr,
    restoPcars(Resto).

validarTren([]) :- !.
validarTren(PCars) :-
    primerPcarValido(PCars),
    ultimoPcarValido(PCars),
    restoPcars(PCars).

train(Id, Maker, RailType, Speed, PCars, [Id, Maker, RailType, Speed, PCars]) :-
    validarTren(PCars).

%RF11-modificador
%train/4
%Descripcion:Función que permite añadir carros a un tren en una posición dada.
%Dom:train (train) X pcar (pcar) X position (positive-integer U {0}) X Train
%Meta Primaria:train/4
%Meta Secundaria:


insertarEnPosicion(Elemento, Lista, 0, [Elemento|Lista]).
insertarEnPosicion(Elemento, [Pcar|Resto], Posicion, [Pcar|PcarNuevo]) :-
    Posicion > 0,
    NuevaPos is Posicion - 1,
    insertarEnPosicion(Elemento, Resto, NuevaPos, PcarNuevo).

trainAddCar([Id, Maker, RailType, Speed, PCars], Pcar, Position, [Id, Maker, RailType, Speed, PcarNuevo]) :-
    insertarEnPosicion(Pcar, PCars, Position, PcarNuevo).

%RF12-Modificador
%trainRemoveCar/4
%Descripción: Regla que elimina un vagón de un tren en una posición específica.
%Dom: Train (List) X Pos (Int) X TrainOut (List)
%Meta Primaria: trainRemoveCar/4
%Meta Secundaria: eliminar/3
eliminarEnPosicion([_|Resto], 0, Resto).
eliminarEnPosicion([Pcar|Resto], Posicion, [Pcar|PcarNuevo]) :-
    Posicion > 0,
    NuevaPosicion is Posicion - 1,
    eliminarEnPosicion(Resto, NuevaPosicion, PcarNuevo).


trainRemoveCar([Id, Maker, RailType, Speed, PCars], Position, [Id, Maker, RailType, Speed, PcarNuevo]) :-
    eliminarEnPosicion(PCars, Position, PcarNuevo).
