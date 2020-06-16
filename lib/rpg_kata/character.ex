defmodule RpgKata.Character do
  defstruct [:id, :health, :level, :alive, :range, :factions]
  alias __MODULE__
  alias RpgKata.CharacterRange

  @type t() :: %Character{
    id: String.t(),
    health: number(),
    level: number(),
    alive: boolean(),
    range: CharacterRange.t(),
    factions: MapSet.t(atom())
  }

  @max_distances %{melee: 2, ranged: 20}

  @spec new() :: t()
  def new, do: new(:melee)

  @spec new(atom()) :: t()
  def new(range) do
    %Character{
      id: UUID.uuid1(),
      health: 1000,
      level: 1,
      alive: true,
      range: CharacterRange.new(range, @max_distances[range]),
      factions: MapSet.new()
    }
  end

  @spec dead?(t()) :: boolean()
  def dead?(%Character{alive: alive}), do: !alive

  @spec die(t()) :: t()
  def die(character), do: %Character{character | health: 0, alive: false}

  @spec join(t(), atom()) :: t()
  def join(character, faction) do
    %Character{character | factions: MapSet.put(character.factions, faction)}
  end

  @spec leave(t(), atom()) :: t()
  def leave(character, faction) do
    %Character{character | factions: MapSet.delete(character.factions, faction)}
  end
end
