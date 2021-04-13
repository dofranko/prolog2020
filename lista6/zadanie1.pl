%Wczytanie scannera z poprzedniej listy 
:- [scanner].

%Napisane w kolejności jaka jest w treści zadania.
%PROGRAM
program([]) --> [].
program([INSTRUKCJA | PROGRAM]) -->
    instrukcja(INSTRUKCJA),
    [sep(;)], !,
    program(PROGRAM).


%INSTRUKCJE
instrukcja(assign(ID, WYRAZENIE)) -->
    [id(ID)],
    [sep(':=')],
    wyrazenie(WYRAZENIE).

instrukcja(read(ID)) -->
    [key(read)],
    [id(ID)].

instrukcja(write(WYRAZENIE)) -->
    [key(write)],
    wyrazenie(WYRAZENIE).

instrukcja(if(WARUNEK, PROGRAM)) -->
    [key(if)],
    warunek(WARUNEK),
    [key(then)],
    program(PROGRAM),
    [key(fi)].

instrukcja(if(WARUNEK, PROGRAM_1, PROGRAM_2)) -->
    [key(if)],
    warunek(WARUNEK),
    [key(then)],
    program(PROGRAM_1),
    [key(else)],
    program(PROGRAM_2),
    [key(fi)].

instrukcja(while(WARUNEK, PROGRAM)) -->
    [key(while)],
    warunek(WARUNEK),
    [key(do)],
    program(PROGRAM),
    [key(od)].


%WYRAZENIE
wyrazenie(SKLADNIK + WYRAZENIE) -->
    skladnik(SKLADNIK),
    [sep('+')],
    wyrazenie(WYRAZENIE).

wyrazenie(SKLADNIK - WYRAZENIE) -->
    skladnik(SKLADNIK),
    [sep('-')],
    wyrazenie(WYRAZENIE).

wyrazenie(SKLADNIK) --> skladnik(SKLADNIK).


%SKŁADNIK
skladnik(CZYNNIK * SKLADNIK) -->
    czynnik(CZYNNIK),
    [sep('*')],
    skladnik(SKLADNIK).

skladnik(CZYNNIK / SKLADNIK) -->
    czynnik(CZYNNIK),
    [sep('/')],
    skladnik(SKLADNIK).

skladnik(CZYNNIK mod SKLADNIK) -->
    czynnik(CZYNNIK),
    [key(mod)],
    skladnik(SKLADNIK).

skladnik(CZYNNIK) -->
    czynnik(CZYNNIK).


%CZYNNIK
czynnik(id(IDENTYFIKATOR)) -->
    [id(IDENTYFIKATOR)].

czynnik(int(LICZBA_NATURALNA)) -->
    [int(LICZBA_NATURALNA)].

czynnik(( WYRAZENIE )) -->
    [sep('(')],
    wyrazenie(WYRAZENIE),
    [sep(')')].


%WARUNEK
warunek(KONIUNKCJA ; WARUNEK) -->
    koniunkcja(KONIUNKCJA),
    [key(or)],
    warunek(WARUNEK).

warunek(KONIUNKCJA) --> koniunkcja(KONIUNKCJA).


%KONIUNKCJA
koniunkcja(PROSTY , KONIUNKCJA) -->
    prosty(PROSTY),
    [key(and)],
    koniunkcja(KONIUNKCJA).

koniunkcja(PROSTY) --> prosty(PROSTY).


%PROSTY
prosty(WYRAZENIE_1 =:= WYRAZENIE_2) -->
    wyrazenie(WYRAZENIE_1),
    [sep('=')],
    wyrazenie(WYRAZENIE_2).

prosty(WYRAZENIE_1 =\= WYRAZENIE_2) -->
    wyrazenie(WYRAZENIE_1),
    [sep('/=')],
    wyrazenie(WYRAZENIE_2).

prosty(WYRAZENIE_1 < WYRAZENIE_2) -->
    wyrazenie(WYRAZENIE_1),
    [sep('<')],
    wyrazenie(WYRAZENIE_2).

prosty(WYRAZENIE_1 > WYRAZENIE_2) -->
    wyrazenie(WYRAZENIE_1),
    [sep('>')],
    wyrazenie(WYRAZENIE_2).

prosty(WYRAZENIE_1 =< WYRAZENIE_2) -->
    wyrazenie(WYRAZENIE_1),
    [sep('=<')],
    wyrazenie(WYRAZENIE_2).

prosty(WYRAZENIE_1 >= WYRAZENIE_2) -->
    wyrazenie(WYRAZENIE_1),
    [sep('>=')],
    wyrazenie(WYRAZENIE_2).

prosty(( WARUNEK )) -->
    [sep('(')],
    wyrazenie(WARUNEK),
    [sep(')')].