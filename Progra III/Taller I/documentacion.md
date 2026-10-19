# Taller 1 - Programación III

**Universidad Tecnológica de Pereira**  
**Facultad de Ingenierías**  
**Ingeniería de Sistemas y Computación**  

---

## Descripción General

Este taller corresponde a la introducción práctica a la programación lógica declarativa utilizando el dialecto **SWI-Prolog**. Se abordaron dos problemas clásicos del paradigma lógico:
1. Representación de conocimiento jerárquico mediante árboles genealógicos (diferenciando hechos directos de reglas inferenciales).
2. Representación de conocimiento normativo y deducción formal en lógica de primer orden (caso de inferencia legal del Coronel West).

---

## Estructura de Archivos

```text
Taller I/
├── README.md               # Documentación explicativa del taller
├── familia_simpson.pl      # Punto 1: Modelado del árbol genealógico
└── crimen.pl               # Punto 2: Sistema de deducción formal de crimen
```

---

## Punto 1: Árbol Genealógico Simpson (`familia_simpson.pl`)

### 1. Planteamiento del problema
A partir de un diagrama genealógico de la familia Simpson, modelar una base de conocimiento donde:
* Las **relaciones directas** (exactamente 1 generación) deben definirse estrictamente mediante **hechos**.
* Las **relaciones derivadas** (más de una generación o relaciones colaterales como abuelos, tíos, hermanos y primos) deben obtenerse mediante **reglas de inferencia**.

### 2. Estrategia de Modelado
* **Hechos base:** Se declararon hechos explícitos para paternidad/maternidad (`padre/2`, `madre/2`) y clasificación de género unaria (`hombre/1`, `mujer/1`). Esto evita ambigüedades en personajes sin descendencia (como Herbert, Patty, Bart o Ling).
* **Predicado auxiliar neutro:** Se definió `progenitor(X, Y)` como una disyunción lógica de ser padre o madre, permitiendo abstraer el parentesco biológico.
* **Desigualdad de identidad:** En las reglas de fraternidad (`hermano/2`, `hermana/2`), se utilizó el operador de no-unificación/desigualdad `X \= Y` para impedir que un individuo sea considerado hermano de sí mismo.
* **Relaciones compuestas:**
  * **Abuelo / Abuela:** $X$ es abuelo de $Z$ si $X$ es hombre, progenitor de una persona intermedia $Y$, y esa persona $Y$ es progenitora de $Z$.
  * **Tío / Tía:** $X$ es tío de $Y$ si $X$ es hermano del progenitor $Z$ de $Y$.
  * **Primo / Prima:** Se definió de forma modular directa: $X$ es primo de $Y$ si $X$ es varón y es hijo de alguien que resulta ser tío o tía de $Y$.

### 3. Consultas de Verificación en SWI-Prolog
```prolog
% Carga del archivo
?- [familia_simpson].

% 1. Abuelos de Bart (debe unificar con Abraham y Clancy)
?- abuelo(X, bart).
X = abraham ;
X = clancy.

% 2. Tíos y tías de Bart (Herbert por el lado paterno, Patty y Selma por el lado materno)
?- tio(X, bart).
X = herbert.

?- tia(X, bart).
X = patty ;
X = selma.

% 3. Primos y primas de Ling
?- primo(X, ling).
X = bart.

?- prima(X, ling).
X = lisa ;
X = maggie.
```

---

## Punto 2: Deducción Formal del Coronel West (`crimen.pl`)

### 1. Planteamiento del problema
Formalizar en cláusulas de Horn el siguiente problema de lógica de primer orden:
> *"La ley dice que es un crimen para un Estadounidense vender armas a naciones hostiles. Corea del Sur, enemigo de Estados Unidos, tiene algunos misiles, y todos sus misiles les fueron vendidos por el Coronel West, quien es Estadounidense. Pruebe que el Col. West es un criminal."*

### 2. Representación del Conocimiento

#### Hechos atómicos:
* `estadounidense(west).` (Nacionalidad de West).
* `enemigos(corea_sur, estados_unidos).` (Relación diplomática bilateral).
* `misil(misil1).` (Existencia de un armamento específico).
* `posee(corea_sur, misil1).` (Posesión del armamento por parte de la nación).

#### Reglas de inferencia y definiciones:
* **Categorización de armamento:** Un misil califica formalmente como arma:  
  `arma(X) :- misil(X).`
* **Definición de nación hostil:** Un país es considerado hostil si califica como enemigo de los Estados Unidos:  
  `hostil(P) :- enemigos(P, estados_unidos).`
* **Relación de compraventa:** Todos los misiles poseídos por Corea del Sur provinieron de una venta realizada por West:  
  `vende(west, X, corea_sur) :- arma(X), posee(corea_sur, X).`
* **La Ley (Estatuto penal):** Una persona $X$ es catalogada criminal si es estadounidense, vendió un objeto $Y$ a una nación $Z$, el objeto $Y$ es un arma y la nación $Z$ es hostil:  
  ```prolog
  criminal(X) :-
      estadounidense(X),
      arma(Y),
      vende(X, Y, Z),
      hostil(Z).
  ```

### 3. Prueba y Meta de Demostración
La resolución de la meta principal verifica el encadenamiento de inferencias hacia atrás (*backward chaining*):

```prolog
% Carga del archivo
?- [crimen].

% Consulta de demostración
?- criminal(west).
true.
```

---

## Instrucciones de Ejecución

Para correr y probar cualquiera de los dos ejercicios:

1. Abrir la terminal en la raíz del taller:
   ```bash
   cd "Taller I"
   ```
2. Iniciar el entorno de SWI-Prolog cargando el archivo deseado:
   ```bash
   swipl familia_simpson.pl
   # o
   swipl crimen.pl
   ```
3. Ejecutar las consultas usando punto final (`.`). Para pedir soluciones adicionales usar punto y coma (`;`). Para salir del entorno interactivo:
   ```prolog
   ?- halt.
   ```