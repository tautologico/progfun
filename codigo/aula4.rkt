#lang racket

;; numeros naturais
;;
;; um numero natural pode ser:
;; - zero
;; - o sucessor de um numero natural
;;

;; (soma n) retorna a soma dos numeros 1 + 2 + ... + n
(define (soma n)
  (if (zero? n)
      0
      (+ n (soma (sub1 n)))))


;; listas
;;
;; uma lista pode ser:
;; - a lista vazia '()
;; - (cons x lst) onde lst é uma lista
;;
;; exemplo: (cons 1 (cons 2 (cons 3 '())))
;;          '(1 2 3)
;;          (list 1 2 3)

;; (tamanho lst) retorna o numero de elementos na lista lst
(define (tamanho lst)
  (cond [(empty? lst) 0]
        [else (add1 (tamanho (rest lst)))]))

;; (remove-primeiro x lst) retorna uma lista igual a lst
;; mas sem a primeira ocorrencia do elemento x (se houver)
(define (remove-primeiro x lst)
  (cond [(empty? lst) '()]
        [(equal? x (first lst)) (rest lst)]
        [else (cons (first lst) (remove-primeiro x (rest lst)))]))

(define (remove-todos x lst)
  (cond [(empty? lst) '()]
        [(equal? x (first lst)) (remove-todos x (rest lst))]
        [else (cons (first lst) (remove-todos x (rest lst)))]))

;; (remove-duplicatas lst) retorna uma lista igual a lst
;; mas com apenas uma ocorrencia de cada elemento de lst
(define (remove-duplicatas lst)
  (cond [(empty? lst) '()]
        [(cons (first lst) (remove-todos (first lst)
                                         (remove-duplicatas (rest lst))))]))


;; (combine l1 l2) retorna pares de elementos com o primeiro do
;; par tirado de l1 e o segundo de l2
(define (combine l1 l2)
  (cond [(empty? l1) '()]
        [(empty? l2) '()]
        [else (cons (list (first l1) (first l2))
                    (combine (rest l1) (rest l2)))]))

