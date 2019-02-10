#lang racket

(require rackunit rackunit/text-ui)

(define (soma n m)
  (if (= m 0) n (soma (add1 n) (sub1 m))))

#;(define (soma n m)
  (if (zero? m)
      n
      (add1 (soma n (sub1 m)))))

(define-test-suite testes-soma
  (test-equal? "3 + 4"  (soma 3 4) 7)
  (test-equal? "10 + 0" (soma 10 0) 10)
  (test-equal? "0 + 0"  (soma 0 0) 0)
  (test-equal? "0 + 21" (soma 0 21) 21)
  (test-equal? "1 + 34" (soma 1 34) 35)
  (test-equal? "7 + 7"  (soma 7 7) 14))

(define (mult n m)
  (if (= m 0) 0
      (+ n (mult n (sub1 m)))))

(define-test-suite testes-mult
  (test-equal? "3 * 4"  (mult 3 4) 12)
  (test-equal? "5 * 0"  (mult 5 0) 0)
  (test-equal? "0 * 5"  (mult 0 5) 0)
  (test-equal? "13 * 1" (mult 13 1) 13)
  (test-equal? "1 * 13" (mult 1 13) 13))

;; listas
'()                    ; lista vazia
(cons 1 '())           ; lista contendo 1
(cons 2 (cons 1 '()))  ; lista (2 1)

(define lista1 (cons 1 '()))    ; (1)
(define lista2 (cons 2 lista1)) ; (2 1)

(check-equal? '(1)   (cons 1 '()))
(check-equal? '(2 1) (cons 2 (cons 1 '())))

(check-equal? (list 1) (cons 1 '()))
(check-equal? (list 3 2 1) (cons 3 (cons 2 (cons 1 '()))))

(define (tamanho l)
  (if (empty? l)
      0
      (add1 (tamanho (rest l)))))

(define-test-suite testes-tamanho
  (test-equal? "lista vazia" (tamanho '()) 0)
  (test-equal? "3 elementos" (tamanho (list 1 2 3)) 3)
  (test-equal? "outros 3 elementos" (tamanho (list 42 22 33)) 3)
  (test-equal? "tamanho (cons x l) = 1 + tamanho l"
               (tamanho (cons 1 (list 2 3)))
               (add1 (tamanho (list 2 3)))))


(run-tests
 (test-suite "todos os testes"
             testes-soma
             testes-mult
             testes-tamanho))
