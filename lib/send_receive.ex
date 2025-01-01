defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule SendReceive do
  def start(_opts \\ []), do: Agent.start(fn -> %{plots: [], index: 0} end)

  def list_registrations(pid), do: Agent.get(pid, fn %{plots: plots} -> plots end)

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn %{plots: plots, index: index} ->
      index = index + 1
      plot = %Plot{plot_id: index, registered_to: register_to}
      {plot, %{plots: [plot | plots], index: index}}
    end)
  end

  def release(pid, plot_id) do
    Agent.cast(pid, fn %{plots: plots} = status ->
      plots = Enum.filter(plots, fn %Plot{plot_id: p} -> p != plot_id end)
      %{status | plots: plots}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn %{plots: plots} ->
      plots
      |> Enum.find({:not_found, "plot is unregistered"}, fn %Plot{plot_id: p} -> p == plot_id end)
    end)
  end
end
