defmodule RpgKata.CharacterTest do
  use ExUnit.Case
  alias RpgKata.Character

  test "new/0 creates a character with default attributes" do
    assert %Character{health: 1000, level: 1, alive: true, range: :melee} = Character.new()
  end

  test "new/1 creates a character with the specified range" do
    assert %Character{health: 1000, level: 1, alive: true, range: :ranged} = Character.new(:ranged)
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

  describe "can_hit?/2" do
    test "melee characters can hit enemies within 2 meters" do
      assert true == Character.can_hit?(Character.new(:melee), 2)
    end

    test "melee characters cannot hit enemies from more than 2 meters of distance" do
      assert false == Character.can_hit?(Character.new(:melee), 3)
    end

    test "ranged characters can hit enemies within 20 meters" do
      assert true == Character.can_hit?(Character.new(:ranged), 20)
    end

    test "ranged characters cannot hit enemies from more than 20 meters of distance" do
      assert false == Character.can_hit?(Character.new(:ranged), 21)
    end
  end
end
