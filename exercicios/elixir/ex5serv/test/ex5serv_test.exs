defmodule Ex5servTest do
  use ExUnit.Case
  doctest Ex5serv

  test "greets the world" do
    assert Ex5serv.hello() == :world
  end
end
