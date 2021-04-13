
wariancja(L, D) :-
    length(L, N),
    (N =:= 0 -> D is 0; 
    %Else:
    srednia(L, N, Srednia),
    sumy_czastkowe(L, 0, Srednia ,Licznik),
    D is Licznik / N).

suma([], Ak, Sum) :-
    Sum is Ak.
suma([X|L], Ak, Sum) :-
    Ak2 is Ak + X,
    suma(L, Ak2, Sum).
srednia(L, N, Wynik) :-
    suma(L, 0, Suma),
    Wynik is Suma / N.

sumy_czastkowe([], Ak, _, Wynik) :-
    Wynik is Ak.

sumy_czastkowe([Y|L], Ak, Srednia, Wynik) :-
    Czastka1 is (Y - Srednia),
    Czastka2 is Czastka1 * Czastka1,
    Ak2 is Ak + Czastka2,
    sumy_czastkowe(L, Ak2, Srednia, Wynik).