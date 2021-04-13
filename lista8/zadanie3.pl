:- use_module(library(clpfd)).


%Zadanie zrobione na dwa sposoby, z czego żaden chyba nie jest tym, które powinno być 'Ok.' ;-;
%Sposób 1. od razu wypisuje zmienne przy zwykłym wywołaniu odcinek/1 
%(nie wiem czemu, ale podejrzewam, że przez zbyt dokładne ograniczenia)
odcinek(X):-
    X = [R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16],
    X ins 0..1,
    R1 + R2 + R3 + R4 + R5 + R6 + R7 + R8 + R9 + R10 + R11 + R12 + R13 + R14 + R15 + R16 #= 8, 
    warunek(X).

warunek([A, B, C, D, E, F, G, H|T]) :- 
    (A + B + C + D + E + F + G + H #= 8);
    warunek([B, C, D, E, F, G, H|T]).

%Sposób 2. po wypisaniu prawidowych kombinacji (nie wiem czemu) wciąż szuka innych rozwiązań (i po dłuższym czasie jest przepełnienie stack'u)
odcinek2(X) :-
    FirstLength in 0..8,
    SecondLength in 0..8,
    SecondLength + FirstLength #= 8,
    OnesLength #= 8,
    length(OnesTab, OnesLength),
    length(FirstTab, FirstLength),
    length(SecondTab, SecondLength),
    FirstTab ins 0,
    SecondTab ins 0,
    OnesTab ins 1,
    append(FirstTab, OnesTab, A),
    append(A, SecondTab, X). 


