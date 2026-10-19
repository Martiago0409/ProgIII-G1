%Hechos
padre(abraham, homero).
padre(abraham, herbert).
padre(homero, bart).
padre(homero, lisa).
padre(homero, maggie).
padre(clancy, marge).
padre(clancy, patty). 
padre(clancy, selma).

madre(mona, homero).
madre(jacqueline, marge).
madre(jacqueline, patty).
madre(jacqueline, selma).
madre(marge, bart).
madre(marge, lisa).
madre(marge, maggie).
madre(selma, ling).

hombre(abraham).
hombre(herbert).
hombre(homero).
hombre(clancy).
hombre(bart).

mujer(mona).
mujer(jacqueline).
mujer(marge).
mujer(patty).
mujer(selma).
mujer(lisa).
mujer(maggie).
mujer(ling).

%Progenitor
progenitor(X, Y) :- padre(X, Y).
progenitor(X, Y) :- madre(X, Y).
% Abuelos
abuelo(X, Z) :- hombre(X), progenitor(X, Y), progenitor(Y, Z).
abuela(X, Z) :- mujer(X),  progenitor(X, Y), progenitor(Y, Z).
% Hermanos
hermano(X, Y) :- hombre(X), progenitor(Z, X), progenitor(Z, Y), X \= Y.
hermana(X, Y) :- mujer(X),  progenitor(Z, X), progenitor(Z, Y), X \= Y.
% Tíos
tio(X, Y) :- hermano(X, Z), progenitor(Z, Y).
tia(X, Y) :- hermana(X, Z), progenitor(Z, Y).
% Primos
primo(X, Y) :- hombre(X), progenitor(T, X), (tio(T, Y) ; tia(T, Y)).
prima(X, Y) :- mujer(X),  progenitor(T, X), (tio(T, Y) ; tia(T, Y)).

