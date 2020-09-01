defmodule RpgKata.CharacterRangeTest do
  use ExUnit.Case, async: true
  alias RpgKata.CharacterRange

  describe "can_hit?/2" do
    test "is true when distance is within max distance for character" do
      assert true == CharacterRange.can_hit?(CharacterRange.new(:test, 10), 9)
    end

    test "is true when distance is equal as max distance for character" do
      assert true == CharacterRange.can_hit?(CharacterRange.new(:test, 10), 10)
    end

    test "is false when distance is more than max distance for character" do
      assert false == CharacterRange.can_hit?(CharacterRange.new(:test, 10), 11)
    end
  end
end
