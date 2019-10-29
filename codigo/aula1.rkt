#lang racket

;; A primeira linha de todo programa Racket deve ser
;; a declaracão #lang racket. Isso é necessário porque
;; é possível utilizar outras linguagens no mesmo
;; ambiente.

;; --- Constantes/literais para valores básicos

;; Números
2             ; literal inteiro
3.5           ; número de ponto flutuante
4/3           ; número racional (exato)
4+5i          ; número complexo

;; números em Racket podem usar precisão arbitrária,
;; e o compilador e runtime vão utilizar a representacao
;; mais eficiente dependendo do uso (por exemplo, números
;; que cabem em uma palavra nativa do processador usarão
;; as instrucões do processador diretamente).
123451234512345123451234512345123451234512345

;; Strings em Racket são Unicode, delimitadas por aspas duplas
"λ 123"

;; Caracteres
#\A
#\space          ; caractere especial: espaco em branco
#\newline        ; caractere de nova linha
#\λ

;; Booleanos
#t
#f

;; --- Expressões (notacão pré-fixada)
(+ 3 2)        ; 3 + 2
(* 7 (+ 3 2))  ; (3 + 2) * 7

; 3 + 2 * 7
(+ 3 (* 2 7))

; 5*5 + 4*3*2
(+
 (* 5 5)
 (* 4 3 2))

 ;; como os operadores aparecem no comeco, é possível
 ;; ter mais de dois operandos
 (+ 1 2 3 4 5)

 ;; operacoes com strings
 (string-length "Esta é uma string")

 ;; operacoes com booleanos
 (not #t)
 (and #t #f)


;; --- Variaveis

;; Usamos a forma especial define para definir variáveis
(define x 2)
(define y (string-length "Aussonderungsaxiom"))
(define s (string-append "um" "dois"))
(define x (* 7 (+ a (- 12 7))))

;; os nomes de variáveis em Racket são mais flexíveis que na
;; maioria das outras linguagens, podendo conter vários símbolos
;; ou mesmo comecar com numeros
(define +++ "string")
(define 2mais3 (+ 2 3))

;; predicados de tipos podem ser usados para testar o
;; tipo de um valor em tempo de execucão
(string? s)
(number? x)

;; obs.: por convencão, predicados (funcoes que retornam um booleano)
;; têm nomes terminando em ?


;; Uma expressão condicional utiliza a forma especial if,
;; junto com três expressões: (if C A B)
;; C é a condicão testada; se o valor de C for #t,
;; a expressão A é avaliada e seu valor é o valor do if;
;; caso contrário a expressão B é avaliada e seu valor
;; é o valor do if
(if (> 3 2) "tres maior que dois"
            "quê?")          ; else

;; Note que como o if é uma expressão, ele pode aparecer
;; em qualquer contexto onde uma expressão pode ser usada
(+ 5 (if (< 2 1) 0 3))
(define var-cond (if (> x 7) 11 22))


;; --- Funcoes
(define (f x) (* x 20))

;; equacoes de segundo grau
(define (delta a b c)
  (- (* b b)
     (* 4 a c)))

(define (raiz-positiva a b c)
  (/ (+ (- b) (sqrt (delta a b c)))
     (* 2 a)))

;; soma como uma funcão recursiva
(define (soma-N N)
  (if (= N 1)
      1
      (+ N
         (soma-N (- N 1)))))
