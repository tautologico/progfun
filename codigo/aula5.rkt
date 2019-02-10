#lang racket

(define (soma-lista lst)
  (if (empty? lst) 0
      (+ (first lst) (soma-lista (rest lst)))))

#|

Pelo modelo de substituicao:

(soma-lista (list 3 5 2))
 = (+ 3 (soma-lista '(5 2)))
 = (+ 3 (+ 5 (soma-lista '(2))))
 = (+ 3 (+ 5 (+ 2 (soma-lista '()))))
 = (+ 3 (+ 5 (+ 2 0)))
 = (+ 3 (+ 5 2))
 = (+ 3 7)
 = 10

|#

(define (pertence? x lst)
  (cond [(empty? lst) #f]
        [(equal? x (first lst)) #t]
        [else (pertence? x (rest lst))]))

#|

(pertence? 3 (lista 1 4 5 7))
 = (pertence? 3 '(4 5 7))
 = (pertence? 3 '(5 7))
 = (pertence? 3 '(7))
 = (pertence? 3 '())
 = #f


|#



(define (soma-lista-2 lst)
  (define (soma-lista-acc lst acc)
    (if (empty? lst)
        acc
        (soma-lista-acc (rest lst) (+ (first lst) acc))))
  (soma-lista-acc lst 0))

#|

(soma-lista-acc '(3 5 2) 0)
 = (soma-lista-acc '(5 2) (+ 3 0))
 = (soma-lista-acc '(5 2) 3)
 = (soma-lista-acc '(2) (+ 5 3))
 = (soma-lista-acc '(2) 8)
 = (soma-lista-acc '() (+ 2 8))
 = (soma-lista-acc '() 10)
 = 10


|#

