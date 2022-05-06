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
mazo(Elementos, N, C, L):- aa(Elementos, N, E), nncard(Elementos, N, A), ncard(Elementos, N, B), append(A,B,X), append(X, E, K), maxC(C, K, L).
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

cardsSetIsDobble([L|Ls]):- not(serepite(L)), yapo(Ls, Ls).  

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
cardsSetToString([L|Ls], [R|Rs]):- atomics_to_string(L, ' ', X), string_concat("carta: ", X, R), cardsSetToString(Ls, Rs).

%%%%%%%%%%%%%%%%%%%%%funciones auxiliares%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%