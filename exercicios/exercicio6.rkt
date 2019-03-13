#lang racket

(require rackunit rackunit/text-ui)

;;
;; Exercício 6 - Padrões de recursividade e funções de alta ordem - Parte 2
;; 

;;
;; --- Questão 1 ----------------------------
;;
;; Outra atividade comum em coleções é selecionar apenas os itens que satisfazem
;; alguma condição. Por exemplo, de uma lista de clientes, selecionar apenas
;; aqueles que optaram por receber a newsletter da empresa.
;;
;; Este também é um padrão comum de recursividade que já vimos, por exemplo,
;; na função lista-pares para selecionar apenas os números pares de uma lista de
;; números:
(define (lista-pares lst)
  (cond [(empty? lst) '()]
        [(even? (first lst)) (cons (first lst) (lista-pares (rest lst)))]
        [else (lista-pares (rest lst))]))

;; A função de alta ordem filter captura esse padrão de recursividade de forma
;; que se lst é uma lista e p uma função que retorna um valor booleano (um predicado)
;; (filter p lst) retorna uma lista contendo os itens de lst que satisfazem p
;; (ou seja, que retornam #t quando passadas para p). Escreva a função filter,
;; seguindo o padrão acima. Opcionalmente, escreva filter de maneira mais
;; eficiente, com recursividade de cauda.
(define (filter p lst) #f)

(define-test-suite test-filter
  (test-equal? "Lista vazia" (filter (lambda (x) #t) '()) '())
  (test-equal? "Nenhum item filtrado"
               (filter (lambda (x) #f) (list 1 2 3 4 5))
               '())
  (test-equal? "Todos os itens"
               (filter (lambda (x) #t) (list 1 2 3 4 5))
               '(1 2 3 4 5))
  (test-equal? "Alguns itens"
               (filter even? (list 1 2 3 4 5))
               '(2 4)))

;;
;; --- Questão 2 ----------------------------
;;
;; Usando filter, escreva as funções filtra-par e filtra-impar que filtram
;; apenas os números pares e ímpares, respectivamente, de uma lista de números.
;; Racket já define os predicados even? e odd? para testar se um número é par ou
;; ímpar (respectivamente)
(define (filtra-par lst) #f)

(define (filtra-impar lst) #f)

(define-test-suite test-filtra-par-impar
  (test-equal? "lista vazia - par"   (filtra-par '())    '())
  (test-equal? "lista vazia - ímpar" (filtra-impar '())  '())
  (test-equal? "filtra pares"   (filtra-par   (list 1 2 3 4 5)) '(2 4))
  (test-equal? "filtra impares" (filtra-impar (list 1 2 3 4 5)) '(1 3 5)))


;;
;; --- Questão 3 ----------------------------
;;
;; Agora queremos escrever uma função filtra-par-lg que aceita listas
;; gerais, que podem conter valores de qualquer tipo, mas ainda assim
;; selecionar apenas os números pares. Chamar even? em um valor que
;; não é um número inteiro resulta em um erro. Escreva a função
;; filtra-par-lg. Em Racket existe o predicado integer? que retorna
;; #t se o parâmetro passado é um número inteiro.
;;
(define (filtra-par-lg lst) #f)  ;; lst pode conter valores de qualquer tipo

(define-test-suite test-filtra-lg
  (test-equal? "lista vazia" (filtra-par-lg '()) '())
  
  (test-equal? "apenas inteiros"
               (filtra-par-lg (list 1 2 3 4 5 6))
               '(2 4))
  
  (test-equal? "apenas pares"
               (filtra-par-lg (list 2 4 6))
               '(2 4 6))

  (test-equal? "lista heterogenea"
               (filtra-par-lg (list "Napoli" 2 "Milano" 7 11 8 "Roma" 0 3))
               '(2 8 0))

  (test-equal? "lista heterogenea sem inteiros"
               (filtra-par-lg (list #f #t 2.7 "Beijing" 'var 3.14 "Shanghai"))
               '()))


;;
;; --- Questão 4 ----------------------------
;;
;; Escreva a função filtra-comp para filtrar o complemento de um
;; predicado, ou seja, (filtra-comp p lst) retorna uma lista com
;; os itens da lista lst para os quais o predicado p retorna #f.
(define (filtra-comp p lst) #f)

(define-test-suite test-filtra-comp
  (test-equal? "lista vazia" (filtra-comp (lambda (x) #f) '()) '())
  (test-equal? "strings que nao comecam com pre"
               (filtra-comp (lambda (s) (string-prefix? s "pre"))
                            (list "precificado" "precalculado" "optimizado"))
               (list "optimizado"))
  (test-equal? "todos os elementos"
               (filtra-comp (lambda (x) #f) (list 1 2 3 4 5 6))
               '(1 2 3 4 5 6))
  (test-equal? "nenhum elemento"
               (filtra-comp (lambda (x) #t) (list 1 2 3 4 5 6))
               '()))

;;
;; --- Questão 5 ----------------------------
;;
;; Também são comuns situações em que precisamos combinar os padrões capturados
;; pelas funções map, fold e filter.
;; Escreva uma função tamanho-lista-strings que, dada uma lista de strings, calcula
;; o tamanho total de todas as strings. Uma forma de fazer é concatenar todas as
;; strings primeiro, e depois calcular o tamanho do resultado, mas é provavelmente
;; mais eficiente usar map depois um fold.
;;
;; A eficiência da solução gerada não será
;; julgada aqui, mas como bônus, escreva as duas soluções, gere uma lista com um
;; bom número de strings (100 mil, 1 milhão), e teste as duas funções usando a
;; macro time da linguagem Racket: (time exp) avalia o valor da expressão exp
;; e imprime o tempo que foi usado na avaliação da expressão.
(define (tamanho-lista-strings lstr) #f)

(define-test-suite test-tamanho-lista
  (test-equal? "lista vazia" (tamanho-lista-strings '()) 0)
  (test-equal? "algumas strings"
               (tamanho-lista-strings (list "Tokyo" "Osaka" "Nara"))
               14)
  (test-equal? "strings vazias não alteram resultado"
               (tamanho-lista-strings (list "" "Tokyo" "Osaka" "" "Nara" ""))
               14))


;;
;; --- Questão 6 ----------------------------
;;
;; Escreva uma função todos? tal que (todos? p lst) retorna #t se todos
;; os elementos da lista lst satisfazem o predicado p, e #f caso contrário.
;;
(define (todos? p lst) 0)

(define-test-suite test-todos
  (test-true  "lista vazia" (todos? (lambda (x) #f) '()))
  (test-false "alguns itens #t"
              (todos? even? (list 1 2 3 4 5)))
  (test-true "todos itens #t"
             (todos? even? (list 2 4 6 8 10)))
  (test-false "nenhum item #t"
              (todos? even? (list 1 3 5 7 9 11))))


;;
;; --- Questão 7 ----------------------------
;;
;; Escreva uma função algum? tal que (algum? p lst) retorna #t se algum
;; elemento da lista lst satisfaz o predicado p, e #f caso contrário.
;;
(define (algum? p lst) 0)

(define-test-suite test-algum
  (test-false "lista vazia" (algum? (lambda (x) #f) '()))
  (test-true  "alguns itens #t"
              (algum? even? (list 1 2 3 4 5)))
  (test-true  "todos itens #t"
              (algum? even? (list 2 4 6 8 10)))
  (test-false "nenhum item #t"
              (algum? even? (list 1 3 5 7 9 11))))


;;
;; --- Questão 8 ----------------------------
;;
;;
;; Uma outra função útil similar a filter é partition, que particiona uma
;; lista (ou outra coleção) em duas: uma contendo os elementos que satisfazem
;; o predicado, e outra contendo os elementos que não satisfazem o predicado.
;; Escreva a função partition que retorna uma lista com dois elementos: o primeiro
;; é uma lista com os elementos de lst que satisfazem o predicado, e o segundo
;; é a lista com os elementos que não satisfazem.
(define (partition p lst) #f)

(define-test-suite test-partition
  (test-equal? "Lista vazia"
               (partition (lambda (x) #t) '())
               '(() ()))
  (test-equal? "Pares e ímpares"
               (partition even? (list 1 2 3 4 5))
               '((2 4) (1 3 5)))
  (test-equal? "ímpares e pares"
               (partition odd? (list 1 2 3 4 5))
               '((1 3 5) (2 4)))
  (test-equal? "apenas pares"
               (partition even? (list 2 4 6 8))
               '((2 4 6 8) ()))
  (test-equal? "apenas ímpares"
               (partition even? (list 1 3 5 7))
               '(() (1 3 5 7))))

;;
;; --- Questão 9 ----------------------------
;;
;;
;; Escreva uma função menor-quociente tal que
;; (menor-quociente x lst)
;; retorna o menor valor entre os obtidos dividindo x por cada número da lista
;; lst. Por exemplo, para (menor-quociente 12 (list 2 3 4)), dividindo 12 por
;; cada número da lista obtemos (6 4 3), o menor dos valores é 3, então
;; (menor-quociente 12 (list 2 3 4)) retorna 3. Os parâmetros podem ser
;; números reais arbitrários. A função deve evitar dividir por zero.
;;
;; Crie também um conjunto de testes e inclua a suíte de testes criados
;; na execução dos testes ao final do arquivo. Inclua nos testes listas
;; com números reais, positivos e negativos, menores que 1, e zero. 
(define (menor-quociente x lst) #f)


;; --- Executa todos os testes ---------
(run-tests
 (test-suite "todos os testes"
             test-filter
             test-filtra-par-impar
             test-filtra-lg
             test-filtra-comp
             test-tamanho-lista
             test-todos
             test-algum
             test-partition))
