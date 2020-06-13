defmodule RpgKata.CharacterTest do
  use ExUnit.Case
  alias RpgKata.Character

  test "new/0 creates a character with default attributes" do
    assert %Character{health: 1000, level: 1, alive: true, range: :melee} = Character.new()
  end

  test "new/1 creates a character with the specified range" do
    assert %Character{health: 1000, level: 1, alive: true, range: :ranged} = Character.new(:ranged)
  end

  describe "damage/3" do
    test "does nothing on dead character" do
      dead_character = Character.new() |> Character.damage(Character.new(), 1100)
      assert dead_character = Character.damage(dead_character, Character.new(), 100)
    end

    test "kills character when damage exceeds current health" do
      damaged_character =
        Character.new()
        |> Character.damage(Character.new(), 1100)

      assert false == damaged_character.alive
    end

    test "health goes to zero when character dies" do
      damaged_character =
        Character.new()
        |> Character.damage(Character.new(), 1100)

      assert 0 == damaged_character.health
    end

    test "reduces health by amount" do
      assert 900 == Character.damage(Character.new(), Character.new(), 100).health
    end

    test "cannot be dealt to self" do
      character = Character.new()
      offender = character
      assert 1000 == Character.damage(character, offender, 100).health
    end

    test "damage is reduced by 50% if target is 5+ levels above the attacker" do
      attacker = Character.new()
      target = %Character{Character.new() | level: 6}

      assert 900 == Character.damage(target, attacker, 200).health
    end

    test "damage is increased by 50% if attacker is 5+ levels above the target" do
      attacker = %Character{Character.new() | level: 6}
      target = Character.new()

      assert 700 == Character.damage(target, attacker, 200).health
    end
  end

  describe "heal/3" do
    test "has no effect on dead characters" do
      dead_character = Character.damage(Character.new(), Character.new(), 1100)
      assert dead_character == Character.heal(dead_character, dead_character, 1000)
    end

    test "cannot be done to others" do
      character = Character.new()
      assert character == Character.heal(character, Character.new(), 100)
    end

    test "restores health" do
      character = Character.new()
      assert 1100 == Character.heal(character, character, 100).health
    end
  end
end
