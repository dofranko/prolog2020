
le(1,1).
le(2,2).
le(3,3).
le(1,2).
le(2,3).
le(1,3).
le(0,0).
le(0,2).
le(0,3).
le(0,1). % to zakomentować 
maksymalny(X) :-
	le(X, X),
	forall(le(X, Y), X == Y).

minimalny(X) :- 
	le(X, X),
	forall(le(Y, X), X == Y).

najmniejszy(X) :- 
	le(X,X),
	forall(le(Y,Y), le(X, Y)).
największy(X) :- 
	le(X,X),
	forall(le(Y,Y), le(Y, X)).
	

