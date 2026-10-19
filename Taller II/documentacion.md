# Taller 2 - Grafos Dirigidos, Backtracking y Resolución SLD

**Universidad Tecnológica de Pereira**  
**Facultad de Ingenierías**  
**Ingeniería de Sistemas y Computación**  

---

##  Descripción del Taller

Este taller aborda el modelado declarativo de **grafos dirigidos ponderados** en Prolog, analizando los mecanismos de **Backtracking** y árboles de **Resolución SLD** (*Selective Linear Definite clause resolution*). 

A través del mapa de rutas entre ciudades canadienses (Vancouver, Edmonton, Calgary, Saskatoon, Regina, Winnipeg), se resuelven problemas de conectividad directa, escalas intermedias, acumulación de costos y prevención de recursión infinita ante la presencia de ciclos dirigidos.

---

##  Archivos del Módulo

```text
Taller II/
├── README.md   # Documentación técnica y sustentación de resultados
└── grafos.pl   # Hechos del grafo y reglas lógicas de conectividad
```

---

##  Modelo del Grafo Dirigido

El sistema de conexiones y costos se representa mediante un predicado ternario `arista(Origen, Destino, Costo)`:

```prolog
% Hechos: arista(Origen, Destino, Costo)
arista(vancouver, edmonton, 16).
arista(vancouver, calgary, 13).
arista(calgary, edmonton, 4).
arista(edmonton, saskatoon, 12).
arista(saskatoon, calgary, 9).
arista(calgary, regina, 14).
arista(regina, saskatoon, 7).
arista(saskatoon, winnipeg, 20).
arista(regina, winnipeg, 4).
```

---

##  Reglas de Inferencia Implementadas

### 1. Pertenencia e Incidencia de Aristas (`tiene_arista/1`)
Evalúa si un nodo forma parte activa del grafo (si posee al menos una arista saliente o entrante). Utiliza el operador de corte (`!`) para evitar que Prolog continúe explorando unificaciones redundantes tras confirmar la existencia:
```prolog
tiene_arista(Nodo) :- arista(Nodo, _, _), !.
tiene_arista(Nodo) :- arista(_, Nodo, _), !.
```

### 2. Distancia Inmediata (`distancia_directa/3`)
Permite consultar la adyacencia directa y el costo asociado entre dos nodos sin escalas intermedias:
```prolog
distancia_directa(Ciudad1, Ciudad2, Distancia) :-
    arista(Ciudad1, Ciudad2, Distancia).
```

### 3. Costo con Parada Obligatoria (`costo_con_parada_en/4`)
Determina el costo acumulado de transitar de una `Ciudad1` a una `Ciudad3` realizando escala obligatoria en `Ciudad2`:
$$\text{CostoTotal} = \text{Costo}_1 + \text{Costo}_2$$
```prolog
costo_con_parada_en(Ciudad1, Ciudad2, Ciudad3, CostoTotal) :-
    arista(Ciudad1, Ciudad2, Costo1),
    arista(Ciudad2, Ciudad3, Costo2),
    CostoTotal is Costo1 + Costo2.
```

### 4. Conectividad y Manejo de Ciclos (`conexion_entre/2` y `camino/3`)
El grafo contiene ciclos dirigidos, por ejemplo:
$$\text{edmonton} \rightarrow \text{saskatoon} \rightarrow \text{calgary} \rightarrow \text{edmonton}$$
Para evitar que el motor de inferencia caiga en un bucle infinito (*stack overflow*) durante el backtracking, se implementa una búsqueda recursiva parametrizada con una lista de nodos `Visitados`:
```prolog
% Conexión directa
conexion_entre(X, Y) :- arista(X, Y, _).
% Conexión recursiva (evitando ciclos)
conexion_entre(X, Y) :- camino(X, Y, [X]).

% Caso base: arista directa
camino(X, Y, _) :- arista(X, Y, _).

% Caso recursivo: salto a un intermediario Z no visitado
camino(X, Y, Visitados) :-
    arista(X, Z, _),
    \+ member(Z, Visitados),
    camino(Z, Y, [Z | Visitados]).
```

### 5. Agrupación de Destinos y Costos (`nodos_conectados/2`)
Utiliza el metapredicado de orden superior `findall/3` para compilar en una sola lista todas las parejas `Destino-Costo` salientes desde un nodo determinado:
```prolog
nodos_conectados(Ciudad, Conexiones) :-
    findall(Dest-Costo, arista(Ciudad, Dest, Costo), Conexiones).
```

---

##  Verificación y Consultas en SWI-Prolog

A continuación se detallan las consultas solicitadas en el taller junto con su fundamentación lógica:

### Pregunta 1: ¿Existe una conexión entre Saskatoon y Vancouver?
* **Consulta:**
  ```prolog
  ?- conexion_entre(saskatoon, vancouver).
  ```
* **Respuesta:** `false.`
* **Justificación:** Vancouver es un nodo puramente fuente en el subgrafo; todas las aristas adyacentes a él son salientes ($vancouver \rightarrow edmonton$, $vancouver \rightarrow calgary$). Ningún camino dirigido en el grafo conduce a Vancouver.

---

### Pregunta 2: ¿Con qué nodos está conectado Regina y cuál es el costo de cada conexión?
* **Consulta:**
  ```prolog
  ?- nodos_conectados(regina, Conexiones).
  ```
* **Respuesta:**
  ```prolog
  Conexiones = [saskatoon-7, winnipeg-4].
  ```
* **Justificación:** Desde Regina existen exactamente dos aristas salientes: hacia Saskatoon (costo 7) y hacia Winnipeg (costo 4).

---

### Pregunta 3: ¿Es posible viajar desde Edmonton a Calgary? (Pregunta central)
* **Consulta:**
  ```prolog
  ?- conexion_entre(edmonton, calgary).
  ```
* **Respuesta:** `true.`
* **Justificación / Traza SLD:**  
  Aunque no existe una arista directa $edmonton \rightarrow calgary$, Prolog realiza el siguiente encadenamiento lógico:
  1. Selecciona la arista saliente de Edmonton: $edmonton \rightarrow saskatoon$ (costo 12).
  2. Evalúa recursivamente `camino(saskatoon, calgary, [saskatoon, edmonton])`.
  3. Encuentra la arista base directa $saskatoon \rightarrow calgary$ (costo 9).
  4. La meta unifica exitosamente con la cláusula vacía ($\square$), demostrando la existencia de la ruta.

---

##  Instrucciones de Ejecución

1. Abrir la terminal en la carpeta del taller:
   ```bash
   cd "Taller II"
   ```
2. Cargar el archivo en SWI-Prolog:
   ```bash
   swipl grafos.pl
   ```
3. Ejecutar las consultas y cerrar la sesión con:
   ```prolog
   ?- halt.
   ```