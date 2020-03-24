#lang racket

(define special-forms
  (list 'define
        'if
        'lambda))

(define env '())

;; cria um environment (lista de pares de nomes de variaveis com seus valores)
;; usando os nomes na lista names e os valores na lista vals
(define (create-env names vals)
  (cond [(empty? names) '()]
        [else (cons (list (first names) (first vals))
                    (create-env (rest names) (rest vals)))]))

;; adiciona a primitiva com nome nome no ambiente,
;; associando a nova primitiva à função Racket racket-f 
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
  (eval-temp-env (create-env params args) body))

(define (prim-call f args)
  (apply (second f) args))

(define (eval-funcall e)
  (define fexp (first e))
  (define args (rest e))
  (define fval (eval fexp))
  (unless (function? fval)
    (error (format "Nao eh funcao: ~a" fval)))
  (define argvals (map eval args))
  (cond [(eq? (first fval) 'fun)  (function-call fval argvals)]
        [(eq? (first fval) 'prim) (prim-call fval argvals)]
        [else (error
               (format "Valor de funcao nao reconhecido: ~a"
                       (first fval)))]))

;;
;; eval-temp-env avalia a expressão exp em um ambiente (environment) temporário.
;; A função salva o ambiente (environment) atual, adiciona as novas
;; variaveis na lista newvars ao ambiente, avalia a expressão exp no novo ambiente,
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

;; primitiva que dobra o valor do parametro, exemplo da possibilidade de adicionar
;; primitivas que não existem em Racket
(adiciona-primitiva '*2 (lambda (x) (* x 2)))


;; --- testes ----------------------------------------------

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
                 35)
    (test-equal? "primitiva *2" (eval '(*2 7)) 14))

  (run-tests test-eval))
