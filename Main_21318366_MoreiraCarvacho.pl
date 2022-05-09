/*
------------------------------------TDA cardsSet-------------------------------------------------
Dominio:
    cardsSet: constructor de las cartas.
    cardsSetIsDobble: verifica que un cardsSet sea valido
    cardsSetNthCard: Entrega una carta del cardset
    cardsSetFindTotalCards: A partir de una carta entrega el total de cartas que tiene el cardset completo de dicha carta.
    cardsSetMissingCards: A partir de un conjuntos de cartas entrega las cartas faltantes para que se forme un cardset completo
    cardsSetToString: convierte la representacion del cardset en un string, para que sea pueda ser "leido" por un usuario

Predicados:
    carta1(N). aridad 1
    ncards(N, J, K). aridad 3
    cartaN(Elementos, N, J, K). aridad 4
    firstnncards(Elementos, N, I, J, K). aridad 5
    secondnncard(Elementos, N, I, J, K). aridad 5
    totalnncard(Elementos, N, I, J, K). aridad 5
    nncards(Elementos, N). aridad 5
    mazo(Elementos, N, C). aridad 3
    cardset(Elementos, N, C). aridad 3
    maxC(C, Cartas). aridad 2
    cardsSetIsDobbl(cardsSet). aridad 1
    cardsSetNthCard(N, cardsSet). aridad 2
    cardsSetFindTotalCards(carta). aridad 1
    cardsSetMissingCards(cardsSet incompleto). aridad 1
    cardsSetToString(cardSet). aridad 1
############################################### REPRESENTACION #######################
El tda cardsSet representa el mazo de cartas del jeugo Dobble, donde su representacion interna corresponde a una lista: Elementos X carta1 X carta2 X..... X ultima carta.
Sabiendo esto cada predicado se debe probar con esta representacion de cardsSet, por el contrario ocurririan errores.
*/
%Hechos:
mazo(_, 0, _, []):- !.                              %encapsula el proceso de creacion del cardSet
maxC(0, _, []):- !.                                         %Entragar una cantiad C de cartas

transformar(_, 0, []).
carta1(0, []):- !.                                          %crea la primera carta solo con numeros
cartaOne(_, 0, []).                                 %crea la primera carta con los simbolos correspondiente

transformar2(_, 0, _, _, []):- !.
ncards(_, 0, _, [1]):- !.                                   %crea 1 de las N cartas
cartan(_, _, _, 0, []):- !.                         %crea crea el total de las N cartas

transformar3(_, 0, _, _, _,_, []):- !.
firstnncard(_, _, _, 0, A, [A]):- !.                        %crea la primera de las NN cartas
secondnncard(_,_, _, 0, _, []):- !.                 %crea las lista de las primeras 3 NN cartas
totalnncard(_,_, 0, _, _, []):- !.                  %crea el total de las NN cartas

cardsSetNthCard([_, L2|_], 0, L2):- !.                     %caso base o verdad de este predicado
cardsSetFindTotalCards([], 0):- !.                          %caso base o verdad de este predicado
cardsSetToString([], []).                                   %caso base o verdad de este predicado

%Reglas:
%encapsularelprocesodecreaciondelcardsSetcompleto

cardset(Elementos, N, C, [Elementos|L]):- mazo(Elementos, N, C, L).
maxC(0, _, []):- !.
maxC(C, [L|Ls], [L|Xs]):- T is C-1, maxC(T, Ls, Xs).
mazo(Elementos, N, C, L):- cartaOne(Elementos, N, E), nncard(Elementos, N, A), ncard(Elementos, N, B), append(A,B,X), append(X, E, K), primero(K, S), length(S, S1), (integer(C)-> C is C; C is ((S1-1)*(S1-1) + (S1-1) + 1)), maxC(C, K, L).


%proceso para crea la priemera carta solo con numeros y transformar esos numeros en los simbolos de la lista de elementos dado
transformar(Elementos, N, L):- carta1(N, X), get2(X, Elementos, L).
carta1(N, [N|L]):- M is N-1, carta1(M, L).
cartaOne(Elementos, N, [L]):- transformar(Elementos, N, L).

%proceso para crear las N cartas solo con numeros y transformar esos numeros en los simbolos de la lista de elementos dado
transformar2(Elementos, N, M, J, L):- ncards(N, M, J, R), get2(R, Elementos, L). 
ncard(Elementos, N,L):- cartan(Elementos, N,(N-1), (N-1), L).
ncards(N, M, J, [K|L]):- T is M-1, K is (N-1)*J + M+1, ncards(N, T, J, L).
cartan(Elementos, N, M, J, [K|L]):- R is J-1, transformar2(Elementos, N, M, J, K), cartan(Elementos, N, M, R, L).

