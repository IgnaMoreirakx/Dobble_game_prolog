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
%primarias: firstcard y ncard

%secundarias: ncards, cartan, proceso no encapsulado de las N cards
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%clausuras
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Hechos
%carta1.
prueba(Elementos, 0, []).
carta1(0, []).
aa(Elementos, 0, [],).
%Ncartas

prueba2(Elementos, 0, _, _, []).
ncards(N, 0, J, [1]).
cartan(Elementos, N, M, 0, []).

%NNcartas.
prueba3(Elementos, 0, _, _, _,_, []).
firstnncard(Elementos, N, I, J, 0, [I]).
secondnncard(Elementos, N, I, 0, K, []).
totalnncard(Elementos, N, 0, J, K, []).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Reglas

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


%%%%%%%%%%%%%%%%%%%%%funciones auxiliares%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
getElem(1,[C|_],C):-!.
getElem(X,[_|R],Sol):-X1 is X -1,getElem(X1,R,Sol).
% get2(Cartas, Elementos, Resultado).


get2([], _, []).
get2([C|Cs], [E|Es], [R|Res]):- getElem(C, [E|Es], R), get2(Cs, [E|Es], Res).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%