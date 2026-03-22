;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |TALLER 2 Santiago Osorio Aramburo|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;Ejercicio 1
;ncuadrado+10
;la funcion multiplica n al cuadrado y le suma 10
;(ncuadrado+10 num) -> num
;ejemplo: (ncuadrado+10 100) -> 10010
(define (ncuadrado+10 n)
  (+(sqr n) 10)
  )
;(Val-Ejer1 cualquiera) -> num o ERROR
;La funcion valida que la entrada sea numerica antes de reducirla
(define (Val-Ejer1 n)
  (if (number? n)
      (ncuadrado+10 n)
      "ERROR en tipo de dato"
      )
  )
;Prueba
(Val-Ejer1 100)
;-------------------------------------------
;Ejercicio 2
;Ej2 -> Resolver la expresión (1/2) - n2 * 20.
;La funcion le resta la multiplicacion de n al cuadrado y 20 a (1/2).
;(Ej2 num num) -> num
;ejemplo: (Ej2 10) -> -1999.5
(define (Ej2 n)
  (-(/ 1 2)(* (sqr n)20))
  )
;(Val-Ejer2 cualquiera) -> num o ERROR
;La funcion valida que la entrada sea numerica antes de reducirla
(define (Val-Ejer2 n)
  (if (number? n)
            (Ej2 n)
            "ERROR en tipo de dato"
            )
  )
;Prueba
(Val-Ejer2 10)
;-------------------------------------------
;Ejercicio 3
;longitudR Medir la longitud de la circunferencia, dado el radio.
;Longitud de la circunferencia igual a multiplicar pi por el radio por 2
;(longitudR num) -> num
;Ejemplo: (longitudR 10) -> i62.83185307179586
(define (longitudR r)
  (* 2 pi r)
  )
;(Val-Ejer3 cualquiera) -> num o ERROR
;La funcion valida que la entrada sea numerica antes de reducirla
;La funcion valida que la entrada sea positiva.
(define (Val-Ejer3 r)
  (if (and (> r 0) (number? r))
        (longitudR r)
       "ERROR en tipo de dato"
       )
  )
;prueba
(Val-Ejer3 10)
;-------------------------------------------
;EJercicio 4
;ncuadrado -> Hacer una función que eleve al cuadrado sin usar expt.
;multiplicar un numero por el mismo numero -> n * n
;(ncuadrado num) -> num
;Ejemplo: (ncuadrado 10) -> 100
(define (ncuadrado n)
  (* n n)
  )
;(Val-Ejer4 cualquiera) -> num o ERROR
;La funcion valida que la entrada sea numerica antes de reducirla
(define (Val-Ejer4 n)
  (if (number? n)
            (ncuadrado n)
            "ERROR En tipo de dato"
            )
  )
;Prueba
(Val-Ejer4 10)
;-------------------------------------------
;Ejercicio 5
;Ej5 -> Calcular el área de un círculo.
;Area del circulo = multiplicar pi por el radio al cuadrado 
;(Ej5 num) -> num
;Ejemplo: (Ej5 10) -> i314.1592653589793
(define (Ej5 r)
  (*(expt r 2)pi)
  )
(define (Val-Ejer5 r)
  (if (and (number? r)
           (> r 0)
           )
      (Ej5 r)
      "ERROR en tipo de dato"
      )
  )
;Prueba
(Val-Ejer5 10)
;-------------------------------------------
;Ejercicio 6
;Ej6 -> Encontrar el área de un anillo, conociendo el radio interior y el exterior.
;Dado el radio exterior(R) y el radio interior(r) podemos encontrar el area
;Area de una circunferencia = pi por el radio al cuadrado
;Sabiendo que un anillo tiene dos radios, el area se encuentra al restarle el radio interior al radio exterior
;(Ej6 num num) -> num
;Ejemplo: (Ej6 10 8) -> i113.09733552923255
(define (Ejer6 R r)
  (* pi (-(* R R) (* r r)))
  )
;(Val-Ejer6 cualquiera) -> num o ERROR
;El radio exterior debe ser mayor que el interior
;El radio exterior y el interior deben ser positivos
;El radio debe ser un numero
(define (Val-Ejer6 R r)
  (cond
    [(or(not(number? R))(not(number? r))) 
         "ERROR: ambos radios deben ser numeros"]
    [(or(not(> R 0))(not(> r 0)))
         "ERROR: el radio no puede ser negativo"]
    [(<= R r)
         "ERROR: El radio exterior no puede ser menor o igual que el interior"]
    [else(Ejer6 R r)]
    )
  )
  
