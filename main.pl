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

%Metas 
%primarias: firstcard y ncard

%secundarias: ncards, cartan, proceso no encapsulado de las N cards

%clausuras
%Hechos
%Ncartas.
carta1(0, []).
ncards(N, 0, J, [1]).
cartan(N, M, 0, []).

%NNcartas.
firstnncard(N, I, J, 0, [I]).
secondnncard(N, I, 0, K, []).
totalnncard(N, 0, J, K, []).

%Reglas
%para las Ncartas
carta1(N, [N|L]):- M is N-1, carta1(M, L).

ncard(N,L):- cartan(N,(N-1), (N-1), L).

ncards(N, M, J, [K|L]):- T is M-1, K is (N-1)*J + M+1, ncards(N, T, J, L).

cartan(N, M, J, [K|L]):- R is J-1, ncards(N, M, J, K), cartan(N, M, R, L).

%Para las NNcartas
nncard(N, L):- totalnncard(N, (N-1), (N-1), (N-1), X), append(X,L).

firstnncard(N, I, J, K, [X|L]):- T is K -1, X is ((N-1)+2+((N-1)*(K-1)))+((((I-1)*(K-1)+J-1)) mod (N-1)), firstnncard(N, I, J, T,L).

secondnncard(N, I, J, K, [X|L]):- R is J-1, firstnncard(N, I, J, K,X), secondnncard(N, I, R, K,L).

totalnncard(N, I, J, K, [Y|Yes]):-  R is I-1, secondnncard(N, I, J, K, Y), totalnncard(N, R, J, K, Yes).