:-style_check(-singleton).


jest_matką(X) :- 
	matka(X, _).
jest_ojcem(X) :- 
	ojciec(X, _).
siostra(X, Y) :- 
	kobieta(X), 
	ojciec(O, X), 
	ojciec(O, Y),
	matka(M, X),
	matka(M, Y), 
	X \= Y.
dziadek(X, Y) :- 
	ojciec(X, R), 
	rodzic(R, Y).
rodzeństwo(X, Y) :- 
	ojciec(O, X), 
	ojciec(O, Y), 
	matka(M, X), 
	matka(M, Y), 
	X \= Y.
jest_synem(X) :- 
	mężczyzna(X), 
	rodzic(_, X).

mężczyzna(piotrek). 
mężczyzna(janusz). 
mężczyzna(jarosław).
kobieta(grażyna). 
kobieta(dżesika). 
ojciec(jarosław, janusz).
ojciec(janusz, dżesika). 
ojciec(janusz, piotrek). 
matka(grażyna, dżesika). 
matka(grażyna, piotrek). 
rodzic(janusz, dżesika). 
rodzic(janusz, piotrek). 
rodzic(grażyna, dżesika). 
rodzic(grażyna, piotrek).
rodzic(jarosław, janusz).