;Prueba
(Val-Ejer6  10 8)
;-------------------------------------------
;Ejercicio 7
;Ejer7 -> Dado un valor de temperatura en grados Celsius, convertirla a grados Fahrenheit.
;la formula para pasar grados celsius a farenheit es multiplicar los grados celcius por 1.8 y sumarle 32
;La funcion recibe grados celcius y retorna grados farenheit
;(Ejer7 num) -> num
;Ejemplo (Ejer7) 5 ) -> 41
(define (Ejer7 C)
  (+ 32 (* (/ 9 5) C)
     )
  )
;(Val-Ejer7 cualquiera) -> num o ERROR
;La funcion valida que la entrada sea numerica antes de reducirla
(define (Val-Ejer7 C)
  (if (number? C)
      (Ejer7 C)
      "Error en tipo de dato"
      )
  )
;Prueba
(Val-Ejer7 5)
;-------------------------------------------
;Ejercicio 8
;Ejer8 -> Dado un valor de temperatura en grados Fahrenheit, convertirla a grados Celsius.
;la formula para pasar grados farenheit a grados celcius es multiplicar la division de 5 y 9 por la resta de los grados farenheit y 32
;La funcion recibe grados farenheit y retorna grados celcius.
;(Ejer8 num)-> num
;Ejemplo (Ejer8) 20) -> -6.6 
(define (Ejer8 n)
  (* (/ 5 9) (- n  32 ))
  )
;(Val-Ejer8 cualquiera) -> num o ERROR
;La funcion valida que la entrada sea numerica antes de reducirla
(define (Val-Ejer8 n)
  (if (number? n)
      (Ejer8 n)
      "Error en tipo de dato"
      )
  )
;Prueba
(Val-Ejer8 20)
;-------------------------------------------
;Ejercicio 9
;Ejer9 -> Calcular el área de un trapecio.
;dada la base mayor(B),base menor(b) y la altura(h)
;El area de un trapecio = la multiplicacion entre la suma de las bases (B + b) por la altura(h) sobre 2
;(Ejer9 num num num) -> num 
;Ejemplo (Ejer9) 10 5 8) -> 60
(define (Ejer9 B b h)
  (* h ( / ( + B b) 2 ))
  )
;(Val-Ejer9 num num num) -> num o ERROR
;La funcion valida que la entrada sea numerica para reducirla
;La funcion valida que la entrada sea positiva
(define (Val-Ejer9 B b h)
  (cond
    [(or (not (number? B))(not(number? b))(not(number? h)))
    "ERROR en tipo de dato"]
    [(or (not(> B 0))(not(> b 0))(not(> h 0)))
    "ERROR: la entrada no puede ser negativa"]
    [else (Ejer9 B b h)]
    )
  )      
;Prueba
(Val-Ejer9 10 5 8 )
;-----------------------------------------------------------
;Ejercicio 10
;Ejer10 -> Dados la base mayor, la base menor y la altura de un trapecio, calcular el perímetro.
;dada la base mayor(B),base menor(b) y la altura(h)
;El perimetro es la suma de todos los lados
;usar teorema de pitagoras para encontrar los lados laterales
;Perimetro = B + b + 2 * sqrt(((B - b) / 2)^2 + h^2)
;(Ejr10 num num num) -> num
;Ejemplo (Ejer10 5 4 3) -> 15
(define (Ejer10 B b h)
  (let* ([cateto (/ (- B b) 2)]
         [lateral (sqrt (+ (sqr cateto) (sqr h)))])
    (+ B b (* 2 lateral))))

;(Val-Ejer10 num num num) -> num o ERROR
;Verifica que todos los parámetros sean válidos.
(define (Val-Ejer10 B b h)
  (cond
    [(or (not (number? B)) (not (number? b)) (not (number? h)))
     "Error: Todos los valores deben ser números."]
    [(or (negative? B) (negative? b) (negative? h))
     "Error: Ningún valor puede ser negativo."]
    [else (Ejer10 B b h)]
    )
  )
;Prueba
(Val-Ejer10 5 4 3)
;------------------------------------------------------------
;Ejercicio 11
;Ejer11 -> Calcular el volumen de una esfera
;Dado el radio de la esfera, la funcion reduce al volumen
;Volumen = (4/3) * pi * r^3
;(Ejer11 num)-> num 
;Ejemplo (Ejer 11) 10) -> #i4188.790204786391
(define (Ejer11 r)
  (* pi ( / 4 3) (expt r 3)
     )
  )
