:- module(tda_section_21454263_garciamorales, [
    agregarElemento/3,
    all_valid/2,
    connected_sections/1]).

%RF7-Auxilar
%agregarElemento/3
%Descripción: auxiliar para agregar un elemento a la lista de linea
%Dom:
%Meta Primaria: agregarElemento/3
agregarElemento([], Elemento, [Elemento]).
agregarElemento([X | Resto], Elemento, [X | RestoNuevo]) :-
    agregarElemento(Resto, Elemento, RestoNuevo).

%RF7-Auxilar
%all_valid/2
%Descripción: verifica si una estacion es valida
%Dom:
%Meta Primaria:all_valid/2

all_valid([], _).
all_valid([H|T], ValidPred) :-
    call(ValidPred, H),
    all_valid(T, ValidPred).

%RF7-Auxilar
%conected_sections/1
%Descripción: Predicado auxiliar para verificar la conectividad de las secciones
%Dom:
%Meta Primaria:conected_sections/1

connected_sections([]).
connected_sections([_]).
connected_sections([[_, Point1, _, _], [Point1, _, _, _] | Rest]) :-
    connected_sections([[Point1, _, _, _] | Rest]).

