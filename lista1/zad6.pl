pierwsza(2).
pierwsza(3).
pierwsza(A) :-
		A > 3,
		A mod 2 =\= 0,
		\+ podzielna(A, 3).
podzielna(A, B) :-
		A mod B =:= 0.
podzielna(A, B) :-
		B * B < A,
		B2 is B + 2,
		podzielna(A, B2).

prime(A, B, X) :-
		between(A, B, X),
		pierwsza(X).
