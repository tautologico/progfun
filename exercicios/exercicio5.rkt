#lang racket

(require rackunit rackunit/text-ui)

;;
;; Exercício 5 - Padrões de recursividade e funções de alta ordem - Parte 1
;; 

;;
;; --- Questão 1 ----------------------------
;;
;; Com frequência precisamos transformar todos os itens de uma lista
;; de uma mesma forma. Escreva a função map tal que (map f lst) retorna
;; uma lista de mesmo tamanho que lst, mas com cada elemento transformado
;; de acordo com f. Bônus: escreva a função map com recursividade de cauda
;; (tail recursion).
;;
(define (map f lst) '())

(define-test-suite test-map
  (test-equal? "mapa sobre a lista vazia"
               (map (lambda (x) x) '())
               '())
  (test-equal? "dobrar todos os números de uma lista"
               (map (lambda (x) (* x 2)) '(3 5 7 11 22))
               '(6 10 14 22 44)))


;;
;; --- Questão 2 ----------------------------
;;
;; Agora vamos usar a função map. Crie uma função tamanho-str-lista que, dada
;; uma lista de strings, retorne uma lista com os tamanhos de cada string
;; da lista original, na mesma ordem. Em Racket já existe a função string-length
;; que calcula o tamanho de uma string.
;;
(define (tamanho-str-lista lista-strings) '())

(define-test-suite test-tamanho-lista
  (test-equal? "Lista vazia"
               (tamanho-str-lista '())
               '())
  (test-equal? "Algumas strings"
               (tamanho-str-lista (list "Lost" "Fringe" "The Sopranos"))
               (list 4 6 12))
  (test-equal? "Com string vazia"
               (tamanho-str-lista (list "Seven Feet Under" "" "Breaking Bad"))
               (list 16 0 12)))

;;
;; --- Questão 3 ----------------------------
;;
;; Crie uma função soma-5-lista que, dada uma lista de números, retorna uma
;; lista com os números da lista original somados a 5.
;;
(define (soma-5-lista lst) '())

(define-test-suite test-soma-5-lista
  (test-equal? "lista vazia" (soma-5-lista '()) '())
  (test-equal? "numeros"     (soma-5-lista (list 37 11 17 0))
                             (list 42 16 22 5)))

;;
;; --- Questão 4 ----------------------------
;;
;; Existem situações em que queremos aplicar um deslocamento a todos os números
;; de uma coleção, por exemplo em aplicações de processamento de sinais ou de
;; análise de dados e machine learning. Crie uma função soma-n-lista que generaliza
;; a função da questão anterior: (soma-n-lista n lst) retorna uma lista de mesmo
;; tamanho que lst mas com n somado a cada número de lst.
(define (soma-n-lista n lst) '())

(define-test-suite test-soma-n-lista
  (test-equal? "lista vazia"   (soma-n-lista 11 '()) '())
  (test-equal? "soma com zero" (soma-n-lista 0 (list 1 2 3 4 5)) (list 1 2 3 4 5))
  (test-equal? "numeros"       (soma-n-lista 5 (list 37 11 17 0))
                               (list 42 16 22 5))
  (test-equal? "soma com -1"   (soma-n-lista -1 (list 11 22 33 44)) (list 10 21 32 43)))

;;
;; --- Questão 5 ----------------------------
;;
;; Imagine que você está implementando um servidor de lista de discussão por email.
;; Esse servidor precisa anexar um prefixo no assunto de cada email enviado para a
;; lista, contendo o nome da lista. Crie a função adiciona-prefixo para este servidor,
;; de forma que (adiciona-prefixo pre lista-assuntos) retorna uma lista com as strings
;; de lista-assuntos, mas com o prefixo (envolto em colchetes) concatenado no início
;; de cada uma. Veja os testes para exemplos.
;;
;; Dica: a função para concatenar strings em Racket se chama string-append. Nesse
;; exercício, as funções format e ~a também podem ser úteis e até mais fáceis
;; de usar que string-append (procure na documentação). 
;;
(define (adiciona-prefixo pre lista-assuntos) '())

(define-test-suite test-adiciona-prefixo
  (test-equal? "Lista vazia" (adiciona-prefixo "teste" '()) '())
  (test-equal? "String vazia" (adiciona-prefixo "ornitologia" (list ""))
                              (list "[ornitologia]"))
  (test-equal? "Strings variadas"
               (adiciona-prefixo "choque"
                                 (list "Só Magia Top!"
                                       "Show!"
                                       "Tá certa a indignação!"))
               (list "[choque] Só Magia Top!"
                     "[choque] Show!"
                     "[choque] Tá certa a indignação!")))

;;
;; --- Questão 6 ----------------------------
;;
;; Outra tarefa que precisamos fazer frequentemente com coleções é acumular
;; uma operação sobre todos os elementos, tendo um valor único como resultado.
;; Por exemplo: soma de todos os elementos, etc. Vimos na aula a função
;; fold_right tal que (fold_right f val lst) aplica a função f aos elementos da
;; lista lst, um de cada vez, começando por val. Escreva a função fold_right.
;;
(define (fold-right f val lst) '())

(define-test-suite test-fold-right
  (test-equal? "fold sobre a lista vazia retorna o valor inicial"
               (fold-right + 0 '())
               0)
  (test-equal? "soma de alguns números"
               (fold-right + 0 (list 1 2 3 4 5))
               15)
  (test-equal? "Operação é agrupada à direita"
               (fold-right - 0 (list 10 8 2))
               4))

;;
;; --- Questão 7 ----------------------------
;;
;; Usando fold-right, defina novamente as funções soma-lista e
;; mult-lista, que somam e multiplicam, respectivamente, todos
;; os números em uma lista.
;;
(define (soma-lista lst) 0)

(define (mult-lista lst) 0)

;;
;; Note que essas funções são completamente desnecessárias em Racket, pois os
;; operadores + e * podem ser usados com qualquer número de argumentos.
;; Por exemplo, tente (+ 1 2 3 4 5) no REPL. 
;;

(define-test-suite test-soma-mult-lista
  (test-equal? "soma da lista vazia"                (soma-lista '())                  0)
  (test-equal? "soma de um número apenas"           (soma-lista '(13))                13)
  (test-equal? "soma de vários números"             (soma-lista (list 5 4 3 2 1))     15)
  (test-equal? "soma de números em ordem diferente" (soma-lista (list 1 2 3 4 5))     15)
  (test-equal? "soma de lista com zero"             (soma-lista (list 1 0 2 0 13 0))  16)
  (test-equal? "produto da lista vazia"            (mult-lista '())                  1)
  (test-equal? "produto de lista com zero"         (mult-lista (list 1 0 2 0 13 0))  0)
  (test-equal? "produto de um número"              (mult-lista '(55))                55)
  (test-equal? "produto de vários números"         (mult-lista (list 1 2 3 4 5))     120)
  (test-equal? "produto de números em outra ordem" (mult-lista (list 2 5 1 4 3))     120))

;;
;; --- Questão 8 ----------------------------
;;
;; Usando fold-right, escreva funções and-lista e or-lista que realizam as operações
;; booleanas AND e OR em uma lista de valores booleanos. Essas funções não precisam
;; implementar comportamento de curto-circuito.
(define (and-lista lst) #f)

(define (or-lista lst) #f)

;;
;; As funções and e or da biblioteca padrão Racket podem ser usadas no lugar de
;; and-lista e or-lista, pois ambas aceitam múltiplos argumentos (e fazem
;; avaliação de curto-circuito).
;;

(define-test-suite test-and-or-lista
  (test-equal? "and com lista vazia" (and-lista '()) #f)
  (test-equal? "and: apenas #t" (and-lista (list #t #t #t))    #t)
  (test-equal? "and: apenas #f" (and-lista (list #f #f #f #f)) #f)
  (test-equal? "and: algum #f"  (and-lista (list #t #t #f))    #f)
  
  (test-equal? "or com lista vazia" (or-lista '()) #t)
  (test-equal? "or: apenas #f" (or-lista (list #f #f #f #f)) #f)
  (test-equal? "or: apenas #t" (or-lista (list #t #t #t))    #t)
  (test-equal? "or: algum #t"  (or-lista (list #f #t #f #f)) #t))
  

;;
;; --- Questão 9 ----------------------------
;;
;; fold-right sempre associa a operação f à direita, e isso pode ser
;; inadequado em muitos casos. Usando o modelo de substituição, podemos
;; ver que a chamada (fold-right f val (list 1 2 3)) terá o valor de
;; (f 1 (f 2 (f 3 val)))
;;
;; Em operadores associativos como adição e multiplicação isso não é problema,
;; mas muitas vezes precisamos associar à esquerda mesmo. Um exemplo é na
;; subtração.
;;
;; Considere uma aplicação para controlar a pontuação de pessoas fazendo uma prova
;; de avaliação de habilidade em que cada um começa com o máximo de pontos, e
;; a cada erro vai sofrendo deduções (similar ao formato de prova prática para
;; carteira de habilitação para dirigir veículos em muitos lugares). O avaliador
;; preenche uma lista com as deduções, e a pontuação inicial é fixa.
;;
;; Suponha que a pontuação inicial seja de 1000 pontos e o avaliador anotou, para
;; uma pessoa, as deduções 10, 20 e 40. O resultado esperado é calculado facilmente:
;; primeiro subtrai-se 10 de 1000, resultando em 990; disto, tiramos 20, chegando a
;; 970, e finalmente subtrai-se mais 40, tendo como resultado final 930.
;;
;; Se tentarmos calcular isso usando (fold-right - 1000 (list 10 20 40)), o resultado
;; será dado por (- 10 (- 20 (- 40 1000))), com resultado -970, claramente errado. 
;;
;; Nesse caso é necessário calcular (- (- (- 1000 10) 20) 40). Em termos mais gerais,
;; dado a operação f e o valor inicial val precisamos calcular, para a lista (1 2 3)
;; (f (f (f val 1) 2) 3).
;;
;; Escreva a função fold-left que faz exatamente isso.
;;
(define (fold-left f val lst) '())

(define-test-suite test-fold-left
  (test-equal? "lista vazia" (fold-left + 0 '()) 0)
  (test-equal? "soma é associativa"
               (fold-left + 0 (list 1 2 3 4 5))
               15)
  (test-equal? "subtração deve associar à esquerda"
               (fold-left - 10 (list 6 2 2))
               0))

;;
;; --- Questão 10 ---------------------------
;;
;; Agora escreva a função pontuacao-final que, dada a pontuação inicial ini e uma
;; lista de deduções lstded, retorna a pontuação final da prova.
;;
(define (pontuacao-final ini lstded) 0)

(define-test-suite test-pontuacao-final
  (test-equal? "lista vazia"    (pontuacao-final 1000 '())              1000)
  (test-equal? "alguns valores" (pontuacao-final 1000 (list 10 20 40))  930))


;;
;; --- Questão 11 ---------------------------
;;
;; Suponha agora que só existe fold-right e, por algum motivo, não é possível
;; escrever fold-left. Defina pontuacao-final-fr, com mesma funcionalidade da
;; funcao pontuacao-final da questão passada, usando apenas fold-right.
(define (pontuacao-final-fr ini lstded) 0)

(define-test-suite test-pontuacao-final-fr
  (test-equal? "lista vazia"    (pontuacao-final-fr 1000 '())              1000)
  (test-equal? "alguns valores" (pontuacao-final-fr 1000 (list 10 20 40))  930))


;;
;; --- Questão 12 ---------------------------
;;
;; Usando fold-left ou fold-right, crie uma função concat-lista que,
;; dada uma lista de strings, retorna a concatenação de todas. Faz
;; diferença usar fold-left ou fold-right?
;;
(define (concat-lista lista-str) "")

(define-test-suite test-concat-lista
  (test-equal? "lista vazia" (concat-lista '()) "")
  (test-equal? "strings" (concat-lista (list "wo3" "shi4" "lao3" "shi1"))
                         "wo3shi4lao3shi1")
  (test-equal? "algumas vazias" (concat-lista (list "pera" "" "banana" "")) "perabanana"))


;;
;; --- Questão 13 ---------------------------
;;
;; Muitas vezes precisamos concatenar strings incluindo um separador no meio,
;; por exemplo para transformar uma lista de strings em uma string de itens
;; separados por vírgula. Crie uma função concat-lista-sep tal que
;; (concat-lista-sep lista-str sep) é uma string com todas as strings
;; da lista concatenadas e separadas por sep. Ver testes para exemplos.
;;
(define (concat-lista-sep lista-str sep) "")

(define-test-suite test-concat-lista-sep
  (test-equal? "lista vazia" (concat-lista-sep '() ", ") "")
  (test-equal? "separador não deve ser usado com apenas um item"
               (concat-lista-sep (list "bacon") ", ")
               "bacon")
  (test-equal? "várias strings"
               (concat-lista-sep (list "bacon" "hamburguer" "cebola") ", ")
               "bacon, hamburguer, cebola"))


;; --- Executa todos os testes ---------
(run-tests
 (test-suite "todos os testes"
             test-map
             test-fold-right
             test-tamanho-lista
             test-soma-5-lista
             test-soma-n-lista
             test-adiciona-prefixo
             test-fold-right
             test-soma-mult-lista
             test-and-or-lista
             test-fold-left
             test-pontuacao-final
             test-pontuacao-final-fr
             test-concat-lista
             test-concat-lista-sep))
