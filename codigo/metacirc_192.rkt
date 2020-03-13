#lang racket

(define special-forms
  (list 'define
        'if
        'lambda))

(define env '())

(define (adiciona-primitiva nome racket-f)
  (set! env
        (cons (list nome (list 'prim racket-f))
              env)))

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
        [(equal? form 'lambda) (eval-lambda e)]
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

(define (eval-lambda e)
  (unless (= (length e) 3)
    (error "Erro de sintaxe no lambda"))
  (define params (second e))
  (define body (third e))
  (unless (list? params)
    (error "Erro de sintaxe: lista de parametros no lambda"))
  (list 'fun params body))

(define (function? val)
  (and (list? val)
       (or (eq? (first val) 'fun)
           (eq? (first val) 'prim))))

(define (env-pair name val)
  (list name val))

(define (add-env-pair name val e)
  (cons (env-pair name val) e))

(define (extend-env params args)
  (cond [(empty? params) env]
        [else (add-env-pair (first params) (first args)
                            (extend-env (rest params) (rest args)))]))
        
(define (function-call f args)
  (define params (second f))
  (define body (third f))
  (unless (= (length params) (length args))
    (error "Numero de parametros incorreto para a funcao"))
  (define old-env env)
  (set! env (extend-env params args))
  (define val (eval body))
  (set! env old-env)
  val)

(define (prim-call f args)
  (apply (second f) args))

(define (eval-funcall e)
  (define fexp (first e))
  (define args (rest e))
  (define fval (eval fexp))
  (unless (function? fval)
    (error (format "Nao eh funcao: ~a" fval)))
  (define argvals (map eval args))
  (cond [(eq? (first fval) 'fun) (function-call fval argvals)]
        [(eq? (first fval) 'prim) (prim-call fval argvals)]
        [else (error
               (format "Valor de funcao nao reconhecido: ~a"
                       (first fval)))]))

(define (eval-list e)
  (cond [(empty? e) '()]
        [(special-form? (first e)) (eval-special e)]
        [else (eval-funcall e)]))

(define (eval e)
  (cond [(atom? e) (eval-atom e)]
        [(list? e) (eval-list e)]
        [else (error (format "Expressao nao reconhecida: ~a" e))]))

;; --- primitivas ------------
(adiciona-primitiva '+ +)
(adiciona-primitiva '* *)

;;(adiciona-primitiva '*2 (lambda (x) (* x 2)))
