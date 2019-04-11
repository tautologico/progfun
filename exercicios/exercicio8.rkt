#lang racket

(require rackunit rackunit/text-ui)

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


;; --- Questão 2 - Loops com for --------------------------------

;; Como vimos na questão anterior, é possível escrever "loops" iterativos
;; usando funções recursivas, mas muitas vezes é mais simples pensar em
;; processos iterativos associados a estruturas de controle específicas
;; para loops (como for e while), principalmente quando efeitos colaterais
;; são uma parte importante do loop.

;; Em Racket existe a forma especial for para definir loops; for é bastante
;; versátil em Racket, mas o básico é que a expressão

;; (for ([i (in-range 3)])
;;   e)

;; Vai executar a expressão e três vezes, e em cada iteração a variável i
;; (se usada em e) terá valor 0, 1 e 2, nesta ordem. A expressão for não tem
;; valor (mais precisamente, tem valor void), por isso costuma ser usada em
;; código imperativo. 

;; Escreva a função msg-n-for que faz o mesmo que msg-n do exercício anterior,
;; mas usando um loop for ao invés de recursividade.

(define (msg-n-for str n)
  (void))


;; --- Questão 3 - Vector (arrays) ------------------------------

;; Arrays em Racket são chamados de vector, e são uma estrutura de dados
;; naturalmente associada a programas imperativos. Um vector pode ser criado
;; escrevendo um literal vetor, na forma da lista de elementos iniciada por um
;; caractere #, por exemplo:
(define vetor1 #(1 2 3))

;; Outra opção é usar a função vector, que cria um vetor com todos os seus
;; argumentos (similar à função list):
(define vetor2 (vector 11 22 33))

;; Se o vetor precisar ser criado sem atribuir seus elementos inicialmente,
;; podemos usar a função make-vector (vide documentação).

;; A função vector-ref acessa um elemento de um vetor, e vector-set! altera
;; um elemento. Por exemplo, a função a seguir imprime todos os elementos de
;; um vector:
(define (print-vector v)
  (for ([i (in-range (vector-length v))])
    (displayln (vector-ref v i))))

;; E a função a seguir altera todos os elementos de
;; um vetor para o número zero:
(define (zero-vector v)
  (for ([i (in-range (vector-length v))])
    (vector-set! v i 0)))

;; Às vezes é necessário transformar um vetor, passando cada elemento para uma
;; função de transformação, como fizemos com map, mas alterando o valor dos
;; elementos do próprio vector, ao invés de retornar uma coleção nova com
;; os valores transformados. Escreva a função vector-map! tal que
;; (vector-map! f v) altera os valores do vetor v segundo a função f.
;; A função não deve retornar um novo array com os elementos transformados,
;; mas sim atribuir ao próprio vetor v os elementos transformados.
(define (vector-map! f v)
  (void))

;; O teste de vector-map! deve criar um novo vector com valores conhecidos
;; (let é uma forma especial para criar variáveis temporárias), chamar a
;; função e depois verificar se o vetor original foi alterado
(define-test-suite test-vector-map!
  (test-equal? "alteração de um vector"
               (let ([v (vector 10 2 3)])
                 (vector-map! (lambda (x) (* x x)) v)
                 v)
               (vector 100 4 9)))


;; --- Questão 4 - Atribuições ----------------------------------

;; Como vimos no interpretador meta-circular, a maneira de alterar
;; o valor de variáveis é usando a forma set!. A expressão
;; (set! var val)
;; muda o valor da variável var para val. Com atribuição e loops for,
;; podemos escrever algoritmos imperativos no mesmo estilo que faríamos
;; em uma linguagem imperativa estruturada como a linguagem C.
;;
;; Complete a função abaixo para calcular a soma dos números de um vetor
;; de números. Em cada iteração do loop for podemos acessar um elemento
;; do vetor, e alterar o valor da variável soma para ir acumulando a
;; soma dos elementos. Ou seja, essa função deve ser similar a
;; seguinte função em C:
;;
;; int soma_vetor(int[] v, int n) {
;; {
;;   int soma = 0;
;;   for (int i = 0; i < n; ++i)
;;     soma = soma + v[i];
;;   return soma;
;; }
;;
(define (soma-vetor v)
  (define soma 0)
  (for ([i (in-range (vector-length v))])
    (void))      ;; alterar
  soma)

(define-test-suite test-soma-vetor
  (test-equal? "alguns números" (soma-vetor (vector 1 2 3 4)) 10)
  (test-equal? "vetor vazio" (soma-vetor (vector)) 0))

;; O nome da função soma-vetor não termina com ! porque, embora ela
;; use um efeito imperativo (atribuição), esse efeito fica limitado
;; ao contexto da própria função, não alterando o estado global.
;; Portanto, para o código que chama a função, ela não possui
;; efeitos colaterais observáveis.
;; Esse é um padrão que ocorre com frequência em linguagens híbridas:
;; funções que usam efeitos imperativos internamente (por motivo
;; de eficiência ou facilidade de implementação), mas aparecem
;; externamente como funções livres de efeitos colaterais.


;; --- Questão 5 - for/fold -------------------------------------

;; Embora seja possível programar em um estilo altamente imperativo,
;; como vimos na questão anterior, essa raramente é a melhor opção
;; em uma linguagem moderna, mesmo que não seja uma linguagem
;; classificada como "funcional". Em Racket existem vários tipos
;; de loop similares ao for tradicional mas que expressam melhor
;; a intenção do código.

;; Um desses loops é o for/fold, que faz basicamente o mesmo que
;; a função fold que vimos antes, mas pode ser aplicada a qualquer
;; coleção de elementos. O for/fold tem três partes: a declaração
;; do acumulador e seu valor inicial, uma variável que vai varrer
;; os elementos da coleção, e uma expressão cujo resultado vai
;; ser usado como o valor do acumulador na próxima iteração.
;; Por exemplo, uma versão da função soma-vetor, da questão
;; passada, usando for/fold seria:
(define (soma-vetor-fold vec)
  (for/fold ([soma 0])     ;; acumulador é uma variável chamda soma, valor inicial 0
            ([x vec])      ;; x é a variável do loop, em cada iteração x será um elemento de vec
    (+ soma x)))           ;; expressão que atualiza o valor do acumulador para a próxima iteração

;; Ou seja, soma começa como 0 e em cada iteração do loop ela é atualizada para
;; ter valor igual a (+ soma x), onde x é o próximo elemento do vetor. for/fold
;; retorna o valor da redução, por isso não precisamos usar nenhuma atribuição
;; explicitamente.

;; Usando for/fold, escreva funções para calcular:
;; a) o produto dos números em um vetor
;; b) o menor valor entre os números de um vetor
;; c) a concatenação de todas as strings de um vetor de strings
;; d) a maior string em um vetor de strings
;; Escreva testes para essas funções.

