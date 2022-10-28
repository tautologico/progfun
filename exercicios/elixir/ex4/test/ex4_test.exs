defmodule Ex4Test do
  use ExUnit.Case
  doctest Ex4

  test "soma de dois numeros" do
    assert Ex4.soma(3, 0) == 3
    assert Ex4.soma(0, 42) == 42
    assert Ex4.soma(0, 0) == 0
    assert Ex4.soma(31, 147) == 178
    assert Ex4.soma(-11, 77) == 66
  end

  test "multiplica dois numeros" do
    assert Ex4.mult(0, 11) == 0
    assert Ex4.mult(99, 0) == 0
    assert Ex4.mult(7, 8) == 56
    assert Ex4.mult(6, 3) == 18
    assert Ex4.mult(-2, 3) == -6
  end

  test "tamanho de lista" do
    assert Ex4.tamanho([]) == 0
    assert Ex4.tamanho([1, 2, 3, 4]) == 4
  end

  test "replica uma string n vezes" do
    assert Ex4.replica("foo", 0) == ""
    assert Ex4.replica("", 8) == ""
    assert Ex4.replica("1234", 3) == "123412341234"
  end

  test "calcula a soma de uma lista de numeros" do
    assert Ex4.soma_lista([]) == 0
    assert Ex4.soma_lista([1]) == 1
    assert Ex4.soma_lista([3, 7, 21, 1]) == 32
    assert Ex4.soma_lista([-2, 0, 2, -11, 0, 11]) == 0
  end

  test "calcula o produto de uma lista de numeros" do
    assert Ex4.mult_lista([]) == 1
    assert Ex4.mult_lista([1]) == 1
    assert Ex4.mult_lista([3, 4, 5]) == 60
    assert Ex4.mult_lista([3, 7, 21, 1]) == 441
    assert Ex4.mult_lista([-2, 0, 2, -11, 0, 11]) == 0
    assert Ex4.mult_lista([-2, 2, -11, 11]) == 484
  end

  test "concatena todas as strings em uma lista" do
    assert Ex4.concat_lista([]) == ""
    assert Ex4.concat_lista(["a", "", "xyz"]) == "axyz"
    assert Ex4.concat_lista(["", ""]) == ""
    assert Ex4.concat_lista(["abc", "def", "xyz"]) == "abcdefxyz"
  end

  test "filtra os elementos de uma lista de acordo com predicado" do
    assert Ex4.filter([], fn x -> x > 0 end) == []
    assert Ex4.filter([1, 2, 3, 4, 5], fn x -> x > 1000 end) == []
    assert Ex4.filter([1, 2, 3, 4, 5], fn x -> x > 0 end) == [1, 2, 3, 4, 5]
    assert Ex4.filter(["x", "foo", "tapioca"], fn s -> String.length(s) > 3 end) ==
      ["tapioca"]
  end
end
