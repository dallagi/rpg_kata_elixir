defmodule RpgKata.ActionHeal do
  alias RpgKata.Character

  @spec perform(Character.t(), Character.t(), number()) :: Character.t()
  def perform(target, healer, amount), do: if(allowed?(target, healer), do: do_heal(target, amount), else: target)

  defp allowed?(target, healer) do
    cond do
      Character.dead?(target) -> false
      target != healer -> false
      true -> true
    end
  end

  defp do_heal(character, amount), do: %Character{character | health: character.health + amount}
end
