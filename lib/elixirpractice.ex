defmodule Elixirpractice do
  def add(v1, v2), do: v1 + v2

  def add_explain(num_1, num_2) do
    "The total of #{num_1} + #{num_2} is #{num_1 + num_2}"
  end

  def format_name(full_name) do
    formal_name =
      String.split(full_name, " ")
      |> Enum.map(&String.trim/1)
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(&String.capitalize/1)
      |> Enum.join(" ")

    IO.puts(formal_name)
  end

  def first_letter(value), do: String.trim(value) |> String.first()

  def initial(value), do: "#{first_letter(value) |> String.capitalize()}. "

  def initials(full_name),
    do: String.split(full_name) |> Enum.map(&initial/1) |> List.to_string() |> String.trim()

  def hello do
    :world
  end

  def get_equipment_list(), do: [:helm, :suit, :snack, :hook, :probe]

  def get_first_item(list), do: hd(list)
  def remove_first_item(list), do: tl(list)
  def add_to_list_slow(list, value), do: list ++ [value]

  def add_to_list(list, value) do
    list
    |> Enum.reverse()
    |> prepend(value)
    |> Enum.reverse()
  end

  def prepend(list, value), do: [value | list]

  def remove_from_list(list, index) do
    List.delete_at(list, index)
  end

  def loop([]), do: nil

  def loop([head | tail]) do
    IO.puts(head)
    loop(tail)
  end

  def equipment_count([]), do: 0
  def equipment_count([_head | tail]), do: 1 + equipment_count(tail)

  def occurrence_count([], _value), do: 0
  def occurrence_count([_head | _tail], "Snacks"), do: 400
  def occurrence_count([value | tail], value), do: 1 + occurrence_count(tail, value)
  def occurrence_count([_head | tail], value), do: occurrence_count(tail, value)

  def item_details(item) do
    case item do
      :helm ->
        %{
          id: 4,
          weight: 5,
          qty: 2
        }

      :suit ->
        %{
          id: 2,
          weight: 3,
          qty: 3
        }

      _ ->
        raise("Unknown Item ❌❌❌")
    end
  end
end
