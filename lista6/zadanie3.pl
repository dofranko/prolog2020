%Można wywołać: phrase(z{}, X), format("~s~n", [X]). za {} podstawić 1,2 lub 3

%PS w tablicy otrzymujemy np. [97, 98, 99] (druga część zadania),
% co odpowiada kodom odpowiednio liter 'a', 'b', 'c'
% -- NIE otrzymujemy zaś tablicy typu [a,b,c]

%Kropka pierwsza. a^n b^n ===========
z1 --> ``.
z1 --> `a`, z1, `b`.

%Kropka druga. a^n b^n c^n ===========
z2 --> ab(N), c(N).
ab(0) --> ``.
ab(N) --> `a`, ab(N2), `b`, {N is N2 + 1}.
c(0) --> ``.
c(N) --> `c`, {N > 0, N2 is N - 1}, c(N2). 
	      %Tutaj N jest już jakby wyznaczone z ab(N), przez co inny sposób działania tej linii. (podobnie później)
 
%Kropka trzecia. a^n b^fib(n) ==========
z3 --> a(N), {fib(N, F)},b(F).
a(0) --> ``.
a(N) --> `a`, a(N2), {N is N2 + 1}.
b(0) --> ``.
b(N) --> `b`, {N > 0, N2 is N - 1}, b(N2).

fib(0, 0) :- !.
fib(1, 1) :- !.
fib(N, F) :-
        N > 1,
        N1 is N - 1,
        N2 is N - 2,
        fib(N1, F1),
        fib(N2, F2),
        F is F1 + F2.

/*
p ([])−−>  [].
p ([X | Xs]) −−> [X], p(Xs) .
    Jak jest zależność między listamiL1,L2iL3, jeśli spełniają one warunekphrase(p(L1), L2, L3)?   
    ODP:
Wyniki z prolog'u.
L1 = [],
L2 = L3 ;
L1 = [_12248],
L2 = [_12248|L3] ;
L1 = [_12248, _12260],
L2 = [_12248, _12260|L3] ;

Widać zależność, że L2 = L1 + L3, czyli że L2 składa się na początku z listy L1, a potem z listy L3
*/