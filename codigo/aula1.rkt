#lang racket

;; numeros
2
3.5
4/3

;; strings
"λ 123"

;; caracteres
#\A
#\space
#\newline
#\λ

;; Booleanos
#t
#f

;; Expressoes
(+ 2 3)
; 5*5 + 4*3*2
(+
 (* 5 5)
 (* 4 3 2))

;; Variaveis
(define x 2)
(define y (string-length "Aussonderungsaxiom"))
(define s (string-append "um" "dois")) 

;; predicados de tipos
(string? s)
(number? x)

;; Expressao condicional
(if (> 3 2) "tres maior que dois" "que?")

(+ 5 (if (< 2 1) 0 3))

(define var-cond (if (> x 7) 11 22))

;; Funcoes
(define (f x) (* x 20))

;; equacoes de segundo grau
(define (delta a b c)
  (- (* b b)
     (* 4 a c)))

(define (raiz-positiva a b c)
  (/ (+ (- b) (sqrt (delta a b c)))
     (* 2 a)))

(define (soma-N N)
  (if (= N 1)
      1
      (+ N
         (soma-N (- N 1)))))