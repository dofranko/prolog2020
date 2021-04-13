%TABELKA na końcu pliku

lista(N, X) :-
    lista_liczb(N, Y), !,%wygenerowanie listy [1, 2, 3,..., N]
	pozycja_parzysta([1], [], 2, [1], Y, X). %Na pierwszej pozycji zawsze jest '1'

lista_liczb(1,[1]).
lista_liczb(N, X) :-
    N>0,
    N2 is N-1,
    lista_liczb(N2, Y),
    append(Y, [N], X).

%Skrócony sposób działania:
%	w tablicach @Pozycja_nieparzysta oraz @Pozycja_parzysta zapisywane są informacje o tym, czy dana liczba
%	pierwszy raz wystąpiła na pozycji parzystej czy nieparzystej.
%	Fakt. Jeśli dana liczba wystąpiła pierwszy raz na pozycji parzystej, to jej następne wystąpienie
%			musi być na pozycji nieparzystej (i odwrotnie). [1,1,...] (1,2), [1,_,_,1,...] (1,4)
% 	(i)  Sprawdzenie "Y < Max" i "Y =:= Max" upewnia, że liczby są w odpowiedniej kolejności (zgodnie z "Uwagą 0").
%	(ii) 'X' jest bieżąco generowaną listą wynikową.
pozycja_parzysta(Pozycja_nieparzysta, Pozycja_parzysta, Max, X,Lista_liczb, Wynik) :-
	member(Y, Lista_liczb), %Generator
	(
	(	%Gdy wybrana liczba już wystąpiła raz (czyli teraz został wygenerowana drugi - i ostatni - raz). 
		%- zostaje usunięta z @Lista_liczb i dodana do tablicy X
		Y < Max,
		member(Y, Pozycja_nieparzysta),
		append(X, [Y], X2),
		select(Y, Lista_liczb, Lista_liczb2),
		pozycja_nieparzysta(Pozycja_nieparzysta, Pozycja_parzysta, Max, X2, Lista_liczb2, Wynik)
	)
	;
	(	%Gdy wybrana liczba zostanie wybrana pierwszy raz.
		%
		Y =:= Max,
		Max2 is Max + 1,
		append(X, [Y], X2),
		append([Y], Pozycja_parzysta, Pozycja_parzysta2),
		pozycja_nieparzysta(Pozycja_nieparzysta, Pozycja_parzysta2, Max2, X2, Lista_liczb, Wynik)
	)
	).

%Koniec listy. Zwrócenie wyniku. Koniec może pojawić się tylko PO parzystej pozycji.
pozycja_nieparzysta(_, _, _, X, [], Wynik) :-
	Wynik = X.

%Zasada działania tak samo, jak wyżej. 
pozycja_nieparzysta(Pozycja_nieparzysta, Pozycja_parzysta, Max, X, Lista_liczb, Wynik) :-
	member(Y, Lista_liczb),
	(
	(
		Y < Max,
		member(Y, Pozycja_parzysta),
		append(X, [Y], X2),
		select(Y, Lista_liczb, Lista_liczb2),
		pozycja_parzysta(Pozycja_nieparzysta, Pozycja_parzysta, Max, X2, Lista_liczb2, Wynik)
	)
	;
	(
		Y =:= Max,
		Max2 is Max + 1,
		append(X, [Y], X2),
		append([Y], Pozycja_nieparzysta, Pozycja_nieparzysta2),
		pozycja_parzysta(Pozycja_nieparzysta2, Pozycja_parzysta, Max2, X2, Lista_liczb, Wynik)
	)
	).

%	TABELKA
%
%	N	N!			inf				avg
%	1	1			18				18
%	2	2			94				47
%	3	6			409				68,17
%	4	24			1 970			82,08
%	5	120			11 222			93,52
%	6	720			75 274			104,55
%	7	5040		582 597			115,59
%	8	40320		5 106 969		126,66
%	9	362880		49 974 341		137,72 (4.2s)
%	10	3628800		539 774 694		148,75 (48.5s)
%	11	39916800	6 376 871 985	159,75 (593.3s ~ 10min)
%	12	479001600	81 783 757 046	170,74 (~ 2.5h ;-; chyba trochę długo)


