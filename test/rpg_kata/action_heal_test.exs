defmodule RpgKata.ActionHealTest do
  use ExUnit.Case, async: true
  alias RpgKata.{ActionHeal, Character}

  describe "perform/3" do
    test "has no effect on dead characters" do
      dead_character = Character.die(Character.new())
      assert dead_character == ActionHeal.perform(dead_character, dead_character, 1000)
    end

    test "restores health" do
      character = Character.new()
      assert 1100 == ActionHeal.perform(character, character, 100).health
    end

    test "can be performed on allies" do
      character = Character.new() |> Character.join(:test_faction)
      ally = Character.new() |> Character.join(:test_faction)
      assert 1100 == ActionHeal.perform(character, ally, 100).health
    end

    test "cannot be performed on enemies" do
      character = Character.new()
      assert character == ActionHeal.perform(character, Character.new(), 100)
    end
  end
end
