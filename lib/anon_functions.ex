defmodule AnonFunctions do
  def get_equipment_list(), do: [:space_helmet, :space_suite, :snacks, :grappling_hook, :probe]

  def get_first_item(list) do
    first = fn [head | _rest] -> head end
    first.(list)
  end

  def get_item_details(item) do
    case item do
      :space_helmet -> {3, :kg, 1}
      :space_suite -> {16, :kg, 1}
      :snacks -> {1, :kg, 16}
      :grappling_hook -> {4, :kg, 1}
      :probe -> {2, :lb, 1}
      _ -> :unknown_item
    end
  end

  def get_weight_lbs(list) do
    get_lbs = fn item ->
      {weight, type, _qty} = get_item_details(item)

      case type do
        :kg -> Float.round(weight * 2.2, 1)
        _ -> Float.round(weight * 1.0, 1)
      end
    end

    Enum.map(list, get_lbs)
  end

  def atom_to_string(list) do
    convert = fn x ->
      to_string(x)
      |> String.upcase()
      |> String.replace("_", " ")
    end

    Enum.map(list, convert)
  end

  def secret_subtract(secret), do: fn value -> value - secret end
end