%proceso para crear las N**2 cartas solo con numeros y transformar esos numeros en los simbolos de la lista de elementos dado
transformar3(Elementos, N, I, J, K, A, L):- firstnncard(N,I,J,K,A, X), get2(X, Elementos, L).
nncard(Elementos, N, L):- totalnncard(Elementos, N, (N-1), (N-1), (N-1), X), append(X,L).
firstnncard(N, I, J, K, _, [X|L]):- E is I+1,T is K -1, X is ((N-1)+2+((N-1)*(K-1)))+((((I-1)*(K-1)+J-1)) mod (N-1)), firstnncard(N, I, J, T, E, L).
secondnncard(Elementos, N, I, J, K, [X|L]):- R is J-1, transformar3(Elementos, N, I, J, K, N, X), secondnncard(Elementos, N, I, R, K,L).
totalnncard(Elementos, N, I, J, K, [Y|Yes]):-  R is I-1, secondnncard(Elementos, N, I, J, K, Y), totalnncard(Elementos, N, R, J, K, Yes).

 %proceso para verificar si un cardSet es valido
cardsSetIsDobble([L|Ls]):- primero(Ls, X), length(X, T), Num is T-1, primo(Num), not(serepite(L)), yapo(Ls, Ls). 

cardsSetNthCard([_|Xs], C, Sol):- cardsSetIsDobble([_|Xs]), T is C-1, cardsSetNthCard(Xs, T, Sol).

cardsSetFindTotalCards(L, R):- cardsSetIsDobble(L), length(L, X), R is (X-1)* (X-1) + (X-1) + 1.

cardsSetMissingCards([L, L2|Ls], R):- cardsSetIsDobble([L,L2|Ls]), length(L2, X), S is (X-1)* (X-1) + (X-1) + 1, cardset(L, X, S, T), subtract(T, [L,L2|Ls], R).

cardsSetToString([L|Ls], [R|Rs]):- atomics_to_string(L, ' ', X), string_concat("\n carta: ", X, R), cardsSetToString(Ls, Rs).

/*

----------------------------------------------------- TDA  Jugador-------------------------------------------
Dominio:
    Jugador: constructor de un jugador.
    onescore: cambia el score de un jugador
    cambiarscoretotal: Se obtiene la lista de jugadores original, pero con el score cambiado del jugador dado
    
Predicados: 
    Jugador(Nombre). aridad 1
    onescore(Jugador). aridad 1
    cambiarscoretotal(Jugadores), aridad 1

################################################### REPRESENTACION ####################################
La representacion escogida de un Jugador corresponde a Nombre X Score, cabe destacar que el score siempre parte en 0
*/
%Hechos:
jugador(Nombre, [Nombre, 0]).

%reglas:
onescore([Nombre, Score], [Nombre, Score2]):- Score2 is Score +1.           %cambia el score de un jugador

cambiarscoretotal([L1|Ls], R):- onescore(L1, L), append([L], Ls, R).        %forma la lista de juagdores con el score ya cambiado de un jugador dado



/*
---------------------------------------------- TDA GAME --------------------------------------------------
Dominios:
    dobbleGame: COnstructor de la estructura que alberga una partida del juego
    dobbleGameRegister: Se encarga de registar a un usuario en una partida dada
    dobbleGameWhoseTurnIsIt: Predicado para saber a que jugador le corresponde jugar
    dobbleGamePlay: Es el predica con los que los jugadores podran hacer jugadas sobre las cartas, este predicado se subdivide en 3, el null, pass, finish, spoit
    null: solo da vuelta las primeras 2 cartas del mazo y las dispone en el area de juego del game
    pass: solo se cambia el turno entre los jugadores
    finish: se cambia el estado del juego a finilizado, y se entrega el gandor.
    spoit: dado un jugador y un elemento que escoja este, se compara los simbolos de las cartas con el elemento y si en ambas cartas esta ese elemento,
           se le suma 1 punto al score del jugador, se cambia de turno, se eliminan las cartas que ya estaban en el area de juego y se disponen ahi otras 2 nuevas cartas para que se pueda seguir jugando si asi lo desean.
    dobbleGameStatus: obtiene el estado del juego
    dobbleGameScore: obtiene el score de un solo jugador registrado en el juego.


Predicados:
    dobbleGame(Numeros_jugadores, CardSset, Modo_juego, Estado_juego). aridad 4
    dobbleGameRegister(Jugador, Game). aridad 2
    dobbleGameWhoseTurnIsIt(Game). aridad 1
    dobbleGamePlay(Game, action). aridad 2
    null(Game). aridad 1
    pass(Game). aridad 1
    finish(Game). aridad 1
    spoit(Game, Jugador, Elemento). aridad 3
    dobbleGameStatus(Game). aridad 1
    dobbleGameScore(Jugador, Game). aridad 2

################################################### REPRESENTACION #########################################
La representacion escogida para el tda game es la siguiente: game = Lista_Jugadores X Num_jugadores_permitidos X Mazo X Area_juego X Modo_juego X Estado_juego 
*/

