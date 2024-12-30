defmodule MapObjects do
  def extract_from_path(data, path) do
    do_extract_from_path(data, String.split(path, "."))
  end

  defp do_extract_from_path(data, []), do: data
  defp do_extract_from_path(data, [x | xs]), do: do_extract_from_path(data[x], xs)

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end

  defmodule BoutiqueInventory do
    def sort_by_price(inventory) do
      Enum.sort(inventory, fn a, b -> a[:price] <= b[:price] end)
    end

    def with_missing_price(inventory) do
      Enum.filter(inventory, fn x -> is_nil(x[:price]) end)
    end

    def update_names([], _old_word, _new_word), do: []

    def update_names(inventory, old_word, new_word) do
      Enum.map(inventory, fn item ->
        Map.update!(item, :name, fn name ->
          String.replace(name, old_word, new_word)
        end)
      end)
    end

    def increase_quantity(item, count) do
      Map.update!(item, :quantity_by_size, fn x ->
        Map.new(x, fn {size, qty} -> {size, qty + count} end)
      end)
    end

    def total_quantity(item) do
      quantities = item[:quantity_by_size]
      count_quantity(Map.values(quantities))
    end

    defp count_quantity([]), do: 0
    defp count_quantity([head | tail]), do: head + count_quantity(tail)

    def total_quantity_v2(item) do
      item
      |> Map.get(:quantity_by_size)
      |> Map.values()
      |> Enum.sum()
    end
  end
end
