defmodule RpgKata.Thing do
  defstruct ~w(id health destroyed)a

  alias __MODULE__

  @type t() :: %Thing{
          id: String.t(),
          health: number(),
          destroyed: boolean()
        }

  @spec new(number()) :: t()
  def new(health) do
    %Thing{
      id: UUID.uuid1(),
      health: health,
      destroyed: false
    }
  end

  @spec destroy(t()) :: t()
  def destroy(thing) do
    %Thing{thing | health: 0, destroyed: true}
  end
end
