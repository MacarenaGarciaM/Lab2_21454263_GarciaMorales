%RF2-Constructor
%station/5
% Descripcion:Predicado constructor de una estación de metro, las que
% pueden ser estaciones del tipo: regular, mantención, combinación o
% terminal.
%Dom:id (int) X name (String)  X type (stationType) X stopTime (positive integer) X Station
%Meta Primaria:station/5
%Meta Secundaria:
station(Id, Name, Type, StopTime, [Id, Name, Type, StopTime]).

%RF3-Constructor
%section/5
%Descripcion: Predicado que permite establecer enlaces entre dos estaciones.
%Dom: point1 (station)  X point2 (station) X distance (positive-number) X cost (positive-number U {0}) X Section
%Meta Primaria: Section/5
%Meta Secundaria:
section(Point1, Point2, Distance, Cost, [Point1, Point2, Distance, Cost]).
