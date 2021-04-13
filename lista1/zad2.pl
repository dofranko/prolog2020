on(blok6, blok5).
on(blok5, blok4).
on(blok4, blok3).
on(blok3, blok2).
on(blok2, blok1).
on(blok1, blok0).

above(Block1, Block2) :- 
    on(Block1, Block2).

above(Block1, Block2) :- 
    on(Block1, X), 
    above(X, Block2).
