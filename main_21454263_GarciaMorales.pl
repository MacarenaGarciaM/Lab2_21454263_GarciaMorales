%RF2-Constructor
%station/5
% Descripcion:Predicado constructor de una estación de metro, las que
% pueden ser estaciones del tipo: regular, mantención, combinación o
% terminal.
%Dom:id (int) X name (String)  X type (stationType) X stopTime (positive integer) X Station
%Meta Primaria:station/5
%Meta Secundaria:
station(Id, Name, Type, StopTime, [Id, Name, Type, StopTime]).
