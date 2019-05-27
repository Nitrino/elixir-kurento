defmodule KurentoTest do
  use ExUnit.Case
  doctest Kurento

  test "greets the world" do
    assert Kurento.hello() == :world
  end
end
