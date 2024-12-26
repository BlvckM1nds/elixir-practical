defmodule ExercismPractice do
  # Please define the 'expected_minutes_in_oven/0' function
  def expected_minutes_in_oven(), do: 40
  # Please define the 'remaining_minutes_in_oven/1' function
  def remaining_minutes_in_oven(running_time), do: expected_minutes_in_oven() - running_time
  # Please define the 'preparation_time_in_minutes/1' function
  def preparation_time_in_minutes(layers), do: layers * 2
  # Please define the 'total_time_in_minutes/2' function
  def total_time_in_minutes(layers, running_time),
    do: preparation_time_in_minutes(layers) + running_time

  # Please define the 'alarm/0' function
  def alarm() do
    Float.floor(50.1)
  end

  # LanguageList
  def new(), do: []

  def add(list, language), do: [language | list]

  def remove(list) do
    [_head | tail] = list
    tail
  end

  def sanitize(username) do
    username
    |> Enum.reduce([], fn char, acc ->
      case char do
        # Convert special German characters
        ?ä -> acc ++ ~c"ae"
        ?ö -> acc ++ ~c"oe"
        ?ü -> acc ++ ~c"ue"
        ?ß -> acc ++ ~c"ss"
        # Keep lowercase letters and underscores
        char when char in ?a..?z or char == ?_ -> acc ++ [char]
        # Discard all other characters
        _ -> acc
      end
    end)
  end

  def print(id, name, department) do
    if id && department do
      "[#{id}] - #{name} - #{String.upcase(department)}"
    else
      if !id do
        "#{name} - #{String.upcase(department)}"
      else
        "#{name} - OWNER"
      end
    end
  end

  def start(), do: spawn(fn -> loop(0) end)

  defp loop(state) do
    receive do
      {:take_a_number, caller} ->
        new_state = state + 1
        send(caller, new_state)
        loop(new_state)

      {:report_state, caller} ->
        send(caller, state)
        loop(state)

      :stop ->
        :ok

      _ ->
        loop(state)
    end
  end

  # WINE CELLAR
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  def filter(cellar, color, opts \\ [])
  def filter([], _color, _opts), do: []

  def filter(cellar, color, opts) do
    year =
      case opts[:year] do
        nil ->
          nil

        year when is_binary(year) ->
          case Integer.parse(year) do
            {int, ""} -> int
            _ -> nil
          end

        year when is_integer(year) ->
          year
      end

    country = opts[:country]

    cellar
    |> Enum.filter(
      &(elem(&1, 0) == color and
          (is_nil(year) or elem(&1, 1) |> elem(1) == year) and
          (is_nil(country) or elem(&1, 1) |> elem(2) == country))
    )
    |> Enum.map(&elem(&1, 1))
  end
end
