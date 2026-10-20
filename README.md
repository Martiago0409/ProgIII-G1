# Programación III (ProgIII-G1)

**Universidad Tecnológica de Pereira (UTP)**  
**Facultad de Ingenierías**  
**Ingeniería de Sistemas y Computación**

## Descripción del Repositorio

Este repositorio contiene las soluciones, talleres prácticos, proyectos y ejercicios de laboratorio desarrollados a lo largo del curso de **Programación III**. El propósito del espacio es documentar de forma estructurada el aprendizaje y dominio de paradigmas de programación no imperativos y avanzados, tales como:

* **Paradigma Funcional:** Razonamiento formal mediante funciones puras, recursión de cola, orden superior y evaluación perezosa/aplicativa (e.g., Racket / Scheme).
* **Paradigma Lógico:** Modelado declarativo de bases de conocimiento, lógica de predicados de primer orden, cláusulas de Horn, resolución, unificación, términos complejos y listas (e.g., SWI-Prolog).
* **Diseño e Implementación de Lenguajes:** Intérpretes, sintaxis abstracta (AST) y sistemas de tipos si aplican durante el semestre.

## Tecnologías y Requisitos

Para clonar, ejecutar y verificar las prácticas de este repositorio se requiere:

* **Git:** Para control de versiones y sincronización con GitHub.
* **SWI-Prolog:** Intérprete oficial para la sección lógica del curso (`swipl --version` $\ge$ 9.x).
* **Racket / DrRacket:** Entorno y compilador para las prácticas de programación funcional.
* **Visual Studio Code:** Editor principal recomendado junto con las extensiones de *Prolog* (por Arthur Wang) y extensiones de resaltado sintáctico funcional.

## Guía Rápida de Clonación y Uso

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/Martiago0409/ProgIII-G1.git
   cd ProgIII-G1
   ```

2. **Ejecutar un taller específico (ejemplo Taller 3 en Prolog):**
   ```bash
   cd "Taller III"
   swipl simpson_estructuras.pl
   # o
   swipl grafo_estructuras.pl
   ```

3. **Consultas en consola interactiva:**
   Una vez dentro del prompt `?-`, escribe consultas terminadas en punto (`.`), usa punto y coma (`;`) para solicitar más soluciones mediante *backtracking*, y sal con:
   ```prolog
   ?- halt.
   ```

## Registro de Entregas y Talleres

| Módulo / Taller | Paradigma / Lenguaje | Temas Principales | Estado |
|---|---|---|:---:|
| **Taller I** | Lógico (SWI-Prolog) | Hechos, reglas, backtracking, unificación, Cláusulas de Horn | ✅ Completado |
| **Taller II** | Lógico (SWI-Prolog) | Grafos dirigidos ponderados, acumulación de costos, ciclos, resolución SLD | ✅ Completado |
| **Taller III** | Lógico (SWI-Prolog) | Estructuras complejas (`persona/2`, `familia/3`), listas de adyacencia, pares clave-valor | ✅ Completado |

## Autores y Colaboradores Principales

* **Santiago** – Estudiante de Ingeniería de Sistemas y Computación, Universidad Tecnológica de Pereira.
* **Jimena Betancur García** – Estudiante de Ingeniería de Sistemas y Computación, Universidad Tecnológica de Pereira.
* **Mateo Bedoya Toro** – Estudiante de Ingeniería de Sistemas y Computación, Universidad Tecnológica de Pereira.