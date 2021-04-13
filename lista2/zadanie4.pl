%Zestaw reguł upraszczających, które udało mi się wymyślić.
reguła(X, +, Y, Y) :- 
    number(X),
    X =:= 0, !.
reguła(X, +, Y, X) :- 
    number(Y),
    Y =:= 0, !.

reguła(X, *, _, 0) :-
    number(X),
    X =:= 0, !.
reguła(_, *, X, 0) :-
    number(X),
    X =:= 0, !.

reguła(X, *, Y, Y) :-
    number(X),
    X =:= 1, !.
reguła(X, *, Y, X) :-
    number(Y),
    Y =:= 1, !.

reguła(X, /, X, 1) :-
    (
        number(X),
        X =\= 0
    )
    ;
    !.
reguła(X, /, 1, X) :-
    (
        number(X),
        X =\= 0
    )
    ;
    !.
reguła(0, /, X, 0) :-
    (
        number(X),
        X =\= 0
    )
    ;
    !.
reguła(X, -, X, 0).

reguła(X*Y, /, X, Y).
reguła(X*Y, /, Y, X).

reguła(X/Y, *, Y, X).

%Reguły, które policzą działania liczbowe
reguła(X, +, Y, Z) :- 
    number(X),
    number(Y),
    Z is X+Y, !.
reguła(X, -, Y, Z) :- 
    number(X),
    number(Y),
    Z is X-Y, !.
reguła(X, *, Y, Z) :- 
    number(X),
    number(Y),
    Z is X*Y, !.
reguła(X, /, Y, Z) :- 
    number(X),
    number(Y),
    Z is X/Y, !.
%Reguły, do których trafi reszta działań, które nie da się uprościć
reguła(X, +, X, 2*X) :- !.
reguła(X, +, Y, X+Y) :- !. 
reguła(X, -, Y, X-Y) :- !.
reguła(X, *, Y, X*Y) :- !.
reguła(X, /, Y, X/Y) :- !.



uprość(X, X) :-  %jeżeli coś jest atomem to zakończ upraszczanie
    atomic(X), !.
uprość(Wyrażenie, Wynik) :-
    Wyrażenie =.. [Operator, Lewy, Prawy], %Rozłożenie wyrażenia do listy
    uprość(Prawy, Y),
    uprość(Lewy, X),
    reguła(X, Operator, Y, Wynik),!. %Zastosowanie reguł do wyrażenia

