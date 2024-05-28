:- module(tda_driver_21454263_garciamorales, [getDriverId/2, getDriversId/2]).
%TDA DRIVER
%RF19-Auxiliar
%get_Driver_Id/2
%Descripción: Regla auxiliar que obtiene el ID de un conductor.
%Dom: Driver (List) X Id (Any)
%Meta Primaria:getDriverId/2
%Meta Secundaria: driver/4

getDriverId(Driver,Id):-
    driver(Id,_ ,_ , Driver).

%RF19-Auxiliar
%getDriversId/2
%Descripción: Regla auxiliar que obtiene los IDs de una lista de conductores.
%Dom: Drivers (List) X Ids (List)
%Meta Primaria: getDriversId/2
%Meta Secundaria: getDriverId/2

getDriversId([], []).
getDriversId([Driver | Rest], [Id | Ids]) :-
    getDriverId(Driver, Id),
    getDriversId(Rest, Ids).


