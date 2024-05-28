:- use_module('tda_section_21454263_garciamorales').
:- use_module('tda_line_21454263_garciamorales').
:- use_module('tda_pcar_21454263_garciamorales').
:- use_module('tda_train_21454263_garciamorales').
:- use_module('tda_driver_21454263_garciamorales').

%Rf2-Constructor
%station/5
% Descripcion:Predicado constructor de una estaciÃ³n de metro, las que
% pueden ser estaciones del tipo: regular, mantenciÃ³n, combinaciÃ³n o
% terminal.
%Dom:id (int) X name (String)  X type (stationType) X stopTime (positive integer) X Station
%Meta Primaria:station/5
%Meta Secundaria: member/2
station(Id, Name, Type, StopTime, [Id, Name, Type, StopTime]):-
    member(Type, [r, m, c, t]).

%Rf3-Constructor
%Section/5
% Descripcion:Predicado Que permite establecer enlaces entre dos
% estaciones
%Dom: point1 (station) X point2 (station) X distance
% (positive-number) X cost (positive-number U {0}) X Section
%MetaPrimaria:section/5
%Meta Secundaria: No aplica
section(Point1, Point2, Distance, Cost, [Point1, Point2, Distance, Cost]).

%RF4-Constructor
%line/5
%Descripcion:Predicado que permite crear una línea
%Dom:id (int) X name (string) X rail-type (string) X sections (List section) X Line
%Meta Primaria:line/5
%Meta Secundaria: No aplica
line(Id, Name, RailType, Sections, [Id, Name, RailType, Sections]).

%RF5-Constructor
%line/5
%Descripcion:Predicado que permite determinar el largo total de una línea (cantidad de estaciones), la distancia (en la unidad de medida expresada en cada tramo) y su costo. No queda establecido en este enunciado la unidad de distancia ya que no afecta el objetivo del proyecto.
%Dom:id (int) X name (string) X rail-type (string) X sections (List section) X Line
%Meta Primaria:line/5
%Meta Secundaria: largoLinea/4

lineLength([_, _, _, Sections], Length, Distance, Cost) :-
    largoLinea(Sections, Length, Distance, Cost).

%RF6-otros
%line/6
%Descripcion:Predicado que permite determinar el trayecto entre una estación origen y una final,
%la distancia de ese trayecto y el costo. No queda establecido en este enunciado la unidad de distancia ya que
%no afecta el objetivo del proyecto.
%Dom:line (line) X station1-name (String) X station2-name (String) X path (List Section) X distance (Number) X cost (Number)
%Meta Primaria: line/6
%Meta Secundaria: getSectionLine/2, encontrar_camino/6

lineSectionLength(Line, Station1Name, Station2Name, Path, Distance, Cost) :-
    getSectionLine(Line, Sections),
    encontrar_camino(Sections, Station1Name, Station2Name, Path, Distance, Cost).


%RF7-modificador
% lineAddSection/3
% Descripción: Predicado que añade una sección a una línea si dicha sección no existe ya en la línea.
% Dom: line (Line) X section (Section) X lineOut (Line)
% Meta Primaria: lineAddSection/3
% Meta Secundaria: member/2, addSection/3

lineAddSection([Id, Name, RailType, Sections], Section, [Id, Name, RailType, NewSections]) :-
    \+ member(Section, Sections),
    agregarElemento(Sections, Section, NewSections).


%RF8-otros
%line/1
%Descripcion: Predicado que permite determinar si un elemento cumple con las restricciones señaladas en apartados anteriores en relación a las estaciones y tramos para poder conformar una línea.
%Dom:line (Line)
%Meta Primaria:line/1
% Meta Secundaria: connected_sections/1,lineFirstStationType/1,
% lineLastStationType/1


isLine(Line) :-
    Line=[_, _, _, Sections],
    Sections \= [],
    connected_sections(Sections),
    lineFirstStationType(Line),
    lineLastStationType(Line).


%RF9-Constructor
%pcar/5
%Descripcion: Permite crear los carros de pasajeros que conforman un convoy. Los carros pueden ser de tipo terminal (tr) o central (ct).
%Dom:id (int) X capacity (positive integer) X model (string) X type (car-type) X PCar
%Meta Primaria:pcar/5
%Meta Secundaria: member/2

pcar(Id, Capacity, Model, Type, [Id, Capacity, Model, Type]):-
    member(Type,[tr, ct]).


