;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |TALLER 2 Santiago Osorio Aramburo|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;a) Un hombre camina 5 km por hora a paso normal. Escribir un procedimiento que permita calcular cuántas horas le tomará caminar una distancia determinada.
;Parametro de la funcion: d = distancia a recorrer, en kilómetros (real positivo)
;La velocidad se da en kilometros por hora
;Velocidad constante de 5 km / h 
;Tiempo = distancia / 5
;La funcion reduce en un tiempo en horas
;(EjerA Num )-> Num 
;Ejemplo (EjerA 10) -> 2
(define (EjerA distancia)
  (/ distancia 5)
  )
;(Val-EjerA num) -> num
;La funcion verifica que la distancia sea un numero real >= 0
(define (Val-EjerA distancia)
  (if ( and (>= distancia 0) (number? distancia))
            (EjerA distancia)
            "ERROR en dato" ))
;Prueba
(Val-EjerA 10)
;-----------------------------------------------------------------------------------------------------------------------------------------------
;b) Un camión puede cargar 10 toneladas de mercancía. Escribir un procedimiento que permita calcular en cuántos viajes podrá llevar una cantidad determinada de mercancía
;El peso es una constante y que lo realiza en un viaje
;m = cantidad de mercancía en toneladas (real positivo)
;Formula: toneladas que debe llevar / maximo en toneladas que puede llevar el camion (10 toneladas)
;(EjerB Num) -> Num
;Ejemplo (EjerB 100)-> 10
(define (EjerB m)
  (ceiling ( / m 10)
           )
  )
;(Val-EjerB num) -> num
;La funcion verifica que la mercancia sea un numero real >= 0
(define (Val-EjerB Toneladas)
  (if (and (> Toneladas 0) (number? Toneladas))
      (EjerB Toneladas)
      "ERROR en dato"
      )
  )
;Prueba
(Val-EjerB 100)
;-----------------------------------------------------------------------------------------------------------------------------------------------
;c) El área del triángulo es (Base * Altura / 2) Si en un polígono regular de seis lados, se ha construido en uno de sus lados incluye un triángulo isósceles, Construir un procedimiento que permita calcular el área restante del polígono sin incluir el área del triángulo que está inscrito.
;Sacamos el area del triangulo (Base * Altura / 2) depues sacamos el area del hexagono ( 3 * RAIZ 3 / 2 )* B AL CUADRADO se resta las dos cantidades resultantes
;AREA Triangulo: (Base x Altura / 2)
;AREA Hexagono: (3 * sqrt(3) * l^2 / 2)
;Dada la base del triangulo(b) y la altura(h)
;Los parametros se miden en centimetros
;Base del triangulo = Lado del hexagono(l)
;(EjerC Num Num) -> Num 
;Ejemplo (EjerC 4 3)-> 35.5692
(define (EjerC b h)
  (let ([area-triangulo (/ (* b h) 2)]
        [area-hexagono (/(* 3 (sqrt 3)(sqr b))2)]
        )
    (- area-hexagono area-triangulo)
    )
  )
;(Val-EjerC num num) -> num o ERROR
;La funcion verifica que los parametros sean numeros mayores a 0
(define (Val-EjerC b h)
   (let ([real-positivo? (lambda (x) (and(number? x)(> x 0)))])
     (cond
       [(not (real-positivo? b))
        "ERROR en tipo de dato"]
       [(not (real-positivo? h))
        "ERROR en tipo de dato"]
       [else (EjerC b h)]
       )
     )
)
;Prueba
(Val-EjerC 4 3)
;---------------------------------------------------------------------------------------------------------------------------------------------
;d) Un hombre digita 1 página tamaño carta en 16 minutos. Construir un procedimiento que permita calcular cuánto le tomaría al mismo hombre digitar un libro con un determinado número de páginas (asumir que el libro tiene también tamaño carta)
;Constante 1 Pagina en 16 min
;Tiempo : # de pag * 16 min
;(EjerD Num) -> Num
;Ejemplo (EjerD 500) -> 8000
(define (EjerD Paginas)
  (* Paginas 16)
  )
;(Val-EjerD num) -> num o ERROR
;La funcion verifica que los parametros sean numeros mayores a 0
(define (Val-EjerD Paginas)
  (if ( and (> Paginas 0) (integer? Paginas))
            (EjerD Paginas)
            "ERROR en tipo de dato"
            )
  )