%Hechos:
scoresjugadores([], []).
dobbleGame(N, CardsSet, Mode, Estado, [[], N, CardsSet, [], Mode, Estado]).

%Reglas:
register(Nombre, Game, Game2):- jugador(Nombre, J1), primero(Game, Lj), not(member(J1, Lj)), agregar(J1, Lj, Ju), getElem(2, Game, Num), Num>0, getElem(3, Game, Mazo),
getElem(5, Game, Modo), getElem(6, Game, Estado), T is Num-1, dobbleGame(T, Mazo, Modo, Estado, [Ga|Gas]), append([Ju], Gas, Game2).

dobbleGameWhoseTurnIsIt(Game, Jugador):- primero(Game, L), primero(L, R), primero(R, Jugador).

%Se crean reglas para cada acction que puede tomar el play
%para el null
play1([Jugadores, Numjugadores, Mazo, Area, Modo, Estado], null, [Jugadores, Numjugadores, Mazo2, Area2, Modo, Estado]):- agregarcarta(2, Mazo, Area2), eliminarcartas(Mazo, Mazo2), !.

%para el spotit
compararspot(Elemento, [C1,C2]):- member(Elemento, C1), member(Elemento, C2), !.
play2([Jugadores, Numjugadores, Mazo, Area, Modo, Estado], ["spoit", Jugador, Elemento], [Jugadores2, Numjugadores, Mazo2, Area2, Modo, Estado]):- jugador(Jugador, J1), primero(Jugadores,J1),  compararspot(Elemento, Area), cambiarscoretotal(Jugadores, X), cambiarturno(X, Jugadores2), 
eliminarcartas(Mazo, Mazo2), agregarcarta(2, Mazo, Area2), !.
play2([Jugadores, Numjugadores, Mazo, Area, Modo, Estado], ["spoit", Jugadores, Elemento], [Jugadores2, Numjugadores, Mazo, Area, Modo, Estado]):- jugador(Jugador, J1), primero(Jugadores,J1), not(compararspot(Elemento, Area)), cambiarturno(Jugadores, Jugadores2).

%para el pass
play3([Jugadores, Numjugadores, Mazo, Area, Modo, Estado], pass, [Jugadores2, Numjugadores, Mazo, Area, Modo, Estado]):- cambiarturno(Jugadores, Jugadores2), !.

%para el finish
play4([Jugadores, Numjugadores, Mazo, Area, Modo, _], finish, [Jugadores, Numjugadores, Mazo, Area, Modo, finalizado, R]):- scoresjugadores(Jugadores, R1), maxScore(R1, R2), ganador(Jugadores, R2, R3), primero(R3, R).
scoresjugadores([Jugador|Js], [L|Ls]):- getElem(2, Jugador, L), scoresjugadores(Js, Ls). 
maxScore(L, X):- mayor(L, X).
ganador([L|_], Score, G):- mymember(Score, L, G), !.
ganador([_|Ls], Score, G):- ganador(Ls, Score, G). 


%manera de ocupar el play
play(Game, null, G2):- play1(Game, null, G2),!.
play(Game, ["spoit" , Jugador, Elemento], G2):- play2(Game, ["spoit", Jugador, Elemento], G2), !.
play(Game, pass, G2):- play3(Game, pass, G2), !.
play(Game, finish, G2):- play4(Game, finish, G2), !.

%para el dobbleGameStatus
dobbleGameStatus(Game, Estado):- getElem(6, Game, Estado).

%para el dobbleGameScore
dobbleGameScore(Game, Jugador, Resultado):- primero(Game, Jugadores), obtener2(Jugador, Jugadores, L), getElem(2, L, Resultado). 



