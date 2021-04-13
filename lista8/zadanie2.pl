:- use_module(library(clpfd)).

plecak(Wartosci, Wielkosci, Pojemnosc, Zmienne) :-
    length(Wartosci, N),
    length(Wielkosci, N),
    length(Zmienne, N),
    Zmienne ins 0..1,
    scalar_product(Wielkosci, Zmienne, #=<, Pojemnosc), %Ograniczenie możliwości
    scalar_product(Wartosci, Zmienne, #=, Wyniki),      %Wyliczenie pozostałych możliwości
    once(labeling([max(Wyniki)], Zmienne)).             %Znalezienie najlepszego wyniku