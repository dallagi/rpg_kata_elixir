defmodule RpgKata.Character do
  defstruct [:id, :health, :level, :alive]
  alias __MODULE__, as: Character
  @type t :: %Character{id: String.t(), health: number(), level: number(), alive: boolean()}

  @spec new() :: t()
  def new do
    %Character{id: UUID.uuid1, health: 1000, level: 1, alive: true}
  end

  @spec damage(t(), t(), number()) :: t()
  def damage(%Character{alive: false} = target, _, _), do: target
  def damage(target, offender, _) when target == offender, do: target
  def damage(target, offender, amount), do: inflict_damage(target, amount_of_damage(amount, target, offender))

  @spec heal(t(), t(), number()) :: t()
  def heal(%Character{alive: false} = target, _, _), do: target
  def heal(target, healer, _) when target != healer, do: target
  def heal(%Character{health: health} = target, _, amount), do: %Character{target | health: health + amount}

  defp die(character), do: %Character{character | health: 0, alive: false}

  defp inflict_damage(%Character{health: health} = target, amount) when health < amount, do: die(target)
  defp inflict_damage(character, amount), do: %Character {character | health: character.health - amount}

  defp amount_of_damage(amount, %Character{level: target_level}, %Character{level: attacker_level}) do
    cond do
      attacker_level >= target_level + 5  -> round(amount * 1.5)
      attacker_level <= target_level - 5 -> round(amount * 0.5)
      true -> amount
    end
  end
end
