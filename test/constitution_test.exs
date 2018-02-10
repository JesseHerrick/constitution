defmodule ConstitutionTest do
  use ExUnit.Case
  doctest Constitution

  test "greets the world" do
    assert Constitution.hello() == :world
  end
end