;(Val-Ejer11 num) -> num o ERROR
;Verifica que la entrada sea un numero positivo antes de reducir
(define (Val-Ejer11 r)
  (if (and (> r 0) (number? r))
        (Ejer11 r)
       "ERROR en tipo de dato"
       )
  )
;Prueba
(Val-Ejer11 10)
;-------------------------------------------
;Ejercicio 12
;Ejer12 -> Calcular el volumen de una pirámide de base cuadrada.
;Dada la base(b) y la altura(h) podemos calcular el volumen de la piramide
;Volumen = (1/3) * b^2 * h
;(Ejer12 num num) -> num
;Ejemplo (Ejer12) 6 10) -> 120
(define (Ejer12 b h)
  (* h (/ 1 3)(sqr b))
  )
;(Val-Ejer12 num num) -> num o ERROR
;Verifica que la entrada sea un numero positivo antes de reducir
(define (Val-Ejer12 b h)
  (cond
    [(or (not (number? b))(not(number? h)))
     "Error: el tipo de dato debe ser numerico."]
    [(or (negative? b)(negative? h))
     "Error: Ningún valor puede ser negativo."]
    [else (Ejer12 b h)]
    )
  )
;Prueba
(Val-Ejer12 6 10)
;-------------------------------------------
;Ejercicio 13
;Ejer13 -> Calcular el área exterior de la pirámide del ejercicio anterior.
;Dada la base(b) y la altura vertical de la piramide(h)
;Formula para el area = b^2 + 2 * b * L
;L= altura inclinada de las caras dada tras usar teorema de pitagoras(sqrt((b/2)^2 + h^2))
;(Ejer13 num num) -> num
;Ejemplo (Ejer 13) 6 10) -> 161.2836781069266
(define(Ejer13 b h)
  (let* ([semi-b (/ b 2)]
         [L (sqrt (+ (sqr semi-b)(sqr h)))]
         [area-base (sqr b)]
         [area-L (* 2 b L)]
         )
    (+ area-base area-L)
    )
  )
;(Val-Ejer13 num num) -> num o ERROR
;Verifica que la entrada sea un numero positivo antes de reducir
(define (Val-Ejer13 b h)
  (cond
    [(or (not (number? b))(not(number? h)))
     "Error: el tipo de dato debe ser numerico."]
    [(or (negative? b)(negative? h))
     "Error: Ningún valor puede ser negativo."]
    [else (Ejer13 b h)]
    )
  )
;Prueba
(Val-Ejer13 6 10)
;-------------------------------------------
;Ejercicio 14
;Ejer14 -> Encontrar el volumen de un cilindro.
;Dado el radio(r) y la altura(h) del cilindro
;Formula para el volumen = pi * r^2 * h
;(Ejer14 num num) -> num
;Ejemplo (Ejer14) 4 10) -> 502.6548245743669
(define  (Ejer14 r h)
  (* pi h (sqr r))
  )
;(Val-Ejer14 num num) -> num o ERROR
;Verifica que la entrada sea un numero positivo antes de reducir.
(define (Val-Ejer14 r h)
  (cond
    [(or (not (number? r))(not(number? h)))
     "Error: el tipo de dato debe ser numerico."]
    [(or (negative? r)(negative? h))
     "Error: Ningún valor puede ser negativo."]
    [else (Ejer14 r h)]
    )
  )
;Prueba
(Val-Ejer14 4 10)
;-------------------------------------------
;Ejercicio 15
;Ejer15 -> Calcular el área de la superficie de un cilindro.
;Dada la altura(h) y el radio(r) del cilindro.
;Formula para la base circular del cilindro = 2 * pi * r^2
;Formula para el area lateral del cilindro = 2 * pi * r * h
;Fórmula para el area del cilindro(obtenida al factorizar las dos formulas anteriores) = 2 * pi * r * (r + h)
;(Ejer15 num num) -> num
;Ejemplo (Ejer15) 6 10) #i351.85837720205683
(define (Ejer15 h r)
  (* 2 pi r (+ r h))
  )
;(Val-Ejer15 num num) -> num o ERROR
;Verifica que la entrada sea un numero positivo antes de reducir.
(define (Val-Ejer15 h r)
  (cond
    [(or (not (number? r))(not(number? h)))
     "Error: el tipo de dato debe ser numerico."]
    [(or (negative? r)(negative? h))
     "Error: Ningún valor puede ser negativo."]
    [else (Ejer15 h r)]
    )
  )
