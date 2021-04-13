:- use_module(library(clpfd)).


tasks([
        [2, 1, 3],
        [3, 2, 1],
        [4, 2, 2],
        [3, 3, 2],
        [3, 1, 1],
        [3, 4, 2],
        [5, 2, 1]
    ]).

resources(5, 5).

schedule(Horizon, Starts, MakeSpan) :-
    %Etap przygotowan i ograniczen
    MakeSpan #=< Horizon,   %Mam nadzieje, ze takie ograniczenie mialo tu byc
    tasks(Tasks),
    resources(R1, R2),

    length(Tasks, N),
    length(Starts, N),
    length(Ends, N),
    Starts ins 0..Horizon,
    Ends ins 0..Horizon,
    MakeSpan in 0..Horizon,

    list_max(Ends, MakeSpan),
    prepare_tasks(Tasks, Starts, Ends, [], [], Prepared_tasks_R1, Prepared_tasks_R2),

    %Etap szukania rozwiazania :D
    cumulative(Prepared_tasks_R1, [limit(R1)]),
    cumulative(Prepared_tasks_R2, [limit(R2)]),
    once(labeling([min(MakeSpan)], Starts)). 

%Przygotowanie task'ów. (cumulative/2 wymaga odpowiednio przygotowanej tablicy wejściowej)
prepare_tasks([], [], [], Tail_R1, Tail_R2, Tail_R1, Tail_R2).
prepare_tasks([[Duration, Res1, Res2]|T1], [Start|T2], [End|T3], Tail_R1, Tail_R2, Prepared_R1, Prepared_R2) :-
    append(Tail_R1, [task(Start, Duration, End, Res1, 0)], Tail_R1_2),
    append(Tail_R2, [task(Start, Duration, End, Res2, 0)], Tail_R2_2),
    prepare_tasks(T1, T2, T3, Tail_R1_2, Tail_R2_2, Prepared_R1, Prepared_R2).

%Do zmiennej Max przypisywana jest max wartosc z calej listy (nie widzialem wbudowanego predykatu na to)
list_max([L|Ls], Max) :-
    list_max_(Ls, L, Max).

list_max_([], Max, Max).
list_max_([L|Ls], Max0, Max) :-
    Max1 #= max(Max0,L),
    list_max_(Ls, Max1, Max).
