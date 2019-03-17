defmodule War do
  def run_set(count) do
    1..count
    |> Enum.reduce([], fn _, acc -> [War.Game.init() | acc] end)
    |> IO.inspect()
    |> Task.async_stream(fn game -> War.Game.play(game) end)
    |> Enum.reduce([], fn {:ok, {:game_over, rounds, winner}}, acc -> [{rounds, winner} | acc] end)
    |> IO.inspect()
  end
end
