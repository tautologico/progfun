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
end