;; Existem outros loops for além de for/fold, veja na documentação em
;; https://docs.racket-lang.org/guide/for.html


;; --- Questão 6 - Entrada com read -----------------------------

;; Já vimos a função display que pode representar na saída
;; qualquer valor da linguagem Racket. Para opções de formatação,
;; podemos usar a função format (que gera strings) ou a função
;; printf (que escreve na saída diretamente).

;; Para leitura de dados, uma função bastante versátil é
;; a função read. Ela é usada para ler e fazer o parse da
;; própria linguagem Racket, então qualquer forma da linguagem
;; pode ser lida com facilidade. Por exemplo, ao digitar
;; (define v (read))
;; no REPL, vai abrir uma caixa para digitar um valor, que
;; será atribuído a v. Esse valor pode ser qualquer valor
;; reconhecido pela linguagem Racket, seja um valor
;; simples como número, booleano, etc, ou uma coleção
;; como string, lista, vetor, etc. É possível até mesmo
;; alterar como read funciona, possibilitando a leitura de
;; valores não reconhecidos pela linguagem Racket, mas esse
;; é um tópico avançado. 

;; Nosso objetivo será usar read para ler valores simples (números)
;; de um arquivo.
;; O sistema de I/O em Racket é organizado em torno do conceito de
;; portas (ports). Tudo que pode ser lido ou onde pode-se escrever
;; é uma porta, que pode ser uma string, um arquivo, a rede, o console,
;; etc. Para ler de um arquivo, é preciso abrir uma file port.

;; Uma forma de ler de um arquivo é abrir o arquivo (que cria a porta),
;; ler da porta, e depois fechar a porta:
;;
;; (define arq (open-input-file "arquivo.txt"))
;; (define v1 (read arq))
;; (close-input-port arq)
;;
;; Esse código vai ler o primeiro valor no arquivo arquivo.txt e atribuir
;; à variável v1. read é chamada com um parâmetro que é a porta de onde ler.
;; Se read for chamada em uma porta que não tem mais valores para ser lidos
;; (porque chegou no final do arquivo, para file ports), será retornado um
;; objeto especial eof (end of file). Pode-se usar o predicado eof-object?
;; que testa se um valor é o objeto eof.

;; Outra forma de ler de um arquivo, que não precisa fechar o arquivo, é
;; usando a função call-with-input-file, que espera dois parâmetros: o nome
;; do arquivo e uma função que vai receber a porta de leitura do arquivo como
;; parâmetro. Por exemplo:
;;
;; (call-with-input-port "arquivo.txt"
;;                       (lambda (arq) (read arq)))
;;
;; vai ler e retornar o primeiro valor no arquivo arquivo.txt, similar ao
;; exemplo anterior mas sem atribuir o valor a uma variável.

;; Para este exercício vamos usar o arquivo input1.txt, que deve estar disponível
;; juntamente com este exercicio8.rkt. O arquivo input1.txt tem um número por linha,
;; que pode ser positivo ou negativo.
;; Escreva uma função que calcula e retorna a soma de todos os números no arquivo.
;; O resultado deve ser 510. 


;; Executa os testes
(run-tests
 (test-suite "todos os testes"
             test-vector-map!
             test-soma-vetor))