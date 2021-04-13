%Zadanie zrobione algorytmem Kadane'a
max_sum(L, S) :-
    max_sum(L, 0, 0 ,S).

max_sum([], _, Max_calkowity, S) :-
    S is Max_calkowity.

max_sum([H|L], Max_teraz, Max_calkowity, S) :-
    Nowy_max is Max_teraz + H,
    (Nowy_max < 0 -> Max_teraz2 is 0; Max_teraz2 is Nowy_max),
    (Nowy_max > Max_calkowity -> Max_calkowity2 is Nowy_max; Max_calkowity2 is Max_calkowity),
    max_sum(L, Max_teraz2, Max_calkowity2, S).