%RF10- Constructor
%train/6
%Descripcion:Predicado que permite crear un tren o convoy.
%Dom:id (int) X maker (string) X rail-type (string) X speed (positive number) X pcars (Lista de PCar) X Train
%Meta Primaria:train/6
%Meta Secundaria:validarTren/1


train(Id, Maker, RailType, Speed, PCars, [Id, Maker, RailType, Speed, PCars]) :-
    validarTren(PCars).

%RF11-modificador
%train/4
%Descripcion:Función que permite añadir carros a un tren en una posición dada.
%Dom:train (train) X pcar (pcar) X position (positive-integer U {0}) X Train
%Meta Primaria:train/4
%Meta Secundaria:insertarEnPosicion/4

trainAddCar([Id, Maker, RailType, Speed, PCars], Pcar, Position, [Id, Maker, RailType, Speed, PcarNuevo]) :-
    insertarEnPosicion(Pcar, PCars, Position, PcarNuevo).

%RF12-Modificador
%trainRemoveCar/4
%Descripción: Regla que elimina un vagón de un tren en una posición específica.
%Dom: Train (List) X Pos (Int) X TrainOut (List)
%Meta Primaria: trainRemoveCar/4
%Meta Secundaria: eliminarEnPosicion/3


trainRemoveCar([Id, Maker, RailType, Speed, PCars], Position, [Id, Maker, RailType, Speed, PcarNuevo]) :-
    eliminarEnPosicion(PCars, Position, PcarNuevo).

%RF13-Pertenencia
%istrain/1
%Descripcion: Predicado que permite determinar si un elemento es un tren válido, esto es, si el elemento tiene la estructura de tren y los carros que lo conforman son compatibles (mismo modelo) y
%tienen una disposición coherente con carros terminales (tr) en los extremos y centrales (ct) en medio del convoy.
%Dom:Train
%Meta Primaria: istrain/1
%Meta Secundaria: getTrainPcar/2, validarTren/1


isTrain(Train):-
    getTrainPcar(Train, Pcars),
    validarTren(Pcars).

%RF14-otros
%trainCapacity/2
%Descripcion:Predicado que permite determinar la capacidad máxima de pasajeros del tren.
%Dom:Train X capacity (Number)
%Meta Primaria: trainCapacity/2
%Meta Secundaria:getTrainPcar/2, getCapacityPcars/2

trainCapacity(Train, Capacity):-
    getTrainPcar(Train, Pcars),
    getCapacityPcars(Pcars, Capacity).

%RF15-Constructor
%driver/4
%Descripcion:Predicado que permite crear un conductor cuya habilitación de conducción depende del fabricante de tren (train-maker)
%Dom: id (int) X nombre (string) X train-maker (string) X Driver
%Meta Primaria: driver/4
%Meta Secundaria:No aplica
driver(Id, Nombre, TrainMaker, [Id, Nombre, TrainMaker]).

%RF16- Subway
%subway/3
%Descripcion: Predicado que permite crear una red de metro.
%Dom:id (int) X nombre (string) X Subway
%Meta Primaria: subway/3
%Meta Secundaria:No aplica
subway(Id, Nombre, [Id, Nombre]).

%RF17-Modificador
%subwayAddTrain/3
%Descripcion:Predicado que permite añadir trenes a una red de metro.
%Dom:sub (Subway) X trains (List Train) X SubwayOut (Subway)
%Meta Primaria: subwayAddTrain/3
%Meta Secundaria:getIdsTrain/2, unicoId/1, append/3

subwayAddTrain(Subway, Trains, SubwayOut) :-
    getIdsTrain(Trains, Ids),
    unicoId(Ids),
    append(Subway, Trains, SubwayOut).

%RF18-Modificador
%subwayAddLine/3
%Descripcion:Predicado que permite añadir líneas a una red de metro.
%Dom:sub (Subway) X lines (List Line) X SubwayOut (Subway)
%Meta Primaria:subwayAddLine/3
%Meta Secundaria:getLinesId/2, unicoId/1, append/3

subwayAddLine(Subway, Lines, SubwayOut):-
    getLinesId(Lines, Ids),
    unicoId(Ids),
    append(Subway, Lines, SubwayOut).


%RF19-Modificador
%subwayAddDriver/2
%Descripción:Predicado que permite añadir conductores a una red de metro.
%Dom: Driver (List) X Id (Any)
%Meta Primaria: getDriversId/2, unicoId/1, append/3

subwayAddDriver(Subway, Drivers, SubwayOut):-
    getDriversId(Drivers, Ids),
    unicoId(Ids),
    append(Subway, Drivers, SubwayOut).


