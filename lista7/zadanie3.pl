%[Filozofowie]                                    [A]
%(Widelce)                                   (5)        (1)
%                                          [E]            [B]                                          
%                                            (4)        (2)
%                                              [D]   [C]
%                                                 (3)


%With_mutex'y zastosowane, żeby wątki nie wchodziły sobie w paradę w czasie wykonywania write'a
loop(Filozof, LewyWidelec, PrawyWidelec) :-
    %Myśli
    with_mutex(write, (write(Filozof), write(' mysli.'), nl)),

    %Chce i podnosi lewy widelec
    with_mutex(write, (write(Filozof), write(' chce podniesc lewy widelec.'), nl)),
    mutex_lock(LewyWidelec),
    with_mutex(write, (write(Filozof), write(' podnosi lewy widelec.'), nl)),
    
    %Chce i podnosi prawy widelec
    with_mutex(write, (write(Filozof), write(' chce podniesc prawy widelec.'), nl)),
    mutex_lock(PrawyWidelec),
    with_mutex(write, (write(Filozof), write(' podnosi prawy widelec.'), nl)),

    %Je
    with_mutex(write, (write(Filozof), write(' je.'), nl)),
    %sleep(3),

    %Odkłada lewy widelec
    with_mutex(write, (write(Filozof), write(' odkłada lewy widelec.'), nl)),
    mutex_unlock(LewyWidelec),

    %Odkłada prawy widelec
    with_mutex(write, (write(Filozof), write(' odkłada prawy widelec.'), nl)),
    mutex_unlock(PrawyWidelec),

    loop(Filozof, LewyWidelec, PrawyWidelec).


filozofowie :-
    %Widelce 
	mutex_create(Widelec1),
	mutex_create(Widelec2),
	mutex_create(Widelec3),
	mutex_create(Widelec4),
    mutex_create(Widelec5),
    %Filozofowie
	thread_create(loop('Filozof A', Widelec1, Widelec5), FilozofA, []),
	thread_create(loop('Filozof B', Widelec2, Widelec1), FilozofB, []),
	thread_create(loop('Filozof C', Widelec3, Widelec2), FilozofC, []),
	thread_create(loop('Filozof D', Widelec4, Widelec3), FilozofD, []),
	thread_create(loop('Filozof E', Widelec5, Widelec4), FilozofE, []),
	
	thread_join(FilozofA, _),
	thread_join(FilozofB, _),
	thread_join(FilozofC, _),
	thread_join(FilozofD, _),
	thread_join(FilozofE, _).


%Pytanie: Czy możliwe jest zakleszczenie się filozofów (każdy z nich czeka na jeden z widelców 
% i nie może kontynuować swojego działania)?

%Odp:TAK. Jak się włączy program bez sleep/1'ów, to dosyć szybko filozofowie przestają działać, 
%bo każdy ma po jednym (lewym) widelcu.