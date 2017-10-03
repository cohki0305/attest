defmodule AttestTest do
  use ExUnit.Case
  doctest Attest

  test "greets the world" do
    assert Attest.hello() == :world
  end
end
