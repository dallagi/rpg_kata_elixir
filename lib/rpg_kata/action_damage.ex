defprotocol ActionDamage do
  @spec perform(t(), RpgKata.Character.t(), amount: number(), distance_meters: number()) :: t()
  def perform(target, offender, options)
end

defimpl ActionDamage, for: RpgKata.Character do
  alias RpgKata.Character
  alias RpgKata.CharacterRange

  @spec perform(Character.t(), Character.t(), amount: number(), distance_meters: number()) :: Character.t()
  def perform(target, offender, amount: amount, distance_meters: distance_meters) do
    if allowed?(target, offender, distance_meters) do
      do_damage(target, amount_of_damage(amount, target, offender))
    else
      target
    end
  end

  defp allowed?(target, offender, distance_meters) do
    not Character.dead?(target) &&
      not Character.ally?(target, offender) &&
      CharacterRange.can_hit?(offender.range, distance_meters)
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

defimpl ActionDamage, for: RpgKata.Thing do
  alias RpgKata.Thing
  alias RpgKata.Character
  alias RpgKata.CharacterRange

  @spec perform(Thing.t(), Character.t(), amount: number(), distance_meters: number()) :: Thing.t()
  def perform(target, offender, amount: amount, distance_meters: distance_meters) do
    if allowed?(target, offender, distance_meters) do
      do_damage(target, amount)
    else
      target
    end
  end

  def allowed?(%Thing{destroyed: true}, _offender, _distance_meters), do: false
  def allowed?(_target, offender, distance_meters), do: CharacterRange.can_hit?(offender.range, distance_meters)

  defp do_damage(%Thing{health: health} = target, amount) when health < amount, do: Thing.destroy(target)
  defp do_damage(thing, amount), do: %Thing{thing | health: thing.health - amount}
end
