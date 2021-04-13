%Wczytanie zadanie1.pl, scannera z poprzedniej listy, interpretera z wykładu
:- [zadanie1].
:- [scanner].
:- [interpreter].


wykonaj(NazwaPliku) :-
	open(NazwaPliku, read, Strumien),
	scanner(Strumien, Tokeny),
	close(Strumien),
	phrase(program(Program), Tokeny),
	interpreter(Program).