defmodule Ex1Test do
  use ExUnit.Case
  doctest Ex1

  test "multiplica numeros por 5" do
    assert Ex1.mult5(5) == 25
    assert Ex1.mult5(0) == 0
    # como os tipos nao sao especificados, funciona para numeros de ponto-flutuante
    assert Ex1.mult5(10.1) == 50.5
  end

  test "eleva um numero ao quadrado" do
    assert Ex1.quadrado(0) == 0
    assert Ex1.quadrado(1) == 1
    assert Ex1.quadrado(2) == 4
    assert Ex1.quadrado(12) == 144
  end

  test "soma de quadrados" do
    assert Ex1.soma_quadrados(3, 4) == 25
    assert Ex1.soma_quadrados(2, 0) == 4
    assert Ex1.soma_quadrados(0, 7) == 49
    assert Ex1.soma_quadrados(1, 1) == 2
  end

  test "concatena duas strings" do
    assert Ex1.concat("hello, ", "world!") == "hello, world!"
    # cadeia vazia e' o elemento neutro da concatenacao
    assert Ex1.concat("", "world") == "world"
    assert Ex1.concat("hello", "") == "hello"
  end

  test "negacao de valores booleanos" do
    assert Ex1.negacao(true) == false
    assert Ex1.negacao(false) == true

    # dupla negacao, usando a notacao de "pipe"
    assert true |> Ex1.negacao |> Ex1.negacao == true
  end

  test "conjuncao de dois valores booleanos" do
    assert Ex1.e_logico(true, true) == true
    assert Ex1.e_logico(true, false) == false
    assert Ex1.e_logico(false, true) == false
    assert Ex1.e_logico(false, false) == false
  end

  test "multiplica dois inteiros" do
    assert Ex1.mult(5, 0) == 0
    assert Ex1.mult(0, 5) == 0
    assert Ex1.mult(15, 1) == 15
    assert Ex1.mult(1, 15) == 15
    assert Ex1.mult(5, 3) == 15
    assert Ex1.mult(3, 5) == 15
  end

  test "exponenciacao entre dois numeros >= 0" do
    assert Ex1.exp(3, 0) == 1
    assert Ex1.exp(0, 3) == 0
    assert Ex1.exp(3, 3) == 27
    assert Ex1.exp(2, 6) == 64
  end

  test "replica um string" do
    assert Ex1.replica("hello", 0) == ""
    assert Ex1.replica("hello", 1) == "hello"
    assert Ex1.replica("hello", 3) == "hellohellohello"
  end

  test "determina se um numero positivo e' par" do
    assert Ex1.numero_par(5) == false
    assert Ex1.numero_par(0) == true
    assert Ex1.numero_par(55) == false
    assert Ex1.numero_par(246) == true
  end

  test "determina se um numero positivo e' impar" do
    assert Ex1.numero_impar(5) == true
    assert Ex1.numero_impar(0) == false
    assert Ex1.numero_impar(55) == true
    assert Ex1.numero_impar(246) == false
  end

  test "divide dois numeros positivos" do
    assert Ex1.divide(5, 1) == 5
    assert Ex1.divide(5, 2) == 2
    assert Ex1.divide(15, 3) == 5
    assert Ex1.divide(23, 7) == 3
  end

  test "Encontra a menor potencia de 2 maior que um numero" do
    assert Ex1.teto_pot2(1) == 1
    assert Ex1.teto_pot2(2) == 2
    assert Ex1.teto_pot2(9) == 16
    assert Ex1.teto_pot2(214) == 256
  end
end
