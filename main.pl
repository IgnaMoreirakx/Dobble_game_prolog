%Dominios:
%carta1: Numeros de elementos por carta
%ncards: Numeros de elementos por carta, un "contador" M, un "contador"
%j
%cartan: Numeros de elementos por carta, un "contador" M, un "contador"
%j
%ncard: Numeros de elementos por carta( se encarga de encapsular todo
%sobre las N cartas
%firstnncard : numero de elementos por carta, contardor i, contador j contador, K, lista de resultado. La funcion se encarga de crea la 1era de las NNcartas
%secondnncard: numero de elementos por carta, contardor i, contador j contador, K, lista de resultado. La funcion se encarga de ir variando j e ir creando las demas cartas.
%totalnncard: umero de elementos por carta, contardor i, contador j contador, K, lista de resultado. La funcion se encarga de crear todas las NN cartas, variando el Ii
%nncard: encapsula el proceso de creacion de las NN cartas, solo necesita el parametro de numeros de elementos por carta

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Metas 
%primarias: firstcard, ncard, nncard y cardset

%secundarias: ncards, cartan, proceso no encapsulado de las N cards
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%clausuras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Hechos
%cardset
mazo(Elementos, 0, C, []):- !.
maxC(0, _, []):- !.

%carta1.
prueba(Elementos, 0, []).
carta1(0, []):- !.
aa(Elementos, 0, [],).
%Ncartas

prueba2(Elementos, 0, _, _, []):- !.
ncards(N, 0, J, [1]):- !.
cartan(Elementos, N, M, 0, []):- !.

%NNcartas.
prueba3(Elementos, 0, _, _, _,_, []):- !.
firstnncard(Elementos, N, I, J, 0, [I]):- !.
secondnncard(Elementos, N, I, 0, K, []):- !.
totalnncard(Elementos, N, 0, J, K, []):- !.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Reglas
%para cardset
cardset(Elementos, N, C, [Elementos|L]):- mazo(Elementos, N, C, L).
mazo(Elementos, N, C, L):- aa(Elementos, N, E), nncard(Elementos, N, A), ncard(Elementos, N, B), append(A,B,X), append(X, E, K), primero(K, S), length(S, S1), (integer(C)-> C is C; C is ((S1-1)*(S1-1) + (S1-1) + 1)), maxC(C, K, L).
maxC(C, [L|Ls], [L|Xs]):- T is C-1, maxC(T, Ls, Xs).

%para la primera carta
prueba(Elementos, N, L):- carta1(N, X), get2(X, Elementos, L).
carta1(N, [N|L]):- M is N-1, carta1(M, L).
aa(Elementos, N, [L]):- prueba(Elementos, N, L).

%para las Ncartas

ncard(Elementos, N,L):- cartan(Elementos, N,(N-1), (N-1), L).
prueba2(Elementos, N, M, J, L):- ncards(N, M, J, R), get2(R, Elementos, L). 
ncards(N, M, J, [K|L]):- T is M-1, K is (N-1)*J + M+1, ncards(N, T, J, L).
cartan(Elementos, N, M, J, [K|L]):- R is J-1, prueba2(Elementos, N, M, J, K), cartan(Elementos, N, M, R, L).

%Para las NNcartas

nncard(Elementos, N, L):- totalnncard(Elementos, N, (N-1), (N-1), (N-1), X), append(X,L).
prueba3(Elementos, N, I, J, K, A, L):- firstnncard(N,I,J,K,A, X), get2(X, Elementos, L).

firstnncard(N, I, J, K, A, [X|L]):- E is I+1,T is K -1, X is ((N-1)+2+((N-1)*(K-1)))+((((I-1)*(K-1)+J-1)) mod (N-1)), firstnncard(N, I, J, T, E, L).

secondnncard(Elementos, N, I, J, K, [X|L]):- R is J-1, prueba3(Elementos, N, I, J, K, N, X), secondnncard(Elementos, N, I, R, K,L).

totalnncard(Elementos, N, I, J, K, [Y|Yes]):-  R is I-1, secondnncard(Elementos, N, I, J, K, Y), totalnncard(Elementos, N, R, J, K, Yes).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cardsSetIsDobble([L|Ls]):- primero(Ls, X), length(X, T), Num is T-1, primo(Num), not(serepite(L)), yapo(Ls, Ls).  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cardsSetNthCard([L, L2|Ls], 0, L2):- !.
cardsSetNthCard([_|Xs], C, Sol):- cardsSetIsDobble([L,L2|Ls]), T is C-1, cardsSetNthCard(Xs, T, Sol).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cardsSetFindTotalCards([], 0):- !.
cardsSetFindTotalCards(L, R):- cardsSetIsDobble(L), length(L, X), R is (X-1)* (X-1) + (X-1) + 1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cardsSetMissingCards([L, L2|Ls], R):- cardsSetIsDobble([L,L2|Ls]), length(L2, X), S is (X-1)* (X-1) + (X-1) + 1, cardset(L, X, S, T), subtract(T, [L,L2|Ls], R). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cardsSetToString([], []).
cardsSetToString([L|Ls], [R|Rs]):- atomics_to_string(L, ' ', X), string_concat("\n carta: ", X, R), cardsSetToString(Ls, Rs).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     TDA GAME  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


dobbleGame(N, CardsSet, Mode, Estado, [[], N, CardsSet, [], Mode, Estado]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%register%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

agregar(E, L1, [E|L1]).

jugador(Nombre, [Nombre, 0]).

onescore([Nombre, Score], [Nombre, Score2]):- Score2 is Score +1. 
cambiarscoretotal([L1|Ls], R):- onescore(L1, L), append([L], Ls, R). 


register(Nombre, Game, Game2):- primero(Game, Lj), not(member(Nombre, Lj)), agregar(Nombre, Lj, Ju), getElem(2, Game, Num), Num>0, getElem(3, Game, Mazo),getElem(5, Game, Modo), getElem(6, Game, Estado), T is Num-1, dobbleGame(T, Mazo, Modo, Estado, [Ga|Gas]), append([Ju], Gas, Game2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

turno(Game, Jugador):- primero(Game, L), primero(L, R), primero(R, Jugador).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    P L A Y  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cambiarturno(Lista, R):- deletehead(Lista, R1), primero(Lista, P), addend(P, R1, R), !.

agregarcarta(0, Mazo, []):- !.
agregarcarta(N, [M| Ms], [M1| Rs]):- primero(Ms, M1), T is N-1, agregarcarta(T, Ms, Rs).
eliminarcartas([M,M1,M2|Ms], R):- append([M], Ms, R).

%para el null
play1([Jugadores, Numjugadores, Mazo, Area, Modo, Estado], "null", [Jugadores, Numjugadores, Mazo2, Area2, Modo, Estado]):- agregarcarta(2, Mazo, Area2), eliminarcartas(Mazo, Mazo2), !.

%para el spotit
compararspot(Elemento, [C1,C2]):- member(Elemento, C1), member(Elemento, C2), !.

play2([Jugadores, Numjugadores, Mazo, Area, Modo, Estado], ["spoit", Jugador, Elemento], [Jugadores2, Numjugadores, Mazo2, Area2, Modo, Estado]):- compararspot(Elemento, Area), cambiarscoretotal(Jugadores, X), cambiarturno(X, Jugadores2), 
eliminarcartas(Mazo, Mazo2), agregarcarta(2, Mazo, Area2), !.
play2([Jugadores, Numjugadores, Mazo, Area, Modo, Estado], ["spoit", Jugador, Elemento], [Jugadores2, Numjugadores, Mazo, Area, Modo, Estado]):- not(compararspot(Elemento, Area)), cambiarturno(Jugadores, Jugadores2).

play3([Jugadores, Numjugadores, Mazo, Area, Modo, Estado], pass, [Jugadores2, Numjugadores, Mazo, Area, Modo, Estado]):- cambiarturno(Jugadores, Jugadores2), !.

play4([Jugadores, Numjugadores, Mazo, Area, Modo, Estado], finish, [Jugadores, Numjugadores, Mazo, Area, Modo, finalizado, R]):- scoresjugadores(Jugadores, R1), maxScore(R1, R2), ganador(Jugadores, R2, R3), primero(R3, R).
ganador([L|Ls], Score, G):- mymember(Score, L, G), !.
ganador([_|Ls], Score, G):- ganador(Ls, Score, G).  

play(Game, "null", G2):- play1(Game, "null", G2),!.
play(Game, ["spoit" , Jugador, Elemento], G2):- play2(Game, ["spoit", Jugador, Elemento], G2), !.
play(Game, pass, G2):- play3(Game, pass, G2), !.
play(Game, finish, G2):- play4(Game, finish, G2), !.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%estadodeljuego%%%%%%%%%%%%%%%%%%%%%%%%%%

status(Game, Estado):- getElem(6, Game, Estado).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%scoreunjugador%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
scoresjugadores([], []).
scoresjugadores([Jugador|Js], [L|Ls]):- getElem(2, Jugador, L), scoresjugadores(Js, Ls). 
maxScore(L, X):- mayor(L, X).


getScore(Game, Jugador, Resultado):- primero(Game, Jugadores), jugador(Jugador, J1), obtener(J1, Jugadores, L), getElem(2, L, Resultado). 










%%%%%%%%%%%%%%%%%%%%%funciones auxiliares%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
myRandom(Xn, Xn1):-
AX is 1103515245 * Xn,
AXC is AX + 12345,
Xn1 is (AXC mod 2147483647).

serepite(L):- set(L, E), length(E, X), length(L, Y), X < Y. 

primero([L|Ls], L).

encomun(L1, L2):- intersection(L1,L2, X), length(X, 1).

yapo([], _):- !.
yapo([L1|Ls], T):- length(T, 1), yapo(Ls, Ls), !.
yapo([L1|Ls], [X|Xs]):- primero(Xs, E), encomun(L1, E), yapo([L1|Ls], Xs).



getElem(1,[C|_],C):-!.
getElem(X,[_|R],Sol):-X1 is X -1,getElem(X1,R,Sol).

get2([], _, []).
get2([C|Cs], [E|Es], [R|Res]):- getElem(C, [E|Es], R), get2(Cs, [E|Es], Res).

set([], []).
set([H|T], [H|T1]):- subtract(T, [H], T2), set(T2, T1).

obtener(X, [X|_], X):- !.
obtener(X, [_|Xs], Rs):- obtener(X, Xs, Rs).


addhead(X, L, [X|L]).



/* borrar la cabeza de una lista*/
deletehead(L,L1):-
addhead(_,L1,L).

/* adicionar al final de una lista */
addend(X, [], [X]).
addend(X, [C|R], [C|R1]):-
addend(X, R, R1).


mayor([C|[]],C):-!.
mayor([C|R],C1):-mayor(R,C2),C>C2 ,C1 is C,!.
mayor([_|R],C1):-mayor(R,C1).

mymember(X, L, L):- member(X, L), !.

divisible(X,Y):-N is Y*Y, N =< X, X mod Y =:= 0.
divisible(X,Y):-Y < X,Y1 is Y+1,divisible(X,Y1).
primo(X):-Y is 2, X > 1, \+divisible(X,Y).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%