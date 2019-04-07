#lang racket

;;
;; Exercício 8 - Características imperativas em Racket
;;

;;
;; Neste exercício vamos explorar o uso de características imperativas na
;; linguagem Racket. Racket é algumas vezes classificada como uma linguagem
;; híbrida ou que não é "puramente funcional". Embora esse conceito tenha
;; aspectos problemáticos, a intenção é dizer que Racket permite o uso
;; livre das características imperativas, deixando o controle dos
;; efeitos colaterais por conta do programador. Isso é diferente de linguagens
;; como Haskell, onde o sistema de tipos é usado para controlar e demarcar
;; o uso de efeitos colaterais.
;;

;;
;; Vamos abordar principalmente três características imperativas: estruturas
;; de loop, mudança de valores de variáveis por atribuição, e entrada/saída.
;; Uma outra característica imperativa seria a manipulação do fluxo de
;; controle usando continuações e call/cc, mas esse é um aspecto avançado que
;; não veremos aqui.
;;

;;
;; --- Questão 1 - Iteração com função recursiva ----------------
;;

;; Uma função de saída simples em Racket é display, que imprime no
;; console uma representação de qualquer valor, por exemplo
;; (display 2)
;; (display #f)
;; (display "hello!")
;;
;; displayln é igual a display mas adiciona uma nova linha ao final.

;; Uma alternativa a display e displayln é a função printf que, de
;; forma similar à função de mesmo nome na linguagem C, é usada para
;; saída formatada. Por exemplo:
;; (printf "Esta mensagem é a número ~a!" 1)
;; O especificador de formato ~a pode ser usado com a maioria dos
;; valores em Racket.

;; Usando display/displayln ou printf, crie uma função recursiva msg-n
;; tal que (msg-n str n) imprime n copias da mensagem str com o número n
;; no final, por exemplo (msg-n "Mensagem #" 3) deve imprimir:
;; Mensagem #1
;; Mensagem #2
;; Mensagem #3

;; Duas observações:
;; 1) apesar de ser uma função imperativa, ainda é recursão em cima de um número
;; natural, portanto a mesma forma pode ser seguida
;; 2) aqui pela primeira vez será necessário usar o sequenciamento, ou seja, avaliar
;; uma expressão e em seguida outra, similar à forma begin que vimos no interpretador
;; meta-circular. Existe a forma begin em Racket, mas em muitos contextos sintáticos a
;; linguagem Racket aceita sequências de expressões normalmente, sem begin. Por exemplo,
;; em uma definição de função,

;; (define (f x)
;;  e1
;;  e2)

;; vai avaliar (executar) e1, ignorar o valor da expressão, e em seguida avaliar
;; e retornar o valor de e2.

(define (msg-n str n) (void))

;; Sem testes porque, mais uma vez, o uso de efeitos imperativos dificulta
;; a criação de testes. É possível testar esse tipo de função, mas não com
;; uma biblioteca simples de testes unitários.


;; Loops imperativos com for - displayln etc

;; Observações sobre as dificuldades de testar comportamento imperativo

;; Versões "menos imperativas" do for: for/list etc

;; Lidando com arrays

;; Entrada e saída

;; Hash tables?
