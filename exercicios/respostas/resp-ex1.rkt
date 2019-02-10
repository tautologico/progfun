#lang racket

(require rackunit rackunit/text-ui rackunit/gui)

(define a 42)
(define b 14)

(define-test-suite exercicios-1-e-2
  (test-equal? "a deve ser 42" a 42)
  (test-equal? "b deve ser 14" b 14))

(define-test-suite exercicio-3
  (test-equal? "a + b" (+ a b) 56)
  (test-equal? "a - b" (- a b) 28)
  (test-equal? "a + 3b + 7" (+ a (* 3 b) 7) 91)
  (test-equal? "media aritmetica" (/ (+ a b) 2) 28)
  (test-equal? "media geometrica" (sqrt (* a b)) 24.24871130596428)
  (test-equal? "media harmonica" (/ 2
                                    (+ (/ 1 a)
                                       (/ 1 b))) 21))

(define soma-medias (+ (/ (+ a b) 2)
                       (/ 2
                          (+ (/ 1 a)
                             (/ 1 b)))))

(if (= soma-medias 49)
    "teste 1 ok"
    "teste 1 falhou")

(define (quadrado x) (* x x))

(define-test-suite testes-quadrado
  (test-equal? "5 * 5" (quadrado 5) 25)
  (test-equal? "0 * 0" (quadrado 0) 0)
  (test-equal? "-1 * -1" (quadrado -1) 1))

(define (delta a b c)
  (- (quadrado b)
     (* 4 a c)))

(define (raiz-positiva a b c)
  (/ (+ (- b) (sqrt (delta a b c)))
     (* 2 a)))

(define/contract (potencia x y)
  (-> number? (and/c integer? (>=/c 3))
      number?)
  (if (= y 0)
      1
      (* x (potencia x (sub1 y)))))

(run-tests (test-suite "todos os testes"
                       exercicios-1-e-2
                       exercicio-3
                       testes-quadrado))
