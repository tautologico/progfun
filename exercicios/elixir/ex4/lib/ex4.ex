defmodule Ex4 do

  # Recursao de cauda e acumuladores

  # Aqui esta a versao recursiva normal que vimos para a funcao soma

  @doc "Soma os numeros a e b."
  def soma_rec(a, 0), do: a
  def soma_rec(a, b), do: 1 + soma_rec(a, b - 1)

  # Esta funcao nao apresenta recursividade de cauda, pois precisa somar
  # 1 ao resultado da chamada recursiva.

  # Escreva uma funcao similar de soma que tenha recursividade de cauda.
  # Use um parametro acumulador para evitar a soma apos a chamada recursiva.

  # Voce pode criar uma funcao auxiliar privada com o parametro acumulador,
  # ou fazer de outra forma.

  def soma(a, b), do: nil


  # Escreva as funcoes a seguir usando recursividade de cauda. Se precisar,
  # crie funcoes auxiliares que usam um parametro acumulador.

  # Obs: os testes nao vao testar se as funcoes apresentam recursividade
  # de cauda ou nao, apenas se o objetivo da funcao e' cumprido.


  @doc "Multiplica os numeros a e b (b >= 0), usando apenas somas."
  def mult(a, b), do: nil

  @doc "Obtem o tamanho da lista l."
  def tamanho(l), do: nil

  @doc """
  Replica a string s, n vezes.

  Exemplo:
  iex> Ex4.replica("ruby", 4)
  "rubyrubyrubyruby"
  """
  def replica(s, n), do: nil

  @doc """
  Aplica a funcao f em cada elemento da lista l, retornando uma nova lista
  com os elementos transformados.

  Exemplo:
  iex> Ex4.map([1, 2, 3], fn x -> x * 2 end)
  [2, 4, 6]
  """
  def map(l, f), do: nil

  @doc "Calcula a soma dos numeros da lista l."
  def soma_lista(l), do: nil

  @doc "Calcula o produto dos numeros da lista l."
  def mult_lista(l), do: nil

  @doc "Retorna uma string que e' a concatenacao de todas as strings na lista ls."
  def concat_lista(ls), do: nil

  @doc """
  Retorna uma lista com os elementos da lista l para os quais o predicado p
  returna true.

  Exemplo:
  iex> Ex4.filter([10, 2, 15, 9, 42, 27], fn x -> x > 10 end)
  [15, 42, 27]
  """
  def filter(l, p), do: nil

end
