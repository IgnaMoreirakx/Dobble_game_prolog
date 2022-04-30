%Dominios:
%carta1: Numeros de elementos por carta
%ncards: Numeros de elementos por carta, un "contador" M, un "contador"
%j
%cartan: Numeros de elementos por carta, un "contador" M, un "contador"
%j
%ncard: Numeros de elementos por carta( se encarga de encapsular todo
%sobre las N cartas

%Metas 
%primarias: firstcard y ncard

%secundarias: ncards, cartan, proceso no encapsulado de las N cards

%clausuras
%Hechos
carta1(0, []).
ncards(N, 0, J, [1]).
cartan(N, M, 0, []).

%Reglas
carta1(N, [N|L]):- M is N-1, carta1(M, L).

ncard(N,L):- cartan(N,(N-1), (N-1), L).

ncards(N, M, J, [K|L]):- T is M-1, K is (N-1)*J + M+1, ncards(N, T, J, L).

cartan(N, M, J, [K|L]):- R is J-1, ncards(N, M, J, K), cartan(N, M, R, L).