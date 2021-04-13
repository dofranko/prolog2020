długość([], 0).
długość([_|L], N) :-
    długość(L, N1),
    N is N1 + 1.

głowa([H|_], H).

usuń_głowę([_|Reszta], Reszta).

środek(L, 0, X) :-
    głowa(L, X).

środek(L, N, X) :-
    N2 is N - 1,
    usuń_głowę(L, R),
    środek(R, N2, X).

środkowy(L, X) :-
    member(X, L),
    długość(L, N),
    N mod 2 =\= 0,
    N2 is N // 2,
    środek(L, N2, X), !. %cut by program wiedział, że tylko jedna wartość jest poprawna
