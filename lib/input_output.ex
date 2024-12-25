defmodule InputOutput do
  def welcome() do
    IO.puts("Welcome! Let's fill out your character sheet together.")
    :ok
  end

  def ask_name(), do: IO.gets("What is your character's name?\n") |> String.trim()

  def ask_class(), do: IO.gets("What is your character's class?\n") |> String.trim()

  def ask_level() do
    user_input =
      IO.gets("What is your character's level?\n")
      |> String.trim()

    case Integer.parse(user_input) do
      {level, _} ->
        level

      :error ->
        IO.puts("Invalid input. Please enter a valid number.")
        ask_level()
    end
  end

  def run() do
    welcome()

    class = ask_class()
    level = ask_level()
    name = ask_name()

    details = %{class: class, level: level, name: name}
    IO.puts("Your character: #{inspect(details)}")

    details
  end
end
