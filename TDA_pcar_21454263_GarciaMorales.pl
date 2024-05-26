:- module(tda_pcar_21454263_garciamorales, [
    primerPcarValido/1,
    ultimoPcarValido/1,
    restoPcars/1,
    validarTren/1,
    getCapacityPcar/2,
    getCapacityPcars/2
]).
%TDA PCAR
%RF10- Auxiliar
%primerPcarValido/
%Descripcion: verifica si es el primer pcar es válido
%Dom:
%Meta Primaria:primerPcarValido/
%Meta Secundaria:

primerPcarValido([Pcar1| _]) :-
    pcar(_,_,_,Type, Pcar1),
    Type = tr.
primerPcarValido([]) :- !.
primerPcarValido([]).

%RF10- Auxiliar
%ultimoPcarValido/
%Descripcion: verifica si es el ultimo pcar es válido
%Dom:
%Meta Primaria:ulimoPcarValido/
%Meta Secundaria:
ultimoPcarValido(PCars) :-
    reverse(PCars, ReversePCars),
    primerPcarValido(ReversePCars).

%RF10- Auxiliar
%restoPcars/
%Descripcion: verifica si los pcars del medio son válidos
%Dom:
%Meta Primaria:restoPcars/
%Meta Secundaria:
restoPcars([]).
restoPcars([[_, _, Type, _] | Resto]) :-
    Type \= tr,
    restoPcars(Resto).

%RF10- Auxiliar
%validarTren/
%Descripcion: verifica si es el tren es válido
%Dom:
%Meta Primaria:validarTren/
%Meta Secundaria:
validarTren([]) :- !.
validarTren(PCars) :-
    primerPcarValido(PCars),
    ultimoPcarValido(PCars),
    restoPcars(PCars).

%RF14- Auxiliar
%getCapacityPcar/2
%Descripcion: obtiene la capacidad de un Pcar
%Dom:
%Meta Primaria:getCapacityPcar/2
%Meta Secundaria:
getCapacityPcar(Pcar, Capacity):-
    pcar(_, Capacity, _, _, Pcar).

%RF14- Auxiliar
%getCapacityPcars/2
%Descripcion: obtiene la capacidad de una lista de pcars
%Dom:
%Meta Primaria:getCapacityPcars/2
%Meta Secundaria:

getCapacityPcars([],0).
getCapacityPcars([X|Resto], CapacityTotal):-
    getCapacityPcar(X, Capacity),
    getCapacityPcars(Resto, CapacityResto),
    CapacityTotal is CapacityResto + Capacity.

