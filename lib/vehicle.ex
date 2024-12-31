defmodule Vehicle do
  @enforce_keys [:nickname]
  defstruct [
    :nickname,
    battery_percentage: 100,
    distance_driven_in_meters: 0
  ]

  def new(nickname \\ "none"), do: %Vehicle{nickname: nickname}

  def display_distance(%Vehicle{distance_driven_in_meters: distance}), do: "#{distance} meters"

  def display_battery(%Vehicle{battery_percentage: battery}), do: "Battery at #{battery}%"

  def drive(%Vehicle{battery_percentage: 0} = remote_car), do: remote_car

  def drive(%Vehicle{battery_percentage: b, distance_driven_in_meters: d} = remote_car) do
    %{remote_car | battery_percentage: b + 1, distance_driven_in_meters: d + 20}
  end
end
