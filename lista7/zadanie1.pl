merge(IN1, IN2, OUT) :-
	when((nonvar(IN1), nonvar(IN2)), 	
			(	%Sprawdzenie, czy strumień IN1 ma jeszcze dane
				IN1 = [Head1 | Tail1] ->
					(	%IN1 ma dane i sprawdzenie, czy IN2 ma dane
						IN2 = [Head2 | Tail2] ->
						(
							%IN1 i IN2 mają dane. Sprawdzenie, która wartość powinna być zapisana
							Head1 =< Head2 ->
							(
								%Gdy wartość z IN1 powinna być teraz zapisana. + poszukanie kolejnej wartości
								OUT = [Head1 | OUT2],
								merge(Tail1, IN2, OUT2)
							)
							;
							(
								%Gdy wartość z IN2 powinna być teraz zapisana. Przeciwnie niż wyżej.
								OUT = [Head2 | OUT2],
								merge(IN1, Tail2, OUT2)
							)
						)
						;%Jeśli strumień IN2 nie ma już danych (a IN1 ma) to wypisuje tylko dane z IN1
						( OUT = IN1 ) 
					)
					;
					(	%Jeśli strumień IN1 nie ma już danych, to sprawdzenie czy IN2 ma
							IN2 = [Head2 | Tail2] -> ( OUT = IN2 ); (OUT = []) 
					)
			)%Koniec GOAL'a w when'ie
		)%Koniec when'a
		, !.