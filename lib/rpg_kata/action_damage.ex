defmodule ActionDamage do
  alias RpgKata.Character
  alias RpgKata.CharacterRange

  @spec perform(Character.t(), Character.t(), [amount: number(), distance_meters: number()]) :: Character.t()
  def perform(target, offender, amount: amount, distance_meters: distance_meters) do
    if allowed?(target, offender, distance_meters) do
      do_damage(target, amount_of_damage(amount, target, offender))
    else
      target
    end
  end

  defp allowed?(target, offender, distance_meters) do
      not Character.dead?(target)
      && not Character.ally?(target, offender)
      && CharacterRange.can_hit?(offender.range, distance_meters)
  end

  defp do_damage(%Character{health: health} = target, amount) when health < amount, do: Character.die(target)
  defp do_damage(character, amount), do: %Character{character | health: character.health - amount}

  defp amount_of_damage(amount, %Character{level: target_level}, %Character{level: attacker_level}) do
    cond do
      attacker_level >= target_level + 5 -> round(amount * 1.5)
      attacker_level <= target_level - 5 -> round(amount * 0.5)
      true -> amount
    end
  end
end
