#lang racket

;; Neste exercício vamos usar testes,
;; o objetivo é terminar com todos os testes passando
(require rackunit rackunit/text-ui)

;; --- Exercício 1 ---------------------

;; Crie uma função (mult m n) que multiplica os dois números
;; naturais m e n, usando apenas a operação de soma.

;; aqui está uma definição incorreta da função, para que os testes funcionem.
;; para resolver o exercício deve-se alterar o corpo da função para uma versão
;; que faça os testes passarem
(define (mult m n)
  #f)

(define-test-suite testes-mult
  (test-equal? "3 * 4"  (mult 3 4)    12)
  (test-equal? "5 * 0"  (mult 5 0)    0)
  (test-equal? "0 * 5"  (mult 0 5)    0)
  (test-equal? "13 * 1" (mult 13 1)   13)
  (test-equal? "1 * 13" (mult 1 13)   13))

;; --- Exercício 2 ---------------------

;; Crie uma função (sub m n) que calcula a subtração de m por n,
;; usando apenas as funções add1 e sub1. Pode ser assumido que
;; m >= n, mas não é difícil escrever uma função que funcione mesmo
;; quando m < n.

(define (sub m n)
  #f)

(define-test-suite testes-sub
  (test-equal? "42 - 0"  (sub 42 0)   42)
  (test-equal? "32 - 16" (sub 32 16)  16)
  (test-equal? "42 - 42" (sub 42 42)  0)
  (test-equal? "11 - 10" (sub 11 10)  1))

;; --- Exercício 3 ---------------------

;; Crie uma função (par n) que retorna #t se n é par e #f se n é ímpar. Em seguida,
;; crie uma função (impar n) que retorna #t se n é ímpar e #f se n é par. Pense em
;; como definir uma usando a outra (ver observações nas notas de aula).

(define (par n)
  0)

(define (impar n)
  0)

(define-test-suite testes-par-impar
  (test-true "2 é par"         (par 2))
  (test-true "0 é par"         (par 0))
  (test-true "42 é par"        (par 42))
  (test-false "3 não é par"    (par 3))
  (test-false "111 não é par"  (par 111))
  (test-false "12 não é ímpar" (impar 12))
  (test-false "0 não é ímpar"  (impar 0))
  (test-true "7 é ímpar"       (impar 7))
  (test-true "353 é ímpar"     (impar 353)))

;; --- Exercício 4 ---------------------

;; Altere a definição de lista-ex4, abaixo, para que ela contenha os números
;; de 1 a 5, em ordem crescente, usando apenas cons e a lista vazia
(define lista-ex4 '())

;; para não entregar a resposta no teste, vamos construir a resposta de outra forma...
(define-test-suite teste-ex4
  (test-equal? "numeros de 1 a 5" lista-ex4 (range 1 6)))

;; --- Exercício 5 ---------------------

;; Altere a definição de lista-ex5, abaixo, para que ela contenha os números
;; de 1 a 5, em ordem crescente, usando a notação com apóstrofo ou a função list
(define lista-ex5 '())

(define-test-suite teste-ex5
  (test-equal? "numeros de 1 a 5" lista-ex5 (range 1 6)))


;; --- Exercício 6 ---------------------

;; Considere a lista6, a seguir
(define lista6 (list 11 22 33 44 55 66))

;; Altere a definição da variável elem3-lista6, abaixo, para que ele tenha
;; o valor do terceiro elemento de lista6, usando apenas as funções first e rest
(define elem3-lista6 #f)

(define-test-suite teste-ex6
  (test-equal? "elem3-lista6 deve ser 33" elem3-lista6 33))

;; --- Exercício 7 ---------------------

;; Escreva a função terceiro-elemento, abaixo, que retorna sempre o terceiro
;; elemento da lista l. Suponha que l sempre tenha 3 elementos ou mais.
(define (terceiro-elemento l)
  #f)

(define-test-suite testes-terceiro-elemento
  (test-equal? "3o de '(1 2 3)" (terceiro-elemento (list 1 2 3))   3)
  (test-equal? "3o de '(4 8 15 16 23 42)"
               (terceiro-elemento (list 4 8 15 16 23 42))
               15))


;; --- Exercício 8 ---------------------

;; Crie uma função recursiva soma-lista (abaixo) que, dada uma lista de números,
;; calcula a soma dos números contidos
(define (soma-lista l)
  #f)

(define-test-suite testes-soma-lista
  (test-equal? "soma da lista vazia"                (soma-lista '())                  0)
  (test-equal? "soma de um número apenas"           (soma-lista '(13))                13)
  (test-equal? "soma de vários números"             (soma-lista (list 5 4 3 2 1))     15)
  (test-equal? "soma de números em ordem diferente" (soma-lista (list 1 2 3 4 5))     15)
  (test-equal? "soma de lista com zero"             (soma-lista (list 1 0 2 0 13 0))  16))

;; --- Exercício 9 ---------------------

;; Crie uma função recursiva mult-lista (abaixo) que, dada uma lista de números,
;; calcula o produto dos números contidos (a lista vazia deve ter produto igual a 1)
(define (mult-lista l)
  #f)

(define-test-suite testes-mult-lista
  (test-equal? "produto da lista vazia"            (mult-lista '())                  1)
  (test-equal? "produto de lista com zero"         (mult-lista (list 1 0 2 0 13 0))  0)
  (test-equal? "produto de um número"              (mult-lista '(55))                55)
  (test-equal? "produto de vários números"         (mult-lista (list 1 2 3 4 5))     120)
  (test-equal? "produto de números em outra ordem" (mult-lista (list 2 5 1 4 3))     120))

;; --- Exercício 10 --------------------

;; Crie uma função recursiva max-lista (abaixo) que, dada uma lista de números naturais,
;; calcula o maior número entre os presentes na lista. Use (max-lista '()) = 0.
(define (max-lista l)
  #f)

(define-test-suite testes-max-lista
  (test-equal? "maximo da lista vazia"       (max-lista '())                     0)
  (test-equal? "maximo de lista unitaria"    (max-lista '(22))                   22)
  (test-equal? "maximo de lista com numeros" (max-lista (list 8 55 13 24 45))    55)
  (test-equal? "maximo não muda com ordem"   (max-lista (list 45 13 8 55 24))    55)
  (test-equal? "maximo de lista com zeros"   (max-lista (list 1 0 13 0 356 0))   356))

;; --- Exercício 11 --------------------

;; Crie uma funcao elemento-n (abaixo) que, dada uma lista (que pode conter
;; números ou outros tipos de elementos) e um número n, retorna o n-ésimo
;; elemento da lista, contando a partir de zero. Se n é maior ou igual ao
;; tamanho da lista, a função deve retornar #f (veja os testes para exemplos
(define (elemento-n lista n)
  '())  ;; usando '() ao inves de #f pois #f é um valor de retorno válido

(define-test-suite testes-elemento-n
  (test-equal? "elemento de lista vazia" (elemento-n '() 0)                #f)
  (test-equal? "elemento 0"              (elemento-n (list 1 2 3 4 5) 0)    1)
  (test-equal? "elemento 3"              (elemento-n (list 1 2 3 4 5) 3)    4)
  (test-equal? "ultimo elemento"         (elemento-n (list 1 2 3 4 5) 4)    5)
  (test-equal? "indice fora da lista"    (elemento-n (list 1 2 3 4 5) 7)    #f))

;; --- Exercício 12 --------------------

;; Muitas vezes precisamos transformar os elementos de uma lista da mesma
;; maneira. Escreva a função quadrado-lista (abaixo) que, dada uma lista de
;; números, obtém uma lista contendo o quadrado de cada número da lista
;; original (nas mesmas posições)
(define (quadrado-lista l)
  #f)

(define-test-suite testes-quadrado-lista
  (test-equal? "quadrado da lista vazia"  (quadrado-lista '())        '())
  (test-equal? "quadrado de um número"    (quadrado-lista '(5))       25)
  (test-equal? "quadrado de números"
               (quadrado-lista (list 2 5 12 25))
               (list 4 25 144 625)))

;; --- Exercício 13 --------------------

;; Agora vamos selecionar itens em uma lista. Crie uma função filtra-par (abaixo)
;; que, dado uma lista de números naturais, retorna uma outra lista contendo apenas
;; os números pares da lista original. Use a função par definida no exercício 3
(define (filtra-par l)
  #f)

(define-test-suite testes-filtra-par
  (test-equal? "filtragem da lista vazia"     (filtra-par '())                  '())
  (test-equal? "filtragem de lista sem pares" (filtra-par (list 1 3 5 7 9))     '())
  (test-equal? "filtragem de lista com pares" (filtra-par (list 1 2 3 4 5))     (list 2 4))
  (test-equal? "filtragem com todos os itens pares"
               (filtra-par (list 2 4 22 144))
               (list 2 4 22 144)))

;; --- Executa todos os testes ---------
(run-tests
 (test-suite "todos os testes"
             testes-mult
             testes-sub
             testes-par-impar
             teste-ex4
             teste-ex5
             teste-ex6
             testes-terceiro-elemento
             testes-soma-lista
             testes-mult-lista
             testes-max-lista
             testes-elemento-n
             testes-quadrado-lista
             testes-filtra-par))
