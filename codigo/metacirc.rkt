#lang racket

(define env `((* (prim ,*))
              (- (prim ,-))
              (+ (prim ,+))))

(define (symbol-value fn)
  (define val (assoc fn env))
  (if val
      (second val)
      (error (format "Nome nao definido: ~a" fn))))

(define (eval-if args)
  (define cnd    (eval (first args)))
  (define etrue  (second args))
  (define efalse (third args))
  (cond [(not (boolean? cnd))
         (error (format "Expressão nao booleana em if: ~a" (first args)))]
        [cnd  (eval etrue)]
        [else (eval efalse)]))

(define (eval-define args)
  (define name (first args))
  (define val  (eval (second args)))
  (set! env (cons (list name val)
                  env)))

(define (eval-lambda args)
  (define params (first args))
  (define body (second args))
  (list 'fun params body))

(define (funcao? v)
  (and (list? v)
       (not (empty? v))
       (eq? (first v) 'fun)))

(define (cria-assoc-params pnames pvals)
  (cond [(empty? pnames) '()]
        [else (cons (list (first pnames) (first pvals))
                    (cria-assoc-params (rest pnames) (rest pvals)))]))

(define (apply-fun f args)
  (define param-names (second f))
  (define body        (third f))
  (define old-env     env)
  (set! env (append (cria-assoc-params param-names args) env))
  (define val (eval body))
  (set! env old-env)
  val)

(define (prim? f)
  (and (list? f)
       (not (empty? f))
       (eq? (first f) 'prim)))

(define (apply-prim f args)
  (define fval (second f))
  (apply fval args))
  
(define (eval-fun fname args)
  (define fval (symbol-value fname))
  (cond [(funcao? fval) (apply-fun fval (map eval args))]
        [(prim? fval)   (apply-prim fval (map eval args))]
        [else (error (format "Valor nao funcional em posicao de funcao: ~a" fval))]))
  
(define (eval-list lst)
  (define prim (first lst))
  (define args (rest lst))
  (cond [(symbol? prim)
         (cond [(eq? prim 'if)     (eval-if args)]
               [(eq? prim 'define) (eval-define args)]
               [(eq? prim 'lambda) (eval-lambda args)]
               [else (eval-fun prim args)])]
         [(or (number? prim)
              (boolean? prim))
          (error (format "Nao é uma funcao: ~a" prim))]
         [(list? prim) (error "*** nao implementado")]
         [else
          (error (format "Expressao nao reconhecida em posicao de funcao: ~a" prim))]))
  
(define (eval exp)
  (cond [(number? exp) exp]
        [(boolean? exp) exp]
        [(symbol? exp) (symbol-value exp)]
        [(list? exp) (eval-list exp)]
        [else
         (error (format "Expressao de tipo nao reconhecido: ~a" exp))]))

