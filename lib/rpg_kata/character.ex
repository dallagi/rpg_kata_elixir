defmodule RpgKata.Character do
  defstruct [:id, :health, :level, :alive, :range]
  alias __MODULE__, as: Character
  @type t :: %Character{id: String.t(), health: number(), level: number(), alive: boolean()}

  @spec new() :: t()
  def new, do: new(:melee)

  @spec new(atom()) :: t()
  def new(range) do
    %Character{id: UUID.uuid1(), health: 1000, level: 1, alive: true, range: range}
  end

  @spec dead?(t()) :: boolean()
  def dead?(%Character{alive: alive}), do: !alive

  @spec die(t()) :: t()
  def die(character), do: %Character{character | health: 0, alive: false}

  @spec can_hit?(t(), number()) :: boolean()
  def can_hit?(%Character{range: :melee}, distance_meters), do: distance_meters <= 2
  def can_hit?(%Character{range: :ranged}, distance_meters), do: distance_meters <= 20
end
