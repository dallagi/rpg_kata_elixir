defmodule RpgKata.CharacterTest do
  use ExUnit.Case, async: true
  alias RpgKata.{Character, CharacterRange}

  describe "new/0" do
    test "creates a character with default attributes" do
      assert %Character{health: 1000, level: 1, alive: true, range: %CharacterRange{type: :melee}} = Character.new()
    end
  end

  describe "new/1" do
    test "creates a character with the specified range" do
      assert %Character{health: 1000, level: 1, alive: true, range: %CharacterRange{type: :ranged}} =
               Character.new(:ranged)
    end

    test "new characters are not in any faction" do
      assert Enum.empty?(Character.new().factions)
    end
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

  describe "join/2" do
    test "can join a faction" do
      character =
        Character.new()
        |> Character.join(:test_faction)

      assert :test_faction in character.factions
    end

    test "can join multiple factions" do
      character =
        Character.new()
        |> Character.join(:test_faction)
        |> Character.join(:another_faction)

      assert MapSet.new([:test_faction, :another_faction]) == character.factions
    end
  end

  describe "leave/2" do
    test "does nothing when character is not in faction" do
      character = Character.new()
      assert character == Character.leave(character, :test_faction)
    end

    test "removes character from faction" do
      character =
        Character.new()
        |> Character.join(:test_faction)
        |> Character.join(:another_faction)
        |> Character.leave(:test_faction)

      assert MapSet.new([:another_faction]) == character.factions
    end
  end

  describe "ally?/2" do
    test "is false when characters have no faction in common" do
      assert false == Character.ally?(Character.new(), Character.new())
    end

    test "is true when characters have a faction in common" do
      character = Character.new() |> Character.join(:test_faction)
      other = Character.new() |> Character.join(:test_faction)

      assert true == Character.ally?(character, other)
    end

    test "is true even if characters have also other factions" do
      character = Character.new() |> Character.join(:test_faction)

      other =
        Character.new()
        |> Character.join(:test_faction)
        |> Character.join(:another_faction)

      assert true == Character.ally?(character, other)
    end

    test "a character is ally of itself" do
      character = Character.new()
      assert true == Character.ally?(character, character)
    end
  end
end
