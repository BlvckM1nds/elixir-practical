defmodule Guards do
  def number_type(value) when is_integer(value), do: :integer
  def number_type(value) when is_float(value), do: :float
  def number_type(value) when not is_number(value), do: :not_number

  def is_single_digit(value) when is_integer(value) and value < 10, do: true
  def is_single_digit(value) when not is_integer(value) or value >= 10, do: false

  defguardp is_even(value) when is_integer(value) and rem(value, 2) == 0

  def return_even_number(value \\ :empty)
  def return_even_number(value) when is_even(value), do: value
  def return_even_number(value) when not is_even(value), do: :tetot

  def is_under_max_load?(load, max_load \\ 55)
  def is_under_max_load?(load, max_load) when is_number(load) and load <= max_load, do: true
  def is_under_max_load?(load, max_load) when not is_number(load) or load > max_load, do: false
end
