rybki(Kto) :-
    DOMY = [_,_,_,_,_],
    %dom(narodowosc, kolor, papierosy, napoj, zwierze)
    DOMY = [dom(norweg, _,_,_,_), _, _, _, _],
    member(dom(anglik, czerwony, _,_,_), DOMY),
    po_lewej(dom(_, zielony, _,_,_), dom(_, biały, _,_,_), DOMY),
    member(dom(duńczyk, _, _,herbata,_), DOMY),
    obok(dom(_, _,light,_,_),dom(_, _, _,_,koty),DOMY),
    member(dom(_, żółty,cygaro,_,_), DOMY),
    member(dom(niemiec, _, fajka,_,_), DOMY),
    DOMY = [_, _, dom(_, _, _,mleko,_), _, _],
    obok(dom(_, _, light,_,_), dom(_, _, _,woda,_), DOMY),
    member(dom(_, _, bez_filtra,_,psy), DOMY),
    member(dom(szwed, _, _,_,psy),DOMY),
    obok(dom(norweg, _, _,_,_),dom(_, niebieski, _,_,_), DOMY),
    obok(dom(_, _, _,_,konie),dom(_, żółty, _,_,_),DOMY),
    member(dom(_, _, mentolowe,piwo,_), DOMY),
    member(dom(_, zielony, _,kawa,_), DOMY),
    member(dom(Kto, _, _,_,rybki), DOMY).

po_lewej(X, Y, L) :-
    append(_, [X, Y | _], L).
    
po_prawej(X, Y, L) :-
    append(_, [Y, X | _], L).
    
obok(X, Y, L) :-
    po_lewej(X, Y, L).
obok(X, Y, L) :-
    po_prawej(X, Y, L).
    