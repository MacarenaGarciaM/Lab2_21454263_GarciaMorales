%RF2-Constructor
%station/5
% Descripcion:Predicado constructor de una estaci�n de metro, las que
% pueden ser estaciones del tipo: regular, mantenci�n, combinaci�n o
% terminal.
%Dom:id (int) X name (String)  X type (stationType) X stopTime (positive integer) X Station
%Meta Primaria:station/5
%Meta Secundaria:
station(Id, Name, Type, StopTime, [Id, Name, Type, StopTime]).
