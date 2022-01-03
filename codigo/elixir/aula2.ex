defmodule Aula2 do
  # definicao recursiva de soma e multiplicacao
  def soma(n, 0), do: n
  def soma(n, m), do: soma(n+1, m-1)

  def mult(_n, 0), do: 0
  def mult( n, m), do: n + mult(n, m-1)

  # alguns exemplos de listas
  def listas() do
    lista1 = [1 | []]
    lista2 = [2 | lista1]
    lista1 == [1] and lista2 == [2, 1]
  end

  # tamanho de listas
  def tamanho([]), do: 0
  def tamanho([_ | t]), do: 1 + tamanho(t)
end
