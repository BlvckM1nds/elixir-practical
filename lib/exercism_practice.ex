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
end