;Prueba
(Val-EjerD 500)
;-----------------------------------------------------------------------------------------------------------------------------------------------
;e) El área del rectángulo corresponde al resultado de multiplicar su Base por su Altura. Si está inscrito un triángulo, construir un procedimiento que permita calcular el área del rectángulo sin el área del triángulo.
;EjerE -> La funcion calcula el área restante de un rectángulo después de sustraer el área de un triángulo inscrito dentro de él.
;Dados los parametros: base del rectangulo(B), altura del rectangulo(H), base del triangulo(b) y altura del triangulo(h)
;Los parametros se miden en centimetros.
;Area de un triangulo = b * h / 2
;Area de un rectangulo = B * H
;(EjerE num num num num) -> num
;Ejemplo (EjerE 5 7 4 6) -> 23
(define (EjerE B H b h)
  (let* ([area-triangulo (/ (* b h) 2)]
         [area-rectangulo (* B H)]
         )
    (if (> area-rectangulo area-triangulo)
    (- area-rectangulo area-triangulo)
    "ERROR: El area del triangulo debe ser menor al area del rectangulo")
    )
  )
;(Val-EjerE num num num num) -> num o ERROR
;La funcion verifica que los parametros sean numeros mayores a 0
(define (Val-EjerE B H b h)
  (let ([num-positivo? (lambda (x) (and (number? x)(> x 0)))]
        )
    (cond
      [(not(num-positivo? B))
          "ERROR en tipo de dato: La base de un rectangulo no puede ser negativa o 0"]
      [(not(num-positivo? b))
          "ERROR en tipo de dato: La base de un triangulo no puede ser negativa o 0"]
      [(not(num-positivo? H))
          "ERROR en tipo de dato: La altura de un rectangulo no puede ser negativa o 0"]
      [(not(num-positivo? b))
          "ERROR en tipo de dato: La altura de un triangulo no puede ser negativa o 0"]
      [else (EjerE B H b h)]
      )
    )
  )
;Prueba
(Val-EjerE 5 7 4 6)
;----------------------------------------------------------------------------------------------------------------------
;f) El área de un círculo es equivalente a multiplicar el valor de PI (3.141592654) por el valor del radio (mitad del diámetro) elevado al cuadrado. Construir un procedimiento que permita calcular el área de cualquier círculo
;Dado el diametro en centimetros
;Area de Circulo: pi * (Diametro/2)^2
;(EjerF Num)-> Num
;Ejemplo (EjerF 10) -> 78.53981633974483 
(define (EjerF diametro)
  (* pi (sqr (/ diametro 2)
             )
     )
  )
;(Val-EjerF num) -> num o ERROR
;La funcion verifica que los parametros sean numeros mayores a 0         
(define (Val-EjerF diametro)
  (if ( and (> diametro 0) (number? diametro))
            (EjerF diametro)
            "ERROR en tipo de dato"
            )
  )
;Prueba
(Val-EjerF 10)
;--------------------------------------------------------------------------------------------------------------------
;g) Un hombre ha comprado una finca con un área rectangular. Dentro de dicha finca, y circunscrito en ella, un hermano le ha reservado un área circular. Si se conocen la base y la altura del rectángulo y el radio del círculo, construir un procedimiento que permita calcular la porción de tierra que verdaderamente le pertenece al hombre.
;EjerG -> La funcion calcula el área restante de un rectángulo después de sustraer el área circular inscrita dentro de él.
;Dados los parametros: base del rectangulo(b), altura del rectangulo(h), radio del circulo(r)
;Los parametros se miden en centimetros.
;Area de un circulo = pi * r^2
;Area de un rectangulo = b * h
;(EjerG num num num) -> num
;Ejemplo (EjerG 6 10 3) -> 31.725666
(define (EjerG b h r)
  (let* ([area-circulo (* pi (sqr r))]
         [area-rectangulo (* b h)]
         )
    (if (> area-rectangulo area-circulo)
    (- area-rectangulo area-circulo)
    "ERROR: El area del circulo debe ser menor al area del rectangulo")
    )
  )
