defmodule RpgKata.CharacterRange do
  alias __MODULE__, as: CharacterRange

  defstruct [:type, :max_distance]
  @type t() :: %CharacterRange{type: atom(), max_distance: number()}

  @spec new(atom(), number()) :: t()
  def new(type, max_distance), do: %CharacterRange{type: type, max_distance: max_distance}

  @spec can_hit?(CharacterRange.t(), number()) :: boolean()
  def can_hit?(%CharacterRange{max_distance: max_distance}, distance_meters), do: distance_meters <= max_distance
end
