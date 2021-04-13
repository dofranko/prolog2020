jednokrotnie(X, L) :-
	member(X, L),
	select(X, L, L1),
	\+ member(X, L1).

dwukrotnie(X, L) :-
	append(L1, [X | L2], L),
	\+ member(X, L1),
	jednokrotnie(X, L2).