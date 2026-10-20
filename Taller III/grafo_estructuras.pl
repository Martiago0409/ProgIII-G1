% 1. BASE DE CONOCIMIENTO (Listas de Adyacencia con estructuras Destino-Costo)

adyacencias(vancouver, [edmonton-16, calgary-13]).
adyacencias(edmonton,  [saskatoon-12]).
adyacencias(calgary,   [edmonton-4, regina-14]).
adyacencias(saskatoon, [calgary-9, winnipeg-20]).
adyacencias(regina,    [saskatoon-7, winnipeg-4]).
adyacencias(winnipeg,  []).

% 2. REGLA PUENTE: Desempaqueta aristas individuales desde la lista

% Extrae cada arista con su costo utilizando member/2 sobre la lista de adyacencias.
arista(Origen, Destino, Costo) :-
    adyacencias(Origen, Conexiones),
    member(Destino-Costo, Conexiones).

% 3. REGLAS ADAPTADAS DEL TALLER II

% Un nodo tiene aristas si su lista de conexiones no está vacía [_|_] o si aparece como destino en la lista de conexiones de algún otro nodo.
tiene_arista(Nodo) :-
    adyacencias(Nodo, [_|_]), !.
tiene_arista(Nodo) :-
    adyacencias(_, Conexiones),
    member(Nodo-_, Conexiones), !.

% Retorna directamente la lista completa de conexiones salientes y sus costos. Ya no requiere findall/3 porque la lista está almacenada en la estructura.
nodos_conectados(Ciudad, Conexiones) :-
    adyacencias(Ciudad, Conexiones).

% Distancia inmediata entre dos ciudades conectadas.
distancia_directa(Ciudad1, Ciudad2, Distancia) :-
    arista(Ciudad1, Ciudad2, Distancia).

% Calcula el costo de viajar de Ciudad1 a Ciudad3 con escala obligatoria en Ciudad2.
costo_con_parada_en(Ciudad1, Ciudad2, Ciudad3, CostoTotal) :-
    arista(Ciudad1, Ciudad2, Costo1),
    arista(Ciudad2, Ciudad3, Costo2),
    CostoTotal is Costo1 + Costo2.

% 4. CONECTIVIDAD GENERAL Y CONTROL DE CICLOS (SLD + BACKTRACKING)

% Conexión directa
conexion_entre(X, Y) :- arista(X, Y, _).

% Conexión de 2 o más saltos evitando bucles infinitos mediante lista de visitados
conexion_entre(X, Y) :- camino(X, Y, [X]).

camino(X, Y, _) :- arista(X, Y, _).
camino(X, Y, Visitados) :-
    arista(X, Z, _),
    \+ member(Z, Visitados),
    camino(Z, Y, [Z | Visitados]).

% Ruta con cálculo del costo total acumulado
camino_costo(X, Y, Costo, _) :-
    arista(X, Y, Costo).
camino_costo(X, Y, CostoTotal, Visitados) :-
    arista(X, Z, C1),
    \+ member(Z, Visitados),
    camino_costo(Z, Y, C2, [Z | Visitados]),
    CostoTotal is C1 + C2.