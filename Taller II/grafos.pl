% Hechos(Origen, Destino, Costo)
arista(vancouver, edmonton, 16).
arista(vancouver, calgary, 13).
arista(calgary, edmonton, 4).
arista(edmonton, saskatoon, 12).
arista(saskatoon, calgary, 9).
arista(calgary, regina, 14).
arista(regina, saskatoon, 7).
arista(saskatoon, winnipeg, 20).
arista(regina, winnipeg, 4).

% reglas
% Determina si un nodo pertenece al grafo verificando si tiene al menos una arista de salida o una arista de entrada
tiene_arista(Nodo) :- arista(Nodo, _, _), !.
tiene_arista(Nodo) :- arista(_, Nodo, _), !.
% Consulta directa para obtener la distancia o costo inmediato entre dos ciudades conectadas.
distancia_directa(Ciudad1, Ciudad2, Distancia) :-
    arista(Ciudad1, Ciudad2, Distancia).
% Calcula el costo total de viajar de Ciudad1 a Ciudad3 haciendo escala obligatoria en Ciudad2.
costo_con_parada_en(Ciudad1, Ciudad2, Ciudad3, CostoTotal) :-
    arista(Ciudad1, Ciudad2, Costo1),
    arista(Ciudad2, Ciudad3, Costo2),
    CostoTotal is Costo1 + Costo2.
% Verifica si existe conexión entre dos ciudades, ya sea de forma directao mediante una búsqueda recursiva que registra visitados para prevenir bucles infinitos.
conexion_entre(X, Y) :- arista(X, Y, _).
conexion_entre(X, Y) :- camino(X, Y, [X]).
% Caso base del camino: existe una arista directa entre X e Y.
camino(X, Y, _) :- arista(X, Y, _).
% Caso recursivo del camino: avanza a un nodo intermedio Z que no haya sido visitado previamente y continúa la búsqueda hacia Y.
camino(X, Y, Visitados) :-
    arista(X, Z, _),
    \+ member(Z, Visitados),
    camino(Z, Y, [Z | Visitados]).
% Recopila en una lista todas las ciudades de destino alcanzables directamente desde una ciudad origen, junto con el costo asociado a cada una (formato Destino-Costo).
nodos_conectados(Ciudad, Conexiones) :-
    findall(Dest-Costo, arista(Ciudad, Dest, Costo), Conexiones).