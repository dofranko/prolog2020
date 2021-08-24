board(L) :-
    length(L, N),
    pozioma(N),
    rysuj(L, N, N), !.

%Główna "funkcja" rysująca
rysuj(_, _, 0). 
rysuj(L, N, Height) :-
    (
        (0 =:= Height mod 2) -> linia_biały(L, Height); linia_czarny(L, Height)
    ),
    pozioma(N),
    Height2 is Height - 1,
    rysuj(L, N, Height2).

%Cała pozioma kreska "+-----+"
pozioma(N) :-
    pozioma_2(N),
    write(+), nl.

pozioma_2(0).
pozioma_2(N) :-
    write(+-----),
    N2 is N - 1,
    pozioma_2(N2).

%Drukowanie linii, w której białe pole jest pierwsze
linia_biały(L, Height) :-
    linia_biały_2(L, 0, Height),
    write("|"), nl,
    linia_biały_2(L, 0, Height),
    write("|"), nl.

linia_biały_2([], _, _).
linia_biały_2([H|T], Kolumna, Height) :-
    (Kolumna mod 2 =:= 0 -> 
        (
            Height = H -> write("| ### "); write("|     ")
        );
        (
            Height = H -> write("|:###:"); write("|:::::")
        )
    ),
    Kolumna2 is Kolumna - 1,
    linia_biały_2(T, Kolumna2, Height).

%Drukowanie linii, w której czarne pole jest pierwsze
linia_czarny(L, Height) :-
    linia_czarny_2(L, 0, Height),
    write("|"), nl,
    linia_czarny_2(L, 0, Height),
    write("|"), nl.

linia_czarny_2([], _, _).
linia_czarny_2([H|T], Kolumna, Height) :-
    (Kolumna mod 2 =:= 0 -> 
        (
            Height = H -> write("|:###:"); write("|:::::")
        );
        (
        Height = H -> write("| ### "); write("|     ")
        )
    ),
    Kolumna2 is Kolumna - 1,
    linia_czarny_2(T, Kolumna2, Height).

%Hetmany z wykładu
hetmany(N, P) :-
	numlist(1, N, L),
	permutation(L, P),
	dobra(P).

dobra(P) :-
	\+ zla(P).

zla(P) :-
	append(_, [Wi | L1], P),
	append(L2, [Wj | _], L1),
	length(L2, K),
	abs(Wi - Wj) =:= K + 1.