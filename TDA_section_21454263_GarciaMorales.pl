:- module(tda_section_21454263_garciamorales, [
    agregarElemento/3,
    connected_sections/1]).

%RF7-Auxilar
%agregarElemento/3
%Descripción: auxiliar para agregar un elemento a la lista de linea
%Dom: List X Elemento, ListOut
%Meta Primaria: agregarElemento/3
%Meta Secundaria: No aplica
agregarElemento([], Elemento, [Elemento]).
agregarElemento([X | Resto], Elemento, [X | RestoNuevo]) :-
    agregarElemento(Resto, Elemento, RestoNuevo).


%RF7-Auxilar
%conected_sections/1
%Descripción: Predicado auxiliar para verificar la conectividad de las secciones
%Dom:Section (List)
%Meta Primaria:conected_sections/1
%Meta Secundatria: No aplica

connected_sections([]).
connected_sections([_]).
connected_sections([[_, Point1, _, _], [Point1, _, _, _] | Rest]) :-
    connected_sections([[Point1, _, _, _] | Rest]).

