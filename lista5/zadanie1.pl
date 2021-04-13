key(read).
key(write).
key(if).
key(then).
key(else).
key(fi).
key(while).
key(do).
key(od).
key(and).
key(or).
key(mod).

sep(';').
sep('+').
sep('-').
sep('*').
sep('/').
sep('(').
sep(')').
sep('<').
sep('>').
sep('=<').
sep('>=').
sep(':=').
sep('=').
sep('/=').

%MAIN         
scanner(Strumien, Tokeny) :-
    scan(Strumien, [], Tokeny), !.

%Pobiera znak i wysyła do sprawdzenia    L - lista aktualnie zebranych tokenów
scan(Strumien, L, Wynik) :-
    get_char(Strumien, Char),
    scan_type(Strumien, Char, L, Wynik), !.

%Sprawdzenie jakiego typu jest podany znak
scan_type(Strumien, Char, L, Wynik) :-
    (   %Słowa kluczowe
        char_type(Char, lower),
        scan_key(Strumien, Char, L, Wynik)  
    );
    (   %Zmienne
        char_type(Char, upper),
        scan_id(Strumien, Char, L, Wynik)  
    );
    (   %Liczby
        char_type(Char, digit),
        scan_int(Strumien, Char, L, Wynik)  
    );
    (   %Znaki białe: spacje, entery
        char_type(Char, space),
        scan(Strumien, L, Wynik)  
    );
    (   %Separatory dwu- i jedno- znakowe
        member(Char, [':', '=', '>', '/']) ->
        separator(Strumien, Char, L, Wynik)
    );
    (   %Separatory jednoznakowe
        member(Char, [';', '+', '-', '*', '(', ')', '<']),
        append(L, [sep(Char)], L_2),
        scan(Strumien, L_2, Wynik)
    );
    (   %Koniec pliku
        char_type(Char, end_of_file),
        Wynik = L
    ), !.
% ======= Separatory    (Sprawdzenie, czy separator jest jedno-/dwu- znakowy i dodanie do listy L)
separator(Strumien, Char, L, Wynik) :-
    get_char(Strumien, Char_2),
    atom_concat(Char, Char_2, Concated),
    (sep(Concated) ->
        (
            append(L, [sep(Concated)], L_2),
            scan(Strumien, L_2, Wynik)
        );
        (
            append(L, [sep(Char)],  L_2),
            scan_type(Strumien, Char_2, L_2, Wynik)
        )
    ), !.


% ======= Słowa Kluczowe    
scan_key(Strumien, Char, L, Wynik) :-
    get_key(Strumien, Char, Key, Next_Char),
    append(L, [key(Key)],  L_2),
    scan_type(Strumien, Next_Char, L_2, Wynik), !.

%get_key (i podobne niżej) zwraca(ją) dwie wartości: 
        %Key - który jest do dodania do listy L,
        %Next_Char - który wraca spowrotem na górę do sprawdzenia
get_key(Strumien, Chars, Key, Next_Char) :-
    get_char(Strumien, Char_2),
    (char_type(Char_2, lower) ->
        (
            atom_concat(Chars, Char_2, Concat),
            get_key(Strumien, Concat, Key, Next_Char)
        );
        (
            Key = Chars,
            Next_Char = Char_2
        )
    ),!.


% ======= Liczby Całkowite (analogicznie jak wyżej, tylko inne nazwy zmiennych i inny typ sprawdzenia)
scan_int(Strumien, Char, L, Wynik) :-
    get_int(Strumien, Char, Number, Next_Char),
    append(L, [int(Number)],  L_2),
    scan_type(Strumien, Next_Char, L_2, Wynik), !.

get_int(Strumien, Digits, Number, Next_Char) :-
    get_char(Strumien, Char_2),
    (char_type(Char_2, digit) ->
        (
            atom_concat(Digits, Char_2, Concat),
            get_int(Strumien, Concat, Number, Next_Char)
        );
        (
            Number = Digits,
            Next_Char = Char_2
        )
    ), !.

% ======= Zmienne ID (analogicznie ...)
scan_id(Strumien, Char, L, Wynik) :-
    get_id(Strumien, Char, ID, Next_Char),
    append(L, [id(ID)],  L_2),
    scan_type(Strumien, Next_Char, L_2, Wynik), !.

get_id(Strumien, Chars, ID, Next_Char) :-
    get_char(Strumien, Char_2),
    (char_type(Char_2, upper) ->
        (
            atom_concat(Chars, Char_2, Concat),
            get_id(Strumien, Concat, ID, Next_Char)
        );
        (
            ID = Chars,
            Next_Char = Char_2
        )
    ), !.