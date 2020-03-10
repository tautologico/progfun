#lang racket

(define special-forms
  (list 'define
        'if))

(define env '((x 42)
              (y "string")))

(define (lookup s)
  (define pair (assoc s env))
  (if (not (false? pair))
      (second pair)
      (error (format "Variavel nao definida: ~a" s))))
  
(define (atom? e)
  (or (number? e)
      (string? e)
      (boolean? e)
      (symbol? e)))

(define (eval-atom e)
  (cond [(symbol? e) (lookup e)]
        [else e]))

(define (special-form? e)
  (and (symbol? e)
       (member e special-forms)))
       

(define (eval-special e)
  (define form (first e))
  (cond [(equal? form 'define) (eval-define e)]
        [(equal? form 'if) (eval-if e)]
        [else (error (format "Forma especial nao reconhida: ~a" form))]))

(define (eval-define e)
  (unless (= (length e) 3)
    (error "Erro de sintaxe no define: (define s exp)"))
  (unless (symbol? (second e))
    (error "define: nome de variavel esperado"))
  (define value (eval (third e)))
  (set! env (cons (list (second e) value)
                  env)))

(define (eval-if e)
  (unless (= (length e) 4)
    (error "Erro de sintaxe no if"))
  (define c (second e))
  (define e1 (third e))
  (define e2 (fourth e))
  (if (eval c)
      (eval e1)
      (eval e2)))

(define (eval-list e)
  (cond [(empty? e) '()]
        [(special-form? (first e)) (eval-special e)]
        [else (error "Ainda nao implementado")]))

(define (eval e)
  (cond [(atom? e) (eval-atom e)]
        [(list? e) (eval-list e)]
        [else (error (format "Expressao nao reconhecida: ~a" e))]))