;Prueba
(Val-Ejer15 4 10)
;-------------------------------------------
;Ejercicio 16
;pulgadas-centimetros -> Convertir de pulgadas a centímetros y otro programa que haga lo contrario.
;Formula: cm = pulgadas * 2.54
;(pulgadas-centimetros num) -> num
;Ejemplo (pulgadas-centimetros 6) -> 15.24
(define (pulgadas-centimetros in)
  (* in 2.54)
  )
;(Val-Ejer16 num) -> num o ERROR
;Verifica que la entrada sea un numero positivo antes de reducir
(define (Val-Ejer16 in)
  (if (and (> in 0) (number? in))
        (pulgadas-centimetros in)
       "ERROR en tipo de dato"
       )
  )
;Prueba
(Val-Ejer16 6)
;centimetros-pulgadas
(define ( Ejer16.1 cm)
  (/ cm 2.54)
  )
;Prueba 
(Ejer16.1 10)
;-------------------------------------------
;Ejercicio 17 
;pies-pulgadas -> Convertir de pies a pulgadas
;Convierte una longitud en pies a pulgadas.
;Fórmula: pulgadas = pies * 12
;(pies-pulgadas num) -> num
;Ejemplo: (pies-pulgadas 5) -> 60
(define (pies-pulgadas pies)
  (* pies 12)
  )
;(Val-Ejer17 num) -> num o ERROR
;Verifica que la entrada sea un numero positivo antes de reducir
(define (Val-Ejer17 pies)
  (if (and (> pies 0) (number? pies))
        (pies-pulgadas pies)
       "ERROR en tipo de dato"
       )
  )
;Prueba
(Val-Ejer17 5)
;-------------------------------------------
;Ejercicio 18
;yardas-pies -> Convertir de yardas a pies
;Convierte una longitud en yardas a pies.
;Fórmula: pies = yardas * 3
;(yardas-pies num) -> num
;Ejemplo: (yardas-pies 5) -> 15
(define (yardas-pies yardas)
  (* yardas 3)
  )
;(Val-Ejer18 num) -> num o ERROR
;Verifica que la entrada sea un numero positivo antes de reducir
(define (Val-Ejer18 yardas)
  (if (and (> yardas 0) (number? yardas))
        (yardas-pies yardas)
       "ERROR en tipo de dato"
       )
  )
;Prueba
(Val-Ejer18 5)
;-----------------------------------------------
;Ejercicio 19
;millas-yardas -> Convertir de Millas a Yardas 
;Convierte una longitud en millas a yardas.
;Fórmula: yardas = millas * 1760
;(millas-yardas num) -> num
;Ejemplo: (millas-yardas 10) -> 17600
(define (millas-yardas millas)
  (* millas 1760)
  )
;(Val-Ejer19 num) -> num o ERROR
;Verifica que la entrada sea un numero positivo antes de reducir
(define (Val-Ejer19 millas)
  (if (and (>= millas 0) (number? millas))
        (millas-yardas millas)
       "ERROR en tipo de dato"
       )
  )
;Prueba
(Val-Ejer19 10)
;---------------------------------------------------------
;Ejercicio 20
;Ejer20 Convertir de millas a centímetros usando las funciones anteriores.
;Convierte una longitud en millas a centimetros.
;La funcion convierte millas en yardas, luego en pies, luego en pulgadas y por ultimo reduce en centimetros.
;(millas-centimetros num) -> num
;Ejemplo (millas-centimetros 10) -> 16093440
(define (millas-centimetros millas)
  (let* ([yardas (millas-yardas millas)]
         [pies (yardas-pies yardas)]
         [pulgadas (pies-pulgadas pies)])
    (pulgadas-centimetros pulgadas)
    )
  )
;(Val-Ejer20 num) -> num o ERROR
;Verifica que la entrada sea un numero positivo antes de reducir
(define (Val-Ejer20 millas)
  (if (and (>= millas 0) (number? millas))
       (millas-centimetros millas)
       "ERROR en tipo de dato"
       )
  )
