% 1. HECHOS Y ESTRUCTURAS DE DATOS

% Estructura persona: persona(Nombre, Apellido)
% Estructura familia: familia(Padre, Madre, ListaDeHijos)
% Se usa el átomo 'desconocido' cuando el árbol no muestra al progenitor.

familia(persona(abraham, simpson), persona(mona, simpson),
    [persona(herbert, powell), persona(homero, simpson)]).

familia(persona(clancy, bouvier), persona(jacqueline, bouvier),
    [persona(marge, bouvier), persona(patty, bouvier), persona(selma, bouvier)]).

familia(persona(homero, simpson), persona(marge, bouvier),
    [persona(bart, simpson), persona(lisa, simpson), persona(maggie, simpson)]).

familia(desconocido, persona(selma, bouvier),
    [persona(ling, bouvier)]).

% Listas de géneros representadas con estructuras persona/2
hombres([
    persona(abraham, simpson),
    persona(herbert, powell),
    persona(homero, simpson),
    persona(clancy, bouvier),
    persona(bart, simpson)
]).

mujeres([
    persona(mona, simpson),
    persona(jacqueline, bouvier),
    persona(marge, bouvier),
    persona(patty, bouvier),
    persona(selma, bouvier),
    persona(lisa, simpson),
    persona(maggie, simpson),
    persona(ling, bouvier)
]).

% 2. REGLAS AUXILIARES Y GÉNERO

% Identificación de género
hombre(X) :- hombres(L), member(persona(X, _), L).
mujer(X)  :- mujeres(L), member(persona(X, _), L).

% Relaciones directas de progenitores extrayendo de familia/3 con member/2
padre(P, H) :-
    familia(persona(P, _), _, Hijos),
    member(persona(H, _), Hijos).

madre(M, H) :-
    familia(_, persona(M, _), Hijos),
    member(persona(H, _), Hijos).

progenitor(X, Y) :- padre(X, Y).
progenitor(X, Y) :- madre(X, Y).

% 3. REGLAS DE PARENTESCO (HERMANOS, ABUELOS, TÍOS, PRIMOS)

% Hermanos de sangre: comparten la misma lista de hijos en la estructura familiar
hermanos_sangre(X, Y) :-
    familia(_, _, Hijos),
    member(persona(X, _), Hijos),
    member(persona(Y, _), Hijos),
    X \= Y.

hermano(X, Y) :- hombre(X), hermanos_sangre(X, Y).
hermana(X, Y) :- mujer(X),  hermanos_sangre(X, Y).

% Abuelos y abuelas
abuelo(X, Z) :- hombre(X), progenitor(X, Y), progenitor(Y, Z).
abuela(X, Z) :- mujer(X),  progenitor(X, Y), progenitor(Y, Z).

% Tíos y tías
tio(T, S) :- hermano(T, P), progenitor(P, S).
tia(T, S) :- hermana(T, P), progenitor(P, S).

% Primos y primas
primo(P, X) :- hombre(P), progenitor(T, P), (tio(T, X) ; tia(T, X)).
prima(P, X) :- mujer(P),  progenitor(T, P), (tio(T, X) ; tia(T, X)).

% 4. REGLAS ADICIONALES

% Consulta y conteo de hijos
hijos_de(P, Hijos) :-
    findall(H, progenitor(P, H), Hijos).

numero_hijos(P, N) :-
    hijos_de(P, Hijos),
    length(Hijos, N).

% Consulta de nietos
nietos_de(A, Nietos) :-
    findall(N, (abuelo(A, N) ; abuela(A, N)), Nietos).

% Extracción del apellido de una persona
apellido(Nombre, Apellido) :-
    familia(P, M, Hijos),
    (   P = persona(Nombre, Apellido)
    ;   M = persona(Nombre, Apellido)
    ;   member(persona(Nombre, Apellido), Hijos)),
    !.