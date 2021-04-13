left_of2(rower, aparat).
left_of2(ołówek, klepsydra).
left_of2(klepsydra, motyl).
left_of2(motyl, ryba).

left_of(Object1, Object2) :- 
    left_of2(Object1, Object2).
left_of(Object1, Object2) :- 
    left_of2(Object1, A), 
    left_of(A, Object2).

above2(rower, ołówek).
above2(aparat, motyl).

above(Object1, Object2) :-     
    above2(Object1, Object2).
above(Object1, Object2) :-    
    above2(Object1, A),
    above(A, Object2).

right_of(Object1, Object2) :-
    left_of(Object2, Object1).
below(Object1, Object2) :-
    above(Object2, Object1).

higher(Object1, Object2) :-
    above(Object1, Object2).
higher(Object1, Object2) :-
    (above(Object1, A),
    (left_of(A, Object2);
    right_of(A, Object2))).