;Prueba
(Val-Ejer20 10)
;-----------------------------------------------------------
;Ejercicio 21
;Ejer21 Dadas cantidades de billetes recibidos en denominaciones de $1.000, $2.000, $5.000,$10.000, $20.000 y $50.000, obtener como resultado el valor del conjunto de todos los billetes.
;Dadas las variables:
;   N1 = $1000
;   N2 = $2000
;   N5 = $5000
;   N10 = $10000
;   N20 = $20000
;   N50 = $50000
;El conjunto de billetes se calcula multiplicando el numero de parametros por su respectiva denominacion y sumando todos los resultados
;(Ejer21 num num num num num num) -> num
;Ejemplo (Ejer21) 2 1 0 1 0 0) -> 14000
(define (Ejer21 N1 N2 N5 N10 N20 N50)
  ( + ( * 1000 N1)
      ( * 2000 N2)
      ( * 5000 N5)
      ( * 10000 N10)
      ( * 20000 N20)
      ( * 50000 N50)
      )
  )
;(Val-Ejer21 num num num num num num) -> num o ERROR
;Valida que los datos sean validos antes de llamar a la funcion principal
;Los datos deben ser numeros naturales
(define (Val-Ejer21 N1 N2 N5 N10 N20 N50)
  (let ([valido? (lambda (n) (and (integer? n) (>= n 0)))])
  (if (and (valido? N1)
           (valido? N2)
           (valido? N5)
           (valido? N10)
           (valido? N20)
           (valido? N50))
      (Ejer21 N1 N2 N5 N10 N20 N50)
      "Error: Todos los valores deben ser enteros no negativos."
      )
  )
  )
;Prueba
(Val-Ejer21 2 1 0 1 0 0)
;--------------------------------------------------------------
;Ejercicio 22
;cuadratica -> Resuelve la ecuación ax^2 + bx + c = 0
;dados los valores a b c, debemos encontrar un valor x que satisfaga la ecuacion
;Parametros: a ≠ 0, b = numero entero, c = numero entero.
;Calcula el discriminante: D = b^2 - 4ac
;Si D = 0, la funcion reduce en un numero
;Si D > 0, la funcion reduce en una lista
;(cuadratica num num num) -> num o lista
;Ejemplo (cuadratica 2 4 2) -> (list -1 -1)
(define (cuadratica a b c)
      (let* ([discriminante (- (sqr b) (* 4 a c))])
        (if (< discriminante 0)
            "La ecuación no tiene soluciones reales."
            (let* ([raiz-discriminante (sqrt discriminante)]
                   [denominador (* 2 a)]
                   [x1 (/ (+ (- b) raiz-discriminante) denominador)]
                   [x2 (/ (- (- b) raiz-discriminante) denominador)])
              (list x1 x2)
              )
            )
        )
      )
;(Val-Ejer22 num num num) -> num o lista o ERROR
;Verifica que todos los parametros sean numeros reales antes de reducir
;El parametro a debe ser distinto de 0
(define (Val-Ejer22 a b c)
  (let ([real-numero? (lambda (x) (and (real? x) (number? x)))])
  (cond
    [(not (real-numero? a))
     "El coeficiente a debe ser un número real."]
    [(not (real-numero? b))
     "El coeficiente b debe ser un número real."]
    [(not (real-numero? c))
     "El coeficiente c debe ser un número real."]
    [(= a 0)
     "El valor de a no puede ser 0, no es una ecuación cuadrática."]
    [else (cuadratica a b c)]
    )
    )
  )
;Prueba
(Val-Ejer22 2 4 2)
;-------------------------------------------------------------------------------------
;Ejercicio 23
;Ejer23 Teniendo los lados de un triángulo rectángulo, encontrar el valor de la hipotenusa.
;Dados los lados a y b, debemos encontrar el valor de la hipotenusa(h)
;Formula para hallar la hipotenusa: h = sqrt(a^2 + b^2)
;(Ejer23 num num ) -> num
;Ejemplo (Ejer23 a b) 3 4 )-> 5
(define (Ejer23 a b)
  (sqrt ( + (sqr a)(sqr b))
        )
  )
;(Val-Ejer23 num num) -> num o ERROR
;La funcion valida que los parametros sean reales positivos
(define (Val-Ejer23 a b)
  (let ([real-positivo? (lambda (x) (and (real? x) (> x 0)))])
  (cond
    [(not (real-positivo? a)) (error "El valor de 'a' debe ser un número real positivo.")]
    [(not (real-positivo? b)) (error "El valor de 'b' debe ser un número real positivo.")]
    [else (Ejer23 a b)]
    )
    )
  )
