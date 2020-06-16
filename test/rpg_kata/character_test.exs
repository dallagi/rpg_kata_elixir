defmodule RpgKata.CharacterTest do
  use ExUnit.Case
  alias RpgKata.Character
  alias RpgKata.CharacterRange

  test "new/0 creates a character with default attributes" do
    assert %Character{health: 1000, level: 1, alive: true, range: %CharacterRange{type: :melee}} = Character.new()
  end

  test "new/1 creates a character with the specified range" do
    assert %Character{health: 1000, level: 1, alive: true, range: %CharacterRange{type: :ranged}} = Character.new(:ranged)
  end

  describe "dead?/0" do
    test "is false when character is alive" do
      assert false == Character.dead?(Character.new())
    end

    test "is true when character is not alive" do
      dead_character = Character.die(Character.new())
      assert true == Character.dead?(dead_character)
    end
  end

  describe "die/1" do
    test "does nothing on dead characters" do
      dead_character = Character.die(Character.new())
      assert dead_character == Character.die(dead_character)
    end

    test "sets character as dead" do
      dead_character = Character.die(Character.new())
      assert true == Character.dead?(dead_character)
    end

    test "sets health to zero" do
      dead_character = Character.die(Character.new())
      assert 0 == dead_character.health
    end
  end
end
