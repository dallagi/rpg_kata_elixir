defmodule RpgKata.ActionHealTest do
  use ExUnit.Case
  alias RpgKata.ActionHeal
  alias RpgKata.Character

  describe "perform/3" do
    test "has no effect on dead characters" do
      dead_character = Character.die(Character.new())
      assert dead_character == ActionHeal.perform(dead_character, dead_character, 1000)
    end

    test "cannot be done to others" do
      character = Character.new()
      assert character == ActionHeal.perform(character, Character.new(), 100)
    end

    test "restores health" do
      character = Character.new()
      assert 1100 == ActionHeal.perform(character, character, 100).health
    end
  end
end
