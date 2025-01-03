defmodule ControlFlow do
  def check_max_load(load) do
    # if load < 55, do: "Safe to fly!", else: "Too heavy to fly!"
    unless load < 55, do: "Too heavy to fly!", else: "Safe to fly!"
  end

  def check_fuel_level(percentage) do
    cond do
      percentage == 100 -> "FULL tank"
      percentage > 74 -> "3/4 tank"
      percentage > 49 -> "1/2 tank"
      percentage > 24 -> "1/4 tank"
      true -> "empty tank"
    end
  end

  def error_case_check(value) do
    case value do
      200 -> :ok
      201 -> :created
      204 -> :nocontent
      n when is_integer(n) and n > 299 -> :error
      _ -> :unknown
    end
  end

  defp convert_lb_to_kg(lb_value), do: lb_value * 2.2

  def equipment_check(equipment_tuple) do
    unless is_integer(elem(equipment_tuple, 0)) do
      :invalid_data_type
    else
      case equipment_tuple do
        {weight, unit_type, quantity} when weight / quantity < 16 and unit_type == :kg ->
          :equipment_cleared

        {weight, unit_type, quantity} when unit_type == :lb ->
          if convert_lb_to_kg(weight) / quantity < 16, do: :equipment_cleared, else: :failed

        _ ->
          :failed
      end
    end
  end
end
