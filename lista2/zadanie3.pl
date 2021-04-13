%arc(a,b). arc(b,a). arc(b,c). arc(c,d).

osiągalny(X,Y) :-
    Y = X.
osiągalny(X,Y) :-   
    ścieżka(X,Y,[]).            

ścieżka(X,Y,L) :-       
  arc(X,A),        
  \+ member(A,L), 
  (                 
    Y = A            
  ;                  
    ścieżka(A,Y,[X|L])  
  ).                  
