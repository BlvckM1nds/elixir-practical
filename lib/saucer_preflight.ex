defmodule SaucerPreflight do
  defp max_flying_load_lbs, do: 55
  defp convert_kg_to_lbs(kg_value), do: kg_value * 2

  def get_equipment_list, do: [:helm, :suit]

  def get_total_load([]), do: 0

  def get_total_load([head | tail]) do
    (head
     |> Elixirpractice.item_details()
     |> (fn x -> x[:qty] * x[:weight] end).()
     |> convert_kg_to_lbs()) + get_total_load(tail)
  end

  def is_under_max_load?(list) do
    final_weight = get_total_load(list)

    if final_weight < max_flying_load_lbs() do
      true
    else
      false
    end
  end
end
