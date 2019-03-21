#lang racket

;; --- ambiente com valores das variáveis ------------------
(define env '())

;; obtem o valor de um símbolo no ambiente, se existir
(define (symbol-value fn)
  (define val (assoc fn env))
  (if val
      (second val)
      (error (format "Nome nao definido: ~a" fn))))

;; avalia uma expressão condicional (if)
(define (eval-if args)
  (define cnd    (eval (first args)))
  (define etrue  (second args))
  (define efalse (third args))
  (cond [(not (boolean? cnd))
         (error (format "Expressão nao booleana em if: ~a" (first args)))]
        [cnd  (eval etrue)]
        [else (eval efalse)]))

;; avalia uma definição (define)
(define (eval-define args)
  (define name (first args))
  (define val  (eval (second args)))
  (set! env (cons (list name val)
                  env)))

;; avalia uma expressão de função anônima (lambda)
(define (eval-lambda args)
  (define params (first args))
  (define body (second args))
  (list 'fun params body))

;; verifica se um valor é uma função
(define (funcao? v)
  (and (list? v)
       (not (empty? v))
       (eq? (first v) 'fun)))

(define (cria-assoc-params pnames pvals)
  (cond [(empty? pnames) '()]
        [else (cons (list (first pnames) (first pvals))
                    (cria-assoc-params (rest pnames) (rest pvals)))]))

;; aplica a função f aos argumentos args
(define (apply-fun f args)
  (define param-names (second f))
  (define body        (third f))
  (eval-temp-env (cria-assoc-params param-names args) body))

;; verifica se um valor é uma primitiva (função definida usando Racket)
(define (prim? f)
  (and (list? f)
       (not (empty? f))
       (eq? (first f) 'prim)))

;; aplica a primitiva f aos argumentos args
(define (apply-prim f args)
  (define fval (second f))
  (apply fval args))

;; avalia uma aplicação de função ou primitiva (identificada pelo nome fname)
;; aos argumentos args
(define (eval-fun fname args)
  (define fval (symbol-value fname))
  (cond [(funcao? fval) (apply-fun fval (map eval args))]
        [(prim? fval)   (apply-prim fval (map eval args))]
        [else (error (format "Valor nao funcional em posicao de funcao: ~a" fval))]))

;; avalia uma lista de expressões
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

;; avalia a expressão exp de acordo com o ambiente (global) env
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

;; --- primitivas do interpretador -------------------------

;; adiciona uma primitiva de nome nome, que executa a função
;; em Racket dada pela função fun. Ver exemplos abaixo
(define (adiciona-primitiva nome fun)
  (set! env
        (cons (list nome (list 'prim fun))
              env)))

;; --- primitivas aritméticas -------------------------

;; a expressão a seguir adiciona a adição como primitiva do interpretador.
;; o nome da primitiva é dada pelo símbolo + (veja que usamos o quote antes
;; do nome), e a função da primitiva é a função + da linguagem Racket 
(adiciona-primitiva '+ +)

;; da mesma forma podemos adicionar multiplicação
(adiciona-primitiva '* *)

;; a função que implementa a primitiva não precisa ser pré-definida
;; em Racket: podemos usar qualquer função válida da linguagem Racket.
;; como exemplo, vamos adicionar uma primitiva para multiplicar um número por 2.
;; o nome da primitiva é "*2", e a função ligada a essa primitiva é uma função
;; que multiplica o parâmetro por 2:
(adiciona-primitiva '*2 (lambda (x) (* x 2)))

;; dessa forma, (eval '(*2 7)) tem valor 14 (veja no REPL ou no teste abaixo)


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
