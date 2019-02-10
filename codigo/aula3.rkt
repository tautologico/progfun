#lang racket

(define (concat-lista l1 l2)
  (if (empty? l1)
      l2
      (cons (first l1) (concat-lista (rest l1) l2))))

(define (fatorial n)
  (if (zero? n)
      1
      (* n (fatorial (sub1 n)))))

(define (fatorial-acc n acc)
  (if (zero? n)
      acc
      (fatorial-acc (sub1 n) (* n acc))))


(define (soma m n)
  (if (zero? n)
      m
      (soma (add1 m) (sub1 n))))