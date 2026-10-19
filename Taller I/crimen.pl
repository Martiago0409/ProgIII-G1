%Hechos
estadounidense(west).
enemigos(corea_sur, estados_unidos).
misil(misil1).
posee(corea_sur, misil1).

%Hechos adicionales
arma(X) :- misil(X).
hostil(P) :- enemigos(P, estados_unidos).
vende(west, X, corea_sur) :- arma(X), posee(corea_sur, X).

%Reglas
criminal(X) :-
    estadounidense(X),
    arma(Y),
    vende(X, Y, Z),
    hostil(Z).




