even_permutation(Xs, Ys):-
    permutation(Xs, Ys),
    sign_from_transpositions(Xs, 1, S1),
    sign_from_transpositions(Ys, 1, S2),
    S1 = S2. 
    %^ lista nie musi być uporządkowana, więc trzeba sprawdzić czy względem siebie są parzyste
  
odd_permutation(Xs, Ys):-
    permutation(Xs, Ys), %zdefiniowane w prologu
    sign_from_transpositions(Xs, 1, S1),
    sign_from_transpositions(Ys, 1, S2),
    S1 =\= S2.

/* Program sprawdza poprzez liczbę transpozycji - jeśli znak (+1) to parzysta,
jeśli (-1) to nieparzysta. 
*/

%  Czyli: sign = (-1)^m, gdzie m - liczba transpozycji
sign_from_transpositions([], S, Sign_total) :-
  Sign_total is S.
sign_from_transpositions([X|L], S, Sign_total) :-
  sign_from_transpositions_second(L, X, S, Sign_actual),
  sign_from_transpositions(L, Sign_actual, Sign_total).

sign_from_transpositions_second([], _, S, Sign) :-
  Sign is S.
sign_from_transpositions_second([H|L], X, S, Sign) :-
  H =\= X,
  (0 > (X - H) -> S1 is S; S1 is S * -1), %dla x < y, if L[x] > L[y] then Sign *= -1
  sign_from_transpositions_second(L, X, S1, Sign).