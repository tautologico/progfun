#lang racket

(require rackunit rackunit/text-ui)

(define digit->letter-map
  '((1   "I")
    (4   "IV")
    (5   "V")
    (9   "IX")
    (10  "X")
    (40  "XL")
    (50  "L")
    (90  "XC")
    (100 "C")
    (400 "CD")
    (500 "D")
    (900  "CM")
    (1000 "M")))

(define (d->l-letra p) (second p))
(define (d->l-valor p) (first p))

(define (digit->letter d)
  (define res (assoc d digit->letter-map))
  (if res (second res) #f))

(define letter->valor-map
  '(("I" 1)
    ("V" 5)
    ("X" 10)
    ("L" 50)
    ("C" 100)
    ("D" 500)
    ("M" 1000)))

(define (letra->valor l)
  (define res (assoc l letter->valor-map))
  (if res (second res) #f))

(define (ordem-letra l)
  (define (loop lst ix)
    (cond [(empty? lst) #f]
          [(string=? (first (first lst)) l)
           ix]
          [else (loop (rest lst) (add1 ix))]))
  (loop letter->valor-map 0))

(define (maior-letra n)
  (define (loop lst)
    (cond [(empty? lst) (error "maior-letra: nao encontrada")]
          [(<= (d->l-valor (first lst))
               n)
           (first lst)]
          [else (loop (rest lst))]))
  (loop (reverse digit->letter-map)))

(define (number->roman n)
  (cond [(zero? n) ""]
        [else
         (define letra-valor-par (maior-letra n))
         (string-append (d->l-letra letra-valor-par)
                        (number->roman (- n
                                          (d->l-valor letra-valor-par))))]))

(define (roman->number r)
  (define (loop i val ordem)
    (if (< i 0)
        val
        (let ([letra (string (string-ref r i))])
          (cond [(< i 0) val]
                [(< (ordem-letra letra) ordem)
                 (loop (sub1 i)
                       (- val (letra->valor letra))
                       ordem)]
                [else
                 (loop (sub1 i)
                       (+ val (letra->valor letra))
                       (ordem-letra letra))]))))
  (loop (sub1 (string-length r))
        0
        0))

(define-test-suite testes
  (test-equal? "d->l"   (digit->letter 5) "V")
  (test-equal? "d->l"   (digit->letter 8) #f)

  (test-equal? "maior-letra" (maior-letra 132)   '(100 "C"))
  (test-equal? "maior-letra" (maior-letra 1)     '(1 "I"))
  (test-equal? "maior-letra" (maior-letra 1000)  '(1000 "M"))
  (test-equal? "maior-letra" (maior-letra 34427) '(1000 "M"))

  (test-equal? "ordem-letra" (ordem-letra "I") 0)
  (test-equal? "ordem-letra" (ordem-letra "X") 2)
  (test-equal? "ordem-letra" (ordem-letra "M") 6)

  (test-equal? "um"     (number->roman 1) "I")
  (test-equal? "dois"   (number->roman 2) "II")
  (test-equal? "tres"   (number->roman 3) "III")
  (test-equal? "quatro" (number->roman 4) "IV")
  (test-equal? "cinco"  (number->roman 5) "V")
  (test-equal? "oito"   (number->roman 8) "VIII")
  (test-equal? "nove"   (number->roman 9) "IX")
  (test-equal? "treze"  (number->roman 13) "XIII")
  (test-equal? "37"     (number->roman 37) "XXXVII")
  (test-equal? "49"     (number->roman 49) "XLIX")
  (test-equal? "999"    (number->roman 999) "CMXCIX")
  (test-equal? "3247"   (number->roman 3247) "MMMCCXLVII")
  (test-equal? "2019"   (number->roman 2019) "MMXIX")

  (test-equal? "MMXIX"  (roman->number "MMXIX") 2019)
  (test-equal? "999"  (roman->number "CMXCIX") 999)
  (test-equal? "3247" (roman->number "MMMCCXLVII") 3247))

(run-tests testes)
