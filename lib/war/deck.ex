defmodule War.Deck do

  def build() do
    [
      (1..13),
      (1..13),
      (1..13),
      (1..13)
    ]
    |> Enum.reduce([], fn range, acc -> acc ++ Enum.to_list(range) end)
    |> Enum.shuffle()
  end

end
