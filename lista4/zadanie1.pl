wyrażenie(L, V, E) :-
	wyrazenie1(L, E),
	V is E.

wyrazenie1([A], A).
wyrazenie1(L, E) :-
    %v Generowanie wszystkich kombinacji podlist, ale uporządkowanych i różniących się o 1
    append(L1, L2, L),          
    length(L1, N1),
    length(L2, N2),
    N1 > 0,
    N2 > 0,
	wyrazenie1(L1, A),
	wyrazenie1(L2, B),
	(
		E = A + B;
		E = A - B;
		E = A * B;
		(
            \+ (B =:= 0),
            E = A / B
        )
	).
