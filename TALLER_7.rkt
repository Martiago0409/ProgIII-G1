;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |TALLER 7 RECURSION|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;Ejercicio 1
;1. Crear una función recursiva para calcular el capital al cabo de n años a parti de un monto inicial el cual gana interés de x% anual.
;M=5000, i=0,1
;Co= 5000
;C1=5000+5000*0,1
;C2=C1+C1*0,1
;(Capital num num num) -> num
;ejemplo (Capital  5000 0.1 2) -> 6050
(define (Capital m i n)
  (if (= n 0)
      m
      (Capital (+ m ( * m i)) i (- n 1))
      )
  )
;Prueba
( Capital 5000 0.1 2 )

;----------------------------------------------------------------------------------------------------------------------------------------------

;Ejercicio 2
;2. Escribir un algoritmo recursivo que acepte como parámetro un entero positivo y escriba por pantalla su representación en binario.
;Para pasar un numero de base 10 a base 2 es necesario dividir el numero por 2
;La funcion entrega el residuo de las divisiones, leido de derecha a izquierda.
;(Binario num) -> num
;Ejemplo (Binario 10) -> 1010
(define (Binario n )
  (if (< n 2)
      (display n)
      (begin
        (Binario (quotient n 2))
        (display (remainder n 2))
        )
      )
  )

;Ejemplo
(Binario 10)

;----------------------------------------------------------------------------------------------------------------------------------------------

;3.Escribir una función recursiva que, dado un valor entero K, indique si K es o no es diabólico.
;Un número diabólico es un número que, cuando se pasa a base 2, tiene un número impar de O's
;Función auxiliar que cuenta los ceros en la representación binaria de n
(define (contar-ceros n)
  (cond
    [(= n 0) 1]                                 ;el número 0 tiene 1 cero en binario
    [(< n 2) 0]                                 ;1 en binario no tiene ceros
    [else (+ (if (= (remainder n 2) 0) 1 0)     ;si el bit menos significativo es 0, sumar 1
              (contar-ceros (quotient n 2)))])) ;recursión con n/2

;Función principal: verifica si el número es diabólico
(define (diabolico? k)
  (if (not (and (integer? k) (>= k 0)))
      (display "Error: el número debe ser un entero positivo o cero\n")
      (if (odd? (contar-ceros k))
          (display "Es un número diabólico 😈\n")
          (display "No es un número diabólico 😇\n")
          )
      )
  )

;Prueba
(diabolico? 100)

;---------------------------------------------------------------------------------------------------------------------------------

;4. Escribir una función recursiva que, dado un número entero, indique si dicho número es o no es apocalíptico.
;Se dice que un número es apocalíptico si contiene entre sus dígitos la secuencia 666.
;Función auxiliar que cuenta cuántos 6 seguidos hay actualmente
(define (buscar-666 n cont)
  (cond
    [(= cont 3) #t]                     ; si llegamos a 3 seis seguidos → apocalíptico
    [(= n 0) #f]                        ; si ya no quedan dígitos → no lo es
    [(= (remainder n 10) 6)             ; si el último dígito es 6 → aumenta contador
     (buscar-666 (quotient n 10) (+ cont 1))]
    [else                               ; si no es 6 → reinicia el contador
     (buscar-666 (quotient n 10) 0)]))

;Función principal que valida y muestra el resultado
(define (apocaliptico? n)
  (if (not (and (integer? n) (>= n 0)))
      (display "Error: el número debe ser un entero positivo o cero\n")
      (if (buscar-666 n 0)
          (display "💀 Es un número apocalíptico 💀\n")
          (display "😇 No es un número apocalíptico 😇\n"))))

;Prueba
(apocaliptico? 16667234)  ; 💀 sí, tiene 666

;--------------------------------------------------------------------------------------------------------------------------------

;5.Escribir una función recursiva que calcule el cuadrado de un número entero para n > 1,
;mediante el siguiente método: el cuadrado de n es igual a la suma de los n primeros números impares.
;n * n = 1 + 3 + 5 + 7 + ... + n
;(cuadrado num) -> num
;Ejemplo (cuadrado 5) -> 25
(define (cuadrado n)
  (cond
    [(not (and (integer? n) (> n 0)))
     (display "Error: n debe ser un número entero positivo\n")]
    [(= n 1) 1]                                   ; caso base
    [else (+ (cuadrado (- n 1)) (- (* 2 n) 1))])) ; recursión
(cuadrado 5)   ; → 25

