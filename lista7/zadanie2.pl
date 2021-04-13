:- [zadanie1].

split(IN, OUT1, OUT2) :-
	split(IN, OUT1, OUT2, left).

split(IN, OutLeft, OutRight, Side) :- 
	freeze(IN, (	%Sprawdzenie, czy niepusty strumień
                    IN = [Head | Tail] ->
                    (   %Dane są rozdzielane na zmianę (!) na "lewą" i "prawą" tablicę.
                        Side = left ->
                        (   %"Lewa" tablica
                            OutLeft = [Head | OutLeft_2],
                            split(Tail, OutLeft_2, OutRight, right)
                        )
                        ;
                        (   %"Prawa" tablica
                            OutRight = [Head | OutRight_2],
                            split(Tail, OutLeft, OutRight_2, left)
                        )
                    )
                    ;   %Gdy wejściowy strumień jest pusty to zwróć nic
                    ( OutLeft = [], OutRight = [] )
				)
		    ), !.

merge_sort(IN, OUT) :-
    freeze(IN, (    %Sprawdzenie czy niepusty strumień wejściowy
                    IN = [Head | Tail] ->
                    (   %Freeze, bo potrzebujemy sprawdzić potem, czy ogon jest niepusty
                        freeze(Tail,   (   %Sprawdzenie, czy ogon pusty. 
                                        %Jeśli tak, tzn. że Head jest jedynym elementem tablicy przy podziale merge_sort'em
                                        Tail = [] ->
                                        ( OUT = [Head] )
                                        ;
                                        (   %Gdy aktualna tablica ma więcej niż jeden element, to:
                                            % --podział
                                            % --sortowanie ("lewej" i "prawej" strony) 
                                            % --łączenie
                                            split(IN, OutLeft, OutRight),
                                            merge_sort(OutLeft, OutLeftSorted),
                                            merge_sort(OutRight, OutRightSorted),
                                            merge(OutLeftSorted, OutRightSorted, OUT)
                                        )
                                    )
                               )
                    )
                    ;%Gdy pusty strumień wejściowy. (raczej skrajny przypadek)
                    ( OUT = [] )
                )     
           ), !.