;Prueba
(Val-Ejer23 3 4 )
;--------------------------------------------------------------------------------------
;Ejercicio 24
;Ejer24 -> Teniendo un cubo de lado con valor n, calcular cual es el volumen de la mayor esfera que cabe dentro del cubo.
;Dado el valor del lado del cubo = n
;La mayor esfera que cabe dentro del cubo es aquella que toca todas las caras del cubo, por lo tanto n = diametro de la esfera
;Por lo tanto, r = n/2
;La formula del volumen de una esfera es = 4/3 * pi * r^3
;Reemplazando r en la ecuacion anterior = 4/3 * pi * (n/2)^3 = pi * r^3 / 6
;La funcion recibe el lado(n) del cubo y reduce en el volumen de la esfera
;(Ejer24 num) -> num
;Ejemplo (Ejer24 6) -> 113.097
(define (Ejer24 n)
  (* (/ pi 6)(expt n 3)
     )
  )
;(Val-Ejer24 num) -> num o ERROR
;Verifica que la entrada sea un numero positivo antes de reducir
(define (Val-Ejer24 n)
  (if (and (> n 0) (real? n))
        (Ejer24 n)
       "ERROR en tipo de dato"
       )
  )
;Prueba
(Val-Ejer24 6)
;---------------------------------------------------------------------------------------
;Ejercicio 25
;Ejer25 -> Teniendo un cubo de lado con valor n, calcular cual es el volumen de la menor esfera que contiene al cubo.
;Dado el valor del lado del cubo = n
;Si un cubo de lado n está contenido dentro de una esfera, la esfera circunscrita debe tener un diámetro igual a la diagonal del cubo.
;Formula de la diagonal del cubo = n * sqrt(3)
;Por lo tanto, el radio de la esfera = n * sqrt(3) / 2
;Reemplazando el radio en la formula de la esfera = pi * 3 * sqrt(3) / 6
;La funcion recibe el lado n del cubo y retorna el volumen de la esfera
;(Ejer25 num) -> num
;Ejemplo (Ejer25 2) -> 21.7655
(define (Ejer25 n)
  (let* ([r (/ (* n (sqrt 3)) 2)])
    (* (/ 4 3) pi (expt r 3)
       )
    )
  )
;Usamos let* para calcular primero el radio y luego calcular el volumen de la esfera

;(Val-Ejer25 num) -> num o ERROR
;Verifica que la entrada sea un numero positivo antes de reducir
(define (Val-Ejer25 n)
  (if (and (> n 0) (real? n))
        (Ejer25 n)
       "ERROR en tipo de dato"
       )
  )
;Prueba
(Val-Ejer25 2)
;----------------------------------------------------------------------------------------
;Ejercicio 26
;Ejer26 -> Si la probabilidad de que caiga 6 al lanzar un dado es de 1/6, cual es la probabilidad de que caiga 6 en todos los n lanzamientos de un dado.
;n = numero de lanzamientos (n es un entero > 0)
;la formula para calcular la probabilidad de sacar 6 en una tirada es = 1 / 6
;se multiplica por n veces que se tira el dado = (1 / 6)^n
;la funcion reduce en un numero real entre 0 y 1
;(Ejer26 num) -> num
;Ejemplo (Ejer26 3) -> 0.00463
(define (Ejer26 n)
  (expt (/ 1 6)n)
  )
;(Val-Ejer26 num) -> num
;La funcion verifica que n sea un numero entero >= 0
(define (Val-Ejer26 n)
  (if (and (>= n 0) (integer? n))
        (Ejer26 n)
       "ERROR en tipo de dato"
       )
  )
;Prueba
(Val-Ejer26 3)
;----------------------------------------------------------------------------------------
;Ejercicio 27
;Ejer27 -> Si la probabilidad de que caiga 6 al lanzar un dado es de 1/6, cual es la probabilidad de que caiga al menos una vez 6 en n lanzamientos del dado.
;n = numero de lanzamientos (n es un entero > 0)
;la formula para calcular la probabilidad de sacar al menos un 6 en n tiradas es = 1 - (1 / 6)
;formula cuando no se saca ningun 6 en n tiradas = (5 / 6)^n
;Entonces, la formula para encontrar la probabilidad de sacar al menos un 6 en n lanzamientos es = 1 - (5 / 6)^n
;la funcion reduce en un numero real entre 0 y 1
;(Ejer27 num) -> num
;Ejemplo (Ejer27 3) -> 0.421296
(define (Ejer27 n)
  (- 1 (expt (/ 5 6)n)
  )
  )
;(Val-Ejer26 num) -> num
;La funcion verifica que n sea un numero entero >= 0
(define (Val-Ejer27 n)
  (if (and (>= n 0) (integer? n))
        (Ejer27 n)
       "ERROR en tipo de dato"
       )
  )
;Prueba
(Val-Ejer27 3)
