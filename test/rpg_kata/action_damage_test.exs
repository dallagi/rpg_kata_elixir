defmodule RpgKata.ActionDamageTest do
  use ExUnit.Case
  alias RpgKata.Character

  describe "damage/3" do
    test "does nothing on dead character" do
      dead_character = Character.die(Character.new())
      assert dead_character = ActionDamage.perform(dead_character, Character.new(), amount: 100, distance_meters: 1)
    end

    test "does nothing when target is out of range" do
      target = Character.new(:melee)

      assert target == ActionDamage.perform(target, Character.new(), amount: 100, distance_meters: 10)
    end

    test "does nothing when offender and target are allies" do
      target = Character.join(Character.new(), :test_faction)
      offender = Character.join(Character.new(), :test_faction)

      assert target == ActionDamage.perform(target, offender, amount: 100, distance_meters: 1)
    end

    test "kills character when damage exceeds current health" do
      damaged_character =
        Character.new()
        |> ActionDamage.perform(Character.new(), amount: 1100, distance_meters: 1)

      assert true == Character.dead?(damaged_character)
    end

    test "reduces health by amount" do
      assert 900 == ActionDamage.perform(Character.new(), Character.new(), amount: 100, distance_meters: 1).health
    end

    test "cannot be dealt to self" do
      character = Character.new()
      offender = character
      assert 1000 == ActionDamage.perform(character, offender, amount: 100, distance_meters: 1).health
    end

    test "damage is reduced by 50% if target is 5+ levels above the attacker" do
      attacker = Character.new()
      target = %Character{Character.new() | level: 6}

      assert 900 == ActionDamage.perform(target, attacker, amount: 200, distance_meters: 1).health
    end

    test "damage is increased by 50% if attacker is 5+ levels above the target" do
      attacker = %Character{Character.new() | level: 6}
      target = Character.new()

      assert 700 == ActionDamage.perform(target, attacker, amount: 200, distance_meters: 1).health
    end
  end
end
