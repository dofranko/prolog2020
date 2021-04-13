interpreter(PROGRAM) :-
    interpreter(PROGRAM, []).

interpreter([], _).
interpreter([read(ID) | PGM], AS) :- !,
    read(N),
    integer(N),
    podstaw(AS, ID, N, AS1),
    interpreter(PGM, AS1).
interpreter([write(W) | PGM], AS) :- !,
    wartość(W, AS, WART),
    write(WART), nl,
    interpreter(PGM, AS).
interpreter([assign(ID, W) | PGM], AS) :- !,
    wartość(W, AS, WAR),
    podstaw(AS, ID, WAR, AS1),
    interpreter(PGM, AS1).
interpreter([if(C, P) | PGM], AS) :- !,
    interpreter([if(C, P, []) | PGM], AS).
interpreter([if(C, P1, P2) | PGM], AS) :- !,
    (   prawda(C, AS)
    ->  append(P1, PGM, DALEJ)
    ;   append(P2, PGM, DALEJ)),
    interpreter(DALEJ, AS).
interpreter([while(C, P) | PGM], AS) :- !,
    append(P, [while(C, P)], DALEJ),
    interpreter([if(C, DALEJ) | PGM], AS).




podstaw([], ID, N, [ID = N]).
podstaw([ID=_ | AS], ID, N, [ID=N | AS]) :- !.
podstaw([ID1=W1 | AS1], ID, N, [ID1=W1 | AS2]) :-
    podstaw(AS1, ID, N, AS2).

pobierz([ID=N | _], ID, N) :- !.
pobierz([_ | AS], ID, N) :-
    pobierz(AS, ID, N).

wartość(int(N), _, N).
wartość(id(ID), AS, N) :-
    pobierz(AS, ID, N).
wartość(W1 + W2, AS, N) :-
    wartość(W1, AS, N1), wartość(W2, AS, N2),
    N is N1 + N2.
wartość(W1 - W2, AS, N) :-
    wartość(W1, AS, N1), wartość(W2, AS, N2),
    N is N1 - N2.
wartość(W1 * W2, AS, N) :-
    wartość(W1, AS, N1), wartość(W2, AS, N2),
    N is N1 * N2.
wartość(W1 / W2, AS, N) :-
    wartość(W1, AS, N1), wartość(W2, AS, N2),
    N2 =\= 0,
    N is N1 div N2.
wartość(W1 mod W2, AS, N) :-
    wartość(W1, AS, N1), wartość(W2, AS, N2),
    N2 =\= 0,
    N is N1 mod N2.
prawda(W1 =:= W2, AS) :-
    wartość(W1, AS, N1), wartość(W2, AS, N2),
    N1 =:= N2.
prawda(W1 =\= W2, AS) :-
    wartość(W1, AS, N1), wartość(W2, AS, N2),
    N1 =\= N2.
prawda(W1 < W2, AS) :-
    wartość(W1, AS, N1), wartość(W2, AS, N2),
    N1 < N2.
prawda(W1 > W2, AS) :-
    wartość(W1, AS, N1), wartość(W2, AS, N2),
    N1 > N2.
prawda(W1 >= W2, AS) :-
    wartość(W1, AS, N1), wartość(W2, AS, N2),
    N1 >= N2.
prawda(W1 =< W2, AS) :-
    wartość(W1, AS, N1), wartość(W2, AS, N2),
    N1 =< N2.
prawda((W1, W2), AS) :-
    prawda(W1, AS),
    prawda(W2, AS).
prawda((W1; W2), AS) :-
    (   prawda(W1, AS),
        !
    ;   prawda(W2, AS)).