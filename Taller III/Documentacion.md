# Taller 3 - Estructuras de Datos y Listas en Prolog

**Universidad Tecnológica de Pereira (UTP)**  
**Facultad de Ingenierías**  
**Ingeniería de Sistemas y Computación**  
**Asignatura:** Programación III  
**Docente:** Prof. Ramiro A. Barrios Valencia  

---

## Descripción del Taller

El objetivo de esta actividad consiste en rediseñar y refactorizar las soluciones desarrolladas en los talleres anteriores, migrando de bases de conocimiento con **hechos planos/atómicos** hacia representaciones basadas en **estructuras compuestas (términos complejos)** y **listas**.

Esta transformación modulariza los datos, optimiza el almacenamiento de información relacional y adapta las reglas lógicas para que continúen resolviendo las mismas consultas sin alterar la semántica del problema.

---

## Archivos del Taller

```
Taller III/
├── README.md                 # Documentación técnica del taller (este archivo)
├── simpson_estructuras.pl    # Ejercicio 1: Árbol Simpson con estructuras y listas
└── grafo_estructuras.pl      # Ejercicio 2: Grafo de Canadá con listas de adyacencia
```

---

## Ejercicio 1: Familia Simpson (`simpson_estructuras.pl`)

### 1. Transformación Conceptual del Modelo

* **Antes (Taller 1):** Múltiples hechos atómicos dispersos (`padre/2`, `madre/2`, `hombre/1`, `mujer/1`).
* **Ahora (Taller 3):** 
  * Estructura compuesta para personas: `persona(Nombre, Apellido)`.
  * Estructura compuesta para familias: `familia(Padre, Madre, ListaDeHijos)`.
  * Agrupación de géneros en listas declarativas con términos complejos: `hombres([...])` y `mujeres([...])`.

```prolog
familia(persona(abraham, simpson), persona(mona, simpson),
    [persona(herbert, powell), persona(homero, simpson)]).

familia(persona(clancy, bouvier), persona(jacqueline, bouvier),
    [persona(marge, bouvier), persona(patty, bouvier), persona(selma, bouvier)]).

familia(persona(homero, simpson), persona(marge, bouvier),
    [persona(bart, simpson), persona(lisa, simpson), persona(maggie, simpson)]).

familia(desconocido, persona(selma, bouvier),
    [persona(ling, bouvier)]).
```

### 2. Mecanismos de Inferencia y Desempaquetado

* **Extracción de miembros con `member/2`:** Para relacionar a padres e hijos, se examina la pertenencia dentro de la lista de descendientes sin importar el apellido:
  ```prolog
  padre(P, H) :-
      familia(persona(P, _), _, Hijos),
      member(persona(H, _), Hijos).
  ```
* **Fraternidad inmediata en lista:** Si dos personas están en la misma lista `Hijos` de un hecho `familia/3`, son hermanos de sangre directamente:
  ```prolog
  hermanos_sangre(X, Y) :-
      familia(_, _, Hijos),
      member(persona(X, _), Hijos),
      member(persona(Y, _), Hijos),
      X \= Y.
  ```
* **Consultas de orden superior y conteo:**
  * `hijos_de(P, Hijos)`: Agrupa los hijos de una persona mediante `findall/3`.
  * `numero_hijos(P, N)`: Calcula la cardinalidad de la lista con `length/2`.
  * `apellido(Nombre, Apellido)`: Realiza una búsqueda unificada que analiza si la persona actúa como padre, madre o miembro de la lista de descendencia, cortando la exploración con `!` tras resolver.

### 3. Consultas de Verificación en SWI-Prolog

```prolog
% Carga del archivo
?- [simpson_estructuras].

% Abuelos de Bart
?- abuelo(A, bart).
A = abraham ;
A = clancy.

% Hermanos de Lisa
?- hermano(H, lisa).
H = bart.

% Consulta de lista de hijos y cardinalidad
?- hijos_de(homero, H).
H = [bart, lisa, maggie].

?- numero_hijos(homero, N).
N = 3.

% Extracción de apellido desde la estructura
?- apellido(herbert, Ap).
Ap = powell.
```

---

## Ejercicio 2: Grafo de Canadá (`grafo_estructuras.pl`)

### 1. Transformación Conceptual del Modelo

* **Antes (Taller 2):** 9 hechos ternarios individuales `arista(Origen, Destino, Costo).`
* **Ahora (Taller 3):** Un hecho por cada nodo representativo mediante **listas de adyacencia**, utilizando estructuras de par clave-valor `Destino-Costo`:

```prolog
adyacencias(vancouver, [edmonton-16, calgary-13]).
adyacencias(edmonton,  [saskatoon-12]).
adyacencias(calgary,   [edmonton-4, regina-14]).
adyacencias(saskatoon, [calgary-9, winnipeg-20]).
adyacencias(regina,    [saskatoon-7, winnipeg-4]).
adyacencias(winnipeg,  []).
```

### 2. Regla Puente y Adaptación de Predicados

* **Regla Puente (`arista/3`):** Desempaqueta las aristas directamente desde las estructuras de la lista con `member/2`:
  ```prolog
  arista(Origen, Destino, Costo) :-
      adyacencias(Origen, Conexiones),
      member(Destino-Costo, Conexiones).
  ```
* **Acceso $O(1)$ a destinos:** En lugar de recorrer toda la base de hechos con `findall/3`, las conexiones salientes se obtienen de forma directa:
  ```prolog
  nodos_conectados(Ciudad, Conexiones) :-
      adyacencias(Ciudad, Conexiones).
  ```
* **Prevención de bucles:** El grafo presenta el ciclo $edmonton \rightarrow saskatoon \rightarrow calgary \rightarrow edmonton$. Para evitar recursión infinita en backtracking, se emplea acumulación de nodos en `Visitados` mediante el operador de negación por fallo `\+ member(Z, Visitados)`:
  ```prolog
  camino(X, Y, _) :- arista(X, Y, _).
  camino(X, Y, Visitados) :-
      arista(X, Z, _),
      \+ member(Z, Visitados),
      camino(Z, Y, [Z | Visitados]).
  ```

### 3. Consultas de Verificación en SWI-Prolog

```prolog
% Carga del archivo
?- [grafo_estructuras].

% Conexiones directas y costos desde Regina
?- nodos_conectados(regina, C).
C = [saskatoon-7, winnipeg-4].

% Conexión imposible (Vancouver es nodo fuente)
?- conexion_entre(saskatoon, vancouver).
false.

% Viaje entre Edmonton y Calgary (atraviesa ciclo dirigido)
?- conexion_entre(edmonton, calgary).
true.

% Costo acumulado con parada intermedia
?- costo_con_parada_en(edmonton, saskatoon, calgary, Total).
Total = 21.
```

---

## Guía de Ejecución

1. Abrir una terminal en el directorio `Taller III`:
   ```bash
   cd "Taller III"
   ```
2. Iniciar el entorno interactivo de SWI-Prolog cargando el archivo deseado:
   ```bash
   swipl simpson_estructuras.pl
   # o
   swipl grafo_estructuras.pl
   ```
3. Ejecutar las metas lógicas deseadas terminando siempre con punto final (`.`).
4. Para cerrar la sesión en Prolog:
   ```prolog
   ?- halt.
   ```