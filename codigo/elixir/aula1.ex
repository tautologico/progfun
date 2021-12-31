defmodule Aula1 do
  def f(x), do: x * 20

  def delta(a, b, c) do
    (b * b) - (4 * a * c)
  end

  def raiz_positiva(a, b, c) do
    (-b + :math.sqrt(delta(a, b, c))) / (2 * a)
  end

  def soma_N(1), do: 1
  def soma_N(n) do
    n + soma_N(n - 1)
  end
end
