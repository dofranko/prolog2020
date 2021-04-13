%+---+---+---+   +-1-+-2-+-3-+ 
%|   |   |   |   4   5   6   7 
%+---+---+---+   +-8-+-9-+10-+ 
%|   |   |   |   11  12  13  14 
%+---+---+---+   +15-+16-+17-+
%|   |   |   |   18  19  20  21
%+---+---+---+   +22-+23-+24-+ 

%Lista kwadratów
duzy_kwadrat([1, 2, 3, 4, 7, 11, 14, 18, 21, 22, 23, 24]).
srednie_kwadraty([[1, 2, 4, 6, 11, 13, 15, 16], [2, 3, 5, 7, 12, 14, 16, 17], 
                    [8, 9, 11, 13, 18, 20, 22, 23], [9, 10, 12, 14, 19, 21, 23, 24]]).
male_kwadraty([[1, 4, 5, 8], [2, 5, 6, 9], [3, 6, 7, 10], [8, 11, 12, 15], [9, 12, 13, 16], 
                [10, 13, 14, 17], [15, 18, 19, 22], [16, 19, 20, 23], [17, 20, 21, 24]]).

wszystkie([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]).

%Nie wiem jak inaczej wczytać wszystkie kombinacje :/
wczytaj_liczby(Kwadraty, D, S, M) :-
    Kwadraty = (duze(D), srednie(S), male(M)).
wczytaj_liczby(Kwadraty, D, S, M) :-
    Kwadraty = (duze(D), srednie(S)), 
    M is 0.
wczytaj_liczby(Kwadraty, D, S, M) :-
    Kwadraty = (duze(D), male(M)), 
    S is 0.
wczytaj_liczby(Kwadraty, D, S, M) :-
    Kwadraty = (srednie(S), male(M)),
    D is 0.
wczytaj_liczby(Kwadraty, D, S, M) :-
    Kwadraty = (duze(D)),
    S is 0, M is 0.
wczytaj_liczby(Kwadraty, D, S, M) :-
    Kwadraty = (srednie(S)),
    D is 0, M is 0.
wczytaj_liczby(Kwadraty, D, S, M) :-
    Kwadraty = (male(M)),
    D is 0, S is 0.


%MAIN
%(Polecenie było z polskim znakiem, a przykłady bez, więc dla pewności zrobiłem konwerter)
zapalki(N, Kwadraty) :-
    zapałki(N, Kwadraty). 
zapałki(N, Kwadraty) :-
    wczytaj_liczby(Kwadraty, D, S, M), !,
    stworz_duzy(D, Zapalki),
    stworz_srednie(S, Zapalki, Zapalki2),
    stworz_male(M, Zapalki2, Zapalki3),
    length(Zapalki3, N2),
    N is 24 - N2,
    sprawdz_duzy(D, Zapalki3),
    sprawdz_srednie(S, Zapalki3),
    sprawdz_male(M, Zapalki3),
    drukuj(Zapalki3).

%Generowanie różnych ułożeń kwadratów
stworz_duzy(0, L) :-
    L = [].
stworz_duzy(1, L) :-
    duzy_kwadrat(L).

stworz_srednie(0, L, Wynik) :-
    Wynik = L.
stworz_srednie(N, L, Wynik) :-
    N > 0,
    srednie_kwadraty(Srednie),
    subsets(Srednie, Podzbior),
    length(Podzbior, N),
    generuj(Podzbior, L, N ,Wynik).
    
stworz_male(0, L, Wynik) :-
    Wynik = L.
stworz_male(N, L, Wynik) :-
    N > 0,
    male_kwadraty(Male),
    subsets(Male, Podzbior),
    length(Podzbior, N),
    generuj(Podzbior, L, N ,Wynik).

generuj(_,L, 0, Wynik) :-
    Wynik = L.
generuj([H|T],L,N, Wynik) :-
    N2 is N - 1,
    union(L, H, L2),
    generuj(T, L2, N2, Wynik).

%Sprawdzenie liczby kwadratów po wygenerowaniu jakiejś możliwości
sprawdz_duzy(0, Zapalki) :-
    duzy_kwadrat(Duzy),
    intersection(Duzy, Zapalki, L),
    length(L, N),
    N =\= 12.
sprawdz_duzy(1, Zapalki) :-
    duzy_kwadrat(Duzy),
    intersection(Duzy, Zapalki, L),
    length(L, 12).


sprawdz_srednie(N, Zapalki) :-
    srednie_kwadraty(Srednie),
    sprawdz_srednie(Zapalki, Srednie, 0, Dlugosc),
    Dlugosc is N.

sprawdz_srednie(_, [], Dlugosc, Wynik) :-
    Wynik is Dlugosc.
sprawdz_srednie(Zapalki, [H|T], Dlugosc, Wynik) :-
    intersection(H, Zapalki, L),
    (length(L, 8) -> Dlugosc2 is Dlugosc + 1; Dlugosc2 is Dlugosc),
    sprawdz_srednie(Zapalki, T, Dlugosc2, Wynik).


sprawdz_male(N, Zapalki) :-
    male_kwadraty(Male),
    sprawdz_male(Zapalki, Male, 0, Dlugosc),
    Dlugosc is N.

sprawdz_male(_, [], Dlugosc, Wynik) :-
    Wynik is Dlugosc.
sprawdz_male(Zapalki, [H|T], Dlugosc, Wynik) :-
    intersection(H, Zapalki, L),
    (length(L, 4) -> Dlugosc2 is Dlugosc + 1; Dlugosc2 is Dlugosc),
    sprawdz_male(Zapalki, T, Dlugosc2, Wynik).

%Geneorwanie podtablic
subsets([], []).
subsets([H|T1], [H|T2]):-
   subsets(T1, T2).
subsets([_|T1], T2):-
   subsets(T1, T2).

%Drukowanie
drukuj(L) :-
	wszystkie(Wszystkie),
	drukuj(Wszystkie, L), !.

drukuj([], _).
drukuj([H | T], L) :- %+---           (nowa linia i pierwszy +---)
member(H, [1, 8, 15, 22]),
    (member(H, L) -> nl, write('+---+') ; nl, write('+   +')),
    drukuj(T, L).
drukuj([H | T], L) :- %    +---+---+  (bez pierwszego +---)
	member(H, [2, 3, 9, 10, 16, 17, 23, 24]),
	(member(H, L) -> write('---+') ; write('   +')),
	drukuj(T, L).
drukuj([H | T], L) :- %|              (nowa linia i pierwszy |) 
	member(H, [4, 11, 18]),
	(member(H, L) -> nl, write('|   ') ; nl, write('    ')),
	drukuj(T, L).
drukuj([H | T], L) :- %   |   |   |   (bez pierwszego |)
	member(H, [5, 6, 7, 12, 13, 14, 19, 20, 21]),
	(member(H, L) -> write('|   ') ; write('    ')),
	drukuj(T, L).