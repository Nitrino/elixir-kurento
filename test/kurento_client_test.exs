defmodule KurentoClientTest do
  use ExUnit.Case
  doctest KurentoClient

  test "greets the world" do
    assert KurentoClient.hello() == :world
  end
end
