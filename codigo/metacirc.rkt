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
  (eval-temp-env (cria-assoc-params param-names args) body))

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

;;
;; eval-temp-env avalia a expressão exp em um ambiente (environment) temporário.
;; A função salva o ambiente (environment) atual, adiciona as novas
;; variaveis em newvars ao ambiente, avalia a expressão exp no novo ambiente,
;; restaura o ambiente anterior, e retorna o valor avaliado para a expressão exp.
;; Isso é usado nas chamadas de função (para criar o ambiente local da função) e
;; em testes.
;;
(define (eval-temp-env newvars exp)
  (define old-env env)
  (set! env (append newvars env))
  (define val (eval exp))
  (set! env old-env)
  val)

(module+ test
  (require rackunit rackunit/text-ui)

  (define-test-suite test-eval
    (test-equal? "constante inteira" (eval 2) 2)
    (test-equal? "constante de ponto flutuante" (eval 3.14) 3.14)
    (test-equal? "booleano #t" (eval #t) #t)
    (test-equal? "booleano #f" (eval #f) #f)
    (test-equal? "primitiva +" (eval '(+ 2 3)) 5)
    (test-equal? "primitiva *" (eval '(* 2 3)) 6)
    (test-equal? "referência a uma variável"
                 (eval-temp-env '((x 2)) '(+ x 7))
                 9)
    (test-equal? "referência a uma variável com valor de função"
                 (eval-temp-env '((f (fun (n) (* n 7))))
                                '(f (+ 3 2)))
                 35))

  (run-tests test-eval))
