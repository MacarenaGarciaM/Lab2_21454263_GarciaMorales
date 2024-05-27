:- module(tda_train_21454263_garciamorales, [
    insertarEnPosicion/4,
    eliminarEnPosicion/3,
    getTrainPcar/2,
    getIdTrain/2,
    getIdsTrain/2,
    unicoId/1
]).
%RF11-Auxiliar
%insertarEnPosicion/4
%Descripcion: Inserta un elemento en el tren en una posicion especifica
%Dom: Elemento X List X Posicion(int) X ListOut
%Meta Primaria:insertarEnPosicion/4
%Meta Secundaria:No aplica

insertarEnPosicion(Elemento, Lista, 0, [Elemento|Lista]).
insertarEnPosicion(Elemento, [Pcar|Resto], Posicion, [Pcar|PcarNuevo]) :-
    Posicion > 0,
    NuevaPos is Posicion - 1,
    insertarEnPosicion(Elemento, Resto, NuevaPos, PcarNuevo).

%RF12-Auxiliar
%eliminarEnPosicion/4
%Descripcion: elimina un elemento en el tren en una posicion especifica
%Dom:List X Posicion(int) X ListOut
%Meta Primaria:eliminarEnPosicion/4
%Meta Secundaria:No aplica
eliminarEnPosicion([_|Resto], 0, Resto).
eliminarEnPosicion([Pcar|Resto], Posicion, [Pcar|PcarNuevo]) :-
    Posicion > 0,
    NuevaPosicion is Posicion - 1,
    eliminarEnPosicion(Resto, NuevaPosicion, PcarNuevo).

%RF13- Auxiliar
%getTrainPcar/2
%Descripcion: obtiene el pcar de un tren
%Dom: Train (List) X Ocars(List9
%Meta Primaria:getTrainPcar/2
%Meta Secundaria: train/6
getTrainPcar(Train, PCars):-
    train(_, _, _, _, PCars, Train).

%RF17-Auxiliar
%getIdTrain/2
%Descripcion:Predicado que obtiene el id de un tren
%Dom: Train (List) X Id
%Meta Primaria: getIdTrain/2
%Meta Secundaria: train/6

getIdTrain(Train, Id):-
    train(Id, _, _, _, _, Train).


getIdsTrain([], []).
getIdsTrain([Train|Resto], [Id|Ids]):-
    getIdTrain(Train, Id),
    getIdsTrain(Resto, Ids).

%RF17-Auxiliar
%unicoId/2
%Descripcion:Verifica que los Id's de los trenes sean unicos
%Dom:Ids
%Meta Primaria: unicoId/2
%Meta Secundaria:sort/2, length/2
unicoId(Ids):-
    sort(Ids, IdsUnicos),
    length(Ids, Len),
    length(IdsUnicos, Len).