/*
---------------------------------------------------- Predicados y reglas auxiliares ---------------------------------------------------
Dominios:
    Myrandom: Entregar numeros pseudosaleatorios, obtenido del enunciado del proyecto
    serepite: Saber si en una lista se repite un elemento
    encomun: Saber cuantos elementos en comun tienen 2 listas
    primero: se obtiene el primer elemento de una lista
    yapo: Encargada de verificar que en un mazo de cartas, cada par de carta tenga en comun solo 1 objeto.
    getElem: Obtiene el elemento de la lista dado la poscicion 
    get2: Encargada de que a un numero se le asigna un elemento de una lista
    set: A partir de una lista donde se repiten elementos se obtiene otra lista donde no se repitan los elementos
    obtener: Si un elemento indicado esta en la lista entregada, entrega ese elemento.
    addhead: agregar un elemento en la cabeza de una lista
    deletehead: borra la cabeza de una lista
    addend: agrega un elemento en la cola de la lista dada
    mayor: saber el mayor de una lista, solo funciona con lista de numeros
    mymember: Dado un elemento y una lista, se obtiene esa lista como resultado si el elemento pertenece a dicha lista
    divisible: saber si un numero X es divisible por otro numero Y
    primo: saber si un numero es primo o no
    cambiarturno: cambia los turno de un game
    agregarcartas: se agregan cartas a la area de juego
    eliminarcartas: se eliminan del mazo las cartas que estan en el area del juego 
    agregar: agregar un elemento a una lista dada.

Predicados:
    myrandom(X). aridad 1
    serepite(X, L). aridad 2
    encomun(L1, L2). aridad 2
    primero(L). aridad 1
    yapo(Cartas). aridad 1
    getElem(X, L). aridad 2
    get2(L1, L2). aridad 2
    set(L). aridad 2
    obtener(X, L). aridad 2
    addhead(X, L). aridad 2
    deletehead(L). aridad 1
    addend(X, L). aridad 2
    mayor(L). aridad 1
    mymember(X, L). aridad 2
    divisible(X, Y). aridad 2
    primo(X). aridad 1
    cambiarturno(Jugadores). aridad 1
    agregarcartar(X, Mazo). aridad 2
    eliminarcartas(Area_juego). aridad 1
    agregar(X, L). aridad 1
*/
%hechos:
primero([L|_], L).

yapo([], _):- !.

getElem(1,[C|_],C):-!.

get2([], _, []).

set([], []).

obtener(X, [X|_], X):- !.

addhead(X, L, [X|L]).

addend(X, [], [X]).

mayor([C|[]],C):-!.

agregarcarta(0, _, []):- !.

%Reglas:
myRandom(Xn, Xn1):-
AX is 1103515245 * Xn,
AXC is AX + 12345,
Xn1 is (AXC mod 2147483647).

cambiarturno(Lista, R):- deletehead(Lista, R1), primero(Lista, P), addend(P, R1, R), !.
agregarcarta(N, [M| Ms], [M1| Rs]):- primero(Ms, M1), T is N-1, agregarcarta(T, Ms, Rs).

eliminarcartas([M,_,_|Ms], R):- append([M], Ms, R).

serepite(L):- set(L, E), length(E, X), length(L, Y), X < Y. 

encomun(L1, L2):- intersection(L1,L2, X), length(X, 1).

yapo([_|Ls], T):- length(T, 1), yapo(Ls, Ls), !.
yapo([L1|Ls], [_|Xs]):- primero(Xs, E), encomun(L1, E), yapo([L1|Ls], Xs).

getElem(X,[_|R],Sol):-X1 is X -1,getElem(X1,R,Sol).

get2([C|Cs], [E|Es], [R|Res]):- getElem(C, [E|Es], R), get2(Cs, [E|Es], Res).

set([H|T], [H|T1]):- subtract(T, [H], T2), set(T2, T1).

obtener(X, [_|Xs], Rs):- obtener(X, Xs, Rs).

deletehead(L,L1):- addhead(_,L1,L).

addend(X, [C|R], [C|R1]):- addend(X, R, R1).

mayor([C|R],C1):-mayor(R,C2),C>C2 ,C1 is C,!.
mayor([_|R],C1):-mayor(R,C1).

mymember(X, L, L):- member(X, L), !.

divisible(X,Y):-N is Y*Y, N =< X, X mod Y =:= 0.
divisible(X,Y):-Y < X,Y1 is Y+1,divisible(X,Y1).

primo(X):-Y is 2, X > 1, \+divisible(X,Y).

agregar(E, L1, [E|L1]).

obtener2(X, [L|Ls], Resultado):- mymember(X, L, Resultado), !.
obtener2(X, [_|Ls], Resultado):- obtener2(X, Ls, Resultado).

