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
%primerPcarValido/1
%Descripcion: verifica si es el primer pcar es válido
%Dom:Pcars(List)
%Meta Primaria:primerPcarValido/1
%Meta Secundaria:pcar/5

primerPcarValido([Pcar1| _]) :-
    pcar(_,_,_,Type, Pcar1),
    Type = tr.
primerPcarValido([]) :- !.
primerPcarValido([]).

%RF10- Auxiliar
%ultimoPcarValido/1
%Descripcion: verifica si es el ultimo pcar es válido
%Dom:Pcars(List)
%Meta Primaria:ultimoPcarValido/1
%Meta Secundaria:primerPcarValido/1
ultimoPcarValido(PCars) :-
    reverse(PCars, ReversePCars),
    primerPcarValido(ReversePCars).

%RF10- Auxiliar
%restoPcars/1
%Descripcion: verifica si los pcars del medio son válidos
%Dom:pcars(List)
%Meta Primaria:restoPcars/1
%Meta Secundaria: No aplica
restoPcars([]).
restoPcars([[_, _, Type, _] | Resto]) :-
    Type \= tr,
    restoPcars(Resto).

%RF10- Auxiliar
%validarTren/1
%Descripcion: verifica si es el tren es válido
%Dom:pcars(List)
%Meta Primaria:validarTren/1
%Meta Secundaria:primerPcarValido/1, ultimoPcarValido/1, restoPcars/1
validarTren([]) :- !.
validarTren(PCars) :-
    primerPcarValido(PCars),
    ultimoPcarValido(PCars),
    restoPcars(PCars).

%RF14- Auxiliar
%getCapacityPcar/2
%Descripcion: obtiene la capacidad de un Pcar
%Dom:pcar (List) X Capacity (int)
%Meta Primaria:getCapacityPcar/2
%Meta Secundaria:pcar/5
getCapacityPcar(Pcar, Capacity):-
    pcar(_, Capacity, _, _, Pcar).

%RF14- Auxiliar
%getCapacityPcars/2
%Descripcion: obtiene la capacidad de una lista de pcars
%Dom:pcars(List) X Capacity
%Meta Primaria:getCapacityPcars/2
%Meta Secundaria: getCapacityPcar/2

getCapacityPcars([],0).
getCapacityPcars([X|Resto], CapacityTotal):-
    getCapacityPcar(X, Capacity),
    getCapacityPcars(Resto, CapacityResto),
    CapacityTotal is CapacityResto + Capacity.