;(Val-EjerG num num num) -> num o ERROR
;La funcion verifica que los parametros sean numeros mayores a 0
(define (Val-EjerG b h r)
  (let ([num-positivo? (lambda (x) (and (number? x)(> x 0)))]
        )
    (cond
      [(not(num-positivo? b))
          "ERROR en tipo de dato: La base de un rectangulo no puede ser negativa o 0"]
      [(not(num-positivo? h))
          "ERROR en tipo de dato: La altura de un rectangulo no puede ser negativa o 0"]
      [(not(num-positivo? r))
          "ERROR en tipo de dato: El radio del circulo no puede ser negativo o 0"]
      [else (EjerG b h r)]
      )
    )
  )
;Prueba
(Val-EjerG 6 10 3)
;-----------------------------------------------------------------------------------------------------------------------------
;h) Un centro comercial con forma circular ha adquirido un espacio cuadrado para utilizarlo como parqueadero. Si se tiene el radio del círculo que describe el centro comercial y también se tiene el lado del cuadrado que se va a utilizar como parqueadero, construir un procedimiento que permita calcular el área total que cubre el centro comercial
;EjerH -> La funcion calcula el área total del centro comercial circular sumando el area del parqueadero cuadrado
;Dados los parametros: radio del centro comercial(r), lado del parqueadero cuadrado(l)
;Los parametros se miden en centimetros.
;Area de un circulo = pi * r^2
;Area de un rectangulo = l * l
;(EjerH num num) -> num
;Ejemplo (EjerH 6 10) -> 213.09733
(define (EjerH r l)
  (let* ([area-circulo (* pi (sqr r))]
         [area-cuadrado (sqr l)]
         )
    (+ area-cuadrado area-circulo)
    )
  )
;(Val-EjerH num num) -> num o ERROR
;La funcion verifica que los parametros sean numeros mayores a 0
(define (Val-EjerH r l)
  (let ([num-positivo? (lambda (x) (and (number? x)(> x 0)))]
        )
    (cond
      [(not(num-positivo? l))
          "ERROR en tipo de dato: El lado del cuadrado no puede ser negativo o 0"]
      [(not(num-positivo? r))
          "ERROR en tipo de dato: El radio del circulo no puede ser negativo o 0"]
      [else (EjerH r l)]
      )
    )
  )
;Prueba
(Val-EjerH 6 10)
;--------------------------------------------------------------------------------------------------------------------------------------------
;i) Construir un procedimiento que permita recibir un número entero de dos dígitos y mostrar la suma de ambos dígitos
;Tenemos un numero entero y mostramos la suma de ambos
;Decenas: ( quotient  X 10 )
;Unidades ( remainder X 10)
;SUMA: decenas + unidades
;(EjerI Num) -> Num
;Ejemplo (EjerI 47) ->11
(define (EjerI X)
 ( + (quotient X 10 )(remainder X 10)
     )
  )
(define (Val-EjerI X)
  (if (number? X)
            (EjerI X)
            "ERROR en tipo de dato"
            )
  )
;Prueba
  (Val-EjerI 47)
;--------------------------------------------------------------------------------------------------------------------------------------------
;j) Construir un procedimiento que permita recibir un número entero de tres dígitos y mostrar el dígito que se encuentra en el centro
;Tenemos un numero entero de 3 digitos y mostrar el de la mitad
;sacamos las centenas / 100 el resultado que son decenas /10
; (EjerJ Num) -> Num
;Ejemplo (EjerJ 808)-> 8
(define (EjerJ n)
  (quotient(remainder n 100)10))
(define (Val-EjerJ n)
  (if (number? n)
            (EjerJ n)
            "ERROR en tipo de dato"
            )
  )
;Prueba
(Val-EjerJ 808)
;--------------------------------------------------------------------------------------------------------------------------------------
;k) Construir un procedimiento que permita recibir un número entero de tres dígitos y mostrar el resultado de la suma de los tres dígitos
;Tenemos un numero de 3 digitos  y mostrar la suma de los 3
;sacamos las centenas / 100 el resultado que son decenas /10 volvemos al resultado /10 lo sumamos 
;(EjerK Num) -> Num
;Ejemplo (EjerK 999) ->  27 
(define (EjerK n )
  (+(quotient n 100)(remainder (quotient n 10)10)(remainder n 10)))
(define (Val-EjerK n)
  (if (number? n)
            (EjerK n)
            "ERROR en tipo de dato"
            )
  )
;Prueba
(Val-EjerK 999)