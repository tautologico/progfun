defmodule Ex2Test do
  use ExUnit.Case
  doctest Ex2

  test "obtem o terceiro elemento de uma lista" do
    assert Ex2.terceiro([]) == nil
    assert Ex2.terceiro([1]) == nil
    assert Ex2.terceiro([1, 2]) == nil
    assert Ex2.terceiro([1, 2, 3]) == 3
    assert Ex2.terceiro([1, 2, 3, 4, 5]) == 3
  end

  test "obtem o tamanho de uma lista" do
    assert Ex2.tamanho([]) == 0
    assert Ex2.tamanho([1]) == 1
    assert Ex2.tamanho([11, 22, 33, 44, 55, 66]) == 6
  end

  test "calcula a soma de uma lista de numeros" do
    assert Ex2.soma_lista([]) == 0
    assert Ex2.soma_lista([1]) == 1
    assert Ex2.soma_lista([3, 7, 21, 1]) == 42
    assert Ex2.soma_lista([-2, 0, 2, -11, 0, 11]) == 0
  end

  test "calcula o produto de uma lista de numeros" do
    assert Ex2.mult_lista([]) == 1
    assert Ex2.mult_lista([1]) == 1
    assert Ex2.mult_lista([3, 4, 5]) == 60
    assert Ex2.mult_lista([3, 7, 21, 1]) == 441
    assert Ex2.mult_lista([-2, 0, 2, -11, 0, 11]) == 0
    assert Ex2.mult_lista([-2, 2, -11, 11]) == 484
  end

  test "concatena todas as strings em uma lista" do
    assert Ex2.concat_lista([]) == ""
    assert Ex2.concat_lista(["a", "", "xyz"]) == "axyz"
    assert Ex2.concat_lista(["", ""]) == ""
    assert Ex2.concat_lista(["abc", "def", "xyz"]) == "abcdefxyz"
  end

  test "obtem o maior valor de uma lista de numeros" do
    assert Ex2.max_lista([]) == nil
    assert Ex2.max_lista([0]) == 0
    assert Ex2.max_lista([0, -11, -22]) == 0
    assert Ex2.max_lista([1, 2, 3, 4, 5]) == 5
    assert Ex2.max_lista([11, 22, 99, 33, 44]) == 99
    assert Ex2.max_lista([-3, 22, -99, 42, 0, -21]) == 42
  end

  test "obtem os primeiros n elementos de uma lista" do
    assert Ex2.primeiros_n([], 0) == []
    assert Ex2.primeiros_n([], 6) == []
    assert Ex2.primeiros_n([1, 2, 3, 4], 3) == [1, 2, 3]
    assert Ex2.primeiros_n([1, 2, 3, 4], 8) == [1, 2, 3, 4]
    assert Ex2.primeiros_n([1, 2, 3, 4], 0) == []
    assert Ex2.primeiros_n([1, 2, 3, 4], 1) == [1]
  end

  test "otem os ultimos n elementos de uma lista" do
    assert Ex2.ultimos_n([], 0) == []
    assert Ex2.ultimos_n([], 6) == []
    assert Ex2.ultimos_n([1, 2, 3, 4], 3) == [2, 3, 4]
    assert Ex2.ultimos_n([1, 2, 3, 4], 8) == [1, 2, 3, 4]
    assert Ex2.ultimos_n([1, 2, 3, 4], 0) == []
    assert Ex2.ultimos_n([1, 2, 3, 4], 1) == [4]
  end

  test "multiplica todos os elementos da lista por 2" do
    assert Ex2.dobro_lista([]) == []
    assert Ex2.dobro_lista([0, 11, 21, 42]) == [0, 22, 42, 84]
    assert Ex2.dobro_lista([111]) == [222]
  end

  test "eleva todos os numeros da lista ao quadrado" do
    assert Ex2.quadrado_lista([]) == []
    assert Ex2.quadrado_lista([0, 11, 21, 42]) == [0, 121, 441, 1764]
    assert Ex2.quadrado_lista([111]) == [12321]
  end

  test "filtra os numeros positivos" do
    assert Ex2.positivos_lista([]) == []
    assert Ex2.positivos_lista([0]) == []
    assert Ex2.positivos_lista([-1, -2, -3, -4, -5]) == []
    assert Ex2.positivos_lista([0, 11, -22, 33, -44]) == [11, 33]
  end

  test "filtra os numeros pares" do
    assert Ex2.pares_lista([]) == []
    assert Ex2.pares_lista([11, 33, 55, 77]) == []
    assert Ex2.pares_lista([20, 10, -8, 7, -12, -45]) == [20, 10, -8, -12]
  end

  test "soma duas listas, elemento a elemento" do
    assert Ex2.soma_listas([], [1, 2, 3]) == []
    assert Ex2.soma_listas([1, 2, 3], []) == []
    assert Ex2.soma_listas([0], [1, 2, 3]) == [1]
    assert Ex2.soma_listas([1, 2, 3], [0]) == [1]
    assert Ex2.soma_listas([10, 10, 10], [1, 2, 3]) == [11, 12, 13]
  end

  test "concatena as strings de duas listas, elemento a elemento" do
    assert Ex2.concat_listas([], ["a", "b", "c"]) == []
    assert Ex2.concat_listas(["a", "b", "c"], []) == []
    assert Ex2.concat_listas(["X", "Y"], ["a", "b", "c"]) == ["Xa", "Yb"]
    assert Ex2.concat_listas(["", "$$$", ""], ["a", "b", "c"]) == ["a", "$$$b", "c"]
  end

  test "junta/concatena duas listas" do
    assert Ex2.append([], [1, 2, 3]) == [1, 2, 3]
    assert Ex2.append([1, 2, 3], []) == [1, 2, 3]
    assert Ex2.append([1], [7, 8, 9]) == [1, 7, 8, 9]
    assert Ex2.append([1, 2, 3], [99]) == [1, 2, 3, 99]
  end

  test "obtem os elementos alternados de uma lista" do
    assert Ex2.posicoes_pares([]) == []
    assert Ex2.posicoes_pares([1]) == []
    assert Ex2.posicoes_pares([1, 2]) == [2]
    assert Ex2.posicoes_pares([7, 9, 11, 13, 15]) == [9, 13]
  end
end
