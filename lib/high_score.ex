defmodule HighScore do
  def new(), do: %{}

  @spec add_player(map(), String.t()) :: map()
  def add_player(scores, name, score \\ 0), do: Map.put(scores, name, score)

  @spec remove_player(map(), String.t()) :: map()
  def remove_player(scores, name), do: Map.drop(scores, [name])

  @spec reset_score(map(), String.t()) :: map()
  def reset_score(scores, name), do: Map.put(scores, name, 0)

  @spec update_score(map(), String.t(), number()) :: map()
  def update_score(scores, name, score) do
    current_score = Map.get(scores, name, 0)
    Map.put(scores, name, current_score + score)
  end

  @spec get_players(map()) :: list()
  def get_players(scores), do: Map.keys(scores)
end
